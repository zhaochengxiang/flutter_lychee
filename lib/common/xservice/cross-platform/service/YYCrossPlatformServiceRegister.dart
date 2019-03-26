
 import 'YYCrossPlatformService.dart';
 import '../handlers/YYCrossPlatformServiceMessageToFlutter.dart'; 
 
 class YYCrossPlatformServiceRegister{
 
  static register(){
    YYCrossPlatformService.regsiter();
    YYCrossPlatformServiceMessageToFlutter.regsiter();
   }

 }