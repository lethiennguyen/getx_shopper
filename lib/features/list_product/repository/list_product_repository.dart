
import 'package:getx_curd/core/base/base_reponse/base_response_data.dart';
import 'package:getx_curd/core/base/base_reponse/base_response_list.dart';
import 'package:getx_curd/core/base/base_request/base_request_model.dart';
import 'package:getx_curd/core/values/api_url.dart';

import '../../../core/base/base_repository/base_connect_api.dart';
import '../../../core/base/base_repository/base_repository.dart';

class ListProductRepository extends BaseRepository {
  ListProductRepository(super.controller);

  Future<BaseResponseList<ProductData>?> getListProduct(
      BaseRequestListModel baseRequestListModel
      ) async {
    final res = await baseSendRequest(
      ApiUrl.urlListProduct,
      RequestMethod.GET,
      jsonMap: baseRequestListModel.toJson(),
    );
    if (res == null) return null;
    return BaseResponseList.fromJson(
      res,
      func: (json) => ProductData.fromJson(json),
    );
  }
}