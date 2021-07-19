// An exception class used to throw when a http request fails with a custom message.
class HttpException implements Exception {
  final String message;

  HttpException(this.message);

  @override
  String toString() {
    return message;
  }
}