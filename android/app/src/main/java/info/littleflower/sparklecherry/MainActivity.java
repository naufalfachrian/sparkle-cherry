package info.littleflower.sparklecherry;

import android.os.Build;
import android.os.Bundle;

import java.lang.reflect.Field;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
  private static final String CHANNEL = "sparkle-cherry.io/native-calls-example";

  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);

    new MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler(
      new MethodChannel.MethodCallHandler() {
        @Override
        public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
          if (methodCall.method.equals("getOsVersion")) {
            result.success(MainActivity.this.getAndroidVersion());
          } else {
            result.notImplemented();
          }
        }
      }
    );
  }

  private String getAndroidVersion() {
    StringBuilder builder = new StringBuilder();
    builder.append("Android : ").append(Build.VERSION.RELEASE);

    Field[] fields = new Field[0];
    if (android.os.Build.VERSION.SDK_INT >= android.os.Build.VERSION_CODES.DONUT) {
      fields = Build.VERSION_CODES.class.getFields();
    }
    for (Field field : fields) {
      String fieldName = field.getName();
      int fieldValue = -1;
      try {
        fieldValue = field.getInt(new Object());
      } catch (Exception e) {
        builder.append(" : ").append("Unknown");
      }
      if (fieldValue == Build.VERSION.SDK_INT) {
        builder.append(" : ").append(fieldName).append(" : ").append(" SDK = ").append(fieldValue);
      }
    }
    return builder.toString();
  }
}
