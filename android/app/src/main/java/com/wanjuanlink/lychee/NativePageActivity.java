package com.wanjuanlink.lychee;

import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.widget.TextView;
import com.wanjuanlink.lychee.crossplatform.service.*;
import java.util.Map;
import java.util.HashMap;
import fleamarket.taobao.com.xservicekit.handler.MessageResult;
import fleamarket.taobao.com.xservicekit.service.ServiceEventListner;

public class NativePageActivity extends AppCompatActivity implements View.OnClickListener {

    private TextView mOpenFlutter;
    private TextView mBackFlutter;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        setContentView(R.layout.native_page);

        mOpenFlutter = findViewById(R.id.open_flutter);
        mBackFlutter = findViewById(R.id.back);

        mOpenFlutter.setOnClickListener(this);
        mBackFlutter.setOnClickListener(this);
    }

    @Override
    public void onClick(View v) {
        if (v == mOpenFlutter) {
            CrossPlatformService.MessageToFlutter(new MessageResult<Map>() {
                @Override
                public void success(Map var1) {
                    System.out.println( "Native message sent to flutter success!");
                }

                @Override
                public void error(String var1, String var2, Object var3) {
                    System.out.println( "Send Native message to flutter error");
                }

                @Override
                public void notImplemented() {

                    System.out.println( "Send Native message to flutter not implemented");

                }
            },"This a message from native to flutter");

            Map<String,String> map = new HashMap();
            map.put("param","name");
            CrossPlatformService.getService().emitEvent("test",map);
            CrossPlatformService.getService().addEventListner("flutter test",new ServiceEventListner() {
                @Override
                public void onEvent(String name, Map params) {
                    System.out.println("Did recieve broadcast even from flutter");
                }
            });

            PageRouter.openPageByUrl(this, "native://LoginPageActivity");
        } else if (v == mBackFlutter) {
            finish();
        }
    }
}