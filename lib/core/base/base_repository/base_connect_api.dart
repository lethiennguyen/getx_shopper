

import 'package:dio/dio.dart';
import 'package:getx_curd/core/values/api_url.dart';
import 'package:getx_curd/core/values/const.dart';
import 'package:getx_curd/core/values/key.dart';
import 'package:getx_curd/features/app/controller/app_controller.dart';
import 'package:hive/hive.dart';

import '../base_controller/base_controller.dart';

enum RequestMethod { POST, GET, PUT, DELETE }

class BaseConnectAPI {
  static Dio dio = getBaseDio();

  static Dio getBaseDio() {
    Dio dio = Dio();

    dio.options = buildDefaultOptions();

    return dio;
  }

  static BaseOptions buildDefaultOptions() {
    return BaseOptions()
      ..connectTimeout = AppConst.requestTimeOut
      ..receiveTimeout = AppConst.requestTimeOut;
  }

  Future<dynamic> sendRequest(
      String action,
      RequestMethod requestMethod, {
        dynamic jsonMap,
        String? urlOther,
        Map<String, String>? headersUrlOther,
        bool isQueryParametersPost = false,
        required BaseGetxController controller,
        BaseOptions? dioOptions,
        Function(Object error)? functionError,
        bool isToken = true, // mặc định request nào cũng cần token, login thì set false
      }) async {
    dio.options = dioOptions ?? buildDefaultOptions();

    final Response response;

    final String url = urlOther ?? (ApiUrl.baseUrl + action);

    final Map<String, String> headers =
        headersUrlOther ?? await getBaseHeader();

    final Options options = Options(
      headers: headers,
      method: requestMethod.toString(),
      responseType: ResponseType.json,
    );

    final CancelToken cancelToken = CancelToken();
    controller.addCancelToken(cancelToken);
    try {
      if (requestMethod == RequestMethod.POST) {
        if (isQueryParametersPost) {
          response = await dio.post(
            url,
            queryParameters: jsonMap,
            options: options,
            cancelToken: cancelToken,
          );
        } else {
          response = await dio.post(
            url,
            data: jsonMap,
            options: options,
            cancelToken: cancelToken,
          );
        }
      } else if (requestMethod == RequestMethod.DELETE) {
        response = await dio.delete(
          url,
          queryParameters: jsonMap,
          options: options,
          cancelToken: cancelToken,
        );
      } else if (requestMethod == RequestMethod.PUT) {
        if (isQueryParametersPost) {
          response = await dio.put(
            url,
            queryParameters: jsonMap,
            options: options,
            cancelToken: cancelToken,
          );
        } else {
          response = await dio.put(
            url,
            data: jsonMap,
            options: options,
            cancelToken: cancelToken,
          );
        }
      } else {
        response = await dio.get(
          url,
          queryParameters: jsonMap,
          options: options,
          cancelToken: cancelToken,
        );
      }
      return response.data;
    } catch (e) {
      print("SendRequest error: $e"); // stacktrace
      if (functionError != null) {
        functionError(e);
      }
     }
  }

  Future<Map<String, String>> getBaseHeader() async {
    final authBox = await Hive.openBox(HiveBoxNames.auth);
    final String token = authBox.get(HiveKeys.token, defaultValue: '');
    if (token.isNotEmpty) {
      return {
        "Content-Type": "application/json",
        "Authorization": token,
      };
    }

    return {
      "Content-Type": "application/json",
    };
  }
}