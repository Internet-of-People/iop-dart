import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'package:iop_sdk/src/ffi/ffi.dart';
import 'package:iop_sdk/src/ffi/native_bip44_key.dart';
import 'package:iop_sdk/src/ffi/native_bip44_public_key.dart';
import 'package:iop_sdk/src/ffi/native_did.dart';
import 'package:iop_sdk/src/ffi/native_hydra_plugin.dart';
import 'package:iop_sdk/src/ffi/native_hydra_private.dart';
import 'package:iop_sdk/src/ffi/native_hydra_public.dart';
import 'package:iop_sdk/src/ffi/native_jwt_builder.dart';
import 'package:iop_sdk/src/ffi/native_jwt_parser.dart';
import 'package:iop_sdk/src/ffi/native_m_key_id.dart';
import 'package:iop_sdk/src/ffi/native_m_private_key.dart';
import 'package:iop_sdk/src/ffi/native_m_public_key.dart';
import 'package:iop_sdk/src/ffi/native_m_signature.dart';
import 'package:iop_sdk/src/ffi/native_morpheus_plugin.dart';
import 'package:iop_sdk/src/ffi/native_morpheus_private_key.dart';
import 'package:iop_sdk/src/ffi/native_morpheus_private_kind.dart';
import 'package:iop_sdk/src/ffi/native_morpheus_private.dart';
import 'package:iop_sdk/src/ffi/native_morpheus_public_key.dart';
import 'package:iop_sdk/src/ffi/native_morpheus_public_kind.dart';
import 'package:iop_sdk/src/ffi/native_morpheus_public.dart';
import 'package:iop_sdk/src/ffi/native_secp_key_id.dart';
import 'package:iop_sdk/src/ffi/native_secp_private_key.dart';
import 'package:iop_sdk/src/ffi/native_secp_public_key.dart';
import 'package:iop_sdk/src/ffi/native_secp_signature.dart';
import 'package:iop_sdk/src/ffi/native_signed_bytes.dart';
import 'package:iop_sdk/src/ffi/native_signed_json.dart';
import 'package:iop_sdk/src/ffi/native_validation_issue.dart';
import 'package:iop_sdk/src/ffi/native_validation_result.dart';
import 'package:iop_sdk/src/ffi/native_vault.dart';

/// Conventions to minimize merge conflicts
/// - Create a separate module for each Rust struct.
/// - Create a class named Native* in that module.
/// - Define 2 typedefs N* and D* for each Rust method in that module.
/// - Read all functions from the DynamicLibrary in the constructor of the class into
///   final fields.
/// - Keep the fields in this class sorted by classname.
/// - Keep the initializers in the constructor of this class in the same order as the
///   fields are in.
class NativeApi {
  final NativeBip44Key bip44Key;
  final NativeBip44PublicKey bip44PublicKey;
  final NativeDid did;
  final NativeHydraPlugin hydraPlugin;
  final NativeHydraPrivate hydraPrivate;
  final NativeHydraPublic hydraPublic;
  final NativeJwtBuilder jwtBuilder;
  final NativeJwtParser jwtParser;
  final NativeMKeyId keyId;
  final NativeMorpheusPlugin morpheusPlugin;
  final NativeMorpheusPrivate morpheusPrivate;
  final NativeMorpheusPrivateKey morpheusPrivateKey;
  final NativeMorpheusPrivateKind morpheusPrivateKind;
  final NativeMorpheusPublic morpheusPublic;
  final NativeMorpheusPublicKey morpheusPublicKey;
  final NativeMorpheusPublicKind morpheusPublicKind;
  final NativeMPrivateKey privateKey;
  final NativeMPublicKey publicKey;
  final NativeMSignature signature;
  final NativeSecpKeyId secpKeyId;
  final NativeSecpPrivateKey secpPrivateKey;
  final NativeSecpPublicKey secpPublicKey;
  final NativeSecpSignature secpSignature;
  final NativeSignedBytes signedBytes;
  final NativeSignedJson signedJson;
  final NativeValidationIssue validationIssue;
  final NativeValidationResult validationResult;
  final NativeVault vault;

  final DBip39_GeneratePhrase bip39_generate_phrase;
  final DBip39_ValidatePhrase bip39_validate_phrase;
  final DBip39_ListWords bip39_list_words;

  final DSelectiveDigestJson selectiveDigestJson;
  final DDigestJson digestJson;
  final DStringifyJson stringifyJson;
  final DNonce264 nonce264;
  final DHydraTransferTx hydraTransferTx;
  final DMorpheusTx morpheusTx;

  static NativeApi load(fileName) {
    final lib = DynamicLibrary.open(fileName);
    return NativeApi._(lib);
  }

  NativeApi._(DynamicLibrary lib)
      : bip44Key = NativeBip44Key(lib),
        bip44PublicKey = NativeBip44PublicKey(lib),
        did = NativeDid(lib),
        hydraPlugin = NativeHydraPlugin(lib),
        hydraPrivate = NativeHydraPrivate(lib),
        hydraPublic = NativeHydraPublic(lib),
        jwtBuilder = NativeJwtBuilder(lib),
        jwtParser = NativeJwtParser(lib),
        keyId = NativeMKeyId(lib),
        privateKey = NativeMPrivateKey(lib),
        publicKey = NativeMPublicKey(lib),
        signature = NativeMSignature(lib),
        morpheusPlugin = NativeMorpheusPlugin(lib),
        morpheusPrivate = NativeMorpheusPrivate(lib),
        morpheusPrivateKey = NativeMorpheusPrivateKey(lib),
        morpheusPrivateKind = NativeMorpheusPrivateKind(lib),
        morpheusPublic = NativeMorpheusPublic(lib),
        morpheusPublicKey = NativeMorpheusPublicKey(lib),
        morpheusPublicKind = NativeMorpheusPublicKind(lib),
        secpKeyId = NativeSecpKeyId(lib),
        secpPrivateKey = NativeSecpPrivateKey(lib),
        secpPublicKey = NativeSecpPublicKey(lib),
        secpSignature = NativeSecpSignature(lib),
        signedBytes = NativeSignedBytes(lib),
        signedJson = NativeSignedJson(lib),
        validationIssue = NativeValidationIssue(lib),
        validationResult = NativeValidationResult(lib),
        vault = NativeVault(lib),
        bip39_generate_phrase =
            lib.lookupFunction<NBip39_GeneratePhrase, DBip39_GeneratePhrase>(
          'Bip39_generate_phrase',
        ),
        bip39_validate_phrase =
            lib.lookupFunction<NBip39_ValidatePhrase, DBip39_ValidatePhrase>(
          'Bip39_validate_phrase',
        ),
        bip39_list_words =
            lib.lookupFunction<NBip39_ListWords, DBip39_ListWords>(
          'Bip39_list_words',
        ),
        selectiveDigestJson =
            lib.lookupFunction<NSelectiveDigestJson, DSelectiveDigestJson>(
          'selective_digest_json',
        ),
        digestJson = lib.lookupFunction<NDigestJson, DDigestJson>(
          'digest_json',
        ),
        stringifyJson = lib.lookupFunction<NStringifyJson, DStringifyJson>(
          'stringify_json',
        ),
        nonce264 = lib.lookupFunction<NNonce264, DNonce264>(
          'nonce264',
        ),
        hydraTransferTx =
            lib.lookupFunction<NHydraTransferTx, DHydraTransferTx>(
          'HydraTxBuilder_transfer',
        ),
        morpheusTx = lib.lookupFunction<NMorpheusTx, DMorpheusTx>(
          'MorpheusTxBuilder_new',
        );
}

typedef NBip39_GeneratePhrase = Pointer<Result> Function(
  Pointer<Utf8> langCode,
);
typedef DBip39_GeneratePhrase = Pointer<Result> Function(
  Pointer<Utf8> langCode,
);

typedef NBip39_ValidatePhrase = Pointer<Result> Function(
  Pointer<Utf8> langCode,
  Pointer<Utf8> phrase,
);
typedef DBip39_ValidatePhrase = Pointer<Result> Function(
  Pointer<Utf8> langCode,
  Pointer<Utf8> phrase,
);

typedef NBip39_ListWords = Pointer<Result> Function(
  Pointer<Utf8> langCode,
  Pointer<Utf8> prefix,
);
typedef DBip39_ListWords = Pointer<Result> Function(
  Pointer<Utf8> langCode,
  Pointer<Utf8> prefix,
);

typedef NSelectiveDigestJson = Pointer<Result> Function(
  Pointer<Utf8> json,
  Pointer<Utf8> keepPaths,
);
typedef DSelectiveDigestJson = Pointer<Result> Function(
  Pointer<Utf8> json,
  Pointer<Utf8> keepPaths,
);

typedef NDigestJson = Pointer<Result> Function(
  Pointer<Utf8> json,
);
typedef DDigestJson = Pointer<Result> Function(
  Pointer<Utf8> json,
);

typedef NStringifyJson = Pointer<Result> Function(
  Pointer<Utf8> json,
);
typedef DStringifyJson = Pointer<Result> Function(
  Pointer<Utf8> json,
);

typedef NNonce264 = Pointer<Result> Function();
typedef DNonce264 = Pointer<Result> Function();

typedef NHydraTransferTx = Pointer<Result> Function(
  Pointer<Utf8> network,
  Pointer<Utf8> senderPubKey,
  Pointer<Utf8> recipient,
  Int64 amount,
  Int64 nonce,
);
typedef DHydraTransferTx = Pointer<Result> Function(
  Pointer<Utf8> network,
  Pointer<Utf8> senderPubKey,
  Pointer<Utf8> recipient,
  int amount,
  int nonce,
);

typedef NMorpheusTx = Pointer<Result> Function(
  Pointer<Utf8> network,
  Pointer<Utf8> senderPubKey,
  Pointer<Utf8> opAttemptsJson,
  Int64 nonce,
);
typedef DMorpheusTx = Pointer<Result> Function(
  Pointer<Utf8> network,
  Pointer<Utf8> senderPubKey,
  Pointer<Utf8> opAttemptsJson,
  int nonce,
);
