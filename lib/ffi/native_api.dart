import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'ffi.dart';

class NativeApi {
  final DBip39GeneratePhrase bip39_generate_phrase;
  final DBip39ValidatePhrase bip39_validate_phrase;
  final DBip39ListWords bip39_list_words;
  final DMaskJson mask_json;
  final DGenerateNonce generate_nonce;
  final DHydraTransferTx hydra_transfer_tx;
  final DCreateVault create_vault;
  final DFreeVault free_vault;
  final DVaultToJson vault_to_json;
  final DJsonToVault json_to_vault;
  final DVaultIsDirty vault_is_dirty;
  final DMorpheusRewind morpheus_rewind;
  final DMorpheusGet morpheus_get;
  final DFreeMorpheus free_morpheus_plugin;
  final DMorpheusPersona morpheus_persona;
  final DHydraPluginRewind hydra_plugin_rewind;
  final DHydraPluginGet hydra_plugin_get;
  final DFreeHydraPlugin free_hydra_plugin;
  final DHydraPluginPrivateGet hydra_private_get;
  final DFreeHydraPrivate free_hydra_private;
  final DHydraPrivateSignTx hydra_private_sign_tx;
  final DHydraPrivateNeuter hydra_private_neuter;
  final DHydraPluginPublicGet hydra_public_get;
  final DFreeHydraPublic free_hydra_public;
  final DHydraPublic_Key hydra_public_key;
  final DHydraPublic_KeyByAddress hydra_public_key_by_address;
  final DFreeBip44PublicKey free_bip44_public_key;
  final DBip44PublicKey_PublicKeyGet bip44_public_key_pk_get;
  final DBip44PublicKey_AddressGet bip44_public_key_address_get;
  final DFreeSecpPublicKey free_secp_public_key;
  final DSecpPublicKey_ToString secp_public_key_tostring;

  NativeApi(
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
    this.hydra_private_neuter,
    this.hydra_public_get,
    this.free_hydra_public,
    this.hydra_public_key,
    this.hydra_public_key_by_address,
    this.free_bip44_public_key,
    this.bip44_public_key_pk_get,
    this.bip44_public_key_address_get,
    this.free_secp_public_key,
    this.secp_public_key_tostring,
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

typedef NFreeVault = Void Function(Pointer vault);
typedef DFreeVault = void Function(Pointer vault);

typedef NVaultIsDirty = Pointer<Result> Function(Pointer vault);
typedef DVaultIsDirty = Pointer<Result> Function(Pointer vault);

typedef NVaultToJson = Pointer<Result> Function(Pointer vault);
typedef DVaultToJson = Pointer<Result> Function(Pointer vault);

typedef NJsonToVault = Pointer<Result> Function(Pointer<Utf8> json);
typedef DJsonToVault = Pointer<Result> Function(Pointer<Utf8> json);

typedef NMorpheusRewind = Pointer<Result> Function(
  Pointer vault,
  Pointer<Utf8> unlockPwd,
);
typedef DMorpheusRewind = Pointer<Result> Function(
  Pointer vault,
  Pointer<Utf8> unlockPwd,
);

typedef NMorpheusGet = Pointer<Result> Function(Pointer vault);
typedef DMorpheusGet = Pointer<Result> Function(Pointer vault);

typedef NMorpheusPersona = Pointer<Result> Function(
  Pointer morpheus,
  Int32 idx,
);
typedef DMorpheusPersona = Pointer<Result> Function(
  Pointer morpheus,
  int idx,
);

typedef NFreeMorpheus = Void Function(Pointer morpheus);
typedef DFreeMorpheus = void Function(Pointer morpheus);

typedef NHydraPluginRewind = Pointer<Result> Function(
  Pointer vault,
  Pointer<Utf8> unlockPwd,
  Pointer<Utf8> network,
  Int32 idx,
);
typedef DHydraPluginRewind = Pointer<Result> Function(
  Pointer vault,
  Pointer<Utf8> unlockPwd,
  Pointer<Utf8> network,
  int idx,
);

typedef NHydraPluginGet = Pointer<Result> Function(
  Pointer vault,
  Pointer<Utf8> network,
  Int32 idx,
);
typedef DHydraPluginGet = Pointer<Result> Function(
  Pointer vault,
  Pointer<Utf8> network,
  int idx,
);

typedef NFreeHydraPlugin = Void Function(Pointer hydra);
typedef DFreeHydraPlugin = void Function(Pointer hydra);

typedef NHydraPluginPrivateGet = Pointer<Result> Function(
  Pointer hydra,
  Pointer<Utf8> unlockPassword,
);
typedef DHydraPluginPrivateGet = Pointer<Result> Function(
  Pointer hydra,
  Pointer<Utf8> unlockPassword,
);

typedef NFreeHydraPrivate = Void Function(Pointer private);
typedef DFreeHydraPrivate = void Function(Pointer private);

typedef NHydraPrivateNeuter = Pointer<Result> Function(Pointer private);
typedef DHydraPrivateNeuter = Pointer<Result> Function(Pointer private);

typedef NHydraPrivateSignTx = Pointer<Result> Function(
  Pointer private,
  Pointer<Utf8> address,
  Pointer<Utf8> txJson,
);
typedef DHydraPrivateSignTx = Pointer<Result> Function(
  Pointer private,
  Pointer<Utf8> address,
  Pointer<Utf8> txJson,
);

typedef NHydraPluginPublicGet = Pointer<Result> Function(Pointer hydra);
typedef DHydraPluginPublicGet = Pointer<Result> Function(Pointer hydra);

typedef NFreeHydraPublic = Void Function(Pointer public);
typedef DFreeHydraPublic = void Function(Pointer public);

typedef NHydraPublic_Key = Pointer<Result> Function(
  Pointer hydra,
  Int32 idx,
);
typedef DHydraPublic_Key = Pointer<Result> Function(
  Pointer hydra,
  int idx,
);

typedef NHydraPublic_KeyByAddress = Pointer<Result> Function(
  Pointer public,
  Pointer<Utf8> address,
);
typedef DHydraPublic_KeyByAddress = Pointer<Result> Function(
  Pointer public,
  Pointer<Utf8> address,
);

typedef NFreeBip44PublicKey = Void Function(Pointer bip44Pk);
typedef DFreeBip44PublicKey = void Function(Pointer bip44Pk);

typedef NBip44PublicKey_PublicKeyGet = Pointer<Result> Function(
  Pointer bip44Pk,
);
typedef DBip44PublicKey_PublicKeyGet = Pointer<Result> Function(
  Pointer bip44Pk,
);

typedef NBip44PublicKey_AddressGet = Pointer<Result> Function(Pointer bip44Pk);
typedef DBip44PublicKey_AddressGet = Pointer<Result> Function(Pointer bip44Pk);

typedef NFreeSecpPublicKey = Void Function(Pointer secpPk);
typedef DFreeSecpPublicKey = void Function(Pointer secpPk);

typedef NSecpPublicKey_ToString = Pointer<Result> Function(Pointer secpPk);
typedef DSecpPublicKey_ToString = Pointer<Result> Function(Pointer secpPk);
