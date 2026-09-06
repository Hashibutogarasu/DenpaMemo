#include "include/denpamen_logics/denpamen_logics_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "denpamen_logics_plugin.h"

void DenpamenLogicsPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  denpamen_logics::DenpamenLogicsPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
