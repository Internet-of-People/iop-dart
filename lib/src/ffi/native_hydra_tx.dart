import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'package:iop_sdk/src/ffi/ffi.dart';

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

typedef NHydraVoteTx = Pointer<Result> Function(
  Pointer<Utf8> network,
  Pointer<Utf8> senderPubKey,
  Pointer<Utf8> delegate,
  Int64 nonce,
);
typedef DHydraVoteTx = Pointer<Result> Function(
  Pointer<Utf8> network,
  Pointer<Utf8> senderPubKey,
  Pointer<Utf8> delegate,
  int nonce,
);

typedef NHydraUnvoteTx = Pointer<Result> Function(
  Pointer<Utf8> network,
  Pointer<Utf8> senderPubKey,
  Pointer<Utf8> delegate,
  Int64 nonce,
);
typedef DHydraUnvoteTx = Pointer<Result> Function(
  Pointer<Utf8> network,
  Pointer<Utf8> senderPubKey,
  Pointer<Utf8> delegate,
  int nonce,
);


class NativeHydraTx {
  final DHydraTransferTx transfer;
  final DHydraVoteTx vote;
  final DHydraUnvoteTx unvote;

  NativeHydraTx(DynamicLibrary lib) :
    transfer = lib.lookupFunction<NHydraTransferTx, DHydraTransferTx>(
      'HydraTxBuilder_transfer',
    ),
    vote = lib.lookupFunction<NHydraVoteTx, DHydraVoteTx>(
      'HydraTxBuilder_vote',
    ),
    unvote = lib.lookupFunction<NHydraUnvoteTx, DHydraUnvoteTx>(
      'HydraTxBuilder_unvote',
    );
}
