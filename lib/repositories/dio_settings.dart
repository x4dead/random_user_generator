// ignore_for_file: avoid_print

import 'package:dio/dio.dart';

class DioSettings {
  DioSettings() {
    setup();
  }

  final dio = Dio(
    BaseOptions(
      baseUrl: 'https://randomuser.me/',
      connectTimeout: 15000,
    ),
  );

  void setup() {
    final interceptor = dio.interceptors;
    interceptor.clear();
    final headerInterceptor = InterceptorsWrapper(
      onRequest: (options, handler) {
        print('ON REQUIEST');
        return handler.next(options);
      },
      onError: (DioError error, handler) {
        print('ON ERROR');
        handler.next(error);
      },
    );

    interceptor.addAll(
      [headerInterceptor],
    );
  }
}
