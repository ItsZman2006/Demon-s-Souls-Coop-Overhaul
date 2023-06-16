
--バッドエンディング時のウェイト
BAD_END_WAIT = false;

--■徘徊デーモン用のID

demon_id_list_m01_00_00_00 = { 830 , 831 , 832};

hiroin_cancelAnimId = -1;

------------------------------------------------------------------------------------------
--■ヒロインの状態一覧--------------------------------------------------------------------
--■ヒロインの状態一覧--------------------------------------------------------------------
HEROINE_STATE_WAIT_FOR_PLAYER = 16140;--プレイヤーを待つ
HEROINE_STATE_WANT_TO_SETTLE  = 16141;--決着をつけたい
HEROINE_STATE_WITH_A_FUTURE   = 16142;--付いていきます
HEROINE_STATE_DOOR_FRONT		= 16143;--扉の前
HEROINE_STATE_DOOR_LEAVE		= 16144;--扉から去ろうかな？
HEROINE_STATE_PRAYER			= 16145;--祈っている
HEROINE_STATE_ISNOT				= 16146;--まだ居ない
heroine_flag_list = {
	HEROINE_STATE_WAIT_FOR_PLAYER ,
	HEROINE_STATE_WANT_TO_SETTLE  ,
	HEROINE_STATE_WITH_A_FUTURE		,
	HEROINE_STATE_DOOR_FRONT		,
	HEROINE_STATE_DOOR_LEAVE		,
	HEROINE_STATE_PRAYER,
	HEROINE_STATE_ISNOT
};


--ワープ監視
GO_TO_WARP_OUJOU 		= 16710;--王城へワープ
GO_TO_WARP_FURUTORIDE 	= 16711;--古砦へワープ
GO_TO_WARP_ROUJOU		= 16712;--牢城へワープ
GO_TO_WARP_FUJOU		= 16713;--不浄へワープ
GO_TO_WARP_KOUDOU		= 16714;--坑道へワープ
GO_TO_WARP_HOKUGEN		= 16715;--北限へワープ

warp_list ={
	GO_TO_WARP_OUJOU		,
	GO_TO_WARP_FURUTORIDE	,
	GO_TO_WARP_ROUJOU		,
	GO_TO_WARP_FUJOU		,
	GO_TO_WARP_KOUDOU		,
	GO_TO_WARP_HOKUGEN		,
}

------------------------------------------------------------------------------------------
--■ボードウィンの状態一覧----------------------------------------------------------------
--アクションID				
BALDWIN_STATE_WORK     = 16440--仕事中			
BALDWIN_STATE_HOSTILE  = 16441--敵対			
BALDWIN_STATE_DEAD     = 16442--死亡
BALDWIN_STATE_ISNOT    = 16443--まだいない

baldwin_flag_list = {
	BALDWIN_STATE_WORK   ,--仕事中			
	BALDWIN_STATE_HOSTILE,--敵対			
	BALDWIN_STATE_DEAD   ,--死亡
	BALDWIN_STATE_ISNOT	  --まだいない
};



------------------------------------------------------------------------------------------
--■要人の状態一覧----------------------------------------------------------------
--アクションID				
YOJIN_STATE_WAIT_FOR_PLAYER = 16270--プレイヤーを待つ			
YOJIN_STATE_LASTWORD        = 16271--最後の言葉を伝えよう			
YOJIN_STATE_DEAD            = 16272--死亡			

yojin_flag_list = {
	YOJIN_STATE_WAIT_FOR_PLAYER   ,--プレイヤーを待つ			
	YOJIN_STATE_LASTWORD          ,--最後の言葉を伝えよう			
	YOJIN_STATE_DEAD               --死亡
};





--■【魔術の徒】状態一覧--------------------------------------------------------------------
MAGIC_STUDENT_STATE_ROGARN_HELP		= 16290;
MAGIC_STUDENT_STATE_ROGARN_TOGETHER	= 16291;
MAGIC_STUDENT_STATE_FALL			= 16292;
MAGIC_STUDENT_STATE_ANGRY			= 16293;
MAGIC_STUDENT_STATE_DEAD			= 16294;
MAGIC_STUDENT_STATE_ISNOT			= 16295;
magic_student_flag_list = {
	MAGIC_STUDENT_STATE_ROGARN_HELP 	,
	MAGIC_STUDENT_STATE_ROGARN_TOGETHER ,
	MAGIC_STUDENT_STATE_FALL			,
	MAGIC_STUDENT_STATE_ANGRY			,
	MAGIC_STUDENT_STATE_DEAD			,
	MAGIC_STUDENT_STATE_ISNOT
};


------------------------------------------------------------------------------------------
--■【神の信徒1】状態一覧--------------------------------------------------------------------
GOD_BELIEVER_1_STATE_STONE_PILLAR	= 16300;--石柱にいる			
GOD_BELIEVER_1_STATE_URU			= 16301;--ウルさまと一緒			
GOD_BELIEVER_1_STATE_FALL			= 16302;--落胆
GOD_BELIEVER_1_STATE_ANGRY			= 16303;--敵対			
GOD_BELIEVER_1_STATE_DEAD			= 16304;--死亡	
GOD_BELIEVER_1_STATE_ISNOT			= 16305;--まだ居ない

god_beliver1_flag_list = {
	GOD_BELIEVER_1_STATE_STONE_PILLAR 	,
	GOD_BELIEVER_1_STATE_URU  			,
	GOD_BELIEVER_1_STATE_FALL			,
	GOD_BELIEVER_1_STATE_ANGRY			,
	GOD_BELIEVER_1_STATE_DEAD			,
	GOD_BELIEVER_1_STATE_ISNOT
};


------------------------------------------------------------------------------------------
--■【神の信徒2】状態一覧--------------------------------------------------------------------
GOD_BELIEVER_2_STATE_STONE_PILLAR	= 16310;--石柱にいる			
--GOD_BELIEVER_2_STATE_URU			= 16311;--ウルさまと一緒			
GOD_BELIEVER_2_STATE_FALL			= 16312;--落胆
GOD_BELIEVER_2_STATE_ANGRY			= 16313;--敵対			
GOD_BELIEVER_2_STATE_DEAD			= 16314;--死亡	
GOD_BELIEVER_2_STATE_ISNOT			= 16315;--まだ居ない
GOD_BELIEVER_2_STATE_ISNOTALREADY	= 16316;--すでに居ない
god_beliver2_flag_list = {
	GOD_BELIEVER_2_STATE_STONE_PILLAR 	,
	--GOD_BELIEVER_2_STATE_URU  		,
	GOD_BELIEVER_2_STATE_FALL			,
	GOD_BELIEVER_2_STATE_ANGRY			,
	GOD_BELIEVER_2_STATE_DEAD			,
	GOD_BELIEVER_2_STATE_ISNOT			,
	GOD_BELIEVER_2_STATE_ISNOTALREADY
};

------------------------------------------------------------------------------------------
--■【神の信徒3】状態一覧--------------------------------------------------------------------
GOD_BELIEVER_3_STATE_STONE_PILLAR	= 16320;--石柱にいる			
GOD_BELIEVER_3_STATE_URU			= 16321;--ウルさまと一緒			
GOD_BELIEVER_3_STATE_FALL			= 16322;--落胆
GOD_BELIEVER_3_STATE_ANGRY			= 16323;--敵対			
GOD_BELIEVER_3_STATE_DEAD			= 16324;--死亡			
god_beliver3_flag_list = {
	GOD_BELIEVER_3_STATE_STONE_PILLAR 	,
	GOD_BELIEVER_3_STATE_URU  			,
	GOD_BELIEVER_3_STATE_FALL			,
	GOD_BELIEVER_3_STATE_ANGRY			,
	GOD_BELIEVER_3_STATE_DEAD
};

------------------------------------------------------------------------------------------
--■【メフィスト】状態一覧--------------------------------------------------------------------
MEFIST_STATE_NO_STAY					= 16390;--まだいない
MEFIST_STATE_STONE_PILLAR				= 16391;--石柱にいる
MEFIST_STATE_ANGRY						= 16392;--敵対
MEFIST_STATE_DEAD						= 16393;--死亡			
MEFIST_STATE_KILL_WAIT_RENDOL			= 16394;--王子殺害待ち			
MEFIST_STATE_KILL_WAIT_BIYO				= 16395;--ビヨ殺害待ち
MEFIST_STATE_KILL_WAIT_ROGARN			= 16396;--ロガーン殺害待ち			
MEFIST_STATE_KILL_WAIT_MAJO				= 16397;--魔女殺害待ち
MEFIST_STATE_KILL_WAIT_URU				= 16398;--ウルベイン殺害待ち
MEFIST_STATE_KILL_WAIT_TOMASU			= 16399;--トマス殺害待ち
MEFIST_STATE_KILL_WAIT_BATTI			= 16400;--バッチ殺害待ち
mefist_flag_list = {
	MEFIST_STATE_NO_STAY 			,
	MEFIST_STATE_STONE_PILLAR  		,
	MEFIST_STATE_ANGRY  			,
	MEFIST_STATE_DEAD  				,
	MEFIST_STATE_KILL_WAIT_RENDOL  	,
	MEFIST_STATE_KILL_WAIT_BIYO  	,
	MEFIST_STATE_KILL_WAIT_ROGARN  	,
	MEFIST_STATE_KILL_WAIT_MAJO		,
	MEFIST_STATE_KILL_WAIT_URU		,
	MEFIST_STATE_KILL_WAIT_TOMASU	,
	MEFIST_STATE_KILL_WAIT_BATTI
};

------------------------------------------------------------------------------------------
--■【大袋のトマス】状態一覧--------------------------------------------------------------------
TOMASU_STATE_WAIT					= 16350;--荷物番
TOMASU_STATE_ANGRY					= 16351;--敵対
TOMASU_STATE_DEAD					= 16352;--死亡
TOMASU_STATE_ISNOT					= 16353;--まだいない
tomasu_flag_list = {
	TOMASU_STATE_WAIT			,
	TOMASU_STATE_ANGRY			,
	TOMASU_STATE_DEAD			,
	TOMASU_STATE_ISNOT
};

------------------------------------------------------------------------------------------
--■【心折れた戦士】状態一覧--------------------------------------------------------------------
HEART_BREAK_FIGHTER_STATE_STONE_PILLAR	= 16420;--石柱にいる
HEART_BREAK_FIGHTER_STATE_ANGRY			= 16421;--敵対
HEART_BREAK_FIGHTER_STATE_DEAD			= 16422;--死亡
HEART_BREAK_FIGHTER_STATE_MAYBE_DELETE	= 16423;--消えそう
HEART_BREAK_FIGHTER_STATE_DELETE		= 16424;--消えます
heartbreak_fighter_flag_list = {
	HEART_BREAK_FIGHTER_STATE_STONE_PILLAR 	,
	HEART_BREAK_FIGHTER_STATE_ANGRY  		,
	HEART_BREAK_FIGHTER_STATE_DEAD			,
	HEART_BREAK_FIGHTER_STATE_MAYBE_DELETE	,
	HEART_BREAK_FIGHTER_STATE_DELETE
};





--■ルアー内変数　初期化のタイミングでクリアブロック数などを格納して、使いまわす
ClearBlockCount = 0;				--クリアしているブロックの数
IsLast = false;						--石柱の奥に進める条件を満たしているか？

--[[削除とのことなので、コメントアウト
--■ハーフハンドの状態一覧

HALF_STATE_WAIT_KOUDOU     = 16160;--坑道で待つ
HALF_STATE_WAIT_SEKITYU    = 16161;--石柱で待つ
HALF_STATE_HOSTILE_KOUDOU  = 16162;--敵対(坑道)
HALF_STATE_HOSTILE_SEKITYU = 16163;--敵対(石柱)
HALF_STATE_DEAD            = 16164;--死亡
HALF_STATE_GO_TO_SEKITYU   = 16165;--石柱へ行きたい

half_flag_list = {

	HALF_STATE_WAIT_KOUDOU     ,
	HALF_STATE_WAIT_SEKITYU    ,
	HALF_STATE_HOSTILE_KOUDOU  ,
	HALF_STATE_HOSTILE_SEKITYU ,
	HALF_STATE_DEAD            ,
	HALF_STATE_GO_TO_SEKITYU
};

------------------------------------------------------------------------------------------
--■物識りの状態一覧--------------------------------------------------------------------
--アクションID				
MONOSHIRI_STATE_ISNOT    = 16340--まだいない			
MONOSHIRI_STATE_BUSINESS = 16341--情報売るよ			
MONOSHIRI_STATE_HOSTILE  = 16342--敵対			
MONOSHIRI_STATE_DEAD     = 16343--死亡			

monoshiri_flag_list = {
	MONOSHIRI_STATE_ISNOT   ,--まだいない			
	MONOSHIRI_STATE_BUSINESS,--情報売るよ			
	MONOSHIRI_STATE_HOSTILE ,--敵対			
	MONOSHIRI_STATE_DEAD     --死亡
};

]]
--------------------------------------------------------------------------------------
--マップ読み込み時に読まれる初期化処理■
--------------------------------------------------------------------------------------
function Initialize_m01_00_00_00(proxy)
	print("Initialize_m01_00_00_00 begin");
	
	--QWCの更新要求
	proxy:RecvGlobalQwc();
	
	--石柱に限り、死体再現はされません（ＮＰＣは結局消えるので再現も何もない）
	proxy:AddFieldInsFilter(611);-- 心折れた戦士
	proxy:AddFieldInsFilter(613);-- 要人
	proxy:AddFieldInsFilter(615);-- ヒロイン
	proxy:AddFieldInsFilter(617);-- 賢者ロガーン
	proxy:AddFieldInsFilter(619);-- 沈黙の長、ユルト
	proxy:AddFieldInsFilter(680);-- メフィストフェレス
	proxy:AddFieldInsFilter(681);-- 魔術の徒
	proxy:AddFieldInsFilter(682);-- 神の信徒その1
	proxy:AddFieldInsFilter(683);-- 神の信徒その2
	proxy:AddFieldInsFilter(684);--神の信徒その3
	proxy:AddFieldInsFilter(687);-- 大袋のトマス
	proxy:AddFieldInsFilter(688);-- レンドル王子
	proxy:AddFieldInsFilter(689);-- 魔女
	proxy:AddFieldInsFilter(690);-- ウルベイン
	proxy:AddFieldInsFilter(693);-- パッチ
	proxy:AddFieldInsFilter(694);-- 鍛冶屋ボールドウィン
	proxy:AddFieldInsFilter(695);-- ビヨルングリム
	proxy:AddFieldInsFilter(821);-- デモンズソウルを護るもの
	
	
	--クリア状況がGOODでエリアを通した
	if proxy:IsCompleteEvent( 510 ) == false then 
		if proxy:GetClearState() == CLEAR_STATE_GOODEND then
			proxy:OnKeyTime2( 510 , "OnEvent_510" , 1.0,0,0,once);			
		end
	end

	--クリアしているエリアの数を取得
	local areaclear_actionId_list = {8010, 8011, 8012, 8013, 8014};
	local areaclear_actIdNum = table.getn(areaclear_actionId_list);
	for index = 1, areaclear_actIdNum, 1 do
		if proxy:IsCompleteEvent( areaclear_actionId_list[index] ) == true then
			ClearBlockCount = ClearBlockCount + 1;
		end
	end
	
	--全エリアをクリアしているか？
	if areaclear_actIdNum == ClearBlockCount then
		IsLast = true;
	end
	
	--クリア数が１以上なら王城門の開放フラグはON
	if proxy:GetClearCount() > 0 then
		print("王城門開放準備OK");
		proxy:SetEventFlag(8035,true);
		if proxy:IsInventoryEquip(TYPE_GOODS,9995) == true then
			print("黒い瞳の石を持っている");
			proxy:SetEventFlag( 15500 , true );
		else
			print("黒い瞳の石は持っていない");
		end
	end

	--各ボスの倒した数を取得(各マップでもやってはいるが、念のためにもう一度判定)
	GetBossFlagCount( proxy, param );
	
	--2008.05.16/toyohide
	--取り合えず情報屋追加
	if boss_flagCount >= 1 then
		print("Add InfoId 16");
		proxy:SetEnableInfoStateForEvent(16,true);
		print("Add InfoId 17");
		proxy:SetEnableInfoStateForEvent(17,true);
	end

--------------------------------------------------------------------------------
--各エリアワープ関連
--------------------------------------------------------------------------------
	SingleReset(proxy,0);
--■0■各エリアへワープ(王城)■
	proxy:OnDistanceAction(    0, 10000, 1000, "OnEvent_0"   , WarpGimmickDist_A, HELPID_CHECK_OUJOU,        180, WarpGimmickAngle_A, everytime );

	SingleReset(proxy,1);
--■1■各エリアへワープ(古砦)■
	proxy:OnDistanceAction(    1, 10000, 1001, "OnEvent_1"   , WarpGimmickDist_A, HELPID_CHECK_HURUTORIDE  , 180, WarpGimmickAngle_A, everytime );
	
	SingleReset(proxy,2);
--■2■各エリアへワープ(牢城)■
	proxy:OnDistanceAction(    2, 10000, 1002, "OnEvent_2"   , WarpGimmickDist_A, HELPID_CHECK_ROUJOU,       180, WarpGimmickAngle_A, everytime );	

	SingleReset(proxy,3);
--■3■各エリアへワープ(不浄)■
	proxy:OnDistanceAction(    3, 10000, 1003, "OnEvent_3"   , WarpGimmickDist_A, HELPID_CHECK_HUJOU,        180, WarpGimmickAngle_A, everytime );

	SingleReset(proxy,4);
--■4■各エリアへワープ(坑道)■
	proxy:OnDistanceAction(    4, 10000, 1004, "OnEvent_4"   , WarpGimmickDist_A, HELPID_CHECK_KOUDOU,       180, WarpGimmickAngle_A, everytime );

--■5■各エリアへワープ(北限)■
	--proxy:OnDistanceAction(    5, 10000, 1005, "OnEvent_5"   , WarpGimmickDist_A, HELPID_CHECK_HOKUGEN,      180, WarpGimmickAngle_A, everytime );

--■8083■ワープして戻ってきた■
	--各マップの要石でのワープ時に、フラグを立てる。
	--戻ってきた判定のフラグを立てる
	--proxy:SetEventFlag(8083, true);

--■8084■王城に行った事がある■
	--王城でのInitにて、フラグを立てる。
--■8085■古砦に行った事がある■
	--古砦でのInitにて、フラグを立てる。
--■8086■牢城に行った事がある■
	--牢城でのInitにて、フラグを立てる。
--■8087■不浄に行った事がある■
	--不浄でのInitにて、フラグを立てる。
--■8088■坑道に行った事がある■
	--坑道でのInitにて、フラグを立てる。
	
--------------------------------------------------------------------------------
--ラスボス関連
--------------------------------------------------------------------------------
--■40■ラスボス部屋に行くまでの飛び降り、ポリ劇■(会話システムから呼び出し)
--test
--proxy:LuaCall(40,2000,"OnEvent_40_RemoStart",everytime);
--proxy:LuaCall(40,2001,"OnEvent_40_RemoFinish",once);
	if proxy:IsCompleteEvent( 40 ) == false then
		
		proxy:LuaCall( 40 , 0 , "OnEvent_40" , everytime );
		
		proxy:NotNetMessage_begin();
			--ポリ劇開始フェード後に呼ばれるハンドラ
			proxy:LuaCall(40,REMO_START,"OnEvent_40_RemoStart",once);
			--ポリ劇終了後に呼ばれるハンドラ
			proxy:LuaCall(40,REMO_FINISH,"OnEvent_40_RemoFinish",once);
		proxy:NotNetMessage_end();
		
		--要石見えない
		proxy:SetColiEnable(1140,false);
		proxy:SetDrawEnable(1140,false);
		
		proxy:SetColiEnable(1141,false);
		proxy:SetDrawEnable(1141,false);
		
	else--ラスボスポリ劇終了していたら
		--proxy:TreasureDispModeChange2( 1140 , true ,KANAME_SFX);
		proxy:TreasureDispModeChange2( 1141 , true ,KANAME_SFX);
		
		--proxy:TreasureDispModeChange2( 1145 , true ,KANAME_SFX);
		proxy:TreasureDispModeChange2( 1146 , true ,KANAME_SFX);
		SingleReset(proxy,42);
		SingleReset(proxy,43);
		if proxy:IsCompleteEvent( 70 ) == false then
			proxy:OnDistanceAction( 42,10000,1140,"OnEvent_42",WarpGimmickDist_A,HELPID_GO_TO_SEKITYUU,0,WarpGimmickAngle_B,everytime);
		end
		proxy:OnDistanceAction( 43,10000,1145,"OnEvent_43",WarpGimmickDist_A,HELPID_GO_TO_SEKITYUU,0,WarpGimmickAngle_B,everytime);		
	end
	
	--[[
--■60■拡散のモノが屈み込むポリ劇■
	if proxy:IsCompleteEvent( 60 ) == false then
		proxy:OnRegionJustIn( 60 , 10000 , 2040 , "OnEvent_60" , once );
		
		proxy:NotNetMessage_begin();
			--ポリ劇開始フェード後に呼ばれるハンドラ
			proxy:LuaCall(60,REMO_START,"OnEvent_60_RemoStart",once);
			--ポリ劇終了後に呼ばれるハンドラ
			proxy:LuaCall(60,REMO_FINISH,"OnEvent_60_RemoFinish",once);
		proxy:NotNetMessage_end();
	end
	]]
	
--■70■ラスボスを倒したら、ソウル入手■	
	if proxy:IsCompleteEvent( 70 ) == false then
		proxy:OnCharacterDead( 70 , 821 , "OnEvent_70" , once );
		proxy:CustomLuaCall( 450 , "OnEvent_450" , once );
	else
		proxy:SetEventFlag( 450 , true );
		InvalidBackRead( proxy, 821 );
		--ヒロインを移動させる
		LuaFunc_ForceOmission(proxy,615);	
		proxy:SetAlwayEnableBackread_forEvent( 615 , true );
		proxy:SetDisableGravity( 615,true );
	end

--■71■ラスボスを倒したら、ポリ劇を再生■
	if proxy:IsCompleteEvent( 71 ) == false then
		proxy:OnRegionIn( 71 , 10000 , 2082 , "OnEvent_71" , everytime );
		--proxy:LuaCall(71, 0, "OnEvent_71", once);--ポリ劇再生要求ハンドラ登録		
		proxy:NotNetMessage_begin();
			--ポリ劇開始フェード後に呼ばれるハンドラ
			proxy:LuaCall(71,REMO_START,"OnEvent_71_RemoStart",once);
			--ポリ劇終了後に呼ばれるハンドラ
			proxy:LuaCall(71,REMO_FINISH,"OnEvent_71_RemoFinish",once);
		proxy:NotNetMessage_end();
	else
		--▼ヒロインへのダメージ監視(エンディング1用)▼Bad End
		--proxy:OnSimpleDamage( 80 , 615 , 10000 , "OnEvent_80" , once );
		proxy:OnCharacterDead( 80 , 615 , "OnEvent_80",once);
	
		proxy:NotNetMessage_begin();
			--ポリ劇開始フェード後に呼ばれるハンドラ
			proxy:LuaCall(80,REMO_START,"OnEvent_80_RemoStart",once);
			--ポリ劇終了後に呼ばれるハンドラ
			proxy:LuaCall(80,REMO_FINISH,"OnEvent_80_RemoFinish",once);
		proxy:NotNetMessage_end();
	
		--▼領域監視を追加(エンディング2用)▼Good End
		local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;
		proxy:OnPlayerActionInRegionAttribute( 81, 2010, "OnEvent_81", 10010405, possible_chr_type, once );
	
		proxy:NotNetMessage_begin();
			--ポリ劇開始フェード後に呼ばれるハンドラ
			proxy:LuaCall(81,REMO_START,"OnEvent_81_RemoStart",once);
			--ポリ劇終了後に呼ばれるハンドラ
			proxy:LuaCall(81,REMO_FINISH,"OnEvent_81_RemoFinish",once);
		proxy:NotNetMessage_end();	
	end
	
--■75■ラスボス死体を調べた■	
	proxy:AddCorpseEvent( 75 , 821 );
	proxy:LuaCall( 75 , 0 , "OnEvent_75",once);

--■61■ボス部屋に入る■	
	--中ボスが生きているときだけイベント登録
	if proxy:IsCompleteEvent( 70 ) == false then	

		--ソロのときは一度目にボス部屋に入る用のイベントを毎回登録させたいので、対応するフラグをOFFにする。
		SingleReset(proxy, 61);

		--▽同期アニメ再生用の開始ハンドラ(旋回→歩き)
		proxy:LuaCall( 61, 1, "OnEvent_61_1", everytime );		

		--(セッション中に)ボス前の魔法壁を最初に通れるのは生存の人だけ
		local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;			

		proxy:NotNetMessage_begin();
			--▼61▼扉が開いているときに中に入るためのイベントを追加▼
			proxy:OnPlayerActionInRegionAttribute( 61, 2895, "OnEvent_61", HELPID_GO_TO_IN, possible_chr_type, once );
		proxy:NotNetMessage_end();
		
		--ソウルブランド非表示
		proxy:SetDrawEnable( 1130 , false );--ひとまず描画だけOFF
		proxy:SetColiEnable( 1130 , false );
		proxy:InvalidSfx( 1131 ,false );

	end	

--■62■ボスが死んだときの初期化■
	if proxy:IsCompleteEvent( 70 ) == true then
		InvalidCharactor( proxy, 821 );
		proxy:SetEventFlag( 62, true );
		proxy:OnDistanceAction( 44,10000,1140,"OnEvent_44",WarpGimmickDist_A,HELPID_GO_TO_SEKITYUU,0,WarpGimmickAngle_B,everytime);
		
		--ソウルブランド抜いてない
		if proxy:IsCompleteEvent( 141 ) == false then			
			--調べるイベント自体は同期します、調べれる人はホストorシングルプレイヤーです
			--proxy:NotNetMessage_begin();
				--ホスト、生存、グレイのみ調べることができる
				local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;				
				proxy:OnDistanceActionAttribute( 141 , LOCAL_PLAYER , 1130 , "OnEvent_141" , ItemBoxDist_A , 10010135 , 0 , ItemBoxAngle_A ,possible_chr_type, everytime ); 
				proxy:LuaCall( 141,1,"OnEvent_141_2",once);
				proxy:LuaCall( 141,2,"OnEvent_141_3",once);
				proxy:TreasureDispModeChange2( 1130, true ,KEN_SFX);
				--proxy:SetRarity( 1130, 10104 );
			--proxy:NotNetMessage_end();
		else
			proxy:SetDrawEnable( 1130 , false );--ひとまず描画だけOFF
			proxy:SetColiEnable( 1130 , false );	
			proxy:InvalidSfx( 1131 , false );			
		end
	end
	
--■魔方陣解除のポリ劇■
	if proxy:IsCompleteEvent( 39 ) == true then
		proxy:SetDrawEnable( 1190 , false );--剣OBJ表示OFF
		proxy:SetColiEnable( 1190 , false );--剣OBJアタリOFF
		
		proxy:SetDrawEnable( 1200 , false );--魔方陣1OBJ表示OFF
		proxy:SetColiEnable( 1200 , false );--魔方陣1OBJアタリOFF
		proxy:SetDrawEnable( 1201 , false );--魔方陣2OBJ表示OFF
		proxy:SetColiEnable( 1201 , false );--魔方陣2OBJアタリOFF
		proxy:SetDrawEnable( 1202 , false );--魔方陣3OBJ表示OFF
		proxy:SetColiEnable( 1202 , false );--魔方陣3OBJアタリOFF
		proxy:SetDrawEnable( 1203 , false );--魔方陣4OBJ表示OFF
		proxy:SetColiEnable( 1203 , false );--魔方陣4OBJアタリOFF	
		proxy:SetEventResponsedNavimeshFlag_Disable();
	end
	
--■拡散のモノが屈み込むポリ劇■

	if proxy:IsCompleteEvent( 40 ) == false then
		
		--マップパーツを無効化する
		proxy:SetDrawEnableArray( 1020 , false );--表示OFF
		proxy:SetColiEnableArray( 1020 , false );--当たりOFF
		
		proxy:SetDrawEnableArray( 1121 , false );--表示OFF
		proxy:SetColiEnableArray( 1121 , false );--当たりOFF
		
		--木のオブジェを無効化する
		local first_id = 1030;
		local last_id  = 1058;
		local now_id   = first_id;
		local num      = last_id - first_id + 1;
		
		for i=1 , num , 1 do
			proxy:SetDrawEnable( now_id , false );--表示OFF
			proxy:SetColiEnable( now_id , false );--当たりOFF
			now_id = now_id + 1;
		end	
		
		--対応する敵を無効化する
		--削除
		
		--ボスを無効化
		InvalidCharactor( proxy , 821 );
		
		--SFXを無効化
		proxy:InvalidSfx( 1110 , false );--RootEraseしない
		
	else	
		--OBJを無効化
		proxy:SetDrawEnable( 1100 , false );
		proxy:SetColiEnable( 1100 , false );
		
		proxy:SetDrawEnableArray( 1120 , false );--表示OFF
		proxy:SetColiEnableArray( 1120 , false );--当たりOFF
		
		--SFXを無効化
		--proxy:InvalidSfx( 1110 , false );
	end
--■72■ラスボスの声１■
	if proxy:IsCompleteEvent( 70 ) == false then
		SingleReset( proxy ,72 );
		--proxy:SetEventFlag( 61 , true );--ボス部屋イベントを一時的に無効か
		proxy:OnRegionJustIn( 72 , 10000 , 2080 , "OnEvent_72",once);
		proxy:RegistSimpleTalk( 72 , 821 , 28500 , TALK_ATTR_ALL-TALK_ATTR_REPEAT);
	end
	
--■73■ラスボスの声２■
	if proxy:IsCompleteEvent( 70 ) == false then
		SingleReset( proxy ,73 );
		proxy:OnRegionJustIn( 73 , 10000 , 2081 , "OnEvent_73",once);
	end
--[[処理の順番上うまくいかない。 明日。
--■70■ラスボスを倒したら、ポリ劇を再生■
	if proxy:IsCompleteEvent( 70 ) == true then
		proxy:ForceDead( 821 );
		OnEvent_70_RemoFinish(proxy, param);--対応するポリ劇終了時に呼ばれるハンドラを呼ぶ。
	end
]]

--------------------------------------------------------------------------------
--ギミック関連
--------------------------------------------------------------------------------
--■20■徘徊デーモンの登場■ハンドラ登録
	proxy:NotNetMessage_begin();
		--プレイヤーがソロで死亡した時にキックされます。
		proxy:LuaCall( 4000, 100, "PlayerDeath_m01_00_00_00", everytime );
		--プレイヤーが復活した時にキックされます。
		proxy:LuaCall( 4032, 100, "PlayerRevive_m01_00_00_00", everytime );
	proxy:NotNetMessage_end();

	--■徘徊デーモン用
	if proxy:IsCompleteEvent( 20 ) == true then
		LuaFunc_VisibleTheWanderingDemon  (proxy, param, demon_id_list_m01_00_00_00);
		proxy:SetEventFlag(20,false);
	else
		LuaFunc_InvisibleTheWanderingDemon(proxy, param, demon_id_list_m01_00_00_00);
	end
--BGM再生関連--------------------------------------------------------------------------------
	--ポリ劇を見た事があれば
	if proxy:IsCompleteEvent( 30 ) == true		--マップ紹介ポリ劇が再生済み　かつ
	and proxy:IsCompleteEvent( 31 ) == true then--復活ポリ劇が再生済み　ならば
		--最後で　最後へのポリ劇が終わってない場合はは何もしない
		if IsLast == true and  proxy:IsCompleteEvent( 39 ) == false then
			--何もしない
		else
			--マップのクリア数によって、再生するBGMを中で変更して再生
			proxy:OnKeyTime2( 30 , "PlayBGM_SEKITYUU" , 0.1,0,0,once);
			--PlayBGM_SEKITYUU(proxy, param);
			print("☆石柱BGM再生");
		end		
	end
--■422■BGM再生3(ラスボス戦)■
	if proxy:IsCompleteEvent( 70 ) == false then
		SingleReset(proxy, 422);
		proxy:EnableLogic( 821, false );
		proxy:RepeatMessage_begin();
			proxy:OnRegionIn(422,10000,2061,"OnEvent_422",everytime);--領域への監視登録
		proxy:RepeatMessage_end();
	end

	--proxy:CreateSpreadBeast( 1100, 1101 );
---------------------------------------------------------------------------------------------
	
--■30■マップ紹介ポリ劇再生■
	if proxy:IsCompleteEvent( 30 ) == false then		
		proxy:NotNetMessage_begin();
			--ポリ劇開始フェード後に呼ばれるハンドラ
			proxy:LuaCall(30,REMO_START,"OnEvent_30_RemoStart",once);
			--ポリ劇終了後に呼ばれるハンドラ
			proxy:LuaCall(30,REMO_FINISH,"OnEvent_30_RemoFinish",once);
		proxy:NotNetMessage_end();
		
		OnEvent_30(proxy,param);
		--proxy:OnKeyTime2( 30 , "OnEvent_30" , 0.0 , 0 , 1 , once );
	else
		if proxy:IsCompleteEvent( 37 ) == false then
			if proxy:GetClearCount() == 0 then		
				proxy:OnKeyTime2( 32 , "OnEvent_32",0.1,0,0,once);
			end
		end
		
		--■31■復活ポリ劇■
		if proxy:IsCompleteEvent( 31 ) == false then
			--ファランクス撃破済み
			if proxy:IsCompleteEvent( 4096 ) == true then
				proxy:NotNetMessage_begin();
					--ポリ劇開始フェード後に呼ばれるハンドラ
					proxy:LuaCall(31,REMO_START,"OnEvent_31_RemoStart",once);
					--ポリ劇終了後に呼ばれるハンドラ
					proxy:LuaCall(31,REMO_FINISH,"OnEvent_31_RemoFinish",once);
				proxy:NotNetMessage_end();
				OnEvent_31(proxy,param);
			else
				--ファランクスを倒さずに石柱へ戻ってきたので、BGM再生
				proxy:OnKeyTime2( 31 , "PlayBGM_SEKITYUU" ,0.1 , 0 , 1 ,once);
				--PlayBGM_SEKITYUU(proxy, param);
				print("■石柱BGM再生");
			end
		else
			--最後への解放ポリ劇を見ていない
			if proxy:IsCompleteEvent( 39 ) == false and IsLast == true then
				proxy:NotNetMessage_begin();
					--ポリ劇開始フェード後に呼ばれるハンドラ
					proxy:LuaCall( 39 , REMO_START,"OnEvent_39_RemoStart",once);
					--ポリ劇終了時に呼ばれるハンドラ
					proxy:LuaCall( 39 , REMO_FINISH, "OnEvent_39_RemoFinish",once);
				proxy:NotNetMessage_end();
				OnEvent_39(proxy,param);				
			end
		end
	end
	


--■303■要人からの昔話■
	proxy:NotNetMessage_begin();
		proxy:LuaCall( 303,0,"OnEvent_303",once);--ムービー再生用の会話呼び出しハンドラ
	proxy:NotNetMessage_end();
	
--■34■要石の封印の開放■
	proxy:NotNetMessage_begin();
		proxy:LuaCall(34, 0, "OnEvent_34", once);--要人ムービー後の会話呼び出しされるハンドラ
	proxy:NotNetMessage_end();
	
--■304■ヒロインからアイテムを貰う■
	proxy:NotNetMessage_begin();
		proxy:LuaCall(304,0,"OnEvent_304",once);
	proxy:NotNetMessage_end();
--■305■要人からアイテムを貰う■
	proxy:NotNetMessage_begin();
		proxy:LuaCall(305,0,"OnEvent_305",once);
	proxy:NotNetMessage_end();
	
--■80■エンディングポリ劇1■
	--(OnEvent_71の終了後に追加)
	
--■81■エンディングポリ劇2■
	--(OnEvent_71の終了後に追加)

--■140■死体に刺さっている剣■
	--if proxy:IsCompleteEvent( 140 ) == false then
		---ホスト、生存、グレイのみ調べることができる
		--local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;
		
		--proxy:OnDistanceActionAttribute( 140 , 10000 , 1130 , "OnEvent_140" , ItemBoxDist_A , 10010135 , 0 , ItemBoxAngle_A ,possible_chr_type, once ); 
		--proxy:LuaCall( 140,1,"OnEvent_140_2",once);
	--else
		--proxy:SetDrawEnable( 1130 , false );--ひとまず描画だけOFF	
		--proxy:InvalidSfx(1130, false);
	--end
	
	--proxy:TreasureDispModeChange( 1130, true );
	--proxy:SetRarity( 1130, 10730 );
	
--■要人への扉が開いている
	if	boss_flagCount >= 1 then
		--proxy:PlayAnimation( 1111, 1 );
		proxy:SetColiEnable( 1111, false );
		proxy:SetDrawEnable( 1111, false );
		proxy:InvalidSfx(2071, false);
	end
	
--------------------------------------------------------------------------------
--NPC関連
--------------------------------------------------------------------------------
--[[▼ヒロイン関連▼]]--------------------------------------------------------------

--■100■ヒロインが最後の戦いを決意する■
	--(Second_Initializeで判定後、追加)
	

--■90,91■ＰＣがヒロインの前で跪く■(会話システムから呼び出し)
	proxy:LuaCall( 90 , 0 , "OnEvent_90" , everytime );
	proxy:LuaCall( 91 , 0 , "OnEvent_91" , everytime );
	
--会話から呼ばれるハンドラ
	proxy:LuaCall( 110, 0, "OnEvent_110", everytime );
--■113■ヒロインを立ち上がらせる■(会話システムから呼び出し)
	proxy:LuaCall( 113, 0, "OnEvent_113", everytime );

--■111■ヒロイン死亡監視■	
	proxy:RepeatMessage_begin();
		proxy:SetEventFlag( 115 , false );	
		proxy:OnCharacterDead(111, 615, "OnEvent_111", once);
		--proxy:OnCharacterHP( 111 , 615 , "OnEvent_111",0.0,once);
	proxy:RepeatMessage_end();
	
	--初期状態をセット(状態が未設定の場合、指定した状態をセットする)
	SetFirstNpcStateFlag( proxy , param , heroine_flag_list , HEROINE_STATE_ISNOT );

	--ヒロインがまだ居ない
	if proxy:IsCompleteEvent( HEROINE_STATE_ISNOT ) == true then
		if boss_flagCount >= 1 then--1体以上倒していたら
			SetNpcStateFlag(proxy,param, heroine_flag_list , HEROINE_STATE_WAIT_FOR_PLAYER );
		else
			--ヒロインが消える
			InvalidBackRead( proxy , 615 );
		end
	end
	
--~ 	--ヒロインが扉の前に移動している
--~ 	if proxy:IsCompleteEvent( HEROINE_STATE_WAIT_FOR_PLAYER ) == true then
--~ 		if boss_flagCount >= 1 then--１体以上倒していたら
--~ 			--会話を終らせていない場合は何度も
--~ 			if	proxy:IsCompleteEvent(110) == false then
--~ 				SetNpcStateFlag(proxy, param, heroine_flag_list, HEROINE_STATE_DOOR_FRONT );
--~ 				proxy:SetAlwayEnableBackread_forEvent( 615 , true );
--~ 				--ヒロインの強制バックリードを無効化
--~ 				--proxy:OnKeyTime2( 40,"OnEvent_40_1",0,0,2,once);
--~ 			end
--~ 		end
--~ 	end
	
	--ヒロインが扉の前から去る
	if	IsLast == true then
		if	proxy:IsCompleteEvent(HEROINE_STATE_WAIT_FOR_PLAYER) 	== true then--or
--~ 			proxy:IsCompleteEvent(HEROINE_STATE_DOOR_FRONT) 		== true or
--~ 			proxy:IsCompleteEvent(HEROINE_STATE_DOOR_LEAVE) 		== true then
			SetNpcStateFlag(proxy, param, heroine_flag_list, HEROINE_STATE_WANT_TO_SETTLE );
			proxy:SetAlwayEnableBackread_forEvent( 615 , true );
			--ヒロインの強制バックリードを無効化
			--proxy:OnKeyTime2( 40,"OnEvent_40_1",0,0,3,once);
		end
--~ 	else
--~ 		if	proxy:IsCompleteEvent(HEROINE_STATE_DOOR_LEAVE) == true then
--~ 			SetNpcStateFlag(proxy, param, heroine_flag_list, HEROINE_STATE_WAIT_FOR_PLAYER );
--~ 			proxy:SetAlwayEnableBackread_forEvent( 615 , true );
--~ 			--ヒロインの強制バックリードを無効化
--~ 			--proxy:OnKeyTime2( 40,"OnEvent_40_1",0,0,4,once);
--~ 		end
	end


	if proxy:IsCompleteEvent(HEROINE_STATE_WANT_TO_SETTLE) == true then
		--予約
		--位置あわせ
		proxy:Warp( 615 , 2205 );
	elseif proxy:IsCompleteEvent(HEROINE_STATE_WAIT_FOR_PLAYER) == true then		
		if proxy:IsCompleteEvent( 4096 ) == true then
			--アイテムもらう会話終わっている
			if proxy:IsCompleteEvent( 304 ) == false then
				--ヒロイン座標あわせ
				proxy:Warp( 615 , 2206 );
				proxy:SetSpStayAndDamageAnimId( 615 , -1 , -1 );
			else
				--位置あわせ
				Lua_SetHeroinPos(proxy,param);
			end
		else
			--位置あわせ
			Lua_SetHeroinPos(proxy,param);
		end
	elseif proxy:IsCompleteEvent(HEROINE_STATE_WITH_A_FUTURE) == true then
		proxy:Warp( 615, 2001 );
		proxy:ChangeThink( 615, 10 );
		proxy:ResetThink( 615 );
		proxy:ChangeInitPosAng( 615, 2001 );
		--ヒロインのロジック切り替え →「祈る？」
		proxy:SendEventRequest( 615 , 0 , AI_EVENT_GRACE);
		proxy:SetAlwayEnableBackread_forEvent( 615 , true );
		--ヒロインの強制バックリードを無効化
		--proxy:OnKeyTime2( 40,"OnEvent_40_1",0,0,5,once);
	elseif proxy:IsCompleteEvent(HEROINE_STATE_DOOR_FRONT) == true then
		--位置あわせ
		--Lua_SetHeroinPos(proxy,param);
		--proxy:Warp( 615, 2003 );
		--proxy:ChangeInitPosAng( 615, 2003 );
	elseif proxy:IsCompleteEvent(HEROINE_STATE_PRAYER) == true then--祈り
		--■153■祈り状態初期化■
		--ヒロインを移動させる
		LuaFunc_ForceOmission(proxy,615);
		proxy:Warp( 615 , 2002 );--ヒロインを所定の位置にワープ
		proxy:SetHp( 615 , 1.0 );--ヒロインHP全快
		proxy:EnableLogic( 615 , false );--ロジックOFF
		
		proxy:SetEventCommand( 615 , 70 );--EzStateに制御番号(祈る)を送る
		proxy:SetAlwayEnableBackread_forEvent( 615 , true );
		--ヒロインの強制バックリードを無効化
		--proxy:OnKeyTime2( 40,"OnEvent_40_1",0,0,6,once);
	end
	
	
--▲ヒロイン関連▲-----------------------------

--[[▼ロガーン関連▼]]-----------------------------
	SetFirstNpcStateFlag( proxy , param , rogarn_flag_list , ROGARN_STATE_PRISONER );--状態が無ければ囚人にする
	
	if	proxy:IsCompleteEvent( ROGARN_STATE_WAIT ) == true and
		IsLast == true then
		SetNpcStateFlag( proxy, param, rogarn_flag_list, ROGARN_STATE_LAST_WARD );
	end
	if	proxy:IsCompleteEvent( ROGARN_STATE_GO_M1 ) == true then
		SetNpcStateFlag( proxy, param, rogarn_flag_list, ROGARN_STATE_WAIT );
	end
	
	if	proxy:IsCompleteEvent( ROGARN_STATE_WAIT ) == true or--待ちの時　か
		proxy:IsCompleteEvent( ROGARN_STATE_ANGRY_M1 ) == true or--敵対の時　か
		proxy:IsCompleteEvent( ROGARN_STATE_LAST_WARD ) == true then--最後の言葉の時に
		
		if	proxy:IsCompleteEvent( ROGARN_STATE_ANGRY_M1 ) == false then--敵対ではない時
			--proxy:OnCharacterTotalDamage( 221, 617, 10000, 100, "OnEvent_221", once );--ダメージ監視追加
			proxy:OnCharacterTotalRateDamage( 221, 617, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_221", once );
			
		end
		--上記の状態の時に、死亡監視追加
		proxy:OnCharacterDead( 222, 617, "OnEvent_222", once );
		
		proxy:SetEventFlag( 224, false );
	end

	if	proxy:IsCompleteEvent( ROGARN_STATE_WAIT ) 		== false and
		proxy:IsCompleteEvent( ROGARN_STATE_ANGRY_M1 )	== false and
		proxy:IsCompleteEvent( ROGARN_STATE_LAST_WARD ) == false then
		InvalidBackRead( proxy, 617 );
		proxy:SetEventFlag( 224, true );
	elseif proxy:IsCompleteEvent( ROGARN_STATE_ANGRY_M1 ) == true then
		proxy:EnableLogic(617,true);--ロジックＯＮ
		proxy:SetTeamType(617, TEAM_TYPE_AngryFriend);--チームタイプ変更
		--特殊待機解除		
		--SetNpcStateFlag(proxy,param,rogarn_flag_list,ROGARN_STATE_ANGRY_M1);--敵対状態に
	end
--▲ロガーン関連▲-----------------------------


--[[▼魔術の徒関連▼]]-----------------------------

	SetFirstNpcStateFlag(proxy, param, magic_student_flag_list, MAGIC_STUDENT_STATE_ISNOT);--状態が設定されていなければ、まだ居ない

	--まだ居ない
	if proxy:IsCompleteEvent( MAGIC_STUDENT_STATE_ISNOT ) == true then
		if boss_flagCount >= 1 then 
			SetNpcStateFlag( proxy, param ,magic_student_flag_list, MAGIC_STUDENT_STATE_ROGARN_HELP );--助けて状態に
		else
			InvalidBackRead( proxy , 681 );
		end
	end
	
	if proxy:IsCompleteEvent( MAGIC_STUDENT_STATE_DEAD ) == false then--死亡していない　かつ
		if proxy:IsCompleteEvent( MAGIC_STUDENT_STATE_ANGRY ) == false then--敵対していない
		
			if proxy:IsCompleteEvent( MAGIC_STUDENT_STATE_ROGARN_TOGETHER ) == true --ロガーンと一緒ならば
			and	proxy:IsCompleteEvent( ROGARN_STATE_ANGRY_M1 ) == true then--ロガーンが敵対ならば
				SetNpcStateFlag( proxy, param, magic_student_flag_list, MAGIC_STUDENT_STATE_ANGRY );--敵対状態に
			end
			
			--■312■ロガーンが石柱へ来たら状態変更■--
			if proxy:IsCompleteEvent( ROGARN_STATE_GO_M1 ) == true --ロガーンが石柱へ来たい　か
			or proxy:IsCompleteEvent( ROGARN_STATE_WAIT ) == true then--ロガーンが石柱にいるならば
				SetNpcStateFlag( proxy, param, magic_student_flag_list, MAGIC_STUDENT_STATE_ROGARN_TOGETHER );--ロガーンと一緒に
			end			
			
			--proxy:OnCharacterTotalDamage( 310, 681, 10000, 100, "OnEvent_310", once );--ダメージ監視追加
			proxy:OnCharacterTotalRateDamage( 310, 681, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_310", once );
			
		end
		proxy:OnCharacterDead( 311, 681, "OnEvent_311", once );
	end

	if 	proxy:IsCompleteEvent( MAGIC_STUDENT_STATE_ROGARN_HELP 		) == true or 
		proxy:IsCompleteEvent( MAGIC_STUDENT_STATE_ROGARN_TOGETHER 	) == true or
		proxy:IsCompleteEvent( MAGIC_STUDENT_STATE_FALL 			) == true or
		proxy:IsCompleteEvent( MAGIC_STUDENT_STATE_ANGRY 			) == true then
			proxy:SetEventFlag( 313, false );
			
	elseif proxy:IsCompleteEvent( MAGIC_STUDENT_STATE_ROGARN_HELP 		) == false and
		   proxy:IsCompleteEvent( MAGIC_STUDENT_STATE_ROGARN_TOGETHER 	) == false and
		   proxy:IsCompleteEvent( MAGIC_STUDENT_STATE_FALL 			) == false and
		   proxy:IsCompleteEvent( MAGIC_STUDENT_STATE_ANGRY 			) == false then
			InvalidBackRead( proxy, 681 );
			proxy:SetEventFlag( 313, true );
	end
	
	if proxy:IsCompleteEvent( MAGIC_STUDENT_STATE_ANGRY ) == true then
		proxy:EnableLogic(681,true);--ロジックＯＮ
		proxy:SetTeamType(681, TEAM_TYPE_AngryFriend);--チームタイプ変更
		--特殊待機解除		
		--SetNpcStateFlag( proxy, param, magic_student_flag_list, MAGIC_STUDENT_STATE_ANGRY );--敵対状態に
	end
--▲魔術の徒関連▲-----------------------------


--[[▼レンドル王子関連▼]]-----------------------------
	SetFirstNpcStateFlag(proxy, param, rendol_flag_list, RENDOL_STATE_HELP_FOR_DOREI_HEISI);--レンドル王子の状態を初期化する
	proxy:SetTeamTypePlus(688, TEAM_TYPE_Friend,false);--チームタイプ変更	
	local now_rendol_state = GetRendolState(proxy,param);
	
	if	now_rendol_state == RENDOL_STATE_SEARCH_1 or				--王城１を探索　か
		now_rendol_state == RENDOL_STATE_SEARCH_2 or				--王城２を探索　か
		now_rendol_state == RENDOL_STATE_SEARCH_3 or				--王城３を探索　か
		now_rendol_state == RENDOL_STATE_LOCATION_INVISIBLE or		--見えない場所にいる　か
		now_rendol_state == RENDOL_STATE_HOSTILE_STONE_PILLAR then	--石柱で敵対ならば
		
		if	proxy:IsCompleteEvent( RENDOL_STATE_HOSTILE_STONE_PILLAR ) == false then--敵対ではない
			--proxy:OnCharacterTotalDamage( 230, 688, 10000, 100, "OnEvent_230", once );--ダメージ監視追加
			proxy:OnCharacterTotalRateDamage( 230, 688, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_230", once );
		end
		--上記条件の時に、死亡監視追加
		proxy:OnCharacterDead( 231, 688, "OnEvent_231", once );
		proxy:SetEventFlag( 232, false );
	end
	
	local now_rendol_state = GetRendolState(proxy,param);
	
	if	now_rendol_state ~= RENDOL_STATE_SEARCH_1 and
		now_rendol_state ~= RENDOL_STATE_SEARCH_2 and
		now_rendol_state ~= RENDOL_STATE_SEARCH_3 and
		now_rendol_state ~= RENDOL_STATE_LOCATION_INVISIBLE and
		now_rendol_state ~= RENDOL_STATE_HOSTILE_STONE_PILLAR then
		InvalidBackRead( proxy, 688 );
		proxy:SetEventFlag( 232, true );
	elseif now_rendol_state == RENDOL_STATE_HOSTILE_STONE_PILLAR then
		proxy:EnableLogic(688,true);--ロジックＯＮ
		proxy:SetTeamType(688, TEAM_TYPE_AngryFriend);--チームタイプ変更	TEAM_TYPE_Friend
		proxy:EraseEventSpecialEffect_2(688,5063);		
		--SetNpcStateFlag(proxy,param,possible_transration_list_m02_03_00_00,RENDOL_STATE_HOSTILE_STONE_PILLAR);--敵対状態に
	end
--▲レンドル王子関連▲-----------------------------

--[[▼ビヨルングルム関連▼]]-----------------------------
	SetFirstNpcStateFlag( proxy , param , biyo_flag_list , BIYO_STATE_CAPTIVE );--状態が設定されてなければ、王城３を探索に
	proxy:SetTeamTypePlus(695, TEAM_TYPE_Friend,false);--チームタイプ変更	
	--王の剣を倒していて
	if	proxy:IsCompleteEvent(BIYO_STATE_KING_OF_SWORD_KILL) == true then 
		--飛竜の長が死んでいた場合はもういない状態へ
		if proxy:IsCompleteEvent(TYO_STATE_DEAD) == true then 
			SetNpcStateFlag(proxy,param, biyo_flag_list, BIYO_STATE_EXIT );
			
		--飛竜の長が死んでいない場合は長と戦っている状態に遷移
		elseif proxy:IsCompleteEvent(TYO_STATE_DEAD) == false then
			SetNpcStateFlag(proxy,param, biyo_flag_list, BIYO_STATE_BATTLE_FLY_DRAGON );
		end
	end
	
	if	proxy:IsCompleteEvent(BIYO_STATE_SEARCH_3) == true or					--石柱で待機　か
		proxy:IsCompleteEvent(BIYO_STATE_BATTLE_FLY_DRAGON) == true or			--飛竜の長と戦っている　か
		proxy:IsCompleteEvent(BIYO_STATE_HOSTILE_IN_STONE_PILLAR ) == true then	--石柱で敵対ならば
		
		if	proxy:IsCompleteEvent( BIYO_STATE_HOSTILE_IN_STONE_PILLAR ) == false then--敵対ではない
			--proxy:OnCharacterTotalDamage( 240, 695, 10000, 100, "OnEvent_240", once );--ダメージ監視追加
			proxy:OnCharacterTotalRateDamage( 240, 695, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_240", once );
		end
		proxy:OnCharacterDead( 241, 695, "OnEvent_241", once );
		proxy:SetEventFlag( 244, false );
	end
	
	print("test1");
	if	proxy:IsCompleteEvent(BIYO_STATE_SEARCH_3) == false and
		proxy:IsCompleteEvent(BIYO_STATE_BATTLE_FLY_DRAGON) == false and
		proxy:IsCompleteEvent(BIYO_STATE_HOSTILE_IN_STONE_PILLAR ) == false then
		print("test2");
		InvalidBackRead( proxy, 695 );
		proxy:SetEventFlag( 244, true );
	elseif proxy:IsCompleteEvent( BIYO_STATE_HOSTILE_IN_STONE_PILLAR ) == true then
		proxy:EnableLogic(695,true);--ロジックＯＮ
		proxy:SetTeamType(695, TEAM_TYPE_AngryFriend);--チームタイプ変更
		proxy:EraseEventSpecialEffect_2(695,5064);
		--SetNpcStateFlag(proxy,param,biyo_flag_list,BIYO_STATE_HOSTILE_IN_STONE_PILLAR);--敵対状態に
		print("test3");
	end
--▲ビヨルングルム関連▲-----------------------------


--[[▼魔女関連▼]]-----------------------------

	SetFirstNpcStateFlag(proxy, param, majo_flag_list, MAJO_STATE_LIBERATE);--状態が設定されていなければ、開放してほしいに
	
	--休憩中　か
	if proxy:IsCompleteEvent( MAJO_STATE_BREAK ) == true then
		SetNpcStateFlag(proxy, param, majo_flag_list, MAJO_STATE_WAIT_M1);
	end
	
	if	proxy:IsCompleteEvent( MAJO_STATE_WAIT_M1 )		== true or		--石柱で待機　か		
		proxy:IsCompleteEvent( MAJO_STATE_ANGRY_M1 )	== true then	--石柱で敵対ならば		
		if	proxy:IsCompleteEvent( MAJO_STATE_ANGRY_M1 ) == false then	--敵対ではない
			--proxy:OnCharacterTotalDamage( 260, 689, 10000, 100, "OnEvent_260", once );--ダメージ監視追加
			proxy:OnCharacterTotalRateDamage( 260, 689, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_260", once );			
		end
		--上記の状態の時に、死亡監視追加
		proxy:OnCharacterDead( 261, 689, "OnEvent_261", once );
		proxy:SetEventFlag( 263, false );
	end
	
	
	if	proxy:IsCompleteEvent( MAJO_STATE_WAIT_M1 )		== false and
		proxy:IsCompleteEvent( MAJO_STATE_ANGRY_M1 )	== false then
		InvalidBackRead( proxy, 689 );
		proxy:SetEventFlag( 263, true );
	elseif proxy:IsCompleteEvent( MAJO_STATE_ANGRY_M1 )	== true then
		proxy:EnableLogic(689,true);--ロジックＯＮ
		proxy:SetTeamType(689, TEAM_TYPE_AngryFriend);--チームタイプ変更		
		--SetNpcStateFlag( proxy, param, majo_flag_list, MAJO_STATE_ANGRY_M1 );--敵対状態に	
	end
--▲魔女関連▲-----------------------------


--[[▼ウルベイン関連▼]]-----------------------------
	SetFirstNpcStateFlag(proxy, param, urubain_flag_list, URUBAIN_STATE_HELP);--状態が設定されていなければ、助けてほしいに

	if	proxy:IsCompleteEvent( URUBAIN_STATE_THANKS ) == true then--感謝しているならば
		SetNpcStateFlag( proxy, param, urubain_flag_list, URUBAIN_STATE_STONE_PILLAR );--石柱にいるに
	end
	
	if	proxy:IsCompleteEvent( URUBAIN_STATE_STONE_PILLAR ) == true or			--石柱にいる　か
		proxy:IsCompleteEvent( URUBAIN_STATE_STONE_PILLAR_ANGRY ) == true then	--石柱で敵対ならば
		
		if proxy:IsCompleteEvent( URUBAIN_STATE_STONE_PILLAR_ANGRY ) == false then--敵対ではない
			--proxy:OnCharacterTotalDamage( 270, 690, 10000, TOTALDAMAGE_URUBAIN, "OnEvent_270", once );--ダメージ監視追加
			proxy:OnCharacterTotalRateDamage( 270, 690, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_270", once );
			
		end
		--上記の状態の時に、死亡監視追加
		proxy:OnCharacterDead( 271, 690, "OnEvent_271", once );
		proxy:SetEventFlag( 273, false );
	end
	
	if	proxy:IsCompleteEvent( URUBAIN_STATE_STONE_PILLAR ) 		== false and
		proxy:IsCompleteEvent( URUBAIN_STATE_STONE_PILLAR_ANGRY ) 	== false then
		InvalidBackRead( proxy , 690 );--ウル様無効化
		proxy:SetEventFlag( 273, true );
		
	elseif proxy:IsCompleteEvent( URUBAIN_STATE_STONE_PILLAR_ANGRY ) == true then
		proxy:EnableLogic(690,true);--ロジックＯＮ
		proxy:SetTeamType(690, TEAM_TYPE_AngryFriend);--チームタイプ変更		
		--SetNpcStateFlag( proxy, param, urubain_flag_list, URUBAIN_STATE_STONE_PILLAR_ANGRY );--敵対状態に
	end
--▲ウルベイン関連▲-----------------------------


--[[▼ユルト関連▼]]-----------------------------
	SetFirstNpcStateFlag(proxy, param, yuruto_flag_list, YURUTO_STATE_LIFT);--状態が設定されてなかったら、エレベーターで待つにする

	--石柱に行く前状態なら
	if proxy:IsCompleteEvent( YURUTO_STANDBY_M1 ) == true then
		--記憶ボス撃破数より現在の撃破数の方が多い
		if proxy:GetBossCount() < boss_flagCount then
			SetNpcStateFlag( proxy, param, yuruto_flag_list, YURUTO_STATE_WAIT_M1 );
			--再びボスカウントを記憶
			proxy:SetBossCount( boss_flagCount );
		end
	end

--■280■ユルト敵対■（会話システムから呼び出し）
	--会話から呼ばれるハンドラ
	proxy:LuaCall( 280, 0, "OnEvent_280", everytime );
	
--■15630■ユルトの死体を調べた■
	if proxy:IsCompleteEvent( 15630 ) == false then
		proxy:AddCorpseEvent( 15630 , 619 );
		proxy:NotNetMessage_begin();
			proxy:LuaCall( 15630 ,0 , "OnEvent_15630",once );
 		proxy:NotNetMessage_end();
	end	
	
	if	proxy:IsCompleteEvent( YURUTO_STATE_ANGRY_M1 ) == true or	--石柱で敵対　か
		proxy:IsCompleteEvent( YURUTO_STATE_WAIT_M1  ) == true then	--石柱で待つならば
		
		--[[
		if proxy:IsCompleteEvent( 500 ) == false then
			proxy:SetEventFlag( 500 , true );
			proxy:SetBossCount( boss_flagCount );
		end
		]]
		--上記の状態の時に、死亡監視追加
		proxy:OnCharacterDead( 281, 619, "OnEvent_281", once );
		proxy:SetEventFlag( 282, false );
	end

	if	proxy:IsCompleteEvent( YURUTO_STATE_ANGRY_M1 ) == false and		--敵対ではない　かつ
		proxy:IsCompleteEvent( YURUTO_STATE_WAIT_M1  ) == false then	--石柱で待つならば
		if 	proxy:IsCompleteEvent( 281 ) == true and	--死んでいる
			proxy:IsCompleteEvent( 15630 ) == false then	--死体を調べてない
			--死体を再現する
			proxy:OpeningDeadPlus( 619 , true ,false ,false );
		else
			InvalidBackRead( proxy, 619 );
		end
		proxy:SetEventFlag( 282, true );
	elseif	proxy:IsCompleteEvent( YURUTO_STATE_ANGRY_M1 ) == true then--敵対ならば
		proxy:EnableLogic(619,true);--ロジックＯＮ
		proxy:SetTeamType(619, TEAM_TYPE_AngryFriend);--チームタイプ変更		
		--SetNpcStateFlag( proxy, param, yuruto_flag_list, YURUTO_STATE_ANGRY_M1 );--敵対状態に
	end
--▲ユルト関連▲-----------------------------

--[[▼バッチ関連▼]]-----------------------------
	SetFirstNpcStateFlag(proxy, param, batti_flag_list, BATTI_NOT_STAY);--状態が設定されていなければ、どこにもいないに
	
	if	proxy:IsCompleteEvent(BATTI_SATISFIED) 		== true or		--古砦の満足　か
		proxy:IsCompleteEvent(BATTI_PRESENT) 		== true or		--坑道の宝はあげた　か
		proxy:IsCompleteEvent(BATTI_VEXING_M6) 		== true or		--坑道の残念　か
		proxy:IsCompleteEvent(BATTI_DESTORYKUMA)	== true then	--坑道でクマムシ倒したならば
		SetNpcStateFlag( proxy, param, batti_flag_list, BATTI_RESERVE_M1 );--石柱で待つに
	end
	
	if	proxy:IsCompleteEvent( BATTI_RESERVE_M1 ) == true or	--石柱で待つ　か
		proxy:IsCompleteEvent( BATTI_ANGRY_M1 ) == true then	--石柱で敵対ならば
		
		if	proxy:IsCompleteEvent( BATTI_ANGRY_M1 ) == false then--敵対ではない
			--proxy:OnCharacterTotalDamage( 290, 693, 10000, TOTALDAMAGE_BATTI, "OnEvent_290", once );--ダメージ監視追加
			proxy:OnCharacterTotalRateDamage( 290, 693, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_290", once );
			
		end
		--上記の状態の時に、死亡監視追加
		proxy:OnCharacterDead( 291, 693, "OnEvent_291", once );
		proxy:SetEventFlag( 293, false );
	end
	
	if	proxy:IsCompleteEvent( BATTI_RESERVE_M1 )	== false and
		proxy:IsCompleteEvent( BATTI_ANGRY_M1  ) 	== false then
		InvalidBackRead( proxy, 693 );
		proxy:SetEventFlag( 293, true );
	elseif proxy:IsCompleteEvent( BATTI_ANGRY_M1  )	== true then
		proxy:EnableLogic(693,true);--ロジックＯＮ
		proxy:SetTeamType(693, TEAM_TYPE_AngryFriend);--チームタイプ変更		
		--SetNpcStateFlag( proxy, param, batti_flag_list, BATTI_ANGRY_M1 );--敵対状態に
	end
--▲バッチ関連▲-----------------------------


--[[▼要人関連▼]]-----------------------------
	--初期状態を設定
	SetFirstNpcStateFlag(proxy, param, yojin_flag_list, YOJIN_STATE_WAIT_FOR_PLAYER);

	--Initに記載
	--proxy:LuaCall( 303,0,"OnEvent_303",once);--ポリ劇再生用の会話呼び出しハンドラ
	--要人が生きている
	proxy:SetDeadMode( 613, true );--ノーダメージ
	proxy:DisableHpGauge( 613 , true );--ゲージ表示無し
	if proxy:IsCompleteEvent(YOJIN_STATE_DEAD ) == false then
		--会話から呼ばれるハンドラ
		
		--■300■要人死亡■
		if proxy:IsCompleteEvent( 300 ) == false then
			proxy:OnCharacterDead( 300 , 613 , "OnEvent_300" , once );
		end
		
		--要人が最後の言葉を伝えようになる
		if	IsLast == true then--すべてのステージが終わったら
			if	proxy:IsCompleteEvent( YOJIN_STATE_WAIT_FOR_PLAYER ) 	== true then--主人公を待つならば
				SetNpcStateFlag(proxy, param, yojin_flag_list, YOJIN_STATE_LASTWORD );
			end
		end
	end

	--要人が生きてない
	if proxy:IsCompleteEvent(YOJIN_STATE_DEAD ) == true then
		InvalidBackRead( proxy , 613 );--要人無効化
	end
--▲要人関連▲-----------------------------

--[[▼神の信徒1関連▼]]-----------------------------
	SetFirstNpcStateFlag(proxy, param, god_beliver1_flag_list, GOD_BELIEVER_1_STATE_ISNOT);--状態が設定されていなかったら、まだ居ない
	
	if proxy:IsCompleteEvent( GOD_BELIEVER_1_STATE_ISNOT ) == true then
		if boss_flagCount >= 1 then
			SetNpcStateFlag( proxy, param, god_beliver1_flag_list, GOD_BELIEVER_1_STATE_STONE_PILLAR );
		else
			InvalidBackRead( proxy ,682 );
		end
	end
	
--------状態初期化処理-----------
	--■322■ロガーンが古砦から戻ってきた時に、「ウル様と一緒」にする■
	if	proxy:IsCompleteEvent( GOD_BELIEVER_1_STATE_STONE_PILLAR ) == true and	--石柱に居る かつ
		proxy:IsCompleteEvent( URUBAIN_STATE_STONE_PILLAR ) == true or			--ウル様石柱に居る か
		proxy:IsCompleteEvent( URUBAIN_STATE_THANKS ) == true then				--ウル様が感謝している ならば
		
		SetNpcStateFlag( proxy, param, god_beliver1_flag_list, GOD_BELIEVER_1_STATE_URU );--ウル様と一緒に
	end
	
	if proxy:IsCompleteEvent( URUBAIN_STATE_STONE_PILLAR_ANGRY ) == true and	--ウル様が敵対　かつ
	   proxy:IsCompleteEvent( GOD_BELIEVER_1_STATE_ANGRY ) == false then	--敵対していないならば
		if proxy:IsCompleteEvent( GOD_BELIEVER_1_STATE_DEAD ) == false then
			SetNpcStateFlag( proxy, param, god_beliver1_flag_list, GOD_BELIEVER_1_STATE_ANGRY );--敵対状態に
		end
	end
	
	if proxy:IsCompleteEvent( GOD_BELIEVER_1_STATE_DEAD ) == true then
		--■323■信徒１死亡処理■
		InvalidBackRead( proxy, 682 );
		--proxy:SetEventFlag( 323, true );
	elseif proxy:IsCompleteEvent( GOD_BELIEVER_1_STATE_ANGRY ) == true then
		--■324■信徒１敵対処理■
		proxy:EnableLogic(682,true);--ロジックＯＮ
		proxy:SetTeamType(682, TEAM_TYPE_AngryFriend);--チームタイプ変更		
		--SetNpcStateFlag( proxy, param, god_beliver1_flag_list, GOD_BELIEVER_1_STATE_ANGRY );--敵対状態に
	end
--------各監視追加-----------	
	--ウル様敵対時に呼ばれるハンドラ登録
	proxy:LuaCall(320, 1, "OnEvent_320", once);
	
	if proxy:IsCompleteEvent(GOD_BELIEVER_1_STATE_DEAD ) == false then--死亡していないならば
		if proxy:IsCompleteEvent( GOD_BELIEVER_1_STATE_ANGRY ) == false then--敵対していない
			--■320■信徒１敵対監視■
			proxy:OnCharacterTotalRateDamage( 320, 682, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_320", once );--敵対監視追加
			
		end
		--■321■信徒１死亡監視■
		proxy:OnCharacterDead( 321, 682, "OnEvent_321", once );--上記の状態だった時に、死亡監視追加
	end
--▲神の信徒1関連▲-----------------------------


--[[▼神の信徒2関連▼]]-----------------------------
	SetFirstNpcStateFlag(proxy, param, god_beliver2_flag_list, GOD_BELIEVER_2_STATE_ISNOT);--状態が設定されていなかったら、まだ居ない
	
	if proxy:IsCompleteEvent( GOD_BELIEVER_2_STATE_ISNOT ) == true then
		if boss_flagCount >= 1 then
			proxy:SetEventFlag( 333, false );
			SetNpcStateFlag( proxy, param, god_beliver2_flag_list, GOD_BELIEVER_2_STATE_STONE_PILLAR );
		else
			proxy:SetEventFlag( 333, true );
			InvalidBackRead( proxy ,683 );
		end
	end
--■335■ウル様を探しに行き、行方不明■
	if proxy:IsCompleteEvent( GOD_BELIEVER_2_STATE_STONE_PILLAR ) == true	--石柱に居る　かつ
	and proxy:IsCompleteEvent( 9164 ) == true	--会話「ウル様を助けに行くつもり」（9164）を聞いている　かつ
	and proxy:IsCompleteEvent( 4756 ) == true then --古砦１をクリアしている　ならば
		proxy:SetEventFlag( 335, true );
		SetNpcStateFlag( proxy, param, god_beliver2_flag_list, GOD_BELIEVER_2_STATE_ISNOTALREADY );--すでに居ないに
		
	elseif proxy:IsCompleteEvent( URUBAIN_STATE_STONE_PILLAR ) == true then	--ウル様が石柱にいたら
		proxy:SetEventFlag( 335, true );
		SetNpcStateFlag( proxy, param, god_beliver2_flag_list, GOD_BELIEVER_2_STATE_ISNOTALREADY );--すでに居ないに
	end
	--[[実質、すでに居ないフラグは、立たない。（復活するかもしれないので、残しておく）]]
	if proxy:IsCompleteEvent( GOD_BELIEVER_2_STATE_ISNOTALREADY ) == true then
		print("ウル様を探しに行って…行方不明");
		SetNpcStateFlag( proxy, param, god_beliver2_flag_list, GOD_BELIEVER_2_STATE_DEAD );--探しに行って帰らぬ人に・・・
	end
	
--------状態初期化処理-----------	
	if proxy:IsCompleteEvent( GOD_BELIEVER_2_STATE_DEAD ) == true 				--死亡　か
	or proxy:IsCompleteEvent( GOD_BELIEVER_2_STATE_ISNOTALREADY ) == true then	--すでに居ないならば
		--■333■信徒２死亡処理■
		InvalidBackRead( proxy, 683 );
		proxy:SetEventFlag( 333, true );
	elseif proxy:IsCompleteEvent( GOD_BELIEVER_2_STATE_ANGRY ) == true then
		--■334■信徒２敵対処理■
		proxy:EnableLogic(683,true);--ロジックＯＮ
		proxy:SetTeamType(683, TEAM_TYPE_AngryFriend);--チームタイプ変更		
		--SetNpcStateFlag( proxy, param, god_beliver2_flag_list, GOD_BELIEVER_2_STATE_ANGRY );--敵対状態に
	end

	if proxy:IsCompleteEvent( URUBAIN_STATE_STONE_PILLAR_ANGRY ) == true and	--ウル様が敵対 かつ
	   proxy:IsCompleteEvent( GOD_BELIEVER_2_STATE_ANGRY ) == false then	--敵対していないならば
	   --死んでいないか？
		if proxy:IsCompleteEvent(GOD_BELIEVER_2_STATE_DEAD) == false then
			SetNpcStateFlag( proxy, param, god_beliver2_flag_list, GOD_BELIEVER_2_STATE_ANGRY );--敵対状態に
		end
	end
	
	--■！削除！■ウルベインが古砦から戻ってきた時に、「ウル様と一緒」にする■
--------各監視追加-----------
	--ウル様敵対時に呼ばれるハンドラ登録
	proxy:LuaCall(330, 1, "OnEvent_330", once);

	if proxy:IsCompleteEvent(GOD_BELIEVER_2_STATE_DEAD ) == false then--死亡していないならば
		if proxy:IsCompleteEvent( GOD_BELIEVER_2_STATE_ANGRY ) == false then--敵対していない
			--■330■信徒２敵対監視■
			proxy:OnCharacterTotalRateDamage( 330, 683, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_330", once );--敵対監視追加
			
		end
		--■331■信徒２死亡監視■
		proxy:OnCharacterDead( 331, 683, "OnEvent_331", once );--上記の状態だった時に、死亡監視追加
	end
--▲神の信徒2関連▲-----------------------------

--[[▼神の信徒3関連▼]]-----------------------------
	SetFirstNpcStateFlag(proxy, param, god_beliver3_flag_list, GOD_BELIEVER_3_STATE_STONE_PILLAR);--状態が設定されていなかったら、石柱にいるに
--------状態初期化処理-----------
	--■432■ロガーンが古砦から戻ってきた時に、「ウル様と一緒」にする■
	if	proxy:IsCompleteEvent( GOD_BELIEVER_3_STATE_STONE_PILLAR ) == true and	--石柱に居る かつ
		proxy:IsCompleteEvent( URUBAIN_STATE_STONE_PILLAR ) == true or			--ウル様石柱に居る か
		proxy:IsCompleteEvent( URUBAIN_STATE_THANKS ) == true then				--ウル様が感謝している ならば
		
		SetNpcStateFlag( proxy, param, god_beliver3_flag_list, GOD_BELIEVER_3_STATE_URU );--ウル様と一緒に
	end
	
	if proxy:IsCompleteEvent( URUBAIN_STATE_STONE_PILLAR_ANGRY ) == true and	--ウル様が敵対 かつ
	   proxy:IsCompleteEvent( GOD_BELIEVER_3_STATE_ANGRY ) == false then	--敵対していないならば
	   --死んで無い
	   if proxy:IsCompleteEvent( GOD_BELIEVER_3_STATE_DEAD ) == false then
			SetNpcStateFlag( proxy, param, god_beliver3_flag_list, GOD_BELIEVER_3_STATE_ANGRY );--敵対状態に
		end
	end
	
	if proxy:IsCompleteEvent( GOD_BELIEVER_3_STATE_DEAD ) == true then
		--■433■信徒３死亡処理■
		InvalidBackRead( proxy, 684 );
		proxy:SetEventFlag( 323, true );
	elseif proxy:IsCompleteEvent( GOD_BELIEVER_3_STATE_ANGRY ) == true then
		--■434■信徒３敵対処理■
		proxy:EnableLogic(684,true);--ロジックＯＮ
		proxy:SetTeamType(684, TEAM_TYPE_AngryFriend);--チームタイプ変更		
		--SetNpcStateFlag( proxy, param, god_beliver3_flag_list, GOD_BELIEVER_3_STATE_ANGRY );--敵対状態に
	end
--------各監視追加-----------
	--ウル様敵対時に呼ばれるハンドラ登録
	proxy:LuaCall(430, 1, "OnEvent_430", once);
	--■435■信徒３がアイテムをくれる■(会話呼び出し)
	proxy:LuaCall(435, 0, "OnEvent_435", once);
	
	if proxy:IsCompleteEvent(GOD_BELIEVER_3_STATE_DEAD ) == false then--死亡していないならば
		if proxy:IsCompleteEvent( GOD_BELIEVER_3_STATE_ANGRY ) == false then--敵対していない
			--■430■信徒３敵対監視■
			proxy:OnCharacterTotalRateDamage( 430, 684, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_430", once );--敵対監視追加
			
		end
		--■431■信徒３死亡監視■
		proxy:OnCharacterDead( 431, 684, "OnEvent_431", once );--上記の状態だった時に、死亡監視追加
	end
--▲神の信徒3関連▲-----------------------------

--[[▼大袋のトマス関連▼]]-----------------------------
	SetFirstNpcStateFlag(proxy, param, tomasu_flag_list, TOMASU_STATE_ISNOT);--状態が設定されていなければ、まだいないに
	
	--トマスがまだ居ない状態だったら
	if proxy:IsCompleteEvent( TOMASU_STATE_ISNOT ) == true then--まだいないならば
		if boss_flagCount >= 0 then--ボスを1体以上倒したら
			SetNpcStateFlag(proxy, param, tomasu_flag_list, TOMASU_STATE_WAIT );--預かるよに
		end
	end
	
	--トマスに娘の髪飾りを渡す処理
	proxy:LuaCall( 354, 0, "OnEvent_354", everytime );
	
	if	proxy:IsCompleteEvent( TOMASU_STATE_DEAD ) == false then--死んでいないならば
		if	proxy:IsCompleteEvent( TOMASU_STATE_ANGRY ) == false then--敵対ではない
			--proxy:OnCharacterTotalDamage( 350, 687, 10000, 100, "OnEvent_350", once );--ダメージ監視追加
			proxy:OnCharacterTotalRateDamage( 350, 687, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_350", once );
			
		end
		--上記の状態だった時に、死亡監視追加
		proxy:OnCharacterDead( 351, 687, "OnEvent_351", once );
	end
	
	if proxy:IsCompleteEvent( TOMASU_STATE_WAIT ) == true or 
	   proxy:IsCompleteEvent( TOMASU_STATE_ANGRY ) == true then
		proxy:SetEventFlag( 352, false );
	end

	
	if	proxy:IsCompleteEvent( TOMASU_STATE_DEAD ) == true or proxy:IsCompleteEvent( TOMASU_STATE_ISNOT ) == true then
		InvalidBackRead( proxy, 687 );
		proxy:SetEventFlag( 352, true );
	elseif proxy:IsCompleteEvent( TOMASU_STATE_ANGRY ) == true then
		proxy:EnableLogic(687,true);--ロジックＯＮ
		proxy:SetTeamType(687, TEAM_TYPE_AngryFriend);--チームタイプ変更		
		--SetNpcStateFlag( proxy, param, tomasu_flag_list, TOMASU_STATE_ANGRY );--敵対状態に
	end
--▲大袋のトマス関連▲-----------------------------

--[[▼メフィスト関連▼]]-----------------------------

--メフィスト用フラグ成立判定
--[[トマスは、使用の変更で依頼されない為、コメントアウト。（再利用もありうるので消さない）]]
	if proxy:IsCompleteEvent( RENDOL_STATE_DEAD ) == true then--レンドル王子が死んでいる
		if proxy:IsCompleteEvent( BIYO_STATE_DEAD ) == true then--ブヨが死んでいる
			if proxy:IsCompleteEvent( ROGARN_STATE_DEAD ) == true and proxy:IsCompleteEvent( MAGIC_STUDENT_STATE_DEAD ) == true then--ロガーンと魔術の徒が死んでいる
				if proxy:IsCompleteEvent( MAJO_STATE_DEAD ) == true then--魔女が死んでいる
					if proxy:IsCompleteEvent( URUBAIN_STATE_DEAD ) == true and proxy:IsCompleteEvent( GOD_BELIEVER_1_STATE_DEAD ) == true and proxy:IsCompleteEvent( GOD_BELIEVER_3_STATE_DEAD ) == true then--ウル様とそのとりまきが死んでいる
						--if proxy:IsCompleteEvent( TOMASU_STATE_DEAD ) == true then--トマスが死んでいる
						if proxy:IsCompleteEvent( BATTI_DEAD ) == true then--バッチが死んでいる
							--全員殺した事になるので、任務完了フラグを立てる
							proxy:SetEventFlag( 8097, true );
						else--パッチが生きている
							--フラグ成立
							proxy:SetEventFlag( 8096, true );--バッチ殺害待ち
						end
						--else--トマスが生きている
						--	--フラグ成立
						--	proxy:SetEventFlag( 8095, true );--トマス殺害待ち
						--end
					elseif proxy:IsCompleteEvent( URUBAIN_STATE_DEAD ) == false and proxy:IsCompleteEvent( GOD_BELIEVER_1_STATE_DEAD ) == false and proxy:IsCompleteEvent( GOD_BELIEVER_2_STATE_DEAD ) == false then--ウル様とそのとりまきが生きている
						--フラグ成立
						proxy:SetEventFlag( 8094, true );--ウル様とそのとりまき殺害待ち
					end
				else--魔女が生きている
					--フラグ成立
					proxy:SetEventFlag( 8093, true );--魔女殺害待ち
				end
			elseif proxy:IsCompleteEvent( ROGARN_STATE_DEAD ) == false or proxy:IsCompleteEvent( MAGIC_STUDENT_STATE_DEAD ) == false then--ロガーンか魔術の徒が生きている
				--フラグ成立
				proxy:SetEventFlag( 8092, true );--ロガーン達殺害待ち
			end
		else--ビヨが生きていたら
			--フラグ成立
			proxy:SetEventFlag( 8091, true );--ビヨ殺害待ち
		end
	else--レンドル王子が生きていたら
		--フラグ成立
		proxy:SetEventFlag( 8090, true );--レンドル王子殺害待ち
	end


	SetFirstNpcStateFlag(proxy, param, mefist_flag_list, MEFIST_STATE_NO_STAY);--状態が設定されていなければ、まだいないに
	
	if	proxy:IsCompleteEvent( MEFIST_STATE_NO_STAY ) == true 	--まだいない　かつ
	and	proxy:IsCompleteEvent( YURUTO_STATE_DEAD ) == true --ユルトが死亡 かつ
	and proxy:IsSuccessQWC( 10600 ) == true then--QWC成立ならば
		SetNpcStateFlag(proxy, param, mefist_flag_list, MEFIST_STATE_STONE_PILLAR );--石柱にいるに
	end
	
	if	proxy:IsCompleteEvent( MEFIST_STATE_NO_STAY ) == false		--もうここに居る　かつ
	and	proxy:IsCompleteEvent( MEFIST_STATE_DEAD 	) == false then	--死亡していないならば
		
		if	proxy:IsCompleteEvent( MEFIST_STATE_ANGRY ) == false then--敵対していない
			--proxy:OnCharacterTotalDamage( 360, 680, 10000, 100, "OnEvent_360", once );--ダメージ監視追加
			proxy:OnCharacterTotalRateDamage( 360, 680, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_360", once );
			
		end
		
		--各NPC殺害待ち--
		proxy:LuaCall( 362, 0, "OnEvent_362", everytime );--レンドル王子
		proxy:LuaCall( 363, 0, "OnEvent_363", everytime );--ビヨルングルム
		proxy:LuaCall( 364, 0, "OnEvent_364", everytime );--ロガーン
		proxy:LuaCall( 365, 0, "OnEvent_365", everytime );--魔女
		proxy:LuaCall( 366, 0, "OnEvent_366", everytime );--ウル様
		proxy:LuaCall( 367, 0, "OnEvent_367", everytime );--トマス
		proxy:LuaCall( 368, 0, "OnEvent_368", everytime );--バッチ
		
		--メフィストの宣戦布告--
		proxy:LuaCall( 369, 0, "OnEvent_369", everytime );
		
		--各NPC殺害お礼--
		proxy:LuaCall( 400, 0, "OnEvent_400", everytime );--レンドル王子
		proxy:LuaCall( 401, 0, "OnEvent_401", everytime );--ビヨルングルム
		proxy:LuaCall( 402, 0, "OnEvent_402", everytime );--ロガーン
		proxy:LuaCall( 403, 0, "OnEvent_403", everytime );--魔女
		proxy:LuaCall( 404, 0, "OnEvent_404", everytime );--ウル様
		proxy:LuaCall( 405, 0, "OnEvent_405", everytime );--トマス
		proxy:LuaCall( 406, 0, "OnEvent_406", everytime );--バッチ
		
		--上記の状態の時に、死亡監視追加
		proxy:OnCharacterDead( 361, 680, "OnEvent_361", once );
	end
	
	if	proxy:IsCompleteEvent( MEFIST_STATE_NO_STAY )	== true or
		proxy:IsCompleteEvent( MEFIST_STATE_DEAD ) 		== true then
		InvalidBackRead( proxy, 680 );
	elseif proxy:IsCompleteEvent( MEFIST_STATE_ANGRY ) == true then
		proxy:EnableLogic(680,true);--ロジックＯＮ
		proxy:SetTeamType(680, TEAM_TYPE_AngryFriend);--チームタイプ変更		
		--SetNpcStateFlag( proxy, param, mefist_flag_list, MEFIST_STATE_ANGRY );--敵対状態に
	end

--▲メフィスト関連▲-----------------------------

--[[▼心折れた戦士関連▼]]-----------------------------
	SetFirstNpcStateFlag(proxy, param, heartbreak_fighter_flag_list, HEART_BREAK_FIGHTER_STATE_STONE_PILLAR);--状態が設定されていない時、石柱にいるに
	
	if proxy:IsCompleteEvent( HEART_BREAK_FIGHTER_STATE_DELETE ) == true then--消えますならば
		SetNpcStateFlag( proxy, param, heartbreak_fighter_flag_list, HEART_BREAK_FIGHTER_STATE_DEAD );--死亡に
		proxy:OpeningDead( 611, true );
	end
	
	if proxy:IsCompleteEvent( HEART_BREAK_FIGHTER_STATE_DEAD ) == false then--死亡していなければ
		if proxy:IsCompleteEvent( HEART_BREAK_FIGHTER_STATE_ANGRY ) == false then--敵対ではない
		--■384■王の盾を倒すと、消えそうになる■
			if proxy:IsCompleteEvent( HEART_BREAK_FIGHTER_STATE_STONE_PILLAR ) == true 	--石柱にいる　かつ
			and proxy:IsCompleteEvent( 4224 ) == true then								--王の盾を殺している　ならば
				SetNpcStateFlag( proxy, param, heartbreak_fighter_flag_list, HEART_BREAK_FIGHTER_STATE_MAYBE_DELETE );--消えそうに
				proxy:SetEventFlag( 384, true );
			end
			--proxy:OnCharacterTotalDamage( 380, 611, 10000, 100, "OnEvent_380", once );--ダメージ監視追加
			proxy:OnCharacterTotalRateDamage( 380, 611, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_380", once );
			
			proxy:LuaCall( 382, 0, "OnEvent_382", everytime );
			
		--■388■心折れた戦士に話しかけた■
			if proxy:IsCompleteEvent( 388 ) == false then
				proxy:LuaCall( 388, 0, "OnEvent_388", once );
				proxy:LuaCall( 388, REMO_START , "OnEvent_388_RemoStart",once);
				proxy:LuaCall( 388, REMO_FINISH, "OnEvent_388_RemoFinish",once);
			end
		end
		--上記の時に、死亡監視追加
		proxy:OnCharacterDead( 381, 611, "OnEvent_381", once );
	end

	if	proxy:IsCompleteEvent( HEART_BREAK_FIGHTER_STATE_STONE_PILLAR ) == false and
		proxy:IsCompleteEvent( HEART_BREAK_FIGHTER_STATE_ANGRY ) 		== false and
		proxy:IsCompleteEvent( HEART_BREAK_FIGHTER_STATE_MAYBE_DELETE ) == false and
		proxy:IsCompleteEvent( HEART_BREAK_FIGHTER_STATE_DELETE )		== false then
		InvalidBackRead( proxy, 611 );
	elseif proxy:IsCompleteEvent( HEART_BREAK_FIGHTER_STATE_ANGRY ) == true then
		proxy:EnableLogic(611,true);--ロジックＯＮ
		proxy:SetTeamType(611, TEAM_TYPE_AngryFriend);--チームタイプ変更		
		--SetNpcStateFlag( proxy, param, heartbreak_fighter_flag_list, HEART_BREAK_FIGHTER_STATE_ANGRY );--敵対状態に
	end
--▲心折れた戦士関連▲-----------------------------


--[[▼ボールドウィン関連▼]]-----------------------------
	--初期状態を設定
	SetFirstNpcStateFlag(proxy, param, baldwin_flag_list, BALDWIN_STATE_ISNOT);--状態が設定されていなければ、まだいないに

	--ボールドウィンがまだ居ない状態だったら
	if proxy:IsCompleteEvent( BALDWIN_STATE_ISNOT ) == true then--まだいないならば
		--if boss_flagCount >= 2 then--ボスを2体以上倒したら
		SetNpcStateFlag(proxy, param, baldwin_flag_list, BALDWIN_STATE_WORK );--仕事中に
		--end
	end
	
	
	if	proxy:IsCompleteEvent( BALDWIN_STATE_WORK ) 	== true or			--仕事中　か
		proxy:IsCompleteEvent( BALDWIN_STATE_HOSTILE ) 	== true then		--石柱で敵対ならば
		
		if	proxy:IsCompleteEvent( BALDWIN_STATE_HOSTILE ) == false then--敵対では無い
			--proxy:OnCharacterTotalDamage( 390, 694, 10000, 100, "OnEvent_390", once );--ダメージ監視追加
			proxy:OnCharacterTotalRateDamage( 390, 694, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_390", once );
			
		end
		
		--上記の状態の時に、死亡監視追加
		proxy:OnCharacterDead( 391 , 694 , "OnEvent_391" , once );
	end

	--現在の状態を取得
	local now_state = GetNpcStateFlag( proxy , param , baldwin_flag_list );

	if now_state == BALDWIN_STATE_HOSTILE then--敵対(石柱)
		proxy:EnableLogic(694,true);--ロジックＯＮ
		proxy:SetTeamType(694, TEAM_TYPE_AngryFriend);--チームタイプ変更		
		--SetNpcStateFlag( proxy, param, baldwin_flag_list, BALDWIN_STATE_HOSTILE );--敵対
	elseif now_state == BALDWIN_STATE_DEAD or now_state == BALDWIN_STATE_ISNOT then--死亡
		InvalidBackRead( proxy , 694 );--ボールドウィン無効化
		proxy:SetEventFlag( 392, true );
	end
--▲ボールドウィン関連▲-----------------------------

--[[▼物織り関連▼]-----------------------------
	--初期状態を設定
	SetFirstNpcStateFlag(proxy, param, monoshiri_flag_list, MONOSHIRI_STATE_ISNOT);--状態が設定されていなければ、まだいないに
	
	--物織りがまだ居ない状態だったら
	if proxy:IsCompleteEvent( MONOSHIRI_STATE_ISNOT ) == true then--まだいないならば
		if boss_flagCount >= 1 then--ボスを１体以上倒したら
			SetNpcStateFlag(proxy, param, monoshiri_flag_list, MONOSHIRI_STATE_BUSINESS );--情報売るよに
		end
	end

	if proxy:IsCompleteEvent(MONOSHIRI_STATE_DEAD ) == false then--死亡していないならば
		if proxy:IsCompleteEvent( MONOSHIRI_STATE_HOSTILE ) == false then--敵対していない
			--proxy:OnCharacterTotalDamage( 340, 686, 10000, 100, "OnEvent_340", once );--ダメージ監視追加
			proxy:OnCharacterTotalRateDamage( 340, 686, LOCAL_PLAYER, NPC_ANGRY_Rate, "OnEvent_340", once );
			
		end
		--上記の状態だった時に、死亡監視追加
		proxy:OnCharacterDead( 341 , 686 , "OnEvent_341" , once );
	end

	--現在の状態を取得
	local now_state = GetNpcStateFlag( proxy , param , monoshiri_flag_list );
	
	if now_state == MONOSHIRI_STATE_BUSINESS or now_state == MONOSHIRI_STATE_HOSTILE then
		proxy:SetEventFlag( 343, false );
	end

	if now_state == MONOSHIRI_STATE_HOSTILE then--敵対(石柱)
		proxy:EnableLogic(686,true);--ロジックＯＮ
		proxy:SetTeamType(686, TEAM_TYPE_AngryFriend);--チームタイプ変更		
		--SetNpcStateFlag( proxy, param, monoshiri_flag_list, MONOSHIRI_STATE_HOSTILE );--敵対状態に
		
	elseif now_state == MONOSHIRI_STATE_ISNOT or now_state == MONOSHIRI_STATE_DEAD  then--まだいない
		InvalidBackRead( proxy , 686 );--物織り無効化
		proxy:SetEventFlag( 343, true );
		
	end
	
--▲物織り関連▲-----------------------------]]

--------------------------------------------------------------------------------
--[[NPC付随OBJ関連]]
--------------------------------------------------------------------------------
--■180■神の信徒3のOBJ■
	if proxy:IsCompleteEvent( 323 ) == true then
		--OBJの表示・アタリをなくす
		proxy:SetDrawEnable( 1160, false );
		proxy:SetColiEnable( 1160, false );
		--SFXを消す
		proxy:InvalidSfx( 2160, false );
		--ポイントライトを消す
		proxy:InvalidPointLight( 2140 );
		--フラグをセットする
		proxy:SetEventFlag( 180, true );
	end
--■181■神の信徒2のOBJ■
	if proxy:IsCompleteEvent( 333 ) == true then
		--OBJの表示・アタリをなくす
		proxy:SetDrawEnable( 1161, false );
		proxy:SetColiEnable( 1161, false );
		--SFXを消す
		proxy:InvalidSfx( 2161, false );
		--ポイントライトを消す
		proxy:InvalidPointLight( 2141 );
		--フラグをセットする
		proxy:SetEventFlag( 181, true );
	end
--■182■ロガーンのOBJ■
	if proxy:IsCompleteEvent( 224 ) == true then
		--OBJの表示・アタリをなくす
		proxy:SetDrawEnable( 1162, false );
		proxy:SetColiEnable( 1162, false );
		--SFXを消す
		proxy:InvalidSfx( 2162, false );
		--ポイントライトを消す
		proxy:InvalidPointLight( 2142 );
		--フラグをセットする
		proxy:SetEventFlag( 182, true );
	else
		proxy:SetEventFlag( 182, false );
	end
--■183■魔術の徒のOBJ■
	if proxy:IsCompleteEvent( 313 ) == true then
		--OBJの表示・アタリをなくす
		proxy:SetDrawEnable( 1163, false );
		proxy:SetColiEnable( 1163, false );
		--SFXを消す
		proxy:InvalidSfx( 2163, false );
		--ポイントライトを消す
		proxy:InvalidPointLight( 2143 );
		--フラグをセットする
		proxy:SetEventFlag( 183, true );
	end
--■184■魔女のOBJ■
	if proxy:IsCompleteEvent( 263 ) == true then
		--OBJの表示・アタリをなくす
		proxy:SetDrawEnable( 1164, false );
		proxy:SetColiEnable( 1164, false );
		--SFXを消す
		proxy:InvalidSfx( 2164, false );
		--ポイントライトを消す
		proxy:InvalidPointLight( 2144 );
		--フラグをセットする
		proxy:SetEventFlag( 184, true );
	else
		proxy:SetEventFlag( 184, false );
	end
--■185■ウルベインのOBJ■
	if proxy:IsCompleteEvent( 273 ) == true then
		--OBJの表示・アタリをなくす
		proxy:SetDrawEnable( 1165, false );
		proxy:SetColiEnable( 1165, false );
		--SFXを消す
		proxy:InvalidSfx( 2165, false );
		proxy:InvalidSfx( 2190, false );
		proxy:InvalidSfx( 2191, false );
		proxy:InvalidSfx( 2192, false );
		--ポイントライトを消す
		proxy:InvalidPointLight( 2145 );
		--フラグをセットする
		proxy:SetEventFlag( 185, true );
	else
		proxy:SetEventFlag( 185, false );
	end
--■186■ボールドウィンのOBJ■
	if proxy:IsCompleteEvent( 392 ) == true then
		--OBJの表示・アタリをなくす
		proxy:SetDrawEnable( 1166, false );
		proxy:SetColiEnable( 1166, false );
		proxy:SetDrawEnable( 1180, false );
		proxy:SetColiEnable( 1180, false );
		proxy:SetDrawEnable( 1181, false );
		proxy:SetColiEnable( 1181, false );
		proxy:SetDrawEnable( 1182, false );
		proxy:SetColiEnable( 1182, false );
		
		--SFXを消す
		proxy:InvalidSfx( 2166, false );
		--ポイントライトを消す
		proxy:InvalidPointLight( 2146 );
		--フラグをセットする
		proxy:SetEventFlag( 186, true );
		--マップヒットの無効化
		proxy:SetDrawEnableArray( 1080,false);
		proxy:SetColiEnableArray( 1080,false);
		
	end
--■187■大袋のトマスのOBJ■
	if proxy:IsCompleteEvent( 352 ) == true then
		--OBJの表示・アタリをなくす
		proxy:SetDrawEnable( 1167, false );
		proxy:SetColiEnable( 1167, false );
		
		proxy:SetDrawEnable( 1185, false );
		proxy:SetColiEnable( 1185, false );
		proxy:SetDrawEnable( 1186, false );
		proxy:SetColiEnable( 1186, false );
		proxy:SetDrawEnable( 1187, false );
		proxy:SetColiEnable( 1187, false );
		
		--SFXを消す
		proxy:InvalidSfx( 2167, false );
		--ポイントライトを消す
		proxy:InvalidPointLight( 2147 );
		--フラグをセットする
		proxy:SetEventFlag( 187, true );
		--マップヒットの無効化
		proxy:SetDrawEnableArray( 1081,false);
		proxy:SetColiEnableArray( 1081,false);
	else
		proxy:SetEventFlag( 187, false );
	end
--■188■物識りのOBJ■
	--削除

--■189■ビヨのOBJ■
	if proxy:IsCompleteEvent( 244 ) == true then
		--OBJの表示・アタリをなくす
		proxy:SetDrawEnable( 1169, false );
		proxy:SetColiEnable( 1169, false );
		--フラグをセットする
		proxy:SetEventFlag( 189, true );
	else
		proxy:SetEventFlag( 189, false );
	end
--■190■レンドル王子のOBJ■
	if proxy:IsCompleteEvent( 232 ) == true then
		--OBJの表示・アタリをなくす
		proxy:SetDrawEnable( 1170, false );
		proxy:SetColiEnable( 1170, false );
		--フラグをセットする
		proxy:SetEventFlag( 190, true );
	else
		proxy:SetEventFlag( 190, false );
	end
--■191■パッチのOBJ■
	if proxy:IsCompleteEvent( 293 ) == true then
		--OBJの表示・アタリをなくす
		proxy:SetDrawEnable( 1171, false );
		proxy:SetColiEnable( 1171, false );
		--フラグをセットする
		proxy:SetEventFlag( 191, true );
	else
		proxy:SetEventFlag( 191, false );
	end
--■192■ユルトのOBJ■
	if proxy:IsCompleteEvent( 282 ) == true then
		--OBJの表示・アタリをなくす
		proxy:SetDrawEnable( 1172, false );
		proxy:SetColiEnable( 1172, false );
		--フラグをセットする
		proxy:SetEventFlag( 192, true );
	else
		proxy:SetEventFlag( 192, false );
	end
	
--[[■188■物識りのOBJ■
	if proxy:IsCompleteEvent( 343 ) == true then
		--OBJの表示・アタリをなくす
		proxy:SetDrawEnable( 1168, false );
		proxy:SetColiEnable( 1168, false );
		--SFXを消す
		proxy:InvalidSfx( 2168, false );
		--ポイントライトを消す
		proxy:InvalidPointLight( 2148 );
		--フラグをセットする
		proxy:SetEventFlag( 188, true );
	else
		proxy:SetEventFlag( 188, false );
	end]]

--------------------------------------------------------------------------------
--QWCの値によるNPCの会話変化判定用のフラグ
--------------------------------------------------------------------------------
	--■QWC■会話用フラグ１
	if proxy:IsSuccessQWC( 10100 ) == true then
		proxy:SetEventFlag(8040,true);--条件成立
	else
		proxy:SetEventFlag(8040,false);--条件未成立
	end
	
	--■QWC■会話用フラグ２
	if proxy:IsSuccessQWC( 10200 ) == true then
		proxy:SetEventFlag(8041,true);--条件成立
	else
		proxy:SetEventFlag(8041,false);--条件未成立
	end
	
	--■QWC■会話用フラグ3
	if proxy:IsSuccessQWC( 10300 ) == true then
		proxy:SetEventFlag(8042,true);--条件成立
	else
		proxy:SetEventFlag(8042,false);--条件未成立
	end
	
	--■QWC■会話用フラグ4
	if proxy:IsSuccessQWC( 10400 ) == true then
		proxy:SetEventFlag(8043,true);--条件成立
	else
		proxy:SetEventFlag(8043,false);--条件未成立
	end
	
	--■QWC■会話用フラグ5
	if proxy:IsSuccessQWC( 10500 ) == true then
		proxy:SetEventFlag(8044,true);--条件成立
	else
		proxy:SetEventFlag(8044,false);--条件未成立
	end
	
--■飛竜の撤退解除■
	if proxy:IsCompleteEvent(TYO_STATE_ESCAPE) == true then
		SetNpcStateFlag( proxy, param, tyo1_flag_list, TYO_STATE_SLEEPING );
	end
	if proxy:IsCompleteEvent(KENZOKU_STATE_ESCAPE) == true then
		SetNpcStateFlag( proxy, param, kenzoku_flag_list, KENZOKU_STATE_WARNING );
	end
	
	
	--HpMpSpMax
	--proxy:PlayerParamRecover();
	--proxy:PlayerRecover();

	--■■■	
	--proxy:OnKeyTime2( 9999990,"OnEvent_9999990",0.5,0,0,once);
	
	--proxy:LuaCall( 99999,0,"OnEvent_9999990",everytime);
	if proxy:IsDbgReLoad() == true then
		proxy:OnKeyTime2( 4021,"OnEvent_DbgReLoad",1.0,0,0,once);
	end
	print("Initialize_m01_00_00_00 end");
end

--[[
--トゥルーデス判定
function OnEvent_9999990(proxy,param)
	print("OnEvent_9999990 begin");
	--proxy:DropItemExceedWeightLimit();
		--HpMpSpMax
	--proxy:PlayerParamRecover();
	proxy:PlayerRecover();
	print("OnEvent_9999990 end");
end
]]

--リロードデバッグ　ランダムで各マップに
function OnEvent_DbgReLoad(proxy,param)
	local rand = proxy:GetRandom( 2,6 );
	--2～6の3以外はブロック0に
	if rand ~= 3 then
		--完全回復要求
		proxy:RequestFullRecover();
		proxy:WarpNextStage( rand, 0, 0, 0, 999 );
	elseif rand == 3 then--3はブロック1に飛ぶ
		--完全回復要求
		proxy:RequestFullRecover();
		proxy:WarpNextStage( rand, 1, 0, 0, 999 );
	end
end


--------------------------------------------------------------------------------------
--■各エリアへワープ(王城)■
--------------------------------------------------------------------------------------
--■0■各エリアへワープ(王城1)■
--新しいワープ方法
function OnEvent_0(proxy, param)
	print("OnEvent_0 begin");
	
	if proxy:IsCompleteEvent( 0 ) == true then
		print("OnEvent_0 end");
		return;
	end	
	proxy:SetEventFlag( 0, true );--ワープメニュー選択の多重発動を防止ON
	
	local areaNum = 2;
	local blockNum = 1;
		
	--ここで進行フラグを判定して表示ブロック数を設定すること
	if proxy:IsCompleteEvent(4103) == true then
		blockNum = 2;--王城2開放
	end
	
	if proxy:IsCompleteEvent(4252) == true then
		blockNum = 3;--王城3開放		
	end
	
	if proxy:IsCompleteEvent(4372) == true then
		blockNum = 4;--王城4開放
	end
	
	if proxy:IsCompleteEvent(4503) == true then
		blockNum = 5;--王城5開放
	end	
	
	proxy:RepeatMessage_begin();
		proxy:OnWarpMenuClose(0,"OnEvent_0_0",areaNum,blockNum,once);	
	proxy:RepeatMessage_end();
		
	print("OnEvent_0 end");
end


function OnEvent_0_0(proxy, param)
	print("OnEvent_0_0 begin");

	--ワープメニュ－の選択を取得
	local retval = proxy:GetWarpMenuResult();
	
	--ワープがキャンセルされた場合は、アニメを再生しない
	if retval == -1 then
		OnEvent_0_2(proxy, param);
		return;
	end
	
	proxy:WarpDmy( 10000 , 1000 , 191 );
	proxy:PlayAnimation( 10000 , 8283 );--要石に触れるアニメを再生
	
	proxy:NotNetMessage_begin();
		--▼要石に触れるアニメ再生終了▼
		proxy:OnChrAnimEnd( SYSTEM_WARP , 10000 , 8283 , "OnEvent_0_1" , once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_0_0 end");
end

--▲0_1▲要石に触れるアニメ再生終了▲
function OnEvent_0_1(proxy,param)
	print("OnEvent_0_1 begin");
	
	proxy:PlayAnimation( 10000 , 8284 );--自世界に帰るアニメを再生
	
	--待機アニメ待ちが無くなったので直接呼び出す
	OnEvent_0_2(proxy,param);
	--[[
	proxy:NotNetMessage_begin();
		--▼自世界に帰るアニメ再生終了▼
		proxy:OnChrAnimEnd( SYSTEM_WARP , 10000 , 8284 , "OnEvent_0_2" , once );
	proxy:NotNetMessage_end();
	]]
	print("OnEvent_0_1 end");
end


function OnEvent_0_2(proxy,param)
	print("OnEvent_0_2 begin");
	
	proxy:SetEventFlag( 0, false );--ワープメニュー選択の多重発動を防止OFF

	--ワープメニュ－の選択を取得
	local retval = proxy:GetWarpMenuResult();
	if retval == -1 then
		print("Warp Cancel");
		print("OnEvent_0_2 end");
		return;
	elseif retval == 0 then
		--完全回復要求
		proxy:RequestFullRecover();
		proxy:WarpNextStage( 2, 0, 0, 0, 999 );
		SetNpcStateFlag(proxy,param, warp_list , GO_TO_WARP_OUJOU );
		print("Warp Block1");
		print("OnEvent_0_2 end");
		return;
	elseif retval == 1 then
		--完全回復要求
		proxy:RequestFullRecover();
		proxy:WarpNextStage( 2, 0, 0, 0, 998 );
		SetNpcStateFlag(proxy,param, warp_list , GO_TO_WARP_OUJOU );
		print("Warp Block2");
		print("OnEvent_0_2 end");
		return;
	elseif retval == 2 then
		--完全回復要求
		proxy:RequestFullRecover();
		proxy:WarpNextStage( 2, 1, 0, 0, 997 );
		SetNpcStateFlag(proxy,param, warp_list , GO_TO_WARP_OUJOU );
		print("Warp Block3");
		print("OnEvent_0_2 end");
		return;
	elseif retval == 3 then
		--完全回復要求
		proxy:RequestFullRecover();
		proxy:WarpNextStage( 2, 2, 0, 0, 996 );
		SetNpcStateFlag(proxy,param, warp_list , GO_TO_WARP_OUJOU );
		print("Warp Block4");
		print("OnEvent_0_2 end");
		return;		
	elseif retval == 4 then
		--完全回復要求
		proxy:RequestFullRecover();
		proxy:WarpNextStage( 2, 3, 0, 0, 995 );
		SetNpcStateFlag(proxy,param, warp_list , GO_TO_WARP_OUJOU );
		print("Warp Block5");
		print("OnEvent_0_2 end");
		return;
	end
	print("retval Error");
	print("OnEvent_0_2 end");
end


--------------------------------------------------------------------------------------
--■各エリアへワープ(古砦)■
--------------------------------------------------------------------------------------
--■1■各エリアへワープ(古砦2)■
--新しいワープ方法
function OnEvent_1(proxy,param)
	print("OnEvent_1 begin");

	if proxy:IsCompleteEvent( 1 ) == true then
		print("OnEvent_1 end");
		return;
	end
	
	if proxy:IsCompleteEvent( 8030 ) == false then
		--封印インフォメーション		
		--proxy:InfomationMenu( INFOMENU_TYPE_SIMPLE, 0, MSG_CATEGORY_EVENT, 10010190, 1);
		--proxy:ShowGenDialog(10010190,1,1,true);
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010190, 0, 6, 1001, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
		print("OnEvent_1 end");
		return;
	end
	
	proxy:SetEventFlag( 1, true );--ワープメニュー選択の多重発動を防止ON	
	
	local areaNum = 3;
	local blockNum = 1;
		
	--ここで進行フラグを判定して表示ブロック数を設定すること
	if proxy:IsCompleteEvent(4804) == true then
		blockNum = 2;--古砦2開放
	end
	
	if proxy:IsCompleteEvent(4874) == true then
		blockNum = 3;--古砦3開放		
	end
	
	if proxy:IsCompleteEvent(4996) == true then
		blockNum = 4;--古砦4開放		
	end	
	
	proxy:RepeatMessage_begin();
		proxy:OnWarpMenuClose(1,"OnEvent_1_0",areaNum,blockNum,once);	
	proxy:RepeatMessage_end();
	
	print("OnEvent_1 end");
end


function OnEvent_1_0(proxy, param)
	print("OnEvent_1_0 begin");

	--ワープメニュ－の選択を取得
	local retval = proxy:GetWarpMenuResult();
	
	--ワープがキャンセルされた場合は、アニメを再生しない	
	if retval == -1 then
		OnEvent_1_2(proxy, param);
		return;
	end
	
	proxy:WarpDmy( 10000 , 1001 , 191 );
	proxy:PlayAnimation( 10000 , 8283 );--要石に触れるアニメを再生
	
	proxy:NotNetMessage_begin();
		--▼要石に触れるアニメ再生終了▼
		proxy:OnChrAnimEnd( SYSTEM_WARP , 10000 , 8283 , "OnEvent_1_1" , once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_1_0 end");
end

--▲1_1▲要石に触れるアニメ再生終了▲
function OnEvent_1_1(proxy, param)
	print("OnEvent_1_1 begin");
	proxy:PlayAnimation( 10000 , 8284 );--自世界に帰るアニメを再生
	
	--待機アニメ待ちが無くなったので直接呼び出す
	OnEvent_1_2(proxy,param);
	--[[
	proxy:NotNetMessage_begin();
		--▼自世界に帰るアニメ再生終了▼
		proxy:OnChrAnimEnd( SYSTEM_WARP , 10000 , 8284 , "OnEvent_1_2" , once );
	proxy:NotNetMessage_end();
]]
	print("OnEvent_1_1 end");
end
	

function OnEvent_1_2(proxy, param)
	print("OnEvent_1_2 begin");
	
	proxy:SetEventFlag( 1, false );--ワープメニュー選択の多重発動を防止OFF
	
	--2008.05.06 toyohide 古砦のアイテム交換イベント用のアクションIDチェック
	if proxy:IsCompleteEvent(12613) == true then
		proxy:SetEventFlag(12614,true);
	end
	
	--ワープメニュ－の選択を取得
	local retval = proxy:GetWarpMenuResult();
	if retval == -1 then
		print("Warp Cancel");
		print("OnEvent_1_2 end");
		return;
	elseif retval == 0 then
		--完全回復要求
		proxy:RequestFullRecover();
		proxy:WarpNextStage( 3, 1, 0, 0, 999 );
		SetNpcStateFlag(proxy,param, warp_list , GO_TO_WARP_FURUTORIDE );
		print("Warp Block1");
		print("OnEvent_1_2 end");
		return;
	elseif retval == 1 then
		--完全回復要求
		proxy:RequestFullRecover();
		proxy:WarpNextStage( 3, 1, 0, 0, 997 );
		SetNpcStateFlag(proxy,param, warp_list , GO_TO_WARP_FURUTORIDE );
		print("Warp Block2");
		print("OnEvent_1_2 end");
		return;
	elseif retval == 2 then
		--完全回復要求
		proxy:RequestFullRecover();
		proxy:WarpNextStage( 3, 2, 0, 0, 996 );
		SetNpcStateFlag(proxy,param, warp_list , GO_TO_WARP_FURUTORIDE );
		print("Warp Block3");
		print("OnEvent_1_2 end");
		return;	
	elseif retval == 3 then
		--完全回復要求
		proxy:RequestFullRecover();
		proxy:WarpNextStage( 3, 3, 0, 0, 995 );
		SetNpcStateFlag(proxy,param, warp_list , GO_TO_WARP_FURUTORIDE );
		print("Warp Block4");
		print("OnEvent_1_2 end");
		return;	
	end
	print("retval Error");	
	print("OnEvent_1_2 end");
end

--------------------------------------------------------------------------------------
--■各エリアへワープ(牢城)■
--------------------------------------------------------------------------------------
--新しいワープ
function OnEvent_2(proxy,param)
	print("OnEvent_2 begin");

	if proxy:IsCompleteEvent( 2 ) == true then
		print("OnEvent_2 end");
		return;
	end
	
	if proxy:IsCompleteEvent( 8030 ) == false then
		--封印インフォメーション		
		--proxy:InfomationMenu( INFOMENU_TYPE_SIMPLE, 0, MSG_CATEGORY_EVENT, 10010190, 1);
		--proxy:ShowGenDialog(10010190,1,1,true);
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010190, 0, 6, 1002, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
		print("OnEvent_2 end");
		return;
	end
	proxy:SetEventFlag( 2, true );--ワープメニュー選択の多重発動を防止ON	
	
	local areaNum = 4;
	local blockNum = 1;
		
	--ここで進行フラグを判定して表示ブロック数を設定すること
	if proxy:IsCompleteEvent(5121) == true then
		blockNum = 2;--牢城2開放
	end
	
	if proxy:IsCompleteEvent(5261) == true then
		blockNum = 3;--牢城3開放		
	end
	
	if proxy:IsCompleteEvent(5381) == true then
		blockNum = 4;--牢城4開放	
	end
	
	proxy:RepeatMessage_begin();
		proxy:OnWarpMenuClose(2,"OnEvent_2_0",areaNum,blockNum,once);	
	proxy:RepeatMessage_end();
	
	print("OnEvent_2 begin");
end


function OnEvent_2_0(proxy, param)
	print("OnEvent_2_0 begin");

	--ワープメニュ－の選択を取得
	local retval = proxy:GetWarpMenuResult();
	
	--ワープがキャンセルされた場合は、アニメを再生しない	
	if retval == -1 then
		OnEvent_2_2(proxy, param);
		return;
	end
	
	proxy:WarpDmy( 10000 , 1002 , 191 );
	proxy:PlayAnimation( 10000 , 8283 );--要石に触れるアニメを再生
	
	proxy:NotNetMessage_begin();
		--▼要石に触れるアニメ再生終了▼
		proxy:OnChrAnimEnd( SYSTEM_WARP , 10000 , 8283 , "OnEvent_2_1" , once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_2_0 end");
end

--▲2_1▲要石に触れるアニメ再生終了▲
function OnEvent_2_1(proxy, param)
	print("OnEvent_2_1 begin");	

	proxy:PlayAnimation( 10000 , 8284 );--自世界に帰るアニメを再生
	
	--待機アニメ待ちが無くなったので直接呼び出す
	OnEvent_2_2(proxy,param);
	--[[
	proxy:NotNetMessage_begin();
		--▼自世界に帰るアニメ再生終了▼
		proxy:OnChrAnimEnd( SYSTEM_WARP, 10000 , 8284 , "OnEvent_2_2" , once );
	proxy:NotNetMessage_end();
	]]
	print("OnEvent_2_1 end");
end

--■2■各エリアへワープ(牢城1)■
function OnEvent_2_2(proxy, param)
	print("OnEvent_2_2 begin");		
	
	proxy:SetEventFlag( 2, false );--ワープメニュー選択の多重発動を防止OFF	
	
	--ワープメニュ－の選択を取得
	local retval = proxy:GetWarpMenuResult();
	if retval == -1 then
		print("Warp Cancel");
		print("OnEvent_2_2 end");
		return;
	elseif retval == 0 then
		--完全回復要求
		proxy:RequestFullRecover();
		proxy:WarpNextStage( 4, 0, 0, 0, 999 );
		SetNpcStateFlag(proxy,param, warp_list , GO_TO_WARP_ROUJOU );
		print("Warp Block1");
		print("OnEvent_2_2 end");
		return;
	elseif retval == 1 then
		--完全回復要求
		proxy:RequestFullRecover();
		proxy:WarpNextStage( 4, 1, 0, 0, 998 );
		SetNpcStateFlag(proxy,param, warp_list , GO_TO_WARP_ROUJOU );
		print("Warp Block2");
		print("OnEvent_2_2 end");
		return;
	elseif retval == 2 then
		--完全回復要求
		proxy:RequestFullRecover();
		proxy:WarpNextStage( 4, 1, 0, 0, 997 );
		SetNpcStateFlag(proxy,param, warp_list , GO_TO_WARP_ROUJOU );
		print("Warp Block3");
		print("OnEvent_2_2 end");
		return;	
	elseif retval == 3 then
		--完全回復要求
		proxy:RequestFullRecover();
		proxy:WarpNextStage( 4, 2, 0, 0, 996 );
		SetNpcStateFlag(proxy,param, warp_list , GO_TO_WARP_ROUJOU );
		print("Warp Block4");
		print("OnEvent_2_2 end");
		return;	
	end
	print("retval Error");		
	print("OnEvent_2_2 end");
end



--------------------------------------------------------------------------------------
--■各エリアへワープ(不浄)■
--------------------------------------------------------------------------------------
--新しいワープ
function OnEvent_3(proxy,param)
	print("OnEvent_3 begin");

	if proxy:IsCompleteEvent( 3 ) == true then
		print("OnEvent_3 end");
		return;
	end
	
	if proxy:IsCompleteEvent( 8030 ) == false then
		--封印インフォメーション		
		--proxy:InfomationMenu( INFOMENU_TYPE_SIMPLE, 0, MSG_CATEGORY_EVENT, 10010190, 1);
		--proxy:ShowGenDialog(10010190,1,1,true);
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010190, 0, 6, 1003, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
		print("OnEvent_3 end");
		return;
	end
	
	proxy:SetEventFlag( 3, true );--ワープメニュー選択の多重発動を防止ON	
	
	local areaNum = 5;
	local blockNum = 1;
		
	--ここで進行フラグを判定して表示ブロック数を設定すること
	if proxy:IsCompleteEvent(5653) == true then
		blockNum = 2;--不浄2開放
	end
	
	if proxy:IsCompleteEvent(5773) == true then
		blockNum = 3;--不浄3開放		
	end
	
	if proxy:IsCompleteEvent(5893) == true then
		blockNum = 4;--不浄4開放		
	end	
	
	proxy:RepeatMessage_begin();
		proxy:OnWarpMenuClose(3,"OnEvent_3_0",areaNum,blockNum,once);	
	proxy:RepeatMessage_end();	
	
	print("OnEvent_3 end");
end


function OnEvent_3_0(proxy, param)
	print("OnEvent_3_0 begin");

	--ワープメニュ－の選択を取得
	local retval = proxy:GetWarpMenuResult();
	
	--ワープがキャンセルされた場合は、アニメを再生しない	
	if retval == -1 then
		OnEvent_3_2(proxy, param);
		return;
	end
	
	proxy:WarpDmy( 10000 , 1003 , 191 );
	proxy:PlayAnimation( 10000 , 8283 );--要石に触れるアニメを再生
	
	proxy:NotNetMessage_begin();
		--▼要石に触れるアニメ再生終了▼
		proxy:OnChrAnimEnd( SYSTEM_WARP , 10000 , 8283 , "OnEvent_3_1" , once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_3_0 end");
end

--▲3_1▲要石に触れるアニメ再生終了▲
function OnEvent_3_1(proxy, param)
	print("OnEvent_3_1 begin");
	
	proxy:PlayAnimation( 10000 , 8284 );--自世界に帰るアニメを再生
	
	--待機アニメ待ちが無くなったので直接呼び出す
	OnEvent_3_2(proxy,param);
	--[[
	proxy:NotNetMessage_begin();
		--▼自世界に帰るアニメ再生終了▼
		proxy:OnChrAnimEnd( SYSTEM_WARP , 10000 , 8284 , "OnEvent_3_2" , once );
	proxy:NotNetMessage_end();
	]]
	print("OnEvent_3_1 end");
end

--■3■各エリアへワープ(不浄)■
function OnEvent_3_2(proxy, param)
	print("OnEvent_3_2 begin");		

	proxy:SetEventFlag( 3, false );--ワープメニュー選択の多重発動を防止OFF

	--ワープメニュ－の選択を取得
	local retval = proxy:GetWarpMenuResult();
	if retval == -1 then
		print("Warp Cancel");
		print("OnEvent_3_2 end");
		return;
	elseif retval == 0 then
		--完全回復要求
		proxy:RequestFullRecover();
		proxy:WarpNextStage( 5, 0, 0, 0, 999 );
		SetNpcStateFlag(proxy,param, warp_list , GO_TO_WARP_FUJOU );
		print("Warp Block1");
		print("OnEvent_3_2 end");
		return;
	elseif retval == 1 then		
		--完全回復要求
		proxy:RequestFullRecover();
		proxy:WarpNextStage( 5, 0, 0, 0, 998 );
		SetNpcStateFlag(proxy,param, warp_list , GO_TO_WARP_FUJOU );
		print("Warp Block2");
		print("OnEvent_3_2 end");
		return;
	elseif retval == 2 then
		--完全回復要求
		proxy:RequestFullRecover();
		proxy:WarpNextStage( 5, 1, 0, 0, 997 );
		SetNpcStateFlag(proxy,param, warp_list , GO_TO_WARP_FUJOU );
		print("Warp Block3");
		print("OnEvent_3_2 end");
		return;	
	elseif retval == 3 then
		--完全回復要求
		proxy:RequestFullRecover();
		proxy:WarpNextStage( 5, 2, 0, 0, 996 );
		SetNpcStateFlag(proxy,param, warp_list , GO_TO_WARP_FUJOU );
		print("Warp Block4");
		print("OnEvent_3_2 end");
		return;	
	end
	print("retval Error");			
	print("OnEvent_3_2 end");
end


--------------------------------------------------------------------------------------
--■各エリアへワープ(坑道)■
--------------------------------------------------------------------------------------
function OnEvent_4(proxy,param)
	print("OnEvent_4 begin");

	if proxy:IsCompleteEvent( 4 ) == true then
		print("OnEvent_4 end");
		return;
	end
	
	if proxy:IsCompleteEvent( 8030 ) == false then
		--封印インフォメーション		
		--proxy:InfomationMenu( INFOMENU_TYPE_SIMPLE, 0, MSG_CATEGORY_EVENT, 10010190, 1);
		--proxy:ShowGenDialog(10010190,1,1,true);
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010190, 0, 6, 1004, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
		print("OnEvent_4 end");
		return;
	end	
	
	proxy:SetEventFlag( 4, true );--ワープメニュー選択の多重発動を防止ON		
	
	local areaNum = 6;
	local blockNum = 1;
	
	--ここで進行フラグを判定して表示ブロック数を設定すること
	if proxy:IsCompleteEvent(6193) == true then
		blockNum = 2;--坑道2開放
	end
	
	if proxy:IsCompleteEvent(6283) == true then
		blockNum = 3;--坑道3開放		
	end
	
	if proxy:IsCompleteEvent(6403) == true then
		blockNum = 4;--坑道4開放		
	end	
	
	proxy:RepeatMessage_begin();
		proxy:OnWarpMenuClose(4,"OnEvent_4_0",areaNum,blockNum,once);	
	proxy:RepeatMessage_end();	
	
	print("OnEvent_4 end");
end


function OnEvent_4_0(proxy, param)
	print("OnEvent_4_0 begin");

	--ワープメニュ－の選択を取得
	local retval = proxy:GetWarpMenuResult();
	
	--ワープがキャンセルされた場合は、アニメを再生しない	
	if retval == -1 then
		OnEvent_4_2(proxy, param);
		return;
	end
	
	proxy:WarpDmy( 10000 , 1004 , 191 );
	proxy:PlayAnimation( 10000 , 8283 );--要石に触れるアニメを再生
	
	proxy:NotNetMessage_begin();
		--▼要石に触れるアニメ再生終了▼
		proxy:OnChrAnimEnd( SYSTEM_WARP , 10000 , 8283 , "OnEvent_4_1" , once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_4_0 end");
end


--▲4_1▲要石に触れるアニメ再生終了▲
function OnEvent_4_1(proxy, param)
	print("OnEvent_4_1 begin");		

	proxy:PlayAnimation( 10000 , 8284 );--自世界に帰るアニメを再生
	
	--待機アニメ待ちが無くなったので直接呼び出す
	OnEvent_4_2(proxy,param);
	--[[
	proxy:NotNetMessage_begin();
		--▼自世界に帰るアニメ再生終了▼
		proxy:OnChrAnimEnd( SYSTEM_WARP , 10000 , 8284 , "OnEvent_4_2" , once );
	proxy:NotNetMessage_end();
	]]
	print("OnEvent_4_1 end");
end


--■4■各エリアへワープ(坑道1)■
function OnEvent_4_2(proxy, param)
	print("OnEvent_4_2 begin");		

	proxy:SetEventFlag( 4, false );--ワープメニュー選択の多重発動を防止OFF

	--ワープメニュ－の選択を取得
	local retval = proxy:GetWarpMenuResult();
	if retval == -1 then
		print("Warp Cancel");
		print("OnEvent_4_2 end");
		return;
	elseif retval == 0 then
		--完全回復要求
		proxy:RequestFullRecover();
		proxy:WarpNextStage( 6, 0, 0, 0, 999 );
		SetNpcStateFlag(proxy,param, warp_list , GO_TO_WARP_KOUDOU );
		print("Warp Block1");
		print("OnEvent_4_2 end");
		return;
	elseif retval == 1 then
		--完全回復要求
		proxy:RequestFullRecover();
		proxy:WarpNextStage( 6, 0, 0, 0, 998 );
		SetNpcStateFlag(proxy,param, warp_list , GO_TO_WARP_KOUDOU );
		print("Warp Block2");
		print("OnEvent_4_2 end");
		return;
	elseif retval == 2 then
		--完全回復要求
		proxy:RequestFullRecover();
		proxy:WarpNextStage( 6, 1, 0, 0, 997 );
		SetNpcStateFlag(proxy,param, warp_list , GO_TO_WARP_KOUDOU );
		print("Warp Block3");
		print("OnEvent_4_2 end");
		return;	
	elseif retval == 3 then
		--完全回復要求
		proxy:RequestFullRecover();
		proxy:WarpNextStage( 6, 2, 0, 0, 996 );
		SetNpcStateFlag(proxy,param, warp_list , GO_TO_WARP_KOUDOU );
		print("Warp Block4");
		print("OnEvent_4_2 end");
		return;
	end
	print("retval Error");	
	print("OnEvent_4_2 end");
end


--
--------------------------------------------------------------------------------------
--■各エリアへワープ(北限)■
--------------------------------------------------------------------------------------
function OnEvent_5(proxy,param)
	print("OnEvent_5 begin");

	if proxy:IsCompleteEvent( 5 ) == true then
		print("OnEvent_5 end");
		return;
	end
	
	local bflag = false;
	if bflag == false then
		--封印インフォメーション		
		--proxy:InfomationMenu( INFOMENU_TYPE_SIMPLE, 0, MSG_CATEGORY_EVENT, 10010190, 1);
		--proxy:ShowGenDialog(10010190,1,1,true);
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010190, 0, 6, 1005, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
		print("OnEvent_5 end");
		--北限は封印が解けません
		return;
	end
	proxy:SetEventFlag( 5, true );--ワープメニュー選択の多重発動を防止ON		
	
	local areaNum = 7;
	local blockNum = 1;
	
	--ここで進行フラグを判定して表示ブロック数を設定すること
	--[[
	if proxy:IsCompleteEvent(6193) == true then
		blockNum = 2;--坑道2開放
	end
	
	if proxy:IsCompleteEvent(6283) == true then
		blockNum = 3;--坑道3開放		
	end
	
	if proxy:IsCompleteEvent(6403) == true then
		blockNum = 4;--坑道4開放		
	end	
	]]
	proxy:RepeatMessage_begin();
		proxy:OnWarpMenuClose(5,"OnEvent_5_0",areaNum,blockNum,once);	
	proxy:RepeatMessage_end();	
	
	print("OnEvent_5 end");
end


function OnEvent_5_0(proxy, param)
	print("OnEvent_5_0 begin");

	--ワープメニュ－の選択を取得
	local retval = proxy:GetWarpMenuResult();
	
	--ワープがキャンセルされた場合は、アニメを再生しない	
	if retval == -1 then
		OnEvent_5_2(proxy, param);
		return;
	end
	
	--proxy:WarpDmy( 10000 , 1004 , 191 );
	proxy:PlayAnimation( 10000 , 8283 );--要石に触れるアニメを再生
	
	proxy:NotNetMessage_begin();
		--▼要石に触れるアニメ再生終了▼
		proxy:OnChrAnimEnd( SYSTEM_WARP , 10000 , 8283 , "OnEvent_5_1" , once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_5_0 end");
end


--▲5_1▲要石に触れるアニメ再生終了▲
function OnEvent_5_1(proxy, param)
	print("OnEvent_5_1 begin");		

	proxy:PlayAnimation( 10000 , 8284 );--自世界に帰るアニメを再生
	
	--待機アニメ待ちが無くなったので直接呼び出す
	OnEvent_5_2(proxy,param);
	--[[
	proxy:NotNetMessage_begin();
		--▼自世界に帰るアニメ再生終了▼
		proxy:OnChrAnimEnd( SYSTEM_WARP , 10000 , 8284 , "OnEvent_4_2" , once );
	proxy:NotNetMessage_end();
	]]
	print("OnEvent_5_1 end");
end


--■4■各エリアへワープ(北限)■
function OnEvent_5_2(proxy, param)
	print("OnEvent_5_2 begin");		

	proxy:SetEventFlag( 5, false );--ワープメニュー選択の多重発動を防止OFF

	--ワープメニュ－の選択を取得
	local retval = proxy:GetWarpMenuResult();
	if retval == -1 then
		print("Warp Cancel");
		print("OnEvent_5_2 end");
		return;
	elseif retval == 0 then
		--完全回復要求
		--proxy:RequestFullRecover();
		--proxy:WarpNextStage( 6, 0, 0, 0, 999 );
		--SetNpcStateFlag(proxy,param, warp_list , GO_TO_WARP_HOKUGEN );
		print("Warp Block1");
		print("OnEvent_5_2 end");
		return;
	elseif retval == 1 then
		--完全回復要求
		--proxy:RequestFullRecover();
		--proxy:WarpNextStage( 6, 0, 0, 0, 998 );
		--SetNpcStateFlag(proxy,param, warp_list , GO_TO_WARP_HOKUGEN );
		print("Warp Block2");
		print("OnEvent_5_2 end");
		return;
	elseif retval == 2 then
		--完全回復要求
		--proxy:RequestFullRecover();
		--proxy:WarpNextStage( 6, 0, 0, 0, 997 );
		--SetNpcStateFlag(proxy,param, warp_list , GO_TO_WARP_HOKUGEN );
		print("Warp Block3");
		print("OnEvent_5_2 end");
		return;	
	elseif retval == 3 then
		--完全回復要求
		--proxy:RequestFullRecover();
		--proxy:WarpNextStage( 6, 0, 0, 0, 996 );
		--SetNpcStateFlag(proxy,param, warp_list , GO_TO_WARP_HOKUGEN );
		print("Warp Block4");
		print("OnEvent_5_2 end");
		return;
	end
	print("retval Error");	
	print("OnEvent_5_2 end");
end
--

--------------------------------------------------------------------------------------
--徘徊デーモンの登場■20
--------------------------------------------------------------------------------------

--▼グローバルの死亡監視から呼ばれる(ソロ)
function PlayerDeath_m01_00_00_00(proxy, param)
	print("PlayerDeath_m01_00_00_00");
	
	LuaFunc_VisibleTheWanderingDemon(proxy, param, demon_id_list_m01_00_00_00);
	proxy:SetEventFlag( 20 , 1 );
	
	print("PlayerDeath_m01_00_00_00");
end

--▼グローバルの血文字復活から呼ばれる(ソロ)
function PlayerRevive_m01_00_00_00(proxy,param)
	print("PlayerRevive_m01_00_00_00");
	
	LuaFunc_InvisibleTheWanderingDemon(proxy, param, demon_id_list_m01_00_00_00);
	proxy:SetEventFlag( 20 , 0 );
	
	print("PlayerRevive_m01_00_00_00");
end



--------------------------------------------------------------------------------------
--■30■マップ紹介ポリ劇再生■
--------------------------------------------------------------------------------------

function OnEvent_30(proxy , param)
	print("OnEvent_30 begin");

	--▼マップ紹介ポリ劇再生
	proxy:RequestRemo(00010,REMO_FLAG,30,1);
	proxy:SetEventFlag( 30, true );

	print("OnEvent_30 end");
end


--■ポリ劇再生開始(フェード終了)
function OnEvent_30_RemoStart(proxy,param)
	print("OnEvent_30_RemoStart begin");
	--Mapもやもや一時的に無効化
	proxy:InvalidSfx( 2110 , false );
	print("OnEvent_30_RemoStart end");
end


--■ポリ劇再生終了(フェード終了)
function OnEvent_30_RemoFinish(proxy , param)
	print("OnEvent_30_RemoFinish begin");
	--石柱BGMを再生
	PlayBGM_SEKITYUU(proxy, param);
	print("石柱BGM再生");
	
	--PCの初期位置を最初だけ変更
	proxy:Warp( 10000 , 1205 );
	proxy:CamReset( 10000 , true );--カメラリセット
	
	if proxy:GetClearCount() == 0 then		
		proxy:OnKeyTime2( 32 , "OnEvent_32",0.1,0,0,once);
	else
		--2周目以降、クリアアイテムフラグON
		if proxy:IsClearItem() == true then
			if proxy:GetClearState() == CLEAR_STATE_GOODEND then
				proxy:OnKeyTime2( 32,"OnEvent_GoodSoul",0.0,0,10,once);
			elseif proxy:GetClearState() == CLEAR_STATE_BADEND then
				proxy:OnKeyTime2( 32,"OnEvent_BadSoul",0.0,0,20,once);
			end		
		end
	end
	
	--もやもやSFX再生
	proxy:ValidSfx( 2110 );
	print("OnEvent_30_RemoFinish end");
end


--------------------------------------------------------------------------------------
--■31■復活ポリ劇再生■
--------------------------------------------------------------------------------------
function OnEvent_31(proxy , param)
	print("OnEvent_31 begin");

	--▼マップ紹介ポリ劇再生
	proxy:RequestRemo(000015,REMO_FLAG,31,1);
	proxy:SetEventFlag( 31, true );

	print("OnEvent_31 end");
end


--■ポリ劇再生開始(フェード終了)
function OnEvent_31_RemoStart(proxy,param)
	print("OnEvent_31_RemoStart begin");	
	print("OnEvent_31_RemoStart end");
end


--■ポリ劇再生終了(フェード終了)
function OnEvent_31_RemoFinish(proxy , param)
	print("OnEvent_31_RemoFinish begin");
	--石柱BGMを再生
	PlayBGM_SEKITYUU(proxy, param);
	print("石柱BGM再生");
	
	--ヒロイン座標あわせ
	proxy:Warp( 615 , 2206 );
	proxy:SetSpStayAndDamageAnimId( 615 , -1 , -1 );

	print("OnEvent_31_RemoFinish end");
end


--------------------------------------------------------------------------------------
--■39■魔方陣開放ポリ劇■
--------------------------------------------------------------------------------------
function OnEvent_39(proxy,param)
	--▼魔方陣開放ポリ劇
	proxy:RequestRemo(000006,REMO_FLAG,39,1);
	proxy:SetEventFlag( 39, true );
end

--■ポリ劇再生開始(フェード終了)
function OnEvent_39_RemoStart(proxy,param)
	print("OnEvent_39_RemoStart begin");	
	print("OnEvent_39_RemoStart end");
end


--■ポリ劇再生終了(フェード終了)
function OnEvent_39_RemoFinish(proxy , param)
	print("OnEvent_39_RemoFinish begin");
	--石柱BGMを再生
	PlayBGM_SEKITYUU(proxy, param);
	print("石柱BGM再生");
		
	proxy:SetDrawEnable( 1190 , false );--剣OBJ表示OFF
	proxy:SetColiEnable( 1190 , false );--剣OBJアタリOFF
		
	proxy:SetDrawEnable( 1200 , false );--魔方陣1OBJ表示OFF
	proxy:SetColiEnable( 1200 , false );--魔方陣1OBJアタリOFF
	proxy:SetDrawEnable( 1201 , false );--魔方陣2OBJ表示OFF
	proxy:SetColiEnable( 1201 , false );--魔方陣2OBJアタリOFF
	proxy:SetDrawEnable( 1202 , false );--魔方陣3OBJ表示OFF
	proxy:SetColiEnable( 1202 , false );--魔方陣3OBJアタリOFF
	proxy:SetDrawEnable( 1203 , false );--魔方陣4OBJ表示OFF
	proxy:SetColiEnable( 1203 , false );--魔方陣4OBJアタリOFF	
	
	proxy:SetEventResponsedNavimeshFlag_Disable();

	print("OnEvent_39_RemoFinish end");
end


--------------------------------------------------------------------------------------
--インフォ表示:死亡後1■32
--------------------------------------------------------------------------------------
function OnEvent_32(proxy,param)
	print("OnEvent_32 begin");
	--Display_InfomationMenu_2(proxy, 0, -1, 30, 84000100, 1, -1, 30, 84000101, 7);
	proxy:RequestOpenBriefingMsgPlus( 84000101 , true );
	--Lua_PauseTutorial(proxy);	
	proxy:OnKeyTime2( 32 , "OnEvent_32_1",0.1,0,1,once);	
	print("OnEvent_32 end");
end

--インフォメニューの表示消し待ち
function OnEvent_32_1(proxy,param)
	print("OnEvent_32_1 begin");
	proxy:OnRegistFunc( 32 , "Check_32_2","OnEvent_32_2",1,once);
	--proxy:SetEventFlag( 32 , true );	
	print("OnEvent_32_1 end");
end

--チェック
function Check_32_2(proxy)
	if proxy:IsShowMenu_BriefingMsg() == true then
		return false;
	end
	return true;
end

--インフォメニューを消したら次のインフォを出す
function OnEvent_32_2(proxy,param)
	print("OnEvent_32_2 begin");
	proxy:OnKeyTime2( 33 , "OnEvent_33",0.1,0,0,once);
	print("OnEvent_32_2 end");
end

--死亡後２　
function OnEvent_33(proxy,param)
	print("OnEvent_33 begin");
	--Display_InfomationMenu_2(proxy, 0, -1, 30, 84000110, 1, -1, 30, 84000111, 6);
	proxy:RequestOpenBriefingMsgPlus( 84000111 , true );
	proxy:OnKeyTime2( 33 , "OnEvent_33_1", 0.1 , 0 , 20, once);
	--Lua_PauseTutorial(proxy);	
	--proxy:SetEventFlag( 33 , true );
	print("OnEvent_33 end");
end

--待ち
function OnEvent_33_1(proxy,param)
	print("OnEvent_33_1 begin");
	proxy:OnRegistFunc( 37 , "Check_37","OnEvent_37",0,once);
	print("OnEvent_33_1 end");
end

--メニュー消えるの待ち
function Check_37(proxy)
	if proxy:IsShowMenu_BriefingMsg() == true then
		return false;
	end
	return true;
end

--インフォメニューが消えたらワープアイテム入手
function OnEvent_37(proxy,param)
	print("OnEvent_37 begin");
	proxy:GetRateItem( 10860 );
	proxy:SetEventFlag( 37 , true );
	print("OnEvent_37 end");
end

--GOODクリアソウル取得
function OnEvent_GoodSoul(proxy,param)
	print("OnEvent_GoodSoul begin");
	proxy:SetClearItem(false);
	proxy:GetRateItem( 10900 );	
	print("OnEvent_GoodSoul end");
end

--BADクリアソウル取得
function OnEvent_BadSoul(proxy,param)
	print("OnEvent_BadSoul begin");
	proxy:SetClearItem(false);
	proxy:GetRateItem( 10901 );	
	if proxy:IsInventoryEquip(TYPE_GOODS,9996) == false then	
		proxy:GetRateItem( 10902 );	
	end
	print("OnEvent_BadSoul end");
end

--------------------------------------------------------------------------------------
--■40■ラスボス部屋に行くまでの飛び降り、ポリ劇■
--------------------------------------------------------------------------------------

function OnEvent_40(proxy , param)
	print("OnEvent_40 begin");

	if proxy:IsCompleteEvent( 40 ) == true then
		print("OnEvent_40 end");
		return;
	end
	
	--現在の状態を取得
	local now_state = GetNpcStateFlag( proxy , param , heroine_flag_list );
	
	--状態が「決着をつけたい」でない場合、処理抜け。
	if now_state ~= HEROINE_STATE_WANT_TO_SETTLE then
		print("OnEvent_40 end");
		return;
	end
	
	if proxy:IsLand( 10000 ) == false then
		return;
	end
	
	--ポリ劇前に石柱のBGMの停止
	proxy:StopPointSE( 0 );--0のスロットにBGMが設定されている為
	print("--石柱BGM停止--");
	
	--▼ラスボス部屋に行くまでの飛び降り、ポリ劇
	proxy:RequestRemo(00001,REMO_FLAG,40,10	);
	print("OnEvent_40 end");
end


--■ポリ劇再生開始(フェード終了)
function OnEvent_40_RemoStart(proxy,param)
	print("OnEvent_40_RemoStart begin");
	proxy:Warp( 10000 , 2000 );--PCを所定の位置へワープ
	--proxy:SetHitInfo( 10000 , 1050 );
	proxy:CamReset( 10000 , true );--カメラリセット
	if proxy:IsAlive( 10000 ) == true then
		proxy:PlayerChrResetAnimation_RemoOnly(10000);
		proxy:ChrResetRequest(10000);
	end
	print("OnEvent_40_RemoStart end");
end


--■ポリ劇再生終了(フェード終了)
function OnEvent_40_RemoFinish(proxy , param)
	print("OnEvent_40_RemoFinish begin");	
	
	--proxy:Warp( 10000 , 2000 );--PCを所定の位置へワープ
	proxy:SetHitInfo( 10000 , 1050 );
	--proxy:CamReset( 10000 , true );--カメラリセット	
	
	LuaFunc_ForceOmission(proxy,615);
	proxy:SetAlwayEnableBackread_forEvent( 615 , true );
	proxy:SetSpStayAndDamageAnimId( 615 ,-1,-1);
	--ヒロインの強制バックリードを無効化
	proxy:OnKeyTime2( 40,"OnEvent_40_1",0.1,0,1,once);
	proxy:Warp( 615 , 2001 );--ヒロインを所定の位置へワープ
	proxy:ChangeInitPosAng( 615 , 2001 );--帰還場所を更新
	
	--ヒロインの状態フラグを「ついて行きます」にする
	SetNpcStateFlag(proxy, param, heroine_flag_list, HEROINE_STATE_WITH_A_FUTURE );

	--ヒロインのロジック切り替え →「祈る？」
	proxy:SendEventRequest( 615 , 0 , AI_EVENT_GRACE);
	proxy:ResetThink( 615 );	
	
	proxy:DeleteEvent( 40 );--everytimeなので消す
	
	proxy:SetEventFlag( 40,true);
	
	--要石見える
	proxy:SetColiEnable(1140,true);
	proxy:SetDrawEnable(1140,true);	
	proxy:SetColiEnable(1141,true);
	proxy:SetDrawEnable(1141,true);	

	--proxy:TreasureDispModeChange2( 1140 , true ,KANAME_SFX);
	proxy:TreasureDispModeChange2( 1141 , true ,KANAME_SFX);	
	--proxy:TreasureDispModeChange2( 1145 , true ,KANAME_SFX);
	proxy:TreasureDispModeChange2( 1146 , true ,KANAME_SFX);
	
	SingleReset(proxy,42);
	SingleReset(proxy,43);
	proxy:OnDistanceAction( 42,10000,1140,"OnEvent_42",WarpGimmickDist_A,HELPID_GO_TO_SEKITYUU,0,WarpGimmickAngle_B,everytime);
	proxy:OnDistanceAction( 43,10000,1145,"OnEvent_43",WarpGimmickDist_A,HELPID_GO_TO_SEKITYUU,0,WarpGimmickAngle_B,everytime);		
	
	OnEvent_60_RemoFinish(proxy,param);
	--proxy:SetEventFlag( 60 , true );
	
	print("OnEvent_40_RemoFinish end");
end

function OnEvent_40_1(proxy,param)
	print("OnEvent_40_1 begin");
	LuaFunc_NormalOmission(proxy,615);
	proxy:SetAlwayEnableBackread_forEvent( 615 , false );
	print("OnEvent_40_1 end");
end

--------------------------------------------------------------------------------------
--■60■拡散のモノが屈み込むポリ劇■
--------------------------------------------------------------------------------------

function OnEvent_60(proxy , param)
	print("OnEvent_60 begin");

	--▼拡散のモノが屈み込むポリ劇
	proxy:RequestRemo(2,REMO_FLAG,60,1);
	proxy:SetEventFlag( 60, true );

	print("OnEvent_60 end");
end


--■ポリ劇再生開始(フェード終了)
function OnEvent_60_RemoStart(proxy,param)
	print("OnEvent_60_RemoStart begin");
	print("OnEvent_60_RemoStart end");
end


--■ポリ劇再生終了(フェード終了)
function OnEvent_60_RemoFinish(proxy , param)
	print("OnEvent_60_RemoFinish begin");
	
	--マップパーツを有効化
	proxy:SetDrawEnableArray( 1020 , true );
	proxy:SetColiEnableArray( 1020 , true );
	
	proxy:SetDrawEnableArray( 1121 , true );
	proxy:SetColiEnableArray( 1121 , true );
	
	--マップパーツを無効化する
	proxy:SetDrawEnableArray( 1120 , false );
	proxy:SetColiEnableArray( 1120 , false );
	
	--木のオブジェを有効化する
	local first_id = 1030;
	local last_id  = 1058;
	local now_id   = first_id;
	local num      = last_id - first_id + 1;
	
	for i=1 , num , 1 do
		proxy:SetDrawEnable( now_id , true );--表示ON
		proxy:SetColiEnable( now_id , true );--当たりON
		now_id = now_id + 1;
	end
	
	--proxy:SetDrawEnable( 1190 , false );--追加OBJ表示OFF
	--proxy:SetColiEnable( 1190 , false );--追加OBJアタリOFF
		
	--対応する敵を有効化
	--削除
	
	--ボスを有効化
	ValidCharactor( proxy , 821 );
	
	--OBJを無効化
	proxy:SetDrawEnable( 1100 , false );
	proxy:SetColiEnable( 1100 , false );
	
	--OBJを無効化
	--proxy:SetDrawEnable( 1101 , false );
	--proxy:SetColiEnable( 1101 , false );
	
	--SFXを有効化
	proxy:ValidSfx( 1110 );
	
	print("OnEvent_60_RemoFinish end");
end




--------------------------------------------------------------------------------------
--■70■ラスボスを倒したら、ポリ劇を再生■
--------------------------------------------------------------------------------------

function OnEvent_70(proxy , param)
	print("OnEvent_70 begin");
	--アイテム入手(抽選ID10900)	
	--獣のDS廃止
	--proxy:GetRateItem( 10900 );
	--ソウルブランド廃止
	--proxy:GetRateItem(10730);--アイテム	
	proxy:NotNetMessage_begin();
		proxy:OnRegistFunc( 451 , "Check_451","OnEvent_451", 1 , once);
	proxy:NotNetMessage_end();
	
	proxy:SetEventFlag( 70, true );
	
	--ソウルブランド抜いてない
	if proxy:IsCompleteEvent( 141 ) == false then			
		--調べるイベント自体は同期します、調べれる人はホストorシングルプレイヤーです
		--proxy:NotNetMessage_begin();		
			
			proxy:OnKeyTime2( 141 , "OnEvent_141_WAIT",9.5,0,0,once);
			
			proxy:ValidSfx( 1131 );			
			--proxy:SetRarity( 1130, 10104 );
		--proxy:NotNetMessage_end();
	else
		proxy:SetDrawEnable( 1130 , false );--ひとまず描画だけOFF
		proxy:SetColiEnable( 1130 , false );			
		proxy:InvalidSfx( 1131 ,true );
	end

	print("OnEvent_70 end");
end



--------------------------------------------------------------------------------------
--■450■演出終了待ち■
--------------------------------------------------------------------------------------
--会話の終了待ち
function Check_451(proxy)
	if proxy:IsCompleteEvent( 9054 ) == false then
		return false;
	end
	return true;
end

--テキスト演出呼び出し
function OnEvent_451(proxy,param)
	proxy:CustomLuaCallStart( 450 , 821 );
end

----------------------------------------------------------------------------------------------------------------
--■450■石柱用ブロッククリア■
----------------------------------------------------------------------------------------------------------------
function OnEvent_450(proxy,param)	
	--自分のみ
	if param:IsNetMessage() == true then
		return;
	end	
	if proxy:IsCompleteEvent( 4047 ) == true then
		return;
	end
	print("OnEvent_450 begin");	
	SekiClearBossId = -1;
	SekiClearBossId = param:GetParam2();
	
	--SOSサインを一度クリア
	proxy:ClearSosSign();	
	--セッション数を記憶
	proxy:SetClearSesiionCount();	
	--ボスゲージをクリア
	proxy:ClearBossGauge();	
	--クリアボーナスを計算
	proxy:SetClearBonus(SekiClearBossId);
	
	--生存時
	if proxy:IsLivePlayer() == true then		
		proxy:SetTextEffect(TEXT_TYPE_KillDemon);
		proxy:NotNetMessage_begin();
			proxy:OnTextEffectEnd( 450 , TEXT_TYPE_KillDemon ,"OnEvent_450_effectEnd");
		proxy:NotNetMessage_end();
	--グレイ時
	elseif proxy:IsGreyGhost() == true then		
		proxy:SetTextEffect(TEXT_TYPE_KillDemon);
		proxy:SetTextEffect(TEXT_TYPE_Revival);
		proxy:OnTextEffectEnd( 450 , TEXT_TYPE_Revival ,"OnEvent_450_effectEnd");
		proxy:SetReviveWait( true );--復活待ち状態フラグを入れておく(グレイで抜けられてしまった時の為)
	end	
	
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 450, "OnEvent_450_1", 5.0, 0, 2, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_450 end");
end

function OnEvent_450_1(proxy,param)
	print("OnEvent_450_1 begin");
	
	if proxy:IsInParty() == true then
		print("ERROR! PTを組んでいる");
	else
		if proxy:IsLivePlayer() == true then
			proxy:NotNetMessage_begin();
				proxy:OnKeyTime2( 450, "Clear_450", 3.0, 0, 6, once );
			proxy:NotNetMessage_end();			
		--グレイ時
		elseif proxy:IsGreyGhost() == true then
			--めでたく復活
			proxy:RevivePlayer();
			proxy:SetReviveWait( false );--復活待ち状態フラグを下ろしておく
			--復活するのでペナルティで減少したパラメータを元に戻す(最大値のみ)
			proxy:EraseEventSpecialEffect( 10000, 101 );
			proxy:NotNetMessage_begin();
				proxy:OnKeyTime2( 450, "Clear_450", 6.0, 0, 6, once );
			proxy:NotNetMessage_end();
		end		
	end
	print("OnEvent_450_1 end");
end

function Clear_450(proxy,param)
	print("Clear_450 begin");
	proxy:GetSoloClearBonus(SekiClearBossId);
	print("Clear_450 end");
end

function OnEvent_450_effectEnd(proxy,param)
	print("OnEvent_450_effectEnd begin");
	proxy:SetEventFlag( 450 , true );
	print("OnEvent_450_effectEnd end");
end

--------------------------------------------------------------------------------------
--■71■ラスボスを倒したら、ポリ劇を再生■
--------------------------------------------------------------------------------------
function OnEvent_71(proxy , param)
	--会話フラグが立ってなかったら無視
	if proxy:IsCompleteEvent( 9054 ) == false then
		return;
	end
	
	--ポリ劇再生が立っていたら無視
	if proxy:IsCompleteEvent( 71 ) == true then
		return;
	end
	
	--演出終了してなければ無視
	if proxy:IsCompleteEvent( 450 ) == false then
		return;
	end
	print("OnEvent_71 begin");
	
	--proxy:InvalidSfx( 1991, true );
	
	--ボス戦BGMの再生をとめる
	proxy:StopPointSE( 1 );

	--▼ヒロインが祈るポリ劇
	proxy:RequestRemo(3,REMO_FLAG,71,1);
	proxy:SetEventFlag( 71, true );

	print("OnEvent_71 end");
end


--■ポリ劇再生開始(フェード終了)
function OnEvent_71_RemoStart(proxy,param)
	print("OnEvent_71_RemoStart begin");
	
	proxy:InvalidSfx( 1991, false );
	
	--ボス(821)を無効化する
	--InvalidCharactor( proxy, 821 );

	print("OnEvent_71_RemoStart end");
end


--■ポリ劇再生終了(フェード終了)
function OnEvent_71_RemoFinish(proxy , param)
	print("OnEvent_71_RemoFinish begin");
	
	--レンドル王の会話をボタン連打しまくった場合の応急処置的な？
	if proxy:IsCompleteEvent( 70 ) == false then
		OnEvent_70(proxy, param);	--OnEvent_70を呼び出す
	end
	
	--対象のSFXを表示させる
	proxy:ValidSfx( 1991 );
	
	--ヒロインを移動させる
	LuaFunc_ForceOmission(proxy,615);	
	proxy:SetAlwayEnableBackread_forEvent( 615 , true );	
	proxy:SetDisableGravity( 615,false );
	--ヒロインの強制バックリードを無効化
	proxy:OnKeyTime2( 40,"OnEvent_40_1",0.2,0,1,once);
	
	--proxy:Warp( 615 , 2002 );--ヒロインを所定の位置にワープ
	--proxy:RecoveryHeroin();
	proxy:SetAlive( 615 ,1.0);
	proxy:SetHp( 615 , 1.0 );--ヒロインHP全快
	proxy:WarpRestart( 615, 2002 );
	proxy:PlayerChrResetAnimation_RemoOnly( 615 );--禁断の補間切り	
	proxy:EnableLogic( 615 , false );--ロジックOFF
	
	proxy:SetEventCommand( 615 , 70 );--EzStateに制御番号(祈る)を送る
	
	SetNpcStateFlag(proxy, param, heroine_flag_list, HEROINE_STATE_PRAYER );--ヒロイン状態を「祈る」に
	
	--対応する敵を削除(死亡させる)
	--削除
	
	proxy:OnDistanceAction( 44,10000,1140,"OnEvent_44",WarpGimmickDist_A,HELPID_GO_TO_SEKITYUU,0,WarpGimmickAngle_B,everytime);

	--エンディング用の監視を追加
	
	--▼ヒロインへのダメージ監視(エンディング1用)▼Bad End
	--proxy:OnSimpleDamage( 80 , 615 , 10000 , "OnEvent_80" , once );
	proxy:OnKeyTime2( 80 , "OnEvent_71_wait",0.1,0,0,once);	
	
	proxy:NotNetMessage_begin();
		--ポリ劇開始フェード後に呼ばれるハンドラ
		proxy:LuaCall(80,REMO_START,"OnEvent_80_RemoStart",once);
		--ポリ劇終了後に呼ばれるハンドラ
		proxy:LuaCall(80,REMO_FINISH,"OnEvent_80_RemoFinish",once);
	proxy:NotNetMessage_end();
	
	--▼領域監視を追加(エンディング2用)▼Good End
	local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;
	proxy:OnPlayerActionInRegionAttribute( 81, 2010, "OnEvent_81", 10010405, possible_chr_type, once );
	
	proxy:NotNetMessage_begin();
		--ポリ劇開始フェード後に呼ばれるハンドラ
		proxy:LuaCall(81,REMO_START,"OnEvent_81_RemoStart",once);
		--ポリ劇終了後に呼ばれるハンドラ
		proxy:LuaCall(81,REMO_FINISH,"OnEvent_81_RemoFinish",once);
	proxy:NotNetMessage_end();
	
	proxy:Warp( 10000 , 2083);	
	proxy:CamReset( 10000 , true );--カメラリセット
	
	if proxy:IsAlive( 10000 ) == true then
		proxy:PlayerChrResetAnimation_RemoOnly(10000);
		proxy:ChrResetRequest(10000);
	end	
	--要らなくなったので削除
	proxy:DeleteEvent( 71 );
	
	print("OnEvent_71_RemoFinish end");
end

function OnEvent_71_wait(proxy,param)
	print("OnEvent_71_wait begin");
	proxy:OnCharacterDead( 80 , 615 , "OnEvent_80",once);
	proxy:SetEventFlag( 75 , true );
	print("OnEvent_71_wait end");
end



--------------------------------------------------------------------------------------
--■80■エンディングポリ劇1■Bad End
--------------------------------------------------------------------------------------

function OnEvent_80(proxy , param)
	print("OnEvent_80 begin");

	proxy:InvalidSfx( 1991, true );
	
	--クライアントではない＝生存　or　グレイ=　ホストorソロ
	if proxy:IsClient() == false then
		--クリア状態設定、クリア周回加算
		proxy:SetClearState( CLEAR_STATE_BADEND );
		proxy:AddClearCount();
		--ココでクリア用の初期化処理を呼び出すか？
		LastRemoveEquip(proxy);
		proxy:OnEndFlow( 80,"OnEvent_80_1");
		proxy:OnKeyTime2( 80 , "OnEvent_80_wait", 3.0 , 0 , 1 , once );
	end
	--復活イベント削除
	proxy:DeleteEvent( 111 );
	proxy:DeleteEvent( 81 );
	print("OnEvent_80 end");
end

function OnEvent_80_wait(proxy,param)
	--アニメ待ちの代わりの秒数経過
	BAD_END_WAIT = true;
end

--終了準備完了
function OnEvent_80_1(proxy,param)
	print("OnEvent_80_1 begin");
	proxy:OnRegistFunc( 80 , "Check_80_2","OnEvent_80_2",1,once);
	--もうフラグ初期化済みなのでフラグはONにしない
	print("OnEvent_80_1 begin");
end

--フラグ待ち
function Check_80_2(proxy)
	if BAD_END_WAIT == true then
		return true;
	end
	return false;
end

--ポリ劇発動
function OnEvent_80_2(proxy,param)
	--▼エンディングポリ劇1
	proxy:RequestRemo(4,REMO_FLAG,80,1);
end

--■ポリ劇再生開始(フェード終了)
function OnEvent_80_RemoStart(proxy,param)
	print("OnEvent_80_RemoStart begin");
	print("OnEvent_80_RemoStart end");
end


--■ポリ劇再生終了(フェード終了)
function OnEvent_80_RemoFinish(proxy , param)
	print("OnEvent_80_RemoFinish begin");
	
	--[[ゲームクリア処理]]
	print("Bad Ending");	
	
	--ムービー再生要求
	--proxy:RequestPlayMoviePlus(MOVIE_ENDING_BAD,true);
	--ムービー再生の監視
	--proxy:OnRegistFunc(80,"Check_80","OnEvent_80_2",1,once);
	proxy:RequestEnding();--エンディング要求
	
	print("OnEvent_80_RemoFinish end");
end
	
--[[
--ムービー再生中の監視動くのか？
function Check_80(proxy,param)
	if proxy:IsPlayMovie() == true then
		return false;
	end	
	return true;
end
	
--Badロール終了後
function OnEvent_80_2(proxy,param)
	print("OnEvent_80_2 begin");
	--石柱に入り直し
	proxy:WarpNextStage( 1, 0, 0, 0, -1 );
	print("OnEvent_80_2 end");
end
]]


--------------------------------------------------------------------------------------
--■81■エンディングポリ劇2■GoodEnd
--------------------------------------------------------------------------------------

function OnEvent_81(proxy, param)
	print("OnEvent_81 begin");
		
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		if param:IsNetMessage() == true then
			--旋回アニメ再生を同期
			proxy:TurnCharactor( 10001 + param:GetPlayID(), 2011 );
		else
			--旋回アニメ再生を行い、その終了時にOnEvent_81_1を発行する
			proxy:OnTurnCharactorEnd( 81, 10000, 2011, "OnEvent_81_1_1", once );
		end
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();	
	
	print("OnEvent_81 end");
end

function OnEvent_81_1_1(proxy, param)
	print("OnEvent_81_1_1 begin");
		
	--同期用歩きアニメ再生
	proxy:LuaCallStart( 4012, 1 );
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 81, 10000, ANIMEID_WALK, "OnEvent_81_1_2", once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();

	print("OnEvent_81_1_1 end");
end

function OnEvent_81_1_2(proxy, param)
	print("OnEvent_81_1_2 begin");
	
	proxy:OnKeyTime2( 81, "OnEvent_81_2", 3, 0, 0, once );

	print("OnEvent_81_1_2 end");
end

function OnEvent_81_2(proxy , param)
	print("OnEvent_81_2 begin");
	
	proxy:InvalidSfx( 1991, true );
	
	--クライアントではない＝生存　or　グレイ=　ホストorソロ
	if proxy:IsClient() == false then
		--クリア状態設定、クリア周回加算
		proxy:SetClearState( CLEAR_STATE_GOODEND );
		proxy:AddClearCount();
		
		--▼トロフィー取得判定▼
		--Lua_RequestUnlockTrophy(proxy, 1);--トロフィの状況を判定し、取得する
		LastRemoveEquip(proxy);
		--ココでクリア用の初期化処理を呼び出すか？
		proxy:OnEndFlow(81,"OnEvent_81_3");
		
	end
	proxy:DeleteEvent(80);

	print("OnEvent_81_2 end");
end

--終了準備完了
function OnEvent_81_3(proxy,param)
	print("OnEvent_81_3 begin");
	--▼エンディングポリ劇2
	proxy:RequestRemo(5,REMO_FLAG,81,1);
	--もうフラグ初期化済みなのでフラグはONにしない
	print("OnEvent_81_3 end");
end

--■ポリ劇再生開始(フェード終了)
function OnEvent_81_RemoStart(proxy,param)
	print("OnEvent_81_RemoStart begin");
	print("OnEvent_81_RemoStart end");
end


--■ポリ劇再生終了(フェード終了)
function OnEvent_81_RemoFinish(proxy , param)
	print("OnEvent_81_RemoFinish begin");
	
	--[[ゲームクリア処理]]
	print("Good Ending");	
	--ムービー再生要求
	--proxy:RequestPlayMoviePlus(MOVIE_ENDING_GOOD,true);
	--ムービー再生の監視
	--proxy:OnRegistFunc(81,"Check_81","OnEvent_81_4",1,once);
	proxy:RequestEnding();--エンディング要求
	print("OnEvent_81_RemoFinish end");
end

--[[
--ムービー再生中の監視動くのか？
function Check_81(proxy,param)
	if proxy:IsPlayMovie() == true then
		return false;
	end	
	return true;
end
	
--Goodロール終了後
function OnEvent_81_4(proxy,param)
	print("OnEvent_81_4 begin");
	--石柱をロード
	proxy:WarpNextStage( 1, 0, 0, 0, -1 );
	print("OnEvent_81_4 end");
end
]]

--[[
--------------------------------------------------------------------------------------
--■140■死体にささっている剣を入手■
--------------------------------------------------------------------------------------
function OnEvent_140(proxy, param)
	print("OnEvent_140 begin");
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした)
	if Luafunc_PlaySynchroAnimation( proxy, param, 8300 ) == true then--新しいアニメ 
		proxy:PlayAnimation( 1130 , 1);	
		print("OnEvent_140 end");
		return true;
	end

	proxy:WarpDmy( 10000 , 1130 , 191 );--ダミー位置へワ－プ
	proxy:PlayAnimation( 1130 , 1);
	--アニメが終わったら監視追加
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 140 , 10000 , 8300 , "OnEvent_140_1", once);
	proxy:NotNetMessage_end();
	
	print("OnEvent_140 end");
end

function OnEvent_140_1(proxy, param)
	print("OnEvent_140_1 begin");
	--アイテム取得関数--パラメータ10104参照
	proxy:GetRateItem(10730);--アイテム	
	
	--アイテムを取得済み
	proxy:SetEventFlag( 140, true );
	
	--OBJを消すためのイベント配信
	proxy:LuaCallStart( 140, 1);
	
	print("OnEvent_140_1 end");
end

--■140_2■剣OBJ非表示用■
function OnEvent_140_2(proxy,param)
	print("OnEvent_140_2 begin");
	--オブジェが消える
	proxy:SetDrawEnable( 1130 , false );--ひとまず描画だけOFF
	proxy:SetColiEnable( 1130 , false );--当たりはあるのは不明(現状ではないようなので消さない)
	print("OnEvent_140_2 end");
end
]]
	
--------------------------------------------------------------------------------------
--■100■ヒロインが最後の戦いを決意する■
--------------------------------------------------------------------------------------

--■100■ヒロインが最後の戦いを決意する■
function OnEvent_100(proxy , param)
	print("OnEvent_100 begin");

	--ヒロインの状態フラグを「決着をつけたい」にする
	SetNpcStateFlag(proxy, param, heroine_flag_list, HEROINE_STATE_WANT_TO_SETTLE );
	proxy:SetEventFlag( 100 , 1 );
	
	print("OnEvent_100 end");
end



--------------------------------------------------------------------------------------
--■90,91■ＰＣがヒロインの前で跪く■(会話システムから呼び出し)
--------------------------------------------------------------------------------------

--■90■ＰＣがヒロインの前で跪く_1■
function OnEvent_90(proxy , param)
	print("OnEvent_90 begin");
	proxy:SetEventFlag(90,false);
	proxy:TurnCharactor( 10000 , 615 );--PCをヒロインのほうに向かわせる
	proxy:EnableLogic( 10000 , false );--PCを操作不能
	proxy:ResetCamAngle();
	
	proxy:RepeatMessage_begin();
		--▼旋回アニメの終了▼
		proxy:OnTurnCharactorEnd( 90 , 10000 , 615 , "OnEvent_90_trun_end" , once );
	proxy:RepeatMessage_end();
	
	print("OnEvent_90 end");
end


--▲旋回アニメの終了▲
function OnEvent_90_trun_end(proxy , param)
	print("OnEvent_90_trun_end begin");

	if proxy:IsCompleteEvent(90) == false then
	--[[	--強制アニメ
		proxy:ForcePlayAnimation( 10000 , 8280 );
	
	proxy:RepeatMessage_begin();
		--▼最初のアニメ終了▼
		proxy:OnChrAnimEnd( 90 , 10000 , 8280 , "OnEvent_90_anime_end" , once );
		proxy:RepeatMessage_end();]]
		--跪く命令を送信
		proxy:SetEventCommand( 10000 , 80 );
	end
	
	print("OnEvent_90_trun_end end");
end


--▲最初のアニメの終了▲
function OnEvent_90_anime_end(proxy , param)
	print("OnEvent_90_anime_end begin");
	--[[
	if proxy:IsCompleteEvent(90) == false then
	proxy:PlayLoopAnimation( 10000 , 8281 );
	end	
	]]
	print("OnEvent_90_anime_end end");
end


--■91■ＰＣがヒロインの前で跪く_2■
function OnEvent_91(proxy , param)
	print("OnEvent_91 begin");
--強制アニメ
	--proxy:ForcePlayAnimation( 10000 , 8282 );
	proxy:SetEventCommand( 10000 , 81);
	proxy:EnableLogic( 10000 , true );--PCを操作不能
	proxy:ResetCamAngle();
	proxy:SetEventFlag(90,true);
	
	print("OnEvent_91 end");
end

--[[
--------------------------------------------------------------------------------------
--ハーフハンド敵対■200
--------------------------------------------------------------------------------------

--■200■ハーフハンド敵対■
function OnEvent_200(proxy, param)
	print("OnEvent_200 begin");

	proxy:EnableLogic( 618 , true );--[[ロジックON ロジック切り替え?]]
	
	--ハーフハンドの状態フラグを「敵対(石柱)」にする
	SetNpcStateFlag(proxy, param, half_flag_list, HALF_STATE_HOSTILE_SEKITYU );
	proxy:SetEventFlag( 200 , 1 );
	
	print("OnEvent_200 end");
end


--------------------------------------------------------------------------------------
--ハーフハンド死亡■201
--------------------------------------------------------------------------------------

--■201■ハーフハンド死亡■
function OnEvent_201(proxy, param)
	print("OnEvent_201 begin");

	--ハーフハンドの状態フラグを「死亡」にする
	SetNpcStateFlag(proxy, param, half_flag_list, HALF_STATE_DEAD );
	proxy:SetEventFlag( 201 , 1 );
	
	print("OnEvent_201 end");
end
]]





--------------------------------------------------------------------------------------
--■100～153■NPC状態遷移　ヒロイン■
--------------------------------------------------------------------------------------
--■100～153■NPC状態遷移　ヒロイン■

function OnEvent_110(proxy,param)
	print("OnEvent_110 begin");
	if	proxy:IsCompleteEvent(110) == true then
		print("OnEvent_110 既に会話イベントが終了しています。");
		return;
	end
	if	proxy:IsCompleteEvent( HEROINE_STATE_DOOR_FRONT ) == true then
		SetNpcStateFlag(proxy, param, heroine_flag_list, HEROINE_STATE_DOOR_LEAVE );
	end
	proxy:SetEventFlag( 110, true );
	proxy:SetEventFlag(120,true);
	print("OnEvent_110 end");
end

--■111■ヒロイン死亡監視■	
function OnEvent_111(proxy, param)
	print("OnEvent_111 begin");
	proxy:OnKeyTime2(111, "OnEvent_111_1", 10.0, 0, 0, once);
	--proxy:SendEventRequest(615, 0, -1);
	print("OnEvent_111 end");
end

function OnEvent_111_1(proxy, param)
	print("OnEvent_111_1 begin");
	proxy:SetEventFlag( 115 , true );	
	proxy:RecoveryHeroin();
	--復活命令を送る
	proxy:SetEventCommand( 615 , 700);
	--２回目以降の監視
	proxy:RepeatMessage_begin();
		proxy:OnCharacterDead(111, 615, "OnEvent_111", once);
		--proxy:OnCharacterHP( 111 , 615 , "OnEvent_111",0.0,once);
	proxy:RepeatMessage_end();
	--proxy:SetEventFlag(111, true);
	print("OnEvent_111_1 end");
end

-------------------------------------------------------
--再生しているアニメIDによって、再生するアニメを変える
-------------------------------------------------------
function OnEvent_113(proxy, param)
	print("OnEvent_113　begin");
		--proxy:ForcePlayAnimation(615, 7022);--アニメの方でやるらしい。
		proxy:SetSpStayAndDamageAnimIdPlus(615, -1, -1,hiroin_cancelAnimId);--通常待機へ戻す

		--proxy:
	print("OnEvent_113　end");
end

--------------------------------------------------------------------------------------
--トマスに娘の髪飾りを渡す■354■
--------------------------------------------------------------------------------------
function OnEvent_354(proxy,param)
	print("OnEvent_354 begin");
	if	proxy:IsCompleteEvent(354) == true then
		print("OnEvent_354 既に会話イベントが終了しています。");
	end
	if proxy:RemoveInventoryEquip(TYPE_GOODS, 38) == true then
		print("OnEvent_354 RemoveInventoryEquip Succsess");
	else
		print("OnEvent_354 RemoveInventoryEquip Failed");
	end
	proxy:GetRateItem( 10700 );
	proxy:SetEventFlag( 354, true );
	print("OnEvent_354 end");
end

--------------------------------------------------------------------------------------
--ボードウィン敵対■390
--------------------------------------------------------------------------------------
--■390■ボードウィン敵対■
function OnEvent_390(proxy, param)
	print("OnEvent_390 begin");
	proxy:EnableLogic(694,true);--ロジックＯＮ
	proxy:SetTeamType(694, TEAM_TYPE_AngryFriend);--チームタイプ変更
	SetNpcStateFlag( proxy, param, baldwin_flag_list, BALDWIN_STATE_HOSTILE );--敵対

	proxy:SetEventFlag( 390 , 1 );
	
	print("OnEvent_390 end");
end
--------------------------------------------------------------------------------------
--ボードウィン死亡■391
-------------------------------------------------------------------------------------
--■391■ボードウィン死亡■
function OnEvent_391(proxy, param)
	print("OnEvent_391 begin");

	--ボードウィンの状態フラグを「死亡」にする
	SetNpcStateFlag(proxy, param, baldwin_flag_list, BALDWIN_STATE_DEAD );
	proxy:SetEventFlag( 391 , 1 );
	
	print("OnEvent_391 end");
end


--------------------------------------------------------------------------------------
--■303■要人からの昔話■
--------------------------------------------------------------------------------------
function OnEvent_303(proxy,param)
	print("OnEvent_303 begin");
	if proxy:IsCompleteEvent( 303 ) == true then
		return;
	end
	
	local movieflag = true;
	--[[
	if proxy:GetClearCount() >= 1 then 
		movieflag = true;
	end
	]]
	--BGM停止
	proxy:StopPointSE(0);
	
	proxy:RequestPlayMoviePlus(MOVIE_OLDTALE,movieflag);
	proxy:OnRegistFunc( 303,"Check_303","OnEvent_303_1",1,once);
	print("OnEvent_303 end");
end

--ムービー終了判定
function Check_303(proxy,param)
	if proxy:IsPlayMovie() == false then
		return true;
	end
	return false;	
end

--ムービー終了
function OnEvent_303_1(proxy,param)
	print("OnEvent_303_1 begin");
	--ムービー再生終了したので、BGMを再生
	PlayBGM_SEKITYUU(proxy, param);
	print("石柱BGM再生");
	
	OnEvent_34(proxy, param);--要石の開放処理発動
	
	proxy:SetEventFlag(303,true);
	print("OnEvent_303_1 end");
end

------------------------------------------------------------------------------------
--34■要石の封印の開放
------------------------------------------------------------------------------------
--要石開放
function OnEvent_34(proxy,param)
	print("OnEvent_34 begin");

	proxy:RequestOpenBriefingMsgPlus(10010760,true);
	proxy:PlayTypeSE( 10000 ,SOUND_TYPE_M ,777777777 );
	
	--2周目以降はここまで
	if proxy:GetClearCount() == 0 then--まだ全クリアしていなければ
		proxy:OnKeyTime2( 34 , "OnEvent_34_1",0.1,0,0,once);--時間監視の追加
	else--全クリアしたことがある
		--会話用にフラグを立てる
		OnEvent_36(proxy, param);--36フラグＯＮ
	end
	proxy:SetEventFlag( 8802 , true );
	proxy:SetEventFlag( 8030 , true );
	print("OnEvent_34 end");
end

function OnEvent_34_1(proxy,param)
	print("OnEvent_34_1 beign");
	proxy:OnRegistFunc( 36 , "Check_36","OnEvent_36",1,ocne);
	print("OnEvent_34_1 end");
end

function Check_36(proxy,param)
	if proxy:IsShowMenu() == true then
		return false;
	end
	return true;
end


--開放インフォ表示OFF待ち
function OnEvent_36(proxy,param)
	print("OnEvent_36 begin");
	
	proxy:SetEventFlag( 34 ,true);
	proxy:SetEventFlag( 36 , true );
	
	print("OnEvent_36 end");
end

--------------------------------------------------------------------------------------
--要人死亡■300
-------------------------------------------------------------------------------------
--■300■要人死亡■
function OnEvent_300(proxy, param)
	print("OnEvent_300 begin");

	--要人の状態フラグを「死亡」にする
	SetNpcStateFlag(proxy, param, yojin_flag_list, YOJIN_STATE_DEAD );
	proxy:SetEventFlag( 300 , 1 );
	
	print("OnEvent_300 end");
end


--------------------------------------------------------------------------------------
--心折れた戦士死亡■380～386
-------------------------------------------------------------------------------------
function OnEvent_380(proxy,param)
	print("OnEvent_380 begin");
	if	proxy:IsCompleteEvent( HEART_BREAK_FIGHTER_STATE_STONE_PILLAR ) == true or	--石柱に居る　か
		proxy:IsCompleteEvent( HEART_BREAK_FIGHTER_STATE_MAYBE_DELETE ) == true or	--多分消える　か
		proxy:IsCompleteEvent( HEART_BREAK_FIGHTER_STATE_DELETE ) == true then		--消えますならば
		
		--proxy:SetEventCommand( 611 , 86);
		--proxy:DisableMapHit( 611 , false );
		--proxy:SetDisableGravity( 611 , false );
		proxy:EnableLogic(611,true);--ロジックＯＮ
		proxy:SetTeamType(611, TEAM_TYPE_AngryFriend);--チームタイプ変更		
		SetNpcStateFlag( proxy, param, heartbreak_fighter_flag_list, HEART_BREAK_FIGHTER_STATE_ANGRY );--敵対状態に
	end
	
	proxy:SetEventFlag( 380, true );
	print("OnEvent_380 end");
end

function OnEvent_381(proxy,param)
	print("OnEvent_381 begin");
	SetNpcStateFlag(proxy, param, heartbreak_fighter_flag_list, HEART_BREAK_FIGHTER_STATE_DEAD );
	proxy:SetEventFlag( 381, true );
	print("OnEvent_381 end");
end

function OnEvent_382(proxy,param)
	print("OnEvent_382 begin");
	--SetNpcStateFlag(proxy, param, heartbreak_fighter_flag_list, HEART_BREAK_FIGHTER_STATE_DEAD );--消えますにするはずなので、コメントアウト 
	SetNpcStateFlag(proxy, param, heartbreak_fighter_flag_list, HEART_BREAK_FIGHTER_STATE_DELETE );--消えますに
	proxy:SetEventFlag( 382, true );
	print("OnEvent_382 end");
end


--■388■■
function OnEvent_388(proxy,param)
	print("OnEvent_388 begin");
	proxy:RequestRemo(000025,REMO_FLAG,388,1);
	print("OnEvent_388 end");
end

--ポリ劇開始フェード終了後
function OnEvent_388_RemoStart(proxy,param)
	print("OnEvent_388_RemoStart begin");
	proxy:Warp( 611 , 2120 );
	print("OnEvent_388_RemoStart end");
end

--ポリ劇終了フェード開始前
function OnEvent_388_RemoFinish(proxy,param)
	print("OnEvent_388_RemoFinish begin");
	proxy:SetSpStayAndDamageAnimId(611,7625,-1);
	print("OnEvent_388_RemoFinish end");
end



--------------------------------------------------------------------------------------
--神の信徒1■320～324
-------------------------------------------------------------------------------------
function OnEvent_320(proxy,param)
	print("OnEvent_320 begin");
	if proxy:IsCompleteEvent(GOD_BELIEVER_1_STATE_DEAD) == true then--死亡しているならば
		print("OnEvent_320 end");
		return;--何もせずに終了
	end
	proxy:EnableLogic(682,true);--ロジックＯＮ
	proxy:SetTeamType(682, TEAM_TYPE_AngryFriend);--チームタイプ変更
	SetNpcStateFlag( proxy, param, god_beliver1_flag_list, GOD_BELIEVER_1_STATE_ANGRY );--敵対状態に
	
	proxy:SetEventFlag( 320, true );
	print("OnEvent_320 end");
end

function OnEvent_321(proxy,param)
	print("OnEvent_321 begin");
	SetNpcStateFlag(proxy, param, god_beliver1_flag_list, GOD_BELIEVER_1_STATE_DEAD );
	proxy:SetEventFlag( 321, true );
	print("OnEvent_321 end");
end

--------------------------------------------------------------------------------------
--神の信徒2■330～334
-------------------------------------------------------------------------------------
function OnEvent_330(proxy,param)
	print("OnEvent_330 begin");
	if proxy:IsCompleteEvent(GOD_BELIEVER_2_STATE_DEAD) == true					--死亡している　か
	or proxy:IsCompleteEvent(GOD_BELIEVER_2_STATE_ISNOTALREADY) == true then	--すでにいないならば
		print("OnEvent_330 end");
		return;--何もせずに終了
	end
	proxy:EnableLogic(683,true);--ロジックＯＮ
	proxy:SetTeamType(683, TEAM_TYPE_AngryFriend);--チームタイプ変更
	SetNpcStateFlag( proxy, param, god_beliver2_flag_list, GOD_BELIEVER_2_STATE_ANGRY );--敵対状態に
	
	proxy:SetEventFlag( 330, true );
	print("OnEvent_330 end");
end

function OnEvent_331(proxy,param)
	print("OnEvent_331 begin");
	SetNpcStateFlag(proxy, param, god_beliver2_flag_list, GOD_BELIEVER_2_STATE_DEAD );
	proxy:SetEventFlag( 331, true );
	print("OnEvent_331 end");
end

--------------------------------------------------------------------------------------
--神の信徒3■430～434
-------------------------------------------------------------------------------------
function OnEvent_430(proxy,param)
	print("OnEvent_430 begin");
	if proxy:IsCompleteEvent(GOD_BELIEVER_3_STATE_DEAD) == true then--死亡しているならば
		print("OnEvent_430 end");
		return;--何もせずに終了		
	end
	proxy:EnableLogic(684,true);--ロジックＯＮ
	proxy:SetTeamType(684, TEAM_TYPE_AngryFriend);--チームタイプ変更
	SetNpcStateFlag( proxy, param, god_beliver3_flag_list, GOD_BELIEVER_3_STATE_ANGRY );--敵対状態に
	
	proxy:SetEventFlag( 430, true );
	print("OnEvent_430 end");
end

function OnEvent_431(proxy,param)
	print("OnEvent_431 begin");
	SetNpcStateFlag(proxy, param, god_beliver3_flag_list, GOD_BELIEVER_3_STATE_DEAD );
	proxy:SetEventFlag( 431, true );
	print("OnEvent_431 end");
end

--■435■信徒３がアイテムをくれる■(会話呼び出し)
function OnEvent_435(proxy, param)
	print("OnEvent_435 begin");
	proxy:GetRateItem(10760);--アイテム入手
	proxy:GetRateItem(10761);--アイテム入手
	proxy:SetEventFlag(435, true);
	print("OnEvent_435 end");
end


--------------------------------------------------------------------------------------
--魔術の徒■310～314
-------------------------------------------------------------------------------------
function OnEvent_310(proxy,param)
	print("OnEvent_310 begin");
	
	if	proxy:IsCompleteEvent( MAGIC_STUDENT_STATE_ROGARN_HELP ) == true		--ロガーンを助けて　か
	or	proxy:IsCompleteEvent( MAGIC_STUDENT_STATE_ROGARN_TOGETHER ) == true	--ロガーンと一緒　か
	or	proxy:IsCompleteEvent( MAGIC_STUDENT_STATE_FALL ) == true then			--落胆ならば
		
		proxy:EnableLogic(681,true);--ロジックＯＮ
		proxy:SetTeamType(681, TEAM_TYPE_AngryFriend);--チームタイプ変更
		SetNpcStateFlag( proxy, param, magic_student_flag_list, MAGIC_STUDENT_STATE_ANGRY );--敵対状態に
	end
	
	proxy:SetEventFlag( 310, true );
	
	print("OnEvent_310 begin");
end

function OnEvent_311(proxy,param)
	print("OnEvent_311 begin");
	SetNpcStateFlag( proxy, param, magic_student_flag_list, MAGIC_STUDENT_STATE_DEAD );
	proxy:SetEventFlag( 311, true );
	print("OnEvent_311 begin");
end



--------------------------------------------------------------------------------------
--ウルベイン■270～274
-------------------------------------------------------------------------------------
--ウルベイン敵対
function OnEvent_270(proxy,param)
	print("OnEvent_270 begin");
	proxy:EnableLogic(690,true);--ロジックＯＮ
	proxy:SetTeamType(690, TEAM_TYPE_AngryFriend);--チームタイプ変更
	SetNpcStateFlag( proxy, param, urubain_flag_list, URUBAIN_STATE_STONE_PILLAR_ANGRY );--敵対状態に
	
	--ウル様がお怒りになられたので、信徒達も怒る
	proxy:LuaCallStart(320, 1);--信徒１敵対化ハンドラ発動
	proxy:LuaCallStart(330, 1);--信徒２敵対化ハンドラ発動
	proxy:LuaCallStart(430, 1);--信徒３敵対化ハンドラ発動
	
	proxy:SetEventFlag( 270, true );
	print("OnEvent_270 end");
end

--ウルベイン死亡
function OnEvent_271(proxy,param)
	print("OnEvent_271 begin");
	SetNpcStateFlag( proxy, param, urubain_flag_list, URUBAIN_STATE_DEAD );
	proxy:SetEventFlag( 271, true );
	print("OnEvent_271 end");
end



--------------------------------------------------------------------------------------
--ユルト■280～283
-------------------------------------------------------------------------------------
--ユルト敵対
function OnEvent_280(proxy,param)
	print("OnEvent_280 begin");
	proxy:EnableLogic(619,true);--ロジックＯＮ
	proxy:SetTeamType(619, TEAM_TYPE_AngryFriend);--チームタイプ変更
	SetNpcStateFlag( proxy, param, yuruto_flag_list, YURUTO_STATE_ANGRY_M1 );--敵対状態に	
	proxy:SetEventFlag( 280, true );
	print("OnEvent_280 end");
end

--ユルト死亡
function OnEvent_281(proxy,param)
	print("OnEvent_281 begin");
	SetNpcStateFlag( proxy, param, yuruto_flag_list, YURUTO_STATE_DEAD );
	proxy:SetEventFlag( 281, true );
	print("OnEvent_281 end");
end

--ユルトの死体調べた
function OnEvent_15630(proxy,param)
	print("OnEvent_15630 begin");
	proxy:SetEventFlag( 15630 , true );
	print("OnEvent_15630 end");
end


--------------------------------------------------------------------------------------
--バッチ■290～294
-------------------------------------------------------------------------------------
--バッチ敵対
function OnEvent_290(proxy,param)
	print("OnEvent_290 begin");
	proxy:EnableLogic(693,true);--ロジックＯＮ
	proxy:SetTeamType(693, TEAM_TYPE_AngryFriend);--チームタイプ変更
	SetNpcStateFlag( proxy, param, batti_flag_list, BATTI_ANGRY_M1 );--敵対状態に
	
	proxy:SetEventFlag( 290, true );
	print("OnEvent_290 end");
end

--バッチ死亡
function OnEvent_291(proxy,param)
	print("OnEvent_291 begin");
	SetNpcStateFlag( proxy, param, batti_flag_list, BATTI_DEAD );
	proxy:SetEventFlag( 291, true );
	print("OnEvent_291 end");
end


--------------------------------------------------------------------------------------
--魔女■260～264
-------------------------------------------------------------------------------------
--魔女敵対
function OnEvent_260(proxy,param)
	print("OnEvent_260 begin");
	proxy:EnableLogic(689,true);--ロジックＯＮ
	proxy:SetTeamType(689, TEAM_TYPE_AngryFriend);--チームタイプ変更
	SetNpcStateFlag( proxy, param, majo_flag_list, MAJO_STATE_ANGRY_M1 );--敵対状態

	proxy:SetEventFlag( 260, true );
	print("OnEvent_260 end");
end

--魔女死亡
function OnEvent_261(proxy,param)
	print("OnEvent_261 begin");
	SetNpcStateFlag( proxy, param, majo_flag_list, MAJO_STATE_DEAD );
	proxy:SetEventFlag( 261, true );
	print("OnEvent_261 end");
end


--------------------------------------------------------------------------------------
--ビヨルングルム■240～245
-------------------------------------------------------------------------------------
--ビヨルングルム敵対
function OnEvent_240(proxy,param)
	print("OnEvent_240 begin");
	proxy:EnableLogic(695,true);--ロジックＯＮ
	proxy:SetTeamType(695, TEAM_TYPE_AngryFriend);--チームタイプ変更
	SetNpcStateFlag(proxy,param,biyo_flag_list,BIYO_STATE_HOSTILE_IN_STONE_PILLAR);--敵対状態に
	proxy:EraseEventSpecialEffect_2(695,5064);
	proxy:SetEventFlag( 240, true );
	print("OnEvent_240 end");
end

--ビヨルングルム死亡
function OnEvent_241(proxy,param)
	print("OnEvent_241 begin");
	SetNpcStateFlag( proxy, param, biyo_flag_list, BIYO_STATE_DEAD );
	proxy:SetEventFlag( 241, true );
	print("OnEvent_241 end");
end




--------------------------------------------------------------------------------------
--ロガーン■220～225
-------------------------------------------------------------------------------------
--ロガーン敵対
function OnEvent_221(proxy,param)
	print("OnEvent_221 begin");
	SetNpcStateFlag( proxy, param, rogarn_flag_list, ROGARN_STATE_ANGRY_M1 );--状態を敵対に
	proxy:SetTeamType(617, TEAM_TYPE_AngryFriend);--チームタイプ変更
	proxy:SetEventFlag( 240, true );
	
	--魔術の徒敵対
	if	proxy:IsCompleteEvent( MAGIC_STUDENT_STATE_ROGARN_HELP ) == true		--ロガーンを助けて　か
	or	proxy:IsCompleteEvent( MAGIC_STUDENT_STATE_ROGARN_TOGETHER ) == true	--ロガーンと一緒　か
	or	proxy:IsCompleteEvent( MAGIC_STUDENT_STATE_FALL ) == true then			--落胆ならば
		
		proxy:EnableLogic(681,true);--ロジックＯＮ
		proxy:SetTeamType(681, TEAM_TYPE_AngryFriend);--チームタイプ変更
		SetNpcStateFlag( proxy, param, magic_student_flag_list, MAGIC_STUDENT_STATE_ANGRY );--敵対状態に
	end
	
	print("OnEvent_221 end");
end

--ロガーン死亡
function OnEvent_222(proxy,param)
	print("OnEvent_222 begin");
	SetNpcStateFlag( proxy, param, rogarn_flag_list, ROGARN_STATE_DEAD );
	proxy:SetEventFlag( 240, true );
	print("OnEvent_222 end");
end

--------------------------------------------------------------------------------------
--トマス■350～354
-------------------------------------------------------------------------------------
--トマス敵対
function OnEvent_350(proxy,param)
	print("OnEvent_350 end");
	proxy:EnableLogic(687,true);--ロジックＯＮ
	proxy:SetTeamType(687, TEAM_TYPE_AngryFriend);--チームタイプ変更
	SetNpcStateFlag( proxy, param, tomasu_flag_list, TOMASU_STATE_ANGRY );--敵対状態に	
	proxy:SetEventFlag( 350, true );
	print("OnEvent_350 end");
end

--トマス死亡
function OnEvent_351(proxy,param)
	print("OnEvent_351 end");
	SetNpcStateFlag( proxy, param, tomasu_flag_list, TOMASU_STATE_DEAD );
	proxy:SetEventFlag( 351, true );
	print("OnEvent_351 end");
end


--------------------------------------------------------------------------------------
--レンドル王子■230～233
-------------------------------------------------------------------------------------
function OnEvent_230(proxy,param)
	print("OnEvent_230 begin");
	SetNpcStateFlag( proxy, param, rendol_flag_list, RENDOL_STATE_HOSTILE_STONE_PILLAR );
	proxy:EnableLogic(688,true);--ロジックＯＮ
	proxy:SetTeamType(688, TEAM_TYPE_AngryFriend);--チームタイプ変更
	proxy:EraseEventSpecialEffect_2(688,5063);
	proxy:SetEventFlag( 230, true );
	print("OnEvent_230 end");
end

function OnEvent_231(proxy,param)
	print("OnEvent_231 begin");
	SetNpcStateFlag( proxy, param, rendol_flag_list, RENDOL_STATE_DEAD );
	proxy:SetEventFlag( 231, true );
	print("OnEvent_231 end");
end




--------------------------------------------------------------------------------------
--メフィスト■360～372
-------------------------------------------------------------------------------------
--メフィスト敵対
function OnEvent_360(proxy,param)
	print("OnEvent_360 end");
			proxy:EnableLogic(680,true);--ロジックＯＮ
			proxy:SetTeamType(680, TEAM_TYPE_AngryFriend);--チームタイプ変更
			SetNpcStateFlag( proxy, param, mefist_flag_list, MEFIST_STATE_ANGRY );--敵対状態に
	proxy:SetEventFlag( 360, true );
	print("OnEvent_360 end");
end

--メフィスト死亡
function OnEvent_361(proxy,param)
	print("OnEvent_361 end");
	SetNpcStateFlag( proxy, param, mefist_flag_list, MEFIST_STATE_DEAD );
	proxy:SetEventFlag( 361, true );
	print("OnEvent_361 end");
end


--メフィスト 　【レンドル王子】殺害報告待ち
function OnEvent_362(proxy,param)
	print("OnEvent_362 end");
	SetNpcStateFlag(proxy, param, mefist_flag_list, MEFIST_STATE_KILL_WAIT_RENDOL );
	proxy:SetEventFlag( 362, true );
	print("OnEvent_362 end");
end

--メフィスト 　【ビヨルングルム】殺害報告待ち
function OnEvent_363(proxy,param)
	print("OnEvent_363 end");
	SetNpcStateFlag(proxy, param, mefist_flag_list, MEFIST_STATE_KILL_WAIT_BIYO );
	proxy:SetEventFlag( 363, true );
	print("OnEvent_363 end");
end

--メフィスト 　【ロガーン】殺害報告待ち
function OnEvent_364(proxy,param)
	print("OnEvent_364 end");
	SetNpcStateFlag(proxy, param, mefist_flag_list, MEFIST_STATE_KILL_WAIT_ROGARN );
	proxy:SetEventFlag( 364, true );
	print("OnEvent_364 end");
end

--メフィスト 　【魔女】殺害報告待ち
function OnEvent_365(proxy,param)
	print("OnEvent_365 end");
	SetNpcStateFlag(proxy, param, mefist_flag_list, MEFIST_STATE_KILL_WAIT_MAJO );
	proxy:SetEventFlag( 365, true );
	print("OnEvent_365 end");
end

--メフィスト 　【ウルベイン】殺害報告待ち
function OnEvent_366(proxy,param)
	print("OnEvent_366 end");
	SetNpcStateFlag(proxy, param, mefist_flag_list, MEFIST_STATE_KILL_WAIT_URU );
	proxy:SetEventFlag( 366, true );
	print("OnEvent_366 end");
end

--メフィスト 　【トマス】殺害報告待ち
function OnEvent_367(proxy,param)
	print("OnEvent_367 end");
	SetNpcStateFlag(proxy, param, mefist_flag_list, MEFIST_STATE_KILL_WAIT_TOMASU );
	proxy:SetEventFlag( 367, true );
	print("OnEvent_367 end");
end

--メフィスト 　【バッチ】殺害報告待ち
function OnEvent_368(proxy,param)
	print("OnEvent_368 end");
	SetNpcStateFlag(proxy, param, mefist_flag_list, MEFIST_STATE_KILL_WAIT_BATTI );
	proxy:SetEventFlag( 368, true );
	print("OnEvent_368 end");
end

--メフィスト 　宣戦布告敵対
function OnEvent_369(proxy,param)
	print("OnEvent_369 end");
	proxy:EnableLogic(680,true);--ロジックＯＮ
	proxy:SetTeamType(680, TEAM_TYPE_AngryFriend);--チームタイプ変更
	SetNpcStateFlag( proxy, param, mefist_flag_list, MEFIST_STATE_ANGRY );--敵対状態に
	
	proxy:SetEventFlag( 369, true );
	print("OnEvent_369 end");
end

--【王子】殺害のお礼
function OnEvent_400(proxy,param)
	print("OnEvent_400 end");
	
	proxy:GetRateItem( 10710 );
	proxy:SetEventFlag( 400, true );
	
	print("OnEvent_400 end");
end

--【ビヨルングルム】殺害のお礼
function OnEvent_401(proxy,param)
	print("OnEvent_401 end");
	
	proxy:GetRateItem( 10711 );
	proxy:SetEventFlag( 401, true );
	
	print("OnEvent_401 end");
end

--【ロガーン】殺害のお礼
function OnEvent_402(proxy,param)
	print("OnEvent_402 end");
	
	proxy:GetRateItem( 10712 );
	proxy:SetEventFlag( 402, true );
	
	print("OnEvent_402 end");
end

--【魔女】殺害のお礼
function OnEvent_403(proxy,param)
	print("OnEvent_403 end");
	
	proxy:GetRateItem( 10713 );
	proxy:SetEventFlag( 403, true );
	
	print("OnEvent_403 end");
end

--【ウルベイン】殺害のお礼
function OnEvent_404(proxy,param)
	print("OnEvent_404 end");
	
	proxy:GetRateItem( 10714 );
	proxy:SetEventFlag( 404, true );
	
	print("OnEvent_404 end");
end

--【トマス】殺害のお礼
function OnEvent_405(proxy,param)
	print("OnEvent_405 end");
	
	proxy:GetRateItem( 10715 );
	proxy:SetEventFlag( 405, true );
	
	print("OnEvent_405 end");
end

--【バッチ】殺害のお礼
function OnEvent_406(proxy,param)
	print("OnEvent_406 end");
	
	proxy:GetRateItem( 10716 );
	proxy:SetEventFlag( 406, true );
	
	print("OnEvent_406 end");
end

------------------------------------------------------------------------------------
--BGM関連OnEvent
------------------------------------------------------------------------------------
--ステージクリア数によって再生するBGMを変更する
function PlayBGM_SEKITYUU(proxy, param)
	if ClearBlockCount ~= 5 then
		if ClearBlockCount >= 3 then--ステージクリア数3以上
			print("--■421■BGM再生2■");
			proxy:RepeatMessage_begin();
				--proxy:LuaCall(421, 0, "OnEvent_421", everytime);--BGMを流すOnEventを発動させる
				proxy:PlayPointSE( 2050, SOUND_TYPE_M, 010100000, 0 );
				print("010100000再生");
				proxy:SetEventFlag( 421, true );
				--proxy:DeleteEvent( 421 );--442のようにeverytimeではないので
			proxy:RepeatMessage_end();	
			
		elseif ClearBlockCount <= 2 then--ステージクリア数2以下
			print("--■420■BGM再生1■");
			proxy:RepeatMessage_begin();
				--proxy:LuaCall( 420 , 0 , "OnEvent_420", once );--BGMを流すOnEventを発動させる
				proxy:PlayPointSE( 2050, SOUND_TYPE_M, 010000000, 0 );
				print("010000000再生");
				proxy:SetEventFlag( 420, true );
				--proxy:DeleteEvent( 420 );--442のようにeverytimeではないので
			proxy:RepeatMessage_end();
			
		end
	else
		print("--■440■BGM再生3■");
		proxy:RepeatMessage_begin();
			--proxy:LuaCall( 440 , 0 , "OnEvent_420", once );--BGMを流すOnEventを発動させる
			proxy:PlayPointSE( 2020, SOUND_TYPE_C, 600004000, 0 );
			print("600004000再生");
			proxy:SetEventFlag( 440, true );
			--proxy:DeleteEvent( 420 );--442のようにeverytimeではないので
		proxy:RepeatMessage_end();
	end
end

--ラスボス戦BGM
function OnEvent_422(proxy,param)
	print("OnEvent_422 begin");
		proxy:EnableLogic( 821, true );
		proxy:PlayPointSE( 2060, SOUND_TYPE_M, 010200000, 1 );
		--ボスゲージ表示
		proxy:SetBossGauge(821, 0, 4000);
		proxy:SetEventFlag( 422, true );
		proxy:DeleteEvent( 422 );
	print("OnEvent_422 end");
end


------------------------------------------------------------------------------------
--304■ヒロインからアイテムを貰う
------------------------------------------------------------------------------------
function OnEvent_304(proxy,param)
	print("OnEvent_304 begin");
	
	proxy:SetEventFlag( 304, true );	
	
	--if proxy:GetClearCount() == 0 then	
	if proxy:IsInventoryEquip(TYPE_GOODS,9997) == false then	
		proxy:GetRateItem( 10740 );
		proxy:GetRateItem( 10850 );
		--Lua_PauseTutorial(proxy);
		proxy:OnKeyTime2( 304 , "OnEvent_304_1",0.1,0,0,once);
	end
	
	print("OnEvent_304 end");
end

--アイテム入手表示OFF待ち
function OnEvent_304_1(proxy,param)
	print("OnEvent_304_1 begin");
	proxy:OnRegistFunc( 112 , "Check_112","OnEvent_112",1,once);
	print("OnEvent_304_1 end");
end

--チェック
function Check_112(proxy)
	if proxy:IsShowMenu() == true then
		return false;
	end
	return true;
end

--青い瞳の石説明
function OnEvent_112(proxy,param)
	print("OnEvent_112 begin");
	proxy:SetEventFlag(112, true);
	--Display_InfomationMenu_2(proxy, 0, -1, 30, 84001000, 1, -1, 30, 84001001, 6);
	proxy:RequestOpenBriefingMsgPlus(84001001,true);
	--Lua_PauseTutorial(proxy);	
	
	proxy:OnKeyTime2( 112 , "OnEvent_112_1", 0.1 , 0 , 1 ,once );
	print("OnEvent_112 end");
end

function OnEvent_112_1(proxy,param)
	proxy:OnRegistFunc( 114 , "Check_114","OnEvent_114",1,once);
end

--チェック
function Check_114(proxy)
	if proxy:IsShowMenu() == true then
		return false;
	end
	return true;
end

--ヒロイン説明
function OnEvent_114(proxy,param)
	print("OnEvent_114 begin");
	--Display_InfomationMenu_2(proxy, 0, -1, 30, 84001100, 1, -1, 30, 84001101, 6);	
	--Lua_PauseTutorial(proxy);
	proxy:OnKeyTime2( 114 , "OnEvent_114_wait",0.1,0,20,once);	
	print("OnEvent_114 end");
end

function OnEvent_114_wait(proxy,param)
	print("OnEvent_114_wait begin");	
	proxy:RequestOpenBriefingMsgPlus(84001101,true);
	proxy:OnRegistFunc( 114 , "Check_114_1","OnEvent_114_1",5,once);
	print("OnEvent_114_wait end");
end

--チェック
function Check_114_1(proxy)
	if proxy:IsShowMenu() == true then
		return false;
	end
	return true;
end

--メニューが閉じたらフラグを立てる
function OnEvent_114_1(proxy,param)
	print("OnEvent_114_1 begin");
	proxy:SetEventFlag(114, true);
	print("OnEvent_114_1 end");
end


------------------------------------------------------------------------------------
--304■ヒロインからアイテムを貰う
------------------------------------------------------------------------------------
function OnEvent_305(proxy,param)
	print("OnEvent_305 begin");	
	proxy:SetEventFlag( 304, true );
	proxy:GetRateItem( 10741 );	
	print("OnEvent_305 end");
end

------------------------------------------------------------------------------------
--42■石柱下へのローディング
------------------------------------------------------------------------------------
function OnEvent_42(proxy,param)
	print("OnEvent_42 begin");
	proxy:RepeatMessage_begin();
	--▼42_0▼選択メニューの監視▼
		proxy:OnSelectMenu(42, "OnEvent_42_0", 10010730, 0, 2, 1140, 2, once);			
	proxy:RepeatMessage_end();
	print("OnEvent_42 end");
end

--▲42_0▲選択メニューの監視▲
function OnEvent_42_0(proxy, param)
	print("OnEvent_42_0 begin");	
	proxy:PlayAnimation( 10000 , 8283 );--要石に触れるアニメを再生	
	proxy:NoAnimeTurnCharactor( 10000 , 1140 ,TURNSKIP_ANGLE);
	proxy:NotNetMessage_begin();
		--▼要石に触れるアニメ再生終了▼
		proxy:OnChrAnimEnd( 42 , 10000 , 8283 , "OnEvent_42_1" , once );
	proxy:NotNetMessage_end();
	proxy:SetEventFlag( 42 , 1 );
	
	print("OnEvent_42_0 end");
end

--▲42_1▲要石に触れるアニメ再生終了▲
function OnEvent_42_1(proxy, param)
	print("OnEvent_42_1 begin");	
	proxy:PlayAnimation( 10000 , 8284 );--自世界に帰るアニメを再生		
	OnEvent_42_2(proxy,param);
	
	print("OnEvent_42_1 end");
end

--▲自世界に帰るアニメ再生終了▲
function OnEvent_42_2(proxy,param)	
	print("OnEvent_42_2 begin");	
	--完全回復要求
	proxy:RequestFullRecover();
	proxy:WarpNextStage( 1, 0, 0, 0, 2101 );	
	print("OnEvent_42_2 end");
end


------------------------------------------------------------------------------------
--44■石柱下へのローディング2
------------------------------------------------------------------------------------
function OnEvent_44(proxy,param)
	print("OnEvent_44 begin");
	proxy:RepeatMessage_begin();
	--▼42_0▼選択メニューの監視▼
		proxy:OnSelectMenu(42, "OnEvent_44_0", 10010730, 0, 2, 1140, 2, once);			
	proxy:RepeatMessage_end();
	print("OnEvent_44 end");
end

--▲42_0▲選択メニューの監視▲
function OnEvent_44_0(proxy, param)
	print("OnEvent_44_0 begin");	
	proxy:PlayAnimation( 10000 , 8283 );--要石に触れるアニメを再生	
	proxy:NoAnimeTurnCharactor( 10000 , 1140 ,TURNSKIP_ANGLE);
	proxy:NotNetMessage_begin();
		--▼要石に触れるアニメ再生終了▼
		proxy:OnChrAnimEnd( 42 , 10000 , 8283 , "OnEvent_44_1" , once );
	proxy:NotNetMessage_end();
	proxy:SetEventFlag( 42 , 1 );
	
	print("OnEvent_44_0 end");
end

--▲42_1▲要石に触れるアニメ再生終了▲
function OnEvent_44_1(proxy, param)
	print("OnEvent_44_1 begin");	
	proxy:PlayAnimation( 10000 , 8284 );--自世界に帰るアニメを再生		
	OnEvent_44_2(proxy,param);
	
	print("OnEvent_44_1 end");
end

--▲自世界に帰るアニメ再生終了▲
function OnEvent_44_2(proxy,param)	
	print("OnEvent_44_2 begin");	
	--完全回復要求
	proxy:RequestFullRecover();
	proxy:WarpNextStage( 1, 0, 0, 0, 2102 );	
	print("OnEvent_44_2 end");
end


------------------------------------------------------------------------------------
--43■石柱上へのローディング
------------------------------------------------------------------------------------
function OnEvent_43(proxy,param)
	print("OnEvent_43 begin");
	proxy:RepeatMessage_begin();
	--▼43_0▼選択メニューの監視▼
		proxy:OnSelectMenu(43, "OnEvent_43_0", 10010710, 0, 2, 1145, 2, once);			
	proxy:RepeatMessage_end();
	print("OnEvent_43 end");
end

--▲43_0▲選択メニューの監視▲
function OnEvent_43_0(proxy, param)
	print("OnEvent_43_0 begin");	
	proxy:PlayAnimation( 10000 , 8283 );--要石に触れるアニメを再生	
	proxy:NoAnimeTurnCharactor( 10000 , 1145 ,TURNSKIP_ANGLE);
	proxy:NotNetMessage_begin();
		--▼要石に触れるアニメ再生終了▼
		proxy:OnChrAnimEnd( 43 , 10000 , 8283 , "OnEvent_43_1" , once );
	proxy:NotNetMessage_end();
	proxy:SetEventFlag( 43 , 1 );
	
	print("OnEvent_43_0 end");
end

--▲43_1▲要石に触れるアニメ再生終了▲
function OnEvent_43_1(proxy, param)
	print("OnEvent_43_1 begin");	
	proxy:PlayAnimation( 10000 , 8284 );--自世界に帰るアニメを再生		
	OnEvent_43_2(proxy,param);
	
	print("OnEvent_43_1 end");
end

--▲自世界に帰るアニメ再生終了▲
function OnEvent_43_2(proxy,param)	
	print("OnEvent_43_2 begin");	
	--完全回復要求
	proxy:RequestFullRecover();
	proxy:WarpNextStage( 1, 0, 0, 0, 2100 );	
	print("OnEvent_43_2 end");
end

--------------------------------------------------------------------------------------
--ボス部屋の中に入る■61
--------------------------------------------------------------------------------------
--■イベントがループなので、全部リピートにする↓
--■61■中ボス部屋への扉が開く■
function OnEvent_61(proxy,param)	
	print("OnEvent_61 begin");
	
	if proxy:IsCompleteEvent( SYSTEM_ID_IGNORE ) == true then
		print("OnEvent_61 end");
		return;
	end
	
	proxy:LuaCallStart( 61 , 1 );--旋回アニメの同期再生
	proxy:SetEventFlag( SYSTEM_ID_IGNORE, true );
	proxy:SetEventFlag( 61, true );
	
	--プロファイルのセーブ
	proxy:SaveRequest_Profile()
	print("OnEvent_61 end");
end


--旋回アニメの同期再生(IDが別)
function OnEvent_61_1(proxy,param)
	print("OnEvent_61_1 begin");
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		if param:IsNetMessage() == true then
			--旋回アニメ再生を同期
			proxy:TurnCharactor( 10001 + param:GetPlayID(), 2891 );
		else
			--旋回アニメ再生を行い、その終了時にOnEvent_61_2を発行する
			proxy:OnTurnCharactorEnd( 61, 10000, 2891, "OnEvent_61_2", once );
		end
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();	
	
	print("OnEvent_61_1 end");
end

--旋回アニメの同期再生終了後
function OnEvent_61_2(proxy,param)
	print("OnEvent_61_2 begin");
	
	--同期用歩きアニメ再生
	proxy:LuaCallStart( 4012, 1 );
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 61, 10000, ANIMEID_WALK, "OnEvent_61_3", once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
		
	print("OnEvent_61_2 end");
end

--歩きアニメの同期再生終了後
function OnEvent_61_3(proxy,param)
	print("OnEvent_61_3 begin");

	--最初の人がボス部屋の中に入り終わっていたら、既に配信されているはずなので、もうおくらないハンドラ
	if proxy:IsCompleteEvent( 61 ) == false then
		proxy:LuaCallStart( 61 , 5 );--2回目以降にボス部屋に入るためのイベント配信用
	end

	--プレイヤーが扉の中に完全にはいったタイミングで、ボスの思考をリセット
	--場所が悪いとプレイヤーを見つけれないため(攻撃してこない)
	if proxy:IsClient() == false then
		proxy:ResetThink( 821 );
	end
	
	proxy:LuaCallStart( 61 , 6 );--フラグセット(同期用)
	proxy:SetEventFlag( SYSTEM_ID_IGNORE,false);	
	print("OnEvent_61_3 end");
end

--[[削除との事なので、コメントアウト
--------------------------------------------------------------------------------------
--物識り敵対■340
--------------------------------------------------------------------------------------
--■341■物識り敵対■
function OnEvent_340(proxy, param)
	print("OnEvent_340 begin");
	proxy:EnableLogic(686,true);--ロジックＯＮ
	proxy:SetTeamType(686, TEAM_TYPE_AngryFriend);--チームタイプ変更
	SetNpcStateFlag( proxy, param, monoshiri_flag_list, MONOSHIRI_STATE_HOSTILE );--敵対状態に

	proxy:SetEventFlag( 340 , 1 );
	print("OnEvent_340 end");
end
--------------------------------------------------------------------------------------
--物識り死亡■341
--------------------------------------------------------------------------------------
--■340■物識り死亡■
function OnEvent_341(proxy, param)
	print("OnEvent_341 begin");

	--物識りの状態フラグを「死亡」にする
	SetNpcStateFlag(proxy, param, monoshiri_flag_list, MONOSHIRI_STATE_DEAD );
	proxy:SetEventFlag( 341 , 1 );
	
	print("OnEvent_341 end");
end
]]



--PCが石柱に戻ってきた時にヒロインの位置を決定する関数
function Lua_SetHeroinPos(proxy,param)
	
	--初期ステータスを設定
	SetFirstNpcStateFlag( proxy , param , warp_list , GO_TO_WARP_OUJOU );	
	
	--アニメIDの定数用意
	local a0000 = -1;
	local a7003 = 7003;--座り
	local a7004 = 7004;--座り
	local a7005 = 7005;--立ち
	local a7006 = 7006;--座り	
	local a7007 = 7003;--座り
	local a7008 = 7008;--座り
	local a7009 = 7005;--立ち
	
	local d0000 = -1;
	local d7003 = 9600;
	local d7004 = 9600;
	local d7005 = -1;
	local d7006 = 9600;
	local d7007 = 9600;
	local d7008 = 9600;
	local d7009 = -1;
	
	local c0000 = -1;
	local c7003 = 7024;	
	local c7004 = 7022;
	local c7005 = -1;
	local c7006 = 7025;
	local c7007 = 7024;
	local c7008 = 7023;
	local c7009 = -1;
	
	--王城に行っていた
	if proxy:IsCompleteEvent( GO_TO_WARP_OUJOU ) == true then
		print("王城に行っていた");
		local Oujou_Apos 	={2200	,2200	,2200	,2200	};
		local Oujou_Aanim 	={a7003	,a7006	,a7007	,a0000	};
		local Oujou_Adam	={d7003	,d7006	,d7007	,d0000	};
		local Oujou_Acan	={c7003	,c7006	,c7007	,c0000	};
		local Oujou_Bpos	={2206	,2210	};
		local Oujou_Banim	={a0000	,a0000	};
		local Oujou_Bdam	={d0000	,d0000	};
		local Oujou_Bcan	={c0000	,c0000	};
		local Oujou_Cpos 	={2205	,2205	,2205	,2207	,2207	,2207	,2208	,2208	,2208	};
		local Oujou_Canim	={a7004	,a7008	,a7009	,a7004	,a7008	,a7009	,a7004	,a7008	,a7009	};
		local Oujou_Cdam	={d7004	,d7008	,d7009	,d7004	,d7008	,d7009	,d7004	,d7008	,d7009	};
		local Oujou_Ccan	={c7004	,c7008	,c7009	,c7004	,c7008	,c7009	,c7004	,c7008	,c7009	};
		local Oujou_Dpos 	={2205	,2209	};
		local Oujou_Danim	={a7005	,a7005	};
		local Oujou_Ddam	={d7005	,d7005	};
		local Oujou_Dcan	={c7005	,c7005	};
		Lua_SetPos(proxy,
		Oujou_Apos,
		Oujou_Aanim,
		Oujou_Adam,
		Oujou_Acan,
		Oujou_Bpos,
		Oujou_Banim,
		Oujou_Bdam,
		Oujou_Bcan,
		Oujou_Cpos,
		Oujou_Canim,
		Oujou_Cdam,
		Oujou_Ccan,
		Oujou_Dpos,
		Oujou_Danim,
		Oujou_Ddam,
		Oujou_Dcan
		);
	end
	
	--古砦に行っていた
	if proxy:IsCompleteEvent( GO_TO_WARP_FURUTORIDE ) == true then
		print("古砦に行っていた");
		local Furutoride_Apos 	={2203	,2203	,2203	,2203	};
		local Furutoride_Aanim 	={a7003	,a7006	,a7007	,a0000	};
		local Furutoride_Adam 	={d7003	,d7006	,d7007	,d0000	};
		local Furutoride_Acan 	={c7003	,c7006	,c7007	,c0000	};
		local Furutoride_Bpos	={2206	,2210	};
		local Furutoride_Banim	={a0000	,a0000	};
		local Furutoride_Bdam	={d0000	,d0000	};
		local Furutoride_Bcan	={c0000	,c0000	};
		local Furutoride_Cpos 	={2205	,2205	,2205	,2207	,2207	,2207	,2208	,2208	,2208	};
		local Furutoride_Canim	={a7004	,a7008	,a7009	,a7004	,a7008	,a7009	,a7004	,a7008	,a7009	};
		local Furutoride_Cdam	={d7004	,d7008	,d7009	,d7004	,d7008	,d7009	,d7004	,d7008	,d7009	};
		local Furutoride_Ccan	={c7004	,c7008	,c7009	,c7004	,c7008	,c7009	,c7004	,c7008	,c7009	};
		local Furutoride_Dpos 	={2205	,2209	};
		local Furutoride_Danim	={a7005	,a7005	};
		local Furutoride_Ddam	={d7005	,d7005	};
		local Furutoride_Dcan	={c7005	,c7005	};
		Lua_SetPos(proxy,
			Furutoride_Apos,
			Furutoride_Aanim,
			Furutoride_Adam,
			Furutoride_Acan,
			Furutoride_Bpos,
			Furutoride_Banim,
			Furutoride_Bdam,
			Furutoride_Bcan,
			Furutoride_Cpos,
			Furutoride_Canim,
			Furutoride_Cdam,
			Furutoride_Ccan,
			Furutoride_Dpos,
			Furutoride_Danim,
			Furutoride_Ddam,
			Furutoride_Dcan
			);
	end
	
	--牢城に行っていた
	if proxy:IsCompleteEvent( GO_TO_WARP_ROUJOU ) == true then
		print("牢城に行っていた");
		local Roujou_Apos 	={2202	,2202	,2202	,2202	};
		local Roujou_Aanim 	={a0000	,a7004	,a7008	,a7009	};
		local Roujou_Adam 	={d0000	,d7004	,d7008	,d7009	};
		local Roujou_Acan 	={c0000	,c7004	,c7008	,c7009	};
		local Roujou_Bpos	={2206	,2210	};
		local Roujou_Banim	={a0000	,a0000	};
		local Roujou_Bdam	={d0000	,d0000	};
		local Roujou_Bcan	={c0000	,c0000	};
		local Roujou_Cpos 	={2205	,2205	,2205	,2207	,2207	,2207	,2208	,2208	,2208	};
		local Roujou_Canim	={a7004	,a7008	,a7009	,a7004	,a7008	,a7009	,a7004	,a7008	,a7009	};
		local Roujou_Cdam	={d7004	,d7008	,d7009	,d7004	,d7008	,d7009	,d7004	,d7008	,d7009	};
		local Roujou_Ccan	={c7004	,c7008	,c7009	,c7004	,c7008	,c7009	,c7004	,c7008	,c7009	};
		local Roujou_Dpos 	={2205	,2209	};
		local Roujou_Danim	={a7005	,a7005	};
		local Roujou_Ddam	={d7005	,d7005	};
		local Roujou_Dcan	={c7005	,c7005	};
		Lua_SetPos(proxy,
			Roujou_Apos,
			Roujou_Aanim,
			Roujou_Adam,
			Roujou_Acan,
			Roujou_Bpos,
			Roujou_Banim,
			Roujou_Bdam,
			Roujou_Bcan,
			Roujou_Cpos,
			Roujou_Canim,
			Roujou_Cdam,
			Roujou_Ccan,
			Roujou_Dpos,
			Roujou_Danim,
			Roujou_Ddam,
			Roujou_Dcan);
	end
	
	--不浄に行っていた
	if proxy:IsCompleteEvent( GO_TO_WARP_FUJOU ) == true then
		print("不浄に行っていた");
		local Fujou_Apos 	={2204	,2204	,2204	,2204	};
		local Fujou_Aanim 	={a7003	,a7006	,a7007	,a0000	};
		local Fujou_Adam 	={d7003	,d7006	,d7007	,d0000	};
		local Fujou_Acan 	={c7003	,c7006	,c7007	,c0000	};
		local Fujou_Bpos	={2206	,2210	};
		local Fujou_Banim	={a0000	,a0000	};
		local Fujou_Bdam	={d0000	,d0000	};
		local Fujou_Bcan	={c0000	,c0000	};
		local Fujou_Cpos 	={2205	,2205	,2205	,2207	,2207	,2207	,2208	,2208	,2208	};
		local Fujou_Canim	={a7004	,a7008	,a7009	,a7004	,a7008	,a7009	,a7004	,a7008	,a7009	};
		local Fujou_Cdam	={d7004	,d7008	,d7009	,d7004	,d7008	,d7009	,d7004	,d7008	,d7009	};
		local Fujou_Ccan	={c7004	,c7008	,c7009	,c7004	,c7008	,c7009	,c7004	,c7008	,c7009	};
		local Fujou_Dpos 	={2205	,2209	};
		local Fujou_Danim	={a7005	,a7005	};
		local Fujou_Ddam	={d7005	,d7005	};
		local Fujou_Dcan	={c7005	,c7005	};
		Lua_SetPos(proxy,
			Fujou_Apos,
			Fujou_Aanim,
			Fujou_Adam,
			Fujou_Acan,
			Fujou_Bpos,
			Fujou_Banim,
			Fujou_Bdam,
			Fujou_Bcan,
			Fujou_Cpos,
			Fujou_Canim,
			Fujou_Cdam,
			Fujou_Ccan,
			Fujou_Dpos,
			Fujou_Danim,
			Fujou_Ddam,
			Fujou_Dcan);
	end
	
	--坑道に行っていた
	if proxy:IsCompleteEvent( GO_TO_WARP_KOUDOU ) == true then
		print("坑道に行っていた");
		local Koudou_Apos 	={2201	,2201	,2201	,2201	};
		local Koudou_Aanim 	={a7003	,a7006	,a7007	,a0000	};
		local Koudou_Adam 	={d7003	,d7006	,d7007	,d0000	};
		local Koudou_Acan 	={c7003	,c7006	,c7007	,c0000	};
		local Koudou_Bpos	={2206	,2210	};
		local Koudou_Banim	={a0000	,a0000	};
		local Koudou_Bdam	={d0000	,d0000	};
		local Koudou_Bcan	={c0000	,c0000	};
		local Koudou_Cpos 	={2205	,2205	,2205	,2207	,2207	,2207	,2208	,2208	,2208	};
		local Koudou_Canim	={a7004	,a7008	,a7009	,a7004	,a7008	,a7009	,a7004	,a7008	,a7009	};
		local Koudou_Cdam	={d7004	,d7008	,d7009	,d7004	,d7008	,d7009	,d7004	,d7008	,d7009	};
		local Koudou_Ccan	={c7004	,c7008	,c7009	,c7004	,c7008	,c7009	,c7004	,c7008	,c7009	};
		local Koudou_Dpos 	={2205	,2209	};
		local Koudou_Danim	={a7005	,a7005	};
		local Koudou_Ddam	={d7005	,d7005	};
		local Koudou_Dcan	={c7005	,c7005	};
		Lua_SetPos(proxy,
			Koudou_Apos,
			Koudou_Aanim,
			Koudou_Adam,
			Koudou_Acan,
			Koudou_Bpos,
			Koudou_Banim,
			Koudou_Bdam,
			Koudou_Bcan,
			Koudou_Cpos,
			Koudou_Canim,
			Koudou_Cdam,
			Koudou_Ccan,
			Koudou_Dpos,
			Koudou_Danim,
			Koudou_Ddam,
			Koudou_Dcan);
	end
	
	--北限に行っていた
	if proxy:IsCompleteEvent( GO_TO_WARP_HOKUGEN ) == true then
		print("北限に行っていた");
		local Hokugen_Apos 	={2200	,2200	,2200	,2200	};
		local Hokugen_Aanim ={a7003	,a7006	,a7007	,a0000	};
		local Hokugen_Adam	={d7003	,d7006	,d7007	,d0000	};
		local Hokugen_Acan	={c7003	,c7006	,c7007	,c0000	};
		local Hokugen_Bpos	={2206	,2210	};
		local Hokugen_Banim	={a0000	,a0000	};
		local Hokugen_Bdam	={d0000	,d0000	};
		local Hokugen_Bcan	={c0000	,c0000	};
		local Hokugen_Cpos 	={2205	,2205	,2205	,2207	,2207	,2207	,2208	,2208	,2208	};
		local Hokugen_Canim	={a7004	,a7008	,a7009	,a7004	,a7008	,a7009	,a7004	,a7008	,a7009	};
		local Hokugen_Cdam	={d7004	,d7008	,d7009	,d7004	,d7008	,d7009	,d7004	,d7008	,d7009	};
		local Hokugen_Ccan	={c7004	,c7008	,c7009	,c7004	,c7008	,c7009	,c7004	,c7008	,c7009	};
		local Hokugen_Dpos 	={2205	,2209	};
		local Hokugen_Danim	={a7005	,a7005	};
		local Hokugen_Ddam	={d7005	,d7005	};
		local Hokugen_Dcan	={c7005	,c7005	};
		Lua_SetPos(proxy,
			Hokugen_Apos,
			Hokugen_Aanim,
			Hokugen_Adam,
			Hokugen_Acan,
			Hokugen_Bpos,
			Hokugen_Banim,
			Hokugen_Bdam,
			Hokugen_Bcan,
			Hokugen_Cpos,
			Hokugen_Canim,
			Hokugen_Cdam,
			Hokugen_Ccan,
			Hokugen_Dpos,
			Hokugen_Danim,
			Hokugen_Ddam,
			Hokugen_Dcan);
	end
end


function Lua_SetPos(
proxy,
list_Apos,
list_Aanim,
list_Adam,
list_Acan,
list_Bpos,
list_Banim,
list_Bdam,
list_Bcan,
list_Cpos,
list_Canim,
list_Cdam,
list_Ccan,
list_Dpos,
list_Danim,
list_Ddam,
list_Dcan
)
	
	local heroine = 615;
	--乱数取得
	local randA = proxy:GetRandom(0,100);
	local dbgrandA = proxy:GetDbgRandomA();
	--デバッグ乱数があればそっちを使う(製品では必ず-1が帰ります要らなくなったらコメントアウト推奨)
	if dbgrandA ~= -1 then
		randA = dbgrandA;
	end	
	print("ヒロイン出待ち乱数A",randA);	
	
	--乱数取得
	local randB = proxy:GetRandom(0,100);
	local dbgrandB = proxy:GetDbgRandomB();	
	if dbgrandB ~= -1 then
		randB = dbgrandB;
	end	
	print("ヒロイン出待ち乱数B",randB);	
		
	if randA <= 40 then
		local Aindex = 1;
		if randB <= 25 then
			Aindex = 1;
		elseif randB <= 50 then
			Aindex = 2;
		elseif randB <= 75 then
			Aindex = 3;
		else
			Aindex = 4;
		end
		proxy:Warp( heroine , list_Apos[Aindex] );
		proxy:ChangeInitPosAng(heroine,  list_Apos[Aindex] );
		proxy:SetSpStayAndDamageAnimIdPlus( heroine , list_Aanim[Aindex] ,list_Adam[Aindex] , list_Acan[Aindex]);
		hiroin_cancelAnimId = list_Acan[Aindex];
		print("ヒロイン pos:",list_Apos[Aindex]," anim:",list_Aanim[Aindex]);
	elseif randA <= 70 then
		local Bindex = 1;
		if randB <= 50 then
			Bindex = 1;
		else
			Bindex = 2;
		end
		proxy:Warp( heroine , list_Bpos[Bindex] );
		proxy:ChangeInitPosAng(heroine,  list_Apos[Aindex] );
		proxy:SetSpStayAndDamageAnimIdPlus( heroine , list_Banim[Bindex] ,list_Bdam[Bindex] , list_Bcan[Bindex] );
		hiroin_cancelAnimId = list_Bcan[Bindex];
		print("ヒロイン pos:",list_Bpos[Bindex]," anim:",list_Banim[Bindex]);
	elseif randA <= 90 then
		local Cindex = 1;
		--[[
		if randB <= 20 then			
			Cindex = 1;
		elseif randB <= 30 then
			Cindex = 2;
			]]
		if randB <= 20 then
			Cindex = 3;
		elseif randB <= 40 then
			Cindex = 4;
		elseif randB <= 60 then
			Cindex = 5;
		elseif randB <= 70 then
			Cindex = 6;
		elseif randB <= 80 then
			Cindex = 7;
		elseif randB <= 90 then
			Cindex = 8;
		else
			Cindex = 9;
		end
		proxy:Warp( heroine , list_Cpos[Cindex] );
		proxy:ChangeInitPosAng(heroine,  list_Apos[Aindex] );
		proxy:SetSpStayAndDamageAnimIdPlus( heroine , list_Canim[Cindex] ,list_Cdam[Cindex] ,list_Ccan[Cindex]);
		hiroin_cancelAnimId = list_Ccan[Cindex];
		print("ヒロイン pos:",list_Cpos[Cindex]," anim:",list_Canim[Cindex]);
	else
		local Dindex = 1;
		if randB <= 50 then
			Dindex = 1;
		else
			Dindex = 2;
		end
		proxy:Warp( heroine , list_Dpos[Dindex] );
		proxy:ChangeInitPosAng(heroine,  list_Apos[Aindex] );
		proxy:SetSpStayAndDamageAnimIdPlus( heroine , list_Danim[Dindex] ,list_Ddam[Dindex] ,list_Dcan[Dindex] );
		hiroin_cancelAnimId = list_Dcan[Dindex];
		print("ヒロイン pos:",list_Dpos[Dindex]," anim:",list_Danim[Dindex]);
	end	
end


--------------------------------------------------------------------------------------
--光の壁の前会話■72
--------------------------------------------------------------------------------------
function OnEvent_72(proxy,param)
	print("OnEvent_72 beign");
	proxy:SetEventFlag( 72, true );
	proxy:CloseMenu();
	proxy:TalkNextPage( 72 );
	--proxy:SetEventFlag( 61 , false );
	print("OnEvent_72 end");
end


--------------------------------------------------------------------------------------
--光の壁を越えた時の会話用■73
--------------------------------------------------------------------------------------
function OnEvent_73(proxy,param)
	print("OnEvent_73 begin");
	proxy:SetEventFlag( 73, true );
	print("OnEvent_73 end");
end


--------------------------------------------------------------------------------------
--トロフィー開放■510
--------------------------------------------------------------------------------------
function OnEvent_510(proxy,param)
	print("☆☆☆☆☆☆☆☆☆☆☆☆OnEvent_510☆☆☆☆☆☆☆☆☆☆☆☆");
	Lua_RequestUnlockTrophy(proxy, 1);--トロフィの状況を判定し、取得する
	proxy:SetEventFlag( 510 , true );
end


function LastRemoveEquip(proxy)
	--RemoveInventoryEquip(const dl_int32 nType,const dl_int32 nId)
	print("LastRemoveEquip begin");
	proxy:RemoveInventoryEquip(TYPE_GOODS,8);	
	proxy:RemoveInventoryEquip(TYPE_GOODS,9);
	proxy:RemoveInventoryEquip(TYPE_GOODS,10);
	proxy:RemoveInventoryEquip(TYPE_GOODS,11);
	proxy:RemoveInventoryEquip(TYPE_GOODS,12);
	proxy:RemoveInventoryEquip(TYPE_GOODS,13);
	proxy:RemoveInventoryEquip(TYPE_GOODS,14);
	proxy:RemoveInventoryEquip(TYPE_GOODS,35);
	proxy:RemoveInventoryEquip(TYPE_GOODS,36);
	proxy:RemoveInventoryEquip(TYPE_GOODS,39);
	proxy:RemoveInventoryEquip(TYPE_GOODS,40);
	proxy:RemoveInventoryEquip(TYPE_GOODS,41);
	proxy:RemoveInventoryEquip(TYPE_GOODS,42);
	proxy:RemoveInventoryEquip(TYPE_GOODS,43);
	proxy:RemoveInventoryEquip(TYPE_GOODS,44);	
	print("LastRemoveEquip end");	
end

--■75■ラスボスの死体調べた■
function OnEvent_75(proxy,param)
	print("OnEvent_75 begin");
	proxy:SetDispMask(821, 1);--使い方あっているのか？
	print("OnEvent_75 end");
end


--ソウルブランドを調べた
function OnEvent_141(proxy, param)
	if param:IsNetMessage() == false then
	print("OnEvent_141 begin");
	proxy:NotNetMessage_begin();
	proxy:RepeatMessage_begin();
		proxy:PlayAnimation( 10000 , 8290);		
		proxy:PlayAnimation( 1130 , 1);	
		proxy:OnKeyTime2( 141 , "OnEvent_141_0",0.01,0,0,once);
	proxy:RepeatMessage_end();
	proxy:NotNetMessage_end();	
	print("OnEvent_141 end");
	end
end

function OnEvent_141_0(proxy,param)
	print("OnEvent_141_0 begin");
	--if proxy:IsPlayerStay(10000) == true then
	if proxy:IsEventAnim( 10000 , 8290 ) == true then
		proxy:LuaCallStart( 141 , 2 );
	else
		proxy:ForcePlayAnimation( 1130 , 0);	
	end
	print("OnEvent_141_0 end");
end

--■141_1■アイテム取得■
function OnEvent_141_1(proxy, param)
	print("OnEvent_141_1 begin");

	--アイテム取得関数--パラメータ10104参照
	proxy:GetRateItem(10730);	
	
	--アイテムを取得済み
	proxy:SetEventFlag( 141, 1 );
	
	--OBJを消すためのイベント配信
	proxy:LuaCallStart( 141, 1);
	
	print("OnEvent_141_1 end");
end

--■141_2■剣OBJ非表示用■
function OnEvent_141_2(proxy,param)
	print("OnEvent_141_2 begin");
	--オブジェが消える
	proxy:SetDrawEnable( 1130 , false );--ひとまず描画だけOFF
	proxy:SetColiEnable( 1130 , false );--当たりはあるのは不明(現状ではないようなので消さない)	
	--イベント消える
	proxy:DeleteEvent( 141 );
	print("OnEvent_141_2 end");
end

--アニメ再生の同期＆監視
function OnEvent_141_3(proxy,param)
	print("OnEvent_141_3 begin");
	
	proxy:TreasureDispModeChange2( 1130, false ,KEN_SFX);
	proxy:InvalidSfx( 1131 , true );
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした)
	if Luafunc_PlaySynchroAnimation( proxy, param, 8290 ) == true then--新しいアニメ 
		proxy:PlayAnimation( 1130 , 1);	
		print("OnEvent_141_3 end");
		return true;
	end
	
	--剣にワープ
	proxy:WarpDmy( LOCAL_PLAYER , 1130 , 191 );		
	
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 141 , LOCAL_PLAYER , 8290 , "OnEvent_141_1", once);
	proxy:NotNetMessage_end();
	
	print("OnEvent_141_3 end");
end

function OnEvent_141_WAIT(proxy,param)
	print("OnEvent_141_WAIT begin");
	--ホスト、生存、グレイのみ調べることができる
	local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;				
	proxy:OnDistanceActionAttribute( 141 , LOCAL_PLAYER , 1130 , "OnEvent_141" , ItemBoxDist_A , 10010135 , 0 , ItemBoxAngle_A ,possible_chr_type, everytime ); 
	proxy:LuaCall( 141,1,"OnEvent_141_2",once);
	proxy:LuaCall( 141,2,"OnEvent_141_3",once);
	proxy:SetDrawEnable( 1130 , true );
	proxy:SetColiEnable( 1130 , true );
	proxy:TreasureDispModeChange2( 1130, true ,KEN_SFX);
	print("OnEvent_141_WAIT end")
end
