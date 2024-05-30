import 'dart:async';

import 'package:expenses/app/realm.dart';
import 'package:expenses/extensions/expense_extension.dart';
import 'package:expenses/models/personal_expense.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:realm/realm.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Reports extends StatefulWidget {
  const Reports({Key? key}) : super(key: key);

  @override
  State<Reports> createState() => _ReportsState();
}

class _ReportsState extends State<Reports> {
  /*var expenses = realm.all<Expense>();
  List<Expense> data = [];*/
  var expenses = realm.all<PersonalExpense>();
  List<PersonalExpense> data = [];
  StreamSubscription<RealmResultsChanges<PersonalExpense>>? _expensesSub;

  @override
  void initState() {
    data = expenses.toList();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Map<String, double> categoryAmounts = data.processChartData();

    return Scaffold(
      body: SfCircularChart(
        title: ChartTitle(text: 'Sales by sales person'),
        legend: Legend(isVisible: true),
        series: _getDefaultPieSeries(data),
      ),
    );
    ;
  }

  List<PieSeries<PersonalExpense, String>> _getDefaultPieSeries(
      List<PersonalExpense> expenses) {
    return <PieSeries<PersonalExpense, String>>[
      PieSeries<PersonalExpense, String>(
          explode: true,
          explodeIndex: 0,
          dataSource: expenses,
          xValueMapper: (PersonalExpense data, _) => data.groupExpense as String,
          yValueMapper: (PersonalExpense data, _) => data.amount,
          dataLabelMapper: (PersonalExpense data, _) => data.groupExpense,
          startAngle: 90,
          endAngle: 90,
          dataLabelSettings: const DataLabelSettings(isVisible: true)),
    ];
  }
}
