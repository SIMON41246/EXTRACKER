import 'package:expenses/presentation/pages/add/add_balance.dart';
import 'package:expenses/presentation/pages/add/add_expense.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Add extends StatefulWidget {
  const Add({Key? key}) : super(key: key);

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      animationDuration: const Duration(milliseconds: 200),
      length: 2,
      initialIndex: 1,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(135, 152, 106, 100),
          title: Text("Add",style: GoogleFonts.roboto(
            fontSize: 25,
            color: Colors.black

          ),),
          centerTitle: true,
          bottom:  TabBar(indicatorWeight: 3,indicatorColor: Colors.black,tabs: [
            Tab(
              child: Text("Expenses",style: GoogleFonts.robotoSlab(fontSize:14,color: Colors.black ,fontWeight: FontWeight.bold)),
            ),
            Tab(
              child: Text("Balance",style: GoogleFonts.robotoSlab(fontSize:14,color: Colors.black ,fontWeight: FontWeight.bold)),
            ),
          ]),
        ),
        body: const TabBarView(
          children: [AddExpense(), BalanceView()],
        ),
      ),
    );
  }
}
