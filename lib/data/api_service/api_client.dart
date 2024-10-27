import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ApiClient {
  late Dio _dio;
  ApiClient() {
    BaseOptions options = BaseOptions(
      baseUrl: 'https://movies-api14.p.rapidapi.com/',
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
      headers: {
        'x-rapidapi-key': '2bdbd45160msh58a2783e00c08d7p100e4bjsn90702fb8a69d',
      },
    );
    InterceptorsWrapper interceptor = InterceptorsWrapper(
      onRequest: (options, handler){
        debugPrint('Request: ${options.method} ${options.path}');
        debugPrint('Headers: ${options.headers}');
        debugPrint('Query Params: ${options.queryParameters}');
        handler.next(options);
      },
      onResponse: (response, handler){
        debugPrint('Response: ${response.statusCode} ${response.data}');
        handler.next(response);
      },
      onError: (error, handler){
        debugPrint('Error: ${error.message}');
        handler.next(error);
      },
    );
    _dio = Dio(options);
    _dio.interceptors.add(interceptor);
  }

  Future<Response> getMovies(){
    return _dio.get('movies');
  }
  Future<Response<List>> getHome(){
    return _dio.get('home');
  }
}