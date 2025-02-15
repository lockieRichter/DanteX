import 'package:easy_localization/easy_localization.dart';

final DateFormat _dfMonth = DateFormat('MMMM yyyy');
final DateFormat _dfMonthShort = DateFormat('MMM yy');
final DateFormat _dfYear = DateFormat('yyyy');
final DateFormat _dfDayMonthYear = DateFormat('dd/MM/yy');
final DateFormat _dfDayMonthYearAlt = DateFormat('dd MMM yyyy');

extension DateTimeX on DateTime {
  String formatWithMonthAndYear() {
    return _dfMonth.format(this);
  }

  String formatWithMonthAndYearShort() {
    return _dfMonthShort.format(this);
  }

  String formatWithYear() {
    return _dfYear.format(this);
  }

  String formatWithDayMonthYear() {
    return _dfDayMonthYear.format(this);
  }

  String formatWithDayMonthYearAlt() {
    return _dfDayMonthYearAlt.format(this);
  }
}
