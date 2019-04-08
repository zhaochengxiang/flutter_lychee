
 import 'CrossPlatformService.dart';
 import '../handlers/CrossPlatformServiceMessageToFlutter.dart'; 
 
 class CrossPlatformServiceRegister{
 
  static register(){
    CrossPlatformService.regsiter();
    CrossPlatformServiceMessageToFlutter.regsiter();
   }

 }