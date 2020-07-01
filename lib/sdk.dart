abstract class ContentId {}

class MorpheusSigned<T> {}

// TODO work these out
class SignedHydraTransaction {
  String txContents;

  SignedHydraTransaction(this.txContents);

  @override
  String toString() {
    return '{"transactions":[$txContents]}';
  }
}
