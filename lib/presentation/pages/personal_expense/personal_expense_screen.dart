import 'dart:io';

import 'package:chips_choice/chips_choice.dart';
import 'package:expenses/presentation/common/app_strings.dart';
import 'package:expenses/presentation/pages/personal_expense/personal_expense_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

import '../../../utils/custom_snackbars.dart';

class PersonalExpenseScreen extends StatefulWidget {
  const PersonalExpenseScreen({super.key});

  @override
  State<PersonalExpenseScreen> createState() => _PersonalExpenseScreenState();
}

class _PersonalExpenseScreenState extends State<PersonalExpenseScreen> {
  PersonalExpenseController controller = Get.put(PersonalExpenseController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade200,
        body: Padding(
          padding: EdgeInsets.only(left: 14.0.r, right: 14.r, top: 15.r),
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Add Personal Expense",
                      style: GoogleFonts.roboto(
                          fontSize: 20.sp, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),

                    Container(
                      width: double.infinity,
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.symmetric(horizontal: 10.r),
                      height: 50.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Text(
                        AppStrings.options[controller.tag],
                        style: GoogleFonts.roboto(color: Colors.black),
                      ),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Text(
                      "Expense Category",
                      style: GoogleFonts.roboto(fontSize: 15.sp),
                    ),
                    Container(
                      width: double.infinity,
                      alignment: Alignment.centerLeft,
                      color: Colors.white,
                      child: TextFormField(
                        controller: controller.amountcontroller,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0.r),
                              borderSide: BorderSide(color: Colors.black)),
                          disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0.r),
                              borderSide: BorderSide(color: Colors.black)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0.r),
                              borderSide: BorderSide(color: Colors.black)),
                          fillColor: Colors.white,
                          focusColor: Colors.green,
                          hintText: "Enter The amount of the Expense",
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 20.h,
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
                    Container(
                      decoration: BoxDecoration(color: Colors.white),
                      child: TextFormField(
                        controller: controller.descriptioncontroller,
                        maxLines: 2,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0.r),
                              borderSide: BorderSide(color: Colors.black)),
                          disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0.r),
                              borderSide: BorderSide(color: Colors.black)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12.0.r),
                              borderSide: BorderSide(color: Colors.black)),
                          fillColor: Colors.white,
                          focusColor: Colors.green,
                          hintText: "Electricity Water and gas bills",
                        ),
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
                                  child: Image.file(
                                      File(controller.image.value),
                                      fit: BoxFit.cover))
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Iconsax.image,
                                        size: 40.w,
                                        color: Colors.black.withOpacity(0.4)),
                                    SizedBox(height: 12.h),
                                    Text("Select Image",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall)
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
                              backgroundColor: MaterialStatePropertyAll(
                                  Colors.green.shade800),
                              shape: MaterialStatePropertyAll(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.r),
                              ))),
                          onPressed: () {
                            controller.addNewPersonalExpense().then((value) {
                              return CustomSnackBars.success(
                                  title: "Success",
                                  message: "Expense Added SucessFully");
                              controller.amountcontroller.clear();
                              controller.descriptioncontroller.clear();    
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
                              "Add Personal Expense",
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
      ),
    );
  }
}
