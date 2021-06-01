import 'dart:io';
import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

typedef InjectRequest = void Function(
  RequestOptions options,
  RequestInterceptorHandler handler,
);
typedef InjectResponse = void Function(
  Response response,
  ResponseInterceptorHandler handler,
);
typedef InjectError = void Function(
  DioError dioError,
  ErrorInterceptorHandler handler,
);

class DSHttpInject {
  final InjectRequest onRequest;
  final InjectResponse onResponse;
  final InjectError onError;

  const DSHttpInject({this.onRequest, this.onResponse, this.onError});
}

class DSDioUtil {
  static final DSDioUtil _singleton = DSDioUtil._init();
  static Dio _dio;

  static DSDioUtil getInstance() {
    return _singleton;
  }

  factory DSDioUtil() {
    return _singleton;
  }

  ///
  /// Dio 初始化
  /// baseUrl           BASEURL,请求的基础url
  /// connectTimeout    连接超时时间(默认10s)
  /// receiveTimeout    接收超时时间(默认10s)
  /// inject            拦截处理
  /// proxyAddress      代理处理
  ///
  void init({
    @required String baseUrl,
    int connectTimeout = 1000 * 10,
    int receiveTimeout = 1000 * 10,
    DSHttpInject inject,
    String proxyAddress,
  }) {
    _dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: connectTimeout,
      receiveTimeout: receiveTimeout,
    ));
    if (inject != null) {
      _dio.interceptors.add(InterceptorsWrapper(
        onRequest: inject?.onRequest,
        onResponse: inject?.onResponse,
        onError: inject?.onError,
      ));
    }
    if (proxyAddress != null && proxyAddress.isNotEmpty) {
      (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
          (HttpClient client) {
        client.findProxy = (uri) {
          return 'PROXY $proxyAddress';
        };
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
      };
    }
  }

  DSDioUtil._init();

  ///
  /// GET 方法请求
  /// url                   请求的地址
  /// queryParameters       请求的参数信息
  /// options               每个请求独立的options
  /// cancelToken           取消请求的Token
  ///
  Future<dynamic> get(
    String url, {
    Map<String, dynamic> queryParameters,
    Options options,
    CancelToken cancelToken,
  }) async {
    if (_dio == null) {
      throw ErrorHint('Dio 未初始化,请先进行初始化');
    }
    Response response = await _dio.get(
      url,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
    return response.data;
  }

  ///
  /// POST 方法请求
  /// url                     请求的地址
  /// data                    请求Body中的数据
  /// queryParameters         请求From表单中的数据
  /// options                 每个请求独立的options
  /// cancelToken             取消请求的Token
  ///
  Future<dynamic> post(
    String url, {
    dynamic data,
    Map<String, dynamic> queryParameters,
    Options options,
    CancelToken cancelToken,
  }) async {
    if (_dio == null) {
      throw ErrorHint('Dio 未初始化,请先进行初始化');
    }
    Response<dynamic> response = await _dio.post(
      url,
      data: data,
      queryParameters: queryParameters,
      options: options,
      cancelToken: cancelToken,
    );
    if (response.statusCode == HttpStatus.ok ||
        response.statusCode == HttpStatus.created) {
      return response.data;
    }
    //可以抛出一个特定的异常信息
    return response.data;
  }
}
