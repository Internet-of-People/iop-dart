import 'dart:core';
import 'package:ffi/ffi.dart';
import 'package:iop_sdk/crypto.dart';
import 'package:iop_sdk/network.dart';
import 'package:iop_sdk/src/ffi/dart_api.dart';
import 'package:iop_sdk/src/ffi/ffi.dart';

class HydraTxBuilder {
  final Network network;

  HydraTxBuilder(this.network);

  String transfer(
    SecpPublicKey senderPubKey,
    String recipient,
    int flakesAmount,
    int nonce,
  ) {
    final nativeNet = network.networkNativeName.toNativeUtf8();
    final nativeRecipient = recipient.toNativeUtf8();
    try {
      return DartApi.native.hydraTx
          .transfer(
            nativeNet,
            senderPubKey.ffi,
            nativeRecipient,
            flakesAmount,
            nonce,
          )
          .extract((res) => res.asString);
    } finally {
      calloc.free(nativeRecipient);
      calloc.free(nativeNet);
    }
  }

  String vote(
    SecpPublicKey senderPubKey,
    SecpPublicKey delegate,
    int nonce,
  ) {
    final nativeNet = network.networkNativeName.toNativeUtf8();
    try {
      return DartApi.native.hydraTx
          .vote(
            nativeNet,
            senderPubKey.ffi,
            delegate.ffi,
            nonce,
          )
          .extract((res) => res.asString);
    } finally {
      calloc.free(nativeNet);
    }
  }

  String unvote(
    SecpPublicKey senderPubKey,
    SecpPublicKey delegate,
    int nonce,
  ) {
    final nativeNet = network.networkNativeName.toNativeUtf8();
    try {
      return DartApi.native.hydraTx
          .unvote(
            nativeNet,
            senderPubKey.ffi,
            delegate.ffi,
            nonce,
          )
          .extract((res) => res.asString);
    } finally {
      calloc.free(nativeNet);
    }
  }
}
