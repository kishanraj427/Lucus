class ApiException implements Exception {
  final String message;
  final int? statusCode;
  final dynamic data;

  const ApiException({
    required this.message,
    this.statusCode,
    this.data,
  });

  @override
  String toString() => 'ApiException: $message (Status: $statusCode)';
}

class UnauthorizedException extends ApiException {
  const UnauthorizedException({String? message, super.data})
      : super(message: message ?? 'Unauthorized', statusCode: 401);
}

class NotFoundException extends ApiException {
  const NotFoundException({String? message, super.data})
      : super(message: message ?? 'Resource not found', statusCode: 404);
}

class ServerException extends ApiException {
  const ServerException({String? message, super.data})
      : super(message: message ?? 'Server error', statusCode: 500);
}
