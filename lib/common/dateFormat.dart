import 'package:intl/intl.dart';

class FormatDate {
  String formatDate(String date) {
    try {
      DateTime parsedDate = DateTime.parse(date);
      var formattedDate = DateFormat.yMMMMd('id_ID').format(parsedDate);
      return formattedDate.toString();
    } catch (e) {
      return '-';
    }
  }

  String formatDate2(String date) {
    try {
      DateTime parsedDate = DateTime.parse(date);
      var formattedDate = DateFormat('dd MMM yyyy', 'id_ID').format(parsedDate);
      return formattedDate.toString();
    } catch (e) {
      return '-';
    }
  }

  static String formatDateStatic(String date) {
    try {
      DateTime parsedDate = DateTime.parse(date);
      var formattedDate =
          DateFormat('dd MMMM yyyy', 'id_ID').format(parsedDate);
      return formattedDate.toString();
    } catch (e) {
      return '-';
    }
  }

  // input date: 16-11-2015 12:06:41
  static String formatDateIdID(String date) {
    try {
      DateTime parsedDate = DateFormat("dd-MM-yyyy").parse(date);
      var formattedDate =
          DateFormat('dd MMMM yyyy', 'id_ID').format(parsedDate);
      return formattedDate.toString();
    } catch (e) {
      return '-';
    }
  }

  // input date: 16-11-2015 12:06:41
  static String formatDateEnUS(String date) {
    try {
      DateTime parsedDate = DateFormat("dd-MM-yyyy").parse(date);
      var formattedDate =
          DateFormat('dd MMMM yyyy', 'en_US').format(parsedDate);
      return formattedDate.toString();
    } catch (e) {
      return '-';
    }
  }

  static String formatDateWithTime(String date) {
    try {
      DateTime parsedDate = DateTime.parse(date);
      var formattedDate = DateFormat('dd MMM yyyy HH:mm:ss').format(parsedDate);
      return formattedDate.toString();
    } catch (e) {
      return '-';
    }
  }
   String formatDateFormatTime(String date) {
    try {
      DateTime parsedDate = DateTime.parse(date);
      var formattedDate = DateFormat('dd MMM yyyy, HH:mm').format(parsedDate);
      return formattedDate.toString();
    } catch (e) {
      return '-';
    }
  }
}
