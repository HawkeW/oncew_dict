import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'code.dart';
import 'result_data.dart';

/// 数据初步处理
class ResponseInterceptors extends InterceptorsWrapper {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    var token = "";
    options.headers["token"] = token;
    handler.next(options);
    return;
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.requestOptions.extra["showErrMsg"] &&
        err.type != DioExceptionType.cancel) {
      debugPrint("请求失败${err.message?.toString() ?? "异常"}");
    }

    super.onError(err, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    try {
      ///一般只需要处理200的情况，300、400、500保留错误信息，外层为http协议定义的响应码
      if (response.statusCode == 200 || response.statusCode == 201) {
        int? status;
        String? msg;
        final a = response.data;
        if (a is String) {
          status = -1;
          msg = a;
        } else {
          status = response.data["code"];
          msg = response.data["msg"];
        }

        switch (status) {
          case 0:
          case 2:
            // 请求成功
            response.data = ResultData(response.data, msg, true, 200,
                headers: response.headers);
            handler.next(response);
            break;
          case 999:
            response.data = ResultData(response.data, msg, false, 200,
                headers: response.headers);
            handler.next(response);
            break;
          default:
            // 异常处理
            handleError(response, handler, msg);
            break;
        }
        return;
      }
    } catch (e) {
      final String? msg = response.data["message"];
      response.data = ResultData(response.data, msg, false, response.statusCode,
          headers: response.headers);
      handler.next(response);
      return;
    }

    response.data = ResultData(response.data, '', false, response.statusCode,
        headers: response.headers);
    handler.next(response);
  }

  void handleError(
      Response response, ResponseInterceptorHandler handler, String? errorMsg) {
    if (response.requestOptions.extra["showErrMsg"] &&
        response.statusCode != Code.CANCEL &&
        errorMsg != null) {
      debugPrint(errorMsg);
    }

    response.data = ResultData(response.data, errorMsg, false, 200,
        headers: response.headers);
    handler.next(response);
  }
}
