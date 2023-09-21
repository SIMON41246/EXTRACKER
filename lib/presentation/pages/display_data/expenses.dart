import 'dart:async';

import 'package:collection/collection.dart';
import 'package:expenses/app/realm.dart';
import 'package:expenses/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:realm/realm.dart';
import 'package:unity_ads_plugin/unity_ads_plugin.dart';


class Expenses extends StatefulWidget {
  const Expenses({Key? key}) : super(key: key);

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  var expenses = realm.all<Expense>();
  List<Expense> data = [];
  StreamSubscription<RealmResultsChanges<Expense>>? _expensesSub;
  double convertedAmount = 0.0;

  double get _total => data.map((expense) => expense.amount).sum;

  @override
  void initState() {
    data = expenses.toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _expensesSub ??= expenses.changes.listen((changes) {
      setState(() {
        data = changes.results.toList();
      });
    });
    double priceconverted=_total*0.93;


    return Scaffold(
      backgroundColor: const Color.fromRGBO(181, 201, 154, 100),
      body: Stack(
        children:[
          Container(
            margin: const EdgeInsets.only(top: 190),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(topRight: Radius.circular(50),topLeft: Radius.circular(50)),
                color: Color.fromRGBO(151, 169, 124, 100)
            ),
            child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(top: 18.0, left: 8, right: 8),
                  child: data.isNotEmpty
                      ? Column(
                    children: [
                      Text(
                        ("Total Expenses"),
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
                            Text("${priceconverted.toStringAsFixed(2)} £",style: GoogleFonts.roboto(
                                color: Colors.black,
                                fontSize: 30
                            ),)
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              data.sort((a, b) => a.date.millisecondsSinceEpoch
                                  .compareTo(b.date.millisecondsSinceEpoch));
                              return ListTile(


                                title: Text(
                                  data[index].category!.name,
                                  style: GoogleFonts.roboto(
                                      color: data[index].category?.color),
                                ),
                                subtitle: Text(data[index].amount.toString()),
                                leading: IconButton(
                                  icon: const Icon(Icons.delete),
                                  onPressed: () {
                                    setState(() {
                                      realm.write(() => realm.delete(data[index]));
                                      data.removeAt(index);
                                    });
                                  },
                                ),
                                trailing: Text(
                                    "${data[index].date.year}/${data[index].date.month}/${data[index].date.day} ${data[index].date.hour}:${data[index].date.minute}"),
                              );
                            }),
                      ),

                    ],
                  )
                      :  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Center(child: Text("No Expense Yet",style: GoogleFonts.roboto(
                          fontSize: 30,
                          color: Colors.black
                      ),)),
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
                                  Text("1- Go to Categories : Add Categories Or Expense Type ",style: GoogleFonts.roboto(
                                      fontSize: 30,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold
                                  ),),
                                  SizedBox(height: 10,),

                                  Text("2- Go to Add  page And Type the expenses That You need To Save\n",style: GoogleFonts.roboto(
                                      fontSize: 30,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold

                                  ),),
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

                      ),
                       UnityBannerAd(
                         placementId: 'Banner_Android',
                         onLoad: (placementId) => print('Banner loaded: $placementId'),
                         onClick: (placementId) => print('Banner clicked: $placementId'),
                         onFailed: (placementId, error, message) => print('Banner Ad $placementId failed: $error $message'),
                       )

                    ],
                  ),
                )),
          ),
        ]
      ),
    );
  }
}


