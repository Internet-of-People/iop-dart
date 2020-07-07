import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'package:morpheus_sdk/ffi/ffi.dart';

/// Convention
/// - Class naming: ClassName_MethodName
/// - Keep the order of definitions at all the three blocks
class NativeApi {
  static DynamicLibrary lib;

  final DBip39_GeneratePhrase bip39_generate_phrase;
  final DBip39_ValidatePhrase bip39_validate_phrase;
  final DBip39_ListWords bip39_list_words;
  final DSelectiveDigestJson selective_digest_json;
  final DNonce264 nonce264;
  final DHydraTransferTx hydra_transfer_tx;
  final DVault_Create vault_create;
  final DDelete_Vault delete_vault;
  final DVault_Save vault_save;
  final DVault_Load vault_load;
  final DVault_Dirty_Get vault_dirty_get;
  final DMorpheusPlugin_Rewind morpheus_plugin_rewind;
  final DMorpheusPlugin_Get morpheus_plugin_get;
  final DMorpheusPlugin_Public morpheus_plugin_public;
  final DMorpheusPlugin_Private morpheus_plugin_private;
  final DDelete_MorpheusPlugin delete_morpheus_plugin;
  final DMorpheusPublic_Personas_Get morpheus_public_personas_get;
  final DMorpheusPublic_KeyById morpheus_public_key_by_id;
  final DDelete_MorpheusPublic delete_morpheus_public;
  final DDelete_MorpheusPrivate delete_morpheus_private;
  final DMorpheusPublicKind_Len_Get morpheus_public_kind_len_get;
  final DMorpheusPublicKind_IsEmpty_Get morpheus_public_kind_is_empty_get;
  final DMorpheusPublicKind_Key morpheus_public_kind_key;
  final DDelete_MorpheusPublicKind delete_morpheus_public_kind;
  final DHydraPlugin_Rewind hydra_plugin_rewind;
  final DHydraPlugin_Get hydra_plugin_get;
  final DDelete_HydraPlugin delete_hydra_plugin;
  final DHydraPlugin_Private hydra_plugin_private;
  final DHydraPluginPublicGet hydra_plugin_public_get;
  final DDelete_HydraPrivate delete_hydra_private;
  final DHydraPrivate_SignHydraTx hydra_private_sign_hydra_tx;
  final DHydraPrivate_Neuter hydra_private_neuter;
  final DDelete_HydraPublic delete_hydra_public;
  final DHydraPublic_Key hydra_public_key;
  final DHydraPublic_KeyByAddress hydra_public_key_by_address;
  final DDelete_Bip44PublicKey delete_bip44_public_key;
  final DBip44PublicKey_PublicKey_Get bip44_public_key_pk_get;
  final DBip44PublicKey_Address_Get bip44_public_key_address_get;
  final DDelete_SecpPublicKey delete_secp_public_key;
  final DSecpPublicKey_ToString secp_public_key_tostring;
  final DDelete_MPrivateKey delete_mprivate_key;
  final DMPrivateKey_FromSecp mprivate_key_from_secp;
  final DMPrivateKey_PublicKey mprivate_key_public_key;
  final DMPrivateKey_Sign mprivate_key_sign;
  final DDelete_MPublicKey delete_mpublic_key;
  final DMPublicKey_Prefix mpublic_key_prefix;
  final DMPublicKey_FromSecp mpublic_key_from_secp;
  final DMPublicKey_FromBytes mpublic_key_from_bytes;
  final DMPublicKey_FromString mpublic_key_from_string;
  final DMPublicKey_ToBytes mpublic_key_to_bytes;
  final DMPublicKey_ToString mpublic_key_to_string;
  final DMPublicKey_KeyId mpublic_key_key_id;
  final DMPublicKey_ValidateId mpublic_key_validate_id;
  final DMPublicKey_Verify mpublic_key_verify;
  final DDelete_MKeyId delete_mkeyid;
  final DMKeyId_Prefix mkeyid_prefix;
  final DMKeyId_FromSecp mkeyid_from_secp;
  final DMKeyId_FromBytes mkeyid_from_bytes;
  final DMKeyId_FromString mkeyid_from_string;
  final DMKeyId_ToBytes mkeyid_to_bytes;
  final DMKeyId_ToString mkeyid_to_string;
  final DDelete_MSignature delete_msignature;
  final DMSignature_Prefix msignature_prefix;
  final DMSignature_FromSecp msignature_from_secp;
  final DMSignature_FromBytes msignature_from_bytes;
  final DMSignature_FromString msignature_from_string;
  final DMSignature_ToBytes msignature_to_bytes;
  final DMSignature_ToString msignature_to_string;

  static NativeApi load(fileName) {
    lib = DynamicLibrary.open(fileName);
    try {
      return NativeApi._();
    } finally {
      lib = null;
    }
  }

  NativeApi._()
      : bip39_generate_phrase =
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
        selective_digest_json =
            lib.lookupFunction<NSelectiveDigestJson, DSelectiveDigestJson>(
          'selective_digest_json',
        ),
        nonce264 = lib.lookupFunction<NNonce264, DNonce264>(
          'nonce264',
        ),
        hydra_transfer_tx =
            lib.lookupFunction<NHydraTransferTx, DHydraTransferTx>(
          'TxBuilder_hydraTransferTx',
        ),
        vault_create = lib.lookupFunction<NVault_Create, DVault_Create>(
          'Vault_create',
        ),
        delete_vault = lib.lookupFunction<NDelete_Vault, DDelete_Vault>(
          'delete_Vault',
        ),
        vault_save = lib.lookupFunction<NVault_Save, DVault_Save>(
          'Vault_save',
        ),
        vault_load = lib.lookupFunction<NVault_Load, DVault_Load>(
          'Vault_load',
        ),
        vault_dirty_get =
            lib.lookupFunction<NVault_Dirty_Get, DVault_Dirty_Get>(
          'Vault_dirty_get',
        ),
        morpheus_plugin_rewind =
            lib.lookupFunction<NMorpheusPlugin_Rewind, DMorpheusPlugin_Rewind>(
          'MorpheusPlugin_rewind',
        ),
        morpheus_plugin_get =
            lib.lookupFunction<NMorpheusPlugin_Get, DMorpheusPlugin_Get>(
          'MorpheusPlugin_get',
        ),
        morpheus_plugin_public =
            lib.lookupFunction<NMorpheusPlugin_Public, DMorpheusPlugin_Public>(
          'MorpheusPlugin_public',
        ),
        morpheus_plugin_private = lib
            .lookupFunction<NMorpheusPlugin_Private, DMorpheusPlugin_Private>(
          'MorpheusPlugin_private',
        ),
        delete_morpheus_plugin =
            lib.lookupFunction<NDelete_MorpheusPlugin, DDelete_MorpheusPlugin>(
          'delete_MorpheusPlugin',
        ),
        morpheus_public_personas_get = lib.lookupFunction<
            NMorpheusPublic_Personas_Get, DMorpheusPublic_Personas_Get>(
          'MorpheusPublic_personas_get',
        ),
        morpheus_public_key_by_id = lib
            .lookupFunction<NMorpheusPublic_KeyById, DMorpheusPublic_KeyById>(
          'MorpheusPublic_key_by_id',
        ),
        delete_morpheus_public =
            lib.lookupFunction<NDelete_MorpheusPublic, DDelete_MorpheusPublic>(
          'delete_MorpheusPublic',
        ),
        delete_morpheus_private = lib
            .lookupFunction<NDelete_MorpheusPrivate, DDelete_MorpheusPrivate>(
          'delete_MorpheusPrivate',
        ),
        morpheus_public_kind_len_get = lib.lookupFunction<
            NMorpheusPublicKind_Len_Get, DMorpheusPublicKind_Len_Get>(
          'MorpheusPublicKind_len_get',
        ),
        morpheus_public_kind_is_empty_get = lib.lookupFunction<
            NMorpheusPublicKind_IsEmpty_Get, DMorpheusPublicKind_IsEmpty_Get>(
          'MorpheusPublicKind_is_empty_get',
        ),
        morpheus_public_kind_key = lib
            .lookupFunction<NMorpheusPublicKind_Key, DMorpheusPublicKind_Key>(
          'MorpheusPublicKind_key',
        ),
        delete_morpheus_public_kind = lib.lookupFunction<
            NDelete_MorpheusPublicKind, DDelete_MorpheusPublicKind>(
          'delete_MorpheusPublicKind',
        ),
        hydra_plugin_rewind =
            lib.lookupFunction<NHydraPlugin_Rewind, DHydraPlugin_Rewind>(
          'HydraPlugin_rewind',
        ),
        hydra_plugin_get =
            lib.lookupFunction<NHydraPlugin_Get, DHydraPlugin_Get>(
          'HydraPlugin_get',
        ),
        delete_hydra_plugin =
            lib.lookupFunction<NDelete_HydraPlugin, DDelete_HydraPlugin>(
          'delete_HydraPlugin',
        ),
        hydra_plugin_private =
            lib.lookupFunction<NHydraPlugin_Private, DHydraPlugin_Private>(
          'HydraPlugin_private',
        ),
        hydra_plugin_public_get =
            lib.lookupFunction<NHydraPluginPublicGet, DHydraPluginPublicGet>(
          'HydraPlugin_public',
        ),
        delete_hydra_private =
            lib.lookupFunction<NDelete_HydraPrivate, DDelete_HydraPrivate>(
          'delete_HydraPrivate',
        ),
        hydra_private_sign_hydra_tx = lib.lookupFunction<
            NHydraPrivate_SignHydraTx, DHydraPrivate_SignHydraTx>(
          'HydraPrivate_sign_hydra_tx',
        ),
        hydra_private_neuter =
            lib.lookupFunction<NHydraPrivate_Neuter, DHydraPrivate_Neuter>(
          'HydraPrivate_neuter',
        ),
        delete_hydra_public =
            lib.lookupFunction<NDelete_HydraPublic, DDelete_HydraPublic>(
          'delete_HydraPublic',
        ),
        hydra_public_key =
            lib.lookupFunction<NHydraPublic_Key, DHydraPublic_Key>(
          'HydraPublic_key',
        ),
        hydra_public_key_by_address = lib.lookupFunction<
            NHydraPublic_KeyByAddress, DHydraPublic_KeyByAddress>(
          'HydraPublic_key_by_address',
        ),
        delete_bip44_public_key =
            lib.lookupFunction<NDelete_Bip44PublicKey, DDelete_Bip44PublicKey>(
          'delete_Bip44PublicKey',
        ),
        bip44_public_key_pk_get = lib.lookupFunction<
            NBip44PublicKey_PublicKey_Get, DBip44PublicKey_PublicKey_Get>(
          'Bip44PublicKey_publicKey_get',
        ),
        bip44_public_key_address_get = lib.lookupFunction<
            NBip44PublicKey_Address_Get, DBip44PublicKey_Address_Get>(
          'Bip44PublicKey_address_get',
        ),
        delete_secp_public_key =
            lib.lookupFunction<NDelete_SecpPublicKey, DDelete_SecpPublicKey>(
          'delete_SecpPublicKey',
        ),
        secp_public_key_tostring = lib
            .lookupFunction<NSecpPublicKey_ToString, DSecpPublicKey_ToString>(
          'SecpPublicKey_toString',
        ),
        delete_mprivate_key =
            lib.lookupFunction<NDelete_MPrivateKey, DDelete_MPrivateKey>(
          'delete_MPrivateKey',
        ),
        mprivate_key_from_secp =
            lib.lookupFunction<NMPrivateKey_FromSecp, DMPrivateKey_FromSecp>(
          'MPrivateKey_from_secp',
        ),
        mprivate_key_public_key =
            lib.lookupFunction<NMPrivateKey_PublicKey, DMPrivateKey_PublicKey>(
          'MPrivateKey_public_key',
        ),
        mprivate_key_sign =
            lib.lookupFunction<NMPrivateKey_Sign, DMPrivateKey_Sign>(
          'MPrivateKey_sign',
        ),
        delete_mpublic_key =
            lib.lookupFunction<NDelete_MPublicKey, DDelete_MPublicKey>(
          'delete_MPublicKey',
        ),
        mpublic_key_prefix =
            lib.lookupFunction<NMPublicKey_Prefix, DMPublicKey_Prefix>(
          'MPublicKey_prefix',
        ),
        mpublic_key_from_secp =
            lib.lookupFunction<NMPublicKey_FromSecp, DMPublicKey_FromSecp>(
          'MPublicKey_from_secp',
        ),
        mpublic_key_from_bytes =
            lib.lookupFunction<NMPublicKey_FromBytes, DMPublicKey_FromBytes>(
          'MPublicKey_from_bytes',
        ),
        mpublic_key_from_string =
            lib.lookupFunction<NMPublicKey_FromString, DMPublicKey_FromString>(
          'MPublicKey_from_string',
        ),
        mpublic_key_to_bytes =
            lib.lookupFunction<NMPublicKey_ToBytes, DMPublicKey_ToBytes>(
          'MPublicKey_to_bytes',
        ),
        mpublic_key_to_string =
            lib.lookupFunction<NMPublicKey_ToString, DMPublicKey_ToString>(
          'MPublicKey_to_string',
        ),
        mpublic_key_key_id =
            lib.lookupFunction<NMPublicKey_KeyId, DMPublicKey_KeyId>(
          'MPublicKey_key_id',
        ),
        mpublic_key_validate_id =
            lib.lookupFunction<NMPublicKey_ValidateId, DMPublicKey_ValidateId>(
          'MPublicKey_validate_id',
        ),
        mpublic_key_verify =
            lib.lookupFunction<NMPublicKey_Verify, DMPublicKey_Verify>(
          'MPublicKey_verify',
        ),
        delete_mkeyid = lib.lookupFunction<NDelete_MKeyId, DDelete_MKeyId>(
          'delete_MKeyId',
        ),
        mkeyid_prefix = lib.lookupFunction<NMKeyId_Prefix, DMKeyId_Prefix>(
          'MKeyId_prefix',
        ),
        mkeyid_from_secp =
            lib.lookupFunction<NMKeyId_FromSecp, DMKeyId_FromSecp>(
          'MKeyId_from_secp',
        ),
        mkeyid_from_bytes =
            lib.lookupFunction<NMKeyId_FromBytes, DMKeyId_FromBytes>(
          'MKeyId_from_bytes',
        ),
        mkeyid_from_string =
            lib.lookupFunction<NMKeyId_FromString, DMKeyId_FromString>(
          'MKeyId_from_string',
        ),
        mkeyid_to_bytes = lib.lookupFunction<NMKeyId_ToBytes, DMKeyId_ToBytes>(
          'MKeyId_to_bytes',
        ),
        mkeyid_to_string =
            lib.lookupFunction<NMKeyId_ToString, DMKeyId_ToString>(
          'MKeyId_to_string',
        ),
        delete_msignature =
            lib.lookupFunction<NDelete_MSignature, DDelete_MSignature>(
          'delete_MSignature',
        ),
        msignature_prefix =
            lib.lookupFunction<NMSignature_Prefix, DMSignature_Prefix>(
          'MSignature_prefix',
        ),
        msignature_from_secp =
            lib.lookupFunction<NMSignature_FromSecp, DMSignature_FromSecp>(
          'MSignature_from_secp',
        ),
        msignature_from_bytes =
            lib.lookupFunction<NMSignature_FromBytes, DMSignature_FromBytes>(
          'MSignature_from_bytes',
        ),
        msignature_from_string =
            lib.lookupFunction<NMSignature_FromString, DMSignature_FromString>(
          'MSignature_from_string',
        ),
        msignature_to_bytes =
            lib.lookupFunction<NMSignature_ToBytes, DMSignature_ToBytes>(
          'MSignature_to_bytes',
        ),
        msignature_to_string =
            lib.lookupFunction<NMSignature_ToString, DMSignature_ToString>(
          'MSignature_to_string',
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

typedef NVault_Create = Pointer<Result> Function(
  Pointer<Utf8> lang,
  Pointer<Utf8> seed,
  Pointer<Utf8> word25,
  Pointer<Utf8> unlockPassword,
);
typedef DVault_Create = Pointer<Result> Function(
  Pointer<Utf8> lang,
  Pointer<Utf8> seed,
  Pointer<Utf8> word25,
  Pointer<Utf8> unlockPassword,
);

typedef NDelete_Vault = Void Function(
  Pointer<Void> vault,
);
typedef DDelete_Vault = void Function(
  Pointer<Void> vault,
);

typedef NVault_Dirty_Get = Pointer<Result> Function(
  Pointer<Void> vault,
);
typedef DVault_Dirty_Get = Pointer<Result> Function(
  Pointer<Void> vault,
);

typedef NVault_Save = Pointer<Result> Function(
  Pointer<Void> vault,
);
typedef DVault_Save = Pointer<Result> Function(
  Pointer<Void> vault,
);

typedef NVault_Load = Pointer<Result> Function(
  Pointer<Utf8> json,
);
typedef DVault_Load = Pointer<Result> Function(
  Pointer<Utf8> json,
);

typedef NMorpheusPlugin_Rewind = Pointer<Result> Function(
  Pointer<Void> vault,
  Pointer<Utf8> unlockPwd,
);
typedef DMorpheusPlugin_Rewind = Pointer<Result> Function(
  Pointer<Void> vault,
  Pointer<Utf8> unlockPwd,
);

typedef NMorpheusPlugin_Get = Pointer<Result> Function(
  Pointer<Void> vault,
);
typedef DMorpheusPlugin_Get = Pointer<Result> Function(
  Pointer<Void> vault,
);

typedef NMorpheusPlugin_Public = Pointer<Result> Function(
  Pointer<Void> vault,
);
typedef DMorpheusPlugin_Public = Pointer<Result> Function(
  Pointer<Void> vault,
);

typedef NMorpheusPlugin_Private = Pointer<Result> Function(
  Pointer<Void> vault,
  Pointer<Utf8> unlockPassword,
);
typedef DMorpheusPlugin_Private = Pointer<Result> Function(
  Pointer<Void> vault,
  Pointer<Utf8> unlockPassword,
);

typedef NDelete_MorpheusPlugin = Void Function(
  Pointer<Void> morpheus,
);
typedef DDelete_MorpheusPlugin = void Function(
  Pointer<Void> morpheus,
);

typedef NMorpheusPublic_Personas_Get = Pointer<Result> Function(
  Pointer<Void> morpheusPublic,
);
typedef DMorpheusPublic_Personas_Get = Pointer<Result> Function(
  Pointer<Void> morpheusPublic,
);

typedef NMorpheusPublic_KeyById = Pointer<Result> Function(
  Pointer<Void> morpheusPublic,
  Pointer<Void> keyId,
);
typedef DMorpheusPublic_KeyById = Pointer<Result> Function(
  Pointer<Void> morpheusPublic,
  Pointer<Void> keyId,
);

typedef NDelete_MorpheusPublic = Void Function(
  Pointer<Void> public,
);
typedef DDelete_MorpheusPublic = void Function(
  Pointer<Void> public,
);

typedef NDelete_MorpheusPrivate = Void Function(
  Pointer<Void> private,
);
typedef DDelete_MorpheusPrivate = void Function(
  Pointer<Void> private,
);

typedef NMorpheusPublicKind_Len_Get = Pointer<Result> Function(
  Pointer<Void> kind,
);
typedef DMorpheusPublicKind_Len_Get = Pointer<Result> Function(
  Pointer<Void> kind,
);

typedef NMorpheusPublicKind_IsEmpty_Get = Pointer<Result> Function(
  Pointer<Void> kind,
);
typedef DMorpheusPublicKind_IsEmpty_Get = Pointer<Result> Function(
  Pointer<Void> kind,
);

typedef NMorpheusPublicKind_Key = Pointer<Result> Function(
  Pointer<Void> kind,
  Int32 idx,
);
typedef DMorpheusPublicKind_Key = Pointer<Result> Function(
  Pointer<Void> kind,
  int idx,
);

typedef NDelete_MorpheusPublicKind = Void Function(
  Pointer<Void> kind,
);
typedef DDelete_MorpheusPublicKind = void Function(
  Pointer<Void> kind,
);

typedef NHydraPlugin_Rewind = Pointer<Result> Function(
  Pointer<Void> vault,
  Pointer<Utf8> unlockPwd,
  Pointer<Utf8> network,
  Int32 idx,
);
typedef DHydraPlugin_Rewind = Pointer<Result> Function(
  Pointer<Void> vault,
  Pointer<Utf8> unlockPwd,
  Pointer<Utf8> network,
  int idx,
);

typedef NHydraPlugin_Get = Pointer<Result> Function(
  Pointer<Void> vault,
  Pointer<Utf8> network,
  Int32 idx,
);
typedef DHydraPlugin_Get = Pointer<Result> Function(
  Pointer<Void> vault,
  Pointer<Utf8> network,
  int idx,
);

typedef NDelete_HydraPlugin = Void Function(
  Pointer<Void> hydra,
);
typedef DDelete_HydraPlugin = void Function(
  Pointer<Void> hydra,
);

typedef NHydraPlugin_Private = Pointer<Result> Function(
  Pointer<Void> hydra,
  Pointer<Utf8> unlockPassword,
);
typedef DHydraPlugin_Private = Pointer<Result> Function(
  Pointer<Void> hydra,
  Pointer<Utf8> unlockPassword,
);

typedef NDelete_HydraPrivate = Void Function(
  Pointer<Void> private,
);
typedef DDelete_HydraPrivate = void Function(
  Pointer<Void> private,
);

typedef NHydraPrivate_Neuter = Pointer<Result> Function(
  Pointer<Void> private,
);
typedef DHydraPrivate_Neuter = Pointer<Result> Function(
  Pointer<Void> private,
);

typedef NHydraPrivate_SignHydraTx = Pointer<Result> Function(
  Pointer<Void> private,
  Pointer<Utf8> address,
  Pointer<Utf8> txJson,
);
typedef DHydraPrivate_SignHydraTx = Pointer<Result> Function(
  Pointer<Void> private,
  Pointer<Utf8> address,
  Pointer<Utf8> txJson,
);

typedef NHydraPluginPublicGet = Pointer<Result> Function(
  Pointer<Void> hydra,
);
typedef DHydraPluginPublicGet = Pointer<Result> Function(
  Pointer<Void> hydra,
);

typedef NDelete_HydraPublic = Void Function(
  Pointer<Void> public,
);
typedef DDelete_HydraPublic = void Function(
  Pointer<Void> public,
);

typedef NHydraPublic_Key = Pointer<Result> Function(
  Pointer<Void> hydra,
  Int32 idx,
);
typedef DHydraPublic_Key = Pointer<Result> Function(
  Pointer<Void> hydra,
  int idx,
);

typedef NHydraPublic_KeyByAddress = Pointer<Result> Function(
  Pointer<Void> public,
  Pointer<Utf8> address,
);
typedef DHydraPublic_KeyByAddress = Pointer<Result> Function(
  Pointer<Void> public,
  Pointer<Utf8> address,
);

typedef NDelete_Bip44PublicKey = Void Function(
  Pointer<Void> bip44Pk,
);
typedef DDelete_Bip44PublicKey = void Function(
  Pointer<Void> bip44Pk,
);

typedef NBip44PublicKey_PublicKey_Get = Pointer<Result> Function(
  Pointer<Void> bip44Pk,
);
typedef DBip44PublicKey_PublicKey_Get = Pointer<Result> Function(
  Pointer<Void> bip44Pk,
);

typedef NBip44PublicKey_Address_Get = Pointer<Result> Function(
  Pointer<Void> bip44Pk,
);
typedef DBip44PublicKey_Address_Get = Pointer<Result> Function(
  Pointer<Void> bip44Pk,
);

typedef NDelete_SecpPublicKey = Void Function(
  Pointer<Void> secpPk,
);
typedef DDelete_SecpPublicKey = void Function(
  Pointer<Void> secpPk,
);

typedef NSecpPublicKey_ToString = Pointer<Result> Function(
  Pointer<Void> secpPk,
);
typedef DSecpPublicKey_ToString = Pointer<Result> Function(
  Pointer<Void> secpPk,
);

typedef NDelete_MPrivateKey = Void Function(
  Pointer<Void> sk,
);
typedef DDelete_MPrivateKey = void Function(
  Pointer<Void> sk,
);

typedef NMPrivateKey_FromSecp = Pointer<Void> Function(
  Pointer<Void> secpSk,
);
typedef DMPrivateKey_FromSecp = Pointer<Void> Function(
  Pointer<Void> secpSk,
);

typedef NMPrivateKey_PublicKey = Pointer<Void> Function(
  Pointer<Void> sk,
);
typedef DMPrivateKey_PublicKey = Pointer<Void> Function(
  Pointer<Void> sk,
);

typedef NMPrivateKey_Sign = Pointer<Void> Function(
  Pointer<Void> sk,
  Pointer<NativeSlice> data,
);
typedef DMPrivateKey_Sign = Pointer<Void> Function(
  Pointer<Void> sk,
  Pointer<NativeSlice> data,
);

typedef NDelete_MPublicKey = Void Function(
  Pointer<Void> pk,
);
typedef DDelete_MPublicKey = void Function(
  Pointer<Void> pk,
);

typedef NMPublicKey_Prefix = Pointer<Utf8> Function();
typedef DMPublicKey_Prefix = Pointer<Utf8> Function();

typedef NMPublicKey_FromSecp = Pointer<Void> Function(
  Pointer<Void> secpPk,
);
typedef DMPublicKey_FromSecp = Pointer<Void> Function(
  Pointer<Void> secpPk,
);

typedef NMPublicKey_FromBytes = Pointer<Result> Function(
  Pointer<NativeSlice> data,
);
typedef DMPublicKey_FromBytes = Pointer<Result> Function(
  Pointer<NativeSlice> data,
);

typedef NMPublicKey_FromString = Pointer<Result> Function(
  Pointer<Utf8> str,
);
typedef DMPublicKey_FromString = Pointer<Result> Function(
  Pointer<Utf8> str,
);

typedef NMPublicKey_ToBytes = Pointer<NativeSlice> Function(
  Pointer<Void> pk,
);
typedef DMPublicKey_ToBytes = Pointer<NativeSlice> Function(
  Pointer<Void> pk,
);

typedef NMPublicKey_ToString = Pointer<Utf8> Function(
  Pointer<Void> pk,
);
typedef DMPublicKey_ToString = Pointer<Utf8> Function(
  Pointer<Void> pk,
);

typedef NMPublicKey_KeyId = Pointer<Void> Function(
  Pointer<Void> pk,
);
typedef DMPublicKey_KeyId = Pointer<Void> Function(
  Pointer<Void> pk,
);

typedef NMPublicKey_ValidateId = Uint8 Function(
  Pointer<Void> pk,
  Pointer<Void> id,
);
typedef DMPublicKey_ValidateId = int Function(
  Pointer<Void> pk,
  Pointer<Void> id,
);

typedef NMPublicKey_Verify = Uint8 Function(
  Pointer<Void> pk,
  Pointer<NativeSlice> data,
  Pointer<Void> sig,
);
typedef DMPublicKey_Verify = int Function(
  Pointer<Void> pk,
  Pointer<NativeSlice> data,
  Pointer<Void> sig,
);

typedef NDelete_MKeyId = Void Function(
  Pointer<Void> pk,
);
typedef DDelete_MKeyId = void Function(
  Pointer<Void> pk,
);

typedef NMKeyId_Prefix = Pointer<Utf8> Function();
typedef DMKeyId_Prefix = Pointer<Utf8> Function();

typedef NMKeyId_FromSecp = Pointer<Void> Function(
  Pointer<Void> secpId,
);
typedef DMKeyId_FromSecp = Pointer<Void> Function(
  Pointer<Void> secpId,
);

typedef NMKeyId_FromBytes = Pointer<Result> Function(
  Pointer<NativeSlice> data,
);
typedef DMKeyId_FromBytes = Pointer<Result> Function(
  Pointer<NativeSlice> data,
);

typedef NMKeyId_FromString = Pointer<Result> Function(
  Pointer<Utf8> str,
);
typedef DMKeyId_FromString = Pointer<Result> Function(
  Pointer<Utf8> str,
);

typedef NMKeyId_ToBytes = Pointer<NativeSlice> Function(
  Pointer<Void> id,
);
typedef DMKeyId_ToBytes = Pointer<NativeSlice> Function(
  Pointer<Void> id,
);

typedef NMKeyId_ToString = Pointer<Utf8> Function(
  Pointer<Void> id,
);
typedef DMKeyId_ToString = Pointer<Utf8> Function(
  Pointer<Void> id,
);

typedef NDelete_MSignature = Void Function(
  Pointer<Void> sig,
);
typedef DDelete_MSignature = void Function(
  Pointer<Void> sig,
);

typedef NMSignature_Prefix = Pointer<Utf8> Function();
typedef DMSignature_Prefix = Pointer<Utf8> Function();

typedef NMSignature_FromSecp = Pointer<Void> Function(
  Pointer<Void> secpSig,
);
typedef DMSignature_FromSecp = Pointer<Void> Function(
  Pointer<Void> secpSig,
);

typedef NMSignature_FromBytes = Pointer<Result> Function(
  Pointer<NativeSlice> data,
);
typedef DMSignature_FromBytes = Pointer<Result> Function(
  Pointer<NativeSlice> data,
);

typedef NMSignature_FromString = Pointer<Result> Function(
  Pointer<Utf8> str,
);
typedef DMSignature_FromString = Pointer<Result> Function(
  Pointer<Utf8> str,
);

typedef NMSignature_ToBytes = Pointer<NativeSlice> Function(
  Pointer<Void> sig,
);
typedef DMSignature_ToBytes = Pointer<NativeSlice> Function(
  Pointer<Void> sig,
);

typedef NMSignature_ToString = Pointer<Utf8> Function(
  Pointer<Void> sig,
);
typedef DMSignature_ToString = Pointer<Utf8> Function(
  Pointer<Void> sig,
);
