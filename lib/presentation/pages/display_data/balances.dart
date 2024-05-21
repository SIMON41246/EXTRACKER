import 'package:collection/collection.dart';
import 'package:expenses/models/balance.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

import '../../../app/realm.dart';

class Balances extends StatefulWidget {
  const Balances({Key? key}) : super(key: key);

  @override
  State<Balances> createState() => _BalancesState();
}

class _BalancesState extends State<Balances> {
  List<Balance> data = [];
  var balances = realm.all<Balance>();

  double get _total => data.map((balance) => balance.amount).sum;

  @override
  void initState() {
    data = balances.toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double priceconverted = _total * 0.93;

    return Scaffold(
      backgroundColor: const Color.fromRGBO(181, 201, 154, 100),

      body: Container(
        margin: const EdgeInsets.only(top: 190),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(50), topLeft: Radius.circular(50)),
            color: Color.fromRGBO(151, 169, 124, 100)
        ),
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.only(top: 18.0, left: 8, right: 8),
          child: data.isNotEmpty
              ? Column(
                  children: [
                    Text(
                      ("Balance"),
                      style:
                          GoogleFonts.roboto(color: Colors.black, fontSize: 20),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    ConstrainedBox(
                      constraints: const BoxConstraints(minHeight: 50),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("$_total \$",
                              style: GoogleFonts.roboto(
                                  color: Colors.black, fontSize: 30)),
                          Text(
                            "${priceconverted.toStringAsFixed(2)} £",
                            style: GoogleFonts.roboto(
                                color: Colors.black, fontSize: 30),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, index) {

                            return ListTile(
                              title: Text(
                                data[index].amount.toStringAsFixed(2),
                                style: GoogleFonts.roboto(
                                    color: Colors.green.shade500),
                              ),
                              subtitle: Text(data[index].amount.toString()),
                              leading: IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  setState(() {
                                    showDialog(context: context, builder: (context){
                                      return AlertDialog(
                                        title: const Text("Are You Sure"),
                                        content: Text("You Want To Delete payment added on ${data[index].dateTime.year}/${data[index].dateTime.month}/${data[index].dateTime.day} ${data[index].dateTime.hour}:${data[index].dateTime.minute}"),
                                        actions: [
                                          TextButton(onPressed: (){
                                            setState(() {
                                              realm
                                                  .write(() => realm.delete(data[index]));
                                              data.removeAt(index);
                                              Get.back();


                                            });
                                          }, child: Text("Yes")),
                                          TextButton(onPressed: (){
                                            setState(() {
                                              Get.back();
                                            });
                                          }, child: Text("No"))
                                        ],
                                      );
                                    });
                                  });
                                },
                              ),
                              trailing: Text(
                                  "${data[index].dateTime.year}/${data[index].dateTime.month}/${data[index].dateTime.day} ${data[index].dateTime.hour}:${data[index].dateTime.minute}"),
                            );
                          }),
                    ),
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                        child: Text(
                      "No Payment Added Yet",
                      style:
                          GoogleFonts.roboto(fontSize: 30, color: Colors.black),
                    )),
                    Lottie.asset("assets/nothing.json",width: 200),
                    Align(
                      alignment: Alignment.bottomRight,
                      child:                       TextButton(onPressed: (){
                        showModalBottomSheet(context: context, builder: (context){
                          return  AlertDialog(
                            actions: [
                              TextButton(onPressed: (){
                                Get.back();
                              }, child: Text("Ok",style: GoogleFonts.roboto(
                                color: Colors.black,
                                fontSize: 15,
                              ),))
                            ],
                            shape:RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)
                            ),
                            content: Column(
                              children: [
                                Text("1- Go to Add Page : Add To Balance ",style: GoogleFonts.roboto(
                                    fontSize: 30,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold
                                ),),
                                SizedBox(height: 10,),


                                SizedBox(height: 10,),

                              ],
                            ),
                          );
                        });
                      }, child: Container(
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.all(Radius.circular(12))
                        ),
                        child: Text("Get Help",style: GoogleFonts.roboto(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                        ),),
                      )),

                    )

                  ],
                ),
        )),
      ),
    );
  }
}
