import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'client.dart';

class SessionHandler {
  final Dio _dio;

  SessionHandler(this._dio);

  /// Generic GET request
  Future<T> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    T Function(dynamic)? fromJson,
    Options? options,
  }) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
      );
      return _processResponse(response, fromJson);
    } catch (e) {
      rethrow; // Let exceptions propagate
    }
  }

  /// Generic POST request
  Future<T> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    T Function(dynamic)? fromJson,
    Options? options,
  }) async {
    try {
      final response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return _processResponse(response, fromJson);
    } catch (e) {
      rethrow;
    }
  }

  /// Generic PUT request
  Future<T> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    T Function(dynamic)? fromJson,
    Options? options,
  }) async {
    try {
      final response = await _dio.put(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return _processResponse(response, fromJson);
    } catch (e) {
      rethrow;
    }
  }

  /// Generic DELETE request
  Future<T> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    T Function(dynamic)? fromJson,
    Options? options,
  }) async {
    try {
      final response = await _dio.delete(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );
      return _processResponse(response, fromJson);
    } catch (e) {
      rethrow;
    }
  }

  /// Process response and apply optional JSON parsing
  T _processResponse<T>(Response response, T Function(dynamic)? fromJson) {
    final data = response.data;
    if (fromJson != null && data != null) {
      return fromJson(data);
    }
    return data as T;
  }
}

// Riverpod provider for SessionHandler
final sessionHandlerProvider = Provider<SessionHandler>((ref) {
  final dio = ref.watch(dioProvider);
  return SessionHandler(dio);
});
