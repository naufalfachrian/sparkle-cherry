package info.littleflower.sparklecherry;

import android.content.Intent;
import android.os.Build;
import android.os.Bundle;

import java.lang.reflect.Field;

import info.littleflower.qrscanner.QrScannerActivity;
import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {

  private static final String CHANNEL = "sparkle-cherry.io/native-calls-example";

  private MethodChannel.Result result;

  private static final int QR_CODE_REQUEST = 90;

  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);

    new MethodChannel(getFlutterView(), CHANNEL).setMethodCallHandler(
      new MethodChannel.MethodCallHandler() {
        @Override
        public void onMethodCall(MethodCall methodCall, MethodChannel.Result result) {
          switch (methodCall.method) {
            case "getOsVersion":
              result.success(MainActivity.this.getAndroidVersion());
              break;
            case "scanQrViaNative":
              MainActivity.this.result = result;
              startActivityForResult(new Intent(MainActivity.this, QrScannerActivity.class), MainActivity.QR_CODE_REQUEST);
              break;
            default:
              result.notImplemented();
              break;
          }
        }
      }
    );
  }

  private String getAndroidVersion() {
    StringBuilder builder = new StringBuilder();
    builder.append("Android : ").append(Build.VERSION.RELEASE);

    Field[] fields = Build.VERSION_CODES.class.getFields();
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

  @Override
  protected void onActivityResult(int requestCode, int resultCode, Intent data) {
    super.onActivityResult(requestCode, resultCode, data);
    if (requestCode == QR_CODE_REQUEST && resultCode == QrScannerActivity.RESULT_SUCCESS && data != null && result != null) {
      String builder = "[" +
              data.getStringExtra(QrScannerActivity.QR_BARCODE_FORMAT) +
              "]" +
              data.getStringExtra(QrScannerActivity.QR_TEXT);
      result.success(builder);
    }
  }
}
