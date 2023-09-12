class ResultData {
  dynamic data;
  bool isSuccess;
  int? status;
  dynamic headers;
  String? message;

  ResultData(this.data, this.message, this.isSuccess, this.status,
      {this.headers});

  @override
  String toString() {
    return 'ResultData{data: $data, isSuccess: $isSuccess, status: $status, headers: $headers, message: $message}';
  }
}
