import 'crypto.dart';
import 'layer1.dart';
import 'sdk.dart';

abstract class BeforeProofHistory {
    ContentId contentId;
    BeforeProofHistory(this.contentId);

    bool existsAtHeight(int blockHeight);
}

abstract class DidDocument {
  bool hasRightAt(String auth, String right, int height);
  bool isTombstonedAt(int height);
}


abstract class Layer2 {
    Layer2(Network network);

    BeforeProofHistory getBeforeProofHistory(ContentId contentId);

    DidDocument getDidDocument(Did did);
    TransactionId getLastTransactionId(Did did);
    bool getTransactionStatus(TransactionId txId);
}
