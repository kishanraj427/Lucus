import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucus/utility/apiUrl.dart';
import 'exceptions.dart';

// Provider for auth token (replace with actual auth logic)
final authTokenProvider =
    Provider<String?>((ref) => null); // Mock; update with real token

// Dio provider for dependency injection
final dioProvider = Provider<Dio>((ref) {
  final dio = Dio(
    BaseOptions(
      baseUrl: ApiUrl.baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );

  // Add interceptors
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) {
        // Add auth token if available
        final token = ref.read(authTokenProvider);
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        handler.next(options);
      },
      onResponse: (response, handler) {
        handler.next(response);
      },
      onError: (DioException error, handler) {
        // Map Dio errors to custom exceptions
        final response = error.response;
        final message = response?.data is Map
            ? response?.data['error']?.toString()
            : error.message;
        switch (response?.statusCode) {
          case 401:
            throw UnauthorizedException(message: message, data: response?.data);
          case 404:
            throw NotFoundException(message: message, data: response?.data);
          case 500:
            throw ServerException(message: message, data: response?.data);
          default:
            throw ApiException(
              message: message ?? 'Unknown error',
              statusCode: response?.statusCode,
              data: response?.data,
            );
        }
      },
    ),
  );

  return dio;
});
