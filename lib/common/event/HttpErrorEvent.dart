import 'package:lychee/common/util/CommonUtils.dart';

class HttpErrorEvent {
  final String message;
  HttpErrorEvent(this.message);

  static errorHandleFunction(message, noTip) {
    if(noTip) {
      return message;
    }
    CommonUtils.eventBus.fire(new HttpErrorEvent(message));
    return message;
  }
}