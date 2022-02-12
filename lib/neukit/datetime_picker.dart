import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:moment/flutter_moment.dart';

class CustomDatetimePicker extends CommonPickerModel {
  DateTime nextTime(int left, int middle, int right) {
    var today = DateTime.now();
    return DateTime(
      today.year,
      today.month,
      today.day + left,
      middle,
      right * stepMinute,
    );
  }

  String digits(int value, int length) {
    return '$value'.padLeft(length, "0");
  }

  int dateDiff(DateTime dt) {
    var moment = Moment();
    var today = moment.datePushedTo(floor: true);
    dt = moment.datePushedTo()(from: dt, floor: true);
    return dt.difference(today).inDays;
  }

  bool isBeforeMinTime(DateTime dt) {
    if (minTime != null) {
      return dt.isBefore(minTime!);
    } else {
      return false;
    }
  }

  bool isAfterMaxTime(DateTime dt) {
    if (maxTime != null) {
      return dt.isAfter(maxTime!);
    } else {
      return false;
    }
  }

  DateTime? minTime;
  DateTime? maxTime;

  int minHour;
  int maxHour;
  int stepMinute;

  CustomDatetimePicker({
    DateTime? currentTime,
    LocaleType? locale,
    this.minTime,
    this.maxTime,
    this.minHour = 0,
    this.maxHour = 23,
    this.stepMinute = 15,
  }) : super(locale: locale) {
    DateTime dt = currentTime ?? DateTime.now();
    if (minTime != null && dt.isBefore(minTime!)) {
      dt = minTime!;
    } else if (maxTime != null && dt.isAfter(maxTime!)) {
      dt = maxTime!;
    }

    this.currentTime = dt;
    setLeftIndex(dateDiff(this.currentTime));
    setMiddleIndex(this.currentTime.hour);
    setRightIndex(0);
  }

  @override
  String? leftStringAtIndex(int index) {
    DateTime today = DateTime.now();
    DateTime nextTime = this.nextTime(
      index,
      currentMiddleIndex(),
      currentRightIndex(),
    );

    if (isBeforeMinTime(nextTime) || isAfterMaxTime(nextTime)) {
      return null;
    } else if (dateDiff(nextTime) == 0) {
      return 'Today';
    } else if (today.year == nextTime.year) {
      DateFormat formatter = DateFormat('E MMM dd');
      return formatter.format(nextTime);
    } else {
      DateFormat formatter = DateFormat('E MMM dd yyyy');
      return formatter.format(nextTime);
    }
  }

  @override
  String? middleStringAtIndex(int index) {
    if (index >= minHour && index <= maxHour) {
      DateTime nextTime = this.nextTime(
        currentLeftIndex(),
        index,
        currentRightIndex(),
      );
      if (isBeforeMinTime(nextTime) || isAfterMaxTime(nextTime)) {
        return null;
      } else {
        return digits(index, 2);
      }
    } else {
      return null;
    }
  }

  @override
  String? rightStringAtIndex(int index) {
    if (index >= 0 && index < 4) {
      DateTime nextTime = this.nextTime(
        currentLeftIndex(),
        currentMiddleIndex(),
        index,
      );
      if (isBeforeMinTime(nextTime) || isAfterMaxTime(nextTime)) {
        return null;
      } else {
        return digits(index * stepMinute, 2);
      }
    } else {
      return null;
    }
  }

  @override
  String leftDivider() {
    return "";
  }

  @override
  String rightDivider() {
    return ":";
  }

  @override
  List<int> layoutProportions() {
    return [4, 1, 1];
  }

  @override
  DateTime finalTime() {
    DateTime today = DateTime.now();

    return today.isUtc
        ? DateTime.utc(
            today.year,
            today.month,
            today.day + currentLeftIndex(),
            currentMiddleIndex(),
            currentRightIndex() * stepMinute,
          )
        : DateTime(
            today.year,
            today.month,
            today.day + currentLeftIndex(),
            currentMiddleIndex(),
            currentRightIndex() * stepMinute,
          );
  }
}
