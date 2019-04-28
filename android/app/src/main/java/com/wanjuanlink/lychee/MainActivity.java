package com.wanjuanlink.lychee;

import android.content.Intent;
import android.os.Bundle;

import com.wanjuanlink.lychee.crossplatform.service.CrossPlatformService;
import com.wanjuanlink.lychee.loader.ServiceLoader;

import java.util.Map;

import fleamarket.taobao.com.xservicekit.service.ServiceEventListner;
import io.flutter.app.FlutterActivity;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {

  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);
    ServiceLoader.load();
    CrossPlatformService.getService().addEventListner("flutter_event_open_scan",new ServiceEventListner() {
      @Override
      public void onEvent(String name, Map params) {
          Intent intent =new Intent(MainActivity.this,TestActivity.class);
          startActivity(intent);
      }
    });
  }
}
