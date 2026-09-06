//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <denpamen_logics/denpamen_logics_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) denpamen_logics_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "DenpamenLogicsPlugin");
  denpamen_logics_plugin_register_with_registrar(denpamen_logics_registrar);
}
