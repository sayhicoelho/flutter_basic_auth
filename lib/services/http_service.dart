import 'package:dio/dio.dart';
import 'package:flutter_basic_auth/config/app.dart';

abstract class HttpService {
  static const int TIMEOUT = Config.REQUEST_TIMEOUT;
  static final Dio _dio = Dio();

  static void setTimeouts() {
    _dio.options.connectTimeout = TIMEOUT;
    _dio.options.receiveTimeout = TIMEOUT;
    _dio.options.sendTimeout = TIMEOUT;
  }

  static void setBaseUrl(String url) {
    _dio.options.baseUrl = url;
  }

  static void setToken(String token) {
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }

  static void unsetToken() {
    _dio.options.headers.remove('Authorization');
  }

  static Future<Response> get(String url, {Map<String, dynamic> queryParameters}) {
    return _dio.get(url, queryParameters: queryParameters);
  }

  static Future<Response> post(String url, {Map data}) {
    return _dio.post(url, data: data);
  }

  static Future<Response> put(String url, {Map data}) {
    return _dio.put(url, data: data);
  }

  static Future<Response> patch(String url, {Map data}) {
    return _dio.patch(url, data: data);
  }

  static Future<Response> delete(String url, {Map data}) {
    return _dio.delete(url, data: data);
  }
}
