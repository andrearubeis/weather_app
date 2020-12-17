extension DateExtension on DateTime {

	isSameDay(DateTime date) {
		return this.day == date.day &&
			this.month == date.month &&
			this.year == date.year;
	}

	static DateTime fromUnixUtc(int utcDateTime) {
		DateTime date = DateTime.fromMillisecondsSinceEpoch(utcDateTime * 1000, isUtc: true);
		return date;
	}

}