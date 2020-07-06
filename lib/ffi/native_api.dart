import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'ffi.dart';

/// Convention
/// - Class naming: ClassName_MethodName
/// - Keep the order of definitions at all the three blocks
class NativeApi {
  static DynamicLibrary lib;

  final DBip39GeneratePhrase bip39_generate_phrase;
  final DBip39ValidatePhrase bip39_validate_phrase;
  final DBip39ListWords bip39_list_words;
  final DMaskJson mask_json;
  final DGenerateNonce generate_nonce;
  final DHydraTransferTx hydra_transfer_tx;
  final DCreateVault create_vault;
  final DDeleteVault delete_vault;
  final DVaultToJson vault_to_json;
  final DJsonToVault json_to_vault;
  final DVaultIsDirty vault_is_dirty;

  final DMorpheusPluginRewind morpheus_plugin_rewind;
  final DMorpheusPluginGet morpheus_plugin_get;
  final DMorpheusPluginPublic morpheus_plugin_public;
  final DMorpheusPluginPrivate morpheus_plugin_private;
  final DDeleteMorpheusPlugin delete_morpheus_plugin;
  final DMorpheusPublicPersonas morpheus_public_personas;
  final DMorpheusPublicKeyById morpheus_public_key_by_id;
  final DDeleteMorpheusPublic delete_morpheus_public;
  final DDeleteMorpheusPrivate delete_morpheus_private;
  final DMorpheusPublicKindLen morpheus_public_kind_len;
  final DMorpheusPublicKindIsEmpty morpheus_public_kind_is_empty;
  final DMorpheusPublicKindKey morpheus_public_kind_key;
  final DDeleteMorpheusPublicKind delete_morpheus_public_kind;

  final DHydraPluginRewind hydra_plugin_rewind;
  final DHydraPluginGet hydra_plugin_get;
  final DDeleteHydraPlugin delete_hydra_plugin;
  final DHydraPluginPrivateGet hydra_private_get;
  final DDeleteHydraPrivate delete_hydra_private;
  final DHydraPrivateSignTx hydra_private_sign_tx;
  final DHydraPrivateNeuter hydra_private_neuter;
  final DHydraPluginPublicGet hydra_public_get;
  final DDeleteHydraPublic delete_hydra_public;
  final DHydraPublic_Key hydra_public_key;
  final DHydraPublic_KeyByAddress hydra_public_key_by_address;
  final DDeleteBip44PublicKey delete_bip44_public_key;
  final DBip44PublicKey_PublicKeyGet bip44_public_key_pk_get;
  final DBip44PublicKey_AddressGet bip44_public_key_address_get;
  final DDeleteSecpPublicKey delete_secp_public_key;
  final DSecpPublicKey_ToString secp_public_key_tostring;
  final DDeleteMPublicKey delete_mpublic_key;
  final DMPublicKey_FromSecp mpublic_key_fromsecp;
  final DMPublicKey_FromBytes mpublic_key_frombytes;
  final DMPublicKey_FromString mpublic_key_fromstring;
  final DMPublicKey_ToBytes mpublic_key_tobytes;
  final DMPublicKey_ToString mpublic_key_tostring;
  final DMPublicKey_KeyId mpublic_key_keyid;
  final DMPublicKey_ValidateId mpublic_key_validate_id;
  final DMPublicKey_Verify mpublic_key_verify;
  final DDeleteMKeyId delete_mkeyid;
  final DMKeyId_FromString mkeyid_fromstring;
  final DMKeyId_ToString mkeyid_tostring;

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
            lib.lookupFunction<NBip39GeneratePhrase, DBip39GeneratePhrase>(
          'Bip39_generate_phrase',
        ),
        bip39_validate_phrase =
            lib.lookupFunction<NBip39ValidatePhrase, DBip39ValidatePhrase>(
          'Bip39_validate_phrase',
        ),
        bip39_list_words = lib.lookupFunction<NBip39ListWords, DBip39ListWords>(
          'Bip39_list_words',
        ),
        mask_json = lib.lookupFunction<NMaskJson, DMaskJson>(
          'Json_selective_digest',
        ),
        generate_nonce = lib.lookupFunction<NGenerateNonce, DGenerateNonce>(
          'Nonce_generate',
        ),
        hydra_transfer_tx =
            lib.lookupFunction<NHydraTransferTx, DHydraTransferTx>(
          'TxBuilder_hydraTransferTx',
        ),
        create_vault = lib.lookupFunction<NCreateVault, DCreateVault>(
          'Vault_create',
        ),
        delete_vault = lib.lookupFunction<NDeleteVault, DDeleteVault>(
          'delete_Vault',
        ),
        vault_to_json = lib.lookupFunction<NVaultToJson, DVaultToJson>(
          'Vault_save',
        ),
        json_to_vault = lib.lookupFunction<NJsonToVault, DJsonToVault>(
          'Vault_load',
        ),
        vault_is_dirty = lib.lookupFunction<NVaultIsDirty, DVaultIsDirty>(
          'Vault_dirty_get',
        ),
        morpheus_plugin_rewind =
            lib.lookupFunction<NMorpheusPluginRewind, DMorpheusPluginRewind>(
          'MorpheusPlugin_rewind',
        ),
        morpheus_plugin_get =
            lib.lookupFunction<NMorpheusPluginGet, DMorpheusPluginGet>(
          'MorpheusPlugin_get',
        ),
        morpheus_plugin_public =
            lib.lookupFunction<NMorpheusPluginPublic, DMorpheusPluginPublic>(
          'MorpheusPlugin_public',
        ),
        morpheus_plugin_private =
            lib.lookupFunction<NMorpheusPluginPrivate, DMorpheusPluginPrivate>(
          'MorpheusPlugin_private',
        ),
        delete_morpheus_plugin =
            lib.lookupFunction<NDeleteMorpheusPlugin, DDeleteMorpheusPlugin>(
          'delete_MorpheusPlugin',
        ),
        morpheus_public_personas = lib
            .lookupFunction<NMorpheusPublicPersonas, DMorpheusPublicPersonas>(
          'MorpheusPublic_personas',
        ),
        morpheus_public_key_by_id =
            lib.lookupFunction<NMorpheusPublicKeyById, DMorpheusPublicKeyById>(
          'MorpheusPublic_key_by_id',
        ),
        delete_morpheus_public =
            lib.lookupFunction<NDeleteMorpheusPublic, DDeleteMorpheusPublic>(
          'delete_MorpheusPublic',
        ),
        delete_morpheus_private =
            lib.lookupFunction<NDeleteMorpheusPrivate, DDeleteMorpheusPrivate>(
          'delete_MorpheusPrivate',
        ),
        morpheus_public_kind_len =
            lib.lookupFunction<NMorpheusPublicKindLen, DMorpheusPublicKindLen>(
          'MorpheusPublicKind_len_get',
        ),
        morpheus_public_kind_is_empty = lib.lookupFunction<
            NMorpheusPublicKindIsEmpty, DMorpheusPublicKindIsEmpty>(
          'MorpheusPublicKind_is_empty_get',
        ),
        morpheus_public_kind_key =
            lib.lookupFunction<NMorpheusPublicKindKey, DMorpheusPublicKindKey>(
          'MorpheusPublicKind_key',
        ),
        delete_morpheus_public_kind = lib.lookupFunction<
            NDeleteMorpheusPublicKind, DDeleteMorpheusPublicKind>(
          'delete_MorpheusPublicKind',
        ),
        hydra_plugin_rewind =
            lib.lookupFunction<NHydraPluginRewind, DHydraPluginRewind>(
          'HydraPlugin_rewind',
        ),
        hydra_plugin_get = lib.lookupFunction<NHydraPluginGet, DHydraPluginGet>(
          'HydraPlugin_get',
        ),
        delete_hydra_plugin =
            lib.lookupFunction<NDeleteHydraPlugin, DDeleteHydraPlugin>(
          'delete_HydraPlugin',
        ),
        hydra_private_get =
            lib.lookupFunction<NHydraPluginPrivateGet, DHydraPluginPrivateGet>(
          'HydraPlugin_private',
        ),
        delete_hydra_private =
            lib.lookupFunction<NDeleteHydraPrivate, DDeleteHydraPrivate>(
          'delete_HydraPrivate',
        ),
        hydra_private_sign_tx =
            lib.lookupFunction<NHydraPrivateSignTx, DHydraPrivateSignTx>(
          'HydraPrivate_sign_hydra_tx',
        ),
        hydra_private_neuter =
            lib.lookupFunction<NHydraPrivateNeuter, DHydraPrivateNeuter>(
          'HydraPrivate_neuter',
        ),
        hydra_public_get =
            lib.lookupFunction<NHydraPluginPublicGet, DHydraPluginPublicGet>(
          'HydraPlugin_public',
        ),
        delete_hydra_public =
            lib.lookupFunction<NDeleteHydraPublic, DDeleteHydraPublic>(
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
            lib.lookupFunction<NDeleteBip44PublicKey, DDeleteBip44PublicKey>(
          'delete_Bip44PublicKey',
        ),
        bip44_public_key_pk_get = lib.lookupFunction<
            NBip44PublicKey_PublicKeyGet, DBip44PublicKey_PublicKeyGet>(
          'Bip44PublicKey_publicKey_get',
        ),
        bip44_public_key_address_get = lib.lookupFunction<
            NBip44PublicKey_AddressGet, DBip44PublicKey_AddressGet>(
          'Bip44PublicKey_address_get',
        ),
        delete_secp_public_key =
            lib.lookupFunction<NDeleteSecpPublicKey, DDeleteSecpPublicKey>(
          'delete_SecpPublicKey',
        ),
        secp_public_key_tostring = lib
            .lookupFunction<NSecpPublicKey_ToString, DSecpPublicKey_ToString>(
          'SecpPublicKey_toString',
        ),
        delete_mpublic_key =
            lib.lookupFunction<NDeleteMPublicKey, DDeleteMPublicKey>(
          'delete_MPublicKey',
        ),
        mpublic_key_fromsecp =
            lib.lookupFunction<NMPublicKey_FromSecp, DMPublicKey_FromSecp>(
          'MPublicKey_from_secp',
        ),
        mpublic_key_frombytes =
            lib.lookupFunction<NMPublicKey_FromBytes, DMPublicKey_FromBytes>(
          'MPublicKey_from_bytes',
        ),
        mpublic_key_fromstring =
            lib.lookupFunction<NMPublicKey_FromString, DMPublicKey_FromString>(
          'MPublicKey_from_string',
        ),
        mpublic_key_tobytes =
            lib.lookupFunction<NMPublicKey_ToBytes, DMPublicKey_ToBytes>(
          'MPublicKey_to_bytes',
        ),
        mpublic_key_tostring =
            lib.lookupFunction<NMPublicKey_ToString, DMPublicKey_ToString>(
          'MPublicKey_to_string',
        ),
        mpublic_key_keyid =
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
        delete_mkeyid = lib.lookupFunction<NDeleteMKeyId, DDeleteMKeyId>(
          'delete_MKeyId',
        ),
        mkeyid_fromstring =
            lib.lookupFunction<NMKeyId_FromString, DMKeyId_FromString>(
          'MKeyId_from_string',
        ),
        mkeyid_tostring =
            lib.lookupFunction<NMKeyId_ToString, DMKeyId_ToString>(
          'MKeyId_to_string',
        );
}

typedef NBip39GeneratePhrase = Pointer<Result> Function(
  Pointer<Utf8> langCode,
);
typedef DBip39GeneratePhrase = Pointer<Result> Function(
  Pointer<Utf8> langCode,
);

typedef NBip39ValidatePhrase = Pointer<Result> Function(
  Pointer<Utf8> langCode,
  Pointer<Utf8> phrase,
);
typedef DBip39ValidatePhrase = Pointer<Result> Function(
  Pointer<Utf8> langCode,
  Pointer<Utf8> phrase,
);

typedef NBip39ListWords = Pointer<Result> Function(
  Pointer<Utf8> langCode,
  Pointer<Utf8> prefix,
);
typedef DBip39ListWords = Pointer<Result> Function(
  Pointer<Utf8> langCode,
  Pointer<Utf8> prefix,
);

typedef NMaskJson = Pointer<Result> Function(
  Pointer<Utf8> json,
  Pointer<Utf8> keepPaths,
);
typedef DMaskJson = Pointer<Result> Function(
  Pointer<Utf8> json,
  Pointer<Utf8> keepPaths,
);

typedef NGenerateNonce = Pointer<Result> Function();
typedef DGenerateNonce = Pointer<Result> Function();

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

typedef NCreateVault = Pointer<Result> Function(
  Pointer<Utf8> lang,
  Pointer<Utf8> seed,
  Pointer<Utf8> word25,
  Pointer<Utf8> unlockPassword,
);
typedef DCreateVault = Pointer<Result> Function(
  Pointer<Utf8> lang,
  Pointer<Utf8> seed,
  Pointer<Utf8> word25,
  Pointer<Utf8> unlockPassword,
);

typedef NDeleteVault = Void Function(Pointer<Void> vault);
typedef DDeleteVault = void Function(Pointer<Void> vault);

typedef NVaultIsDirty = Pointer<Result> Function(Pointer<Void> vault);
typedef DVaultIsDirty = Pointer<Result> Function(Pointer<Void> vault);

typedef NVaultToJson = Pointer<Result> Function(Pointer<Void> vault);
typedef DVaultToJson = Pointer<Result> Function(Pointer<Void> vault);

typedef NJsonToVault = Pointer<Result> Function(Pointer<Utf8> json);
typedef DJsonToVault = Pointer<Result> Function(Pointer<Utf8> json);

typedef NMorpheusPluginRewind = Pointer<Result> Function(
  Pointer<Void> vault,
  Pointer<Utf8> unlockPwd,
);
typedef DMorpheusPluginRewind = Pointer<Result> Function(
  Pointer<Void> vault,
  Pointer<Utf8> unlockPwd,
);

typedef NMorpheusPluginGet = Pointer<Result> Function(Pointer<Void> vault);
typedef DMorpheusPluginGet = Pointer<Result> Function(Pointer<Void> vault);

typedef NMorpheusPluginPublic = Pointer<Result> Function(Pointer<Void> vault);
typedef DMorpheusPluginPublic = Pointer<Result> Function(Pointer<Void> vault);

typedef NMorpheusPluginPrivate = Pointer<Result> Function(
    Pointer<Void> vault, Pointer<Utf8> unlockPassword);
typedef DMorpheusPluginPrivate = Pointer<Result> Function(
    Pointer<Void> vault, Pointer<Utf8> unlockPassword);

typedef NDeleteMorpheusPlugin = Void Function(Pointer<Void> morpheus);
typedef DDeleteMorpheusPlugin = void Function(Pointer<Void> morpheus);

typedef NMorpheusPublicPersonas = Pointer<Result> Function(
    Pointer<Void> morpheusPublic);
typedef DMorpheusPublicPersonas = Pointer<Result> Function(
    Pointer<Void> morpheusPublic);

typedef NMorpheusPublicKeyById = Pointer<Result> Function(
    Pointer<Void> morpheusPublic, Pointer<Void> keyId);
typedef DMorpheusPublicKeyById = Pointer<Result> Function(
    Pointer<Void> morpheusPublic, Pointer<Void> keyId);

typedef NDeleteMorpheusPublic = Void Function(Pointer<Void> public);
typedef DDeleteMorpheusPublic = void Function(Pointer<Void> public);

typedef NDeleteMorpheusPrivate = Void Function(Pointer<Void> private);
typedef DDeleteMorpheusPrivate = void Function(Pointer<Void> private);

typedef NMorpheusPublicKindLen = Pointer<Result> Function(Pointer<Void> kind);
typedef DMorpheusPublicKindLen = Pointer<Result> Function(Pointer<Void> kind);

typedef NMorpheusPublicKindIsEmpty = Pointer<Result> Function(
    Pointer<Void> kind);
typedef DMorpheusPublicKindIsEmpty = Pointer<Result> Function(
    Pointer<Void> kind);

typedef NMorpheusPublicKindKey = Pointer<Result> Function(
    Pointer<Void> kind, Int32 idx);
typedef DMorpheusPublicKindKey = Pointer<Result> Function(
    Pointer<Void> kind, int idx);

typedef NDeleteMorpheusPublicKind = Void Function(Pointer<Void> kind);
typedef DDeleteMorpheusPublicKind = void Function(Pointer<Void> kind);

typedef NHydraPluginRewind = Pointer<Result> Function(
  Pointer<Void> vault,
  Pointer<Utf8> unlockPwd,
  Pointer<Utf8> network,
  Int32 idx,
);
typedef DHydraPluginRewind = Pointer<Result> Function(
  Pointer<Void> vault,
  Pointer<Utf8> unlockPwd,
  Pointer<Utf8> network,
  int idx,
);

typedef NHydraPluginGet = Pointer<Result> Function(
  Pointer<Void> vault,
  Pointer<Utf8> network,
  Int32 idx,
);
typedef DHydraPluginGet = Pointer<Result> Function(
  Pointer<Void> vault,
  Pointer<Utf8> network,
  int idx,
);

typedef NDeleteHydraPlugin = Void Function(Pointer<Void> hydra);
typedef DDeleteHydraPlugin = void Function(Pointer<Void> hydra);

typedef NHydraPluginPrivateGet = Pointer<Result> Function(
  Pointer<Void> hydra,
  Pointer<Utf8> unlockPassword,
);
typedef DHydraPluginPrivateGet = Pointer<Result> Function(
  Pointer<Void> hydra,
  Pointer<Utf8> unlockPassword,
);

typedef NDeleteHydraPrivate = Void Function(Pointer<Void> private);
typedef DDeleteHydraPrivate = void Function(Pointer<Void> private);

typedef NHydraPrivateNeuter = Pointer<Result> Function(Pointer<Void> private);
typedef DHydraPrivateNeuter = Pointer<Result> Function(Pointer<Void> private);

typedef NHydraPrivateSignTx = Pointer<Result> Function(
  Pointer<Void> private,
  Pointer<Utf8> address,
  Pointer<Utf8> txJson,
);
typedef DHydraPrivateSignTx = Pointer<Result> Function(
  Pointer<Void> private,
  Pointer<Utf8> address,
  Pointer<Utf8> txJson,
);

typedef NHydraPluginPublicGet = Pointer<Result> Function(Pointer hydra);
typedef DHydraPluginPublicGet = Pointer<Result> Function(Pointer hydra);

typedef NDeleteHydraPublic = Void Function(Pointer<Void> public);
typedef DDeleteHydraPublic = void Function(Pointer<Void> public);

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

typedef NDeleteBip44PublicKey = Void Function(Pointer<Void> bip44Pk);
typedef DDeleteBip44PublicKey = void Function(Pointer<Void> bip44Pk);

typedef NBip44PublicKey_PublicKeyGet = Pointer<Result> Function(
  Pointer bip44Pk,
);
typedef DBip44PublicKey_PublicKeyGet = Pointer<Result> Function(
  Pointer bip44Pk,
);

typedef NBip44PublicKey_AddressGet = Pointer<Result> Function(
    Pointer<Void> bip44Pk);
typedef DBip44PublicKey_AddressGet = Pointer<Result> Function(
    Pointer<Void> bip44Pk);

typedef NDeleteSecpPublicKey = Void Function(Pointer<Void> secpPk);
typedef DDeleteSecpPublicKey = void Function(Pointer<Void> secpPk);

typedef NSecpPublicKey_ToString = Pointer<Result> Function(Pointer secpPk);
typedef DSecpPublicKey_ToString = Pointer<Result> Function(Pointer secpPk);

typedef NDeleteMPublicKey = Void Function(Pointer pk);
typedef DDeleteMPublicKey = void Function(Pointer pk);

typedef NMPublicKey_FromSecp = Pointer<Void> Function(Pointer<Void> secp);
typedef DMPublicKey_FromSecp = Pointer<Void> Function(Pointer<Void> secp);

typedef NMPublicKey_FromBytes = Pointer<Result> Function(Pointer<NativeSlice> data);
typedef DMPublicKey_FromBytes = Pointer<Result> Function(Pointer<NativeSlice> data);

typedef NMPublicKey_FromString = Pointer<Result> Function(Pointer<Utf8> str);
typedef DMPublicKey_FromString = Pointer<Result> Function(Pointer<Utf8> str);

typedef NMPublicKey_ToBytes = Pointer<NativeSlice> Function(Pointer<Void> pk);
typedef DMPublicKey_ToBytes = Pointer<NativeSlice> Function(Pointer<Void> pk);

typedef NMPublicKey_ToString = Pointer<Utf8> Function(Pointer pk);
typedef DMPublicKey_ToString = Pointer<Utf8> Function(Pointer pk);

typedef NMPublicKey_KeyId = Pointer<Void> Function(Pointer<Void> pk);
typedef DMPublicKey_KeyId = Pointer<Void> Function(Pointer<Void> pk);

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

typedef NDeleteMKeyId = Void Function(Pointer mpk);
typedef DDeleteMKeyId = void Function(Pointer mpk);

typedef NMKeyId_FromString = Pointer<Result> Function(Pointer<Utf8> str);
typedef DMKeyId_FromString = Pointer<Result> Function(Pointer<Utf8> str);

typedef NMKeyId_ToString = Pointer<Utf8> Function(Pointer mid);
typedef DMKeyId_ToString = Pointer<Utf8> Function(Pointer mid);
