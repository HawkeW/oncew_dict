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

  // 批量删除用户词书
  static Future<ResultData> batchDeleteWordBook(Map<String, dynamic> data) {
    return _post("/word_book/delete/list", params: data);
  }

  // 添加单词到词书
  static Future<ResultData> addWordToWordBook(Map<String, dynamic> data) {
    return _post("/word_book/add_words", params: data);
  }

  // 获取用户词书的单词
  static Future<ResultData> getWordsInWordBook(Map<String, dynamic> data) {
    return _get("/word_book/words", params: data);
  }

  // 获取单词详情
  static Future<ResultData> getWordDetail(Map<String, dynamic> data) {
    return _get("/word/details", params: data);
  }

  // 搜索单词
  static Future<ResultData> searchWords(Map<String, dynamic> data) {
    return _get("/word/search", params: data);
  }
}
