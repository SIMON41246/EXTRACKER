import 'package:expenses/app/realm.dart';
import 'package:expenses/models/balance.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:realm/realm.dart';

class BalanceView extends StatefulWidget {
  const BalanceView({Key? key}) : super(key: key);

  @override
  State<BalanceView> createState() => _BalanceViewState();
}

class _BalanceViewState extends State<BalanceView> {
  final TextEditingController _amountcontroller = TextEditingController();
  List<Balance> data = [];
  DateTime currentdate = DateTime.now();
  DateTime selectedDate = DateTime.now();

  var balances = realm.all<Balance>();

  @override
  void initState() {
    data = balances.toList();
    super.initState();
  }

  void addToBalance() {
    realm.write(() => realm.add(Balance(
        ObjectId(), double.parse(_amountcontroller.text), selectedDate)));
    _amountcontroller.clear();
    selectedDate=DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(181, 201, 154, 100),
      body: Container(
        margin: const EdgeInsets.only(top: 200, right: 10, left: 10),
        decoration: const BoxDecoration(
            color: Color.fromRGBO(151, 169, 124, 100),

            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(18), topRight: Radius.circular(18))),
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextFormField(
              keyboardType: TextInputType.number,
              controller: _amountcontroller,
              decoration:  const InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                  borderRadius: BorderRadius.all(Radius.circular(12))
                ),
                  hintText: "Enter The Amount",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12)))),
            ),
            TextButton(
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      useSafeArea: true,
                      builder: (context) {
                        return CupertinoDatePicker(onDateTimeChanged: (value) {
                          setState(() {
                            selectedDate = value;
                          });
                        });
                      },
                      elevation: 1,
                      isDismissible: true);
                },
                child:  Text("Select The Time ",style: GoogleFonts.roboto(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,

                ),)),
            const SizedBox(
              height: 10,
            ),
            Text(
              "time is ${selectedDate.year}/${selectedDate.month}/${selectedDate.day} ${selectedDate.hour}:${selectedDate.minute}",
              style: GoogleFonts.roboto(color: Colors.black, fontSize: 20),
            ),
            const SizedBox(
              height: 25,
            ),
            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: const MaterialStatePropertyAll(
                        Color.fromRGBO(113, 131, 85, 100)),
                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20))),
                    padding: const MaterialStatePropertyAll(
                        EdgeInsets.symmetric(horizontal: 50, vertical: 16))),
                onPressed: () {
                  if (_amountcontroller.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Something Went Wrong"),
                      duration: Duration(milliseconds: 500),
                    ));
                  } else {
                    addToBalance();
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Balance  Added With Success"),
                      duration: Duration(milliseconds: 500),
                    ));
                  }
                },
                child: const Text("Add To Balance"))
          ],
        ),
      ),
    );
  }
}
