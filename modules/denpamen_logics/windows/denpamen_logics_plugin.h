#ifndef FLUTTER_PLUGIN_DENPAMEN_LOGICS_PLUGIN_H_
#define FLUTTER_PLUGIN_DENPAMEN_LOGICS_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace denpamen_logics {

class DenpamenLogicsPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  DenpamenLogicsPlugin();

  virtual ~DenpamenLogicsPlugin();

  // Disallow copy and assign.
  DenpamenLogicsPlugin(const DenpamenLogicsPlugin&) = delete;
  DenpamenLogicsPlugin& operator=(const DenpamenLogicsPlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace denpamen_logics

#endif  // FLUTTER_PLUGIN_DENPAMEN_LOGICS_PLUGIN_H_
