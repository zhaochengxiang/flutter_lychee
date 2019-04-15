import 'package:lychee/common/util/CommonUtils.dart';

class CategoryIndexChangeEvent {
  CategoryIndexChangeEvent();

  static changeHandleFunction() {
    CommonUtils.eventBus.fire(new CategoryIndexChangeEvent());
  }
}