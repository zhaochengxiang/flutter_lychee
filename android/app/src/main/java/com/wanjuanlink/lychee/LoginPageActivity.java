package com.wanjuanlink.lychee;

import com.taobao.idlefish.flutterboost.containers.BoostFlutterActivity;

import java.util.Map;

import io.flutter.plugin.common.PluginRegistry;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class LoginPageActivity extends BoostFlutterActivity {

    @Override
    public void onRegisterPlugins(PluginRegistry registry) {
        GeneratedPluginRegistrant.registerWith(registry);
    }

    @Override
    public String getContainerName() {
        return "flutter://login";
    }

    @Override
    public Map getContainerParams() {
        return null;
    }
}
