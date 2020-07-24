import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'package:iop_sdk/ffi/ffi.dart';

typedef NDelete_SignedJson = Void Function(
  Pointer<Void> signedJson,
);
typedef DDelete_SignedJson = void Function(
  Pointer<Void> signedJson,
);

typedef NSignedJson_PublicKey_Get = Pointer<Void> Function(
  Pointer<Void> signedJson,
);
typedef DSignedJson_PublicKey_Get = Pointer<Void> Function(
  Pointer<Void> signedJson,
);

typedef NSignedJson_Content_Get = Pointer<Utf8> Function(
  Pointer<Void> signedJson,
);
typedef DSignedJson_Content_Get = Pointer<Utf8> Function(
  Pointer<Void> signedJson,
);

typedef NSignedJson_Signature_Get = Pointer<Void> Function(
  Pointer<Void> signedJson,
);
typedef DSignedJson_Signature_Get = Pointer<Void> Function(
  Pointer<Void> signedJson,
);

typedef NSignedJson_Validate = Uint8 Function(
  Pointer<Void> signedJson,
);
typedef DSignedJson_Validate = int Function(
  Pointer<Void> signedJson,
);

typedef NSignedJson_ValidateWithKeyId = Uint8 Function(
  Pointer<Void> signedJson,
  Pointer<Void> id,
);
typedef DSignedJson_ValidateWithKeyId = int Function(
  Pointer<Void> signedJson,
  Pointer<Void> id,
);

typedef NSignedJson_ValidateWithDidDoc = Pointer<Result> Function(
  Pointer<Void> signedJson,
  Pointer<Utf8> didDoc,
  Pointer<IntPtr> fromHeightInc,
  Pointer<IntPtr> untilHeightExc,
);
typedef DSignedJson_ValidateWithDidDoc = Pointer<Result> Function(
  Pointer<Void> signedJson,
  Pointer<Utf8> didDoc,
  Pointer<IntPtr> fromHeightInc,
  Pointer<IntPtr> untilHeightExc,
);

class NativeSignedJson {
  final DDelete_SignedJson delete;
  final DSignedJson_PublicKey_Get publicKeyGet;
  final DSignedJson_Content_Get contentGet;
  final DSignedJson_Signature_Get signatureGet;
  final DSignedJson_Validate validate;
  final DSignedJson_ValidateWithKeyId validateWithKeyId;
  final DSignedJson_ValidateWithDidDoc validateWithDidDoc;

  NativeSignedJson(DynamicLibrary lib)
      : delete = lib.lookupFunction<NDelete_SignedJson, DDelete_SignedJson>(
          'delete_SignedJson',
        ),
        publicKeyGet = lib.lookupFunction<NSignedJson_PublicKey_Get,
            DSignedJson_PublicKey_Get>(
          'SignedJson_public_key_get',
        ),
        contentGet = lib
            .lookupFunction<NSignedJson_Content_Get, DSignedJson_Content_Get>(
          'SignedJson_content_get',
        ),
        signatureGet = lib.lookupFunction<NSignedJson_Signature_Get,
            DSignedJson_Signature_Get>(
          'SignedJson_signature_get',
        ),
        validate =
            lib.lookupFunction<NSignedJson_Validate, DSignedJson_Validate>(
          'SignedJson_validate',
        ),
        validateWithKeyId = lib.lookupFunction<NSignedJson_ValidateWithKeyId,
            DSignedJson_ValidateWithKeyId>(
          'SignedJson_validate_with_keyid',
        ),
        validateWithDidDoc = lib.lookupFunction<NSignedJson_ValidateWithDidDoc,
            DSignedJson_ValidateWithDidDoc>(
          'SignedJson_validate_with_did_doc',
        );
}
