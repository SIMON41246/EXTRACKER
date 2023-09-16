import 'package:expenses/app/realm.dart';
import 'package:expenses/models/category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';

class Categories extends StatefulWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  List<Category> categories = [];
  TextEditingController _controller = TextEditingController();
  Color currentColor = Colors.purple;
  Color selectedColor = Colors.purple;

  @override
  void initState() {
    categories = realm.all<Category>().toList();

    super.initState();
  }

  void addCategory() {
    if (_controller.text.isNotEmpty) {
      var newCatecory = realm.write(
          () => realm.add(Category(_controller.text, selectedColor.value)));
      setState(() {
        categories.add(newCatecory);
        _controller.text = "";
      });
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Enter A Category"),duration: Duration(seconds: 1),));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        centerTitle: true,
        title: const Text("Categories"),
      ),
      body: Stack(
        children: [
          ListView.builder(
              itemCount: categories.length,
              itemBuilder: (context, index) {
                return ListTile(
                  trailing: IconButton(
                    onPressed: () {
                      setState(() {
                        realm.write(() => realm.delete(categories[index]));
                        categories.removeAt(index);
                      });
                    },
                    icon: Icon(Icons.delete),
                  ),
                  leading: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: categories[index].color),
                  ),
                  title: Text(categories[index].name),
                );
              }),
          SafeArea(
              bottom: true,
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                      child: Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                            color: selectedColor, shape: BoxShape.circle),
                      ),
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: Text("Got it"),
                                    style: ButtonStyle(
                                        textStyle: MaterialStatePropertyAll(
                                            GoogleFonts.dmSerifDisplay(
                                                color: Colors.black))),
                                  )
                                ],
                                content: SingleChildScrollView(
                                  child: ColorPicker(
                                    paletteType: PaletteType.hsv,
                                    pickerColor: selectedColor, //default color
                                    onColorChanged: (Color color) {
                                      //on color picked
                                      setState(() {
                                        selectedColor = color;
                                      });
                                    },
                                  ),
                                ),
                              );
                            });
                      },
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    Expanded(
                        child: TextFormField(
                      controller: _controller,
                      decoration: InputDecoration(
                          hintText: "Enter A Category",
                          hintStyle: GoogleFonts.dmSerifDisplay(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.bold)),
                    )),
                    IconButton(
                        onPressed: () {
                          addCategory();
                        },
                        icon: Icon(Icons.send))
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
