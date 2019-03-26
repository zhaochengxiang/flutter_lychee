import '../cross-platform/service/YYCrossPlatformServiceRegister.dart'; 

class YYServiceLoader{
  static load(){
	YYCrossPlatformServiceRegister.register();
  }
}