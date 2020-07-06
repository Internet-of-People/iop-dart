import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:morpheus_sdk/ffi/ffi.dart';
import 'package:morpheus_sdk/ffi/native_api.dart';

class DartApi {
  static DartApi _instance;
  final NativeApi _native;

  DartApi._(this._native);

  static DartApi get instance {
    if (_instance == null) {
      final lib = DynamicLibrary.open('./libmorpheus_core.so');
      final api = NativeApi(
        lib.lookupFunction<NBip39GeneratePhrase, DBip39GeneratePhrase>(
          'Bip39_generate_phrase',
        ),
        lib.lookupFunction<NBip39ValidatePhrase, DBip39ValidatePhrase>(
          'Bip39_validate_phrase',
        ),
        lib.lookupFunction<NBip39ListWords, DBip39ListWords>(
          'Bip39_list_words',
        ),
        lib.lookupFunction<NMaskJson, DMaskJson>('Json_selective_digest'),
        lib.lookupFunction<NGenerateNonce, DGenerateNonce>('Nonce_generate'),
        lib.lookupFunction<NHydraTransferTx, DHydraTransferTx>(
          'TxBuilder_hydraTransferTx',
        ),
        lib.lookupFunction<NCreateVault, DCreateVault>('Vault_create'),
        lib.lookupFunction<NFreeVault, DFreeVault>('delete_Vault'),
        lib.lookupFunction<NVaultToJson, DVaultToJson>('Vault_save'),
        lib.lookupFunction<NJsonToVault, DJsonToVault>('Vault_load'),
        lib.lookupFunction<NVaultIsDirty, DVaultIsDirty>('Vault_dirty_get'),
        lib.lookupFunction<NMorpheusRewind, DMorpheusRewind>(
          'MorpheusPlugin_rewind',
        ),
        lib.lookupFunction<NMorpheusGet, DMorpheusGet>('MorpheusPlugin_get'),
        lib.lookupFunction<NFreeMorpheus, DFreeMorpheus>(
          'delete_MorpheusPlugin',
        ),
        lib.lookupFunction<NMorpheusPersona, DMorpheusPersona>(
          'MorpheusPlugin_persona',
        ),
        lib.lookupFunction<NHydraPluginRewind, DHydraPluginRewind>(
          'HydraPlugin_rewind',
        ),
        lib.lookupFunction<NHydraPluginGet, DHydraPluginGet>('HydraPlugin_get'),
        lib.lookupFunction<NFreeHydraPlugin, DFreeHydraPlugin>(
          'delete_HydraPlugin',
        ),
        lib.lookupFunction<NHydraPluginPrivateGet, DHydraPluginPrivateGet>(
          'HydraPlugin_private',
        ),
        lib.lookupFunction<NFreeHydraPrivate, DFreeHydraPrivate>(
          'delete_HydraPrivate',
        ),
        lib.lookupFunction<NHydraPrivateSignTx, DHydraPrivateSignTx>(
          'HydraPrivate_sign_hydra_tx',
        ),
        lib.lookupFunction<NHydraPrivateNeuter, DHydraPrivateNeuter>(
          'HydraPrivate_neuter',
        ),
        lib.lookupFunction<NHydraPluginPublicGet, DHydraPluginPublicGet>(
          'HydraPlugin_public',
        ),
        lib.lookupFunction<NFreeHydraPublic, DFreeHydraPublic>(
          'delete_HydraPublic',
        ),
        lib.lookupFunction<NHydraPublic_Key, DHydraPublic_Key>(
          'HydraPublic_key',
        ),
        lib.lookupFunction<NHydraPublic_KeyByAddress,
            DHydraPublic_KeyByAddress>(
          'HydraPublic_key_by_address',
        ),
        lib.lookupFunction<NFreeBip44PublicKey, DFreeBip44PublicKey>(
          'delete_Bip44PublicKey',
        ),
        lib.lookupFunction<NBip44PublicKey_PublicKeyGet,
            DBip44PublicKey_PublicKeyGet>(
          'Bip44PublicKey_publicKey_get',
        ),
        lib.lookupFunction<NBip44PublicKey_AddressGet,
            DBip44PublicKey_AddressGet>(
          'Bip44PublicKey_address_get',
        ),
        lib.lookupFunction<NFreeSecpPublicKey, DFreeSecpPublicKey>(
          'delete_SecpPublicKey',
        ),
        lib.lookupFunction<NSecpPublicKey_ToString, DSecpPublicKey_ToString>(
          'SecpPublicKey_toString',
        ),
        lib.lookupFunction<NFreeMPublicKey, DFreeMPublicKey>(
          'delete_MPublicKey',
        ),
        lib.lookupFunction<NMPublicKey_FromString, DMPublicKey_FromString>(
          'MPublicKey_from_string',
        ),
        lib.lookupFunction<NMPublicKey_ToString, DMPublicKey_ToString>(
          'MPublicKey_to_string',
        ),
        lib.lookupFunction<NFreeMKeyId, DFreeMKeyId>('delete_MKeyId'),
        lib.lookupFunction<NMKeyId_FromString, DMKeyId_FromString>(
          'MKeyId_from_string',
        ),
        lib.lookupFunction<NMKeyId_ToString, DMKeyId_ToString>(
          'MKeyId_to_string',
        ),
      );
      _instance = DartApi._(api);
    }

    return _instance;
  }

  static void disposeIfCreated() {
    if (_instance != null) {
      _instance.dispose();
      _instance = null;
    }
  }

  String bip39GeneratePhrase(String langCode) {
    final nativeLangCode = Utf8.toUtf8(langCode);
    try {
      return _native
          .bip39_generate_phrase(nativeLangCode)
          .extract((res) => res.asString);
    } finally {
      free(nativeLangCode);
    }
  }

  void bip39ValidatePhrase(String langCode, String phrase) {
    final nativeLangCode = Utf8.toUtf8(langCode);
    final nativePhrase = Utf8.toUtf8(phrase);
    try {
      return _native
          .bip39_validate_phrase(nativeLangCode, nativePhrase)
          .extract((res) => res.asVoid);
    } finally {
      free(nativeLangCode);
      free(nativePhrase);
    }
  }

  List<String> bip39ListWords(String langCode, String prefix) {
    final nativeLangCode = Utf8.toUtf8(langCode);
    final nativePrefix = Utf8.toUtf8(prefix);

    try {
      return _native
          .bip39_list_words(nativeLangCode, nativePrefix)
          .extract((res) => res.asStringList());
    } finally {
      free(nativeLangCode);
      free(nativePrefix);
    }
  }

  String maskJson(String json, String keepPaths) {
    final nativeJson = Utf8.toUtf8(json);
    final nativeKeepPaths = Utf8.toUtf8(keepPaths);
    try {
      return _native
          .mask_json(nativeJson, nativeKeepPaths)
          .extract((res) => res.asString);
    } finally {
      free(nativeJson);
      free(nativeKeepPaths);
    }
  }

  String generateNonce() {
    return _native.generate_nonce().extract((res) => res.asString);
  }

  String hydraTransferTx(
    String network,
    String senderPubKey,
    String recipient,
    int flakesAmount,
    int nonce,
  ) {
    final nativeNet = Utf8.toUtf8(network);
    final nativeSender = Utf8.toUtf8(senderPubKey);
    final nativeRecipient = Utf8.toUtf8(recipient);
    try {
      return _native
          .hydra_transfer_tx(
            nativeNet,
            nativeSender,
            nativeRecipient,
            flakesAmount,
            nonce,
          )
          .extract((res) => res.asString);
    } finally {
      free(nativeRecipient);
      free(nativeSender);
      free(nativeNet);
    }
  }

  Pointer<Void> createVault(
    String langCode,
    String seed,
    String word25,
    String unlockPassword,
  ) {
    final nativeLang = Utf8.toUtf8(langCode);
    final nativeSeed = Utf8.toUtf8(seed);
    final nativeW25 = Utf8.toUtf8(word25);
    final nativePwd = Utf8.toUtf8(unlockPassword);
    try {
      return _native
          .create_vault(nativeLang, nativeSeed, nativeW25, nativePwd)
          .extract((res) => res.asPointer());
    } finally {
      free(nativePwd);
      free(nativeW25);
      free(nativeSeed);
      free(nativeLang);
    }
  }

  void freeVault(Pointer<Void> vault) {
    _native.free_vault(vault);
  }

  String vaultToJson(Pointer<Void> vault) {
    return _native.vault_to_json(vault).extract((res) => res.asString);
  }

  Pointer<Void> jsonToVault(String json) {
    final nativeJson = Utf8.toUtf8(json);
    try {
      return _native
          .json_to_vault(nativeJson)
          .extract((res) => res.asPointer());
    } finally {
      free(nativeJson);
    }
  }

  bool vaultIsDirty(Pointer<Void> vault) {
    return _native.vault_is_dirty(vault).extract((res) => res.asBool());
  }

  void morpheusRewind(Pointer vault, String unlockPassword) {
    final nativePwd = Utf8.toUtf8(unlockPassword);
    try {
      return _native
          .morpheus_rewind(vault, nativePwd)
          .extract((res) => res.asVoid);
    } finally {
      free(nativePwd);
    }
  }

  Pointer<Void> morpheusGet(Pointer vault) {
    return _native.morpheus_get(vault).extract((res) => res.asPointer());
  }

  void freeMorpheus(Pointer<Void> morpheus) {
    _native.free_morpheus_plugin(morpheus);
  }

  String morpheusPersona(Pointer morpheus, int idx) {
    return _native
        .morpheus_persona(morpheus, idx)
        .extract((res) => res.asString);
  }

  void hydraRewind(
    Pointer vault,
    String unlockPassword,
    String network,
    int idx,
  ) {
    final nativePwd = Utf8.toUtf8(unlockPassword);
    final nativeNet = Utf8.toUtf8(network);
    try {
      return _native
          .hydra_plugin_rewind(vault, nativePwd, nativeNet, idx)
          .extract((res) => res.asVoid);
    } finally {
      free(nativeNet);
      free(nativePwd);
    }
  }

  Pointer<Void> hydraGet(Pointer vault, String network, int idx) {
    final nativeNet = Utf8.toUtf8(network);
    try {
      return _native
          .hydra_plugin_get(vault, nativeNet, idx)
          .extract((res) => res.asPointer());
    } finally {
      free(nativeNet);
    }
  }

  void freeHydra(Pointer<Void> hydra) {
    _native.free_hydra_plugin(hydra);
  }

  Pointer<Void> hydraPrivatePart(Pointer hydra, String unlockPassword) {
    final nativePwd = Utf8.toUtf8(unlockPassword);
    try {
      return _native
          .hydra_private_get(hydra, nativePwd)
          .extract((res) => res.asPointer());
    } finally {
      free(nativePwd);
    }
  }

  void freeHydraPrivatePart(Pointer<Void> private) {
    _native.free_hydra_private(private);
  }

  Pointer<Void> hydraPrivatePartNeuter(Pointer<Void> private) {
    return _native
        .hydra_private_neuter(private)
        .extract((res) => res.asPointer());
  }

  String hydraPrivatePartSignHydraTx(
      Pointer private, String address, String txJson) {
    final nativeAddr = Utf8.toUtf8(address);
    final nativeTx = Utf8.toUtf8(txJson);
    try {
      return _native
          .hydra_private_sign_tx(private, nativeAddr, nativeTx)
          .extract((res) => res.asString);
    } finally {
      free(nativeTx);
      free(nativeAddr);
    }
  }

  Pointer<Void> hydraPublicPart(Pointer hydra) {
    return _native.hydra_public_get(hydra).extract((res) => res.asPointer());
  }

  void freeHydraPublicPart(Pointer<Void> public) {
    _native.free_hydra_public(public);
  }

  Pointer<Void> hydraPublicPartKey(Pointer public, int idx) {
    return _native
        .hydra_public_key(public, idx)
        .extract((res) => res.asPointer());
  }

  Pointer<Void> hydraPublicPartKeyByAddress(Pointer public, String address) {
    final nativeAddr = Utf8.toUtf8(address);
    try {
      return _native
          .hydra_public_key_by_address(public, nativeAddr)
          .extract((res) => res.asPointer());
    } finally {
      free(nativeAddr);
    }
  }

  void freeBip44PublicKey(Pointer<Void> bip44PubKey) {
    _native.free_bip44_public_key(bip44PubKey);
  }

  Pointer<Void> bip44PublicKeyGetPublicKey(Pointer bip44PubKey) {
    return _native
        .bip44_public_key_pk_get(bip44PubKey)
        .extract((res) => res.asPointer());
  }

  String bip44PublicKeyGetAddress(Pointer bip44PubKey) {
    return _native
        .bip44_public_key_address_get(bip44PubKey)
        .extract((res) => res.asString);
  }

  void freeSecpPublicKey(Pointer<Void> secpPubKey) {
    _native.free_secp_public_key(secpPubKey);
  }

  String secpPublicKey_toString(Pointer secpPubKey) {
    return _native
        .secp_public_key_tostring(secpPubKey)
        .extract((res) => res.asString);
  }

  void freeMPublicKey(Pointer<Void> mPubKey) {
    _native.free_mpublic_key(mPubKey);
  }

  Pointer<Void> mPublicKeyFromString(String str) {
    final nativeStr = Utf8.toUtf8(str);
    try {
      return _native
          .mpublic_key_fromstring(nativeStr)
          .extract((res) => res.asPointer());
    } finally {
      free(nativeStr);
    }
  }

  String mPublicKeyToString(Pointer mPubKey) {
    return _native.mpublic_key_tostring(mPubKey).intoString();
  }

  void freeMKeyId(Pointer<Void> mKeyId) {
    _native.free_mkeyid(mKeyId);
  }

  Pointer<Void> mKeyIdFromString(String str) {
    final nativeStr = Utf8.toUtf8(str);
    try {
      return _native
          .mkeyid_fromstring(nativeStr)
          .extract((res) => res.asPointer());
    } finally {
      free(nativeStr);
    }
  }

  String mKeyIdToString(Pointer mKeyId) {
    return _native.mkeyid_tostring(mKeyId).intoString();
  }

  void dispose() {}
}
