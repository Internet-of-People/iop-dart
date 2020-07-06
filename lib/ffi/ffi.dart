import 'dart:ffi';
import 'package:ffi/ffi.dart';

typedef NativeFuncCallback = Void Function(Pointer result);
typedef NativeFuncErrback = Void Function(Pointer<Utf8> result);

class NativeSlice extends Struct {
  Pointer<Pointer> _ptr;

  @IntPtr()
  int _length;

  factory NativeSlice.fromParts(Pointer<Pointer> ptr, int length) {
    final result = allocate<NativeSlice>();
    return result.ref
      .._ptr = ptr
      .._length = length;
  }

  int get length => _length;

  Pointer<T> at<T extends NativeType>(int index) {
    if (index >= _length) {
      throw IndexError(index, this);
    }
    return _ptr[index].cast();
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

  List<String> asStringList() {
    final slicePtr = asPointer<NativeSlice>();
    try {
      final slice = slicePtr.ref;
      return List.generate(slice.length, (i) {
        final nativeStr = slice.at<Utf8>(i);
        try {
          return Utf8.fromUtf8(nativeStr);
        } finally {
          free(nativeStr);
        }
      }, growable: false);
    } finally {
      free(slicePtr);
    }
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
