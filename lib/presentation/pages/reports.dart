import 'package:expenses/app/realm.dart';
import 'package:expenses/extensions/expense_extension.dart';
import 'package:expenses/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Reports extends StatefulWidget {
  const Reports({Key? key}) : super(key: key);

  @override
  State<Reports> createState() => _ReportsState();
}

class _ReportsState extends State<Reports> {
  var expenses = realm.all<Expense>();
  List<Expense> data = [];

  @override
  void initState() {
    data = expenses.toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, double> categoryAmounts = data.processChartData();

    return Scaffold(
      body: SfCartesianChart(
        title: ChartTitle(
          text: "Expense Reports",
          textStyle: GoogleFonts.roboto(
            color: Colors.black,
            fontSize: 19
          )
        ),
        primaryXAxis: CategoryAxis(
          title: AxisTitle(
            text: "Categories"
          )
        ),
        primaryYAxis: NumericAxis(
          title: AxisTitle(
            text: "Price(\$)",
            textStyle: GoogleFonts.roboto(
              color: Colors.black
            )
          )
        ),
        series: <ChartSeries>[
          ColumnSeries<MapEntry<String, double>, String>(
            color: const Color.fromRGBO(66, 155, 140, 100),
            dataSource: categoryAmounts.entries.toList(),
            xValueMapper: (entry, _) => entry.key,
            yValueMapper: (entry, _) => entry.value,
            dataLabelSettings: const DataLabelSettings(
              isVisible: true,
              labelPosition: ChartDataLabelPosition.inside
            ),
          )
        ],
      ),
    );
    ;
  }
}
