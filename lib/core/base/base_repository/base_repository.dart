import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../base_controller/base_controller.dart';
import 'base_connect_api.dart';

class BaseRepository {
  final BaseConnectAPI _baseRequest = Get.find<BaseConnectAPI>();
  final BaseGetxController controller;

  BaseRepository(this.controller);

  /// [isQueryParametersPost]: `true`: phương thức post gửi params, mặc định = `false`
  ///
  /// [dioOptions]: option của Dio() sử dụng khi gọi api có option riêng
  ///
  /// [functionError]: chạy function riêng khi request xảy ra Exception (mặc định sử dụng [showDialogError])
  Future<dynamic> baseSendRequest(
      String action,
      RequestMethod requestMethod, {
        dynamic jsonMap,
        String? urlOther,
        Map<String, String>? headersUrlOther,
        bool isQueryParametersPost = false,
        BaseOptions? dioOptions,
        Function(Object error)? functionError,
      }) {
    return _baseRequest.sendRequest(
      action,
      requestMethod,
      jsonMap: jsonMap,
      urlOther: urlOther,
      headersUrlOther: headersUrlOther,
      isQueryParametersPost: isQueryParametersPost,
      controller: controller,
      dioOptions: dioOptions,
      functionError: functionError,
    );
  }
}
