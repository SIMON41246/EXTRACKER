import 'package:expenses/models/group_expense.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../app/realm.dart';
import '../../../utils/custom_snackbars.dart';

class GroupExpenseAddController extends GetxController {
  late final ImagePicker _imagePicker;
  late final TextEditingController categoryController;
  late final TextEditingController descriptionController;

  late final RxString image;

  @override
  void onInit() {
    _imagePicker = ImagePicker();
    categoryController = TextEditingController();
    descriptionController = TextEditingController();
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

  int tag = 1;

  Future<String> addGroupExpense() async {
    realm.write(() => realm.add(GroupExpense(
        categoryController.text, descriptionController.text, image.value)));
    return categoryController.text;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
}
