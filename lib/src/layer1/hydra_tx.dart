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
    final nativeNet = Utf8.toUtf8(network.networkNativeName);
    final nativeSender = Utf8.toUtf8(senderPubKey.toString());
    final nativeRecipient = Utf8.toUtf8(recipient);
    try {
      return DartApi.native.hydraTx
          .transfer(
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

  String Vote(
    SecpPublicKey senderPubKey,
    SecpPublicKey delegate,
    int nonce,
  ) {
    final nativeNet = Utf8.toUtf8(network.networkNativeName);
    final nativeSender = Utf8.toUtf8(senderPubKey.toString());
    final nativeDelegate = Utf8.toUtf8(delegate.toString());
    try {
      return DartApi.native.hydraTx
          .vote(
            nativeNet,
            nativeSender,
            nativeDelegate,
            nonce,
          )
          .extract((res) => res.asString);
    } finally {
      free(nativeDelegate);
      free(nativeSender);
      free(nativeNet);
    }
  }

  String unvote(
    SecpPublicKey senderPubKey,
    SecpPublicKey delegate,
    int nonce,
  ) {
    final nativeNet = Utf8.toUtf8(network.networkNativeName);
    final nativeSender = Utf8.toUtf8(senderPubKey.toString());
    final nativeDelegate = Utf8.toUtf8(delegate.toString());
    try {
      return DartApi.native.hydraTx
          .unvote(
            nativeNet,
            nativeSender,
            nativeDelegate,
            nonce,
          )
          .extract((res) => res.asString);
    } finally {
      free(nativeDelegate);
      free(nativeSender);
      free(nativeNet);
    }
  }
}
