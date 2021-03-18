import 'package:cnode_flutter2/config/net/base.dart';
import 'package:dio/dio.dart';
// import 'package:pretty_dio_logger/pretty_dio_logger.dart';

final Http http = Http();

class Http extends BaseHttp {
  @override
  void init() {
    options.baseUrl = 'https://cnodejs.org/api/v1';
    interceptors
      ..add(ApiInterceptor());
      // ..add(
      //   PrettyDioLogger(
      //     requestHeader: false,
      //     requestBody: false,
      //     responseBody: false,
      //     responseHeader: false,
      //     error: true,
      //     compact: true,
      //     maxWidth: 90,
      //   ),
      // );
  }
}

class ApiInterceptor extends InterceptorsWrapper {
  @override
  Future onRequest(RequestOptions options) async {
    // debugPrint(
    //     '---api-request--->url--> ${options.method} => ${options.baseUrl}${options.path}' +
    //         ' queryParameters: ${options.queryParameters} post: ${options.data}');
    return options;
  }

  @override
  Future onResponse(Response response) async {
    ResponseData responseData = ResponseData.fromJson(response.data);
    if (responseData.success) {
      response.data = responseData.data;
      return http.resolve(response);
    } else {
      throw NotSuccessException.fromRespData(responseData);
    }
  }
}

class ResponseData extends BaseResponseData {
  ResponseData.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['error_msg'];
    data = json['data'] ?? json;
  }
}
