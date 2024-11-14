import 'package:dantex/data/logger/dante_logger.dart';
import 'package:dantex/data/logger/event.dart';

class DebugLogger extends DanteLogger {
  @override
  void trackEvent(DanteEvent event, {Map<String, Object>? data}) {
    var message = 'Event: ${event.name}';
    if (data != null && data.isNotEmpty) {
      message += ' - $data';
    }
    d(message);
  }
}
