import 'package:date_format/date_format.dart';
import 'package:timeago/timeago.dart' as timeago;

mixin FormatterMixin {
  String formatLog(DateTime dateTime) {
    final today = DateTime.now();
    if (today.difference(dateTime).inDays == 0 && today.day == dateTime.day)
      return 'Today';
    else if (today.difference(dateTime).inDays <= 1 &&
        today.day - 1 == dateTime.day)
      return 'Yesterday';
    else
      return formatDate(dateTime, [M, ' ', dd, ', ', yyyy]);
  }

  String formatTime(DateTime dateTime) {
    return formatDate(dateTime, [hh, ':', nn, ' ', am]);
  }

  static String formatDMY(DateTime dateTime) {
    return formatDate(dateTime, [dd, ' ', M, ' ', yyyy]);
  }

  String formatFull(DateTime dateTime) {
    return formatDate(dateTime, [dd, ' ', M, ' ', yyyy]);
  }

  String formatMY(DateTime dateTime) {
    return formatDate(dateTime, [M, ' ', yyyy]);
  }

  String formatMD(DateTime dateTime) {
    return formatDate(dateTime, [M, ' ', dd]);
  }

  String formatY(DateTime dateTime) {
    return formatDate(dateTime, [yyyy]);
  }

  String formatCustom(DateTime dateTime) {
    final diff = DateTime.now().difference(dateTime).inHours;
    if (diff < 24 || diff > -24)
      return 'Present';
    else
      return formatMY(dateTime);
  }

  String formatRangeMY(DateTime fromDate, DateTime toDate, {separator = '-'}) {
    return '${formatMY(fromDate)}$separator${formatMY(toDate)}';
  }

  String formatRangeY(DateTime fromDate, DateTime toDate, {separator = '-'}) {
    return '${formatY(fromDate)}$separator${formatY(toDate)}';
  }

  String formatRangeCustom(DateTime fromDate, DateTime toDate,
      {separator = '-'}) {
    return '${formatCustom(fromDate)}$separator${formatCustom(toDate)}';
  }

  String iFormatMY(int date) {
    return formatMY(DateTime.fromMillisecondsSinceEpoch(date));
  }

  String iFormatY(int date) {
    return formatY(DateTime.fromMillisecondsSinceEpoch(date));
  }

  String iFormatCustom(int date) {
    return formatCustom(DateTime.fromMillisecondsSinceEpoch(date));
  }

  String iFormatRangeMY(int fromDate, int toDate, {separator = '-'}) {
    return '${iFormatMY(fromDate)}$separator${iFormatMY(toDate)}';
  }

  String iFormatRangeY(int fromDate, int toDate, {separator = '-'}) {
    return '${iFormatY(fromDate)}$separator${iFormatY(toDate)}';
  }

  String iFormatRangeCustom(int fromDate, int toDate, {separator = '-'}) {
    return '${iFormatCustom(fromDate)}$separator${iFormatCustom(toDate)}';
  }

  String formatFileSize(int bytes) {
    final k = 1024;
    final m = k * k;
    final g = m * k;
    if (bytes <= 1) return '$bytes Byte';
    if (bytes < k) return '$bytes Bytes';
    if (bytes < m) return '${(bytes / (k)).toStringAsFixed(1)} KB';
    if (bytes < g) return '${(bytes / (m)).toStringAsFixed(1)} MB';
    return '${(bytes / (g)).toStringAsFixed(1)} GB';
  }

  String formatProper(DateTime date,[showTimeAlways=false]) {
    final now = DateTime.now();
    final showYear = date.year != now.year;
    final showTime = now.difference(date).inDays < 3;

    final time = [', ', hh, ':', nn, ' ', am];
    final year = [',', yyyy];
    return formatDate(date, [
      M,
      ' ',
      dd,
      if (showYear) ...year,
      if (showTimeAlways||showTime) ...time,
    ]);
  }
  String formatProperShort(DateTime date) {
    final now = DateTime.now();
    final showYear = date.year != now.year;
    final showTime = now.difference(date).inDays < 2;

    final time = [hh, ':', nn, ' ', am];
    final year = [',', yyyy];
    return formatDate(date, showTime?time:[
      M,
      ' ',
      dd,
      if (showYear) ...year,
    ]);
  }

  String formatAgoShort(DateTime dateTime) {
    return timeago.format(dateTime, locale: 'en_short');
  }

  String formatAgo(DateTime dateTime) {
    if (dateTime == null) return '';
    return timeago.format(dateTime);
  }

  String formatAgoRecent(DateTime dateTime) {
    final duration = DateTime.now().difference(dateTime);
    if (duration.inHours < 24) return formatAgo(dateTime);
    return formatProper(dateTime,true);
  }

  String formatAgoAndProper(DateTime dateTime) {
    final duration = DateTime.now().difference(dateTime);
    if (duration.inHours < 24) return formatAgo(dateTime);
    return formatProper(dateTime);
  }

  String formatBalance(double balance) {
    if (balance == null) return "0";
    return balance.floor().toDouble() == balance
        ? balance.floor().toString()
        : balance.toString();
  }

  String formatWeekDay(int weekday) {
    switch (weekday.toInt()) {
      case 1:
        return 'Monday';
      case 2:
        return 'Tuesday';
      case 3:
        return 'Wednesday';
      case 4:
        return 'Thursday';
      case 5:
        return 'Friday';
      case 6:
        return 'Saturday';
      case 7:
        return 'Sunday';
    }
    throw 'Invalid argument';
  }
  DateTime getDateTime(String dateString) {
    List<String> split = dateString.split('T');
    List<String> date = split[0].split('-');
    List<String> time = split[1].split(':');
    List<String> second = time[2].split('.');
    return DateTime(int.parse(date[0]), int.parse(date[1]), int.parse(date[2]),
        int.parse(time[0]), int.parse(time[1]), int.parse(second[0]));
  }

}
