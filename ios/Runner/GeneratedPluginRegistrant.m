//
//  Generated file. Do not edit.
//

#import "GeneratedPluginRegistrant.h"
#import <esys_flutter_share/EsysFlutterSharePlugin.h>
#import <firebase_admob/FirebaseAdMobPlugin.h>
#import <flutter_pdf_viewer/FlutterPdfViewerPlugin.h>
#import <flutter_share/FlutterSharePlugin.h>
#import <path_provider/PathProviderPlugin.h>
#import <permission_handler/PermissionHandlerPlugin.h>
#import <plugin_scaffold/PluginScaffoldPlugin.h>
#import <shared_preferences/SharedPreferencesPlugin.h>

@implementation GeneratedPluginRegistrant

+ (void)registerWithRegistry:(NSObject<FlutterPluginRegistry>*)registry {
  [EsysFlutterSharePlugin registerWithRegistrar:[registry registrarForPlugin:@"EsysFlutterSharePlugin"]];
  [FLTFirebaseAdMobPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTFirebaseAdMobPlugin"]];
  [FlutterPdfViewerPlugin registerWithRegistrar:[registry registrarForPlugin:@"FlutterPdfViewerPlugin"]];
  [FlutterSharePlugin registerWithRegistrar:[registry registrarForPlugin:@"FlutterSharePlugin"]];
  [FLTPathProviderPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTPathProviderPlugin"]];
  [PermissionHandlerPlugin registerWithRegistrar:[registry registrarForPlugin:@"PermissionHandlerPlugin"]];
  [PluginScaffoldPlugin registerWithRegistrar:[registry registrarForPlugin:@"PluginScaffoldPlugin"]];
  [FLTSharedPreferencesPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTSharedPreferencesPlugin"]];
}

@end
