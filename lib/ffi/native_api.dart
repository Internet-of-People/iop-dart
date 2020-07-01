import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'ffi.dart';

class NativeAPI {
  final DartFuncBip39GeneratePhrase bip39_generate_phrase;
  final DartFuncBip39ValidatePhrase bip39_validate_phrase;
  final DartFuncBip39ListWords bip39_list_words;
  final DartFuncMaskJson mask_json;
  final DartFuncGenerateNonce generate_nonce;
  final DartFuncHydraTransferTx hydra_transfer_tx;
  final DartFuncCreateVault create_vault;
  final DartFuncFreeVault free_vault;
  final DartFuncVaultToJson vault_to_json;
  final DartFuncJsonToVault json_to_vault;
  final DartFuncVaultIsDirty vault_is_dirty;
  final DartFuncMorpheusRewind morpheus_rewind;
  final DartFuncMorpheusGet morpheus_get;
  final DartFuncFreeMorpheus free_morpheus_plugin;
  final DartFuncMorpheusPersona morpheus_persona;
  final DartFuncHydraPluginRewind hydra_plugin_rewind;
  final DartFuncHydraPluginGet hydra_plugin_get;
  final DartFuncFreeHydraPlugin free_hydra_plugin;
  final DartFuncHydraPluginPrivateGet hydra_private_get;
  final DartFuncFreeHydraPrivate free_hydra_private;
  final DartFuncHydraPrivateSignTx hydra_private_sign_tx;
  final DartFuncHydraPluginPublicGet hydra_public_get;
  final DartFuncFreeHydraPublic free_hydra_public;
  final DartFuncHydraPublicAddress hydra_public_address;

  NativeAPI(
    this.bip39_generate_phrase,
    this.bip39_validate_phrase,
    this.bip39_list_words,
    this.mask_json,
    this.generate_nonce,
    this.hydra_transfer_tx,
    this.create_vault,
    this.free_vault,
    this.vault_to_json,
    this.json_to_vault,
    this.vault_is_dirty,
    this.morpheus_rewind,
    this.morpheus_get,
    this.free_morpheus_plugin,
    this.morpheus_persona,
    this.hydra_plugin_rewind,
    this.hydra_plugin_get,
    this.free_hydra_plugin,
    this.hydra_private_get,
    this.free_hydra_private,
    this.hydra_private_sign_tx,
    this.hydra_public_get,
    this.free_hydra_public,
    this.hydra_public_address,
  );
}

typedef NativeFuncBip39GeneratePhrase = Pointer<Result> Function(
  Pointer<Utf8> langCode,
);
typedef DartFuncBip39GeneratePhrase = Pointer<Result> Function(
  Pointer<Utf8> langCode,
);

typedef NativeFuncBip39ValidatePhrase = Pointer<Result> Function(
  Pointer<Utf8> langCode,
  Pointer<Utf8> phrase,
);
typedef DartFuncBip39ValidatePhrase = Pointer<Result> Function(
  Pointer<Utf8> langCode,
  Pointer<Utf8> phrase,
);

typedef NativeFuncBip39ListWords = Pointer<Result> Function(
  Pointer<Utf8> langCode,
  Pointer<Utf8> prefix,
);
typedef DartFuncBip39ListWords = Pointer<Result> Function(
  Pointer<Utf8> langCode,
  Pointer<Utf8> prefix,
);

typedef NativeFuncMaskJson = Pointer<Result> Function(
  Pointer<Utf8> json,
  Pointer<Utf8> keepPaths,
);
typedef DartFuncMaskJson = Pointer<Result> Function(
  Pointer<Utf8> json,
  Pointer<Utf8> keepPaths,
);

typedef NativeFuncGenerateNonce = Pointer<Result> Function();
typedef DartFuncGenerateNonce = Pointer<Result> Function();

typedef NativeFuncHydraTransferTx = Pointer<Result> Function(
  Pointer<Utf8> network,
  Pointer<Utf8> senderPubKey,
  Pointer<Utf8> recipient,
  Int64 amount,
  Int64 nonce,
);
typedef DartFuncHydraTransferTx = Pointer<Result> Function(
  Pointer<Utf8> network,
  Pointer<Utf8> senderPubKey,
  Pointer<Utf8> recipient,
  int amount,
  int nonce,
);

typedef NativeFuncCreateVault = Pointer<Result> Function(
  Pointer<Utf8> lang,
  Pointer<Utf8> seed,
  Pointer<Utf8> word25,
  Pointer<Utf8> unlockPassword,
);
typedef DartFuncCreateVault = Pointer<Result> Function(
  Pointer<Utf8> lang,
  Pointer<Utf8> seed,
  Pointer<Utf8> word25,
  Pointer<Utf8> unlockPassword,
);

typedef NativeFuncFreeVault = Void Function(Pointer vault);
typedef DartFuncFreeVault = void Function(Pointer vault);

typedef NativeFuncVaultIsDirty = Pointer<Result> Function(Pointer vault);
typedef DartFuncVaultIsDirty = Pointer<Result> Function(Pointer vault);

typedef NativeFuncVaultToJson = Pointer<Result> Function(Pointer vault);
typedef DartFuncVaultToJson = Pointer<Result> Function(Pointer vault);

typedef NativeFuncJsonToVault = Pointer<Result> Function(Pointer<Utf8> json);
typedef DartFuncJsonToVault = Pointer<Result> Function(Pointer<Utf8> json);

typedef NativeFuncMorpheusRewind = Pointer<Result> Function(
  Pointer vault,
  Pointer<Utf8> unlockPwd,
);
typedef DartFuncMorpheusRewind = Pointer<Result> Function(
  Pointer vault,
  Pointer<Utf8> unlockPwd,
);

typedef NativeFuncMorpheusGet = Pointer<Result> Function(Pointer vault);
typedef DartFuncMorpheusGet = Pointer<Result> Function(Pointer vault);

typedef NativeFuncMorpheusPersona = Pointer<Result> Function(
  Pointer morpheus,
  Int32 idx,
);
typedef DartFuncMorpheusPersona = Pointer<Result> Function(
  Pointer morpheus,
  int idx,
);

typedef NativeFuncFreeMorpheus = Void Function(Pointer morpheus);
typedef DartFuncFreeMorpheus = void Function(Pointer morpheus);

typedef NativeFuncHydraPluginRewind = Pointer<Result> Function(
  Pointer vault,
  Pointer<Utf8> unlockPwd,
  Pointer<Utf8> network,
  Int32 idx,
);
typedef DartFuncHydraPluginRewind = Pointer<Result> Function(
  Pointer vault,
  Pointer<Utf8> unlockPwd,
  Pointer<Utf8> network,
  int idx,
);

typedef NativeFuncHydraPluginGet = Pointer<Result> Function(
  Pointer vault,
  Pointer<Utf8> network,
  Int32 idx,
);
typedef DartFuncHydraPluginGet = Pointer<Result> Function(
  Pointer vault,
  Pointer<Utf8> network,
  int idx,
);

typedef NativeFuncFreeHydraPlugin = Void Function(Pointer hydra);
typedef DartFuncFreeHydraPlugin = void Function(Pointer hydra);

typedef NativeFuncHydraPluginPrivateGet = Pointer<Result> Function(
  Pointer hydra,
  Pointer<Utf8> unlockPassword,
);
typedef DartFuncHydraPluginPrivateGet = Pointer<Result> Function(
  Pointer hydra,
  Pointer<Utf8> unlockPassword,
);

typedef NativeFuncFreeHydraPrivate = Void Function(Pointer private);
typedef DartFuncFreeHydraPrivate = void Function(Pointer private);

typedef NativeFuncHydraPrivateSignTx = Pointer<Result> Function(
  Pointer private,
  Pointer<Utf8> address,
  Pointer<Utf8> txJson,
);
typedef DartFuncHydraPrivateSignTx = Pointer<Result> Function(
  Pointer private,
  Pointer<Utf8> address,
  Pointer<Utf8> txJson,
);

typedef NativeFuncHydraPluginPublicGet = Pointer<Result> Function(
  Pointer hydra,
);
typedef DartFuncHydraPluginPublicGet = Pointer<Result> Function(Pointer hydra);

typedef NativeFuncFreeHydraPublic = Void Function(Pointer public);
typedef DartFuncFreeHydraPublic = void Function(Pointer public);

typedef NativeFuncHydraPublicAddress = Pointer<Result> Function(
  Pointer hydra,
  Int32 idx,
);
typedef DartFuncHydraPublicAddress = Pointer<Result> Function(
  Pointer hydra,
  int idx,
);
