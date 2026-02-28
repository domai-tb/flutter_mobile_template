import 'package:dio/dio.dart';

import 'package:mobile_app_skeleton/core/environment_config.dart';
import 'package:mobile_app_skeleton/core/exceptions.dart';
import 'package:mobile_app_skeleton/core/logger.dart';

/// HTTP client wrapper using Dio for network requests.
///
/// Provides a configured Dio instance with:
/// - Base URL from environment configuration
/// - Timeout configuration
/// - Request/Response logging interceptors
/// - Error handling interceptors
///
/// Usage:
/// ```dart
/// final client = HttpClient();
/// final response = await client.get('/users');
/// ```
class HttpClient {
  late final Dio _dio;

  HttpClient({
    String? baseUrl,
    Duration? timeout,
    Map<String, String>? headers,
  }) {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl ?? EnvironmentConfig.apiBaseUrl,
        connectTimeout: timeout ??
            const Duration(milliseconds: EnvironmentConfig.apiTimeout),
        receiveTimeout: timeout ??
            const Duration(milliseconds: EnvironmentConfig.apiTimeout),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          ...?headers,
        },
      ),
    );

    _setupInterceptors();
  }

  /// Set up request/response interceptors for logging and error handling.
  void _setupInterceptors() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          AppLogger.d(
            'REQUEST[${options.method}] => ${options.uri}\n'
            'Headers: ${options.headers}\n'
            'Data: ${options.data}',
          );
          return handler.next(options);
        },
        onResponse: (response, handler) {
          AppLogger.d(
            'RESPONSE[${response.statusCode}] => ${response.requestOptions.uri}\n'
            'Data: ${response.data}',
          );
          return handler.next(response);
        },
        onError: (error, handler) {
          AppLogger.e(
            'ERROR[${error.response?.statusCode}] => ${error.requestOptions.uri}\n'
            'Message: ${error.message}\n'
            'Data: ${error.response?.data}',
            error: error,
          );
          return handler.next(error);
        },
      ),
    );
  }

  /// Perform a GET request.
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      return await _dio.get<T>(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// Perform a POST request.
  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      return await _dio.post<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// Perform a PUT request.
  Future<Response<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      return await _dio.put<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// Perform a PATCH request.
  Future<Response<T>> patch<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      return await _dio.patch<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// Perform a DELETE request.
  Future<Response<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      return await _dio.delete<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
    } on DioException catch (e) {
      throw _handleDioError(e);
    }
  }

  /// Handle Dio errors and convert them to domain exceptions.
  Exception _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const NoConnectionException(
          message: 'Connection timeout. Please check your internet connection.',
        );

      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        if (statusCode == 401 || statusCode == 403) {
          return const AuthenticationException(
            message: 'Authentication failed. Please log in again.',
          );
        } else if (statusCode == 429) {
          return const RateLimitException(
            message: 'Too many requests. Please try again later.',
          );
        } else if (statusCode != null && statusCode >= 500) {
          return ServerException(
            message: 'Server error occurred. Please try again later.',
            statusCode: statusCode,
          );
        }
        return ServerException(
          message: error.response?.statusMessage ?? 'Request failed',
          statusCode: statusCode,
        );

      case DioExceptionType.cancel:
        return const UnexpectedException(message: 'Request was cancelled');

      case DioExceptionType.connectionError:
        return const NoConnectionException(
          message: 'No internet connection. Please check your network.',
        );

      case DioExceptionType.badCertificate:
        return const ServerException(
          message: 'SSL certificate verification failed',
        );

      case DioExceptionType.unknown:
        return UnexpectedException(
          message: 'An unexpected error occurred',
          originalError: error,
        );
    }
  }

  /// Get the underlying Dio instance for advanced usage.
  Dio get dio => _dio;

  /// Add an interceptor to the Dio instance.
  void addInterceptor(Interceptor interceptor) {
    _dio.interceptors.add(interceptor);
  }

  /// Remove an interceptor from the Dio instance.
  void removeInterceptor(Interceptor interceptor) {
    _dio.interceptors.remove(interceptor);
  }

  /// Clear all interceptors.
  void clearInterceptors() {
    _dio.interceptors.clear();
  }
}
