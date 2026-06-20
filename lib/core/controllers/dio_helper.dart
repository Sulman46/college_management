import 'dart:developer';
import 'package:college_management/core/helper/share_pref/auth_sharepref_helper.dart';
import 'package:college_management/core/helper/show_message.dart';
import 'package:dio/dio.dart';
import 'package:college_management/core/constants/app_apis.dart';
import 'package:flutter/cupertino.dart';

class DioHelper {
  static Dio _dio = Dio();
  final String _baseUrl = AppApis.baseUrl;
  final Duration _connectTimeout = Duration(seconds: 10); // 5 seconds
  final Duration _receiveTimeout = Duration(seconds: 10); // 3 seconds

  DioHelper._internal() {
    _dio = Dio(BaseOptions(
      baseUrl: _baseUrl,
      connectTimeout: _connectTimeout,
      receiveTimeout: _receiveTimeout,
    ));

    // Add interceptors (logging, error handling)
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async{
        String? token=await AuthShareprefHelper.getToken();
        if(token!=null){
          options.headers['Authorization'] =
          'Bearer $token';
        }
        // print('Request: ${options.method} ${options.uri}');
        return handler.next(options); // Proceed with the request
      },
      onResponse: (response, handler) {
        // print('Response: ${response.statusCode} ${response.data}');
        return handler.next(response); // Proceed with the response
      },
      onError: (DioError error, handler) {
        // print('Error: ${error.message}');
        return handler.next(error); // Proceed with the error
      },
    ));
  }

  // Singleton instance accessor
  factory DioHelper() {
    return DioHelper._internal();
  }

  // POST method with improved error handling
  Future<Response> post(String endpoint, {Map<String, dynamic>? data}) async {
    try {
      // Make POST request
      Response response = await _dio.post(endpoint, data: data);

      // Check if response status is not 2xx (client or server error)
      if (response.statusCode! < 200 || response.statusCode! >= 300) {
        log("345678989 error: ${response.statusCode} ${response.statusMessage}");
        return _handleApiError(response);
      }

      return response; // Return response if status is in 2xx range
    } on DioError catch (e) {
      log("@#43242: $e");
      // Handle DioError exceptions like timeouts, network issues, etc.
      return _handleError(e);
    }
  }
  Future<Response> postWithFile(String endpoint, {FormData? data}) async {
    try {
      // Make POST request
      Response response = await _dio.post(endpoint, data: data,options: Options(
        contentType: 'multipart/form-data',
      ),);

      // Check if response status is not 2xx (client or server error)
      if (response.statusCode! < 200 || response.statusCode! >= 300) {
        log("345678989 error: ${response.statusCode} ${response.statusMessage}");
        return _handleApiError(response);
      }
      return response; // Return response if status is in 2xx range
    } on DioError catch (e) {
      // Handle DioError exceptions like timeouts, network issues, etc.
      return _handleError(e);
    }
  }


  Future<Response> putWithFile(String endpoint, {FormData? data}) async {
    try {
      // Make POST request
      Response response = await _dio.put(endpoint, data: data,options: Options(
        contentType: 'multipart/form-data',
      ),);

      // Check if response status is not 2xx (client or server error)
      if (response.statusCode! < 200 || response.statusCode! >= 300) {
        log("345678989 error: ${response.statusCode} ${response.statusMessage}");
        return _handleApiError(response);
      }
      return response; // Return response if status is in 2xx range
    } on DioError catch (e) {
      // Handle DioError exceptions like timeouts, network issues, etc.
      return _handleError(e);
    }
  }

  // Put method with improved error handling
  Future<Response> put(String endpoint, {Map<String, dynamic>? data}) async {
    try {
      // Make POST request
      Response response = await _dio.put(endpoint, data: data);

      // Check if response status is not 2xx (client or server error)
      if (response.statusCode! < 200 || response.statusCode! >= 300) {
        log("345678989 error: ${response.statusCode} ${response.statusMessage}");
        return _handleApiError(response);
      }

      return response; // Return response if status is in 2xx range
    } on DioError catch (e) {
      // Handle DioError exceptions like timeouts, network issues, etc.
      return _handleError(e);
    }
  }

  // Get method with improved error handling
  Future<Response> get(String endpoint, {Map<String, dynamic>? data,Map<String, dynamic>? queryParameters}) async {
    try {
      // Make POST request
      Response response = await _dio.get(endpoint, data: data,queryParameters: queryParameters);

      // Check if response status is not 2xx (client or server error)
      if (response.statusCode! < 200 || response.statusCode! >= 300) {
        log("2365945678: ${response.statusCode} ${response.statusMessage}");
        return _handleApiError(response);
      }

      return response; // Return response if status is in 2xx range
    } on DioError catch (e) {
      // Handle DioError exceptions like timeouts, network issues, etc.
      return _handleError(e);
    }
  }

  // delete method with improved error handling
  Future<Response> delete(String endpoint, {Map<String, dynamic>? data}) async {
    try {
      // Make POST request
      Response response = await _dio.delete(endpoint, data: data);

      // Check if response status is not 2xx (client or server error)
      if (response.statusCode! < 200 || response.statusCode! >= 300) {
        log("34763796789: ${response.statusCode} ${response.statusMessage}");
        return _handleApiError(response);
      }

      return response; // Return response if status is in 2xx range
    } on DioError catch (e) {
      // Handle DioError exceptions like timeouts, network issues, etc.
      return _handleError(e);
    }
  }

  // Handle general DioError (network, timeouts, etc.)
  Response _handleError(DioError error) {
    String errorMessage = '';
    int statusCode = error.response?.statusCode ?? 500;

    if (error.type == DioErrorType.connectionTimeout) {
      errorMessage = 'Connection Timeout: Unable to connect to the server.';
    } else if (error.type == DioErrorType.receiveTimeout) {
      errorMessage = 'Receive Timeout: The server took too long to respond.';
    }else if (error.type == DioErrorType.connectionError) {
      errorMessage = 'Unable to establish a connection to the server.';
    }
    else if (error.type == DioErrorType.cancel) {
      errorMessage = 'Request Cancelled';
    }
    else if (error.type==DioExceptionType.badResponse) {
      // For 4xx or 5xx errors, extract error message from the response
      errorMessage = 'API Error: ${error.response?.data ?? "Unknown Error"}';
    }
    else {
      errorMessage = 'Unexpected Error: ${error.message}';
    }

    // Return a generic error response
    return Response(
      data: error.response?.data??null,
      requestOptions: error.requestOptions,
      statusCode: statusCode,
      statusMessage: errorMessage,
    );
  }

  // Handle API-specific errors (4xx, 5xx)
  Response _handleApiError(Response response) {
    String errorMessage = 'Unknown API error';

    // Extract specific error messages from the response body (for validation errors, etc.)
    if (response.data != null && response.data is Map) {
      var data = response.data;
      errorMessage = data['message'] ?? data['error']?? 'An error occurred';
    }

    // Log the API error for debugging
    log('API Error: $errorMessage, StatusCode: ${response.statusCode}');

    // Return the error as a Response
    return Response(
      requestOptions: response.requestOptions,
      statusCode: response.statusCode,
      statusMessage: errorMessage,
      data: response.data, // Include error data in the response
    );
  }
}
