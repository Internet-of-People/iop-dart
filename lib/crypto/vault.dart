import 'dart:ffi';

import 'package:morpheus_sdk/ffi/dart_api.dart';
import 'package:morpheus_sdk/network.dart';

import 'hydra_plugin.dart';

class Vault {
  // TODO call destructor somehow
  final Pointer<Void> _ffiVault;

  Vault(this._ffiVault);

  static Vault create(
    String seed,
    String word25,
    String unlockPassword, {
    String languageCode = 'en',
  }) {
    final ffiVault = DartApi.instance.createVault(
      languageCode,
      seed,
      word25,
      unlockPassword,
    );
    return Vault(ffiVault);
  }

  static Vault load(String vaultJson) {
    final ffiVault = DartApi.instance.jsonToVault(vaultJson);
    return Vault(ffiVault);
  }

  bool isDirty() {
    return DartApi.instance.vaultIsDirty(_ffiVault);
  }

  String save() {
    return DartApi.instance.vaultToJson(_ffiVault);
  }

  // TODO rewind operations should be static fns on the plugin classes, but needs access to vault._ffiVault
  void rewindHydra(String unlockPassword, Network network, int account) {
    DartApi.instance.hydraRewind(
      _ffiVault,
      unlockPassword,
      network.RustApiId,
      account,
    );
  }

  HydraPlugin hydra(Network network, int account) {
    final ffiPlugin = DartApi.instance.hydraGet(
      _ffiVault,
      network.RustApiId,
      account,
    );
    return HydraPlugin(ffiPlugin);
  }
}
