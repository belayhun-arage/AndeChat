class Time {
  int year;
  int month;
  int day;
  int hour;
  int minute;
  int second;
  Time({this.year, this.month, this.day, this.hour, this.minute, this.second});

  factory Time.fromString(String time) {
    if (time == "") {
      return Time(year: 0, month: 0, day: 0, hour: 0, minute: 0, second: 0);
    }
    try {
      List<String> ymdnhms = time.split("T");
      ymdnhms[1] = ymdnhms[1].split(".")[0];

      final ymd = ymdnhms[0].split("-");
      final hms = ymdnhms[1].split(":");
      if(ymd.length ==3 && )
    } catch (e, a) {
      return Time(year: 0, month: 0, day: 0, hour: 0, minute: 0, second: 0);
    }
  }
}
