class HttpResponseError {
  HttpResponseError(this.code, this.message, {this.method});

  final String method;
  final int code;
  final String message;

  @override
  String toString() {
    final content = method == null ? '' : 'Method: $method\n';
    return '$content${'ErrorCode: $code\n Message: $message'}';
  }
}
