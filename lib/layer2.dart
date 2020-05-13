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

    Future<BeforeProofHistory> getBeforeProofHistory(ContentId contentId);

    Future<DidDocument> getDidDocument(Did did);
    Future<TransactionId> getLastTransactionId(Did did);
    Future<bool> getTransactionStatus(TransactionId txId);
}
