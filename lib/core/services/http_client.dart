import 'package:dio/dio.dart';

class HttpService {
  final _dio = Dio();
  String baseUrl = 'https://pokeapi.co/api/v2';

  HttpService() {
    _dio.options.baseUrl = baseUrl;

    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        return handler.next(options);
      },
      onResponse: (response, handler) {
        return handler.next(response);
      },
      onError: (DioException err, handler) {
        return handler.next(err);
      },
    ));
  }
  Dio get dio => _dio;
}
