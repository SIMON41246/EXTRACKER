import 'package:expenses/presentation/pages/add/main_add.dart';
import 'package:expenses/presentation/pages/reports.dart';
import 'package:expenses/presentation/pages/settings.dart';
import 'package:flutter/material.dart';
import 'package:expenses/presentation/pages/display_data/home.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int index = 0;
  List<Widget> pages = [
    const HomeView(),
    const Add(),
    const Reports(),
    const Settings()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages.elementAt(index),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        unselectedItemColor: Colors.black,
        selectedItemColor: const Color.fromRGBO(113, 131, 85,100),
        backgroundColor: Colors.black,
        onTap: (currentIndex) {
          setState(() {
            index = currentIndex;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Expenses"),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: "Add"),
          BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart), label: "Reports"),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: "settings"),
        ],
      ),
    );
  }
}
