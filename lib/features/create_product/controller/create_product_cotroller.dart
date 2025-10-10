import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:getx_curd/core/base/base_controller/base_controller.dart';
import 'package:getx_curd/core/base/base_request/product_request.dart';
import 'package:getx_curd/features/create_product/repository/create_product_repository.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/values/strings.dart';
import '../../../utils/show_popup.dart';
import '../../../utils/utils_widget.dart';
import '../../image_picker_load/repository/image_picker_repository.dart';
import '../../image_picker_load/request/image_upload_request.dart';

class CreateProductController extends BaseGetxController {
  late final CreateProductRepository _createProductRepository =
      CreateProductRepository(this);
  late final ProductRequest _productRequest = ProductRequest();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController coverController = TextEditingController();
  final RxString url = ''.obs;
  late final ImageRepository _repositoryImage = ImageRepository(this);
  final ImageUploadRequest _requestImage = ImageUploadRequest();

  final FocusNode nameFocus = FocusNode();
  final FocusNode priceFocus = FocusNode();
  final FocusNode quantityFocus = FocusNode();
  final FocusNode coverFocus = FocusNode();
  final formKey = GlobalKey<FormState>();
  final autoValidateMode = AutovalidateMode.disabled.obs;

  void loadImage() async {
    url.value = coverController.text;
  }

  Future<void> upImage() async {
    final upImage = await _repositoryImage.pickImage(ImageSource.gallery);
    if (upImage == null) return;
    _requestImage
      ..imagePath = upImage.path
      ..uploadPreset = _repositoryImage.uploadPreset;

    final urlImage = await _repositoryImage.uploadToCloudinary(_requestImage);
    if (urlImage == null) return;
    url.value = urlImage;
  }

  Future<void> createProduct() async {
    autoValidateMode.value = AutovalidateMode.always;

    if (!(formKey.currentState?.validate() ?? false)) {
      return;
    }
    final name = nameController;
    final price = priceController;
    final quantity = quantityController;
    final cover = url;
    _productRequest
      ..name = name.text
      ..price = int.tryParse(price.text)
      ..quantity = int.tryParse(quantity.text)
      ..cover = cover.value;
    final result = await _createProductRepository.postCreateProduct(
      _productRequest,
    );
    if (result?.success == false || result == null) {
      ShowPopup.showDiaLogNotifyton(
        AppStrings.title,
        AppStrings.messageError,
        AppStrings.okButton,
        null,
      );
      return;
    }
    if (result.success) {
      Get.back(result: true);
      UtilsWidget.showSnackBar(
        title: AppStrings.title,
        message: AppStrings.messageUpdate,
      );
      return;
    }
  }
}
