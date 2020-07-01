import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:morpheus_sdk/ffi/ffi.dart';
import 'package:morpheus_sdk/ffi/native_api.dart';

class DartApi {
  static DartApi _instance;
  final NativeAPI _native;

  DartApi._(this._native);

  static DartApi create(String libPath) {
    if (_instance != null) {
      _instance.dispose();
    }

    final lib = DynamicLibrary.open(libPath);

    final api = NativeAPI(
      lib.lookupFunction<NativeFuncBip39GeneratePhrase,
          DartFuncBip39GeneratePhrase>('Bip39_generate_phrase'),
      lib.lookupFunction<NativeFuncBip39ValidatePhrase,
          DartFuncBip39ValidatePhrase>('Bip39_validate_phrase'),
      lib.lookupFunction<NativeFuncBip39ListWords, DartFuncBip39ListWords>(
          'Bip39_list_words'),
      lib.lookupFunction<NativeFuncMaskJson, DartFuncMaskJson>(
          'Json_selective_digest'),
      lib.lookupFunction<NativeFuncGenerateNonce, DartFuncGenerateNonce>(
          'Nonce_generate'),
      lib.lookupFunction<NativeFuncHydraTransferTx, DartFuncHydraTransferTx>(
          'TxBuilder_hydraTransferTx'),
      lib.lookupFunction<NativeFuncCreateVault, DartFuncCreateVault>(
          'Vault_create'),
      lib.lookupFunction<NativeFuncFreeVault, DartFuncFreeVault>(
          'delete_Vault'),
      lib.lookupFunction<NativeFuncVaultToJson, DartFuncVaultToJson>(
          'Vault_save'),
      lib.lookupFunction<NativeFuncJsonToVault, DartFuncJsonToVault>(
          'Vault_load'),
      lib.lookupFunction<NativeFuncVaultIsDirty, DartFuncVaultIsDirty>(
          'Vault_dirty_get'),
      lib.lookupFunction<NativeFuncMorpheusRewind, DartFuncMorpheusRewind>(
          'MorpheusPlugin_rewind'),
      lib.lookupFunction<NativeFuncMorpheusGet, DartFuncMorpheusGet>(
          'MorpheusPlugin_get'),
      lib.lookupFunction<NativeFuncFreeMorpheus, DartFuncFreeMorpheus>(
          'delete_MorpheusPlugin'),
      lib.lookupFunction<NativeFuncMorpheusPersona, DartFuncMorpheusPersona>(
          'MorpheusPlugin_persona'),
      lib.lookupFunction<NativeFuncHydraPluginRewind,
          DartFuncHydraPluginRewind>('HydraPlugin_rewind'),
      lib.lookupFunction<NativeFuncHydraPluginGet, DartFuncHydraPluginGet>(
          'HydraPlugin_get'),
      lib.lookupFunction<NativeFuncFreeHydraPlugin, DartFuncFreeHydraPlugin>(
          'delete_HydraPlugin'),
      lib.lookupFunction<NativeFuncHydraPluginPrivateGet,
          DartFuncHydraPluginPrivateGet>('HydraPlugin_private'),
      lib.lookupFunction<NativeFuncFreeHydraPrivate, DartFuncFreeHydraPrivate>(
          'delete_HydraPrivate'),
      lib.lookupFunction<NativeFuncHydraPrivateSignTx,
          DartFuncHydraPrivateSignTx>('HydraPrivate_sign_hydra_tx'),
      lib.lookupFunction<NativeFuncHydraPluginPublicGet,
          DartFuncHydraPluginPublicGet>('HydraPlugin_public'),
      lib.lookupFunction<NativeFuncFreeHydraPublic, DartFuncFreeHydraPublic>(
          'delete_HydraPublic'),
      lib.lookupFunction<NativeFuncHydraPublicAddress,
          DartFuncHydraPublicAddress>('HydraPublic_address'),
    );

    _instance = DartApi._(api);
    return _instance;
  }

  static void disposeIfCreated() {
    if (_instance != null) {
      _instance.dispose();
      _instance = null;
    }
  }

  static DartApi get Instance => DartApi._instance;

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

  Pointer<Void> hydraPrivate(Pointer hydra, String unlockPassword) {
    final nativePwd = Utf8.toUtf8(unlockPassword);
    try {
      return _native
          .hydra_private_get(hydra, nativePwd)
          .extract((res) => res.asPointer());
    } finally {
      free(nativePwd);
    }
  }

  void freeHydraPrivate(Pointer<Void> private) {
    _native.free_hydra_private(private);
  }

  String signHydraTx(Pointer private, String address, String txJson) {
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

  Pointer<Void> hydraPublic(Pointer hydra) {
    return _native.hydra_public_get(hydra).extract((res) => res.asPointer());
  }

  void freeHydraPublic(Pointer<Void> public) {
    _native.free_hydra_public(public);
  }

  String hydraAddress(Pointer public, int idx) {
    return _native
        .hydra_public_address(public, idx)
        .extract((res) => res.asString);
  }

  void dispose() {}
}
