enum Status { success, loading, error, timeout, internetError }

class NetworkResponse {
  final Status status;
  final Map<String, dynamic>? data;
  final String? message;
  NetworkResponse(this.status, this.data, this.message);

  static NetworkResponse success(data) {
    return NetworkResponse(Status.success, data, null);
  }

  static NetworkResponse error({data, String? message}) {
    return NetworkResponse(Status.error, data, message);
  }

  static NetworkResponse internetError() {
    return NetworkResponse(Status.internetError, null, null);
  }
  // static NetworkResponse loading(data) {
  //   return NetworkResponse(Status.loading, data, null);
  // }
  // static NetworkResponse timeout(data) {
  //   return NetworkResponse(Status.timeout, data, null);
  // }
}
