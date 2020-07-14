import 'dart:ffi';
import 'dart:typed_data';
import 'package:ffi/ffi.dart';
import 'package:morpheus_sdk/crypto/disposable.dart';

extension Optional on int {
  Pointer<IntPtr> asOptional() {
    Pointer<IntPtr> result = nullptr;
    if (this != null) {
      result = allocate<IntPtr>();
      result.value = this;
    }
    return result;
  }
}

class NativeSlice extends Struct {
  Pointer<Void> _ptr;

  @IntPtr()
  int _length;

  factory NativeSlice.fromParts(Pointer<Void> ptr, int length) {
    final result = allocate<NativeSlice>();
    return result.ref
      .._ptr = ptr
      .._length = length;
  }

  int get length => _length;
}

class ByteSlice implements Disposable {
  NativeSlice _slice;

  ByteSlice(this._slice);

  factory ByteSlice.fromBytes(ByteData data) {
    final length = data.lengthInBytes;
    final ptr = allocate<Uint8>(count: length);
    try {
      final dartSlice = ptr.asTypedList(length);
      dartSlice.setAll(0, data.buffer.asUint8List(data.offsetInBytes, length));
      final nativeSlice = NativeSlice.fromParts(ptr.cast(), length);
      return ByteSlice(nativeSlice);
    } catch (e) {
      free(ptr);
      rethrow;
    }
  }

  ByteData toBytes() {
    final length = _slice.length;
    final bytes = Uint8List(length);
    final ptr = _slice.ptr.cast<Uint8>();
    bytes.setAll(0, ptr.asTypedList(length));
    return bytes.buffer.asByteData();
  }

  Pointer<NativeSlice> get addressOf => _slice.addressOf;

  @override
  void dispose() {
    free(_slice.ptr);
    free(_slice.addressOf);
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

extension ResultPtr on Pointer<Result> {
  T extract<T>(T Function(Result) fetcher) {
    try {
      return fetcher(ref);
    } finally {
      ref.dispose();
    }
  }
}

extension StringPtr on Pointer<Utf8> {
  String intoString() {
    try {
      return Utf8.fromUtf8(cast());
    } finally {
      free(this);
    }
  }
}

class Result extends Struct {
  Pointer _success;
  Pointer<Utf8> _error;

  Pointer get _value {
    return _error == nullptr ? _success : throw Utf8.fromUtf8(_error);
  }

  String get asString {
    final result = Utf8.fromUtf8(_value.cast());
    return result;
  }

  /// Taking ownership of the pointer from the result
  Pointer<T> asPointer<T extends NativeType>() {
    final result = _value;
    _success = nullptr;
    return result.cast();
  }

  /// Make sure itemFactory releases the native pointer received.
  List<T> asList<T>(T Function(Pointer<NativeType> raw) itemFactory) {
    final slicePtr = asPointer<NativeSlice>();
    try {
      final slice = slicePtr.ref;
      return List.generate(
        slice.length,
        (i) => itemFactory(slice.at(i)),
        growable: false,
      );
    } finally {
      free(slicePtr);
    }
  }

  List<String> asStringList() {
    return asList((raw) {
      try {
        return Utf8.fromUtf8(raw);
      } finally {
        free(raw);
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
      free(intPtr);
    }
  }

  int asUint64() {
    final intPtr = asPointer<Uint64>();
    try {
      return intPtr.value;
    } finally {
      free(intPtr);
    }
  }

  void dispose() {
    if (_success != nullptr) {
      free(_success);
    }
    if (_error != nullptr) {
      free(_error);
    }
    free(addressOf);
  }
}
