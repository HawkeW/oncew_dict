import 'package:oncew_dict/service/url_path.dart';

import '../base/base.dart';

class UserService {
  static HttpGet get _get =>
      HttpManager.getInstance(baseUrl: UrlPath.BASE_URL).get;

  static HttpPost get _post =>
      HttpManager.getInstance(baseUrl: UrlPath.BASE_URL).post;

  // 简易版登陆
  static Future<ResultData> login(String phone, String password) {
    return _post("/user/login", params: {"phone": phone, "password": password});
  }
}
