import 'package:oncew_dict/service/url_path.dart';

import '../base/base.dart';

class WordService {
  static HttpGet get _get =>
      HttpManager.getInstance(baseUrl: UrlPath.BASE_URL).get;

  static HttpPost get _post =>
      HttpManager.getInstance(baseUrl: UrlPath.BASE_URL).post;

  // 获取用户词书列表
  static Future<ResultData> getUserWorkBooks(int userId) {
    return _get("/word_book/by_user", params: {"user_id": userId});
  }

  // 获取用户词书列表
  static Future<ResultData> createWordBook(Map<String, dynamic> data) {
    return _get("/word_book/create", params: data);
  }
}
