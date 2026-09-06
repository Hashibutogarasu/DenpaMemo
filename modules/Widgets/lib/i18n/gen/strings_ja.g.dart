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
	late final Translations$birthGuide$ja birthGuide = Translations$birthGuide$ja.internal(_root);
	late final Translations$home$ja home = Translations$home$ja.internal(_root);
	late final Translations$search$ja search = Translations$search$ja.internal(_root);
	late final Translations$denpaMenStatus$ja denpaMenStatus = Translations$denpaMenStatus$ja.internal(_root);
	late final Translations$stat$ja stat = Translations$stat$ja.internal(_root);
	late final Translations$editableStatus$ja editableStatus = Translations$editableStatus$ja.internal(_root);
	late final Translations$backup$ja backup = Translations$backup$ja.internal(_root);
	late final Translations$dialog$ja dialog = Translations$dialog$ja.internal(_root);
	Map<String, String> get monster => {
		'swordmouse': 'ねずみけんし',
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
		'speedDown_solo_1': 'すこしおそくなれ',
		'speedDown_solo_2': 'おそくなれ',
		'speedDown_solo_3': 'すごくおそくなれ',
		'speedDown_all_1': 'みんなすこしおそくなれ',
		'speedDown_all_2': 'みんなおそくなれ',
		'speedDown_all_3': 'みんなのろのろ',
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
	Map<String, String> get correction => {
		'protagonist': '主人公補正',
	};
	Map<String, String> get physique => {
		'largest': '最大',
		'large': '準大',
		'medium': '中間',
		'fast': '準速',
		'fastest': '最速',
	};
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

// Path: common
class Translations$common$ja {
	Translations$common$ja.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// ja: '戻る'
	String get back => '戻る';

	/// ja: 'キャンセル'
	String get cancel => 'キャンセル';

	/// ja: '決定'
	String get confirm => '決定';

	/// ja: 'コピー'
	String get copy => 'コピー';

	/// ja: 'エラー'
	String get errorTitle => 'エラー';

	/// ja: '未設定'
	String get unset => '未設定';
}

// Path: birthGuide
class Translations$birthGuide$ja {
	Translations$birthGuide$ja.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// ja: '系譜データの読み込みに失敗しました'
	String get errorMessage => '系譜データの読み込みに失敗しました';

	/// ja: 'エラー'
	String get errorTitle => 'エラー';
}

// Path: home
class Translations$home$ja {
	Translations$home$ja.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// ja: '検索'
	String get searchHint => '検索';
}

// Path: search
class Translations$search$ja {
	Translations$search$ja.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// ja: '名前'
	String get name => '名前';
}

// Path: denpaMenStatus
class Translations$denpaMenStatus$ja {
	Translations$denpaMenStatus$ja.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// ja: '幸福度'
	String get happiness => '幸福度';

	/// ja: 'レベル'
	String get level => 'レベル';

	/// ja: 'MAX'
	String get max => 'MAX';

	/// ja: 'ぞくせいたいせいなし'
	String get noAttributeResistance => 'ぞくせいたいせいなし';

	/// ja: 'つぎのLvまで'
	String get untilNextLevel => 'つぎのLvまで';
}

// Path: stat
class Translations$stat$ja {
	Translations$stat$ja.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// ja: 'アンテナ'
	String get antenna => 'アンテナ';

	/// ja: 'AP'
	String get ap => 'AP';

	/// ja: 'こうげきりょく'
	String get attack => 'こうげきりょく';

	/// ja: '経験値'
	String get currentExp => '経験値';

	/// ja: 'ぼうぎょりょく'
	String get defense => 'ぼうぎょりょく';

	/// ja: 'かいひりつ'
	String get evasionRate => 'かいひりつ';

	/// ja: 'HP'
	String get hp => 'HP';

	/// ja: '必要経験値'
	String get maxExp => '必要経験値';

	/// ja: 'すばやさ'
	String get speed => 'すばやさ';
}

// Path: editableStatus
class Translations$editableStatus$ja {
	Translations$editableStatus$ja.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// ja: 'アンテナ'
	String get antenna => 'アンテナ';

	/// ja: '攻撃'
	String get antennaCategoryAttack => '攻撃';

	/// ja: 'その他'
	String get antennaCategoryOther => 'その他';

	/// ja: 'サポート'
	String get antennaCategorySupport => 'サポート';

	/// ja: '効果時間'
	String get antennaEffectDuration => '効果時間';

	/// ja: 'レベル'
	String get antennaLevel => 'レベル';

	/// ja: '${name}+${plusLevel}'
	String antennaNameWithPlusLevel({required Object name, required Object plusLevel}) => '${name}+${plusLevel}';

	/// ja: '+${plusLevel}'
	String antennaPlusLevelValue({required Object plusLevel}) => '+${plusLevel}';

	/// ja: '効果範囲'
	String get antennaTargetScope => '効果範囲';

	/// ja: '体色'
	String get bodyColor => '体色';

	/// ja: '濃い'
	String get bodyColorShadeDark => '濃い';

	/// ja: '通常'
	String get bodyColorShadeNormal => '通常';

	/// ja: '薄い'
	String get bodyColorShadeThin => '薄い';

	/// ja: '補正を考慮する'
	String get considerCorrections => '補正を考慮する';

	/// ja: '補正'
	String get correction => '補正';

	/// ja: '頭の形'
	String get headShape => '頭の形';

	/// ja: 'メモ'
	String get memo => 'メモ';

	/// ja: 'モンスターから獲得した経験値を記録'
	String get monsterExp => 'モンスターから獲得した経験値を記録';

	/// ja: '親'
	String get parents => '親';

	/// ja: '体格'
	String get physique => '体格';

	/// ja: 'QRコード'
	String get qrCode => 'QRコード';

	/// ja: 'SPカラー'
	String get spColor => 'SPカラー';
}

// Path: backup
class Translations$backup$ja {
	Translations$backup$ja.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// ja: 'エクスポート結果'
	String get exportCompleteTitle => 'エクスポート結果';

	/// ja: 'エクスポート完了'
	String get exportExportedSection => 'エクスポート完了';

	/// ja: '親が同梱されていない個体'
	String get exportOrphanedSection => '親が同梱されていない個体';
}

// Path: dialog
class Translations$dialog$ja {
	Translations$dialog$ja.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final Translations$dialog$accountSignIn$ja accountSignIn = Translations$dialog$accountSignIn$ja.internal(_root);
	late final Translations$dialog$accountSignUp$ja accountSignUp = Translations$dialog$accountSignUp$ja.internal(_root);
}

// Path: dialog.accountSignIn
class Translations$dialog$accountSignIn$ja {
	Translations$dialog$accountSignIn$ja.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// ja: 'クラウドアカウントにサインイン'
	String get title => 'クラウドアカウントにサインイン';

	/// ja: 'メールアドレス'
	String get emailLabel => 'メールアドレス';

	/// ja: 'パスワード'
	String get passwordLabel => 'パスワード';

	/// ja: 'または'
	String get orDivider => 'または';

	/// ja: 'Googleでサインイン'
	String get googleButton => 'Googleでサインイン';

	/// ja: 'アカウントを作成'
	String get createAccountLink => 'アカウントを作成';

	/// ja: 'サインイン'
	String get confirmButton => 'サインイン';
}

// Path: dialog.accountSignUp
class Translations$dialog$accountSignUp$ja {
	Translations$dialog$accountSignUp$ja.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// ja: 'アカウントを作成'
	String get title => 'アカウントを作成';

	/// ja: 'メールアドレス'
	String get emailLabel => 'メールアドレス';

	/// ja: 'パスワード'
	String get passwordLabel => 'パスワード';

	/// ja: 'サインアップ'
	String get confirmButton => 'サインアップ';
}

/// The flat map containing all translations for locale <ja>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on Translations {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'common.back' => '戻る',
			'common.cancel' => 'キャンセル',
			'common.confirm' => '決定',
			'common.copy' => 'コピー',
			'common.errorTitle' => 'エラー',
			'common.unset' => '未設定',
			'birthGuide.errorMessage' => '系譜データの読み込みに失敗しました',
			'birthGuide.errorTitle' => 'エラー',
			'home.searchHint' => '検索',
			'search.name' => '名前',
			'denpaMenStatus.happiness' => '幸福度',
			'denpaMenStatus.level' => 'レベル',
			'denpaMenStatus.max' => 'MAX',
			'denpaMenStatus.noAttributeResistance' => 'ぞくせいたいせいなし',
			'denpaMenStatus.untilNextLevel' => 'つぎのLvまで',
			'stat.antenna' => 'アンテナ',
			'stat.ap' => 'AP',
			'stat.attack' => 'こうげきりょく',
			'stat.currentExp' => '経験値',
			'stat.defense' => 'ぼうぎょりょく',
			'stat.evasionRate' => 'かいひりつ',
			'stat.hp' => 'HP',
			'stat.maxExp' => '必要経験値',
			'stat.speed' => 'すばやさ',
			'editableStatus.antenna' => 'アンテナ',
			'editableStatus.antennaCategoryAttack' => '攻撃',
			'editableStatus.antennaCategoryOther' => 'その他',
			'editableStatus.antennaCategorySupport' => 'サポート',
			'editableStatus.antennaEffectDuration' => '効果時間',
			'editableStatus.antennaLevel' => 'レベル',
			'editableStatus.antennaNameWithPlusLevel' => ({required Object name, required Object plusLevel}) => '${name}+${plusLevel}',
			'editableStatus.antennaPlusLevelValue' => ({required Object plusLevel}) => '+${plusLevel}',
			'editableStatus.antennaTargetScope' => '効果範囲',
			'editableStatus.bodyColor' => '体色',
			'editableStatus.bodyColorShadeDark' => '濃い',
			'editableStatus.bodyColorShadeNormal' => '通常',
			'editableStatus.bodyColorShadeThin' => '薄い',
			'editableStatus.considerCorrections' => '補正を考慮する',
			'editableStatus.correction' => '補正',
			'editableStatus.headShape' => '頭の形',
			'editableStatus.memo' => 'メモ',
			'editableStatus.monsterExp' => 'モンスターから獲得した経験値を記録',
			'editableStatus.parents' => '親',
			'editableStatus.physique' => '体格',
			'editableStatus.qrCode' => 'QRコード',
			'editableStatus.spColor' => 'SPカラー',
			'backup.exportCompleteTitle' => 'エクスポート結果',
			'backup.exportExportedSection' => 'エクスポート完了',
			'backup.exportOrphanedSection' => '親が同梱されていない個体',
			'dialog.accountSignIn.title' => 'クラウドアカウントにサインイン',
			'dialog.accountSignIn.emailLabel' => 'メールアドレス',
			'dialog.accountSignIn.passwordLabel' => 'パスワード',
			'dialog.accountSignIn.orDivider' => 'または',
			'dialog.accountSignIn.googleButton' => 'Googleでサインイン',
			'dialog.accountSignIn.createAccountLink' => 'アカウントを作成',
			'dialog.accountSignIn.confirmButton' => 'サインイン',
			'dialog.accountSignUp.title' => 'アカウントを作成',
			'dialog.accountSignUp.emailLabel' => 'メールアドレス',
			'dialog.accountSignUp.passwordLabel' => 'パスワード',
			'dialog.accountSignUp.confirmButton' => 'サインアップ',
			'monster.swordmouse' => 'ねずみけんし',
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
			'antenna.speedDown_solo_1' => 'すこしおそくなれ',
			'antenna.speedDown_solo_2' => 'おそくなれ',
			'antenna.speedDown_solo_3' => 'すごくおそくなれ',
			'antenna.speedDown_all_1' => 'みんなすこしおそくなれ',
			'antenna.speedDown_all_2' => 'みんなおそくなれ',
			'antenna.speedDown_all_3' => 'みんなのろのろ',
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
			'correction.protagonist' => '主人公補正',
			'physique.largest' => '最大',
			'physique.large' => '準大',
			'physique.medium' => '中間',
			'physique.fast' => '準速',
			'physique.fastest' => '最速',
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
