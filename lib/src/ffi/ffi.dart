import 'dart:ffi';
import 'dart:typed_data';
import 'package:ffi/ffi.dart';
import 'package:iop_sdk/crypto.dart';

extension Optional on int? {
  Pointer<IntPtr> asOptional() {
    Pointer<IntPtr> result = nullptr;
    if (this != null) {
      result = calloc<IntPtr>();
      result.value = this!;
    }
    return result;
  }
}

class NativeSlice extends Struct {
  external Pointer<Void> _ptr;

  @IntPtr()
  external int _length;

  static Pointer<NativeSlice> fromParts(Pointer<Void> ptr, int length) {
    final result = calloc<NativeSlice>();
    result.ref
      .._ptr = ptr
      .._length = length;
    return result;
  }

  int get length => _length;
}

class ByteSlice implements Disposable {
  Pointer<NativeSlice> _slice;

  ByteSlice(this._slice);

  factory ByteSlice.fromBytes(ByteData data) {
    final length = data.lengthInBytes;
    final ptr = calloc<Uint8>(length);
    try {
      final dartSlice = ptr.asTypedList(length);
      dartSlice.setAll(0, data.buffer.asUint8List(data.offsetInBytes, length));
      final nativeSlice = NativeSlice.fromParts(ptr.cast(), length);
      return ByteSlice(nativeSlice);
    } catch (e) {
      calloc.free(ptr);
      rethrow;
    }
  }

  ByteData toBytes() {
    final length = _slice.ref.length;
    final bytes = Uint8List(length);
    final ptr = _slice.ref.ptr.cast<Uint8>();
    bytes.setAll(0, ptr.asTypedList(length));
    return bytes.buffer.asByteData();
  }

  Pointer<NativeSlice> get addressOf => _slice;

  @override
  void dispose() {
    calloc.free(_slice.ref.ptr);
    calloc.free(_slice);
  }
}

extension ArraySlice<T extends NativeType> on NativeSlice {
  Pointer<T> get ptr => _ptr.cast();
}

extension PointerSlice<T extends NativeType> on NativeSlice {
  Pointer<T> at(int index) {
    if (index >= _length) {
      throw IndexError(index, this);
    }
    return (_ptr as Pointer<Pointer<T>>)[index].cast();
  }
}

extension StringPtr on Pointer<Utf8> {
  String intoString() {
    try {
      return toDartString();
    } finally {
      calloc.free(this);
    }
  }
}

class Result extends Struct implements Disposable {
  external Pointer _success;
  external Pointer<Utf8> _error;

  Pointer get _value {
    return _error == nullptr ? _success : throw _error.toDartString();
  }

  String get asString {
    final rawUtf8Ptr = _value.cast<Utf8>();
    final result = rawUtf8Ptr.toDartString();
    return result;
  }

  /// Taking ownership of the pointer from the result
  Pointer<T> asPointer<T extends NativeType>() {
    final result = _value;
    _success = nullptr;
    return result.cast();
  }

  /// Make sure itemFactory releases the native pointer received.
  List<T> asList<T>(T Function(Pointer<Void> raw) itemFactory) {
    final slicePtr = asPointer<NativeSlice>();
    try {
      final slice = slicePtr.ref;
      return List.generate(
        slice.length,
        (i) => itemFactory(slice.at(i) as Pointer<Void>),
        growable: false,
      );
    } finally {
      calloc.free(slicePtr);
    }
  }

  List<String> asStringList() {
    return asList((raw) {
      try {
        final rawUtfPtr = raw.cast<Utf8>();
        return rawUtfPtr.toDartString();
      } finally {
        calloc.free(raw);
      }
    });
  }

  void get asVoid => _value;

  bool asBool() {
    final intPtr = asPointer<Uint8>();
    try {
      final value = intPtr.value;
      return value != 0;
    } finally {
      calloc.free(intPtr);
    }
  }

  int asInt64() {
    final intPtr = asPointer<Int64>();
    try {
      return intPtr.value;
    } finally {
      calloc.free(intPtr);
    }
  }

  int asUint64() {
    final intPtr = asPointer<Uint64>();
    try {
      return intPtr.value;
    } finally {
      calloc.free(intPtr);
    }
  }

  @override
  void dispose() {
    if (_success != nullptr) {
      calloc.free(_success);
    }
    if (_error != nullptr) {
      calloc.free(_error);
    }
  }
}

extension ResultPtr on Pointer<Result> {
  T extract<T>(T Function(Result) fetcher) {
    try {
      return fetcher(ref);
    } finally {
      ref.dispose();
      calloc.free(this);
    }
  }

  T? extractNullable<T>(T? Function(Result) fetcher) {
    try {
      return fetcher(ref);
    } finally {
      ref.dispose();
      calloc.free(this);
    }
  }
}
