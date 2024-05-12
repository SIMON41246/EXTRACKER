import 'dart:async';

import 'package:collection/collection.dart';
import 'package:expenses/app/realm.dart';
import 'package:expenses/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:realm/realm.dart';


class Expenses extends StatefulWidget {
  const Expenses({Key? key}) : super(key: key);

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  var expenses = realm.all<Expense>();
  List<Expense> data = [];
  StreamSubscription<RealmResultsChanges<Expense>>? _expensesSub;
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
    double priceconverted=_total*0.93;


    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade200,
        body:  SizedBox(),
      ),
    );
  }
}


