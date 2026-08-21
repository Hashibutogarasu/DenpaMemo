import 'package:flutter_riverpod/legacy.dart';

/// How the home screen's main content area is rendered: a scrollable list
/// (tiles or a grid, see [HomeTileMode]) or the [DenpaMenLineageTree].
enum HomeViewMode { list, tree }

/// The home screen's current [HomeViewMode], toggled from the AppBar-area
/// [ToggleButtonGroup] in `home.dart`.
final homeViewModeProvider = StateProvider<HomeViewMode>(
  (ref) => HomeViewMode.list,
);

/// How individual [DenpaMen] entries are rendered within
/// [HomeViewMode.list]: as list rows (`DenpaMenListTile`/
/// `DenpaMenAccordionTile`, device-dependent) or as an icon grid
/// (`DenpaMenBox`/`DenpaMenContainer`).
enum HomeTileMode { tile, grid }

/// The home screen's current [HomeTileMode], toggled from the AppBar-area
/// [ToggleButtonGroup] in `home.dart`. Only meaningful while
/// [homeViewModeProvider] is [HomeViewMode.list].
final homeTileModeProvider = StateProvider<HomeTileMode>(
  (ref) => HomeTileMode.tile,
);
