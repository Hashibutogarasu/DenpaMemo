import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:croppy/croppy.dart';

import '../i18n/gen/strings.g.dart';

/// Japanese `CroppyLocalizations` override. `croppy` 1.5.3 doesn't ship a
/// Japanese translation and silently falls back to English for any
/// unlisted locale (see `CroppyLocalizations.lookupCroppyLocalizations`),
/// so this is a real override rather than a redundant one. Every string
/// is delegated to `lib/i18n/ja.i18n.json` (`t.croppy.*`) rather than
/// hardcoded here, keeping this the same single translation source as
/// the rest of the app's UI text. [delegate] must be registered before
/// `CroppyLocalizations.delegate` in `MaterialApp.localizationsDelegates`
/// so this override wins for `ja` while other locales still fall back to
/// croppy's own delegate.
class CroppyLocalizationsJa extends CroppyLocalizations {
  CroppyLocalizationsJa() : super('ja');

  static const LocalizationsDelegate<CroppyLocalizations> delegate =
      _CroppyLocalizationsJaDelegate();

  @override
  String get materialResetLabel => t.croppy.materialResetLabel;

  @override
  String get cupertinoResetLabel => t.croppy.cupertinoResetLabel;

  @override
  String materialGetFlipLabel(LocalizationDirection direction) {
    final directionLabel = direction == LocalizationDirection.vertical
        ? t.croppy.directionVertical
        : t.croppy.directionHorizontal;
    return t.croppy.materialFlipLabel(direction: directionLabel);
  }

  @override
  String get materialFreeformAspectRatioLabel =>
      t.croppy.materialFreeformAspectRatioLabel;

  @override
  String get materialOriginalAspectRatioLabel =>
      t.croppy.materialOriginalAspectRatioLabel;

  @override
  String get materialSquareAspectRatioLabel =>
      t.croppy.materialSquareAspectRatioLabel;

  @override
  String get saveLabel => t.croppy.saveLabel;

  @override
  String get doneLabel => t.croppy.doneLabel;

  @override
  String get cancelLabel => t.croppy.cancelLabel;

  @override
  String get cupertinoFreeformAspectRatioLabel =>
      t.croppy.cupertinoFreeformAspectRatioLabel;

  @override
  String get cupertinoOriginalAspectRatioLabel =>
      t.croppy.cupertinoOriginalAspectRatioLabel;

  @override
  String get cupertinoSquareAspectRatioLabel =>
      t.croppy.cupertinoSquareAspectRatioLabel;
}

class _CroppyLocalizationsJaDelegate
    extends LocalizationsDelegate<CroppyLocalizations> {
  const _CroppyLocalizationsJaDelegate();

  @override
  bool isSupported(Locale locale) => locale.languageCode == 'ja';

  @override
  Future<CroppyLocalizations> load(Locale locale) {
    return SynchronousFuture<CroppyLocalizations>(CroppyLocalizationsJa());
  }

  @override
  bool shouldReload(_CroppyLocalizationsJaDelegate old) => false;
}
