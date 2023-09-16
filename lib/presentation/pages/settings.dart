import 'package:collection/collection.dart';
import 'package:expenses/app/pdf/mobile.dart';
import 'package:expenses/app/realm.dart';
import 'package:expenses/models/balance.dart';
import 'package:expenses/models/category.dart';
import 'package:expenses/models/expense.dart';
import 'package:flutter/foundation.dart' hide Category;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

import '../../app/routes.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  var categeries = realm.all<Category>().toList();
  var balances = realm.all<Balance>();
  var expenses = realm.all<Expense>();
  List<Expense> dataExpenses = [];
  List<Balance> dataBalance = [];

  double get _total => dataExpenses.map((expense) => expense.amount).sum;

  @override
  void initState() {
    dataBalance = balances.toList();
    dataExpenses = expenses.toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(181, 201, 154, 100),
      body: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          height: 500,
          alignment: Alignment.bottomCenter,
          decoration: const BoxDecoration(
              color: Color.fromRGBO(151, 169, 124, 100),
              borderRadius: BorderRadius.all(Radius.circular(30))),
          child: ListView(
            children: [
              Center(
                  child: Text(
                ("Managing Categories"),
                style: GoogleFonts.roboto(fontSize: 19, color: Colors.black),
              )),
              ListTile(
                title: Text(
                  "Categories",
                  style: GoogleFonts.roboto(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
                trailing: Icon(Icons.arrow_forward, color: Colors.black),
                onTap: () {
                  Get.toNamed(Routes.categeries);
                },
              ),
              ListTile(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: const Text(
                              "Are You Sure You Want To Erase All Data?"),
                          title: const Text("Delete All Categories"),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  realm.write(() {
                                    realm.deleteAll<Category>();
                                    realm.deleteAll<Expense>();
                                  });
                                  Get.back();
                                },
                                child: const Text("Yes"))
                          ],
                        );
                      });
                },
                trailing: const Icon(Icons.arrow_forward, color: Colors.red),
                title: Text(
                  "Erase Date",
                  style: GoogleFonts.roboto(
                      color: Colors.red, fontWeight: FontWeight.bold),
                ),
              ),
              ListTile(
                trailing: const Icon(Icons.arrow_forward, color: Colors.black),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("You Want To Export Data?"),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  _createPdf();
                                  Get.back();
                                },
                                child: Text(
                                  "Yes",
                                  style: GoogleFonts.roboto(
                                    fontSize: 19,
                                    color: Colors.black,
                                  ),
                                ))
                          ],
                        );
                      });
                },
                title: Text(
                  "Export Data",
                  style: GoogleFonts.roboto(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _createPdf() async {
    PdfDocument document = PdfDocument();
    final page = document.pages.add();
    // Create a table with headers
    final table = PdfGrid();

    table.columns.add(count: 3);
    table.headers.add(1);
    table.style = PdfGridStyle(
      font: PdfStandardFont(PdfFontFamily.helvetica, 30),
      cellPadding: PdfPaddings(left: 5, bottom: 2, top: 2, right: 2),
    );
    PdfGridRow header = table.headers[0];
    header.cells[0].value = "Category";
    header.cells[1].value = "Price";
    header.cells[2].value = "Date";

    for (var expense in dataExpenses) {
      PdfGridRow row = table.rows.add();
      row.cells[0].value = expense.category?.name;
      row.cells[1].value = expense.amount.toStringAsFixed(2);
      row.cells[2].value =
          "${expense.date.day.toString()}/${expense.date.month.toString()}/${expense.date.year.toString()}  ";
    }
    final string = page.graphics.drawString(
        "ExTracker  ${DateTime.now().year}/${DateTime.now().month}/${DateTime.now().day} ${DateTime.now().hour}:${DateTime.now().minute}",
        PdfStandardFont(PdfFontFamily.helvetica, 30));

    page.graphics.drawRectangle(
      brush: PdfSolidBrush(PdfColor.empty), // Transparent fill
      bounds: const Rect.fromLTWH(
        20,
        20,
        20,
        20,
      ),
      pen: PdfPen(PdfColor.empty), // No border
    );

    table.draw(
      page: page,
      bounds: const Rect.fromLTWH(
        20 + 10, // Adjust left position to add left margin
        20 + 40, // Adjust top position to add top margin
        20 - 20, // Adjust width to account for both left and right margins
        20 - 20, // Adjust height 3to account for both top and bottom margins
      ),
    );

    List<int> bytes = await document.save();
    document.dispose();
    saveAndLaunchFile(bytes, 'output.pdf');
  }

  Future<Uint8List> _readImageData(String name) async {
    final data = await rootBundle.load('assets/$name');
    return data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  }
}
