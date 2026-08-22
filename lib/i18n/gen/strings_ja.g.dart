///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

part of 'strings.g.dart';

// Path: <root>
typedef TranslationsJa = Translations; // ignore: unused_element
class Translations with BaseTranslations<AppLocale, Translations> {
	/// Returns the current translations of the given [context].
	///
	/// Usage:
	/// final t = Translations.of(context);
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	Translations({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.ja,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <ja>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	dynamic operator[](String key) => $meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	Translations $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => Translations(meta: meta ?? this.$meta);

	// Translations
	late final Translations$app$ja app = Translations$app$ja.internal(_root);
	late final Translations$common$ja common = Translations$common$ja.internal(_root);
	late final Translations$page$ja page = Translations$page$ja.internal(_root);
	late final Translations$home$ja home = Translations$home$ja.internal(_root);
	late final Translations$search$ja search = Translations$search$ja.internal(_root);
	late final Translations$backup$ja backup = Translations$backup$ja.internal(_root);
	late final Translations$birthGuide$ja birthGuide = Translations$birthGuide$ja.internal(_root);
	late final Translations$denpaMenStatus$ja denpaMenStatus = Translations$denpaMenStatus$ja.internal(_root);
	late final Translations$stat$ja stat = Translations$stat$ja.internal(_root);
	late final Translations$editableStatus$ja editableStatus = Translations$editableStatus$ja.internal(_root);
	Map<String, String> get headShape => {
		'circle': 'まる',
		'bowlCut': 'おかっぱ',
		'bread': 'しょくぱん',
		'castleTower': 'てんしゅ',
		'dumpling': 'おだんご',
		'fin': 'ひれ',
		'frog': 'かえる',
		'grandCastleTower': 'だいてんしゅ',
		'light': 'ひかり',
		'moon': 'つき',
		'musician': 'おんがくか',
		'ring': 'わっか',
		'silkHat': 'シルクハット',
		'sun': 'たいよう',
		'wing': 'はね',
		'triangle': 'さんかく',
		'horizontalOval': 'よこまる',
		'verticalOval': 'たてまる',
		'roundedSquare': 'かどまる',
		'soap': 'せっけん',
		'droplet': 'しずく',
		'bearCub': 'こぐま',
		'morningDew': 'あまつゆ',
		'robot': 'ロボ',
		'spike': 'とんがり',
		'battery': 'でんち',
		'egg': 'たまご',
		'sparkle': 'きらきら',
		'onigiri': 'おにぎり',
		'beans': 'まめ',
	};
	Map<String, String> get correction => {
		'protagonist': '主人公補正',
	};
	Map<String, String> get antenna => {
		'none': 'アンテナなし',
		'antennaRoot': 'アンテナのねっこ',
		'waterGun_1': 'みずでっぽう',
		'waterGun_3': 'バケツのみず',
		'waterGun_all': 'たかなみ',
		'beam_1': 'よわいこうせん',
		'beam_3': 'スポットライト',
		'beam_all': 'ふゆのひざし',
		'fireball_1': 'ひのたま',
		'fireball_3': 'ばくはつ',
		'fireball_all': 'やまかじ',
		'heal_solo_1': 'ちょっとかいふく',
		'heal_solo_2': 'そこそこかいふく',
		'heal_all_1': 'みんなちょっとかいふく',
		'heal_all_2': 'みんなそこそこかいふく',
		'revive_solo_1': 'ちょっとふっかつ',
		'revive_solo_2': 'そこそこふっかつ',
		'revive_all_1': 'みんなちょっとふっかつ',
		'revive_all_2': 'みんなそこそこふっかつ',
		'excite_solo_1': 'すこしこうふん',
		'excite_solo_2': 'こうふん',
		'excite_solo_3': 'ながくこうふん',
		'excite_all_1': 'みんなすこしこうふん',
		'excite_all_2': 'みんなこうふん',
		'excite_all_3': 'みんなながくこうふん',
		'darkBall_1': 'おどかす',
		'darkBall_3': 'ダークボール',
		'darkBall_all': 'くろいきり',
		'whirlwind_1': 'つむじかぜ',
		'whirlwind_3': 'ビルかぜ',
		'whirlwind_all': 'かまいたち',
		'staticElectricity_1': 'せいでんき',
		'staticElectricity_3': 'いなずま',
		'staticElectricity_all': 'ひゃくボルト',
		'sharpIce_1': 'とがったこおり',
		'sharpIce_3': 'ロックアイス',
		'sharpIce_all': 'あられ',
		'fallingRock_1': 'らくせき',
		'fallingRock_3': 'いしつぶて',
		'fallingRock_all': 'マグニチュード3',
		'knockdown_solo_1': 'ノックダウン',
		'knockdown_solo_2': 'いちげきKO',
		'knockdown_solo_3': 'きゅうしょづき',
		'knockdown_all_1': 'みんなノックダウン',
		'knockdown_all_2': 'みんないちげきKO',
		'knockdown_all_3': 'みんなきゅうしょづき',
		'harden_solo_1': 'すこしかたくなれ',
		'harden_solo_2': 'かたくなれ',
		'harden_solo_3': 'すごくかたくなれ',
		'harden_all_1': 'みんなかためになれ',
		'harden_all_2': 'みんなかたくなれ',
		'harden_all_3': 'みんなガチガチ',
		'invincible_solo_1': 'すこしむてき',
		'invincible_solo_2': 'むてき',
		'invincible_solo_3': 'ながくむてき',
		'invincible_all_1': 'みんなすこしむてき',
		'invincible_all_2': 'みんなむてき',
		'invincible_all_3': 'みんなながくむてき',
		'hardToDodge_all_1': 'みんなすこしよけにくい',
		'hardToDodge_all_2': 'みんなよけにくい',
		'hardToDodge_all_3': 'みんなすごくよけにくい',
		'speedUp_solo_1': 'すこしはやくなれ',
		'speedUp_solo_2': 'はやくなれ',
		'speedUp_solo_3': 'かぜになれ',
		'speedUp_all_1': 'みんなすこしはやくなれ',
		'speedUp_all_2': 'みんなはやくなれ',
		'speedUp_all_3': 'みんなかぜになれ',
	};
	Map<String, String> get bodyColor => {
		'red': 'あか',
		'blue': 'あお',
		'yellow': 'きいろ',
		'green': 'みどり',
		'lightBlue': 'みずいろ',
		'orange': 'だいだい',
		'black': 'くろ',
		'purple': 'むらさき',
		'white': 'しろ',
		'pink': 'もも',
		'gold': 'きん',
		'silver': 'ぎん',
	};
	Map<String, String> get attribute => {
		'fire': '火',
		'water': '水',
		'thunder': '雷',
		'earth': '土',
		'ice': '氷',
		'wind': '風',
		'light': '光',
		'dark': '闇',
		'physical': '物理',
		'suddenDeath': '突然死',
	};
	Map<String, String> get abnormality => {
		'poison': 'どく',
		'burn': 'やけど',
		'frostbite': 'しもやけ',
		'cold': 'かぜっぴき',
		'mud': 'どろだらけ',
		'electrocution': 'かんでん',
		'soaked': 'みずびだし',
		'blind': 'ブラインド',
		'curse': 'のろい',
		'suddenDeath': 'とつぜんし',
		'paralysis': 'マヒ',
		'sleep': 'ねむり',
		'charm': 'みりょう',
		'fear': 'きょうふ',
		'jack': 'ジャック',
	};
}

// Path: app
class Translations$app$ja {
	Translations$app$ja.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// ja: 'Denpa Memo'
	String get name => 'Denpa Memo';
}

// Path: common
class Translations$common$ja {
	Translations$common$ja.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// ja: 'キャンセル'
	String get cancel => 'キャンセル';

	/// ja: '決定'
	String get confirm => '決定';

	/// ja: 'OK'
	String get ok => 'OK';

	/// ja: '保存'
	String get save => '保存';

	/// ja: '編集'
	String get edit => '編集';

	/// ja: '削除'
	String get delete => '削除';

	/// ja: '戻る'
	String get back => '戻る';

	/// ja: '次へ'
	String get next => '次へ';

	/// ja: '完了'
	String get complete => '完了';

	/// ja: '未設定'
	String get unset => '未設定';
}

// Path: page
class Translations$page$ja {
	Translations$page$ja.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// ja: 'ホーム'
	String get home => 'ホーム';

	/// ja: '設定'
	String get settings => '設定';

	/// ja: '電波人間を追加'
	String get addDenpaMen => '電波人間を追加';

	/// ja: '電波人間を編集'
	String get editDenpaMen => '電波人間を編集';

	/// ja: '電波人間を追加'
	String get addDenpaMenGroup => '電波人間を追加';

	/// ja: '再生成'
	String get qrRegenerate => '再生成';

	/// ja: 'QRコードを選ぶ'
	String get selectQrCode => 'QRコードを選ぶ';

	/// ja: '出生ガイド'
	String get birthGuide => '出生ガイド';

	/// ja: '検索'
	String get search => '検索';

	/// ja: '検索結果'
	String get searchResults => '検索結果';

	/// ja: '分析'
	String get analysis => '分析';
}

// Path: home
class Translations$home$ja {
	Translations$home$ja.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// ja: '電波人間が登録されていません'
	String get empty => '電波人間が登録されていません';

	/// ja: '削除の確認'
	String get deleteConfirmTitle => '削除の確認';

	/// ja: 'この電波人間を削除しますか?'
	String get deleteConfirmMessage => 'この電波人間を削除しますか?';

	/// ja: '選択した電波人間を削除しますか?'
	String get deleteSelectedConfirmMessage => '選択した電波人間を削除しますか?';

	/// ja: '選択項目をエクスポート'
	String get exportSelected => '選択項目をエクスポート';

	/// ja: '書き出し先を選択'
	String get exportDialogTitle => '書き出し先を選択';

	/// ja: 'インポート'
	String get importFromFile => 'インポート';

	/// ja: '重複している個体は上書きされます。インポートしない個体はチェックを外してください'
	String get importMergeConfirmTitle => '重複している個体は上書きされます。インポートしない個体はチェックを外してください';

	/// ja: 'ファイルを読み込めませんでした'
	String get importInvalidFile => 'ファイルを読み込めませんでした';

	/// ja: 'コピー'
	String get copySelected => 'コピー';

	/// ja: 'カット'
	String get cutSelected => 'カット';

	/// ja: '全選択'
	String get selectAll => '全選択';

	/// ja: '全選択解除'
	String get deselectAll => '全選択解除';

	/// ja: '検索'
	String get searchHint => '検索';

	/// ja: '単体で追加'
	String get addSingle => '単体で追加';

	/// ja: 'QRコードから追加'
	String get addFromQr => 'QRコードから追加';

	/// ja: '既存のQRコードから追加'
	String get addFromExistingQr => '既存のQRコードから追加';

	/// ja: 'QRコードファイルから追加'
	String get addFromQrFile => 'QRコードファイルから追加';

	/// ja: 'QRコードを読み取れませんでした'
	String get addFromQrFileInvalid => 'QRコードを読み取れませんでした';

	/// ja: 'リスト表示'
	String get viewModeList => 'リスト表示';

	/// ja: 'ツリー表示'
	String get viewModeTree => 'ツリー表示';

	/// ja: 'タイル表示'
	String get viewModeTile => 'タイル表示';

	/// ja: 'グリッド表示'
	String get viewModeGrid => 'グリッド表示';

	/// ja: '位置をリセット'
	String get resetTreePosition => '位置をリセット';

	/// ja: '${order}匹目: ${name}'
	String catchOrderLabel({required Object order, required Object name}) => '${order}匹目: ${name}';

	/// ja: '出生ガイド'
	String get birthGuideAction => '出生ガイド';

	/// ja: 'QRコードを表示'
	String get showQrCodeAction => 'QRコードを表示';
}

// Path: search
class Translations$search$ja {
	Translations$search$ja.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// ja: '名前'
	String get name => '名前';
}

// Path: backup
class Translations$backup$ja {
	Translations$backup$ja.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// ja: 'インポート結果'
	String get importCompleteTitle => 'インポート結果';

	/// ja: '新規追加'
	String get importAddedSection => '新規追加';

	/// ja: '上書き更新'
	String get importMergedSection => '上書き更新';

	/// ja: '親が見つからない個体'
	String get importOrphanedSection => '親が見つからない個体';

	/// ja: 'インポートできなかったデータ'
	String get importFailedSection => 'インポートできなかったデータ';

	/// ja: 'エクスポート結果'
	String get exportCompleteTitle => 'エクスポート結果';

	/// ja: 'エクスポート完了'
	String get exportExportedSection => 'エクスポート完了';

	/// ja: '親が同梱されていない個体'
	String get exportOrphanedSection => '親が同梱されていない個体';

	/// ja: '電波人間をインポート'
	String get importHeaderErrorTitle => '電波人間をインポート';

	/// ja: '電波人間のインポートに失敗しました。データバージョンを読み込めません。'
	String get importHeaderErrorDescription => '電波人間のインポートに失敗しました。データバージョンを読み込めません。';

	/// ja: '電波人間をインポート'
	String get importEntryParseErrorTitle => '電波人間をインポート';

	/// ja: '"${name}"のデータを読み込めませんでした'
	String importEntryParseErrorDescriptionNamed({required Object name}) => '"${name}"のデータを読み込めませんでした';

	/// ja: '${index}件目のデータを読み込めませんでした'
	String importEntryParseErrorDescriptionIndexed({required Object index}) => '${index}件目のデータを読み込めませんでした';
}

// Path: birthGuide
class Translations$birthGuide$ja {
	Translations$birthGuide$ja.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// ja: 'このQRコードから個体をキャッチしてください'
	String get catchQrInstruction => 'このQRコードから個体をキャッチしてください';

	/// ja: 'この個体をキャッチしてください'
	String get catchIndividualInstruction => 'この個体をキャッチしてください';

	/// ja: 'この個体を用意してください'
	String get breedParentInstruction => 'この個体を用意してください';

	/// ja: '出生後、この個体と同じものが出てきたか確認してください'
	String get confirmInstruction => '出生後、この個体と同じものが出てきたか確認してください';

	/// ja: '終了'
	String get finish => '終了';

	/// ja: 'エラー'
	String get errorTitle => 'エラー';

	/// ja: '系譜データの読み込みに失敗しました'
	String get errorMessage => '系譜データの読み込みに失敗しました';
}

// Path: denpaMenStatus
class Translations$denpaMenStatus$ja {
	Translations$denpaMenStatus$ja.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// ja: 'レベル'
	String get level => 'レベル';

	/// ja: '幸福度'
	String get happiness => '幸福度';

	/// ja: 'つぎのLvまで'
	String get untilNextLevel => 'つぎのLvまで';

	/// ja: 'MAX'
	String get max => 'MAX';

	/// ja: 'ぞくせいたいせいなし'
	String get noAttributeResistance => 'ぞくせいたいせいなし';
}

// Path: stat
class Translations$stat$ja {
	Translations$stat$ja.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// ja: 'アンテナ'
	String get antenna => 'アンテナ';

	/// ja: 'HP'
	String get hp => 'HP';

	/// ja: 'AP'
	String get ap => 'AP';

	/// ja: 'こうげきりょく'
	String get attack => 'こうげきりょく';

	/// ja: 'ぼうぎょりょく'
	String get defense => 'ぼうぎょりょく';

	/// ja: 'すばやさ'
	String get speed => 'すばやさ';

	/// ja: 'かいひりつ'
	String get evasionRate => 'かいひりつ';

	/// ja: '経験値'
	String get currentExp => '経験値';

	/// ja: '必要経験値'
	String get maxExp => '必要経験値';
}

// Path: editableStatus
class Translations$editableStatus$ja {
	Translations$editableStatus$ja.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// ja: '頭の形'
	String get headShape => '頭の形';

	/// ja: '体色'
	String get bodyColor => '体色';

	/// ja: 'SPカラー'
	String get spColor => 'SPカラー';

	/// ja: '薄い'
	String get bodyColorShadeThin => '薄い';

	/// ja: '通常'
	String get bodyColorShadeNormal => '通常';

	/// ja: '濃い'
	String get bodyColorShadeDark => '濃い';

	/// ja: 'アンテナ'
	String get antenna => 'アンテナ';

	/// ja: '補正'
	String get correction => '補正';

	/// ja: '親'
	String get parents => '親';

	/// ja: 'QRコードの名前'
	String get qrCodeName => 'QRコードの名前';

	/// ja: 'QRコード'
	String get qrCode => 'QRコード';

	/// ja: 'キャッチ順'
	String get catchOrder => 'キャッチ順';

	/// ja: 'メモ'
	String get memo => 'メモ';

	/// ja: '補正を考慮する'
	String get considerCorrections => '補正を考慮する';

	/// ja: '攻撃'
	String get antennaCategoryAttack => '攻撃';

	/// ja: 'サポート'
	String get antennaCategorySupport => 'サポート';

	/// ja: 'その他'
	String get antennaCategoryOther => 'その他';

	/// ja: 'レベル'
	String get antennaLevel => 'レベル';

	/// ja: '効果範囲'
	String get antennaTargetScope => '効果範囲';

	/// ja: '効果時間'
	String get antennaEffectDuration => '効果時間';

	/// ja: 'レベル'
	String get antennaPlusLevel => 'レベル';

	/// ja: '+${plusLevel}'
	String antennaPlusLevelValue({required Object plusLevel}) => '+${plusLevel}';

	/// ja: '${name}+${plusLevel}'
	String antennaNameWithPlusLevel({required Object name, required Object plusLevel}) => '${name}+${plusLevel}';
}

/// The flat map containing all translations for locale <ja>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on Translations {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'app.name' => 'Denpa Memo',
			'common.cancel' => 'キャンセル',
			'common.confirm' => '決定',
			'common.ok' => 'OK',
			'common.save' => '保存',
			'common.edit' => '編集',
			'common.delete' => '削除',
			'common.back' => '戻る',
			'common.next' => '次へ',
			'common.complete' => '完了',
			'common.unset' => '未設定',
			'page.home' => 'ホーム',
			'page.settings' => '設定',
			'page.addDenpaMen' => '電波人間を追加',
			'page.editDenpaMen' => '電波人間を編集',
			'page.addDenpaMenGroup' => '電波人間を追加',
			'page.qrRegenerate' => '再生成',
			'page.selectQrCode' => 'QRコードを選ぶ',
			'page.birthGuide' => '出生ガイド',
			'page.search' => '検索',
			'page.searchResults' => '検索結果',
			'page.analysis' => '分析',
			'home.empty' => '電波人間が登録されていません',
			'home.deleteConfirmTitle' => '削除の確認',
			'home.deleteConfirmMessage' => 'この電波人間を削除しますか?',
			'home.deleteSelectedConfirmMessage' => '選択した電波人間を削除しますか?',
			'home.exportSelected' => '選択項目をエクスポート',
			'home.exportDialogTitle' => '書き出し先を選択',
			'home.importFromFile' => 'インポート',
			'home.importMergeConfirmTitle' => '重複している個体は上書きされます。インポートしない個体はチェックを外してください',
			'home.importInvalidFile' => 'ファイルを読み込めませんでした',
			'home.copySelected' => 'コピー',
			'home.cutSelected' => 'カット',
			'home.selectAll' => '全選択',
			'home.deselectAll' => '全選択解除',
			'home.searchHint' => '検索',
			'home.addSingle' => '単体で追加',
			'home.addFromQr' => 'QRコードから追加',
			'home.addFromExistingQr' => '既存のQRコードから追加',
			'home.addFromQrFile' => 'QRコードファイルから追加',
			'home.addFromQrFileInvalid' => 'QRコードを読み取れませんでした',
			'home.viewModeList' => 'リスト表示',
			'home.viewModeTree' => 'ツリー表示',
			'home.viewModeTile' => 'タイル表示',
			'home.viewModeGrid' => 'グリッド表示',
			'home.resetTreePosition' => '位置をリセット',
			'home.catchOrderLabel' => ({required Object order, required Object name}) => '${order}匹目: ${name}',
			'home.birthGuideAction' => '出生ガイド',
			'home.showQrCodeAction' => 'QRコードを表示',
			'search.name' => '名前',
			'backup.importCompleteTitle' => 'インポート結果',
			'backup.importAddedSection' => '新規追加',
			'backup.importMergedSection' => '上書き更新',
			'backup.importOrphanedSection' => '親が見つからない個体',
			'backup.importFailedSection' => 'インポートできなかったデータ',
			'backup.exportCompleteTitle' => 'エクスポート結果',
			'backup.exportExportedSection' => 'エクスポート完了',
			'backup.exportOrphanedSection' => '親が同梱されていない個体',
			'backup.importHeaderErrorTitle' => '電波人間をインポート',
			'backup.importHeaderErrorDescription' => '電波人間のインポートに失敗しました。データバージョンを読み込めません。',
			'backup.importEntryParseErrorTitle' => '電波人間をインポート',
			'backup.importEntryParseErrorDescriptionNamed' => ({required Object name}) => '"${name}"のデータを読み込めませんでした',
			'backup.importEntryParseErrorDescriptionIndexed' => ({required Object index}) => '${index}件目のデータを読み込めませんでした',
			'birthGuide.catchQrInstruction' => 'このQRコードから個体をキャッチしてください',
			'birthGuide.catchIndividualInstruction' => 'この個体をキャッチしてください',
			'birthGuide.breedParentInstruction' => 'この個体を用意してください',
			'birthGuide.confirmInstruction' => '出生後、この個体と同じものが出てきたか確認してください',
			'birthGuide.finish' => '終了',
			'birthGuide.errorTitle' => 'エラー',
			'birthGuide.errorMessage' => '系譜データの読み込みに失敗しました',
			'denpaMenStatus.level' => 'レベル',
			'denpaMenStatus.happiness' => '幸福度',
			'denpaMenStatus.untilNextLevel' => 'つぎのLvまで',
			'denpaMenStatus.max' => 'MAX',
			'denpaMenStatus.noAttributeResistance' => 'ぞくせいたいせいなし',
			'stat.antenna' => 'アンテナ',
			'stat.hp' => 'HP',
			'stat.ap' => 'AP',
			'stat.attack' => 'こうげきりょく',
			'stat.defense' => 'ぼうぎょりょく',
			'stat.speed' => 'すばやさ',
			'stat.evasionRate' => 'かいひりつ',
			'stat.currentExp' => '経験値',
			'stat.maxExp' => '必要経験値',
			'editableStatus.headShape' => '頭の形',
			'editableStatus.bodyColor' => '体色',
			'editableStatus.spColor' => 'SPカラー',
			'editableStatus.bodyColorShadeThin' => '薄い',
			'editableStatus.bodyColorShadeNormal' => '通常',
			'editableStatus.bodyColorShadeDark' => '濃い',
			'editableStatus.antenna' => 'アンテナ',
			'editableStatus.correction' => '補正',
			'editableStatus.parents' => '親',
			'editableStatus.qrCodeName' => 'QRコードの名前',
			'editableStatus.qrCode' => 'QRコード',
			'editableStatus.catchOrder' => 'キャッチ順',
			'editableStatus.memo' => 'メモ',
			'editableStatus.considerCorrections' => '補正を考慮する',
			'editableStatus.antennaCategoryAttack' => '攻撃',
			'editableStatus.antennaCategorySupport' => 'サポート',
			'editableStatus.antennaCategoryOther' => 'その他',
			'editableStatus.antennaLevel' => 'レベル',
			'editableStatus.antennaTargetScope' => '効果範囲',
			'editableStatus.antennaEffectDuration' => '効果時間',
			'editableStatus.antennaPlusLevel' => 'レベル',
			'editableStatus.antennaPlusLevelValue' => ({required Object plusLevel}) => '+${plusLevel}',
			'editableStatus.antennaNameWithPlusLevel' => ({required Object name, required Object plusLevel}) => '${name}+${plusLevel}',
			'headShape.circle' => 'まる',
			'headShape.bowlCut' => 'おかっぱ',
			'headShape.bread' => 'しょくぱん',
			'headShape.castleTower' => 'てんしゅ',
			'headShape.dumpling' => 'おだんご',
			'headShape.fin' => 'ひれ',
			'headShape.frog' => 'かえる',
			'headShape.grandCastleTower' => 'だいてんしゅ',
			'headShape.light' => 'ひかり',
			'headShape.moon' => 'つき',
			'headShape.musician' => 'おんがくか',
			'headShape.ring' => 'わっか',
			'headShape.silkHat' => 'シルクハット',
			'headShape.sun' => 'たいよう',
			'headShape.wing' => 'はね',
			'headShape.triangle' => 'さんかく',
			'headShape.horizontalOval' => 'よこまる',
			'headShape.verticalOval' => 'たてまる',
			'headShape.roundedSquare' => 'かどまる',
			'headShape.soap' => 'せっけん',
			'headShape.droplet' => 'しずく',
			'headShape.bearCub' => 'こぐま',
			'headShape.morningDew' => 'あまつゆ',
			'headShape.robot' => 'ロボ',
			'headShape.spike' => 'とんがり',
			'headShape.battery' => 'でんち',
			'headShape.egg' => 'たまご',
			'headShape.sparkle' => 'きらきら',
			'headShape.onigiri' => 'おにぎり',
			'headShape.beans' => 'まめ',
			'correction.protagonist' => '主人公補正',
			'antenna.none' => 'アンテナなし',
			'antenna.antennaRoot' => 'アンテナのねっこ',
			'antenna.waterGun_1' => 'みずでっぽう',
			'antenna.waterGun_3' => 'バケツのみず',
			'antenna.waterGun_all' => 'たかなみ',
			'antenna.beam_1' => 'よわいこうせん',
			'antenna.beam_3' => 'スポットライト',
			'antenna.beam_all' => 'ふゆのひざし',
			'antenna.fireball_1' => 'ひのたま',
			'antenna.fireball_3' => 'ばくはつ',
			'antenna.fireball_all' => 'やまかじ',
			'antenna.heal_solo_1' => 'ちょっとかいふく',
			'antenna.heal_solo_2' => 'そこそこかいふく',
			'antenna.heal_all_1' => 'みんなちょっとかいふく',
			'antenna.heal_all_2' => 'みんなそこそこかいふく',
			'antenna.revive_solo_1' => 'ちょっとふっかつ',
			'antenna.revive_solo_2' => 'そこそこふっかつ',
			'antenna.revive_all_1' => 'みんなちょっとふっかつ',
			'antenna.revive_all_2' => 'みんなそこそこふっかつ',
			'antenna.excite_solo_1' => 'すこしこうふん',
			'antenna.excite_solo_2' => 'こうふん',
			'antenna.excite_solo_3' => 'ながくこうふん',
			'antenna.excite_all_1' => 'みんなすこしこうふん',
			'antenna.excite_all_2' => 'みんなこうふん',
			'antenna.excite_all_3' => 'みんなながくこうふん',
			'antenna.darkBall_1' => 'おどかす',
			'antenna.darkBall_3' => 'ダークボール',
			'antenna.darkBall_all' => 'くろいきり',
			'antenna.whirlwind_1' => 'つむじかぜ',
			'antenna.whirlwind_3' => 'ビルかぜ',
			'antenna.whirlwind_all' => 'かまいたち',
			'antenna.staticElectricity_1' => 'せいでんき',
			'antenna.staticElectricity_3' => 'いなずま',
			'antenna.staticElectricity_all' => 'ひゃくボルト',
			'antenna.sharpIce_1' => 'とがったこおり',
			'antenna.sharpIce_3' => 'ロックアイス',
			'antenna.sharpIce_all' => 'あられ',
			'antenna.fallingRock_1' => 'らくせき',
			'antenna.fallingRock_3' => 'いしつぶて',
			'antenna.fallingRock_all' => 'マグニチュード3',
			'antenna.knockdown_solo_1' => 'ノックダウン',
			'antenna.knockdown_solo_2' => 'いちげきKO',
			'antenna.knockdown_solo_3' => 'きゅうしょづき',
			'antenna.knockdown_all_1' => 'みんなノックダウン',
			'antenna.knockdown_all_2' => 'みんないちげきKO',
			'antenna.knockdown_all_3' => 'みんなきゅうしょづき',
			'antenna.harden_solo_1' => 'すこしかたくなれ',
			'antenna.harden_solo_2' => 'かたくなれ',
			'antenna.harden_solo_3' => 'すごくかたくなれ',
			'antenna.harden_all_1' => 'みんなかためになれ',
			'antenna.harden_all_2' => 'みんなかたくなれ',
			'antenna.harden_all_3' => 'みんなガチガチ',
			'antenna.invincible_solo_1' => 'すこしむてき',
			'antenna.invincible_solo_2' => 'むてき',
			'antenna.invincible_solo_3' => 'ながくむてき',
			'antenna.invincible_all_1' => 'みんなすこしむてき',
			'antenna.invincible_all_2' => 'みんなむてき',
			'antenna.invincible_all_3' => 'みんなながくむてき',
			'antenna.hardToDodge_all_1' => 'みんなすこしよけにくい',
			'antenna.hardToDodge_all_2' => 'みんなよけにくい',
			'antenna.hardToDodge_all_3' => 'みんなすごくよけにくい',
			'antenna.speedUp_solo_1' => 'すこしはやくなれ',
			'antenna.speedUp_solo_2' => 'はやくなれ',
			'antenna.speedUp_solo_3' => 'かぜになれ',
			'antenna.speedUp_all_1' => 'みんなすこしはやくなれ',
			'antenna.speedUp_all_2' => 'みんなはやくなれ',
			'antenna.speedUp_all_3' => 'みんなかぜになれ',
			'bodyColor.red' => 'あか',
			'bodyColor.blue' => 'あお',
			'bodyColor.yellow' => 'きいろ',
			'bodyColor.green' => 'みどり',
			'bodyColor.lightBlue' => 'みずいろ',
			'bodyColor.orange' => 'だいだい',
			'bodyColor.black' => 'くろ',
			'bodyColor.purple' => 'むらさき',
			'bodyColor.white' => 'しろ',
			'bodyColor.pink' => 'もも',
			'bodyColor.gold' => 'きん',
			'bodyColor.silver' => 'ぎん',
			'attribute.fire' => '火',
			'attribute.water' => '水',
			'attribute.thunder' => '雷',
			'attribute.earth' => '土',
			'attribute.ice' => '氷',
			'attribute.wind' => '風',
			'attribute.light' => '光',
			'attribute.dark' => '闇',
			'attribute.physical' => '物理',
			'attribute.suddenDeath' => '突然死',
			'abnormality.poison' => 'どく',
			'abnormality.burn' => 'やけど',
			'abnormality.frostbite' => 'しもやけ',
			'abnormality.cold' => 'かぜっぴき',
			'abnormality.mud' => 'どろだらけ',
			'abnormality.electrocution' => 'かんでん',
			'abnormality.soaked' => 'みずびだし',
			'abnormality.blind' => 'ブラインド',
			'abnormality.curse' => 'のろい',
			'abnormality.suddenDeath' => 'とつぜんし',
			'abnormality.paralysis' => 'マヒ',
			'abnormality.sleep' => 'ねむり',
			'abnormality.charm' => 'みりょう',
			'abnormality.fear' => 'きょうふ',
			'abnormality.jack' => 'ジャック',
			_ => null,
		};
	}
}
