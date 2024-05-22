import 'dart:io';

import 'package:chips_choice/chips_choice.dart';
import 'package:expenses/presentation/pages/group_expense/group_expense_add_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

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
  int tag = 1;
  List<String> options = [
    'News',
    'Entertainment',
    'Politics',
    'Automotive',
    'Sports',
    'Education',
    'Fashion',
    'Travel',
    'Food',
    'Tech',
    'Science',
  ];

  @override
  void initState() {
    _selectedLocation = _locations.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: Padding(
        padding: EdgeInsets.only(left: 14.0.r, right: 14.r, top: 15.r),
        child: SingleChildScrollView(
          child: Stack(
            children:[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Add Personal Expense",
                    style: GoogleFonts.roboto(fontSize: 15.sp),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  DropdownButton(
                    hint: _selectedLocation == null
                        ? Text('Dropdown')
                        : Text(
                      _selectedLocation,
                      style: TextStyle(color: Colors.blue),
                    ),
                    isExpanded: true,
                    iconSize: 30.0,
                    style: TextStyle(color: Colors.black, fontSize: 15.sp),
                    items: ['One', 'Two', 'Three'].map(
                          (val) {
                        return DropdownMenuItem<String>(
                          value: val,
                          enabled: true,
                          child: Text(val),
                        );
                      },
                    ).toList(),
                    onChanged: (val) {
                      setState(
                            () {
                          _selectedLocation = val!;
                        },
                      );
                    },
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    "Expense Category",
                    style: GoogleFonts.roboto(fontSize: 15.sp),
                  ),
                  ChipsChoice<int>.single(
                    value: tag,
                    onChanged: (val) => setState(() => tag = val),
                    choiceItems: C2Choice.listFrom<int, String>(
                      source: options,
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
                    maxLines: 3,
                    decoration: InputDecoration(
                      disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0.r),
                          borderSide: BorderSide(color: Colors.black)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.0.r),
                          borderSide: BorderSide(color: Colors.black)),
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
                  GestureDetector(
                    onTap: controller.selectDelivreyImage,
                    child: Obx(
                          () => Container(
                        width: double.infinity,
                        height: 250.0.h,
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
                                size: 40,
                                color: Colors.white.withOpacity(0.4)),
                            SizedBox(height: 12.h),
                            Text("Select Image (Main)",
                                style: Theme.of(context).textTheme.bodySmall)
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h,),
                  Align(alignment: Alignment.bottomCenter,child: ElevatedButton(onPressed: (){}, child: Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    height: 50.h,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Text("Add Group Expense",style: GoogleFonts.roboto(color:Colors.white),),
                  )),)

                ],
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
