package com.wanjuanlink.lychee;

import com.taobao.idlefish.flutterboost.containers.BoostFlutterFragment;
import java.util.Map;
import io.flutter.plugin.common.PluginRegistry;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class FlutterFragment extends BoostFlutterFragment {


    @Override
    public void onRegisterPlugins(PluginRegistry registry) {
        GeneratedPluginRegistrant.registerWith(registry);
    }

    @Override
    public String getContainerName() {
        return "flutter://home";
    }

    @Override
    public Map getContainerParams() {
        return null;
    }

    @Override
    public void destroyContainer() {

    }

    public static FlutterFragment instance(){
        FlutterFragment fragment = new FlutterFragment();
        return fragment;
    }
}
