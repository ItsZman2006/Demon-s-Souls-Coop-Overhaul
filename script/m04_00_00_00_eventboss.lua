
--発動する行動ID
MAGIC_ID = 11;

--魔方陣設置時のエフェクト
SET_MAGICSQUARE = 701;

--魔方陣反応のみのエフェクト
CHECK_MAGICSQUARE = 702;
--魔方陣発動時のエフェクト
BEGIN_MAGICSQUARE = 703;

--ワープ先テーブル
Telepotbl = { 2980, 2981, 2982, 2983, 2984, 2985, 2986, 2987};

--新ワープ先テーブル
GodEvidTbl			= {  806,  812,  813,  814,  815};
God_Warp_AcidTbl	= { 2011, 2012, 2013, 2014, 2015};

--偽カミサマ有効チェック用テーブル(本物は必要ないので-1)
God_IsValid_AcidTbl	= {   -1, 2016, 2017, 2018, 2019};

--カミサマの消えるアニメ終了監視
God_EraseAnim_AcidTbl	= { 2035, 2036, 2037, 2038, 2039};
God_EraseAnim_AcidTbl2	= { 2055, 2056, 2057, 2058, 2059};

--						   1,	 2,    3,    4,    5,    6,    7,    8,    9,   10,   11,   12,   13,   14,   15,   16,   17,   18,   19,   20
RealGodWarpTbl		= { 2988, 2991, 2983, 2985, 2990, 2986, 2987, 2983, 2989, 2991, 2980, 2984, 2981, 2990, 2982, 2986, 2986, 2982, 2991, 2980};--本物
DummyGodWarpTbl_1 	= { 2982, 2982, 2980, 2980, 2980, 2980, 2980, 2980, 2980, 2980, 2983, 2983, 2982, 2982, 2984, 2984, 2982, 2986, 2980, 2991};--偽者１
DummyGodWarpTbl_2 	= { 2983, 2983, 2985, 2983, 2985, 2985, 2983, 2987, 2991, 2989, 2984, 2980, 2990, 2981, 2985, 2985, 2990, 2990, 2989, 2989};--偽者２
DummyGodWarpTbl_3 	= { 2991, 2988, 2986, 2986, 2986, 2990, 2986, 2986, 2992, 2992, 2985, 2985, 2992, 2992, 2986, 2982,   -1,   -1,   -1,   -1};--偽者３
DummyGodWarpTbl_4 	= { 2992, 2992, 2990, 2990, 2989, 2989, 2990, 2990,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1};--偽者４
--GodWarpTblList = { RealGodWarpTbl,DummyGodWarpTbl_1,DummyGodWarpTbl_2,DummyGodWarpTbl_3,DummyGodWarpTbl_4};


--ワープパターンA
RealGodWarpTbl_A	= { 2986, 2982, 2991, 2980, 2990, 2985, 2989, 2980};
DummyGodWarpTbl_1A	= { 2982, 2986, 2980, 2991, 2980, 2989, 2987, 2986};
DummyGodWarpTbl_2A	= {   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1};
DummyGodWarpTbl_3A	= {   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1};
DummyGodWarpTbl_4A	= {   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1};
GodWarpTblList_A	= {RealGodWarpTbl_A, DummyGodWarpTbl_1A, DummyGodWarpTbl_2A, DummyGodWarpTbl_3A, DummyGodWarpTbl_4A };

--ワープパターンB
RealGodWarpTbl_B	= { 2986, 2982, 2991, 2980, 2980, 2981, 2990, 2988};
DummyGodWarpTbl_1B	= { 2982, 2986, 2980, 2991, 2984, 2984, 2983, 2983};
DummyGodWarpTbl_2B	= { 2990, 2990, 2989, 2989, 2985, 2992, 2987, 2987};
DummyGodWarpTbl_3B	= {   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1};
DummyGodWarpTbl_4B	= {   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1};
GodWarpTblList_B	= {RealGodWarpTbl_B, DummyGodWarpTbl_1B, DummyGodWarpTbl_2B, DummyGodWarpTbl_3B, DummyGodWarpTbl_4B };

--ワープパターンC
RealGodWarpTbl_C	= { 2989, 2991, 2980, 2984, 2981, 2990, 2982, 2986};
DummyGodWarpTbl_1C	= { 2980, 2980, 2983, 2983, 2982, 2982, 2984, 2984};
DummyGodWarpTbl_2C	= { 2991, 2989, 2984, 2980, 2990, 2981, 2985, 2985};
DummyGodWarpTbl_3C	= { 2992, 2992, 2985, 2985, 2992, 2992, 2986, 2982};
DummyGodWarpTbl_4C	= {   -1,   -1,   -1,   -1,   -1,   -1,   -1,   -1};
GodWarpTblList_C	= {RealGodWarpTbl_C, DummyGodWarpTbl_1C, DummyGodWarpTbl_2C, DummyGodWarpTbl_3C, DummyGodWarpTbl_4C };

--ワープパターンD
RealGodWarpTbl_D	= { 2988, 2991, 2983, 2985, 2990, 2986, 2987, 2983};
DummyGodWarpTbl_1D	= { 2982, 2982, 2980, 2980, 2980, 2980, 2980, 2980};
DummyGodWarpTbl_2D	= { 2983, 2983, 2985, 2983, 2985, 2985, 2983, 2987};
DummyGodWarpTbl_3D	= { 2991, 2988, 2986, 2986, 2986, 2990, 2986, 2986};
DummyGodWarpTbl_4D	= { 2992, 2992, 2990, 2990, 2989, 2989, 2990, 2990};
GodWarpTblList_D	= {RealGodWarpTbl_D, DummyGodWarpTbl_1D, DummyGodWarpTbl_2D, DummyGodWarpTbl_3D, DummyGodWarpTbl_4D };
GodWarpTblList		= {GodWarpTblList_A,GodWarpTblList_B,GodWarpTblList_C,GodWarpTblList_D};

GodHpJudge_patternB	= 0.8;--パターンBに移行するHP割合条件(1.0で100%以下, 0.8で80%以下が条件となる)
GodHpJudge_patternC	= 0.6;--パターンCに移行するHP割合条件(1.0で100%以下, 0.8で80%以下が条件となる)
GodHpJudge_patternD	= 0.3;--パターンDに移行するHP割合条件(1.0で100%以下, 0.8で80%以下が条件となる)

god_num 			= table.getn( GodWarpTblList_A );
god_state			= 1;



--魔方陣パターンテーブル　列挙された領域に魔方陣が設置されます。
--パターン選択は現在ランダム　１～5
pattern1 = { 2900, 2901, 2902, 2904, 2905, 2906, 2908, 2909, 2910, 2911};
pattern2 = { 2900, 2901, 2903, 2905, 2907, 2908, 2909, 2910, 2912};
pattern3 = { 2900, 2901, 2902, 2904, 2906, 2907, 2908, 2911, 2912};
pattern4 = { 2900, 2901, 2903, 2905, 2906, 2908, 2909, 2910, 2912};
pattern5 = { 2900, 2901, 2902, 2903, 2904, 2907, 2909, 2911, 2912};

--魔方陣の監視アクションID
evetbl = { 1999 , 2000 , 2001 , 2002 , 2003 , 2004 , 2005 , 2006 , 2007 };

--ローカルプレイヤと奴隷兵のイベントIDリスト(主にターゲットの設定、魔方陣の反応に仕様)
chrtbl = { 10000, 2960, 2961, 2962, 2963, 2964, 2965, 2966, 2967};

--カミサマテーブル用の乱数保持変数
god_rand = 0;

--アニメ終了とEzState監視の順序をあべこべにしない為の、
--アニメ終了監視中のキャラのイベントID格納変数
now_condition_anim_end_chr	= 0;

--[[---------------------------------------------------------------------------------------------------------
---------------------------------------カミサマのアクションID内訳--------------------------------------------
-------------------------------------------------------------------------------------------------------------
--カミサマ魔方陣攻撃開始			1997
--カミサマ瞬間移動EzState			1998
--魔方陣監視						1999, 2000, 2001, 2002, 2003, 2004, 2005, 2006, 2007
--無し								2008～2009
--同期ワープ						2010
--偽カミサマ瞬間移動EzState			2011, 2012, 2013, 2014, 2015
--カミサマの有効チェック			2016, 2017, 2018, 2019
--魔方陣登録						2020
--魔方陣削除						2021
--HP監視B,C,D						2022, 2023, 2024
--無し								2025～2029
--ボス部屋の人がいるかの領域監視	2030
--同期旋回							2031
--無し								2032
--同期フラグセット,リセット,削除	2033
--カミサマ復活フラグ監視			2034
--カミサマ消えるアニメ終了監視		2035, 2036, 2037, 2038, 2039
--フラグ遅延						2040
--無し								2041
--カミサマ復活維持					2042
--ResetThinkの同期をキック			↑
--無し								2043
--偽カミサマの同期消えるアニメ		2044
--偽カミサマの同期無効化			↑
--偽カミサマの同期有効化			↑
--カミサマワープ再スタート			2045
--カミサマ同期ロジックOn/Off		2046
--カミサマの死亡監視再登録			2047
--同期復活、再スタート				↑
--同期ResetThink					↑
--神様のダメージ監視				2048？
--神様死亡時用の消えるアニメ監視	2055, 2056, 2057, 2058, 2059
]]


--------------------------------------------------------------------------------------
--イベント初期化■ボス固有のイベントを登録する際に使用してください
--------------------------------------------------------------------------------------
--■1997～2047■中ボス用アクションID■
function EventBoss_Initialize_m04_00_00_00(proxy)
	print("EventBoss_Initialize_m04_00_00_00 begin");
	
	--
	proxy:AddFieldInsFilter(806);
	local num = table.getn( chrtbl );
	for index = 2, num, 1 do
		proxy:AddFieldInsFilter( chrtbl[index] );
	end
	
	--ボスが生きていたら
	proxy:CustomLuaCall(2010, "KamisamaSynchroWarp", everytime );
	if proxy:IsCompleteEvent( 5123 ) == false then
		BossInit_GodDemon(proxy,param);
		--if proxy:IsLivePlayer() == true or proxy:IsGreyGhost() == true then
		if	proxy:IsClient() == false then
			print("RequestForceUpdateNetwork 806 実行");
			proxy:RequestForceUpdateNetwork( 806 );
			proxy:RequestForceUpdateNetwork( 812 );
			proxy:RequestForceUpdateNetwork( 813 );
			proxy:RequestForceUpdateNetwork( 814 );
			proxy:RequestForceUpdateNetwork( 815 );
			proxy:RequestForceUpdateNetwork( 816 );
			
			--イベントジェネレートする事を設定
			proxy:SetEventGenerate( 806 , true );
		end
	else
		InvalidBackRead(proxy,806);
		InvalidBackRead(proxy,812);
		InvalidBackRead(proxy,813);
		InvalidBackRead(proxy,814);
		InvalidBackRead(proxy,815);
		InvalidBackRead(proxy,816);
	end
	
	if	proxy:IsClient()	== false	or
		proxy:IsHost() 		== true		then
		proxy:NotNetMessage_begin();
			--■5504■カミサマデーモン　魔方陣攻撃の開始監視■
			proxy:OnCheckEzStateMessage(1997,806,"OnEvent_1997",250);
			--■5505■カミサマデーモン　瞬間移動先へのワープ■
			proxy:OnCheckEzStateMessage(1998,806,"OnEvent_1998",251);			
			
			--■2048■カミサマデーモン　ダメージ監視■
			proxy:RepeatMessage_begin();
				proxy:OnSimpleDamage( 2048 , 806 , -1 , "OnEvent_2048",once);
			proxy:RepeatMessage_end();
			
		proxy:NotNetMessage_end();
	end
		
	--■2020■魔方陣設置用1■常駐
	proxy:LuaCall(2020,1,"Registpattern01",everytime);
	--■2020■魔方陣設置用2■常駐
	proxy:LuaCall(2020,2,"Registpattern02",everytime);
	--■2020■魔方陣設置用3■常駐
	proxy:LuaCall(2020,3,"Registpattern03",everytime);
	--■2020■魔方陣設置用4■常駐
	proxy:LuaCall(2020,4,"Registpattern04",everytime);
	--■2020■魔方陣設置用5■常駐
	proxy:LuaCall(2020,5,"Registpattern05",everytime);
	
	--■2021■魔方陣削除用■常駐
	proxy:LuaCall(2021,0,"UnRegistMagicSquare",everytime);
	
	if proxy:IsCompleteEvent( 5123 ) == false then
	
		
	--■2030■領域監視■
		proxy:SetEventFlag( 2030, false );
		proxy:OnNetRegion( 2030 , 2100 );
	end
	
	--■2044_9600■偽カミサマの消えるアニメ同期再生■
	proxy:LuaCall( 2044, 9010, "GodSynchroAnime", everytime );
	proxy:LuaCall( 2044, 9600, "GodSynchroAnime", everytime );
	--■2044_2■偽カミサマの同期無効化■
	proxy:LuaCall( 2044, 2, "GodSynchroInvalid", everytime );
	--■2044_3■偽カミサマの同期有効化■
	proxy:LuaCall( 2044, 3, "GodSynchroValid", everytime );	
	
	
	proxy:LuaCall( 2045, 2, "OnEvent_2045", everytime );
	
	
	proxy:LuaCall( 2047, 3, "SynchroDeadCondition", everytime );
	
	
	--グローバルに移した方が良いかも
	--同期の旋回→歩き、フラグOn/Off
	proxy:LuaCall( 2031, 2, "SynchroTurn", everytime );
	proxy:LuaCall( 2033, 2, "SynchroSetFlag", everytime );
	proxy:LuaCall( 2033, 3, "SynchroResetFlag", everytime );
	proxy:LuaCall( 2033, 4, "SynchroDeleteEvent", everytime );
	proxy:LuaCall( 2033, 5, "SynchroValidSoul", everytime );
	proxy:LuaCall( 2033, 6, "SynchroBossFloorIn", everytime );
	
	proxy:LuaCall( 2043, 2, "ForcePlayAnimation_806", everytime );
	proxy:LuaCall( 2043, 3, "PlayAnimation_806", everytime );
	proxy:LuaCall( 2043, 4, "WarpRestart_806", everytime );
	
	SingleReset( proxy, 365 );
	SingleReset( proxy,	8548);	
	proxy:SetEventFlag( 367 , false );
	proxy:SetEventFlag( 368 , false );
	
	proxy:LuaCall( 365 , 0 ,"OnEvent_365",everytime );
	
	proxy:NotNetMessage_begin();
		proxy:OnRegionJustIn( 367 , 10000 , 2006 , "OnEvent_367_In", everytime );
		proxy:OnRegionJustOut(367 , 10000 , 2006 , "OnEvent_367_Out",everytime );
		
		proxy:OnRegionJustIn( 368 , 10000 , 2007 , "OnEvent_368_In", everytime );
		proxy:OnRegionJustOut(368 , 10000 , 2007 , "OnEvent_368_Out",everytime );		
	proxy:NotNetMessage_end();
	
	print("EventBoss_Initialize_m04_00_00_00 end");
end

function WarpRestart_806(proxy,param)
	print("WarpRestart_806 begin");
	proxy:WarpRestart( 806, 2989 );
	print("WarpRestart_806 end");
end

function ForcePlayAnimation_806(proxy,param)
	print("ForcePlayAnimation_806 begin");
	proxy:ForcePlayAnimation( 806, 0 );
	print("ForcePlayAnimation_806 end");
end

function PlayAnimation_806(proxy,param)
	print("PlayAnimation_806 begin");
	proxy:PlayAnimation( 806, 0 );
	print("ForcePlayAnimation_806 end");
end


--------------------------------------------------------------------------------------
--ボス用の初期化処理が必要なときに使用：固有情報の作成等
--------------------------------------------------------------------------------------
function BossInit_GodDemon(proxy,param)	
	print("BossInit_GodDemon begin");
	local num = table.getn( chrtbl );
	--最初のインデックスは自キャラを設定しているのでその次から
	for index = 2, num , 1 do
		--信者に対してカミサマデーモンをイベントターゲットとして設定する
		proxy:SetEventTarget( chrtbl[ index ] , 806 );
	end
	
	
	print("BossInit_GodDemon InvalidCharactor = ", 816);
	InvalidCharactor(proxy, 816);
	local god_num = table.getn( GodEvidTbl );
	for index = 2, god_num, 1 do
		print("BossInit_GodDemon evid",GodEvidTbl[index]);
		--proxy:EnableInvincible(GodEvidTbl[index], true );--ここで無敵にしておく
		proxy:SetDeadMode(GodEvidTbl[index], true );--ここで無敵にしておく
		proxy:SetSuperArmor(GodEvidTbl[index], true );--ここで無敵にしておく
		proxy:SetDisableGravity(GodEvidTbl[index] ,true );--ここで無重力にしておく
		
		proxy:SetEventFlag( God_Warp_AcidTbl[index], false );--偽カミサマのワープフラグは消しておく
		
		print("BossInit_GodDemon InvalidCharactor = ", GodEvidTbl[index]);
		InvalidCharactor( proxy, GodEvidTbl[index] );
		--1体は予備としているので、無効化
		
		--ここはホストのみ実行
		if	proxy:IsClient() == false then
			--proxy:Warp( GodEvidTbl[index], 2986 );
			--proxy:Warp( GodEvidTbl[index], GodWarpTblList[god_state][index][1] );
			
			proxy:CustomLuaCallStartPlus(2010,GodEvidTbl[index], GodWarpTblList[god_state][index][1] );
			proxy:NotNetMessage_begin();
				--OnEvent_2011,OnEvent_2012,OnEvent_2013,OnEvent_2014,OnEvent_2015
				proxy:OnCheckEzStateMessage( God_Warp_AcidTbl[index],GodEvidTbl[index],"OnEvent_"..God_Warp_AcidTbl[index], 252 );
			proxy:NotNetMessage_end();
		end
	end

	if	proxy:IsClient() == true then
		--本体以外の有効無効をあわせる
		for index = 2, god_num, 1 do
			if	proxy:IsCompleteEvent(God_IsValid_AcidTbl[index]) == true then
				ValidCharactor( proxy,GodEvidTbl[index]);
			end
		end
	
		--本体の有効無効をあわせる
		if	proxy:IsCompleteEvent( 1998 ) == true then
			InvalidCharactor( proxy, GodEvidTbl[1] );
		end
	end

	print("BossInit_GodDemon end");
end

--------------------------------------------------------------------------------------
--カミサマデーモン死亡
--------------------------------------------------------------------------------------
function GodDemonDead(proxy,param)
	print("GodDemonDead begin");
	local index = 1;
	local tblnum = table.getn( evetbl );
	for index = 1, tblnum , 1 do
		proxy:SetEventFlag( evetbl[ index ] , false );
		proxy:DeleteEvent( evetbl[ index ] );
	end
	
	--ステータス初期化
	god_state = 1;
	
	proxy:SetEventFlag( 2012, true );
	proxy:SetEventFlag( 2013, true );
	proxy:SetEventFlag( 2014, true );
	proxy:SetEventFlag( 2015, true );
	
	local is_stay_forged_god = false;
	if	god_rand > 0 then
		for index = 2, god_num, 1 do
			--まだ有効な状態の偽者が残っていたら
			if	proxy:IsCompleteEvent( God_IsValid_AcidTbl[index] ) == true then
				--同期フェードアウトアニメ再生
				proxy:LuaCallStartPlus( 2044, 9010, GodEvidTbl[index] );
				--一人でも分身が残っている場合は、そいつが消えるまで待ってやる
				proxy:RepeatMessage_begin();
				proxy:NotNetMessage_begin();
					--proxy:OnChrAnimEnd( 2019, GodEvidTbl[index], 9010, "OnEvent_2019", once );
					proxy:OnRegistFunc( God_EraseAnim_AcidTbl2[index], "PlayErase_Wait", "EraseAnimEnd_set", GodEvidTbl[index], once );
				proxy:NotNetMessage_end();
				proxy:RepeatMessage_end();
				is_stay_forged_god = true;
			else
				print("この偽神様は既に消えている： ",GodEvidTbl[index]," IsValidId:",God_IsValid_AcidTbl[index]);
			end
		end
	end
	
	if	is_stay_forged_god == false then
		god_rand = 0;
	end

	--ボス部屋に入るイベントも一旦消しておく
	proxy:DeleteEvent( 380 );
	proxy:DeleteEvent( 381 );
	proxy:SetEventFlag( 380, false );
	proxy:SetEventFlag( 381, false );
	
	--カミサマ使いが死んでいたら
	if proxy:IsCompleteEvent( 390 ) == true then
	
		--部屋を出るイベント削除
		proxy:DeleteEvent( 384 );
		
	--カミサマ使いが生きている
	else
	
		--■384■ボス部屋を出る■
		proxy:NotNetMessage_begin();
			proxy:OnPlayerActionInRegion( 384, 2896, "OnEvent_384", HELPID_GO_TO_OUT, everytime );
		proxy:NotNetMessage_end();
		
		proxy:SetEventFlag( 395, true );
		
		--ソロプレイ(生存・グレイ)もしくはホストの場合
		if	proxy:IsClient()	== false then
			
			proxy:NotNetMessage_begin();
			proxy:RepeatMessage_begin();
				--カミサマ復活用のフラグ監視
				proxy:OnRegistFunc( 2034, "NetRegionCondition", "NetRegionResult", 2, once );
			proxy:RepeatMessage_end();
			proxy:NotNetMessage_end();
		end
		
		--フラグを下ろして、出る為のアクションボタン判定を有効に
		proxy:SetEventFlag( 384, false );
	end
	
	print("GodDemonDead end");
end


--------------------------------------------------------------------------------------
--1997		■かみさまデーモン魔方陣配置開始
--------------------------------------------------------------------------------------
function OnEvent_1997(proxy,param)
	print("OnEvent_1997 begin");
	--UnRegistMagicSquare(proxy,param);
	--魔方陣削除同期
	proxy:LuaCallStart(2021,0);
	
	--設置処理はホストに任せる
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2(1997,"OnEvent_1997_1",2.8,0,0,once);	
	proxy:NotNetMessage_end();	
	print("OnEvent_1997 end");
end

--------------------------------------------------------------------------------------
--1998		■瞬間移動開始
--------------------------------------------------------------------------------------
function OnEvent_1998(proxy,param)
	print("OnEvent_1998 begin");
	if proxy:IsAlive(806) == false then
		print("GodDemon Is Dead");
		print("OnEvent_1998 end");
		return;
	end
	if	proxy:IsCompleteEvent( 1998 ) == true then
		print("GodDemon Is Flag return");
		return;
	end
	proxy:SetEventFlag( 1998, true );
	
	proxy:SetEventFlag( 2012, true );
	proxy:SetEventFlag( 2013, true );
	proxy:SetEventFlag( 2014, true );
	proxy:SetEventFlag( 2015, true );
	--proxy:OnKeyTime2(1998, "OnEvent_1998_flag_off", 20.0, 0, 2, once );--割り込みの設定時間で暴発しないように待ちを入れる
	
	local is_stay_forged_god = false;
	
	--本物を無効化
	--InvalidCharactor( proxy, GodEvidTbl[1] );
	proxy:LuaCallStartPlus( 2044, 2, 1 );
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();	
		--■2048■カミサマデーモン　ダメージ監視■
		proxy:OnSimpleDamage( 2048 , 806 , -1 , "OnEvent_2048",once);
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	if	god_rand > 0 then
		for	index = 2, god_num, 1 do
			--まだ割り込みで消えていないキャラなら
			if	proxy:IsCompleteEvent( God_Warp_AcidTbl[index] ) == false then
				--フェードアウトアニメ再生
				proxy:LuaCallStartPlus( 2044, 9010, GodEvidTbl[index] );
				--proxy:PlayAnimation( GodEvidTbl[index], 9010 );
				
				proxy:RepeatMessage_begin();
				proxy:NotNetMessage_begin();
					--proxy:OnChrAnimEnd( 2018, GodEvidTbl[index], 9010, "OnEvent_2018", once );
					print("OnEvent_1998 EraseAnimEnd_set evid = ",GodEvidTbl[index]);
					proxy:OnRegistFunc( God_EraseAnim_AcidTbl[index], "PlayErase_Wait", "EraseAnimEnd_set", GodEvidTbl[index], once );
				proxy:NotNetMessage_end();
				proxy:RepeatMessage_end();
				is_stay_forged_god = true;
			end
		end
	end
	
	if	is_stay_forged_god == false then
		print("OnEvent_1998 全員既に消えていたのでそのまま次の処理へ");
		OnEvent_2018( proxy, param );
	end
--[[
	local num = table.getn( Telepotbl );
	
	--１～テーブル末尾までのどれかのインデックス
	local rand = proxy:GetRandom(1,num);
	proxy:Warp(806,Telepotbl[ rand ] );
]]
	print("OnEvent_1998 end");
end

function OnEvent_1998_flag_off(proxy,param)
	print("OnEvent_1998_flag_off begin");
--[[
	proxy:SetEventFlag( 2011, false );
	proxy:SetEventFlag( 2012, false );
	proxy:SetEventFlag( 2013, false );
	proxy:SetEventFlag( 2014, false );
	proxy:SetEventFlag( 2015, false );
]]
	print("OnEvent_1998_flag_off end");
end

--[[
	魔方陣イベントの全削除	…☆UnRegistMagicSquare
	proxy	…イベントプロキシ
	param	…ネットエッセージパラメータ
]]
function UnRegistMagicSquare(proxy,param)
--	print("UnRegistMagicSquare begin");	
	local index = 1;
	local tblnum = table.getn( evetbl );
	for index = 1, tblnum , 1 do
		proxy:SetEventFlag( evetbl[ index ] , false );
		proxy:DeleteEvent( evetbl[ index ] );
	end	
--	print("UnRegistMagicSquare end");
end

--------------------------------------------------------------------------------------
--1997 	■魔方陣設置
--------------------------------------------------------------------------------------
function OnEvent_1997_1(proxy,param)
--	print("OnEvent_1997_1 begin");
	local rand = proxy:GetRandom(1,5);
	proxy:LuaCallStart(2020,rand);	
--	print("OnEvent_1997_1 end");
end



--[[
	魔方陣イベントの登録	…☆RegistMagicSquare
	proxy	…イベントプロキシ
	param	…ネットメッセージパラメータ
	eventid	…イベントID
	targetid…ターゲットID
	regionid…監視領域ID
]]
function RegistMagicSquare(proxy,param,eventid,targetid,regionid)
	--print("RegistMagicSquare begin");
	if targetid == 10000 then
	--	print("TargetPlayer");
		proxy:OnRegionJustIn(eventid,targetid,regionid,"RegionIn_Player_"..regionid,everytime);
	else
--		print("TargetEnemy ",targetid);
		proxy:OnRegionJustIn(eventid,targetid,regionid,"RegionIn_Enemy_"..regionid,everytime);
	end
--	print("RegistMagicSquare end");	
end

--[[
	魔方陣のみ発動		…☆MagicSquareSFX
	proxy	…イベントプロキシ
	param	…ネットメッセージパラメータ
	regionid…領域ID
]]
function MagicSquareSFX(proxy,param,regionid)
--	print("MagicSquareSFX ",regionid," begin");
	--SFX作成 
	--発生場所　ポイントID	：regionid
	--発生SFX	SFXID		：CHECK_MAGICSQUARE
	proxy:CreateSfx(regionid,CHECK_MAGICSQUARE);	
--	print("MagicSquareSFX ",regionid," end");
end

--[[
	魔方陣と魔法の発動 …☆BeginMagicSquare
	proxy	…イベントプロキシ
	param	…ネットメッセージパラメータ
	regionid…領域ID
]]
function BeginMagicSquare(proxy,param,regionid)
	--print("BeginMagicSquare ",regionid," begin");
	--オーナーID:806、発動ポイントID:2900、発動魔法ID:MAGIC_ID
	--発動角270,0,0
	proxy:CastPointSpellPlus(806,regionid,MAGIC_ID,270,0,0,0,1.5,0);
	--SFX作成 
	--発生場所　ポイントID	：regionid
	--発生SFX	SFXID		：BEGIN_MAGICSQUARE
	proxy:CreateSfx(regionid,BEGIN_MAGICSQUARE);	
	--print("BeginMagicSquare ",regionid," end");
end






--------------------------------------------------------------------------------------
--		■かみさまデーモン魔方陣配置開始 パターン01 全部
--------------------------------------------------------------------------------------
function Registpattern01(proxy,param)
--	print("◎Registpattern01 begin");
	
	--万が一カミサマが死んでいてここに処理がきた場合は魔方陣を設置しない
	if proxy:IsAlive(806) == false then
		--print("◎Registpattern01 end");
		return;
	end
	
	--イベント領域2900～2912まで	
	local listnam = table.getn( chrtbl );
	local regionnam = table.getn( pattern1 );	
	local index = 0;	
	for regionid = 1, regionnam , 1 do
		--print("CreateSfx :",regionid);
		proxy:CreateSfx(pattern1[ regionid ],SET_MAGICSQUARE);
		for index = 1, listnam , 1 do 
			RegistMagicSquare(proxy,param,evetbl[ index ],chrtbl[ index ], pattern1[ regionid ]);			
		end
	end
	--print("◎Registpattern01 end");
end


--------------------------------------------------------------------------------------
--		■かみさまデーモン魔方陣配置開始 パターン02 テーブル配置
--------------------------------------------------------------------------------------
function Registpattern02(proxy,param)
	--print("◎Registpattern02 begin");
	
	--万が一カミサマが死んでいてここに処理がきた場合は魔方陣を設置しない
	if proxy:IsAlive(806) == false then
		--print("◎Registpattern01 end");
		return;
	end
	
	local listnam = table.getn( chrtbl );
	local regionnam = table.getn( pattern2 );
	local index = 0;	
	for regionid = 1, regionnam , 1 do
	--	print("CreateSfx :",regionid);
		proxy:CreateSfx( pattern2[ regionid ] ,SET_MAGICSQUARE);
		for index = 1, listnam , 1 do 
			RegistMagicSquare(proxy,param,evetbl[ index ],chrtbl[ index ],pattern2[ regionid ]);			
		end
	end
--	print("◎Registpattern02 end");
end


--------------------------------------------------------------------------------------
--		■かみさまデーモン魔方陣配置開始 パターン03 テーブル配置
--------------------------------------------------------------------------------------
function Registpattern03(proxy,param)
	--print("◎Registpattern03 begin");
	
	--万が一カミサマが死んでいてここに処理がきた場合は魔方陣を設置しない
	if proxy:IsAlive(806) == false then
		--print("◎Registpattern01 end");
		return;
	end
	
	
	local listnam = table.getn( chrtbl );
	local regionnam = table.getn( pattern3 );
	local index = 0;	
	for regionid = 1, regionnam , 1 do
		--print("CreateSfx :",regionid);
		proxy:CreateSfx( pattern3[ regionid ] ,SET_MAGICSQUARE);
		for index = 1, listnam , 1 do 
			RegistMagicSquare(proxy,param,evetbl[ index ],chrtbl[ index ],pattern3[ regionid ]);			
		end
	end
	--print("◎Registpattern03 end");
end


--------------------------------------------------------------------------------------
--		■かみさまデーモン魔方陣配置開始 パターン04 テーブル配置
--------------------------------------------------------------------------------------
function Registpattern04(proxy,param)
	--print("◎Registpattern04 begin");
	
	--万が一カミサマが死んでいてここに処理がきた場合は魔方陣を設置しない
	if proxy:IsAlive(806) == false then
		--print("◎Registpattern01 end");
		return;
	end

	local listnam = table.getn( chrtbl );
	local regionnam = table.getn( pattern4 );
	local index = 0;	
	for regionid = 1, regionnam , 1 do
		--print("CreateSfx :",regionid);
		proxy:CreateSfx( pattern4[ regionid ] ,SET_MAGICSQUARE);
		for index = 1, listnam , 1 do 
			RegistMagicSquare(proxy,param,evetbl[ index ],chrtbl[ index ],pattern4[ regionid ]);			
		end
	end
	--print("◎Registpattern04 end");
end


--------------------------------------------------------------------------------------
--		■かみさまデーモン魔方陣配置開始 パターン05 テーブル配置
--------------------------------------------------------------------------------------
function Registpattern05(proxy,param)
	--print("◎Registpattern05 begin");
	
	--万が一カミサマが死んでいてここに処理がきた場合は魔方陣を設置しない
	if proxy:IsAlive(806) == false then
		--print("◎Registpattern01 end");
		return;
	end

	local listnam = table.getn( chrtbl );
	local regionnam = table.getn( pattern5 );
	local index = 0;	
	for regionid = 1, regionnam , 1 do
		--print("CreateSfx :",regionid);
		proxy:CreateSfx( pattern5[ regionid ] ,SET_MAGICSQUARE);
		for index = 1, listnam , 1 do 
			RegistMagicSquare(proxy,param,evetbl[ index ],chrtbl[ index ],pattern5[ regionid ]);			
		end
	end
	--print("◎Registpattern05 end");
end









--------------------------------------------------------------------------------------
--2900～2912	■プレイヤーが魔方陣に入った
--------------------------------------------------------------------------------------
function RegionIn_Player_2900(proxy,param)	BeginMagicSquare( proxy,param,2900); end
function RegionIn_Player_2901(proxy,param)	BeginMagicSquare( proxy,param,2901); end
function RegionIn_Player_2902(proxy,param)	BeginMagicSquare( proxy,param,2902); end
function RegionIn_Player_2903(proxy,param)	BeginMagicSquare( proxy,param,2903); end
function RegionIn_Player_2904(proxy,param)	BeginMagicSquare( proxy,param,2904); end
function RegionIn_Player_2905(proxy,param)	BeginMagicSquare( proxy,param,2905); end
function RegionIn_Player_2906(proxy,param)	BeginMagicSquare( proxy,param,2906); end
function RegionIn_Player_2907(proxy,param)	BeginMagicSquare( proxy,param,2907); end
function RegionIn_Player_2908(proxy,param)	BeginMagicSquare( proxy,param,2908); end
function RegionIn_Player_2909(proxy,param)	BeginMagicSquare( proxy,param,2909); end
function RegionIn_Player_2910(proxy,param)	BeginMagicSquare( proxy,param,2910); end
function RegionIn_Player_2911(proxy,param)	BeginMagicSquare( proxy,param,2911); end
function RegionIn_Player_2912(proxy,param)	BeginMagicSquare( proxy,param,2912); end


--------------------------------------------------------------------------------------
--2900～2912	■敵が魔方陣に入った
--------------------------------------------------------------------------------------
function RegionIn_Enemy_2900(proxy,param) MagicSquareSFX( proxy,param,2900); end
function RegionIn_Enemy_2901(proxy,param) MagicSquareSFX( proxy,param,2901); end
function RegionIn_Enemy_2902(proxy,param) MagicSquareSFX( proxy,param,2902); end
function RegionIn_Enemy_2903(proxy,param) MagicSquareSFX( proxy,param,2903); end
function RegionIn_Enemy_2904(proxy,param) MagicSquareSFX( proxy,param,2904); end
function RegionIn_Enemy_2905(proxy,param) MagicSquareSFX( proxy,param,2905); end
function RegionIn_Enemy_2906(proxy,param) MagicSquareSFX( proxy,param,2906); end
function RegionIn_Enemy_2907(proxy,param) MagicSquareSFX( proxy,param,2907); end
function RegionIn_Enemy_2908(proxy,param) MagicSquareSFX( proxy,param,2908); end
function RegionIn_Enemy_2909(proxy,param) MagicSquareSFX( proxy,param,2909); end
function RegionIn_Enemy_2910(proxy,param) MagicSquareSFX( proxy,param,2910); end
function RegionIn_Enemy_2911(proxy,param) MagicSquareSFX( proxy,param,2911); end
function RegionIn_Enemy_2912(proxy,param) MagicSquareSFX( proxy,param,2912); end










function OnEvent_384(proxy,param)
	if proxy:IsCompleteEvent( SYSTEM_ID_IGNORE ) == true then
		return;
	end

	--　→SynchroTurnへ
	proxy:LuaCallStartPlus( 2031, 2, 2892 );
	
	proxy:SetEventFlag( SYSTEM_ID_IGNORE, true );--多重発動防止用フラグON
	
	print("OnEvent_384 end");
end


function SynchroTurn(proxy,param)
	print("SynchroTurn begin");
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		if param:IsNetMessage() == true then
			proxy:TurnCharactor( 10001 + param:GetPlayID(), param:GetParam3() );
		else
			proxy:OnTurnCharactorEnd( 2031, 10000, param:GetParam3(), "SynchroTurn_end", once );
		end
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("SynchroTurn end");
end

function SynchroTurn_end(proxy,param)
	print("SynchroTurn_end begin");
	
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_WALK ) == true then
		return;
	end
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 2031, 10000, ANIMEID_WALK, "SynchroWalk_end", once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("SynchroTurn_end end");
end

function SynchroWalk_end(proxy,param)
	print("SynchroWalk_end begin");
	
	proxy:SetEventFlag( SYSTEM_ID_IGNORE, false );--多重発動防止用フラグOFF
	
	print("SynchroWalk_end end");
end


function NetRegionCondition(proxy,param)
	--まだ領域に入っているプレイヤがいるか？
	if proxy:IsCompleteEvent( 2030 ) == false then
		return true;
	end
	return false;
end

function NetRegionResult(proxy,param)
	print("NetRegionResult begin");
	
	proxy:NotNetMessage_begin();
	proxy:RepeatMessage_begin();
		--2.5秒後
		proxy:OnKeyTime2( 2034, "NetRegionResult_1", 2.5, 0, 2, once );
	proxy:RepeatMessage_end();
	proxy:NotNetMessage_end();

	-- →OnEvent_2045
	proxy:LuaCallStart( 2045, 2 );
	
	print("NetRegionResult end");
end

--LuaCallParam(2045,2)
function OnEvent_2045(proxy,param)
	print("OnEvent_2045 begin");
	local chrId = 806;
	--位置を再セット
	--proxy:WarpRestart( chrId, 2986 );
	
	if proxy:IsClient() == false then
		--proxy:SetAlive( chrId, 1.0 );
		--proxy:ChrResetRequest( chrId );
		--proxy:ChrResetAnimation( chrId );
		proxy:RequestGenerate(chrId);
	end
	
	
	proxy:Warp( chrId, 2986 );
	
	print("OnEvent_2045 end");
end




function NetRegionResult_1(proxy,param)
	print("NetRegionResult_1 begin");
	
	-- →SynchroSetFlag
	-- 全員のイベントフラグ(2040)を立てる
	proxy:LuaCallStartPlus( 2033, 2, 2040 );
	
	--会話用フラグの初期化
	-- →SynchroResetFlag
	proxy:LuaCallStartPlus( 2033, 3, 395 );
	proxy:LuaCallStartPlus( 2033, 3, 365 );
	proxy:LuaCallStartPlus( 2033, 3, 8548);
	--proxy:LuaCallStartPlus( 2033, 3, 367);
	--proxy:LuaCallStartPlus( 2033, 3, 368);
	--proxy:SetEventFlag( 395, false );


	-- →SynchroDeleteEvent
	-- 全員の外に出るイベントを削除
	proxy:LuaCallStartPlus( 2033, 4, 384 );
	
	proxy:SetEventFlag( 2012, false );
	proxy:SetEventFlag( 2013, false );
	proxy:SetEventFlag( 2014, false );
	proxy:SetEventFlag( 2015, false );
	
	
	--カミサマ使いが死んでいる時にカミサマが復活したなら、
	--ここでカミサマのソウル・QWC取得可能にしておく
	if	proxy:IsAlive( 500 ) == false then
		--→SynchroValidSoul
		proxy:LuaCallStartPlus( 2033, 5, 806);
	end

	--ボスフロアに入るための監視追加を全員に
	--→SynchroBossFloorIn
	proxy:LuaCallStart( 2033, 6 );

	print("NetRegionResult_1 end");
end





--LuaCall(2047,3)
function SynchroDeadCondition(proxy,param)
	print("SynchroDeadCondition beign");
	--死亡監視再登録
	proxy:NotNetMessage_begin();
	proxy:RepeatMessage_begin();
	if	proxy:IsClient() == false then
		--死亡監視はかみさま使いが生きている限り何度でも追加するのでRepeat
		--Repeatなので終了済みイベントにならない為、配信にするとAssartがでる為、非配信
		proxy:OnCharacterDead( 5123 , 806 , "OnEvent_5123" , once );
	end
	proxy:RepeatMessage_end();
	proxy:NotNetMessage_end();
	
	if	proxy:IsClient() == false then
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			SingleReset( proxy, 2022 );
			SingleReset( proxy, 2023 );
			SingleReset( proxy, 2024 );
			proxy:OnCharacterHP( 2022, 806, "OnEvent_2022", GodHpJudge_patternB, once );
			proxy:OnCharacterHP( 2023, 806, "OnEvent_2023", GodHpJudge_patternC, once );
			proxy:OnCharacterHP( 2024, 806, "OnEvent_2024", GodHpJudge_patternD, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
	end
	
	proxy:RepeatMessage_begin();
		proxy:OnRegionJustIn( 383 , 10000 , 2887 , "OnEvent_383" , once );
	proxy:RepeatMessage_end();
	print("SynchroDeadCondition end");
end



--LuaCall(2033,2,nEventID)
function SynchroSetFlag(proxy,param)
	proxy:SetEventFlag( param:GetParam3(), true );
end

--LuaCall(2033,3,nEventID)
function SynchroResetFlag(proxy,param)
	proxy:SetEventFlag( param:GetParam3(), false );
end

--LuaCall(2033,4,nEventID)
function SynchroDeleteEvent(proxy,param)
	proxy:DeleteEvent( param:GetParam3() );
end

--LuaCall(2033,5,nEventID)
function SynchroValidSoul(proxy,param)
	proxy:DisableCollection(param:GetParam3(), false );
end

function OnEvent_2011(proxy,param)
	print("OnEvent_2011 begin");
	print("OnEvent_2011 end");
end

function OnEvent_2012(proxy,param)
	print("OnEvent_2012 begin");
	--既に本体の割り込みイベントが来ていたら
	if	proxy:IsCompleteEvent(1998) == true then
		return;
	end
	if	proxy:IsCompleteEvent(2012) == true then
		return;
	end
	--同期InvalidCharactor
	proxy:LuaCallStartPlus(2044, 2, 2);
	proxy:SetEventFlag(2016, false);
	--InvalidCharactor( proxy, GodEvidTbl[2] );
	proxy:SetEventFlag( 2012, true );
	print("OnEvent_2012 end");
end

function OnEvent_2013(proxy,param)
	print("OnEvent_2013 begin");
	--既に本体の割り込みイベントが来ていたら
	if	proxy:IsCompleteEvent(1998) == true then
		return;
	end
	if	proxy:IsCompleteEvent(2013) == true then
		return;
	end
	
	--同期InvalidCharactor
	proxy:LuaCallStartPlus(2044, 2, 3);
	proxy:SetEventFlag(2017, false);
	--InvalidCharactor( proxy, GodEvidTbl[3] );
	proxy:SetEventFlag( 2013, true );
	print("OnEvent_2013 end");
end

function OnEvent_2014(proxy,param)
	print("OnEvent_2014 begin");
	--既に本体の割り込みイベントが来ていたら
	if	proxy:IsCompleteEvent(1998) == true then
		return;
	end
	if	proxy:IsCompleteEvent(2014) == true then
		return;
	end
	--同期InvalidCharactor
	proxy:LuaCallStartPlus(2044, 2, 4);
	proxy:SetEventFlag(2018, false);
	--InvalidCharactor( proxy, GodEvidTbl[4] );
	proxy:SetEventFlag( 2014, true );
	print("OnEvent_2014 end");
end

function OnEvent_2015(proxy,param)
	print("OnEvent_2015 begin");
	--既に本体の割り込みイベントが来ていたら
	if	proxy:IsCompleteEvent(1998) == true then
		return;
	end
	if	proxy:IsCompleteEvent(2015) == true then
		return;
	end
	
	--同期InvalidCharactor
	proxy:LuaCallStartPlus(2044, 2, 5);
	proxy:SetEventFlag(2019, false);
	--InvalidCharactor( proxy, GodEvidTbl[5] );
	proxy:SetEventFlag( 2015, true );
	print("OnEvent_2015 end");
end


--カミサマ本体が攻撃されてワープになり、
--偽カミサマをフェードアウトアニメ再生した後、無効化する
function OnEvent_2018(proxy,param)
	print("OnEvent_2018 end");
	now_condition_anim_end_chr = 0;
	local num = table.getn( GodWarpTblList[god_state][1] );
	print("num",num);
	print("chr_num",god_num);
	
	
	if	god_rand > 0 then
		--一旦、全員無効化
		for index = 2, god_num, 1 do
			if	proxy:IsCompleteEvent( God_Warp_AcidTbl[index] ) == false then
				--同期InvalidCharactor
				proxy:LuaCallStartPlus(2044, 2, index);
				proxy:SetEventFlag(God_IsValid_AcidTbl[index], false);
				--InvalidCharactor( proxy, GodEvidTbl[index] );
			end
			proxy:SetEventFlag( God_Warp_AcidTbl[index], false );
		end
	end
	
	--ワープ先テーブルの乱数を更新
	god_rand = proxy:GetRandom(1,num);
	
	for index = 1, god_num, 1 do
		--有効化する待ち時間の乱数
		local rand_wait = proxy:GetRandom(1, 10) / 10;
		print("acid = ",God_Warp_AcidTbl[index],"  rand_wait = ", rand_wait );
		
		proxy:NotNetMessage_begin();
			proxy:OnKeyTime2( God_Warp_AcidTbl[index], "GodValidWait", rand_wait, 0, index, once );
		proxy:NotNetMessage_end();
	end

	print("OnEvent_2018 end");
end

function PlayErase_Wait(proxy,param)	
	local chrId = param:GetParam2();
	proxy:PlayAnimation(chrId, 9600);
	if	proxy:IsEventAnim(chrId, 9600) == true then
		return true;
	end
	return false;
end

function EraseAnimEnd_set(proxy,param)
	print("EraseAnimEnd_set begin");
	print("EraseAnimEnd_set actId = ", param:GetParam1(), ", chrId = ", param:GetParam2());
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd(param:GetParam1(), param:GetParam2(), 9600, "EraseAnimEnd", once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	print("EraseAnimEnd_set end");
end

function EraseAnimEnd(proxy,param)
	print("EraseAnimEnd begin");
	
	proxy:SetEventFlag( param:GetParam1(), true );
	local actIdNum = table.getn( God_EraseAnim_AcidTbl);
	local index2 = param:GetParam2() - 810;--キャラのイベントIDからindexを無理やり求める
	proxy:LuaCallStartPlus(2044, 2, index2 );
	proxy:SetEventFlag(God_IsValid_AcidTbl[index2], false);
	
	--1つでも未成立のフラグがあれば
	for index = 2, actIdNum, 1 do
		--有効になっていて、まだ消えるアニメが終っていない奴がいたら終了
		if	proxy:IsCompleteEvent(God_IsValid_AcidTbl[index] ) == true then
			print("EraseAnimEnd Is Valid");
			if	proxy:IsCompleteEvent(God_EraseAnim_AcidTbl[index] ) == false then
				print("EraseAnimEnd return end");
				return;
			end
		end
	end
	
	--フラグを全消去しておく
	for index = 2, actIdNum, 1 do
		proxy:SetEventFlag( God_EraseAnim_AcidTbl[index], false );
	end

	--生きていれば
	if	proxy:IsAlive(806) == true then
		--OnEvent_2018(proxy,param);
	else
		OnEvent_2019(proxy,param);
	end
	
	print("EraseAnimEnd end");
end


--カミサマ本体死亡で偽カミサマをフェードアウトアニメ終了後、無効化する
function OnEvent_2019(proxy,param)
	print("OnEvent_2019 begin");
	if	god_rand > 0 then
		for index = 2, god_num, 1 do
			if	GodWarpTblList[god_state][index][god_rand] ~= -1 then
				if	proxy:IsCompleteEvent( God_Warp_AcidTbl[index] ) == false then
					--同期InvalidCharactor
					proxy:LuaCallStartPlus(2044, 2, index);
					proxy:SetEventFlag(God_IsValid_AcidTbl[index], false);
					--InvalidCharactor( proxy, GodEvidTbl[index] );
				end
			end
			--フラグにまとめてリセットをかける
			--proxy:SetEventFlag( God_Warp_AcidTbl[index], false );--こいつは部屋を出た時に移行
			proxy:SetEventFlag( God_EraseAnim_AcidTbl[index], false );
			proxy:SetEventFlag( God_IsValid_AcidTbl[index], false );
		end
	end
	god_rand = 0;
	print("OnEvent_2019 end");
end

--カミサマが消えたとき、乱数時間の待ちを挟んで有効化
function GodValidWait(proxy,param)
	print("GodValidWait begin");
	local index = param:GetParam3();
	print("index = ",index,"  god_rand = ", god_rand );
	if	GodWarpTblList[god_state][index][god_rand] ~= -1 then
		print("GodValidWait Success");
		--proxy:Warp( GodEvidTbl[index], GodWarpTblList[god_state][index][god_rand] );
		proxy:CustomLuaCallStartPlus(2010, GodEvidTbl[index], GodWarpTblList[god_state][index][god_rand] );
		print("GodValidWait Chr ",GodEvidTbl[index]," Warp to ",GodWarpTblList[god_state][index][god_rand]);
		--カミサマ同期有効化
		proxy:LuaCallStartPlus( 2044, 3, index );
		proxy:SetEventFlag(God_IsValid_AcidTbl[index], true);
		--ValidCharactor( proxy, GodEvidTbl[index] );
	end
	
	--EzState割り込み受付開始
	proxy:SetEventFlag( God_Warp_AcidTbl[index], false );
	
	--本体だったらここでEzState割り込み開始
	if	index == 1 then
		proxy:SetEventFlag( 1998, false );
	end
	
	print("GodValidWait end");
end

--■2044_9600■偽カミサマの消えるアニメ同期再生■
function GodSynchroAnime(proxy,param)	
	proxy:ForcePlayAnimation( param:GetParam3(), param:GetParam2() );
end

--■2044_2■偽カミサマの無効化同期■
function GodSynchroInvalid(proxy,param)
	local index = param:GetParam3();
	print("GodSynchroInvalid InvalidCharactor = ", GodEvidTbl[index]);
	InvalidCharactor( proxy, GodEvidTbl[index] );
end


--■2044_3■偽カミサマの有効化同期■
function GodSynchroValid(proxy,param)
	local index = param:GetParam3();
	print("GodSynchroValid ValidCharactor = ", GodEvidTbl[index]);
	ValidCharactor( proxy, GodEvidTbl[index] );
	if GodEvidTbl[index] ~= 806 then		
		proxy:ForcePlayAnimation( GodEvidTbl[index],9000);
	end	
end

function KamisamaSynchroWarp(proxy,param)
	print("KamisamaSynchroWarp beign");
	print("KamisamaSynchroWarp chr = ", param:GetParam2(), ", point = ", param:GetParam3());
	proxy:Warp(param:GetParam2(), param:GetParam3());
	print("KamisamaSynchroWarp end");
end


function SynchroBossFloorIn(proxy,param)
	print("SynchroBossFloorIn begin");
	proxy:RepeatMessage_begin();
		--▽同期アニメ再生用の開始ハンドラ(旋回→歩き)
		proxy:LuaCall( 381, 1, "OnEvent_381_1", everytime );
		--▽2回目以降にボス部屋に入るためのイベント配信用
		proxy:LuaCall( 381 , 5 , "OnEvent_380_GO_TO_IN" , everytime );
		--▽フラグセット(同期用)
		proxy:LuaCall( 381 , 6 , "OnEvent_380_flag_set" , everytime );
		
		--誰かがボス前扉をまだ通過していない
		if proxy:IsCompleteEvent( 380 ) == false then
		
			--(セッション中に)ボス前の魔法壁を最初に通れるのは生存の人だけ
			local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;
			
			proxy:NotNetMessage_begin();
				--▼380▼中に入るためのイベントを追加▼
				proxy:OnPlayerActionInRegionAttribute( 380, 2895, "OnEvent_380", HELPID_GO_TO_IN, possible_chr_type, everytime );
			proxy:NotNetMessage_end();
			
		else --グレイゴーストできたときようにいると思われる。
		
			proxy:NotNetMessage_begin();
				--▼381▼中に入るためのイベントを追加▼--ハンドラは上と同じ
				proxy:OnPlayerActionInRegion( 381, 2895, "OnEvent_380", HELPID_GO_TO_IN, everytime );
			proxy:NotNetMessage_end();
		end
	proxy:RepeatMessage_end();
	print("SynchroBossFloorIn end");
end

--■2022■HP割合でBパターンへ移行
function OnEvent_2022(proxy,param)
	print("OnEvent_2022 begin");
	if	god_state < 2 then
		god_state = 2;
	end
	proxy:SetEventFlag( 2022, true );
	print("OnEvent_2022 end");
end

--■2023■HP割合でCパターンへ移行
function OnEvent_2023(proxy,param)
	print("OnEvent_2023 begin");
	if	god_state < 3 then
		god_state = 3;
	end
	proxy:SetEventFlag( 2023, true );
	print("OnEvent_2023 end");
end

--■2024■HP割合でDパターンへ移行
function OnEvent_2024(proxy,param)
	print("OnEvent_2024 begin");
	if	god_state < 4 then
		god_state = 4;
	end
	proxy:SetEventFlag( 2024, true );
	print("OnEvent_2024 end");
end

--■2048■神さまがダメージを受けた監視■
function OnEvent_2048(proxy,param)
	print("OnEvent_2048 begin");
	for index = 2, god_num, 1 do
		--まだ有効な状態の偽者が残っていたら
		if	proxy:IsCompleteEvent( God_IsValid_AcidTbl[index] ) == true then
			--同期フェードアウトアニメ再生
			proxy:LuaCallStartPlus( 2044, 9600, GodEvidTbl[index] );
			print("☆☆☆☆☆☆☆☆",GodEvidTbl[index],"☆☆☆☆☆☆☆☆")
			--一人でも分身が残っている場合は、そいつが消えるまで待ってやる
			proxy:RepeatMessage_begin();
			proxy:NotNetMessage_begin();
				--proxy:OnChrAnimEnd( 2019, GodEvidTbl[index], 9010, "OnEvent_2019", once );
				proxy:OnRegistFunc( God_EraseAnim_AcidTbl[index], "PlayErase_Wait", "EraseAnimEnd_set", GodEvidTbl[index], once );
			proxy:NotNetMessage_end();
			proxy:RepeatMessage_end();
			--is_stay_forged_god = true;
		end
	end
	print("OnEvent_2048 end");
end

function OnEvent_365(proxy,param)
	print("OnEvent_365 begin");
	proxy:SetEventFlag( 365 , true ); 
	print("OnEvent_365 end");
end

function OnEvent_367_In(proxy,param)
	print("OnEvent_367_In begin");
	proxy:SetEventFlag( 367 , true );
	print("OnEvent_367_In end");
end

function OnEvent_367_Out(proxy,param)
	print("OnEvent_367_Out begin");
	proxy:SetEventFlag( 367 , false );
	print("OnEvent_367_Out end");
end

function OnEvent_368_In(proxy,param)
	print("OnEvent_368_In begin");
	proxy:SetEventFlag( 368 , true );
	print("OnEvent_368_In end");
end

function OnEvent_368_Out(proxy,param)
	print("OnEvent_368_Out begin");
	proxy:SetEventFlag( 368 , false );
	print("OnEvent_368_Out end");
end
