import 'package:getx_curd/core/base/base_reponse/base_response.dart';
import 'package:getx_curd/core/base/base_repository/base_connect_api.dart';
import 'package:getx_curd/core/base/base_repository/base_repository.dart';
import 'package:getx_curd/core/values/api_url.dart';
import 'package:getx_curd/features/login/model/login_request_model.dart';
import 'package:getx_curd/features/login/model/token_model.dart';

class AuthRepository extends BaseRepository {
  AuthRepository(super.controller);

  Future<BaseResponse<ModelToken>?> postUserProviders(
    LoginRequestModel loginRequest,
  ) async {
    final res = await baseSendRequest(
      ApiUrl.urlLogin,
      RequestMethod.POST,
      jsonMap: loginRequest.toJson(),
    );
    if (res == null) return null;
    final respon = BaseResponse.fromJson(
      res,
      func: (json) => ModelToken.fromJson(json),
    );
    return respon;
  }
}
