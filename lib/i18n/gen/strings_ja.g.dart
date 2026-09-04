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
	late final Translations$profile$ja profile = Translations$profile$ja.internal(_root);
	late final Translations$step$ja step = Translations$step$ja.internal(_root);
	late final Translations$page$ja page = Translations$page$ja.internal(_root);
	late final Translations$settings$ja settings = Translations$settings$ja.internal(_root);
	late final Translations$physiqueTable$ja physiqueTable = Translations$physiqueTable$ja.internal(_root);
	late final Translations$home$ja home = Translations$home$ja.internal(_root);
	late final Translations$search$ja search = Translations$search$ja.internal(_root);
	Map<String, String> get monster => {
		'swordmouse': 'ねずみけんし',
	};
	Map<String, String> get languages => {
		'ja': '日本語',
	};
	late final Translations$masterData$ja masterData = Translations$masterData$ja.internal(_root);
	late final Translations$backup$ja backup = Translations$backup$ja.internal(_root);
	late final Translations$cloudBackup$ja cloudBackup = Translations$cloudBackup$ja.internal(_root);
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
	late final Translations$croppy$ja croppy = Translations$croppy$ja.internal(_root);
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

	/// ja: '再試行'
	String get retry => '再試行';

	/// ja: 'エラー'
	String get errorTitle => 'エラー';
}

// Path: profile
class Translations$profile$ja {
	Translations$profile$ja.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// ja: 'プロファイルを切り替え'
	String get switchProfile => 'プロファイルを切り替え';

	/// ja: 'プロファイル切り替え'
	String get switchPageTitle => 'プロファイル切り替え';

	/// ja: '新規作成'
	String get create => '新規作成';

	/// ja: 'プロファイル名'
	String get nameDialogTitle => 'プロファイル名';

	/// ja: 'デフォルト'
	String get defaultName => 'デフォルト';
}

// Path: step
class Translations$step$ja {
	Translations$step$ja.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// ja: '処理に失敗しました'
	String get failureTitle => '処理に失敗しました';

	/// ja: '処理中にエラーが発生しました: ${error}'
	String failureDescription({required Object error}) => '処理中にエラーが発生しました: ${error}';
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

	/// ja: 'アカウント'
	String get accountSettings => 'アカウント';

	/// ja: 'テーマ'
	String get themeSettings => 'テーマ';

	/// ja: '言語'
	String get languageSettings => '言語';

	/// ja: 'データ管理'
	String get dataManagement => 'データ管理';

	/// ja: 'オープンソースライセンス'
	String get openSourceLicenses => 'オープンソースライセンス';

	/// ja: 'クラウドバックアップ&復元'
	String get cloudBackup => 'クラウドバックアップ&復元';

	/// ja: 'バックアップ履歴'
	String get cloudBackupHistory => 'バックアップ履歴';

	/// ja: '画像切り抜き'
	String get clippingSettings => '画像切り抜き';

	/// ja: '画像切り抜き - ${profileName}'
	String clippingSettingsTitle({required Object profileName}) => '画像切り抜き - ${profileName}';
}

// Path: settings
class Translations$settings$ja {
	Translations$settings$ja.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final Translations$settings$section$ja section = Translations$settings$section$ja.internal(_root);

	/// ja: '${label}をコピーしました'
	String copiedToast({required Object label}) => '${label}をコピーしました';

	/// ja: 'アカウント'
	String get account => 'アカウント';

	late final Translations$settings$accountSettings$ja accountSettings = Translations$settings$accountSettings$ja.internal(_root);

	/// ja: 'テーマ'
	String get theme => 'テーマ';

	/// ja: '画像切り抜き'
	String get clipping => '画像切り抜き';

	/// ja: '顔'
	String get clippingFace => '顔';

	/// ja: '全身'
	String get clippingWholeBody => '全身';

	/// ja: 'アイコン'
	String get clippingIcon => 'アイコン';

	/// ja: '左${left}% 上${top}% 右${right}% 下${bottom}%'
	String clippingRangeText({required Object left, required Object top, required Object right, required Object bottom}) => '左${left}% 上${top}% 右${right}% 下${bottom}%';

	/// ja: '言語'
	String get language => '言語';

	/// ja: '通知'
	String get notifications => '通知';

	/// ja: '詳細設定'
	String get advanced => '詳細設定';

	/// ja: '統計'
	String get statistics => '統計';

	/// ja: 'オープンソースライセンス'
	String get openSourceLicenses => 'オープンソースライセンス';

	/// ja: 'データ管理'
	String get dataManagement => 'データ管理';

	/// ja: 'ビルド番号'
	String get buildNumber => 'ビルド番号';

	/// ja: 'アプリバージョン'
	String get appVersion => 'アプリバージョン';

	/// ja: 'リリースチャンネル'
	String get releaseChannel => 'リリースチャンネル';

	/// ja: 'リリース'
	String get releaseChannelStable => 'リリース';

	/// ja: 'プロファイル'
	String get releaseChannelProfile => 'プロファイル';

	/// ja: 'デバッグ'
	String get releaseChannelDebug => 'デバッグ';

	/// ja: 'アカウントID'
	String get accountCuidLabel => 'アカウントID';

	/// ja: '作成日時'
	String get accountCreatedAtLabel => '作成日時';

	/// ja: 'システム設定に合わせる'
	String get themeSystem => 'システム設定に合わせる';

	/// ja: 'ライト'
	String get themeLight => 'ライト';

	/// ja: 'ダーク'
	String get themeDark => 'ダーク';

	/// ja: 'アプリのデータを全て削除'
	String get dataManagementDeleteAllData => 'アプリのデータを全て削除';

	/// ja: 'アプリのデータを全て削除'
	String get dataManagementDeleteAllDataConfirmTitle => 'アプリのデータを全て削除';

	/// ja: '電波人間やQRコードなど、このアプリに保存されているすべてのデータを削除します。この操作は取り消せません。よろしいですか?'
	String get dataManagementDeleteAllDataConfirmMessage => '電波人間やQRコードなど、このアプリに保存されているすべてのデータを削除します。この操作は取り消せません。よろしいですか?';

	/// ja: 'アプリのデータを全て削除しました'
	String get dataManagementDeleteAllDataResult => 'アプリのデータを全て削除しました';

	/// ja: 'キャッシュデータをクリア'
	String get dataManagementClearCache => 'キャッシュデータをクリア';

	/// ja: 'キャッシュクリアの確認'
	String get dataManagementClearCacheConfirmTitle => 'キャッシュクリアの確認';

	/// ja: '一時的なキャッシュデータを削除します。よろしいですか?'
	String get dataManagementClearCacheConfirmMessage => '一時的なキャッシュデータを削除します。よろしいですか?';

	/// ja: 'キャッシュデータを削除しました'
	String get dataManagementClearCacheResult => 'キャッシュデータを削除しました';

	/// ja: '削除しました'
	String get dataManagementResultTitle => '削除しました';

	/// ja: 'クラウドバックアップ&復元'
	String get cloudBackup => 'クラウドバックアップ&復元';

	/// ja: '体格表を編集'
	String get editPhysiqueTable => '体格表を編集';
}

// Path: physiqueTable
class Translations$physiqueTable$ja {
	Translations$physiqueTable$ja.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// ja: '体格表'
	String get title => '体格表';

	/// ja: 'レベル${level} - ${anntenaCategory} の体格表'
	String tableTitle({required Object level, required Object anntenaCategory}) => 'レベル${level} - ${anntenaCategory} の体格表';

	/// ja: 'レベルを入力'
	String get enterLevel => 'レベルを入力';

	/// ja: 'ステータスを選択'
	String get selectStatusCategory => 'ステータスを選択';

	/// ja: 'アンテナを選択'
	String get selectAnntenaCategory => 'アンテナを選択';

	/// ja: '新規作成'
	String get createNewTable => '新規作成';

	/// ja: '編集'
	String get edit => '編集';

	/// ja: '行を追加'
	String get addRow => '行を追加';

	/// ja: '保存'
	String get save => '保存';

	/// ja: '保存しました'
	String get saved => '保存しました';

	/// ja: 'この表を削除'
	String get deleteTable => 'この表を削除';

	/// ja: '体格表を削除'
	String get deleteTableConfirmTitle => '体格表を削除';

	/// ja: 'この体格表を削除します。この操作は取り消せません。よろしいですか?'
	String get deleteTableConfirmMessage => 'この体格表を削除します。この操作は取り消せません。よろしいですか?';

	/// ja: 'この行を削除'
	String get deleteRow => 'この行を削除';

	/// ja: '行を削除'
	String get deleteRowConfirmTitle => '行を削除';

	/// ja: 'この行を削除します。この操作は取り消せません。よろしいですか?'
	String get deleteRowConfirmMessage => 'この行を削除します。この操作は取り消せません。よろしいですか?';

	/// ja: '行をまとめて削除'
	String get deleteSelectedRows => '行をまとめて削除';

	/// ja: '行をまとめて削除'
	String get deleteSelectedRowsConfirmTitle => '行をまとめて削除';

	/// ja: '選択した行を削除します。この操作は取り消せません。よろしいですか?'
	String get deleteSelectedRowsConfirmMessage => '選択した行を削除します。この操作は取り消せません。よろしいですか?';

	/// ja: 'この表にはまだデータがありません。'
	String get empty => 'この表にはまだデータがありません。';

	/// ja: '表の読み込みに失敗しました。'
	String get loadError => '表の読み込みに失敗しました。';
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

	/// ja: 'カーソル表示の切り替え'
	String get toggleTreeCursor => 'カーソル表示の切り替え';

	/// ja: '選択'
	String get selectHoveredTreeIndividual => '選択';

	/// ja: '選択解除'
	String get deselectHoveredTreeIndividual => '選択解除';

	/// ja: '${order}匹目: ${name}'
	String catchOrderLabel({required Object order, required Object name}) => '${order}匹目: ${name}';

	/// ja: '出生ガイド'
	String get birthGuideAction => '出生ガイド';

	/// ja: 'QRコードを表示'
	String get showQrCodeAction => 'QRコードを表示';

	/// ja: '系譜ツリーをJSONとしてコピー'
	String get copyLineageTreeJsonAction => '系譜ツリーをJSONとしてコピー';
}

// Path: search
class Translations$search$ja {
	Translations$search$ja.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// ja: '名前'
	String get name => '名前';

	/// ja: 'リスト'
	String get tabList => 'リスト';

	/// ja: '検索'
	String get tabSearch => '検索';
}

// Path: masterData
class Translations$masterData$ja {
	Translations$masterData$ja.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// ja: 'マスターデータを読み込み中'
	String get loading => 'マスターデータを読み込み中';

	/// ja: 'サーバーに接続できません'
	String get connectionErrorTitle => 'サーバーに接続できません';

	/// ja: 'サーバーに接続できませんでした。サーバーが起動しているか、接続先を確認してください。'
	String get connectionErrorDescription => 'サーバーに接続できませんでした。サーバーが起動しているか、接続先を確認してください。';

	/// ja: 'マスターデータの取得に失敗しました'
	String get serverErrorTitle => 'マスターデータの取得に失敗しました';

	/// ja: 'サーバーがエラーを返しました: ${message}'
	String serverErrorDescription({required Object message}) => 'サーバーがエラーを返しました: ${message}';
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

// Path: cloudBackup
class Translations$cloudBackup$ja {
	Translations$cloudBackup$ja.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// ja: '最新のクラウドバックアップ'
	String get latestBackupLabel => '最新のクラウドバックアップ';

	/// ja: 'ローカルファイル'
	String get localFileLabel => 'ローカルファイル';

	/// ja: 'この機能を使うにはアカウントにサインインしてください。'
	String get notSignedInDescription => 'この機能を使うにはアカウントにサインインしてください。';

	/// ja: 'クラウドにバックアップが存在しません。先にバックアップを実行してください。'
	String get noBackupFoundDescription => 'クラウドにバックアップが存在しません。先にバックアップを実行してください。';

	/// ja: 'クラウドとの通信に失敗しました: ${message}'
	String networkErrorDescription({required Object message}) => 'クラウドとの通信に失敗しました: ${message}';

	/// ja: 'クラウドにバックアップしています'
	String get backupRunning => 'クラウドにバックアップしています';

	/// ja: 'クラウドから復元しています'
	String get restoreRunning => 'クラウドから復元しています';

	/// ja: 'キャンセルしました'
	String get cancelled => 'キャンセルしました';

	/// ja: 'バックアップ履歴を見る'
	String get historyAction => 'バックアップ履歴を見る';

	/// ja: 'バックアップ履歴がありません。'
	String get historyEmptyDescription => 'バックアップ履歴がありません。';

	/// ja: '復元'
	String get restoreAction => '復元';

	/// ja: 'バックアップを削除しますか?'
	String get deleteConfirmTitle => 'バックアップを削除しますか?';

	/// ja: 'このバックアップファイルを削除します。この操作は取り消せません。'
	String get deleteConfirmMessage => 'このバックアップファイルを削除します。この操作は取り消せません。';

	/// ja: '選択したバックアップファイルを削除します。この操作は取り消せません。'
	String get deleteSelectedConfirmMessage => '選択したバックアップファイルを削除します。この操作は取り消せません。';
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

	/// ja: 'モンスターから獲得した経験値を記録'
	String get monsterExp => 'モンスターから獲得した経験値を記録';

	/// ja: 'モンスターを選択'
	String get monsterExpSelectMonster => 'モンスターを選択';

	/// ja: '討伐数'
	String get monsterExpCount => '討伐数';

	/// ja: '経験値'
	String get monsterExpExp => '経験値';

	/// ja: 'レベル'
	String get monsterExpLevel => 'レベル';

	/// ja: 'レベル最大の電波人間の人数'
	String get monsterExpMaxLevelTeammateCount => 'レベル最大の電波人間の人数';

	/// ja: '経験値を獲得した人数'
	String get monsterExpRecipientCount => '経験値を獲得した人数';
}

// Path: croppy
class Translations$croppy$ja {
	Translations$croppy$ja.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// ja: 'リセット'
	String get materialResetLabel => 'リセット';

	/// ja: 'リセット'
	String get cupertinoResetLabel => 'リセット';

	/// ja: '${direction}に反転'
	String materialFlipLabel({required Object direction}) => '${direction}に反転';

	/// ja: '縦'
	String get directionVertical => '縦';

	/// ja: '横'
	String get directionHorizontal => '横';

	/// ja: 'フリーフォーム'
	String get materialFreeformAspectRatioLabel => 'フリーフォーム';

	/// ja: '元のサイズ'
	String get materialOriginalAspectRatioLabel => '元のサイズ';

	/// ja: '正方形'
	String get materialSquareAspectRatioLabel => '正方形';

	/// ja: '保存'
	String get saveLabel => '保存';

	/// ja: '完了'
	String get doneLabel => '完了';

	/// ja: 'キャンセル'
	String get cancelLabel => 'キャンセル';

	/// ja: 'フリーフォーム'
	String get cupertinoFreeformAspectRatioLabel => 'フリーフォーム';

	/// ja: '元のサイズ'
	String get cupertinoOriginalAspectRatioLabel => '元のサイズ';

	/// ja: '正方形'
	String get cupertinoSquareAspectRatioLabel => '正方形';
}

// Path: settings.section
class Translations$settings$section$ja {
	Translations$settings$section$ja.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// ja: '全般'
	String get general => '全般';

	/// ja: '個人設定'
	String get personal => '個人設定';

	/// ja: 'データ'
	String get data => 'データ';

	/// ja: 'その他'
	String get other => 'その他';

	/// ja: '開発者向け'
	String get developer => '開発者向け';
}

// Path: settings.accountSettings
class Translations$settings$accountSettings$ja {
	Translations$settings$accountSettings$ja.internal(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// ja: 'クラウドアカウント'
	String get sectionCloud => 'クラウドアカウント';

	/// ja: 'ローカルアカウント'
	String get sectionLocal => 'ローカルアカウント';

	/// ja: 'デンジャーゾーン'
	String get sectionDangerZone => 'デンジャーゾーン';

	/// ja: 'サインイン'
	String get signIn => 'サインイン';

	/// ja: 'UID'
	String get cloudUidLabel => 'UID';

	/// ja: 'サインアウト'
	String get signOut => 'サインアウト';

	/// ja: 'サインアウトの確認'
	String get signOutConfirmTitle => 'サインアウトの確認';

	/// ja: 'サインアウトしますか?'
	String get signOutConfirmMessage => 'サインアウトしますか?';

	/// ja: 'クラウドアカウントを削除'
	String get deleteCloudAccount => 'クラウドアカウントを削除';

	/// ja: 'クラウドアカウントを削除'
	String get deleteCloudAccountConfirmTitle => 'クラウドアカウントを削除';

	/// ja: 'クラウドアカウントを削除します。この操作は取り消せません。よろしいですか? クラウドに保存したバックアップファイルも削除されます。'
	String get deleteCloudAccountConfirmMessage => 'クラウドアカウントを削除します。この操作は取り消せません。よろしいですか?\nクラウドに保存したバックアップファイルも削除されます。';

	/// ja: 'ローカルアカウントを追加する'
	String get addLocalAccount => 'ローカルアカウントを追加する';

	/// ja: 'ローカルアカウントを削除'
	String get deleteLocalAccount => 'ローカルアカウントを削除';

	/// ja: 'ディスプレイが見つかりませんでした。以下のURLをコピーしてブラウザで認証してください。'
	String get manualAuthUrlMessage => 'ディスプレイが見つかりませんでした。以下のURLをコピーしてブラウザで認証してください。';

	/// ja: 'Googleサインイン'
	String get signInFlowTitle => 'Googleサインイン';

	/// ja: '認証コードを受け取っています'
	String get signInFlowStepReceiveAuthorization => '認証コードを受け取っています';

	/// ja: 'トークンを交換しています'
	String get signInFlowStepExchangeCode => 'トークンを交換しています';

	/// ja: 'セッションを発行しています'
	String get signInFlowStepIssueSession => 'セッションを発行しています';

	/// ja: 'セッションをリフレッシュしています'
	String get signInFlowStepRefreshSession => 'セッションをリフレッシュしています';

	/// ja: 'アカウント情報を保存しています'
	String get signInFlowStepExtractUid => 'アカウント情報を保存しています';
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
			'common.retry' => '再試行',
			'common.errorTitle' => 'エラー',
			'profile.switchProfile' => 'プロファイルを切り替え',
			'profile.switchPageTitle' => 'プロファイル切り替え',
			'profile.create' => '新規作成',
			'profile.nameDialogTitle' => 'プロファイル名',
			'profile.defaultName' => 'デフォルト',
			'step.failureTitle' => '処理に失敗しました',
			'step.failureDescription' => ({required Object error}) => '処理中にエラーが発生しました: ${error}',
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
			'page.accountSettings' => 'アカウント',
			'page.themeSettings' => 'テーマ',
			'page.languageSettings' => '言語',
			'page.dataManagement' => 'データ管理',
			'page.openSourceLicenses' => 'オープンソースライセンス',
			'page.cloudBackup' => 'クラウドバックアップ&復元',
			'page.cloudBackupHistory' => 'バックアップ履歴',
			'page.clippingSettings' => '画像切り抜き',
			'page.clippingSettingsTitle' => ({required Object profileName}) => '画像切り抜き - ${profileName}',
			'settings.section.general' => '全般',
			'settings.section.personal' => '個人設定',
			'settings.section.data' => 'データ',
			'settings.section.other' => 'その他',
			'settings.section.developer' => '開発者向け',
			'settings.copiedToast' => ({required Object label}) => '${label}をコピーしました',
			'settings.account' => 'アカウント',
			'settings.accountSettings.sectionCloud' => 'クラウドアカウント',
			'settings.accountSettings.sectionLocal' => 'ローカルアカウント',
			'settings.accountSettings.sectionDangerZone' => 'デンジャーゾーン',
			'settings.accountSettings.signIn' => 'サインイン',
			'settings.accountSettings.cloudUidLabel' => 'UID',
			'settings.accountSettings.signOut' => 'サインアウト',
			'settings.accountSettings.signOutConfirmTitle' => 'サインアウトの確認',
			'settings.accountSettings.signOutConfirmMessage' => 'サインアウトしますか?',
			'settings.accountSettings.deleteCloudAccount' => 'クラウドアカウントを削除',
			'settings.accountSettings.deleteCloudAccountConfirmTitle' => 'クラウドアカウントを削除',
			'settings.accountSettings.deleteCloudAccountConfirmMessage' => 'クラウドアカウントを削除します。この操作は取り消せません。よろしいですか?\nクラウドに保存したバックアップファイルも削除されます。',
			'settings.accountSettings.addLocalAccount' => 'ローカルアカウントを追加する',
			'settings.accountSettings.deleteLocalAccount' => 'ローカルアカウントを削除',
			'settings.accountSettings.manualAuthUrlMessage' => 'ディスプレイが見つかりませんでした。以下のURLをコピーしてブラウザで認証してください。',
			'settings.accountSettings.signInFlowTitle' => 'Googleサインイン',
			'settings.accountSettings.signInFlowStepReceiveAuthorization' => '認証コードを受け取っています',
			'settings.accountSettings.signInFlowStepExchangeCode' => 'トークンを交換しています',
			'settings.accountSettings.signInFlowStepIssueSession' => 'セッションを発行しています',
			'settings.accountSettings.signInFlowStepRefreshSession' => 'セッションをリフレッシュしています',
			'settings.accountSettings.signInFlowStepExtractUid' => 'アカウント情報を保存しています',
			'settings.theme' => 'テーマ',
			'settings.clipping' => '画像切り抜き',
			'settings.clippingFace' => '顔',
			'settings.clippingWholeBody' => '全身',
			'settings.clippingIcon' => 'アイコン',
			'settings.clippingRangeText' => ({required Object left, required Object top, required Object right, required Object bottom}) => '左${left}% 上${top}% 右${right}% 下${bottom}%',
			'settings.language' => '言語',
			'settings.notifications' => '通知',
			'settings.advanced' => '詳細設定',
			'settings.statistics' => '統計',
			'settings.openSourceLicenses' => 'オープンソースライセンス',
			'settings.dataManagement' => 'データ管理',
			'settings.buildNumber' => 'ビルド番号',
			'settings.appVersion' => 'アプリバージョン',
			'settings.releaseChannel' => 'リリースチャンネル',
			'settings.releaseChannelStable' => 'リリース',
			'settings.releaseChannelProfile' => 'プロファイル',
			'settings.releaseChannelDebug' => 'デバッグ',
			'settings.accountCuidLabel' => 'アカウントID',
			'settings.accountCreatedAtLabel' => '作成日時',
			'settings.themeSystem' => 'システム設定に合わせる',
			'settings.themeLight' => 'ライト',
			'settings.themeDark' => 'ダーク',
			'settings.dataManagementDeleteAllData' => 'アプリのデータを全て削除',
			'settings.dataManagementDeleteAllDataConfirmTitle' => 'アプリのデータを全て削除',
			'settings.dataManagementDeleteAllDataConfirmMessage' => '電波人間やQRコードなど、このアプリに保存されているすべてのデータを削除します。この操作は取り消せません。よろしいですか?',
			'settings.dataManagementDeleteAllDataResult' => 'アプリのデータを全て削除しました',
			'settings.dataManagementClearCache' => 'キャッシュデータをクリア',
			'settings.dataManagementClearCacheConfirmTitle' => 'キャッシュクリアの確認',
			'settings.dataManagementClearCacheConfirmMessage' => '一時的なキャッシュデータを削除します。よろしいですか?',
			'settings.dataManagementClearCacheResult' => 'キャッシュデータを削除しました',
			'settings.dataManagementResultTitle' => '削除しました',
			'settings.cloudBackup' => 'クラウドバックアップ&復元',
			'settings.editPhysiqueTable' => '体格表を編集',
			'physiqueTable.title' => '体格表',
			'physiqueTable.tableTitle' => ({required Object level, required Object anntenaCategory}) => 'レベル${level} - ${anntenaCategory} の体格表',
			'physiqueTable.enterLevel' => 'レベルを入力',
			'physiqueTable.selectStatusCategory' => 'ステータスを選択',
			'physiqueTable.selectAnntenaCategory' => 'アンテナを選択',
			'physiqueTable.createNewTable' => '新規作成',
			'physiqueTable.edit' => '編集',
			'physiqueTable.addRow' => '行を追加',
			'physiqueTable.save' => '保存',
			'physiqueTable.saved' => '保存しました',
			'physiqueTable.deleteTable' => 'この表を削除',
			'physiqueTable.deleteTableConfirmTitle' => '体格表を削除',
			'physiqueTable.deleteTableConfirmMessage' => 'この体格表を削除します。この操作は取り消せません。よろしいですか?',
			'physiqueTable.deleteRow' => 'この行を削除',
			'physiqueTable.deleteRowConfirmTitle' => '行を削除',
			'physiqueTable.deleteRowConfirmMessage' => 'この行を削除します。この操作は取り消せません。よろしいですか?',
			'physiqueTable.deleteSelectedRows' => '行をまとめて削除',
			'physiqueTable.deleteSelectedRowsConfirmTitle' => '行をまとめて削除',
			'physiqueTable.deleteSelectedRowsConfirmMessage' => '選択した行を削除します。この操作は取り消せません。よろしいですか?',
			'physiqueTable.empty' => 'この表にはまだデータがありません。',
			'physiqueTable.loadError' => '表の読み込みに失敗しました。',
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
			'home.toggleTreeCursor' => 'カーソル表示の切り替え',
			'home.selectHoveredTreeIndividual' => '選択',
			'home.deselectHoveredTreeIndividual' => '選択解除',
			'home.catchOrderLabel' => ({required Object order, required Object name}) => '${order}匹目: ${name}',
			'home.birthGuideAction' => '出生ガイド',
			'home.showQrCodeAction' => 'QRコードを表示',
			'home.copyLineageTreeJsonAction' => '系譜ツリーをJSONとしてコピー',
			'search.name' => '名前',
			'search.tabList' => 'リスト',
			'search.tabSearch' => '検索',
			'monster.swordmouse' => 'ねずみけんし',
			'languages.ja' => '日本語',
			'masterData.loading' => 'マスターデータを読み込み中',
			'masterData.connectionErrorTitle' => 'サーバーに接続できません',
			'masterData.connectionErrorDescription' => 'サーバーに接続できませんでした。サーバーが起動しているか、接続先を確認してください。',
			'masterData.serverErrorTitle' => 'マスターデータの取得に失敗しました',
			'masterData.serverErrorDescription' => ({required Object message}) => 'サーバーがエラーを返しました: ${message}',
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
			'cloudBackup.latestBackupLabel' => '最新のクラウドバックアップ',
			'cloudBackup.localFileLabel' => 'ローカルファイル',
			'cloudBackup.notSignedInDescription' => 'この機能を使うにはアカウントにサインインしてください。',
			'cloudBackup.noBackupFoundDescription' => 'クラウドにバックアップが存在しません。先にバックアップを実行してください。',
			'cloudBackup.networkErrorDescription' => ({required Object message}) => 'クラウドとの通信に失敗しました: ${message}',
			'cloudBackup.backupRunning' => 'クラウドにバックアップしています',
			'cloudBackup.restoreRunning' => 'クラウドから復元しています',
			'cloudBackup.cancelled' => 'キャンセルしました',
			'cloudBackup.historyAction' => 'バックアップ履歴を見る',
			'cloudBackup.historyEmptyDescription' => 'バックアップ履歴がありません。',
			'cloudBackup.restoreAction' => '復元',
			'cloudBackup.deleteConfirmTitle' => 'バックアップを削除しますか?',
			'cloudBackup.deleteConfirmMessage' => 'このバックアップファイルを削除します。この操作は取り消せません。',
			'cloudBackup.deleteSelectedConfirmMessage' => '選択したバックアップファイルを削除します。この操作は取り消せません。',
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
			'editableStatus.monsterExp' => 'モンスターから獲得した経験値を記録',
			'editableStatus.monsterExpSelectMonster' => 'モンスターを選択',
			'editableStatus.monsterExpCount' => '討伐数',
			'editableStatus.monsterExpExp' => '経験値',
			'editableStatus.monsterExpLevel' => 'レベル',
			'editableStatus.monsterExpMaxLevelTeammateCount' => 'レベル最大の電波人間の人数',
			'editableStatus.monsterExpRecipientCount' => '経験値を獲得した人数',
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
			'croppy.materialResetLabel' => 'リセット',
			'croppy.cupertinoResetLabel' => 'リセット',
			'croppy.materialFlipLabel' => ({required Object direction}) => '${direction}に反転',
			'croppy.directionVertical' => '縦',
			'croppy.directionHorizontal' => '横',
			'croppy.materialFreeformAspectRatioLabel' => 'フリーフォーム',
			'croppy.materialOriginalAspectRatioLabel' => '元のサイズ',
			'croppy.materialSquareAspectRatioLabel' => '正方形',
			'croppy.saveLabel' => '保存',
			'croppy.doneLabel' => '完了',
			'croppy.cancelLabel' => 'キャンセル',
			'croppy.cupertinoFreeformAspectRatioLabel' => 'フリーフォーム',
			'croppy.cupertinoOriginalAspectRatioLabel' => '元のサイズ',
			'croppy.cupertinoSquareAspectRatioLabel' => '正方形',
			_ => null,
		};
	}
}
