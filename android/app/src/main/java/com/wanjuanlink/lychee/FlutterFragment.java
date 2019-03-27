package com.wanjuanlink.lychee;

import android.os.Bundle;
import android.support.annotation.Nullable;

import com.taobao.idlefish.flutterboost.containers.BoostFlutterFragment;
import java.util.Map;
import io.flutter.plugin.common.PluginRegistry;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class FlutterFragment extends BoostFlutterFragment {

    @Override
    public void setArguments(@Nullable Bundle args) {
        if(args == null) {
            args = new Bundle();
            args.putString("tag","");
        }
        super.setArguments(args);
    }

    public void setTabTag(String tag) {
        Bundle args = new Bundle();
        args.putString("tag",tag);
        super.setArguments(args);
    }

    @Override
    public void onRegisterPlugins(PluginRegistry registry) {
        GeneratedPluginRegistrant.registerWith(registry);
    }

    @Override
    public String getContainerName() {
        return getArguments().getString("tag");
    }

    @Override
    public Map getContainerParams() {
        return null;
    }

    @Override
    public void destroyContainer() {

    }

    public static FlutterFragment instance(String name){
        FlutterFragment fragment = new FlutterFragment();
        fragment.setTabTag(name);
        return fragment;
    }
}
