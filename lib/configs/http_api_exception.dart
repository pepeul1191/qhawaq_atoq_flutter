class HttpApiException implements Exception {
  final int code;
  final String message;

  HttpApiException(this.code, this.message);

  @override
  String toString() {
    return 'HTTPException - code: $code \n message: \n $message';
  }
}
