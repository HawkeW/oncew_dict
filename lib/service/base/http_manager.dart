import 'package:dio/dio.dart';
import 'code.dart';
import 'loading.dart';
import 'request_interceptor.dart';
import './response_interceptor.dart';
import 'result_data.dart';

typedef HttpGet = Future<ResultData> Function(
  dynamic api, {
  Map<String, dynamic>? params,
  bool withLoading,
  bool showErrMsg,
  CancelToken? cancelToken,
});

typedef HttpPost = Future<ResultData> Function(String api,
    {Map<String, dynamic>? params,
    bool withLoading,
    bool showErrMsg,
    CancelToken? cancelToken});

class HttpManager {
  static HttpManager _instance = HttpManager._internal();
  Dio? _dio;

  static const CODE_SUCCESS = 200;
  static const CODE_TIME_OUT = -1;
  static const CONNECT_TIMEOUT = 35000;
  static const SLAM_CONNECT_TIMEOUT = 1100;

  factory HttpManager() => _instance;

  ///通用全局单例，第一次使用时初始化
  HttpManager._internal({String? baseUrl}) {
    if (null == _dio) {
      _dio = Dio(BaseOptions(
        baseUrl: baseUrl ?? '',
        connectTimeout: const Duration(milliseconds: CONNECT_TIMEOUT),
        contentType: Headers.formUrlEncodedContentType,
      ));
      _dio!.interceptors.add(new RequestInterceptor());

      _dio!.interceptors.add(new ResponseInterceptors());
    }
  }

  static HttpManager getInstance({String? baseUrl}) {
    if (baseUrl == null) {
      return _instance._normal();
    } else {
      return _instance._baseUrl(baseUrl);
    }
  }

  //用于指定特定域名
  HttpManager _baseUrl(String baseUrl) {
    if (_dio != null) {
      _dio!.options.baseUrl = baseUrl;
    }
    return this;
  }

  //一般请求，默认域名
  HttpManager _normal() {
    if (_dio != null) {}
    return this;
  }

  ///通用的GET请求
  Future<ResultData> get(api,
      {Map<String, dynamic>? params,
      withLoading = true,
      showErrMsg = true,
      CancelToken? cancelToken}) async {
    if (withLoading) {
      Loading.show();
    }

    Response response;
    try {
      _dio!.options.extra["showErrMsg"] = showErrMsg; // 是否显示错误弹窗
      response = await _dio!
          .get(api, queryParameters: params, cancelToken: cancelToken);
      if (withLoading) {
        Loading.dismiss();
      }
    } on DioError catch (e) {
      if (withLoading) {
        Loading.dismiss();
      }
      return resultError(e);
    }

    if (response.data is DioError) {
      return resultError(response.data['status']);
    }

    return response.data;
  }

  ///通用的POST请求
  Future<ResultData> post(String api,
      {params,
      withLoading = true,
      showErrMsg = true,
      CancelToken? cancelToken}) async {
    if (withLoading) {
      Loading.show();
    }

    Response response;
    try {
      _dio!.options.extra["showErrMsg"] = showErrMsg; // 是否显示错误弹窗

      response = await _dio!.post(api, data: params, cancelToken: cancelToken);

      if (withLoading) {
        Loading.dismiss();
      }
    } on DioError catch (e) {
      if (withLoading) {
        Loading.dismiss();
      }
      return resultError(e);
    }

    if (response.data is DioError) {
      return resultError(response.data['status']);
    }

    return response.data;
  }
}

ResultData resultError(DioError e) {
  Response? errorResponse;
  if (e.response != null) {
    errorResponse = e.response;
  } else {
    errorResponse =
        new Response(statusCode: 666, requestOptions: e.requestOptions);
  }
  if (e.type == DioExceptionType.connectionTimeout ||
      e.type == DioExceptionType.receiveTimeout) {
    errorResponse!.statusCode = Code.NETWORK_TIMEOUT;
  } else if (e.type == DioExceptionType.cancel) {
    errorResponse!.statusCode = Code.CANCEL;
  }
  return ResultData(
      errorResponse!.statusMessage,
      errorResponse.data != null &&
              errorResponse.data != null &&
              errorResponse.data is! String
          ? errorResponse.data.message
          : "",
      false,
      errorResponse.statusCode);
}
