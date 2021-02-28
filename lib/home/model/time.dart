import 'dart:core';

import 'dart:developer';

/// Time class to represent time object in our
///  implementation to convert golang time formated String
/// into Custom Time class
class Time {
  int year;
  int month;
  int day;
  int hour;
  int minute;
  int second;
  Time({this.year, this.month, this.day, this.hour, this.minute, this.second});

  Time.empty() {
    this.year = 0;
    this.month = 0;
    this.day = 0;
    this.hour = 0;
    this.minute = 0;
    this.second = 0;
  }

  factory Time.fromString(String time) {
    if (time == "") {
      return Time.empty();
    }
    try {
      List<String> ymdnhms = time.split("T");
      ymdnhms[1] = ymdnhms[1].split(".")[0];

      final ymd = ymdnhms[0].split("-");
      final hms = ymdnhms[1].split(":");
      if (ymd.length == 3 && hms.length == 3) {
        int year, mon, day, hour, min, sec;
        year = int.parse(ymd[0]) ?? 0;
        mon = int.parse(ymd[1]) ?? 0;
        day = int.parse(ymd[2]) ?? 0;
        hour = int.parse(hms[0]) ?? 0;
        min = int.parse(hms[1]) ?? 0;
        sec = int.parse(hms[2]) ?? 0;
        return Time(
            year: year,
            month: mon,
            day: day,
            hour: hour,
            minute: min,
            second: sec);
      }
      return Time.empty();
    } catch (e, a) {
      return Time.empty();
    }
  }

  /// This method returns time String to show
  /// if the time is before a day it returns a day/month/year formatted String
  /// else if time is with in 24 hour it returns hour/minute/sec
  String showTime() {
    final dateTime = DateTime.now();
    // if()
    return "${this.year}/${this.month}/${this.day}";
  }

  String showFullTime(){
    return "${this.year}/${this.month}/${this.day} ${this.hour}:${this.minute}";
  }
}
