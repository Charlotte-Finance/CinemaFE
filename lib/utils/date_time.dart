import 'package:intl/intl.dart';

String? convertDateTimeDisplay(String? date) {
  if (date == null){
    return null;
  }
  final DateFormat serverFormatter = DateFormat('yyyy-MM-dd');
  final String formatted = serverFormatter.format(DateTime.parse(date));
  return formatted;

}