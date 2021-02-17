/*This time class is created to crate a time object from a string 
which was encoded from golang time.Time Object  */
class Time {
  final int hour;
  final int minute;
  final int second;
  final int day;
  final String dayname;
  final int year;
  final int month;
  static const List<String> MONTHS = [
    "SEPTEMBER",
    "OCTOBER",
    "NOVEMBER",
    "DECEMBER",
    "JANUARY",
    "FEbru "
  ];

  Time({
    this.hour,
    this.minute,
    this.second,
    this.day,
    this.dayname,
    this.year,
    this.month,
  });

  factory Time.fromString(String date) {
    return Time();
  }
}
