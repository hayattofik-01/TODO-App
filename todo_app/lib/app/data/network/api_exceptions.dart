class ApiException implements Exception {
  final dynamic _message;
  final dynamic _prefix;

  ApiException([this._message, this._prefix]);

  @override
  String toString() {
    return '$_prefix$_message';
  }
}

class InternetException extends ApiException {
  InternetException([String? message]) : super(message, 'No Internet : ');
}

class ServerException extends ApiException {
  ServerException([String? message]) : super(message, 'Internal Server Error : ');
}
class NetworkException extends ApiException {
  NetworkException([String? message]) : super(message, 'Network Error: ');
}
class RequestTimeoutException extends ApiException {
  RequestTimeoutException([String? message]) : super(message, 'Request Time Out : ');
}
