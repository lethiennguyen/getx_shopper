import 'package:getx_curd/core/base/base_reponse/base_response.dart';
import 'package:getx_curd/core/base/base_reponse/product_response_data.dart';
import 'package:getx_curd/core/base/base_repository/base_connect_api.dart';
import 'package:getx_curd/core/base/base_repository/base_repository.dart';
import 'package:getx_curd/core/base/base_request/product_request.dart';
import 'package:getx_curd/core/values/api_url.dart';

class CreateProductRepository extends BaseRepository {
  CreateProductRepository(super.controller);

  Future<BaseResponse<ProductData>?> postCreateProduct(
    ProductRequest request,
  ) async {
    final res = await baseSendRequest(
      ApiUrl.urlProductCreate,
      RequestMethod.POST,
      jsonMap: request.toJson(),
    );
    if (res == null) return null;
    return BaseResponse.fromJson(
      res,
      func: (json) => ProductData.fromJson(json),
    );
  }
}
