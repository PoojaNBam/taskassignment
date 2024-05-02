//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <cloud_firestore/cloud_firestore_plugin_c_api.h>
#include <firebase_core/firebase_core_plugin_c_api.h>
#include <flutter_widget_function/flutter_widget_function_plugin_c_api.h>
#include <validation_pro/validation_pro_plugin_c_api.h>

void RegisterPlugins(flutter::PluginRegistry* registry) {
  CloudFirestorePluginCApiRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("CloudFirestorePluginCApi"));
  FirebaseCorePluginCApiRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("FirebaseCorePluginCApi"));
  FlutterWidgetFunctionPluginCApiRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("FlutterWidgetFunctionPluginCApi"));
  ValidationProPluginCApiRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("ValidationProPluginCApi"));
}
