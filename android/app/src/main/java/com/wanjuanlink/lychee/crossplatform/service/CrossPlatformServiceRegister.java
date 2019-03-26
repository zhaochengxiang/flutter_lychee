package com.wanjuanlink.lychee.crossplatform.service;

import com.wanjuanlink.lychee.crossplatform.handlers.*;

public class CrossPlatformServiceRegister {
    public static void register(){
        CrossPlatformService.register();
        CrossPlatformServiceMessageToNative.register();
    }
}
