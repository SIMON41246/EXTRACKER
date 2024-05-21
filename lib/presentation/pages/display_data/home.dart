import 'package:expenses/presentation/pages/display_data/expenses.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:expenses/presentation/pages/categories.dart';

import '../reports.dart';
import '../settings.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int currenttab = 0;
  final List<Widget> screens = [
    Expenses(),
    Categories(),
    Reports(),
    Settings()
  ];
  Widget currentScreen = Expenses();
  final PageStorageBucket bucket = PageStorageBucket();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 1,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Home",
            style: GoogleFonts.roboto(fontSize: 25, color: Colors.black),
          ),
          backgroundColor: const Color.fromRGBO(135, 152, 106, 100),
          bottom:
              TabBar(indicatorWeight: 3, indicatorColor: Colors.black, tabs: [
            Tab(
              child: Text("Expenses",
                  style: GoogleFonts.robotoSlab(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.bold)),
            ),
            Tab(
              child: Text("Balances",
                  style: GoogleFonts.robotoSlab(
                      fontSize: 14,
                      color: Colors.black,
                      fontWeight: FontWeight.bold)),
            ),
          ]),
        ),
        body: PageStorage(
          child: currentScreen,
          bucket: bucket,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.add),
          backgroundColor: Colors.green,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          child: Container(
            child: Row(
              children: [
                Row(
                  children: [
                    MaterialButton(
                      minWidth: 40,
                      onPressed: () {
                        setState(() {
                          currentScreen = Expenses();
                          currenttab = 0;
                        });
                      },
                      child: Column(
                        children: [
                          Icon(
                            Icons.home,
                            color: currenttab == 0
                                ? Colors.green
                                : Colors.green.shade50,
                          ),
                          Text(
                            "Expenses",
                            style: TextStyle(
                                color: currenttab == 0
                                    ? Colors.green
                                    : Colors.green.shade50),
                          )
                        ],
                      ),
                    ),
                    MaterialButton(
                      minWidth: 40,
                      onPressed: () {
                        setState(() {
                          currentScreen = Expenses();
                          currenttab = 0;
                        });
                      },
                      child: Column(
                        children: [
                          Icon(
                            Icons.home,
                            color: currenttab == 0
                                ? Colors.green
                                : Colors.green.shade50,
                          ),
                          Text(
                            "Expenses",
                            style: TextStyle(
                                color: currenttab == 0
                                    ? Colors.green
                                    : Colors.green.shade50),
                          )
                        ],
                      ),
                    )

                  ],
                ),
                Row(
                  children: [
                    MaterialButton(
                      minWidth: 40,
                      onPressed: () {
                        setState(() {
                          currentScreen = Expenses();
                          currenttab = 0;
                        });
                      },
                      child: Column(
                        children: [
                          Icon(
                            Icons.home,
                            color: currenttab == 0
                                ? Colors.green
                                : Colors.green.shade50,
                          ),
                          Text(
                            "Expenses",
                            style: TextStyle(
                                color: currenttab == 0
                                    ? Colors.green
                                    : Colors.green.shade50),
                          )
                        ],
                      ),
                    ),
                    MaterialButton(
                      minWidth: 40,
                      onPressed: () {
                        setState(() {
                          currentScreen = Expenses();
                          currenttab = 0;
                        });
                      },
                      child: Column(
                        children: [
                          Icon(
                            Icons.home,
                            color: currenttab == 0
                                ? Colors.green
                                : Colors.green.shade50,
                          ),
                          Text(
                            "Expenses",
                            style: TextStyle(
                                color: currenttab == 0
                                    ? Colors.green
                                    : Colors.green.shade50),
                          )
                        ],
                      ),
                    )

                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
