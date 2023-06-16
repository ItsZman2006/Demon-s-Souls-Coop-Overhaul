-----------------------------------------------------------------------------------------------
--	ゴールリストの一覧
--	ゴールIDはここで決定してください。
--	管理のしやすいIDをつけて下さい
--	ここを見ればどんなゴールかが分かるように、きちんとコメントを書いてください。
--	キャラ個別のゴールなどは特に必要ありませんが、汎用ものはきちんと書きましょう。
-----------------------------------------------------------------------------------------------



--===============================================================
-- 共通トップゴール
-- 汎用で使用する戦闘以外のトップゴールです。
--===============================================================

--　一番上になるゴール
GOAL_COMMON_TopGoal				= 0;
--	通常行動
GOAL_COMMON_Normal				= 1;
--	敵が来るまで待機している
GOAL_COMMON_Stay 				= 2;
--	うろうろ行動
GOAL_COMMON_WalkAround 			= 3;
--	警戒しながら初期位置に戻る
GOAL_COMMON_BackToHome 			= 4;
-- 非戦闘行動
GOAL_COMMON_NonBattleAct		= 5;




--===============================================================
-- 個別トップゴール
--===============================================================

-- ダメージテスト用騎士２
GOAL_Test10004_Battle			= 10004;
-- 何もしない用
GOAL_Nanimosinai11000_Battle	= 11000;
-- NPCプレイヤーテスト
GOAL_NpcPlayerTest_Battle		= 12010;

-- ★★★★ここから本番用★★★★
--デブデーモン
GOAL_Debu103000_Battle			= 103000;	--チュートリアル用。
GOAL_Debu103001_Battle			= 103001;	--古砦１用。
GOAL_Debu103001_SafeApproach	= 103091;	--古砦１用安全接近。

-- 奴隷兵士（短剣）
GOAL_DoreiTANKEN200000_Battle	= 200000;
-- 奴隷兵士（チュートリアル・ガードのみ）
GOAL_DoreiTANKEN_B200004_Battle	= 200004;
-- 奴隷兵士（チュートリアル）
GOAL_DoreiTANKEN_B200005_Battle	= 200005;

-- 一般兵士（チュートリアル）
GOAL_IppanLONG200010_Battle		= 200010;
-- 一般兵士（チュートリアル・火炎）
GOAL_IppanLONG_B200012_Battle	= 200012;

-- 騎士（チュートリアル）
GOAL_Kisi200020_Battle			= 200020;
-- 騎士（チュートリアル・専守）
GOAL_Kisi200021_Battle			= 200021;

-- 一般兵士（ロングソード）
GOAL_IppanLONG201000_Battle		= 201000;
-- 一般兵士（ロングソード）火炎瓶大好き
GOAL_IppanLONG_B201001_Battle	= 201001;
-- 一般兵士（ボウガン）
GOAL_IppanBOU201003_Battle		= 201003;

-- 騎士
GOAL_Kisi202000_Battle			= 202000;
-- 騎士クレイモア
GOAL_Kisi202001_Battle			= 202001;
-- 騎士スピア
GOAL_Kisi202002_Battle			= 202002;

-- 暗殺者
GOAL_Ansatu203000_Battle		= 203000;

-- 虜囚
GOAL_Ryosyu207000_Battle		= 207000;		--基本
GOAL_RyosyuSINJA207001_Battle	= 207001;		--カミサマ信者
GOAL_Ryosyu207002_Battle		= 207002;		--（刺剣＆槍）
GOAL_Ryosyu207003_Battle		= 207003;		--（刺剣・毒）
GOAL_Ryosyu207005_Battle		= 207005;		--祈るだけ
GOAL_Ryosyu_COMMON_Wait			= 207010;		--虜囚共通待ち。
-- 虜囚玉
GOAL_Ryosyudama207500_Battle	= 207500;


-- 獄吏
GOAL_Gokuri208000_Battle		= 208000;
-- 獄吏（棍棒）
GOAL_Gokuri208002_Battle		= 208002;
-- 獄吏（棍棒、広い）
GOAL_Gokuri208003_Battle		= 208003;

-- 腐敗ヒト
GOAL_Huhai210000_Battle			= 210000;	-- 槌
GOAL_Huhai210002_Battle			= 210002;	-- 槍
GOAL_Huhai_COMMON_Wait			= 210010;
GOAL_Huhai210003_Battle			= 210003;	-- 猛毒
GOAL_Huhai210005_Battle			= 210005;	-- 祈る
-- 大腐敗ヒト
GOAL_Daihuhai210100_Battle		= 210100;


-- ウロコ鉱夫
GOAL_urokoP211000_Battle        = 211000;		--（ピッケル）
GOAL_urokoF211001_Battle        = 211001;		--（袋）
GOAL_urokoSS211002_Battle       = 211002;		--（小剣）
GOAL_urokoLS211003_Battle       = 211003;		--（大剣）
GOAL_uroko211004_Battle         = 211004;		--（獄吏と一緒）
GOAL_uroko211005_Battle         = 211005;		--（獄吏と一緒、広い）
GOAL_uroko211008_Battle         = 211008;		--積極攻撃型。
GOAL_uroko_COMMON_Wait			= 211010;		-- ウロコ鉱夫共通待ちゴール。
GOAL_uroko_ThrowRock			= 211090;		-- ウロコ岩投げ。

--影人
GOAL_kagebito212000_Battle      = 212000;
--影人（強い人）
GOAL_kagebito212001_Battle		= 212001;
--影女
GOAL_kageonna213000_Battle      = 213000;		--通常戦闘。
GOAL_kageonna213000_SneakAttack	= 213090;		--こっそり攻撃。
GOAL_kageonna213000_NonBattle	= 213099;		--非戦闘。
GOAL_kageonna213000_SA_Attack	= 213091;		--こっそり攻撃ゴール中、サブゴール。

--軍用犬
GOAL_Gunyou301000_Battle		= 301000;
GOAL_Gunyou301001_Battle		= 301001;
--鷹
GOAL_Taka303000_Battle			= 303000;
GOAL_TakaSub_Attack				= 303091;	--	鷹攻撃サブゴール。


--キメラ
GOAL_Kimera304000_Battle						= 304000;
GOAL_Kimera304000_Battle_FlyLeaveAndApproach	= 304001;
GOAL_Kimera304000_Battle_FlyLeave				= 304002;
GOAL_Kimera304000_Battle_FlyApproach			= 304003;
GOAL_Kimera304000_Battle_Bite					= 304005;
GOAL_Kimera304000_Battle_BiteAction				= 304006;

--ガーゴイル
GOAL_Gagoiru305000_Battle					= 305000;
GOAL_Gagoiru305000_Battle_Landing			= 305081;
GOAL_Gagoiru305000_Battle_Landing_Move		= 305082;
GOAL_Gagoiru305000_Battle_Landing_Landing	= 305083;
GOAL_Gagoiru305000_LandBattle				= 305090;
GOAL_Gagoiru305000_AirBattle				= 305091;
GOAL_Gagoiru305000_LandingAttack			= 305092;
GOAL_Gagoiru305000_BowgunAttack				= 305093;
GOAL_Gagoiru305000_LiftOff					= 305094;
GOAL_Gagoiru305000_LandingOnGround			= 305095;


--疫病ネズミ
GOAL_Nezumi306000_Battle		= 306000;
--大ナメクジ
GOAL_Namekuji307000_Battle		= 307000;
GOAL_Namekuji307100_Battle		= 307100;
--白濁クラゲ
GOAL_Kurage308000_Battle		= 308000;
--大蚊
GOAL_Ooka309000_Battle			= 309000;

--岩石ミミズ
GOAL_mimizu310000_Battle        = 310000;
--結晶トカゲ
GOAL_tokage311000_Battle        = 311000;
GOAL_tokage311010_Battle		= 311010;
GOAL_tokage311010_Runaway		= 311090;
GOAL_tokage311010_Hide			= 311091;

--マグマヤモリ
GOAL_Yamori312000_Battle        = 312000;


--クマムシ
GOAL_kuma313000_Battle          = 313000;	--大クマムシ
GOAL_kuma313002_Battle          = 313002;	--大クマムシ　迷路用
GOAL_kuma313004_Battle          = 313004;	--羽クマムシ
GOAL_kuma_ApproachXZAndFall		= 313007;	--羽クマムシサブゴール：XZ平面で近づいて落ちる。
GOAL_kuma_ApproachIniXZ			= 313008;	--羽クマムシサブゴール：XZ平面で近づく。


--血ダニ
GOAL_Chidani318000_Battle		= 318000;

--なりそこない
GOAL_Narisoko400000_Battle		= 400000;
--死神
GOAL_sinigami401000_Battle      = 401000;


--骸骨剣士（金・崖上）
GOAL_honeTAIKEN402003_Battle	= 402003;
--骸骨剣士（金・二刀流）
GOAL_honeNITOU402005_Battle		= 402005;

--骸骨剣士（白・剣）
GOAL_honeKEN402100_Battle       = 402100;
--骸骨剣士（白・弓）
GOAL_honeBOU402101_Battle       = 402101;

--タコ男
GOAL_Tako403000_Battle				= 403000;
GOAL_Tako403000_ThrowComboApproach	= 403090;
GOAL_Tako403000_Throw				= 403091;

-- 炎怪人
GOAL_Honokaijin405000_Battle	= 405000;

-- ファランクス（チビ）
GOAL_FaranCIBI500000_Battle		= 500000;
GOAL_FaranCIBI_B500001_Battle	= 500001;
-- ファランクス（本体）
GOAL_FaranHONTAI500100_Battle	= 500100;
-- 王の盾
GOAL_Ounotate501000_Battle		= 501000;
-- 王の剣
GOAL_Ounoken502000_Battle		= 502000;

--嵐の獣
GOAL_akemono503000_Battle       = 503000;
--子エイ
GOAL_koei_503100_Battle         = 503100;	--ボス戦
GOAL_koei_503101_Battle         = 503101;	--単独。

-- 審判者
GOAL_Sinpansya504000_Battle		= 504000;
-- カミサマ
GOAL_Kamisama506000_Battle		= 506000;
-- 偽カミサマ
GOAL_Nisekamisama506001_Battle	= 506001;
-- ムカデ
GOAL_Mukade507000_Battle		= 507000;
-- ムカデ小
GOAL_Mukade507100_Battle		= 507100;

-- 蝿たかり
GOAL_Haetakari508000_Battle		= 508000;
-- 蛭デーモン
GOAL_Hiru509000_Battle			= 509000;
--大蜘蛛
GOAL_kumo510000_Battle          = 510000;
GOAL_kumo510000_Blaze			= 510091;	--火炎放射。
GOAL_kumo510000_FeelerAttack	= 510092;	--触角攻撃。
--鉱石の精霊
GOAL_seirei511000_Battle        = 511000;

-- 嵐の戦士
GOAL_ArasiSensi602000_Battle	= 602000;
GOAL_ArasiSensi602000_NonBattle	= 602001;

-- ドラゴンデーモン（坑道）
GOAL_DD605001_Battle            = 605001;
-- 黄衣の翁
GOAL_Okina603100_Battle			= 603100;

-- リーブラ
GOAL_Libra604000_Battle			= 604000;
-- 不浄なる者
GOAL_Fujou604100_Battle			= 604100;

--要人
GOAL_Kaname_708000_Battle		= 708000;
--乞食（男）
GOAL_kojiki710000_Battle        = 710000;
--鍛治屋（坑道）
GOAL_kajiyaK_713000_Battle      = 713000;
--鍛冶屋ボールドウィン
GOAL_KajiSekichu_713001_Battle	= 713001;
-- ヒロイン
GOAL_Heroine_715000_Battle		= 715000;
--レンドル王
GOAL_King723000_Battle			= 723000;

--古砦敵NPC
GOAL_Wizard800000_Battle        = 800000;
--王城４NPC敵Ａ
--王城４NPC敵Ｂ
--王城４NPC敵Ｃ
GOAL_NpcKISI_A801000_Battle		= 801000;
GOAL_NpcKISI_B802000_Battle		= 802000;
GOAL_NpcKISI_C803000_Battle		= 803000;

--ウル様閉じ込めNPC
GOAL_UruBlockNPC_804000_Battle	= 804000;

--心折れた戦士
GOAL_Kokoro_805000_Battle		= 805000;
--レンドル王子・ブラック
GOAL_Ouji_807000_Battle			= 807000;
--レンドル王子・生存
GOAL_Ouji_807001_Battle			= 807001;
--ビヨルングルム
GOAL_Biyo_808000_Battle			= 808000;
--パッチ(坑道)
GOAL_pachi809000_Battle         = 809000;	--戦闘ゴール。
GOAL_pachi809000_MoveToTreasure	= 809090;	--宝箱へ移動。
--パッチ(古砦)
GOAL_pachi810000_Battle         = 810000;
--古砦囚人
GOAL_syujin811000_Battle        = 811000;

--ウルベイン
GOAL_Urubein_814000_Battle		= 814000;
--ハーフハンド
GOAL_half815000_Battle          = 815000;

--ガルヴィンランド
GOAL_GalV_816000_Battle_Main	= 816000;	--メイン戦闘
GOAL_GalV_816000_Battle_Forward	= 816001;	--前衛
GOAL_GalV_816000_Battle_Retreat	= 816002;	--退却
GOAL_GalV_816000_Battle_Guard	= 816003;	--護衛
GOAL_GalV_816000_Battle			= 816004;	--戦闘
GOAL_GalV_816000_NonBattle		= 816005;	--非戦闘

--ロガーン
GOAL_Rogan_817000_Battle		= 817000;
--ユルト
GOAL_Yuruto_818000_Battle		= 818000;

--黒衣のヴィライデル卿
GOAL_Vilidel_819000_Battle		= 819000;

--姫騎士セレン
GOAL_Selen_820000_Battle		= 820000;

--魔女
GOAL_Majo_821000_Battle			= 821000;
--ドラン
GOAL_Doran_822000_Battle		= 822000;
--魔術の徒
GOAL_Majutu_823000_Battle		= 823000;
--神の信徒１
GOAL_Sinto1_824000_Battle		= 824000;
--神の信徒２
GOAL_Sinto2_825000_Battle		= 825000;
--神の信徒３
GOAL_Sinto3_826000_Battle		= 826000;
--物識り
GOAL_Monosiri_828000_Battle		= 828000;
--トマス
GOAL_Tomas_829000_Battle		= 829000;
--マスターサツキ
GOAL_satuki830000_Battle        = 830000;
--メフィストフェレス
GOAL_Mefist_831000_Battle		= 831000;

--断罪者ミラルダ
GOAL_Miralda_832000_Battle		= 832000;

--翁召喚ブラックNPC
GOAL_OKINA_833000_Battle		= 833000;

--坑道２ブラックゴースト
GOAL_KoudouBG_834000_Battle		= 834000;

--チュートリアル徘徊ゴースト
GOAL_TutorialHG_835000_Battle	= 835000;

--牢城１教会前ブラックゴースト
GOAL_RouBG_836000_Battle		= 836000;

--王城三銃士A
GOAL_TroisM_A837000_Battle		= 837000;
--王城三銃士B
GOAL_TroisM_B838000_Battle		= 838000;
--王城三銃士Cは803000を使用します

--不浄２徘徊黒ゴースト
GOAL_Fujo2BG_839000_Battle		= 839000;


--===============================================================
-- 共通サブゴール
--===============================================================

-----------------------------------------------------------------------------------------------
--	移動関連
-----------------------------------------------------------------------------------------------
GOAL_COMMON_Wait 					= 2000;		--	待機
GOAL_COMMON_Turn 					= 2001;		--	ターゲット方向へ旋回
GOAL_COMMON_TurnAround				= 2002;		--	ターゲットを回り込む
GOAL_COMMON_Step 					= 2014;		--	ステップ移動する（SpinStepへ以降中。）
GOAL_COMMON_ApproachTarget			= 2015;		--	相手に近づく
GOAL_COMMON_LeaveTarget				= 2016;		--	相手から離れる
GOAL_COMMON_SidewayMove				= 2017;		--	相手を中心に横移動
GOAL_COMMON_KeepDist				= 2018;		--	相手が指定範囲内に収まるように移動
GOAL_COMMON_MoveToSomewhere			= 2019;		--	汎用移動
GOAL_COMMON_SpinStep				= 2020;		--	旋回＆ステップ移動。
GOAL_COMMON_Fall					= 2021;		--	落下。



-----------------------------------------------------------------------------------------------
--	アクション関連
-----------------------------------------------------------------------------------------------
GOAL_COMMON_Attack 					= 2100;		--	攻撃する
GOAL_COMMON_Guard					= 2101;		--	ガードする
GOAL_COMMON_ComboAttack				= 2102;		--	連続攻撃する
GOAL_COMMON_GuardBreakAttack		= 2103;		--	ガードくずし攻撃する
GOAL_COMMON_NonspinningAttack		= 2104;		--	旋回せずに攻撃する
GOAL_COMMON_ContinueAttack 			= 2105;		--	突撃する
GOAL_COMMON_Attack2					= 2106;		--	攻撃する（攻撃前旋回時間指定版）
GOAL_COMMON_ApproachStep			= 2107;		--	アクションで移動する。
GOAL_COMMON_UseItem					= 2108;		--	アイテムを使用する。
GOAL_COMMON_DashAttack				= 2109;		--	ダッシュアタック。
GOAL_COMMON_DashAttack_Attack		= 2110;		--	ダッシュアタック中の攻撃。
GOAL_COMMON_Attack3					= 2112;		--	攻撃３．必ず成功する。
GOAL_COMMON_Parry					= 2113;		--	パリィ。
GOAL_COMMON_SpecialTurn				= 2114;		--	特殊旋回（子エイ用）

--===============================================================
-- 個別サブゴール
--===============================================================

-- 神さまデーモン
-- 瞬間移動
GOAL_KAMISAMA_Teleport				= 3001;

--
--


