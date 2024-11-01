import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ApiClient {
  late Dio _dio;
  ApiClient() {
    BaseOptions options = BaseOptions(
      baseUrl: 'https://movies-api14.p.rapidapi.com/',
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
      headers: {
        'x-rapidapi-key': '2bdbd45160msh58a2783e00c08d7p100e4bjsn90702fb8a69d',
      },
    );
    InterceptorsWrapper interceptor = InterceptorsWrapper(
      onRequest: (options, handler) {
        debugPrint('Request: ${options.method} ${options.path}');
        debugPrint('Headers: ${options.headers}');
        debugPrint('Query Params: ${options.queryParameters}');
        return handler.next(options);
      },
      onResponse: (response, handler) {
        debugPrint('Response: ${response.statusCode} ${response.data}');
        return handler.next(response);
      },
      onError: (error, handler) async{
        debugPrint('Error: ${error.message}');
        int retryCount = 0;
        int maxRetries = 3;
        while(retryCount < maxRetries && error.type == DioExceptionType.connectionTimeout) {
          retryCount++;
          try {
            print('Connection timeout, retrying...');
            final res = await _dio.request(error.requestOptions.path);
            return handler.resolve(res);
          } catch (e) {
            print(e.toString());
          }
        }
        return handler.next(error);
      },
    );
    _dio = Dio(options);
    _dio.interceptors.add(interceptor);
  }

  Future<Response> getMovies() => _dio.get('movies');

  Future<Response<List>> getHome() => _dio.get('home');

  Future<Response> getSearchResponse(String query) { 
    return _dio.get(
        'search',
        queryParameters: {'query': query},
      );
  }
  Future<Response> getMovieDetails(int movieId) => _dio.get('movie/$movieId');
}
