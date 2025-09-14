import 'package:intl/intl.dart';

String formatTime(String time) {
  try {
    // Parse the time string (format: "HH:mm")
    final timeParts = time.split(':');
    if (timeParts.length != 2) return time;

    final hour = int.tryParse(timeParts[0]);
    final minute = int.tryParse(timeParts[1]);

    if (hour == null || minute == null) return time;

    // Create a DateTime object for today with the given time
    final now = DateTime.now();
    final dateTime = DateTime(now.year, now.month, now.day, hour, minute);

    // Format using intl package for 12-hour format with AM/PM
    final formatter = DateFormat('h:mm a');
    return formatter.format(dateTime);
  } catch (e) {
    // Return original time if parsing fails
    return time;
  }
}
