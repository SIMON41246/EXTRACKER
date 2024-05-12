import 'package:expenses/models/category.dart';
import 'package:expenses/models/expense.dart';
import 'package:expenses/presentation/common/color_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:realm/realm.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final expense = Expense(ObjectId(), 15.02, DateTime.now(),
      note: "Good", category: Category("FlatMates", 1233456));

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        bottom: true,
        top: true,
        child: Scaffold(
          backgroundColor: Colors.grey.shade200,
          body: Padding(
            padding: EdgeInsets.only(left: 14.0.r, right: 14.r, top: 15.r),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Home",
                    style: GoogleFonts.roboto(fontSize: 15.sp),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14.r)),
                    width: double.infinity,
                    height: 130.h,
                    child: Padding(
                      padding:
                          EdgeInsets.only(top: 20.r, right: 15.r, left: 15.r),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Your Expenses",
                                style: GoogleFonts.roboto(
                                  fontSize: 15.sp,
                                ),
                              ),
                              Text(
                                "£308",
                                style: GoogleFonts.roboto(
                                    fontSize: 20.sp,
                                    color: Colors.green.shade800),
                              ),
                              Row(
                                children: [
                                  Text(
                                    "See Your Monthly report",
                                    style: GoogleFonts.roboto(
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.normal),
                                  ),
                                  SizedBox(
                                    width: 4.w,
                                  ),
                                  Icon(Icons.chevron_right_sharp)
                                ],
                              )
                            ],
                          ),
                          Image.asset(
                            "assets/images/statistics.png",
                            height: 100.h,
                            width: 100.w,
                          )
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 160.w,
                        height: 80.h,
                        decoration: BoxDecoration(
                          color: Colors.red.shade100,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "You Own",
                              style: GoogleFonts.roboto(
                                  fontSize: 15.sp, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Text("£32.25",
                                style: GoogleFonts.roboto(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.normal))
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Container(
                        width: 160.w,
                        height: 80.h,
                        decoration: BoxDecoration(
                          color: Colors.green.shade100,
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "You are owed",
                              style: GoogleFonts.roboto(
                                  fontSize: 15.sp, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            Text("£32.25",
                                style: GoogleFonts.roboto(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.normal))
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Recent Expenses",
                        style: GoogleFonts.roboto(
                            fontSize: 20.sp, fontWeight: FontWeight.bold),
                      ),
                      TextButton(
                          onPressed: () {},
                          child: Text(
                            "See All",
                            style: GoogleFonts.roboto(fontSize: 10.sp),
                          ))
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    height: 250.h,
                    child: ListView.separated(
                      itemCount: 2,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return ListTile(
                          tileColor: Colors.white,
                          onTap: () {},
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.r)),
                          title: Text(
                            "Expense1",
                            style: GoogleFonts.roboto(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          leading: CircleAvatar(
                            child: Image.asset("assets/images/statistics.png"),
                            backgroundColor: Colors.transparent,
                          ),
                          subtitle: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Courtney Paid",
                                    style: GoogleFonts.roboto(fontSize: 12.sp),
                                  ),
                                  SizedBox(
                                    width: 4.w,
                                  ),
                                  Text(
                                    "25£",
                                    style: GoogleFonts.roboto(
                                        fontSize: 12.sp,
                                        color: Colors.red.shade800),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 4.h,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Categoried as",
                                    style: GoogleFonts.roboto(fontSize: 12.sp),
                                  ),
                                  SizedBox(
                                    width: 4.w,
                                  ),
                                  Container(
                                    child: Center(
                                        child: Text(
                                      "market",
                                      style: GoogleFonts.roboto(
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green.shade800),
                                    )),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      borderRadius: BorderRadius.circular(12.r),
                                      border: Border.all(
                                          width: 1,
                                          color: Colors.green.shade800,
                                          style: BorderStyle.solid),
                                    ),
                                    padding: EdgeInsets.all(4.r),
                                    width: 50.w,
                                  )
                                ],
                              ),
                            ],
                          ),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "total",
                                style: GoogleFonts.roboto(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              SizedBox(
                                height: 4.h,
                              ),
                              Text("+£9.60",
                                  style: GoogleFonts.roboto(
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green.shade800))
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(height: 8.0.h);
                      },
                    ),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Frequently Used Groups",
                        style: GoogleFonts.roboto(
                            fontSize: 20.sp, fontWeight: FontWeight.bold),
                      ),
                      TextButton(
                          onPressed: () {},
                          child: Text(
                            "See All",
                            style: GoogleFonts.roboto(fontSize: 10.sp),
                          ))
                    ],
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Container(
                    height: 450.h,
                    child: GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 8.0,
                      ),
                      itemCount: 4, // Total number of items
                      itemBuilder: (BuildContext context, int index) {
                        // Your item widgets here
                        return Container(
                          padding: EdgeInsets.all(12.r),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(color: Colors.black, blurRadius: 0.5)
                              ]),
                          child: Column(
                            children: [
                              Text(
                                "Flatmates",
                                style: GoogleFonts.roboto(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Container(
                                width: 70.w,
                                height: 70.h,
                                decoration:
                                    BoxDecoration(shape: BoxShape.circle),
                                child:
                                    Image.asset("assets/images/statistics.png"),
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              Text("total",
                                  style: GoogleFonts.roboto(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(
                                height: 3.h,
                              ),
                              Text("+£9.60",
                                  style: GoogleFonts.roboto(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}