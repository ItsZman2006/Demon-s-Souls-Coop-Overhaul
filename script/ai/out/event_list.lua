-----------------------------------------------------------------------------------------------
--	イベントとAIでやりとりを行うときの定数一覧
--	キャラごとに内容が変わると思うので、
--	ここに定数を記述して、イベント、AIの両方のスクリプトで
--	使用するようにしてください
-----------------------------------------------------------------------------------------------


AI_EVENT_None = -1;		-- とくになし

-- ファランクス用
-- AI_EVENT_Phalanx_Gattai = 0;	-- 合体中	-- こんなかんじで定数を決めてください。
--どんな状態をさらに細分化して取りたくなるかもしれないのでとりあえず10区切りに設定
AI_EVENT_Phalanx_Gattai = 10;			--合体中


AI_EVENT_Phalanx_Bousui = 20;			--紡錘中
AI_EVENT_Phalanx_Bousui_Attack=21;		--紡錘中突進
AI_EVENT_Phalanx_Bousui_WallAttack=22;	--紡錘中壁昇り突進


AI_EVENT_Phalanx_Bunsan = 30;			--分散中


-- 王の盾用



-- 炎の怪人用
--AI_EVENT_None =-1;					--通常(slot0)
AI_EVENT_FlameMan_Angry = 10;			--怒ってるとき(slot0)
AI_EVENT_FlameMan_Weaker= 20;			--弱ってるとき(slot0)

--AI_EVENT_None = -1;					--まだ吼えてない時(slot1) 
AI_EVENT_FlameMan_Roar = 1;				--咆哮したとき(slot1)

--奴隷兵士イベント用
--AI_EVENT_None = -1;					--通常
AI_EVENT_DOREI_IKAKU = 10;				--威嚇(slot0)


--審判者様
AI_EVENT_AREA01 = 10;					--1Fに居るとき(slot0)
AI_EVENT_AREA02 = 20;					--2Fに居るとき(slot0)
AI_EVENT_AREA03 = 30;					--3Fに居るとき(slot0)
AI_EVENT_AREA04 = 40;					--2-3階　踊り場(slot0)
AI_EVENT_AREA05 = 50;					--1-2階　踊り場(slot0)
AI_EVENT_AREA06 = 60;					--落下エリア(slot0)

--蜘蛛？
AI_EVENT_STAY_TUNNEL = 10;				--プレイヤーがトンネルにいる(slot0)
AI_EVENT_STAY_ROOM = 20;				--プレイヤーが部屋に入ってきてる(slot0)

AI_EVENT_TUNNEL_RIGHT = 10;				--プレイヤーがトンネルの右端にいる(slot1)
AI_EVENT_TUNNEL_CENTER = 20;			--プレイヤーがトンネルの中央にいる(slot1)
AI_EVENT_TUNNEL_LEFT = 30;				--プレイヤーがトンネルの左端にいる(slot1)
AI_EVENT_ROOM_RIGHT = 40;				--プレイヤーが部屋内部の右側にいる(slot1)
AI_EVENT_ROOM_CENTER = 50;				--プレイヤーが部屋内部の中央にいる(slot1)
AI_EVENT_ROOM_LEFT = 60;				--プレイヤーが部屋内部の左側にいる(slot1)


--ヒロイン用
AI_EVENT_GRACE = 10;					--ヒロイン祈り思考(slot0)


--嵐の獣～天駆ける巨大エイ
AI_EVENT_FOR_RIGHT = 10;				--遠方右エリア(slot0)
AI_EVENT_FOR_CENTER = 20;				--遠方正面エリア(slot0)
AI_EVENT_FOR_LEFT = 30;					--遠方左エリア(slot0)
AI_EVENT_NEAR = 40;						--近距離正面エリア(slot0)

--ドラゴンデーモン～ウドの大木
AI_EVENT_PUNCH1 = 10;					--パンチ1(slot0)
AI_EVENT_PUNCH2 = 20;					--パンチ2(slot0)
AI_EVENT_PUNCH3 = 30;					--パンチ3(slot0)
AI_EVENT_PUNCH4 = 40;					--パンチ4(slot0)

AI_EVENT_BREATH1 = 50;					--ブレス1(slot0)
AI_EVENT_BREATH2 = 60;					--ブレス2(slot0)
AI_EVENT_BREATH3 = 70;					--ブレス3(slot0)
AI_EVENT_BREATH4 = 80;					--ブレス4(slot0)

AI_EVENT_BITEATTACK = 90;				--噛み付き攻撃(slot0)

--炎の怪人
AI_EVENT_REACTION = 10;					--炎の怪人リアクション(slot0)

--キメラ
AI_EVENT_KIMERA_TALE_CUT = 10;			--しっぽ切断(slot0)

--蛭デーモン
AI_EVENT_LEECH_REGENERATE = 10;			--OBJ再生可能(slot0)

--ビヨルングルム
AI_EVENT_HIRYU_GATE	= 10;				--飛竜がゲート前にいる(slot0)

--ムカデ
AI_EVENT_MUKADE_TALE_CUT = 1;			--しっぽ切断(slot0)
