class HttpResponseError {
  HttpResponseError(this.code, this.message);

  final int code;
  final String message;

  @override
  String toString() {
    return '${'ErrorCode: $code\n Message: $message'}';
  }
}
