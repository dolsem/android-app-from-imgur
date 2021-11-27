import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

import 'src/app.dart';
import 'src/cubit/selection_cubit.dart';

Future<void> main() async {
  // Set app entrypoint to initApp to allow multi select
  SelectionCubit.allowMultiSelect = false;
  await initApp();
}

@pragma('vm:entry-point')
Future<void> initApp() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Set image cache size to 700 MB:
  PaintingBinding.instance!.imageCache!.maximumSizeBytes = 1024 * 1024 * 700;
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getTemporaryDirectory(),
  );
  runApp(const App());
}