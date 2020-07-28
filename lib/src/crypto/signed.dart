import 'dart:ffi';
import 'dart:typed_data';
import 'package:ffi/ffi.dart';
import 'package:iop_sdk/crypto.dart';
import 'package:iop_sdk/src/ffi/dart_api.dart';
import 'package:iop_sdk/src/ffi/ffi.dart';

class SignedBytes implements Disposable {
  Pointer<Void> _ffi;
  bool _owned;

  SignedBytes(this._ffi, this._owned);

  PublicKey get publicKey {
    final ffiPk = DartApi.native.signedBytes.publicKeyGet(_ffi);
    return PublicKey(ffiPk, true);
  }

  ByteData get content {
    final nativeSlice = DartApi.native.signedBytes.contentGet(_ffi);
    final slice = ByteSlice(nativeSlice.ref);
    try {
      return slice.toBytes();
    } finally {
      slice.dispose();
    }
  }

  Signature get signature {
    final ffiSig = DartApi.native.signedBytes.signatureGet(_ffi);
    return Signature(ffiSig, true);
  }

  bool validate() {
    return DartApi.native.signedBytes.validate(_ffi) != 0;
  }

  bool validateWithKeyId(KeyId id) {
    return DartApi.native.signedBytes.validateWithKeyId(_ffi, id.ffi) != 0;
  }

  ValidationResult validateWithDidDoc(String didDoc,
      {int fromHeightInc, int untilHeightExc}) {
    final nativeDidDoc = Utf8.toUtf8(didDoc);
    final nativeFrom = fromHeightInc.asOptional();
    final nativeUntil = untilHeightExc.asOptional();
    try {
      final ffiResult = DartApi.native.signedBytes
          .validateWithDidDoc(_ffi, nativeDidDoc, nativeFrom, nativeUntil)
          .extract((resp) => resp.asPointer<Void>());
      return ValidationResult(ffiResult, true);
    } finally {
      if (nativeUntil != nullptr) {
        free(nativeUntil);
      }
      if (nativeFrom != nullptr) {
        free(nativeFrom);
      }
      free(nativeDidDoc);
    }
  }

  @override
  void dispose() {
    if (_owned) {
      DartApi.native.signedBytes.delete(_ffi);
      _ffi = nullptr;
      _owned = false;
    }
  }
}

class SignedJson implements Disposable {
  Pointer<Void> _ffi;
  bool _owned;

  SignedJson(this._ffi, this._owned);

  PublicKey get publicKey {
    final ffiPk = DartApi.native.signedJson.publicKeyGet(_ffi);
    return PublicKey(ffiPk, true);
  }

  String get content {
    return DartApi.native.signedJson.contentGet(_ffi).intoString();
  }

  Signature get signature {
    final ffiSig = DartApi.native.signedJson.signatureGet(_ffi);
    return Signature(ffiSig, true);
  }

  bool validate() {
    return DartApi.native.signedJson.validate(_ffi) != 0;
  }

  bool validateWithKeyId(KeyId id) {
    return DartApi.native.signedJson.validateWithKeyId(_ffi, id.ffi) != 0;
  }

  ValidationResult validateWithDidDoc(String didDoc,
      {int fromHeightInc, int untilHeightExc}) {
    final nativeDidDoc = Utf8.toUtf8(didDoc);
    final nativeFrom = fromHeightInc.asOptional();
    final nativeUntil = untilHeightExc.asOptional();
    try {
      final ffiResult = DartApi.native.signedJson
          .validateWithDidDoc(_ffi, nativeDidDoc, nativeFrom, nativeUntil)
          .extract((resp) => resp.asPointer<Void>());
      return ValidationResult(ffiResult, true);
    } finally {
      if (nativeUntil != nullptr) {
        free(nativeUntil);
      }
      if (nativeFrom != nullptr) {
        free(nativeFrom);
      }
      free(nativeDidDoc);
    }
  }

  @override
  void dispose() {
    if (_owned) {
      DartApi.native.signedJson.delete(_ffi);
      _ffi = nullptr;
      _owned = false;
    }
  }
}
