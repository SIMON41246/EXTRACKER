import 'dart:async';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:expenses/models/group_expense.dart';
import 'package:expenses/models/personal_expense.dart';
import 'package:expenses/presentation/pages/display_data/expenses.dart';
import 'package:expenses/presentation/pages/personal_expense/personal_expense_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:realm/realm.dart';

import '../../../app/realm.dart';
import '../../common/widgets/custom_expense_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  /*final expense = Expense(ObjectId(), 15.02, DateTime.now(),
      note: "Good", category: Category("FlatMates", 1233456));*/

  var expenses = realm.all<PersonalExpense>();
  List<PersonalExpense> data = [];
  StreamSubscription<RealmResultsChanges<PersonalExpense>>? _expensesSub;
  double convertedAmount = 0.0;

  double get _total => data.map((expense) => expense.amount).sum;

  @override
  void initState() {
    data = expenses.toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _expensesSub ??= expenses.changes.listen((changes) {
      setState(() {
        data = changes.results.toList();
      });
    });
    return SafeArea(
        bottom: true,
        top: true,
        child: Scaffold(
          backgroundColor: Colors.grey.shade200,
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Home",
                  style: GoogleFonts.roboto(fontSize: 15.sp),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14.r)),
                  width: double.infinity,
                  height: 130.h,
                  child: Padding(
                    padding:
                        EdgeInsets.only(top: 20.r, right: 15.r, left: 15.r),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Your Expenses",
                              style: GoogleFonts.roboto(
                                fontSize: 15.sp,
                              ),
                            ),
                            Text(
                              "${_total}",
                              style: GoogleFonts.roboto(
                                  fontSize: 20.sp,
                                  color: Colors.green.shade800),
                            ),
                            Row(
                              children: [
                                Text(
                                  "See Your Monthly report",
                                  style: GoogleFonts.roboto(
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.normal),
                                ),
                                SizedBox(
                                  width: 4.w,
                                ),
                                Icon(Icons.chevron_right_sharp)
                              ],
                            )
                          ],
                        ),
                        Image.asset(
                          "assets/images/statistics.png",
                          height: 100.h,
                          width: 100.w,
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 160.w,
                      height: 80.h,
                      decoration: BoxDecoration(
                        color: Colors.red.shade100,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "You Own",
                            style: GoogleFonts.roboto(
                                fontSize: 15.sp, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text("${_total}",
                              style: GoogleFonts.roboto(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.normal))
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Container(
                      width: 160.w,
                      height: 80.h,
                      decoration: BoxDecoration(
                        color: Colors.green.shade100,
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "You are owed",
                            style: GoogleFonts.roboto(
                                fontSize: 15.sp, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Text("£32.25",
                              style: GoogleFonts.roboto(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.normal))
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Recent Expenses",
                      style: GoogleFonts.roboto(
                          fontSize: 20.sp, fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                        onPressed: () {
                          Get.to(Expenses());
                        },
                        child: Text(
                          "See All",
                          style: GoogleFonts.roboto(fontSize: 10.sp),
                        ))
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                expenses.length != 0
                    ? Container(
                        height: 250.h,
                        child: ListView.separated(
                          itemCount: 2,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return CustomExpenseCard(expenses[index]);
                          },
                          separatorBuilder:
                              (BuildContext context, int index) {
                            return SizedBox(height: 8.0.h);
                          },
                        ),
                      )
                    : SizedBox(
                        height: 250.h,
                      ),
                SizedBox(
                  height: 5.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Frequently Used Groups",
                      style: GoogleFonts.roboto(
                          fontSize: 20.sp, fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                        onPressed: () {},
                        child: Text(
                          "See All",
                          style: GoogleFonts.roboto(fontSize: 10.sp),
                        ))
                  ],
                ),
                SizedBox(
                  height: 10.h,
                ),
                Container(
                  height: 450.h,
                  child: GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      
                    ),
                    itemCount: expenses.length, // Total number of items
                    itemBuilder: (BuildContext context, int index) {
                      // Your item widgets here
                      return Container(
                        padding: EdgeInsets.all(12.r),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(color: Colors.black, blurRadius: 0.5)
                            ]),
                        child: Column(
                          children: [
                            Text(
                              "${expenses[index].groupExpense}",
                              style: GoogleFonts.roboto(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Container(
                              width: 100.w,
                              height: 80.h,
                              decoration:
                                  BoxDecoration(shape: BoxShape.circle),
                              child: Image.file(File(expenses[index].image)),
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Text("total",
                                style: GoogleFonts.roboto(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.bold)),
                            SizedBox(
                              height: 3.h,
                            ),
                            Text("+${expenses[index].amount}",
                                style: GoogleFonts.roboto(
                                    fontSize: 12.sp,
                                    color: Colors.green.shade800,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
