# lychee

一款跨平台的客户端App，目前支持微信分享，二维码扫描(暂时只支持iOS)，极光推送，图片上传，打开相机相册等功能，项目涉及各种常用控件，如ExpansionPanelList，GridView,ListView,StackIndex等，同样设计到网络、数据库、与原生之间的交互等内容，同时项目封装了几个基础Mixin,如BaseState,BaseScrollState,BaseListState等，将界面中设计到的公共代码放在里面，进行统一管理。

### 示例效果

<img src="https://raw.githubusercontent.com/zhaochengxiang/flutter_lychee/master/效果图/1.jpeg" width="400px"/> <img src="https://raw.githubusercontent.com/zhaochengxiang/flutter_lychee/master/效果图/2.jpeg" width="400px"/>
<img src="https://raw.githubusercontent.com/zhaochengxiang/flutter_lychee/master/效果图/3.jpeg" width="400px"/> <img src="https://raw.githubusercontent.com/zhaochengxiang/flutter_lychee/master/效果图/4.jpeg" width="400px"/>

### 第三方框架

| 库                          | 功能             |
| -------------------------- | -------------- |
| **dio**                    | **网络框架**       |
| **connectivity**           | **网络监听**       |
| **event_bus**              | **界面间发送通知**       |
| **shared_preferences**     | **本地数据缓存**     |
| **fluttertoast**           | **toast**      |
| **json_annotation**        | **json模板**     |
| **json_serializable**      | **json模板**     |
| **flutter_swiper**         | **轮播图**     |
| **flutter_easyrefresh**    | **上下拉刷新**     |
| **sharesdk**               | **mob分享**     |
| **jpush_flutter**          | **极光推送**     |
| **image_picker**           | **打开相机相册**     |
| **xservice_kit**           | **flutter与原生之间的数据传递**     |
| **flutter_slidable**       | **侧滑**         |
| **qr_flutter**             | **生成二维码**         |
| **sqflite**                | **数据库**        |
| **webview_flutter**        | **内嵌webview**    |
| **permission_handler**     | **权限**         |
| **device_info**            | **设备信息**       |
| **flutter_statusbar**      | **状态栏**        |
| **amap_base_location**     | **高德定位**    |

### 相关博客
* [flutter sharesdk实现跨平台分享](https://www.jianshu.com/p/6678c29a963c )
