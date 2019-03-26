package com.wanjuanlink.lychee;

import android.os.Build;
import android.os.Bundle;
import android.support.v7.app.ActionBar;
import android.support.v7.app.AppCompatActivity;
import android.view.Window;
import android.view.WindowManager;
import java.lang.ref.WeakReference;
import io.flutter.plugin.platform.PlatformPlugin;

public class MainActivity extends AppCompatActivity {
  public static WeakReference<MainActivity> sRef;
  private FlutterFragment mFragment;

  @Override
  protected void onCreate(Bundle savedInstanceState) {
    supportRequestWindowFeature(Window.FEATURE_NO_TITLE);
    if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP) {
      Window window = getWindow();
      window.addFlags(WindowManager.LayoutParams.FLAG_DRAWS_SYSTEM_BAR_BACKGROUNDS);
      window.setStatusBarColor(0x40000000);
      window.getDecorView().setSystemUiVisibility(PlatformPlugin.DEFAULT_SYSTEM_UI);
    }

    super.onCreate(savedInstanceState);
    sRef = new WeakReference<>(this);

    final ActionBar actionBar = getSupportActionBar();
    if(actionBar != null) {
      actionBar.hide();
    }

    setContentView(R.layout.main);

    mFragment = FlutterFragment.instance();

    getSupportFragmentManager()
            .beginTransaction()
            .replace(R.id.fragment_stub,mFragment)
            .commit();
  }
}
