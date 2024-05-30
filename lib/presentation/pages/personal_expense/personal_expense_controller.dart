import 'package:expenses/models/group_expense.dart';
import 'package:expenses/models/personal_expense.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:realm/realm.dart';

import '../../../app/realm.dart';
import '../../../utils/custom_snackbars.dart';
import '../../common/app_strings.dart';

class PersonalExpenseController extends GetxController {
  late final ImagePicker _imagePicker;
  late TextEditingController amountcontroller;
  late TextEditingController descriptioncontroller;

  late final RxString image;

  @override
  void onInit() {
    _imagePicker = ImagePicker();
    amountcontroller = TextEditingController();
    descriptioncontroller = TextEditingController();
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

  int tag = 1;

  Future<void> addNewPersonalExpense() async {
    realm.write(() => realm.add(PersonalExpense(ObjectId(),
        double.parse(amountcontroller.text), DateTime.now(), image.value,
        description: descriptioncontroller.text,
        groupExpense: AppStrings.options[tag])));
  }

  @override
  void dispose() {
    amountcontroller.clear();
    descriptioncontroller.clear();
    super.dispose();
  }
}
