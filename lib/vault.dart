import 'dart:ffi';

import 'package:morpheus_sdk/ffi/dart_api.dart';
import 'package:morpheus_sdk/layer1.dart';
import 'package:morpheus_sdk/hydra/plugin.dart';

class Vault {
    // TODO call destructor somehow
    final Pointer<Void> _ffiVault;

    Vault(this._ffiVault);

    static Vault create(String seed, String word25, String unlockPassword, {String languageCode = 'en'}) {
        final ffiVault = DartApi.Instance.createVault(languageCode, seed, word25, unlockPassword);
        return Vault(ffiVault);
    }

    static Vault load(String vaultJson) {
        final ffiVault = DartApi.Instance.jsonToVault(vaultJson);
        return Vault(ffiVault);
    }

    bool isDirty() {
      return DartApi.Instance.vaultIsDirty(_ffiVault);
    }

    String save() {
      return DartApi.Instance.vaultToJson(_ffiVault);
    }

    // TODO rewind operations should be static fns on the plugin classes, but needs access to vault._ffiVault
    void rewindHydra(String unlockPassword, Network network, int account) {
      DartApi.Instance.hydraRewind(_ffiVault, unlockPassword, network.Id, account);
    }

    HydraPlugin hydra(Network network, int account) {
        final ffiPlugin = DartApi.Instance.hydraGet(_ffiVault, network.Id, account);
        return HydraPlugin(ffiPlugin);
    }
}
