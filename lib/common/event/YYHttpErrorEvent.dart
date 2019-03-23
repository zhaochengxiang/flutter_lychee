import 'package:lychee/common/util/YYCommonUtils.dart';

class YYHttpErrorEvent {
  final String message;
  YYHttpErrorEvent(this.message);

  static errorHandleFunction(message, noTip) {
    if(noTip) {
      return message;
    }
    YYCommonUtils.eventBus.fire(new YYHttpErrorEvent(message));
    return message;
  }
}