import 'package:intl/intl.dart';

class Utilities {
  DateTime convertDateStringToDatetime(String strDatetime) {
    String year = strDatetime.substring(0, 4);
    String mon = strDatetime.substring(4, 6);
    String date = strDatetime.substring(6, 8);
    String hh = strDatetime.substring(8, 10);
    String mm = strDatetime.substring(10, 12);
    String ss = strDatetime.substring(12, 14);
    String start = '$year-$mon-$date $hh:$mm:$ss';

    return DateFormat("yyyy-MM-dd hh:mm:ss").parse(start);
  }
}
