import 'dart:io';

import 'package:chips_choice/chips_choice.dart';
import 'package:expenses/presentation/common/app_strings.dart';
import 'package:expenses/presentation/pages/group_expense/group_expense_add_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

import '../../../utils/custom_snackbars.dart';

class GroupExpenseAddScreen extends StatefulWidget {
  const GroupExpenseAddScreen({super.key});

  @override
  State<GroupExpenseAddScreen> createState() => _GroupExpenseAddScreenState();
}

class _GroupExpenseAddScreenState extends State<GroupExpenseAddScreen> {
  List<String> _locations = [
    'A',
    'B',
    'C',
    'D',
    'A',
    'B',
    'C',
    'D'
  ]; // Option 2
  late String _selectedLocation;
  GroupExpenseAddController controller = Get.put(GroupExpenseAddController());

  @override
  void initState() {
    _selectedLocation = _locations.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: Padding(
        padding: EdgeInsets.only(left: 14.0.r, right: 14.r, top: 15.r),
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Add Group Expense",
                    style: GoogleFonts.roboto(fontSize: 15.sp),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                      width: double.infinity,
                      height: 50.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: TextField(
                        controller: controller.categoryController,
                        decoration: InputDecoration(
                          hintText: "Enter Group Expense",
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                        ),
                      )),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    "Expense Category",
                    style: GoogleFonts.roboto(fontSize: 15.sp),
                  ),
                  ChipsChoice<int>.single(
                    choiceStyle: C2ChipStyle(
                        backgroundColor: Colors.green.shade800,
                        checkmarkColor: Colors.green.shade800),
                    value: controller.tag,
                    onChanged: (val) => setState(() => controller.tag = val),
                    choiceItems: C2Choice.listFrom<int, String>(
                      source: AppStrings.options,
                      value: (i, v) => i,
                      label: (i, v) => v,
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    "Expense Description",
                    style: GoogleFonts.roboto(fontSize: 15.sp),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  TextFormField(
                    controller: controller.descriptionController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(8.r)),
                      disabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(8.r)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                          borderRadius: BorderRadius.circular(8.r)),
                      fillColor: Colors.white,
                      focusColor: Colors.green,
                      helperText: "Write a description for the expense",
                      hintText: "Electricity Water and gas bills",
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  // - - - - - - - - - - - - - - - - - - MAIN IMAGE Delivery Man - - - - - - - - - - - - - - - - - -  //
                  Text(
                    "Add Photo",
                    style: GoogleFonts.roboto(fontSize: 15.sp),
                  ),
                  GestureDetector(
                    onTap: controller.selectDelivreyImage,
                    child: Obx(
                      () => Container(
                        width: double.infinity,
                        height: 220.0.h,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          border: Border.all(
                            color: Colors.white.withOpacity(0.4),
                          ),
                          color: Colors.grey.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: controller.image.value != ""
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(12.r),
                                child: Image.file(File(controller.image.value),
                                    fit: BoxFit.cover))
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Iconsax.image,
                                      size: 40.w,
                                      color: Colors.black.withOpacity(0.4)),
                                  SizedBox(height: 12.h),
                                  Text("Select Image",
                                      style:
                                          Theme.of(context).textTheme.bodySmall)
                                ],
                              ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.green.shade800),
                            shape:
                                MaterialStatePropertyAll(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ))),
                        onPressed: () {
                          controller.addGroupExpense().then((value) => {
                                CustomSnackBars.success(
                                    title: "Success",
                                    message: "Expense Added SucessFully"),
                                setState(() {
                                  AppStrings.options.add(value);
                                })
                              });
                        },
                        child: Container(
                          width: double.infinity,
                          alignment: Alignment.center,
                          height: 50.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                          ),
                          child: Text(
                            "Add Group Expense",
                            style: GoogleFonts.roboto(color: Colors.white),
                          ),
                        )),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
