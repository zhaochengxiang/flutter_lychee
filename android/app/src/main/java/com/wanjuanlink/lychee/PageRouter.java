package com.wanjuanlink.lychee;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;

import java.lang.Class;
import java.util.HashMap;
import java.util.Map;

public class PageRouter {

    public static final String Package_Name = "com.wanjuanlink.lychee";

    public static boolean openPageByUrl(Context context, String url) {
        return openPageByUrl(context, url, 0);
    }

    public static boolean openPageByUrl(Context context, String url, int requestCode) {

        if (url.startsWith("flutter://")) {

            try {

                Intent intent = new Intent(context, FlutterActivity.class);
                intent.putExtra("url", url);
                context.startActivity(intent);
                return false;
            } catch (Throwable t) {
                return false;
            }

        } else {
            String className = url.split("://")[1].split("\\?")[0];

            try {
                context.startActivity(new Intent(context,Class.forName(Package_Name+'.'+className)));
                return false;
            } catch (Throwable t) {
                return false;
            }
        }

    }
}
