import 'package:meta/meta.dart';

import 'crypto.dart';
import 'sdk.dart';


// TODO should these be moved to types instead?
enum Network {
    LocalTestNet,
    TestNet,
    DevNet,
    MainNet,
}

extension NetworkProperties on Network {
    String get seedServerUrl => const {
        Network.LocalTestNet: 'http://127.0.0.1',
        Network.TestNet: 'http://35.187.56.222',
        Network.DevNet: 'http://35.240.62.119',
        Network.MainNet: 'http://35.195.150.223',
    }[this];
}

// TODO what goes here?
class HydraAddress {
    HydraAddress(String address) { throw UnimplementedError(); }
}
abstract class TransactionId {}
//class TransactionId {
//    TransactionId(String txId) { throw UnimplementedError(); }
//    @override String toString() { throw UnimplementedError(); }
//}

// TODO work this out
abstract class Transaction {}

class HydraTransferTransaction extends Transaction {
    HydraTransferTransaction({
        @required HydraAddress toAddress,
        @required BigInt flakes,
        BigInt fee,
        // TODO hexencoded binary
        // String vendorField,
    }) { throw UnimplementedError(); }
    @override String toString() { throw UnimplementedError(); }
}

// TODO this will belong to a Hydra subtree interface of Vault after subtrees are implemented
extension HydraTransactionSignatures on Vault {
    Future<SignedHydraTransaction> signHydraTransfer(HydraTransferTransaction tx, HydraAddress senderAddress)
        { throw UnimplementedError(); }
    Future<SignedHydraTransaction> signMorpheusTransaction(MorpheusTransaction tx, HydraAddress gasAddress)
        { throw UnimplementedError(); }
}


// TODO work this out
class MorpheusOperationAttempt {}
class MorpheusSignableOperationAttempt extends MorpheusOperationAttempt {}
class MorpheusOperationBuilder {}
class MorpheusTransaction extends Transaction {
    @override String toString() { throw UnimplementedError(); }
}
class MorpheusTransactionBuilder {}

// TODO this will belong to a Hydra subtree interface of Vault after subtrees are implemented
extension MorpheusTransactionSignatures on Vault {
    Future<MorpheusSigned<MorpheusSignableOperationAttempt>> signDidOperation
        (MorpheusSignableOperationAttempt tx, Authentication authentication)
    { throw UnimplementedError(); }
}


class Layer1 {
    Layer1(Network network);

    Future<bool> getTransactionStatus(TransactionId txId) async { throw UnimplementedError(); }

    Future<TransactionId> sendTransaction(SignedHydraTransaction hydraTx) async { throw UnimplementedError(); }

    // TODO implement sendTransferTx() and sendMorpheusTx() here
    // TODO getWallet(nonce/balance/etc), sendTx(RawTxJson), getCurrentHeight()
}