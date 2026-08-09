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
	};
	Map<String, String> get correction => {
		'protagonist': '主人公補正',
	};
	Map<String, String> get antenna => {
		'none': 'アンテナなし',
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

	/// ja: '選択した電波人間をJSONとしてコピーしました'
	String get exportedToClipboard => '選択した電波人間をJSONとしてコピーしました';

	/// ja: 'コピー'
	String get copySelected => 'コピー';

	/// ja: 'カット'
	String get cutSelected => 'カット';

	/// ja: '検索'
	String get searchHint => '検索';

	/// ja: '単体で追加'
	String get addSingle => '単体で追加';

	/// ja: 'QRコードから追加'
	String get addFromQr => 'QRコードから追加';
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

	/// ja: 'アンテナ'
	String get antenna => 'アンテナ';

	/// ja: '補正'
	String get correction => '補正';

	/// ja: '親'
	String get parents => '親';

	/// ja: '未設定'
	String get parentUnset => '未設定';

	/// ja: 'メモ'
	String get memo => 'メモ';

	/// ja: '補正を考慮する'
	String get considerCorrections => '補正を考慮する';
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
			'common.save' => '保存',
			'common.edit' => '編集',
			'common.delete' => '削除',
			'common.back' => '戻る',
			'common.next' => '次へ',
			'common.complete' => '完了',
			'page.home' => 'ホーム',
			'page.settings' => '設定',
			'page.addDenpaMen' => '電波人間を追加',
			'page.editDenpaMen' => '電波人間を編集',
			'page.addDenpaMenGroup' => '電波人間を追加',
			'page.qrRegenerate' => '再生成',
			'home.empty' => '電波人間が登録されていません',
			'home.deleteConfirmTitle' => '削除の確認',
			'home.deleteConfirmMessage' => 'この電波人間を削除しますか?',
			'home.deleteSelectedConfirmMessage' => '選択した電波人間を削除しますか?',
			'home.exportSelected' => '選択項目をエクスポート',
			'home.exportedToClipboard' => '選択した電波人間をJSONとしてコピーしました',
			'home.copySelected' => 'コピー',
			'home.cutSelected' => 'カット',
			'home.searchHint' => '検索',
			'home.addSingle' => '単体で追加',
			'home.addFromQr' => 'QRコードから追加',
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
			'editableStatus.antenna' => 'アンテナ',
			'editableStatus.correction' => '補正',
			'editableStatus.parents' => '親',
			'editableStatus.parentUnset' => '未設定',
			'editableStatus.memo' => 'メモ',
			'editableStatus.considerCorrections' => '補正を考慮する',
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
			'correction.protagonist' => '主人公補正',
			'antenna.none' => 'アンテナなし',
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
