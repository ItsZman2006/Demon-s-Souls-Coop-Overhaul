--決める夏

-------------------------------------------------------------------------------------------------------------------
--■決まりごと
--[[・距離の単位はメートル]]
--・時間の単位は秒
--・角度は中心とする軸から左右それぞれの数値。
--　仮に60と設定すると、前方120°が有効な角度となる。
-------------------------------------------------------------------------------------------------------------------

--▼通常会話
TalkAngle_N	= 180.0;
TalkDist_N	= 3.0;

--▼宝箱(宝死体)
ItemBoxAngle_A = 180.0;
ItemBoxDist_A  = 1.5;

--▼はしご
LadderAngle_A = 90.0;
LadderTime_A  = 0.2;

--▼レバー
LeverAngle_A = 30;
LeverDist_A  = 1.5;

--▼ワープギミック
WarpGimmickAngle_A = 90.0;  --石柱     → 各マップ のタイプ(正面からだけ)
WarpGimmickDist_A  = 1.5;
WarpGimmickAngle_B = 180.0; --各マップ → 石柱     のタイプ(周囲どこでも)

--▼扉
DoorAngle_A = 90;  --片側扉用(スクリプト共通パラメータより)
DoorDist_A  = 1.0;

--[[↓共通パラメータに既述なしのもの]]

--▼ハンドル
HandleAngle_A = 60.0;
HandleDist_A  = 1.5;

HandleAngle_B = 40.0; --ハンドルBを回して歯車を動かす(水位が変わるイベント用)
HandleDist_B  = 1.8;  --ハンドルBを回して歯車を動かす(水位が変わるイベント用)

--▼跳ね橋
DrawBridgeAngle_A = 30.0;
DrawBridgeDist_A  = 1.5;

--▼かべ張り付き
WallAngle_A = 90.0;
WallTime_A = 0.5;

--▼床スイッチ
FloorSwitchDist_A = 1.5;

--▼ナメクジ
NamekujiAngle_A = 180.0;
NamekujiDist_A = 5.0;

--▼ボス死亡から次ブロックポリ劇再生までの待ち時間
BlockClear_RemoWait = 3.0;

--▼蛭デーモン(ヒルデーモン)のコアパーツのHp
LeechDemon_Core_Hp	= 1800;

--▼蠅たかりデーモン(はえたかりデーモン)定数
FlyCrowdDemon_Core_Hp			= 2700;		--コアパーツのHp
FlyCrowdDemon_SpellReload_Low	= 15.0;		--蠅魔法の発射間隔(最短)
FlyCrowdDemon_SpellReload_High	= 20.0;		--蠅魔法の発射間隔(最長)

--▼不浄３の死体落下間隔の調整定数
M52_Corpse_FallWait_Low		= 10.0;		--落下間隔の調整定数(最短)
M52_Corpse_FallWait_High	= 20.0;		--落下間隔の調整定数(最長)

--▼死亡ペナルティの調整定数
DeathPenalty_SoulAdjust			= 0;--1.0;	--死亡時のソウル減少計算調整値
DeathPenalty_SoulMAX			= 0;--500;	--死亡時の減少ソウル最大値

--▼PKペナルティの調整定数
PK_Soul_Penalty_Adjust		= 1.0;	--死亡時のソウル減少計算調整値
PK_Soul_Penalty_MAX			= -1;	--死亡時の減少ソウル最大値(-1で上限なし)
PK_Soul_Penalty_BASE		= 25;	--基本値(パラメータの差分で倍になる値)
PK_Soul_Penalty_FIX			= 100;	--固定減少値(パラメータ差分調整値に関係なく、絶対に減らす量)

--▼NPCが怒るダメージ割合
NPC_ANGRY_Rate	= 0.2;

--▼汎用ダイアログを消す距離判定
GEN_DIALOG_DIST	= 2.0;

-------------------------------------------------------------------------------------------------------------------
--【システム定数】
-------------------------------------------------------------------------------------------------------------------
once 			= 1;
everytime 		= 0;
LOCAL_PLAYER	= 10000;
SYNCHROANIM		= 4013;
TURNTIME		= 0.05;
TURNSKIP_ANGLE	= 10;

-------------------------------------------------------------------------------------------------------------------
--【ItemType定数】
-------------------------------------------------------------------------------------------------------------------
TYPE_WEAPON		= 0;
TYPE_PROTECTER	= 268435456;
TYPE_ACCESSORY	= 536870912;
TYPE_GOODS		= 1073741824;
TYPE_MASK		= 4026531840;


-------------------------------------------------------------------------------------------------------------------
--【イベントヘルプID定数】
-------------------------------------------------------------------------------------------------------------------

--▼調べる系(100番)

HELPID_CHECK 				= 10010100;--汎用(?)
HELPID_CHECK_GLOWING_CORPS	= 10010101;--光を放つ死体を調べる(レア)
HELPID_CHECK_CORPS			= 10010102;--死体を調べる(通常)
HELPID_PICK_ITEM            = 10010103;--アイテムを拾う(ボスアイテム用?)

--▼話す系(200番)

HELPID_TALK 				= 10010200;--汎用(?)
HELPID_TALK_WAR				= 10010201;--戦士と話す
HELPID_TALK_HUN				= 10010202;--狩人と話す
HELPID_TALK_CLE				= 10010203;--僧侶と話す
HELPID_TALK_MAG				= 10010204;--魔術師と話す
HELPID_TALK_SWO				= 10010205;--刀鍛冶と話す

--▼昇降系(300番)　Mapアクション系

HELPID_UP					= 10010300;--登る
HELPID_DOWN					= 10010301;--降りる

HELPID_WALL					= 10010303;--？壁張り付きようのヘルプ


--▼扉系(400番)

HELPID_OPEN					= 10010400;--開く
HELPID_CLOSE				= 10010401;--閉める
HELPID_REMOVE				= 10010402;--外す

--▼ギミック作動系(500番)

HELPID_START				= 10010500;--作動させる
HELPID_PULL_LEVER			= 10010501;--レバーを引く
HELPID_PUSH_LEVER			= 10010502;--レバーを押す
HELPID_TURN_HANDLE			= 10010503;--ハンドルを回す

--▼ワープ用(600番)(新)
HELPID_CHECK_OUJOU			= 10010650;--王城要石調べる	
HELPID_CHECK_HURUTORIDE		= 10010651;--古砦要石調べる
HELPID_CHECK_ROUJOU			= 10010652;--牢城要石調べる
HELPID_CHECK_HUJOU			= 10010653;--不浄要石調べる
HELPID_CHECK_KOUDOU			= 10010654;--坑道要石調べる
HELPID_CHECK_HOKUGEN		= 10010655;--北限要石調べる

--▼ワープ用(600番)(旧)
--[[
HELPID_GO_TO_OUJOU			= 10010600;--王城1へ行く
HELPID_GO_TO_OUJOU_2		= 10010608;--王城2へ行く
HELPID_GO_TO_OUJOU_3		= 10010614;--王城3へ行く
HELPID_GO_TO_OUJOU_4		= 10010620;--王城4へ行く

HELPID_GO_TO_HURUTORIDE		= 10010601;--古砦1へ行く
HELPID_GO_TO_HURUTORIDE_2	= 10010609;--古砦2へ行く
HELPID_GO_TO_HURUTORIDE_3	= 10010615;--古砦3へ行く

HELPID_GO_TO_ROUJOU			= 10010602;--牢城1へ行く
HELPID_GO_TO_ROUJOU_2		= 10010610;--牢城2へ行く
HELPID_GO_TO_ROUJOU_3		= 10010616;--牢城3へ行く

HELPID_GO_TO_HUJOU			= 10010603;--不浄1へ行く
HELPID_GO_TO_HUJOU_2		= 10010611;--不浄2へ行く
HELPID_GO_TO_HUJOU_3		= 10010617;--不浄3へ行く

HELPID_GO_TO_KOUDOU			= 10010604;--坑道1へ行く
HELPID_GO_TO_KOUDOU_2		= 10010612;--坑道2へ行く
HELPID_GO_TO_KOUDOU_3		= 10010618;--坑道3へ行く

HELPID_GO_TO_HOKUGEN		= 10010605;--北限1へ行く
HELPID_GO_TO_HOKUGEN_2		= 10010613;--北限2へ行く
HELPID_GO_TO_HOKUGEN_3		= 10010619;--北限3へ行く
]]
HELPID_GO_TO_SEKITYUU       = 10010606;--石柱へ行く
HELPID_GO_TO_IN				= 10010403;--中に入る
HELPID_GO_TO_OUT			= 10010404;--外に出る

--▼ソウルサイン

HELPID_TOUCH_SOUL_SIGN			= 50000000;--ソウルサインに触れる
HELPID_SOUL_SIGN_ACTIVATED		= 50000001;--ソウルサイン発動中
HELPID_TOUCH_BLOOD_MESSAGE		= 50000100;--血文字に触れる
HELPID_BLOOD_MESSAGE_ACTIVATED	= 50000101;--血文字発動中

HELPID_OPENCAMPMENU 			= 10010150;--キャンプメニュー表示
-------------------------------------------------------------------------------------------------------------------
--【プレイヤーアニメーションID定数】(よく使うのだけ)
-------------------------------------------------------------------------------------------------------------------

--▼アニメーションID▼
ANIMEID_WALK		= 7410;	--歩く(光の霧通過用)

ANIMEID_PICK 		= 7520;	--拾う
ANIMEID_KICK		= 7400;	--蹴る

ANIMEID_OPEN		= 7401;	--開ける
ANIMEID_CLOSE		= 7402;	--閉める

ANIMEID_PULL_LEVER	= 8000;	--レバーを引く
ANIMEID_PUSH_LEVER	= 8000;	--レバーを押す　	--レバーを引くを代用
ANIMEID_TURN_HANDLE	= 8010;	--ハンドルを回す

ANIMEID_BARISTA_GRASP      = 8100;--バリスタ掴む
ANIMEID_BARISTA_GRASP_KEEP = 8110;--バリスタ掴み待機
ANIMEID_BARISTA_AWAY       = 8120;--バリスタ放す


--▼アニメーション終了までにかかる時間▼(再生フレーム/FPS)
_GAME_FPS = 30;

ANIMEID_PICK_TIME	= (75.0 / _GAME_FPS); --落下で代用
ANIMEID_KICK_TIME	= (50.0 / _GAME_FPS);

ANIMEID_OPEN_TIME	= (80.0 / _GAME_FPS);
ANIMEID_CLOSE_TIME	= (60.0 / _GAME_FPS);

ANIMEID_PULL_LEVER_TIME  = (80.0 / _GAME_FPS);
ANIMEID_PUSH_LEVER_TIME  = (80.0 / _GAME_FPS); --レバーを引くで代用
ANIMEID_TURN_HANDLE_TIME = (60.0 / _GAME_FPS);

-------------------------------------------------------------------------------------------------------------------
--【サウンドバンクID】
-------------------------------------------------------------------------------------------------------------------
SOUND_TYPE_A		=  0; --a:環境音
SOUND_TYPE_C		=  1; --c:キャラモーション
SOUND_TYPE_F		=  2; --f:メニューSE
SOUND_TYPE_O		=  3; --o:オブジェクト
SOUND_TYPE_P		=  4; --p:ポリ劇専用SE
SOUND_TYPE_S		=  5; --s:SFX
SOUND_TYPE_M		=  6; --m:BGM
SOUND_TYPE_V		=  7; --v:音声
SOUND_TYPE_X		=  8; --x:床材質依存
SOUND_TYPE_B		=  9; --b:鎧材質依存
SOUND_TYPE_G		= 10; --g:ゴースト

-------------------------------------------------------------------------------------------------------------------
--【プレイヤーの状態定数】
-------------------------------------------------------------------------------------------------------------------

CHR_TYPE_LivePlayer	= 0; --生存プレイヤー
CHR_TYPE_GreyGhost  = 8; --グレイゴースト(通常ゴースト)
CHR_TYPE_WhiteGhost = 1; --ホワイトゴースト(友好ゴースト)
CHR_TYPE_BlackGhost = 2; --ブラックゴースト(敵対ゴースト)


-------------------------------------------------------------------------------------------------------------------
--【チームタイプ定数】
-------------------------------------------------------------------------------------------------------------------
TEAM_TYPE_None 			= 0;--無効
TEAM_TYPE_Live			= 1;--生存プレイヤー
TEAM_TYPE_WhiteGhost	= 2;--ホワイトゴースト
TEAM_TYPE_BlackGhost	= 3;--ブラックゴースト
TEAM_TYPE_GlayGhost		= 4;--グレイゴースト
TEAM_TYPE_WanderGhost	= 5;--徘徊ゴースト
TEAM_TYPE_Enemy			= 6;--敵
TEAM_TYPE_Boss			= 7;--強敵
TEAM_TYPE_Friend		= 8;--味方
TEAM_TYPE_AngryFriend	= 9;--味方（怒）
TEAM_TYPE_DecoyEnemy	= 10;--おとり敵（腐敗人）
TEAM_TYPE_BloodChild	= 11;--赤子
TEAM_TYPE_BattleFriend	= 12;--戦う味方

-------------------------------------------------------------------------------------------------------------------
--【メッセージカテゴリID】--エクセルファイルの識別に使われる
-------------------------------------------------------------------------------------------------------------------
MSG_CATEGORY_SAMPLE		=  0;--サンプル
MSG_CATEGORY_TALK		=  1;--会話
MSG_CATEGORY_BLOOD		=  2;--血文字
MSG_CATEGORY_ITEM		= 10;--アイテム
MSG_CATEGORY_WEP		= 11;--武器
MSG_CATEGORY_PRO		= 12;--防具
MSG_CATEGORY_ACC		= 13;--アクセサリー
MSG_CATEGORY_ITEM_EXP	= 20;--アイテム説明
MSG_CATEGORY_WEP_EXP	= 21;--武器説明
MSG_CATEGORY_PRO_EXP	= 22;--防具説明
MSG_CATEGORY_ACC_EXP	= 23;--アクセサリー説明
MSG_CATEGORY_EVENT		= 30;--イベントテキスト
MSG_CATEGORY_DIALOG		= 78;--ダイアログ


-------------------------------------------------------------------------------------------------------------------
--【システムで使用するアクションID】--
-------------------------------------------------------------------------------------------------------------------
SYSTEM_ID_IGNORE		= 4048;
IGNORE_TIME				= 3.0;
SYSTEM_WARP				= 4052;--ワープアニメの繋ぎ用ID
SYSTEM_CHECK_POINT		= 4054;--チェックポイント通過
SYSTEM_GENDIALOG		= 4061;--汎用ダイアログ距離判定用

-------------------------------------------------------------------------------------------------------------------
--【インフォメーションメニューの表示タイプ】
-------------------------------------------------------------------------------------------------------------------
INFOMENU_TYPE_LIST		= 0;--行を追加できる通常タイプ。
INFOMENU_TYPE_SIMPLE	= 1;--タイトルとシステム欄のみの簡易タイプ


-------------------------------------------------------------------------------------------------------------------
--【OnObjectDamageHit ヒット対象識別用定数】
-------------------------------------------------------------------------------------------------------------------
EV_HIT_CHR = 1;--キャラが対象
EV_HIT_HIT = 2;--マップが対象
EV_HIT_ALL = 3;--キャラとマップが対象

-------------------------------------------------------------------------------------------------------------------
--【職業用定数】
-------------------------------------------------------------------------------------------------------------------

JOB_LOW_SOLDIER		= 0;--下級兵士	生まれ／戦士チュートリアル
JOB_LOW_KNIGHT		= 1;--下級騎士	生まれ／戦士チュートリアル
JOB_HUNTER			= 2;--狩人		生まれ／狩人チュートリアル
JOB_CLERIC			= 3;--神職		生まれ／僧侶チュートリアル
JOB_SHAMAN			= 4;--呪師		生まれ／魔術師チュートリアル
JOB_NEET			= 5;--放浪者	生まれ／戦士チュートリアル
JOB_MERCENARY		= 6;--蛮族		生まれ／戦士チュートリアル
JOB_THIEF			= 7;--盗賊		生まれ／狩人チュートリアル
JOB_TEMPLE_KNIGHT	= 8;--神殿騎士	生まれ／僧侶チュートリアル
JOB_NOBLEMAN		= 9;--貴族		生まれ／魔術師チュートリアル





-------------------------------------------------------------------------------------------------------------------
--【OnObjectDamageHit 属性ダメージ指定用】
-------------------------------------------------------------------------------------------------------------------
DAMAGE_TYPE_NONE = -1;--無属性
DAMAGE_TYPE_FIRE = 10;--炎属性

-------------------------------------------------------------------------------------------------------------------
--【発動属性】 --発動をプレイヤの状態によって制限できる
-------------------------------------------------------------------------------------------------------------------
ATTR_SESSION 	=   1;
ATTR_NOSESSION	=   2;
ATTR_HOST		=   4;
ATTR_CLIENT		=   8;
ATTR_LIVE		=  16;
ATTR_GREY		=  32;
ATTR_WHITE		=  64;
ATTR_BLACK		= 128;
ATTR_ALL		= 255;

-------------------------------------------------------------------------------------------------------------------
--【イベント会話の設定フラグ】 --会話の設定フラグ関連
-------------------------------------------------------------------------------------------------------------------
TALK_ATTR_REPEAT 	=   1;
TALK_ATTR_PAD		=   2;
TALK_ATTR_DRAW		=   4;
TALK_ATTR_VOICE		=   8;
TALK_ATTR_ALL		= 255;

-------------------------------------------------------------------------------------------------------------------
--【タグインデックス】 --メッセージにプレイヤ名を入れ込む際に、タグの属性を指定する必要がある
-------------------------------------------------------------------------------------------------------------------
TAG_IDX_liveChara 		= 0;
TAG_IDX_joinChara 		= 1;
TAG_IDX_deadChara 		= 2;
TAG_IDX_leaveChara 		= 3;

-------------------------------------------------------------------------------------------------------------------
--【ポリ劇コールバックハンドラ定数】
--RequestRemo(scnId,nflag,cbArgA,cbArgB) 
--cbArgAに指定した数値がハンドラのイベントIDで利用される。
--cbArgBに1以上を指定した場合必ずハンドラがコールされます。
--コールされるハンドラのパラム設定は以下を参照
-------------------------------------------------------------------------------------------------------------------
REMO_START		=10;		--ポリ劇開始(フェード終了時
REMO_FINISH		=100;			--ポリ劇終了

-------------------------------------------------------------------------------------------------------------------
--【ポリ劇フラグ定数】
--マルチ時にスキップ不可、シングル時には通常になります
-------------------------------------------------------------------------------------------------------------------
REMO_FLAG		=0;

-------------------------------------------------------------------------------------------------------------------
--【ムービー指定定数】
-------------------------------------------------------------------------------------------------------------------
MOVIE_ADVERTISE 	= 0;	--アドバタイズムービー
MOVIE_TITLE			= 1;	--タイトルムービー
MOVIE_OPENING		= 2;	--オープニングムービー
MOVIE_STAFFROLL		= 3;	--スタッフロールムービー
MOVIE_ENDING_BAD	= 4;	--バッドエンディングムービー
MOVIE_ENDING_GOOD	= 5;	--グッドエンディングムービー
MOVIE_OLDTALE		= 6;	--昔話ムービー


-------------------------------------------------------------------------------------------------------------------
--【クリア定数】
-------------------------------------------------------------------------------------------------------------------
CLEAR_STATE_BADEND = 2;		--BadEnding
CLEAR_STATE_GOODEND = 1;	--GoodEnding

-------------------------------------------------------------------------------------------------------------------
--【10月末締め用調整定数】
-------------------------------------------------------------------------------------------------------------------
NPCTIMER		=120;--単位(秒)
TEXT_TIMER      =0;--単位(秒)


-------------------------------------------------------------------------------------------------------------------
--【テキスト演出定数】
-------------------------------------------------------------------------------------------------------------------
TEXT_TYPE_KillDemon		= 1;--デーモン撃破
TEXT_TYPE_Dead			= 2;--死亡
TEXT_TYPE_Revival		= 3;--復活
TEXT_TYPE_SoulGet		= 4;--ソウル取得
TEXT_TYPE_TargetClear	= 5;--目標撃破
TEXT_TYPE_GhostDead		= 6;--ゴースト死亡
TEXT_TYPE_BlackClear	= 7;--ブラックゴースト撃破

-------------------------------------------------------------------------------------------------------------------
--【ファランクス関連定数】
-------------------------------------------------------------------------------------------------------------------
--EzState命令定数
PHALANX_Core_ToGattai	= 100;		--合体状態へ移行
PHALANX_Core_ToBousui	= 101;		--紡錘状態へ移行
PHALANX_Core_ToBunsan	= 102;		--分散状態へ移行
PHALANX_Core_ToHitWall	= 103;		--壁に当たった
PHALANX_Core_ToClimb	= 104;		--斜め壁に上った
PHALANX_Core_ToTotugeki = 105;		--突撃準備
PHALANX_Core_ToHitObj	= 106;		--OBJ小屋に当たった

PHALANX_Jr_Wait			= 150;		--Jr待機
PHALANX_Jr_MaruWait		= 151;		--Jrまるがた待機
PHALANX_Jr_Nezumi 		= 152;		--Jrハリネズミ開始
PHALANX_Jr_AllYarinage	= 153;		--Jr全槍投げ
PHALANX_Jr_TankiYari	= 154;		--Jr単騎槍攻撃
PHALANX_Jr_TankiYarinage= 155;		--Jr単騎槍投げ
PHALANX_Jr_NormalBunsan = 156;		--Jr通常分散
PHALANX_Jr_KokeBunsan	= 157;		--Jr転倒分散
PHALANX_Jr_KabeYari		= 158;		--Jr壁から槍の雨
PHALANX_Jr_Totugeki		= 159;		--Jr突撃
PHALANX_Jr_MaruEnd		= 160;		--Jrまるがた待機終了

--EzState戻り値定数
RES_PHALANX_Nezumi_Start		=100;		--ハリネズミ攻撃開始
RES_PHALANX_Nezumi_End			=101;		--ハリネズミ攻撃終了
RES_PHALANX_AllYarinageStart	=102;		--全槍射出攻撃開始
RES_PHALANX_AllYarinageEnd		=103;		--全槍射出攻撃終了
RES_PHALANX_TankiYariStart		=104;		--単騎槍攻撃開始
RES_PHALANX_TankiYariEnd		=105;		--単騎槍攻撃終了
RES_PHALANX_TankiYarinageStart	=106;		--単騎槍射出開始
RES_PHALANX_TankiYarinageEnd	=107;		--単騎槍射出終了
RES_PHALANX_KabeYariStart		=108;		--壁から槍の雨開始
RES_PHALANX_KabeYariEnd			=109;		--壁から槍の雨終了
RES_PHALANX_GattaiComp			=110;		--合体移行完了
RES_PHALANX_BousuiComp			=111;		--紡錘移行完了
RES_PHALANX_BunsanComp			=112;		--分散移行完了
RES_PHALANX_TotugekiStart		=113;		--突進開始
RES_PHALANX_TotugekiEnd			=114;		--突撃終了
RES_PHALANX_TotugekiStop		=115;		--突進停止終了

--EzState戻り値定数
RES_PHALANX_JR_Wait				= 150;		--通常待機開始
RES_PHALANX_JR_MaruWait			= 151;		--まるがた待機開始



JR_STATE_Normal			=0;--通常
JR_STATE_ToCore			=1;--コアを目指した移動
JR_STATE_HoverMove		=2;--コア到達＞ダミポリへの移動
JR_STATE_DmyHover		=3;--ダミポリへの移動＞ホバー吸着
JR_STATE_DmyAttach		=4;--ダミポリ接着
--JR_STATE_DmyDettach--ダミポリ切り離し
JR_STATE_HavokFly		=5;--Havok剥がし
JR_STATE_Single			=6;--一人身更新
JR_STATE_Dead			=7;--Jr死亡

JR_BaseDmyPolyMoveWait	= 8;--ダミポリ間移動の基本値
PHALANX_MaxReturnCount	= 3;--戻り状態の最大値
 


--PT解散までの時間
CLEAR_TIMEOUT = 10.0;

-------------------------------------------------------------------------------------------------------------------
--【イベント監視属性値】--ここに書いておくと、ソースを開かなくても属性値の意味が確認が出来る為記述。実際にスクリプトで使うことはありません。
-------------------------------------------------------------------------------------------------------------------
--EVENT_OBSERVE_DIST_PLAYER	=  0;		//!<	距離	
--EVENT_REGION_ACTION		=  2;		//!<	領域内で入力
--EVENT_REGION_IN			=  3;		//!<	領域に入っている
--EVENT_REGION_JUSTIN		=  4;		//!<	領域に入った瞬間
--EVENT_REGION_JUSTOUT		=  5;		//!<	領域を出た瞬間
--EVENT_DIST_ACTION			=  6;		//!<	距離内で角度内での入力
--EVENT_DIST_IN				=  7;		//!<	範囲内
--EVENT_DIST_OUT			=  8;		//!<	範囲から外れる
--EVENT_DIST_ANGLE			=  9;		//!<	距離内で角度内
--EVENT_KEYFRAME_ONCE		= 10;		//!<	キーフレーム時
--EVENT_KEYFRAME_EVERYTIME	= 11;		//!<	キーフレームまで
--EVENT_CALL				= 12;		//!<	イベントコール
--EVENT_HP					= 13;		//!<	HP
--EVENT_DEAD				= 14;		//!<	完全死亡(死亡アニメの終了まで監視)
--EVENT_KEYTIME_ONCE		= 15;		//!<	秒後
--EVENT_KEYTIME_EVERYTIME	= 16;		//!<	秒間
--EVENT_ANIME_END			= 17;		//!<	アニメーション終了
--EVENT_OBJECT_DESTROYED	= 18;		//!<	OBJ破壊
--TALKEVENT_DIST_ACTION		= 19;		//!<	距離内かつ角度内での入力(会話用)
--TALKEVENT_DIST_IN			= 20;		//!<	距離内(会話用)
--TALKEVENT_DIST_OUT		= 21;		//!<	距離内からでた(会話用)
--TALKEVENT_DIST_ANGLEOUT	= 22;		//!<	距離内で角度が外れた(会話用)
--TALKEVENT_ANGLE			= 23;		//!<	距離内、角度内
--EVENT_SIMPLEDAMAGE		= 24;		//!<	ダメージイベント	
--EVENT_TURN				= 25;		//!<	旋回
--EVENT_REGIST_FUNC			= 26;		//!<	ルアー関数監視
--EVENT_OBJ_DAMAGE			= 27;		//!<	オブジェクトのダメージ球監視
--EVENT_KEEPACTIONID		= 28;		//!<	EzStateに命令を送り続ける用
--EVENT_EZSTATEMESSAGE		= 29;		//!<	EzStateの命令監視
--EVENT_KEYCHECK			= 30;		//!<	キー入力の監視
--EVENT_ITEM				= 31;		//!<	アイテム取得
--EVENT_PK					= 32;		//!<	PKの監視
--EVENT_SELF_BLOODMARK		= 33;		//!<	自分の血文字
--EVENT_SESSION_JUSTIN		= 34;		//!<	セッション繋いだ瞬間
--EVENT_SESSION_IN			= 35;		//!<	セッション中
--EVENT_SESSION_JUSTOUT		= 36;		//!<	セッション切れた瞬間
--EVENT_SESSION_OUT			= 37;		//!<	セッション無し
--EVENT_BLOODMENU			= 38;		//!<	血文字作成メニューの監視
--EVENT_SOSMENU				= 39;		//!<	SOS作成メニューの監視
--EVENT_ASSESSMENU			= 40;		//!<	評価メニューの監視
--EVENT_WAPRMENU			= 41;		//!<	ワープメニューの監視
--EVENT_BODYDAM				= 42;		//!<	部位ダメージの監視


-------------------------------------------------------------------------------------------------------------------
--■NPC状態定数
-------------------------------------------------------------------------------------------------------------------

--[[【ロガーン】の状態(牢城・石柱兼用)]]
ROGARN_STATE_PRISONER		= 16190;--囚われ
ROGARN_STATE_WAIT			= 16191;--石柱で待つ
ROGARN_STATE_ANGRY_M4		= 16192;--敵対(牢城)
ROGARN_STATE_ANGRY_M1		= 16193;--敵対(石柱)
ROGARN_STATE_DEAD			= 16194;--死亡
ROGARN_STATE_GO_M1			= 16195;--石柱に行きたい
ROGARN_STATE_LAST_WARD		= 16196;--最後の言葉を伝えたい(石柱)
rogarn_flag_list = {
	ROGARN_STATE_PRISONER,
	ROGARN_STATE_WAIT,
	ROGARN_STATE_ANGRY_M4,
	ROGARN_STATE_ANGRY_M1,
	ROGARN_STATE_DEAD,
	ROGARN_STATE_GO_M1,
	ROGARN_STATE_LAST_WARD
};
TOTALDAMAGE_ROGARN_M40 = 50;--【ロガーン】敵対蓄積ダメージ




--[[【元貴族婦人】の状態]]
NOBLE_WOMAN_STATE_BUSINESS	= 16210;--商売中
NOBLE_WOMAN_STATE_ANGRY		= 16211;--敵対
NOBLE_WOMAN_STATE_DEAD		= 16212;--死亡
noble_woman_flag_list = {
	NOBLE_WOMAN_STATE_BUSINESS,
	NOBLE_WOMAN_STATE_ANGRY,
	NOBLE_WOMAN_STATE_DEAD,
};
TOTALDAMAGE_NOBLE_WOMAN = 50;--【元貴族婦人】敵対蓄積ダメージ





--[[【ユルト】の状態(牢城、石柱兼用)]]
YURUTO_STATE_LIFT			= 16220;--エレベータにいる
YURUTO_STATE_WAIT_M1		= 16221;--石柱にいる
YURUTO_STATE_ANGRY_M4		= 16222;--敵対(牢城)
YURUTO_STATE_ANGRY_M1		= 16223;--敵対(石柱)
YURUTO_STATE_DEAD			= 16224;--死亡
YURUTO_STANDBY_M1			= 16225;--石柱に行く前
yuruto_flag_list = {
	YURUTO_STATE_LIFT,
	YURUTO_STATE_WAIT_M1,
	YURUTO_STATE_ANGRY_M4,
	YURUTO_STATE_ANGRY_M1,
	YURUTO_STATE_DEAD,
	YURUTO_STANDBY_M1,
};
TOTALDAMAGE_YURUTO_M40 = 50;--【ユルト】敵対蓄積ダメージ

--[[【ビヨルングルム】状態一覧]]
BIYO_STATE_CAPTIVE					= 16060;--牢屋に囚われ
BIYO_STATE_THANKS					= 16061;--解放してくれて感謝
BIYO_STATE_SLEEPING_IN_PRISON		= 16062;--牢屋で寝ている
BIYO_STATE_HOSTILE_IN_PRISON		= 16063;--敵対(牢内)
BIYO_STATE_DEAD						= 16064;--死亡(ビヨルン)
BIYO_STATE_TARGET_ENEMY				= 16065;--獄吏を倒したい
BIYO_STATE_END_OF_STRIKES_BACK		= 16066;--逆襲が終わって満足して寝る
BIYO_STATE_HOSTILE_IN_RAMPART		= 16067;--敵対(城壁)
BIYO_STATE_SEARCH_3					= 16068;--王城3を探索
BIYO_STATE_KING_OF_SWORD_KILL		= 16069;--王の剣を倒して満足
BIYO_STATE_HOSTILE_IN_KING_ROOM		= 16070;--敵対(王の剣の部屋)
--BIYO_STATE_KING_ROOM_DOWN			= 16071;--王の剣の部屋で寝る
BIYO_STATE_BATTLE_FLY_DRAGON		= 16072;--飛竜の長と戦う
--BIYO_STATE_RETURN_TO_STONE_PILLAR	= 16073;--石柱に戻りたい
--BIYO_STATE_WAIT_M1					= 16074;--石柱にいる
BIYO_STATE_HOSTILE_IN_STONE_PILLAR	= 16075;--敵対(石柱)
BIYO_STATE_HOSTILE_IN_GATE_FRONT	= 16076;--敵対(ゲート前)
BIYO_STATE_EXIT						= 16077;--もういない
biyo_flag_list = {
	BIYO_STATE_CAPTIVE					,
	BIYO_STATE_THANKS					,
	BIYO_STATE_SLEEPING_IN_PRISON		,
	BIYO_STATE_HOSTILE_IN_PRISON		,
	BIYO_STATE_DEAD						,
	BIYO_STATE_TARGET_ENEMY				,
	BIYO_STATE_END_OF_STRIKES_BACK		,
	BIYO_STATE_HOSTILE_IN_RAMPART		,
	BIYO_STATE_SEARCH_3					,
	BIYO_STATE_KING_OF_SWORD_KILL		,
	BIYO_STATE_HOSTILE_IN_KING_ROOM		,
--	BIYO_STATE_KING_ROOM_DOWN			,
	BIYO_STATE_BATTLE_FLY_DRAGON		,
--	BIYO_STATE_RETURN_TO_STONE_PILLAR	,
--	BIYO_STATE_WAIT_M1					,
	BIYO_STATE_HOSTILE_IN_STONE_PILLAR	,
	BIYO_STATE_HOSTILE_IN_GATE_FRONT	,
	BIYO_STATE_EXIT
};

--[[【魔女】状態一覧]]
MAJO_STATE_LIBERATE = 16110;--解放してほしい
MAJO_STATE_BREAK    = 16111;--塔で休憩
MAJO_STATE_HOSTILE  = 16112;--敵対
MAJO_STATE_DEAD     = 16113;--死亡
MAJO_STATE_THANKS   = 16114;--感謝
MAJO_STATE_WAIT_M1	= 16115;--石柱にいる
MAJO_STATE_ANGRY_M1	= 16116;--敵対(石柱)

majo_flag_list = {
	MAJO_STATE_LIBERATE	,
	MAJO_STATE_BREAK	,
	MAJO_STATE_HOSTILE	,
	MAJO_STATE_DEAD		,
	MAJO_STATE_THANKS	,
	MAJO_STATE_WAIT_M1	,
	MAJO_STATE_ANGRY_M1
};


--[[ウルベイン状態一覧]]
URUBAIN_STATE_HELP					= 16120;	--助けて欲しい状態
URUBAIN_STATE_THANKS				= 16121;	--感謝している状態
URUBAIN_STATE_ANGRY					= 16122;	--怒っている
URUBAIN_STATE_DEAD					= 16123;	--死んでいる
URUBAIN_STATE_STONE_PILLAR			= 16124;	--石柱にいる
URUBAIN_STATE_STONE_PILLAR_ANGRY	= 16125;	--敵対(石柱)
urubain_flag_list = {
	URUBAIN_STATE_HELP				,
	URUBAIN_STATE_THANKS			,
	URUBAIN_STATE_ANGRY				,
	URUBAIN_STATE_DEAD				,
	URUBAIN_STATE_STONE_PILLAR		,
	URUBAIN_STATE_STONE_PILLAR_ANGRY
};

--ウルベイン蓄積ダメージ
TOTALDAMAGE_URUBAIN = 50;

--[[バッチ状態一覧]]
BATTI_NOT_STAY		= 16240;--まだどこにもいない
BATTI_COME 			= 16241;--来て欲しい(古砦)
BATTI_PUSHING 		= 16242;--突き落としたい(古砦)
BATTI_SATISFIED 	= 16243;--満足(古砦)
BATTI_ANGRY 		= 16244;--怒っている(古砦)
BATTI_DEAD 			= 16245;--死んでいる
BATTI_TRAP_M6		= 16246;--罠にはめたい(坑道)
BATTI_TREASURE_M6	= 16247;--宝は頂いた(坑道)
BATTI_VEXING_M6		= 16248;--残念(坑道)
BATTI_ANGRY_M6		= 16249;--敵対(坑道)
BATTI_DESTORYKUMA	= 16250;--クマムシ撃破(坑道)
BATTI_PRESENT		= 16251;--アイテムをあげた(坑道)
BATTI_SATISFIED_M4	= 16252;--満足(牢城)
BATTI_VEXING_M4		= 16253;--残念(牢城)
BATTI_ANGRY_M4 		= 16254;--敵対(牢城)
BATTI_RESERVE_M1	= 16255;--出撃準備中(石柱)
BATTI_ANGRY_M1		= 16256;--敵対(石柱)
batti_flag_list = {
	BATTI_NOT_STAY		,
	BATTI_COME			,
	BATTI_PUSHING		,
	BATTI_SATISFIED		,
	BATTI_ANGRY			,
	BATTI_DEAD			,
	BATTI_TRAP_M6		,
	BATTI_TREASURE_M6	,
	BATTI_VEXING_M6		,
	BATTI_ANGRY_M6		,
	BATTI_DESTORYKUMA	,
	BATTI_PRESENT		,
	BATTI_SATISFIED_M4	,
	BATTI_VEXING_M4		,
	BATTI_ANGRY_M4		,
	BATTI_RESERVE_M1	,
	BATTI_ANGRY_M1		
};

--ウィス蓄積ダメージ
TOTALDAMAGE_BATTI = 50;



-------------------------------------------------------------------------------------------------------------------
--■王城イベントで使用する定数
-------------------------------------------------------------------------------------------------------------------

--▼レンドル王子の状態一覧

--▽王城全域
RENDOL_STATE_DEAD                  = 16004;--死んでいる

--▽王城1固定
RENDOL_STATE_HELP_FOR_DOREI_HEISI  = 16000;--奴隷兵士から助けて(一番最初に王城1に入ったときはこの状態になる)
RENDOL_STATE_THANKS_1			   = 16001;--感謝(王城1)
RENDOL_STATE_SEARCH_1			   = 16002;--探索(王城1)
RENDOL_STATE_HOSTILE_1             = 16003;--敵対(王城1)

--▽王城2固定
RENDOL_STATE_HELP_HIDING_ME        = 16005;--隠れているので助けて
RENDOL_STATE_THANKS_2			   = 16006;--感謝(王城2)
RENDOL_STATE_SEARCH_2			   = 16007;--探索(王城2)
RENDOL_STATE_HOSTILE_2             = 16008;--敵対(王城2)

--▽王城3固定
RENDOL_STATE_LOCATION_INVISIBLE		= 16009;--見えない場所にこっそり
RENDOL_STATE_WANT_TO_OPEN_THE_GATE	= 16010;--門を開けてほしい
RENDOL_STATE_SCARED					= 16011;--袋小路でおびえ
RENDOL_STATE_THANKS_3				= 16012;--感謝(王城3)
RENDOL_STATE_SEARCH_3				= 16013;--探索(王城3)
RENDOL_STATE_HOSTILE_3_FRONT_GATE	= 16014;--敵対(王城3 城門の前)
RENDOL_STATE_HOSTILE_3_BACK_GATE	= 16015;--敵対(王城3 城門の後ろ)

--▽王城4固定
RENDOL_STATE_LIFT_FRONT				= 16016;--王城4 エレベータ前
RENDOL_STATE_HOSTILE_4_LIFT_FRONT	= 16017;--敵対(王城4 エレベータ前)
RENDOL_STATE_HOSTILE_STONE_PILLAR	= 16018;--敵対(石柱)
RENDOL_STATE_ERASE					= 16019;--もういない

rendol_flag_list = {
	RENDOL_STATE_HELP_FOR_DOREI_HEISI,
	RENDOL_STATE_THANKS_1,
	RENDOL_STATE_SEARCH_1,
	RENDOL_STATE_HOSTILE_1,
	RENDOL_STATE_DEAD,
	RENDOL_STATE_HELP_HIDING_ME,
	RENDOL_STATE_THANKS_2,
	RENDOL_STATE_SEARCH_2,
	RENDOL_STATE_HOSTILE_2,
	RENDOL_STATE_LOCATION_INVISIBLE,
	RENDOL_STATE_WANT_TO_OPEN_THE_GATE,
	RENDOL_STATE_SCARED,
	RENDOL_STATE_THANKS_3,
	RENDOL_STATE_SEARCH_3,
	RENDOL_STATE_HOSTILE_3_FRONT_GATE,
	RENDOL_STATE_HOSTILE_3_BACK_GATE,
	RENDOL_STATE_LIFT_FRONT,
	RENDOL_STATE_HOSTILE_4_LIFT_FRONT,
	RENDOL_STATE_HOSTILE_STONE_PILLAR,
	RENDOL_STATE_ERASE,
};

--▼遷移する可能性のある状態一覧のリスト(マップごとに用意)

--▽王城1
possible_transration_list_m02_00_00_00 = {

	RENDOL_STATE_HELP_FOR_DOREI_HEISI , 
	RENDOL_STATE_THANKS_1 , 
	RENDOL_STATE_SEARCH_1 , 
	RENDOL_STATE_HOSTILE_1 , 
	RENDOL_STATE_DEAD 
};

--▽王城2
possible_transration_list_m02_01_00_00 = {

	RENDOL_STATE_HELP_HIDING_ME , 
	RENDOL_STATE_THANKS_2 , 
	RENDOL_STATE_SEARCH_2 , 
	RENDOL_STATE_HOSTILE_2 , 
	RENDOL_STATE_DEAD 
};

--▽王城3
possible_transration_list_m02_02_00_00 = {

	RENDOL_STATE_LOCATION_INVISIBLE ,
	RENDOL_STATE_WANT_TO_OPEN_THE_GATE , 
	RENDOL_STATE_SCARED ,
	RENDOL_STATE_THANKS_3 , 
	RENDOL_STATE_SEARCH_3 , 
	RENDOL_STATE_HOSTILE_3_FRONT_GATE , 
	RENDOL_STATE_HOSTILE_3_BACK_GATE ,
	RENDOL_STATE_DEAD 
};

--▽王城4
possible_transration_list_m02_03_00_00 = {

	RENDOL_STATE_LIFT_FRONT				,
	RENDOL_STATE_HOSTILE_4_LIFT_FRONT	,
	RENDOL_STATE_HOSTILE_STONE_PILLAR	,
	RENDOL_STATE_DEAD 
};


--▼飛竜(長)の状態一覧

TYO_STATE_SLEEPING          = 16040;--巣で寝ている
TYO_STATE_DEAD              = 16041;--死んでいる(長)
TYO_STATE_WARNING_AISLE     = 16042;--警戒(通路)
TYO_STATE_WARNING_GATE      = 16043;--警戒(ゲート)
TYO_STATE_WARNING_KING_ROOM = 16044;--警戒(王の間) 
TYO_STATE_ESCAPE			= 16045;--撤退
tyo_flag_list = {	
	TYO_STATE_DEAD	   ,
	TYO_STATE_WARNING_AISLE ,
	TYO_STATE_WARNING_GATE ,
	TYO_STATE_WARNING_KING_ROOM
};

tyo1_flag_list = {
	TYO_STATE_SLEEPING ,
	TYO_STATE_ESCAPE
};

--▼飛竜(眷属1)の状態一覧

KENZOKU_STATE_WARNING           = 16030;--巣にいる
KENZOKU_STATE_ABSENCE           = 16031;--不在
KENZOKU_STATE_PROTECT_CASTLE    = 16032;--城壁護る
KENZOKU_STATE_DEAD              = 16033;--死亡
KENZOKU_STATE_WARNING_AND_LEVER = 16034;--巣にいる(レバー阻止諦め)
KENZOKU_STATE_ABSENCE_AND_LEVER = 16035;--不在(レバー阻止諦め)
KENZOKU_STATE_ESCAPE			= 16036;--撤退
KENZOKU_2_STATE_DEAD            = 16102;--死亡(王城2)

kenzoku_flag_list = { 
	KENZOKU_STATE_WARNING           ,
	KENZOKU_STATE_ABSENCE           ,
	KENZOKU_STATE_PROTECT_CASTLE    ,
	KENZOKU_STATE_DEAD              ,
	KENZOKU_STATE_WARNING_AND_LEVER ,
	KENZOKU_STATE_ABSENCE_AND_LEVER ,
	KENZOKU_STATE_ESCAPE			,
	KENZOKU_2_STATE_DEAD            , --王城2で死亡(眷属) 王城1で死亡と分けられているらしい･･･
};



--▼飛竜(眷属2)状態一覧

KENZOKU_2_STATE_WARNING  = 16100;--警戒
KENZOKU_2_STATE_HEROHERO = 16101;--ヘロヘロ
KENZOKU_2_STATE_DEAD     = 16102;--死亡(眷属2=王城2)
KENZOKU_STATE_DEAD       = 16033;--死亡(眷属1=王城1) なぜか死亡が2つに分かれている。

kenzoku_2_flag_list = {

	KENZOKU_2_STATE_WARNING  ,
	KENZOKU_2_STATE_HEROHERO ,
	KENZOKU_2_STATE_DEAD ,
    KENZOKU_STATE_DEAD    
};



--宝系SFXID
KANAME_SFX = 99100;
KAGI_SFX = 94110;
KEN_SFX = 99050;
ITEM_SFX = 93010;

USER_IDX_Unknow 			= -1;	--不明
USER_ID_Network_Error		= 0;	--ネットワーク＿エラー系
USER_ID_Network_Notice		= 1;	--ネットワーク＿通知系
USER_ID_Network_MultiPlay	= 2;	--ネットワーク＿マルチプレイ
USER_ID_Network_Login		= 3;	--ネットワーク＿ログイン
USER_ID_Event_SosLost_White	= 4;	--イベント＿SOS消失_White
USER_ID_Event_SosLost_Red	= 5;	--イベント＿SOS消失_Red
USER_ID_Event_SosLost_Black	= 6;	--イベント＿SOS消失_Black
USER_ID_Event_GetItem		= 7;	--イベント＿アイテム取得系


