package com.wanjuanlink.lychee;

import android.os.Bundle;

import com.taobao.idlefish.flutterboost.containers.BoostFlutterActivity;

import java.util.HashMap;
import java.util.Map;
import io.flutter.plugin.common.PluginRegistry;
import io.flutter.plugins.GeneratedPluginRegistrant;
import android.content.Intent;

public class FlutterActivity extends BoostFlutterActivity {
    private String mName;
    private Map mMap;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        Intent intent = getIntent();
        Bundle bundle = intent.getExtras();
        String url = bundle.getString("url");

        String[] subs = url.split("\\?");
        mName = subs[0];
        String query = "";
        if (subs.length > 1) {
            query = subs[1];
        }

        mMap = new HashMap<String, Object>(0);
        String[] params = query.split("&");
        for (int i = 0; i < params.length; i++) {
            String[] p = params[i].split("=");
            if (p.length == 2) {
                mMap.put(p[0], p[1]);
            }
        }
    }

    @Override
    public void onRegisterPlugins(PluginRegistry registry) {
        GeneratedPluginRegistrant.registerWith(registry);
    }

    @Override
    public String getContainerName() {
        return mName;
    }

    @Override
    public Map getContainerParams() {
        return mMap;
    }

}

