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


abstract class TransactionId {}

// TODO work this out
abstract class HydraTransactionBuilder {}

// TODO work this out
abstract class MorpheusOperationBuilder {}

abstract class Layer1 {
    Layer1(Network network);

    bool getTransactionStatus(TransactionId txId);

    // TODO is it possible to` implement sendTransferTx() and sendMorpheusTx() here?
    // TODO getWallet(nonce/balance/etc), sendTx(RawTxJson), getCurrentHeight()
}