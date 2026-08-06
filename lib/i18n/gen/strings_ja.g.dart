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
	late final Translations$common$ja common = Translations$common$ja.internal(_root);
	late final Translations$page$ja page = Translations$page$ja.internal(_root);
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

// Path: common
class Translations$common$ja {
	Translations$common$ja.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// ja: 'キャンセル'
	String get cancel => 'キャンセル';

	/// ja: '決定'
	String get confirm => '決定';
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

	/// ja: '次のLvまで'
	String get untilNextLevel => '次のLvまで';

	/// ja: 'MAX'
	String get max => 'MAX';
}

// Path: stat
class Translations$stat$ja {
	Translations$stat$ja.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

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

	/// ja: 'けいけんち'
	String get currentExp => 'けいけんち';

	/// ja: 'ひつようけいけんち'
	String get maxExp => 'ひつようけいけんち';
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
}

/// The flat map containing all translations for locale <ja>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on Translations {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'common.cancel' => 'キャンセル',
			'common.confirm' => '決定',
			'page.home' => 'ホーム',
			'page.settings' => '設定',
			'denpaMenStatus.level' => 'レベル',
			'denpaMenStatus.happiness' => '幸福度',
			'denpaMenStatus.untilNextLevel' => '次のLvまで',
			'denpaMenStatus.max' => 'MAX',
			'stat.hp' => 'HP',
			'stat.ap' => 'AP',
			'stat.attack' => 'こうげきりょく',
			'stat.defense' => 'ぼうぎょりょく',
			'stat.speed' => 'すばやさ',
			'stat.evasionRate' => 'かいひりつ',
			'stat.currentExp' => 'けいけんち',
			'stat.maxExp' => 'ひつようけいけんち',
			'editableStatus.headShape' => '頭の形',
			'editableStatus.bodyColor' => '体色',
			'editableStatus.spColor' => 'SPカラー',
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
