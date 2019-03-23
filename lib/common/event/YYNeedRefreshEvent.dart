import 'package:lychee/common/util/YYCommonUtils.dart';

class YYNeedRefreshEvent {
  final String className;
  YYNeedRefreshEvent(this.className);

  static refreshHandleFunction(name) {
    YYCommonUtils.eventBus.fire(new YYNeedRefreshEvent(name));
    return name;
  }
}