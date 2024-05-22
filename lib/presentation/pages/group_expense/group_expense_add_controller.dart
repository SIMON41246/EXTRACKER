import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../utils/custom_snackbars.dart';

class GroupExpenseAddController extends GetxController{
  late final ImagePicker _imagePicker;

  late final RxString image;
  @override
  void onInit() {
    _imagePicker = ImagePicker();
    image = "".obs;
    super.onInit();
  }

  selectDelivreyImage() async {
    final img = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (img == null) {
      CustomSnackBars.warning(
        title: "No Image Selected",
        message: "Try again..",
      );
      return;
    }
    image.value = img.path;
  }

  @override
  void update([List<Object>? ids, bool condition = true]) {
    // TODO: implement update
    super.update(ids, condition);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}