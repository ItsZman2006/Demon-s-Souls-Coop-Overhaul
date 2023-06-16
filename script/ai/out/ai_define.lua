-----------------------------------------------------------------------------------------------
--	AIで使用する定数の一覧
--　基本的にここで記述しているIDはすべてプログラム側と対応させる必要がありますので、
--	変更しないようにしてください。
-----------------------------------------------------------------------------------------------


-- ゴールの実行結果
GOAL_RESULT_Failed = -1;	-- 失敗
GOAL_RESULT_Continue = 0;	-- 継続
GOAL_RESULT_Success = 1;	-- 成功


-- ターゲット位置の指定に使用する方向
-- 基準となる位置によって結果はことなります
-- 「自分」の「前方」であれば、プレイヤーの向いている方向と一致します。
AI_DIR_TYPE_CENTER = 0;	-- 中心
AI_DIR_TYPE_F = 1;		-- 相手の前方
AI_DIR_TYPE_B = 2;		-- 相手の後方	
AI_DIR_TYPE_L = 3;		-- 相手の左
AI_DIR_TYPE_R = 4;		-- 相手の右
AI_DIR_TYPE_ToF = 5;	-- （自分から相手の方向に）向かって前
AI_DIR_TYPE_ToB = 6;	-- 向かって後
AI_DIR_TYPE_ToL = 7;	-- 向かって左
AI_DIR_TYPE_ToR = 8;	-- 向かって右


-- 距離タイプ
-- 近、中、遠をキャラのパラメータから取得します。
-- 調整はExcelで行います。
DIST_Near = 0;	-- 近距離
DIST_Middle = 1;	-- 中距離
DIST_Far = 2;	-- 遠距離
DIST_Out = 3;	-- 範囲外
DIST_None = 4;	-- 無限


-- ターゲットを指定するタイプ
-- 索敵されたターゲット一覧の中から該当するものを選択します。
-- 指定したタイプがいない場合もあります。
TARGET_NONE = -2;		-- ターゲットなし（旋回したくない場合などに使用）
TARGET_SELF = -1;		-- 自分
TARGET_ENE_0 = 0;		-- 一番優先度の高い攻撃ターゲット
TARGET_ENE_1 = 1;
TARGET_ENE_2 = 2;
TARGET_ENE_3 = 3;
TARGET_ENE_4 = 4;
TARGET_ENE_5 = 5;
TARGET_ENE_6 = 6;
TARGET_ENE_7 = 7;
TARGET_ENE_8 = 8;
TARGET_ENE_9 = 9;
TARGET_FRI_0 = 10;		-- 一番優先度の高い味方ターゲット
TARGET_FRI_1 = 11;
TARGET_FRI_2 = 12;
TARGET_FRI_3 = 13;
TARGET_FRI_4 = 14;
TARGET_FRI_5 = 15;
TARGET_FRI_6 = 16;
TARGET_FRI_7 = 17;
TARGET_FRI_8 = 18;
TARGET_FRI_9 = 19;
TARGET_EVENT = 20;			-- イベントで指定されたターゲット
TARGET_LOCALPLAYER = 21;	-- ローカルプレイヤー


-- ポイントを指定するタイプ
POINT_INITIAL 				= 100;	-- 初期位置
POINT_SNIPE 				= 101;	-- 狙撃位置
POINT_EVENT 				= 102;	-- イベント指定位置
POINT_MOVE_POINT 			= 103;	-- ポイント移動
POINT_NEAR_NAVIMESH			= 104;	-- 近いナビメッシュのポリゴン
POINT_FAR_NAVIGATE			= 105;	-- ターゲットの乗っているパーツの中で一番遠いゲート
POINT_NEAR_NAVIGATE			= 106;	-- ターゲットの乗っているパーツの中で一番近いゲート
POINT_AI_FIXED_POS			= 107;	-- AIスクリプトで、SetAIFixedMoveTarget()で設定された位置に向かう。
POINT_FAR_LANDING			= 108;	-- ターゲットの乗っているパーツの中で、ターゲットから遠い着地点。
POINT_NEAR_LANDING			= 109;	-- ターゲットの乗っているパーツの中で、ターゲットから近い着地点。
POINT_2ndNEAR_LANDING		= 110;	-- ターゲットの乗っているパーツの中で、ターゲットから２番目に近い着地点。
POINT_INIT_POSE				= 111;	-- 初期位置の姿勢（旋回ターゲットにすると、この姿勢になる。）
POINT_HitObstacle			= 112;	-- 最後に接触した障害物。
--POINT_LastRequestPosition	= 113;	-- ■！■使うべからず■！■最後の目標位置。
POINT_CurrRequestPosition	= 114;	-- 現在の目標位置。


-- 割り込みタイプ
INTERUPT_FindEnemy 				= 0;	-- 見つけていなかった敵を見つけた
INTERUPT_FindAttack 			= 1;	-- 一番身近なターゲットが攻撃開始
INTERUPT_Damaged 				= 2;	-- 攻撃された
INTERUPT_Damaged_Stranger 		= 3;	-- 索敵していない敵から攻撃された
INTERUPT_FindMissile 			= 4;	-- 飛び道具を発見した（未実装）
INTERUPT_SuccessGuard 			= 5;	-- ガード成功
INTERUPT_MissSwing 				= 6;	-- 敵が空振り
INTERUPT_GuardBegin 			= 7;	-- 敵がガード開始
INTERUPT_GuardFinish 			= 8;	-- 敵がガード終了
INTERUPT_GuardBreak 			= 9;	-- ガードはじき
INTERUPT_Shoot 					= 10;	-- 敵が飛び道具を撃った
INTERUPT_ShootReady 			= 11;	-- 敵が飛び道具を構えた（未実装）
INTERUPT_UseItem 				= 12;	-- 敵がアイテムを使った
INTERUPT_EnterBattleArea 		= 13;	-- 戦闘領域に入った
INTERUPT_LeaveBattleArea 		= 14;	-- 戦闘領域を離脱した
INTERUPT_CANNOT_MOVE			= 15;	-- 一定時間移動できない
INTERUPT_Inside_ObserveArea		= 16;	-- 監視エリアの中にターゲットが入った。
INTERUPT_ReboundByOpponentGuard	= 17;	-- 相手のガードによって攻撃が弾かれた。
INTERUPT_ForgetTarget			= 18;	-- ターゲットを忘れた。
INTERUPT_FriendRequestSupport	= 19;	-- 味方が救援要請を出している。
INTERUPT_TargetIsGuard			= 20;	-- ターゲットが攻撃をガードした。
INTERUPT_HitEnemyWall			= 21;	-- 敵壁に接触した。
INTERUPT_SuccessParry			= 22;	-- パリィが成功した。
INTERUPT_CANNOT_MOVE_DisableInterupt = 23;	-- 一定時間移動できない（割り込み無効中のみ呼ばれる）


-- 強調タイプ
COORDINATE_TYPE_None = -1;	-- なし

-- 攻撃予約する
-- 攻撃予約人数が一定以上のときに攻撃しないようにすることができる
-- 追加、数値取得するときのターゲット：攻撃するターゲット

COORDINATE_TYPE_Attack 				= 0;	-- 攻撃予約
COORDINATE_TYPE_SideWalk_L 			= 1;	-- 左側へ横移動
COORDINATE_TYPE_SideWalk_R 			= 2;	-- 右側へ横移動
COORDINATE_TYPE_AttackOrder 		= 3;	-- 攻撃命令
COORDINATE_TYPE_Support				= 4;	-- 救援。
COORDINATE_TYPE_KIMERAbite			= 100;	-- キメラ噛み付き。
COORDINATE_TYPE_UROKOIwaSupport		= 110;	-- ウロコ岩投げ支援攻撃中。



-- チーム命令タイプ
-- チームからの指令を取得します。
ORDER_TYPE_Role = 0;	-- 役割取得


-- チームからくる役割分担です
-- ＞平井さん　名前は分かりやすいものに変えてください
ROLE_TYPE_None = -1;	-- 役割なし
ROLE_TYPE_Attack = 0;	-- 攻撃役
ROLE_TYPE_Torimaki = 1;	-- とりまき
ROLE_TYPE_Kankyaku = 2;	-- 観客


-- NPCプレイヤー用の攻撃番号
-- いつものAttackゴールのEzState番号に入れる。
-- NPCプレイヤーでのみ有効
NPC_ATK_NormalR 		= 0;				-- 右手通常
NPC_ATK_LargeR 			= 1;				-- 右手大攻撃
NPC_ATK_PushR 			= 2;				-- 右手押し出し攻撃
NPC_ATK_NormalL 		= 3;				-- 左手通常
NPC_ATK_GuardL 			= 4;				-- 左手ガード
NPC_ATK_Parry 			= 5;				-- 左手パリィ
NPC_ATK_Magic 			= 6;				-- 魔法（左）
NPC_ATK_MagicL			= NPC_ATK_Magic;	-- 魔法（左）
NPC_ATK_Item 			= 7;				-- アイテム
NPC_ATK_SwitchWep 		= 8;				-- 片手両手切り替え
NPC_ATK_StepF 			= 9;				-- ステップ移動前
NPC_ATK_StepB 			= 10;				-- ステップ移動後
NPC_ATK_StepL 			= 11;				-- ステップ移動左
NPC_ATK_StepR 			= 12;				-- ステップ移動右
NPC_ATK_ChangeWep_R1	= 13;				-- 右腕主武器に切り替え
NPC_ATK_ChangeWep_R2	= 14;				-- 右腕副武器に切り替え
NPC_ATK_ChangeWep_L1	= 15;				-- 左腕主武器に切り替え
NPC_ATK_ChangeWep_L2	= 16;				-- 左腕副武器に切り替え
NPC_ATK_BackstepF		= 17;				-- バックステップ前
NPC_ATK_BackstepB		= 18;				-- バックステップ後
NPC_ATK_BackstepL		= 19;				-- バックステップ左
NPC_ATK_BackstepR		= 20;				-- バックステップ右
NPC_ATK_MagicR			= 21;				-- 魔法（右）



-- エクセルパラメータタイプ
AI_EXCEL_THINK_PARAM_TYPE__NONE						= 0;	-- 無効
AI_EXCEL_THINK_PARAM_TYPE__maxBackhomeDist			= 1;	-- 
AI_EXCEL_THINK_PARAM_TYPE__backhomeDist				= 2;	-- 
AI_EXCEL_THINK_PARAM_TYPE__backhomeBattleDist		= 3;	-- 
AI_EXCEL_THINK_PARAM_TYPE__nonBattleActLife			= 4;	-- 
AI_EXCEL_THINK_PARAM_TYPE__BattleStartDist			= 5;	-- 戦闘開始距離。
AI_EXCEL_THINK_PARAM_TYPE__bMoveOnHearSound			= 6;	-- 
AI_EXCEL_THINK_PARAM_TYPE__CannotMoveAction			= 7;	-- 移動できなくなっている時のEzState番号。
AI_EXCEL_THINK_PARAM_TYPE__battleGoalID				= 8;	-- 戦闘ゴールID
AI_EXCEL_THINK_PARAM_TYPE__BackHome_LookTargetTime	= 9;	
AI_EXCEL_THINK_PARAM_TYPE__BackHome_LookTargetDist	= 10;
AI_EXCEL_THINK_PARAM_TYPE__BackHomeLife_OnHitEnemyWall	= 11;

--ポイント移動タイプ。
POINT_MOVE_TYPE_Patrol 					= 0;	-- 巡回
POINT_MOVE_TYPE_RoundTrip				= 1;	-- 往復
POINT_MOVE_TYPE_Randum					= 2;	-- ランダム
POINT_MOVE_TYPE_Gargoyle_Air_Patrol		= 3;	-- ガーゴイル空中巡回
POINT_MOVE_TYPE_Gargoyle_Landing		= 4;	-- ガーゴイル着地。


--腕ID(ChrAsm::WEP_SET_POSに対応)
ARM_L	= 0;
ARM_R	= 1;

--武器装備（ChrAsm::WEP_SLOT_OFFSETに対応）
WEP_Primary 	= 0;
WEP_Secondary 	= 1;


-- リプランニング時のゴールアクション。
NPC_THINK_GOAL_ACTION__NONE				= 0;			--/< 何もしない
NPC_THINK_GOAL_ACTION__TURN_TO_TGT		= 1;			--/< ターゲットの方向に向く
NPC_THINK_GOAL_ACTION__WALK_TO_TGT		= 2;			--/< ターゲットへ歩く
NPC_THINK_GOAL_ACTION__RUN_TO_TGT		= 3;			--/< ターゲットへ走る
NPC_THINK_GOAL_ACTION__SET_GOAL			= 4;			--/< 任意のゴールを設定



--特殊効果の状態異常タイプ。
SP_EFFECT_TYPE_NONE=0;			-- なし
SP_EFFECT_TYPE_FIRE=1;			-- 炎
SP_EFFECT_TYPE_POIZON=2;			-- 毒
SP_EFFECT_TYPE_LEECH=3;			-- ヒル
SP_EFFECT_TYPE_SPOIL=4;			-- 腐食
SP_EFFECT_TYPE_ILLNESS=5;			-- 疫病
SP_EFFECT_TYPE_BLOOD=6;			-- 出血
SP_EFFECT_TYPE_CAMOUFLAGE=7;			-- ゴーストカムフラージュ
SP_EFFECT_TYPE_HIDDEN=8;			-- 姿隠し
SP_EFFECT_TYPE_MASOCHIST=9;			-- マゾヒスト
SP_EFFECT_TYPE_RECOVER_POZON=10;			-- 状態異常回復【毒】
SP_EFFECT_TYPE_RECOVER_ILLNESS=11;			-- 状態異常回復【疫病】
SP_EFFECT_TYPE_RECOVER_BLOOD=12;			-- 状態異常回復【出血】
SP_EFFECT_TYPE_RECOVER_ALL=13;			-- 状態異常回復【万能】
SP_EFFECT_TYPE_SOUL_STEAL=14;			-- ソウルスティール
SP_EFFECT_TYPE_ZOOM=15;			-- ズーム
SP_EFFECT_TYPE_WARP=16;			-- ワープ
SP_EFFECT_TYPE_DEMONS_SOUL=17;			-- デモンズソウル
SP_EFFECT_TYPE_BLACK_DISPERSE=18;			-- 黒ゴースト退散
SP_EFFECT_TYPE_TOUGH_GHOST=19;			-- 強ゴースト
SP_EFFECT_TYPE_WHITE_REQUEST=20;			-- ホワイト希望
SP_EFFECT_TYPE_BLACK_REQUEST=21;			-- ブラック希望
SP_EFFECT_TYPE_CHANGE_BLACK=22;			-- 黒ゴースト化
SP_EFFECT_TYPE_REVIVE=23;			-- 蘇生
SP_EFFECT_TYPE_FORBID_USEMAGIC=24;			-- 魔法使用禁止
SP_EFFECT_TYPE_MIRACLE_DIRAY=25;			-- 奇跡モーション延長
SP_EFFECT_TYPE_WHETSTONE=26;			-- 砥石
SP_EFFECT_TYPE_SUSPENDED_REVIVE=27;			-- 仮死蘇生
SP_EFFECT_TYPE_ENCHANT_WEAPON=28;			-- 武器強化
SP_EFFECT_TYPE_ENCHANT_ARMOR=29;			-- 防御シールド
SP_EFFECT_TYPE_WIRE_WRAPED=30;			-- 糸まみれ
SP_EFFECT_TYPE_GHOST_PARAM_CHANGE=31;			-- 判定フラグ／ホワイト、ブラック、グレイゴースト時にシステムとして、強制的に装備させる特殊効果（生存になったら外れる）
SP_EFFECT_TYPE_PARALYSIS=32;			-- 金縛り中は、移動、攻撃、アイテム使用ができなくなる／効果時間を設定する.EzStateによる対応を行う.
SP_EFFECT_TYPE_FLY_CROWD=33;			-- 蠅たかり
SP_EFFECT_TYPE_FIREMAN_STAGE_1=34;			-- 炎怪人_第１段階
SP_EFFECT_TYPE_FIREMAN_STAGE_2=35;			-- 炎怪人_第２段階
SP_EFFECT_TYPE_FIREMAN_STAGE_3=36;			-- 炎怪人_第３段階
SP_EFFECT_TYPE_FIREMAN_STAGE_4=37;			-- 炎怪人_第４段階
SP_EFFECT_TYPE_HALLUCINATION=38;			-- 幻聴
SP_EFFECT_TYPE_SOULCOIN=39;			-- ソウルコイン
SP_EFFECT_TYPE_TOUGH_SHIELD=40;			-- 強防御シールド
SP_EFFECT_TYPE_ANTIFIRE_SHIELD=41;			-- 火耐性シールド
SP_EFFECT_TYPE_HP_RECOVERY=42;			-- HP回復状態
SP_EFFECT_TYPE_FORCE_GHOST_STAGE1=43;			-- 強制ゴースト化　第1段階
SP_EFFECT_TYPE_FORCE_GHOST_STAGE2=44;			-- 強制ゴースト化　第2段階
SP_EFFECT_TYPE_FORCE_GHOST_STAGE3=45;			-- 強制ゴースト化　第3段階
SP_EFFECT_TYPE_PHEROMONE=46;			-- フェロモン
SP_EFFECT_TYPE_CAT_LANDING=47;			-- 猫着地
SP_EFFECT_TYPE_PINCH_ATTACKPOWER_UP=48;			-- ピンチ攻撃力アップ
SP_EFFECT_TYPE_PINCH_DEFENSIBILITY_UP=49;			-- ピンチ防御力アップ
SP_EFFECT_TYPE_REGENERATE=50;			-- リジェネレイト
SP_EFFECT_TYPE_TORCH=51;			-- たいまつ
SP_EFFECT_TYPE_WEAK_REGENERATE=52;			-- 弱リジェネレイト
SP_EFFECT_TYPE_WEAK_CAMOUFLAGE=53;			-- 弱ゴーストカムフラージュ
SP_EFFECT_TYPE_WEAK_HIDDEN=54;			-- 弱姿隠し
SP_EFFECT_TYPE_HINT_BLOOD_SIGN=55;			-- ヒント血文字
SP_EFFECT_TYPE_LEECH_FOOT=56;			-- ヒル足
SP_EFFECT_TYPE_YELLOW_CLOAK=57;			-- 黄衣
SP_EFFECT_TYPE_POINT_LIGHT=58;			-- 点光源
SP_EFFECT_TYPE_BLOOD_SIGN_ESTIMATION=59;			-- 血文字評価
SP_EFFECT_TYPE_ENCHANT_WEAPON_REGULAR=60;			-- 光の武器（魔法）
SP_EFFECT_TYPE_ENCHANT_WEAPON_LARGE=61;			-- 呪いの武器（魔法）
SP_EFFECT_TYPE_ENCHANT_WEAPON_FIRE=62;			-- 松脂（アイテム）
SP_EFFECT_TYPE_ENCHANT_WEAPON_FIRE_LARGE=63;			-- 黒松脂（アイテム）
SP_EFFECT_TYPE_ENCHANT_WEAPON_MAGIC=64;			-- デーモンの獣脂（アイテム）
SP_EFFECT_TYPE_CHIMERA_POWER_UP=65;			-- キメラ強化（牢城２キメラ用）
SP_EFFECT_TYPE_ITEM_DROP_RATE=66;			-- アイテムを装備すると、「敵を倒したときにアイテムになる確率」をアップさせます


