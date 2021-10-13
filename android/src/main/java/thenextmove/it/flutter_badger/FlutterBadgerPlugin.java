package thenextmove.it.flutter_badger;

import androidx.annotation.NonNull;
import android.content.Context;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import me.leolin.shortcutbadger.ShortcutBadger;

/** FlutterBadgerPlugin */
public class FlutterBadgerPlugin implements FlutterPlugin, MethodCallHandler {
  private Context context;
  private MethodChannel channel;

  // /**
  // * Plugin registration.
  // */
  // public static void registerWith(Registrar registrar) {
  // channel = new MethodChannel(registrar.messenger(), "tuna/flutter_badger");
  // channel.setMethodCallHandler(new
  // FlutterBadgerPlugin(registrar.activeContext()));
  // }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    if (call.method.equals("updateBadgeCount")) {
      ShortcutBadger.applyCount(context, Integer.valueOf(call.argument("count").toString()));
      result.success(null);
    } else if (call.method.equals("removeBadge")) {
      ShortcutBadger.removeCount(context);
      result.success(null);
    } else if (call.method.equals("isAppBadgeSupported")) {
      result.success(ShortcutBadger.isBadgeCounterSupported(context));
    } else {
      result.notImplemented();
    }
  }

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "tuna/flutter_badger");
    channel.setMethodCallHandler(this);
    context = flutterPluginBinding.getApplicationContext();
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }
}
