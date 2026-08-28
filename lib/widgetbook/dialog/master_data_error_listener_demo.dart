import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../domain/master_data/master_data_load_error.dart';
import '../../widgets/dialog/master_data_error_listener.dart';
import '../denpa_men/route_denpa_men_data.dart';
import 'package:graphql_client/graphql_client.dart';

final demoShouldFailMasterDataProvider = StateProvider<bool>((ref) => false);

final demoMasterDataProviderOverride = masterDataProvider.overrideWith((ref) async {
  if (ref.watch(demoShouldFailMasterDataProvider)) {
    throw MasterDataConnectionError();
  }
  return RouteDenpaMenData.masterData;
});

/// Exercises the real [listenForMasterDataErrors]: tapping the button
/// makes [masterDataProvider] fail, which the listener picks up and shows
/// as a real [ErrorDialog](../../widgets/dialog/error_dialog.dart).
class MasterDataErrorListenerDemo extends ConsumerWidget {
  const MasterDataErrorListenerDemo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    listenForMasterDataErrors(ref, context);

    return Center(
      child: ElevatedButton(
        onPressed: () =>
            ref.read(demoShouldFailMasterDataProvider.notifier).state = true,
        child: const Text('masterDataProviderを失敗させる'),
      ),
    );
  }
}
