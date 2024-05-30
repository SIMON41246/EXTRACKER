import 'dart:async';

import 'package:collection/collection.dart';
import 'package:expenses/app/realm.dart';
import 'package:expenses/models/personal_expense.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:realm/realm.dart';

import '../../common/widgets/custom_expense_card.dart';

class Expenses extends StatefulWidget {
  const Expenses({Key? key}) : super(key: key);

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
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
    double priceconverted = _total * 0.93;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade200,
        body: Padding(
          padding: EdgeInsets.only(left: 14.0.r, right: 14.r, top: 15.r),
          child: Stack(
            children: [
              Text(
                "Expenses",
                style: GoogleFonts.roboto(fontSize: 15.sp),
              ),
              SizedBox(
                height: 10.h,
              ),
              ListView.separated(
                padding: EdgeInsets.symmetric(vertical: 50.r),
                itemBuilder: (context, index) {
                  return CustomExpenseCard(expenses[index]);
                },itemCount: expenses.length, separatorBuilder: (BuildContext context, int index) {
                return SizedBox(height: 8.0.h);
              },
              )
            ],
          ),
        ),
      ),
    );
  }
}
