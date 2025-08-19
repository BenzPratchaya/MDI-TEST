import 'package:intl/intl.dart';

import '../helpers/constants.dart';
import '../models/routing_model.dart';

extension StringExtensions on String {
  RoutingData get getRoutingData {
    var uriData = Uri.parse(this);
    return RoutingData(
      queryParameter: uriData.queryParameters,
      route: uriData.path,
    );
  }

  String format(String format, String separate) =>
      interpolate(this, format, separate);

  String quillToHtmlBase() {
    String htmlBase = "";
    htmlBase = replaceAll('\t', '&nbsp;');

    // print('htmlBase: $htmlBase');
    // print('|||||||||||||||||||||||||||||||||||||');
    const pattern = r'<ol>(?<ol>.*?)</ol>';
    final regExp = RegExp(pattern, multiLine: true);
    htmlBase = htmlBase.replaceAllMapped(regExp, (match) {
      String resultRpl = match.group(0).toString();
      const patternLiNumber = r'<li data-list="ordered">(?<liNumber>.*?)</li>';
      final regExpLiNumber = RegExp(patternLiNumber, multiLine: true);

      final resultLi = resultRpl.replaceAllMapped(regExpLiNumber, (mNumber) {
        var resNum = mNumber.group(0);
        resNum = resNum!
            .replaceAll('<li data-list="ordered">', '<li>')
            .replaceAll(
                '<span class="ql-ui" contenteditable="false"></span>', '');
        return resNum;
      });
      const patternLiBullet = r'<li data-list="bullet">(?<liNumber>.*?)</li>';
      final regExpLiBullet = RegExp(patternLiBullet, multiLine: true);

      final rBullet = resultLi.replaceAllMapped(regExpLiBullet, (mBullet) {
        var resBullet = mBullet.group(0);
        resBullet = resBullet!
            .replaceAll('<li data-list="bullet">', '<ul>')
            .replaceAll('</li>', '</ul>')
            .replaceAll(
                '<span class="ql-ui" contenteditable="false"></span>', '');
        return resBullet;
      });

      return rBullet;
    });

    const patternFontSize = r'<span class="ql-size(?<size>.*?)</span>';
    final regExpSize = RegExp(patternFontSize, multiLine: true);
    htmlBase = htmlBase.replaceAllMapped(regExpSize, (match) {
      String resultRpl = match.group(0).toString();
      return resultRpl
          .replaceAll('<span class="ql-size-', '<font size="')
          .replaceAll('</span>', '</font>');
    });
    const patternAlignment = r'<p class="ql-align-(?<align>.*?)</p>';
    final regExpAlign = RegExp(patternAlignment, multiLine: true);
    htmlBase = htmlBase.replaceAllMapped(regExpAlign, (match) {
      String resultRpl = match.group(0).toString();
      return resultRpl.replaceAll('<p class="ql-align-', '<p align="');
    });
    const patternIndent = r'<p class="ql-indent-(?<indent>.*?)</p>';
    final regExpIndent = RegExp(patternIndent, multiLine: true);
    htmlBase = htmlBase.replaceAllMapped(regExpIndent, (match) {
      String resultRpl = match.group(0).toString();
      String sub1 = resultRpl.replaceAll(RegExp(r'<p class="ql-indent-'), '');
      String sub2 = sub1.substring(0, sub1.indexOf('"'));
      int forSpace = int.parse(sub2);
      String spaceTab = '';

      for (var i = 0; i < forSpace; i++) {
        spaceTab += '&nbsp;&nbsp;&nbsp;&nbsp;';
      }

      return resultRpl.replaceAll(
          '<p class="ql-indent-$forSpace">', '<p>$spaceTab');
    });
    return htmlBase;
  }

  String htmlToQuillHtml() {
    String htmlBase = "";
    htmlBase = replaceAll('<br>', '&nbsp;<br>');
    htmlBase = htmlBase
        .replaceAll(RegExp(r'<font[^>]*>'), '')
        .replaceAll('</font>', '');
    return htmlBase;
  }
}

String interpolate(String string, String format, String separate) {
  if (format.replaceAll(separate, '').length > string.length) {
    return string;
  } else {
    String result = '';
    final split = format.split(separate);
    int location = 0;
    for (String item in split) {
      result += string.substring(location, item.length + location);
      result += separate;
      location += item.length;
    }
    result = result.substring(0, result.length - 1);
    return result;
  }
}

extension DoubleExtension on double {
  String formatDecimalPattern() => NumberFormat.decimalPattern().format(this);
  String formatDecimalTwoDigit() =>
      NumberFormat("#,###.00", "en_US").format(this);
}

extension DatetimeExtension on DateTime {
  String formatDateTimeSave() =>
      DateFormat(EnvisionFormat.saveFormattedDate).format(this);
  // String formatDatetimePattern() =>
  //     DateFormat(EnvisionFormat.searchFormattedDate).format(this);
  String formatDateisplay() =>
      DateFormat(EnvisionFormat.displayFormattedDate).format(this);
  String formatDateTimeDisplay() =>
      DateFormat(EnvisionFormat.displayFormattedDateTime).format(this);
  String formatDateTime(format) => DateFormat(format).format(this);
  String formatDateTimeDisplayDatePicker() =>
      DateFormat('d MMM, yyyy').format(this);
  String formatDateTimeDisplayTimePicker() => DateFormat('HH:mm').format(this);
  String compareFormattedDateTime() =>
      DateFormat(EnvisionFormat.saveFormattedDate).format(this);
  String formatDateTimeStringFormat() =>
      DateFormat('dd/MM/yyyy HH:mm').format(this);
  String formatDateTimeSaveStringFormat() =>
      DateFormat('yyyyMMddHHmmss').format(this);
  String formatDateSaveStringFormat() => DateFormat('yyyyMMdd').format(this);
}

extension IterableExtension<T> on Iterable<T> {
  Iterable<T> distinctBy(Object Function(T e) getCompareValue) {
    var result = <T>[];
    for (var element in this) {
      if (!result.any((x) => getCompareValue(x) == getCompareValue(element))) {
        result.add(element);
      }
    }

    return result;
  }
}
