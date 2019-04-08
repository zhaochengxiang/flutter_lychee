import 'package:lychee/common/util/CommonUtils.dart';

class NeedRefreshEvent {
  final String className;
  NeedRefreshEvent(this.className);

  static refreshHandleFunction(name) {
    CommonUtils.eventBus.fire(new NeedRefreshEvent(name));
    return name;
  }
}