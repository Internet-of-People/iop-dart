abstract class ContentId {}

// TODO work these out
class SignedHydraTransaction {
    String txContents;
    SignedHydraTransaction(this.txContents);
    @override String toString() { return txContents; }
}
class MorpheusSigned<T> {}
