import 'dart:ffi';

import 'package:iop_sdk/crypto.dart';
import 'package:ffi/ffi.dart';
import 'package:iop_sdk/src/ffi/dart_api.dart';
import 'package:iop_sdk/src/ffi/ffi.dart';

class SubtreePolicies implements Disposable {
  Pointer<Void> _ffi;
  bool _owned;

  SubtreePolicies(this._ffi, this._owned);

  factory SubtreePolicies.create() =>
      SubtreePolicies(DartApi.native.coeusSubtreePolicies.create(), true);

  SubtreePolicies withSchema(String schema) {
    final nativeSchema = schema.toNativeUtf8();
    try {
      final policies = DartApi.native.coeusSubtreePolicies
          .withSchema(_ffi, nativeSchema)
          .extract((res) => res.asPointer<Void>());
      return SubtreePolicies(policies, true);
    } finally {
      calloc.free(nativeSchema);
    }
  }

  SubtreePolicies withExpiration(int maxExpiryBlocks) {
    final policies = DartApi.native.coeusSubtreePolicies
        .withExpiration(_ffi, maxExpiryBlocks)
        .extract((res) => res.asPointer<Void>());
    return SubtreePolicies(policies, true);
  }

  @override
  void dispose() {
    if (_owned) {
      DartApi.native.coeusSubtreePolicies.delete(_ffi);
      _ffi = nullptr;
      _owned = false;
    }
  }
}

class UserOperation implements Disposable {
  Pointer<Void> _ffi;
  bool _owned;

  // NOTE needed for NonceBundleBuilder
  Pointer<Void> get ffi => _ffi;

  UserOperation(this._ffi, this._owned);

  factory UserOperation.register(
    String domainName,
    PublicKey owner,
    SubtreePolicies subtreePolicies,
    String data,
    int expiresAtHeight,
  ) {
    final nativeDomainName = domainName.toNativeUtf8();
    final nativeOwner = owner.toString().toNativeUtf8();
    final nativeData = data.toNativeUtf8();
    try {
      final op = DartApi.native.coeusUserOperation
          .opRegister(nativeDomainName, nativeOwner, subtreePolicies._ffi,
              nativeData, expiresAtHeight)
          .extract((res) => res.asPointer<Void>());
      return UserOperation(op, true);
    } finally {
      calloc.free(nativeData);
      calloc.free(nativeOwner);
      calloc.free(nativeDomainName);
    }
  }

  factory UserOperation.update(String domainName, String schema) {
    final nativeDomainName = domainName.toNativeUtf8();
    final nativeSchema = schema.toNativeUtf8();
    try {
      final op = DartApi.native.coeusUserOperation
          .opUpdate(nativeDomainName, nativeSchema)
          .extract((res) => res.asPointer<Void>());
      return UserOperation(op, true);
    } finally {
      calloc.free(nativeSchema);
      calloc.free(nativeDomainName);
    }
  }

  factory UserOperation.renew(String domainName, int expiresAtHeight) {
    final nativeDomainName = domainName.toNativeUtf8();
    try {
      final op = DartApi.native.coeusUserOperation
          .opRenew(nativeDomainName, expiresAtHeight)
          .extract((res) => res.asPointer<Void>());
      return UserOperation(op, true);
    } finally {
      calloc.free(nativeDomainName);
    }
  }

  factory UserOperation.transfer(String domainName, PublicKey toOwner) {
    final nativeDomainName = domainName.toNativeUtf8();
    final nativeToOwner = toOwner.toString().toNativeUtf8();
    try {
      final op = DartApi.native.coeusUserOperation
          .opTransfer(nativeDomainName, nativeToOwner)
          .extract((res) => res.asPointer<Void>());
      return UserOperation(op, true);
    } finally {
      calloc.free(nativeToOwner);
      calloc.free(nativeDomainName);
    }
  }

  factory UserOperation.delete(String domainName) {
    final nativeDomainName = domainName.toNativeUtf8();
    try {
      final op = DartApi.native.coeusUserOperation
          .opDelete(nativeDomainName)
          .extract((res) => res.asPointer<Void>());
      return UserOperation(op, true);
    } finally {
      calloc.free(nativeDomainName);
    }
  }

  @override
  void dispose() {
    if (_owned) {
      DartApi.native.coeusUserOperation.delete(_ffi);
      _ffi = nullptr;
      _owned = false;
    }
  }
}
