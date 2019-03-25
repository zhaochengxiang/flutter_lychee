package com.wanjuanlink.lychee;

import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.v7.app.AppCompatActivity;
import android.view.View;
import android.widget.TextView;

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
            PageRouter.openPageByUrl(this, "native://LoginPageActivity");
        } else if (v == mBackFlutter) {
            finish();
        }
    }
}