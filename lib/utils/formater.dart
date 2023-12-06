import 'package:intl/intl.dart';

class Formatter{
  String numFormat(dynamic num) => num != null ? NumberFormat.decimalPattern().format(num) : '';
  String dateFormat(DateTime? date) => date != null ? DateFormat('dd-MM-yyyy').format(date) : '';
  String dateFormatStandard(DateTime? date) => date != null ? DateFormat('yyyy-MM-dd').format(date) : '';
  String dateFormatStandardLaos(DateTime? date) => date != null ? DateFormat.yMMMMd('lo').format(date) : '';
  String timeFormat(DateTime? time) => time != null ? DateFormat('HH:mm').format(time) : '';
  String formatMonthLaos(DateTime? month) => month != null ? DateFormat.MMMM('lo').format(month) : '';
}