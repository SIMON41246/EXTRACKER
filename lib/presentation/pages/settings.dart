import 'package:babstrap_settings_screen/babstrap_settings_screen.dart';
import 'package:collection/collection.dart';
import 'package:expenses/app/pdf/mobile.dart';
import 'package:expenses/app/realm.dart';
import 'package:expenses/models/balance.dart';
import 'package:expenses/models/group_expense.dart';
import 'package:expenses/models/personal_expense.dart';
import 'package:flutter/cupertino.dart';
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
  // var categeries = realm.all<Category>().toList();
  var balances = realm.all<Balance>();
  /*var expenses = realm.all<Expense>();
  List<Expense> dataExpenses = [];*/
  List<Balance> dataBalance = [];

  // double get _total => dataExpenses.map((expense) => expense.amount).sum;

  @override
  void initState() {
    dataBalance = balances.toList();
    // dataExpenses = expenses.toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(181, 201, 154, 100),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            // User card
            BigUserCard(
              backgroundColor: Colors.red,
              userName: "Babacar Ndong",
              userProfilePic: AssetImage("assets/logo.png"),
              cardActionWidget: SettingsItem(
                icons: Icons.edit,
                iconStyle: IconStyle(
                  withBackground: true,
                  borderRadius: 50,
                  backgroundColor: Colors.yellow[600],
                ),
                title: "Modify",
                subtitle: "Tap to change your data",
                onTap: () {
                  print("OK");
                },
              ),
            ),
            SettingsGroup(
              items: [
                SettingsItem(
                  onTap: () {},
                  icons: CupertinoIcons.pencil_outline,
                  iconStyle: IconStyle(),
                  title: 'Appearance',
                  subtitle: "Make Ziar'App yours",
                ),
                SettingsItem(
                  onTap: () {},
                  icons: Icons.dark_mode_rounded,
                  iconStyle: IconStyle(
                    iconsColor: Colors.white,
                    withBackground: true,
                    backgroundColor: Colors.red,
                  ),
                  title: 'Dark mode',
                  subtitle: "Automatic",
                  trailing: Switch.adaptive(
                    value: false,
                    onChanged: (value) {},
                  ),
                ),
              ],
            ),
            SettingsGroup(
              items: [
                SettingsItem(
                  onTap: () {},
                  icons: Icons.info_rounded,
                  iconStyle: IconStyle(
                    backgroundColor: Colors.purple,
                  ),
                  title: 'About',
                  subtitle: "Learn more about Ziar'App",
                ),
              ],
            ),
            // You can add a settings title
            SettingsGroup(
              settingsGroupTitle: "Account",
              items: [
                SettingsItem(
                  onTap: () {},
                  icons: Icons.exit_to_app_rounded,
                  title: "Sign Out",
                ),
                SettingsItem(
                  onTap: () {},
                  icons: CupertinoIcons.delete_solid,
                  title: "Delete account",
                  titleStyle: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
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

    /*for (var expense in dataExpenses) {
      PdfGridRow row = table.rows.add();
      row.cells[0].value = expense.category?.name;
      row.cells[1].value = expense.amount.toStringAsFixed(2);
      row.cells[2].value =
          "${expense.date.day.toString()}/${expense.date.month.toString()}/${expense.date.year.toString()}  ";
    }*/
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
