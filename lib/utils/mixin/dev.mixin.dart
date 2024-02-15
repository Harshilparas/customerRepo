import 'package:flutter/foundation.dart';

mixin Dev {
  // Emit a log event.
  ///
  /// This function was designed to map closely to the logging information
  /// collected by `package:logging`.
  ///
  /// - [message] is the log message
  /// - [time] (optional) is the timestamp
  /// - [sequenceNumber] (optional) is a monotonically increasing sequence number
  /// - [level] (optional) is the severity level (a value between 0 and 2000); see
  ///   the `package:logging` `Level` class for an overview of the possible values
  /// - [name] (optional) is the name of the source of the log message
  /// - [zone] (optional) the zone where the log was emitted
  /// - [error] (optional) an error object associated with this log event
  /// - [stackTrace] (optional) a stack trace associated with this log event
  static log(dynamic msg, {bool? hasDottedLine}) {
    hasDottedLine ??= true;
    if (!(kDebugMode || kProfileMode)) {
      return;
    }
    final String message = msg.toString();
    if (hasDottedLine) {
      debugPrint(
          '👇------------------------------------------------------------------------------👨🏻‍💻');
    }
    const int limitLength = 800;
    if (message.length < limitLength) {
      debugPrint('$msg');
    } else {
      final StringBuffer outStr = StringBuffer();
      for (int index = 0; index < message.length; index++) {
        outStr.write(message[index]);
        if (index % limitLength == 0 && index != 0) {
          debugPrint(outStr.toString());
          outStr.clear();
          final int lastIndex = index + 1;
          if (message.length - lastIndex < limitLength) {
            final String remainderStr =
                message.substring(lastIndex, message.length);
            debugPrint(remainderStr);
            break;
          }
        }
      }
    }
    if (hasDottedLine) {
      debugPrint(
          '👆🏻└------------------------------------------------------------------------------👨🏻‍💻');
    }
  }
}
