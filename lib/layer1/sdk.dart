import 'dart:convert';

abstract class ContentId {}

class MorpheusSigned<T> {}

class SignedHydraTransaction {
  final String _txContents;

  SignedHydraTransaction(this._txContents);

  @override
  String toString() {
    final content = json.decode(_txContents);
    return json.encode({
      'transactions': [content],
    });
  }
}
