import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class SPLogger {
  static SPLogger instance = SPLogger();

  var _logger = Logger(printer: PrettyPrinter(colors: false));

  void verbose(String message) {
    _logger.v(message);
  }

  void debug(String message) {
    _logger.d(message);
  }

  void info(String message) {
    _logger.i(message);
  }

  void warning(String message) {
    _logger.w(message);
  }

  void error(String message) {
    _logger.e(message);
  }

  void printConsole(Response response) {
    SPLogger.instance.verbose(
      'Base Network - request: ${response.request.baseUrl + response.request.path}',
    );
    SPLogger.instance.verbose(
      'Base Network - request data: ${response.request.data}',
    );
    SPLogger.instance.verbose(
        'Base Network - request parameters: ${response.request.queryParameters}');
    SPLogger.instance.verbose(
      'Base Network - response: $response',
    );
  }
}
