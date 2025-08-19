import 'package:flutter/material.dart';

class DataColumnSearch extends StatelessWidget {
  const DataColumnSearch(
      {super.key,
      this.onSearchChaged,
      required this.columnname,
      this.isSearch = false,
      this.width,
      this.columnFontColor,
      this.columnInputColor});
  final ValueChanged<String>? onSearchChaged;
  final double? width;
  final String columnname;
  final Color? columnFontColor;
  final Color? columnInputColor;
  final bool isSearch;
  @override
  Widget build(BuildContext context) {
    return isSearch
        ? Column(
            children: [
              Text(
                columnname,
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: columnFontColor ?? Colors.white),
              ),
              Container(
                  decoration: BoxDecoration(
                    color: columnInputColor ?? Colors.grey.withOpacity(0.3),
                    boxShadow: [
                      BoxShadow(
                          offset: const Offset(0, 6),
                          color: const Color(0xFFA4A6B3).withOpacity(.1),
                          blurRadius: 12)
                    ],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  height: 30,
                  width: width ?? 150,
                  child: TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.blueGrey[50],
                      contentPadding: const EdgeInsets.only(left: 30),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueGrey[50]!),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blueGrey[50]!),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onChanged: onSearchChaged,
                    // decoration: const InputDecoration(
                    //   fillColor: Colors.white,
                    //   hintStyle: TextStyle(
                    //     color: Color.fromARGB(0, 146, 146, 146),
                    //   ),
                    // )
                  ))
            ],
          )
        : SizedBox(
            width: width ?? 110,
            child: Text(
              columnname,
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: columnFontColor ?? Colors.white),
            ),
          );
  }
}
