import 'package:dio/dio.dart';
import 'package:qna_frontend/core/constants/api_constants.dart';

/// Service responsible for handling HTTP requests using Dio.
///
/// This service is configured with a base URL and default timeouts.
/// It also includes a [LogInterceptor] for debugging purposes.
class ApiService {
  late final Dio _dio;

  /// Initializes the Dio instance with default options.
  ///
  /// We use a 30-second timeout to accommodate potentially slow
  /// backend operations like embedding or LLM inference.
  ApiService() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );

    // Add logging to help debug API issues during development.
    _dio.interceptors.add(LogInterceptor(
      request: true,
      requestBody: true,
      responseBody: true,
      error: true,
    ));
  }

  /// Exposes the underlying Dio instance for making requests.
  Dio get dio => _dio;
}
