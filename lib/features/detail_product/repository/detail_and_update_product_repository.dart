import 'dart:convert';

import 'package:getx_curd/core/base/base_reponse/base_response.dart';
import 'package:getx_curd/core/base/base_reponse/base_response_data.dart';
import 'package:getx_curd/core/base/base_repository/base_connect_api.dart';
import 'package:getx_curd/core/base/base_repository/base_repository.dart';
import 'package:getx_curd/core/values/api_url.dart';
import 'package:getx_curd/core/base/base_request/product_request.dart';

class DetailAndUpdateProductRepository extends BaseRepository {
  DetailAndUpdateProductRepository(super.controller);

  Future<BaseResponse<ProductData>?> getDetailProduct(int id) async {
    final res = await baseSendRequest(
      '${ApiUrl.urlProductDetial}$id',
      RequestMethod.GET,
    );

    if (res == null) {
      return null;
    }
    return BaseResponse.fromJson(
      res,
      func: (json) => ProductData.fromJson(json),
    );
  }

  Future<BaseResponse<ProductData>?> getUpdateProduct(
    int id,
    ProductRequest request,
  ) async {
    final res = await baseSendRequest(
      '${ApiUrl.urlProductUpdate}$id',
      RequestMethod.PUT,
      jsonMap: request.toJson(),
    );
    if (res == null) {
      return null;
    }
    return BaseResponse.fromJson(
      res,
      func: (json) => ProductData.fromJson(json),
    );
  }

  Future<BaseResponse?> deleteProduct(int id) async {
    final res = await baseSendRequest(
      '${ApiUrl.urlProductUpdate}$id',
      RequestMethod.DELETE,
    );
    if (res == null) return null;
    return BaseResponse.fromJson(
      res,
      func: (json) => ProductData.fromJson(json),
    );
  }
}
