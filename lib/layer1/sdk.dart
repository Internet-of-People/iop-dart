abstract class ContentId {}

class MorpheusSigned<T> {}

class SignedHydraTransaction {
  final String _txContents;

  SignedHydraTransaction(this._txContents);

  Map<String, dynamic> toJson() {
    return {
      'transactions': [_txContents]
    };
  }
}
