import 'dart:io';
import 'package:getx_curd/core/base/base_repository/base_connect_api.dart';
import 'package:getx_curd/core/base/base_repository/base_repository.dart';
import 'package:getx_curd/core/values/api_url.dart';
import 'package:getx_curd/features/image_picker_load/request/image_upload_request.dart';
import 'package:image_picker/image_picker.dart';

class ImageRepository extends BaseRepository {
  final ImagePicker _picker = ImagePicker();
  final String uploadPreset = 'anh_hang_hoa';
  ImageRepository(super.controller);

  Future<File?> pickImage(ImageSource source) async {
    final pickedFile = await _picker.pickImage(source: source);
    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null;
  }

  Future<String?> uploadToCloudinary(ImageUploadRequest requestImage) async {
    final res = await baseSendRequest(
      '',
      RequestMethod.POST,
      urlOther: ApiUrl.urlImagePicker,
      jsonMap: await requestImage.toFormData(),
    );
    if (res == null) {
      return null;
    }
    return res['secure_url'];
  }
}
