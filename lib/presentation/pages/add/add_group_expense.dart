import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AddGroupExpense extends StatefulWidget {
  const AddGroupExpense({super.key});

  @override
  State<AddGroupExpense> createState() => _AddGroupExpenseState();
}

class _AddGroupExpenseState extends State<AddGroupExpense> {
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
          child: Column(
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
              )
            ],
          ),
        ),
      ),
    ));
  }
}
