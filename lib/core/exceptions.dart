/// Response status code is not 200.
class ServerException implements Exception {
  final String? message;
  final int? statusCode;

  const ServerException({this.message, this.statusCode});

  @override
  String toString() =>
      'ServerException: ${message ?? 'Server error'} (status: $statusCode)';
}

/// Failed to parse response data.
class ParseException implements Exception {
  final String? message;

  const ParseException({this.message});

  @override
  String toString() => 'ParseException: ${message ?? 'Failed to parse data'}';
}

/// Expected response is not existing or empty.
class EmptyResponseException implements Exception {
  final String? message;

  const EmptyResponseException({this.message});

  @override
  String toString() =>
      'EmptyResponseException: ${message ?? 'Empty or missing response'}';
}

/// Generic authentication error (e.g. invalid credentials / expired session).
class AuthenticationException implements Exception {
  final String? message;

  const AuthenticationException({this.message});

  @override
  String toString() =>
      'AuthenticationException: ${message ?? 'Authentication failed'}';
}

/// Object is not valid JSON.
class JsonException implements Exception {
  final String? message;

  const JsonException({this.message});

  @override
  String toString() => 'JsonException: ${message ?? 'Invalid JSON format'}';
}

/// Some unexpected error occurred.
class UnexpectedException implements Exception {
  final String? message;
  final Object? originalError;

  const UnexpectedException({this.message, this.originalError});

  @override
  String toString() =>
      'UnexpectedException: ${message ?? 'An unexpected error occurred'}'
      '${originalError != null ? ' (caused by: $originalError)' : ''}';
}

/// No connection to a remote dependency.
class NoConnectionException implements Exception {
  final String? message;

  const NoConnectionException({this.message});

  @override
  String toString() =>
      'NoConnectionException: ${message ?? 'No network connection'}';
}

/// Too many requests to a remote dependency (rate limited).
class RateLimitException implements Exception {
  final String? message;
  final Duration? retryAfter;

  const RateLimitException({this.message, this.retryAfter});

  @override
  String toString() => 'RateLimitException: ${message ?? 'Rate limit exceeded'}'
      '${retryAfter != null ? ' (retry after: $retryAfter)' : ''}';
}
