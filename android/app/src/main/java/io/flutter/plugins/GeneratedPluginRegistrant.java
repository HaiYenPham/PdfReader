package io.flutter.plugins;

import io.flutter.plugin.common.PluginRegistry;
import de.esys.esysfluttershare.EsysFlutterSharePlugin;
import io.flutter.plugins.firebaseadmob.FirebaseAdMobPlugin;
import com.pycampers.flutterpdfviewer.FlutterPdfViewerPlugin;
import com.example.fluttershare.FlutterSharePlugin;
import io.flutter.plugins.pathprovider.PathProviderPlugin;
import com.baseflow.permissionhandler.PermissionHandlerPlugin;
import com.pycampers.plugin_scaffold.PluginScaffoldPlugin;
import io.flutter.plugins.sharedpreferences.SharedPreferencesPlugin;

/**
 * Generated file. Do not edit.
 */
public final class GeneratedPluginRegistrant {
  public static void registerWith(PluginRegistry registry) {
    if (alreadyRegisteredWith(registry)) {
      return;
    }
    EsysFlutterSharePlugin.registerWith(registry.registrarFor("de.esys.esysfluttershare.EsysFlutterSharePlugin"));
    FirebaseAdMobPlugin.registerWith(registry.registrarFor("io.flutter.plugins.firebaseadmob.FirebaseAdMobPlugin"));
    FlutterPdfViewerPlugin.registerWith(registry.registrarFor("com.pycampers.flutterpdfviewer.FlutterPdfViewerPlugin"));
    FlutterSharePlugin.registerWith(registry.registrarFor("com.example.fluttershare.FlutterSharePlugin"));
    PathProviderPlugin.registerWith(registry.registrarFor("io.flutter.plugins.pathprovider.PathProviderPlugin"));
    PermissionHandlerPlugin.registerWith(registry.registrarFor("com.baseflow.permissionhandler.PermissionHandlerPlugin"));
    PluginScaffoldPlugin.registerWith(registry.registrarFor("com.pycampers.plugin_scaffold.PluginScaffoldPlugin"));
    SharedPreferencesPlugin.registerWith(registry.registrarFor("io.flutter.plugins.sharedpreferences.SharedPreferencesPlugin"));
  }

  private static boolean alreadyRegisteredWith(PluginRegistry registry) {
    final String key = GeneratedPluginRegistrant.class.getCanonicalName();
    if (registry.hasPlugin(key)) {
      return true;
    }
    registry.registrarFor(key);
    return false;
  }
}
