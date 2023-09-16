import 'dart:async';

import 'package:expenses/app/constants.dart';
import 'package:expenses/app/realm.dart';
import 'package:expenses/models/category.dart';
import 'package:expenses/models/expense.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:realm/realm.dart';

var recurrences = List.from(Recurrence.values);

class AddExpense extends StatefulWidget {
  const AddExpense({Key? key}) : super(key: key);

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  final TextEditingController _amountcontroller = TextEditingController();
  final TextEditingController _notecontroller = TextEditingController();
  List<Category> categories = [];
  DateTime _selecteddate = DateTime.now();
  DateTime currentTime = DateTime.now();
  var realmCategories = realm.all<Category>();
  int _selectedCategory = 0;
  StreamSubscription<RealmResultsChanges<Category>>? _categoriesSub;
  int _selectedRecurrence = 0;

  void addExpense() {
    realm.write(() => realm.add(Expense(
        ObjectId(), double.parse(_amountcontroller.text), _selecteddate,
        note: _notecontroller.text,
        category: categories[_selectedCategory],
        recurrence: recurrences[_selectedRecurrence])));
    setState(() {
      _selecteddate = DateTime.now();
      _notecontroller.clear();
      _amountcontroller.clear();
      _selectedRecurrence = 0;
    });
  }

  @override
  void initState() {
    categories = realmCategories.toList();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _categoriesSub ??= realmCategories.changes.listen((event) {
      categories = event.results.toList();
    });
    return Scaffold(
        backgroundColor: const Color.fromRGBO(181, 201, 154, 100),
        body: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 500,
            alignment: Alignment.bottomCenter,
            decoration: const BoxDecoration(
                color: Color.fromRGBO(151, 169, 124, 100),
                borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30))
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            controller: _amountcontroller,
                            decoration: const InputDecoration(
                                hintText: "Enter The Amount",

                                hintStyle:
                                TextStyle(fontSize: 17, color: Colors.black),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        width: 2,
                                        color: Colors.black,
                                        style: BorderStyle.solid
                                    ),
                                    borderRadius: BorderRadius.all(Radius.circular(10))
                                ),
                                disabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 2,
                                    color: Colors.black,
                                    style: BorderStyle.solid
                                  ),
                                  borderRadius: BorderRadius.all(Radius.circular(10))
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                    width: 10
                                  ),
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(10)))),
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              showModalBottomSheet(

                                  context: context,
                                  useSafeArea: true,
                                  builder: (context) {
                                    return CupertinoDatePicker(
                                        onDateTimeChanged: (value) {
                                          setState(() {
                                            _selecteddate = value;
                                          });
                                        }
                                    );
                                  },
                                  elevation: 1,
                                  isDismissible: true);
                            },
                            icon: const Icon(Icons.calendar_month_outlined)),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "${_selecteddate.day}/${_selecteddate.month}/${_selecteddate.year} ${_selecteddate.hour}:${_selecteddate.minute}",
                          style: GoogleFonts.dmSerifText(
                              color: Colors.black, fontSize: 20),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            maxLines: 3,
                            controller: _notecontroller,
                            decoration: InputDecoration(
                              enabledBorder:OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1,
                                      color: Colors.black,
                                      style: BorderStyle.solid
                                  ),
                                  borderRadius: BorderRadius.all(Radius.circular(10))
                              ) ,
                              focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 2,
                                      color: Colors.black,
                                      style: BorderStyle.solid
                                  ),
                                  borderRadius: BorderRadius.all(Radius.circular(10))
                              ),
                              disabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 5,
                                      color: Colors.black,
                                      style: BorderStyle.solid
                                  ),
                                  borderRadius: BorderRadius.all(Radius.circular(10))
                              ),
                              helperStyle: GoogleFonts.akshar(
                                  fontSize: 17, color: Colors.black),
                              hintText: "Enter A Note",
                            ),
                          ),
                        ),
                        IconButton(
                            onPressed: () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return CupertinoPicker(
                                        itemExtent: 32,
                                        onSelectedItemChanged: (value) {
                                          setState(() {
                                            _selectedCategory = value;
                                          });
                                        },
                                        children: List.generate(categories.length,
                                                (index) => Text(categories[index].name)));
                                  });
                            },
                            icon: const Icon(Icons.category))
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: categories.isNotEmpty
                          ? Text(
                        "Category is ${categories[_selectedCategory].name}",
                        style: GoogleFonts.roboto(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                      )
                          : const Text("No Category Yet"),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: TextButton(
                        style: ButtonStyle(
                            padding: const MaterialStatePropertyAll(EdgeInsets.all(12)),
                            shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)))),
                        onPressed: () {
                          showModalBottomSheet(
                              context: context,
                              builder: (context) {
                                return CupertinoPicker(
                                    itemExtent: 32,
                                    onSelectedItemChanged: (value) {
                                      setState(() {
                                        _selectedRecurrence = value;
                                      });
                                    },
                                    children: List.generate(recurrences.length,
                                            (index) => Text(recurrences[index])));
                              });
                        },
                        child: Text("${recurrences[_selectedRecurrence]}",style: GoogleFonts.roboto(
                          fontSize: 20,
                          color: Colors.black
                        ),),
                      ),
                    ),
                    ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor: const MaterialStatePropertyAll(
                                Color.fromRGBO(113, 131, 85, 100)                            ),
                            shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)
                                )
                            ),
                            padding: const MaterialStatePropertyAll(
                                EdgeInsets.symmetric(horizontal: 50,vertical: 16)
                            )
                        ),
                        onPressed: () {
                          if (_amountcontroller.text.isEmpty ||
                              _notecontroller.text.isEmpty ||
                              recurrences[_selectedRecurrence] == Recurrence.none) {
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text("You Left Something Empty "),
                              duration: Duration(milliseconds: 500),
                            ));
                          } else {
                            addExpense();
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text("Expense Added With Success"),
                              duration: Duration(milliseconds: 500),
                            ));
                          }
                        },
                        child: const Text("Submit Expense"))
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
