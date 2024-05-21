import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

Widget CustomExpenseCard(){
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
}