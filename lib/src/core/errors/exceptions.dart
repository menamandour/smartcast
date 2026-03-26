class ServerException implements Exception {
  final String message;
  final String? code;

  ServerException({required this.message, this.code});

  @override
  String toString() => 'ServerException: $message (code: $code)';
}

class NetworkException implements Exception {
  final String message;

  NetworkException({required this.message});

  @override
  String toString() => 'NetworkException: $message';
}

class CacheException implements Exception {
  final String message;

  CacheException({required this.message});

  @override
  String toString() => 'CacheException: $message';
}

class ValidationException implements Exception {
  final String message;

  ValidationException({required this.message});

  @override
  String toString() => 'ValidationException: $message';
}

class UnknownException implements Exception {
  final String message;

  UnknownException({required this.message});

  @override
  String toString() => 'UnknownException: $message';
}
