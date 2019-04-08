import '../cross-platform/service/CrossPlatformServiceRegister.dart'; 

class ServiceLoader{
  static load(){
	CrossPlatformServiceRegister.register();
  }
}