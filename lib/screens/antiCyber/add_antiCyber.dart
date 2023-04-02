import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pro_test/resources/color_manager.dart';

import '../../resources/values_manager.dart';

class AddAntiCyber extends StatelessWidget {
  const AddAntiCyber({super.key, this.title});
  final String? title;

  @override
  Widget build(BuildContext context) {
    final List<String> items = [
      'Item1',
      'Item2',
      'Item3',
      'Item4',
      'Item5',
      'Item6',
      'Item7',
      'Item8',
    ];
    String? selectedValue;
    return Scaffold(
      backgroundColor: ColorManager.secondary,
      appBar: AppBar(
        title: Text(title!),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: DropdownButtonHideUnderline(
                  child: DropdownButton2(
                    isExpanded: true,
                    hint: Row(
                      children: const [
                        // Icon(
                        //   Icons.arrow_drop_down,
                        //   size: 50,
                        //   color: Colors.black,
                        // ),
                        SizedBox(
                          width: 4,
                        ),
                        Expanded(
                          child: Text(
                            'Select Item',
                            style: TextStyle(
                              fontSize: 20,
                              //fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    items: items
                        .map((item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(
                                item,
                                style: const TextStyle(
                                  fontSize: 14,
                                  // fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ))
                        .toList(),
                    value: selectedValue,
                    onChanged: (value) {
                      // setState(() {
                      //   selectedValue = value as String;
                      // });
                    },
                    buttonStyleData: ButtonStyleData(
                      height: 50,
                      width: double.infinity,
                      padding: const EdgeInsets.only(left: 14, right: 14),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          width: 3,
                          color: ColorManager.white,
                        ),
                        color: ColorManager.primary,
                      ),
                      elevation: 2,
                    ),
                    dropdownStyleData: DropdownStyleData(
                        maxHeight: 200,
                        width: double.infinity,
                        padding: null,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: ColorManager.primary,
                        ),
                        elevation: 8,
                        offset: const Offset(-20, 0),
                        scrollbarTheme: ScrollbarThemeData(
                          radius: const Radius.circular(40),
                          thickness: MaterialStateProperty.all(6),
                          thumbVisibility: MaterialStateProperty.all(true),
                        )),
                    menuItemStyleData: const MenuItemStyleData(
                      height: 40,
                      padding: EdgeInsets.only(left: 14, right: 14),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                maxLines: 8,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: ColorManager.primary,
                  focusColor: ColorManager.black,
                  hoverColor: ColorManager.black,
                  labelText: 'labelText',
                  labelStyle: TextStyle(
                      color: ColorManager.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: ColorManager.white, width: AppSize.s3),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: ColorManager.white, width: 3),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  style: const ButtonStyle(
                      side: MaterialStatePropertyAll(
                          BorderSide(color: Colors.white, width: 3)),
                      minimumSize:
                          MaterialStatePropertyAll(Size(double.infinity, 50))),
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Add Photo',
                        style: TextStyle(color: ColorManager.white),
                      ),
                      Icon(
                        Icons.camera_alt_outlined,
                        color: ColorManager.white,
                      ),
                    ],
                  )),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  style: const ButtonStyle(
                      side: MaterialStatePropertyAll(
                          BorderSide(color: Colors.white, width: 3)),
                      minimumSize:
                          MaterialStatePropertyAll(Size(double.infinity, 50))),
                  onPressed: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Add Link',
                        style: TextStyle(color: ColorManager.white),
                      ),
                      Icon(FontAwesomeIcons.link, color: ColorManager.white),
                    ],
                  )),
              const SizedBox(
                height: 50,
              ),
              ElevatedButton(
                style: const ButtonStyle(
                    side: MaterialStatePropertyAll(
                        BorderSide(color: Colors.white, width: 3)),
                    minimumSize: MaterialStatePropertyAll(Size(150, 50))),
                onPressed: () {
                  print('object');
                },
                child: Text(
                  'Send complaint',
                  style: TextStyle(color: ColorManager.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
