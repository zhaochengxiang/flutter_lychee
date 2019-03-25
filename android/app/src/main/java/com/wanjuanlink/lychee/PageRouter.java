package com.wanjuanlink.lychee;

import android.content.Context;
import android.content.Intent;
import android.text.TextUtils;

import java.lang.Class;

public class PageRouter {

    public static final String Package_Name = "com.wanjuanlink.lychee";

    public static boolean openPageByUrl(Context context, String url) {
        return openPageByUrl(context, url, 0);
    }

    public static boolean openPageByUrl(Context context, String url, int requestCode) {
        String className = url.split("://")[1];

        try {
            context.startActivity(new Intent(context,Class.forName(Package_Name+'.'+className)));
            return false;
        } catch (Throwable t) {
            return false;
        }
    }
}
