package np.com.a99darshan.aws_whitepapers_guides;
import io.flutter.app.FlutterApplication;
import io.flutter.plugin.common.PluginRegistry;
import io.flutter.plugins.GeneratedPluginRegistrant;
//import io.flutter.embedding.engine.FlutterEngine;
import vn.hunghd.flutterdownloader.FlutterDownloaderPlugin;


public class WhitepapersApplication extends FlutterApplication implements PluginRegistry.PluginRegistrantCallback {
    @Override
    public void registerWith(PluginRegistry registry) {
        //GeneratedPluginRegistrant.registerWith(registry);
       FlutterDownloaderPlugin.registerWith(registry.registrarFor("vn.hunghd.flutterdownloader.FlutterDownloaderPlugin"));
    }
}