package com.wanjuanlink.lychee.loader;

import com.wanjuanlink.lychee.crossplatform.service.*;

public class ServiceLoader {
    public static void load(){
        CrossPlatformServiceRegister.register();
    }
}
