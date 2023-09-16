import 'package:expenses/presentation/pages/display_data/expenses.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'balances.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 1,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Home",style: GoogleFonts.roboto(
              fontSize: 25,
              color: Colors.black

          ),),
          backgroundColor: const Color.fromRGBO(135, 152, 106, 100),

          bottom:  TabBar(indicatorWeight: 3,indicatorColor: Colors.black,tabs: [
            Tab(
              child: Text("Expenses",style: GoogleFonts.robotoSlab(fontSize:14,color: Colors.black ,fontWeight: FontWeight.bold)),
            ),
            Tab(
              child: Text("Balances",style: GoogleFonts.robotoSlab(fontSize:14,color: Colors.black ,fontWeight: FontWeight.bold)),
            ),
          ]),
        ),
        body:  const TabBarView(
          children: [Expenses(), Balances()],
        ),
      ),
    );

  }
}
