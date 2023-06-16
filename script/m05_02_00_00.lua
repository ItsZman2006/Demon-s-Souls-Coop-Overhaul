
--血沼効果の発生周期パラメータ
BloodCycle_low		= 1.00;	--血沼効果の周期(最長)
BloodCycle_High		= 1.01;	--血沼効果の周期(最短)

IsInBloodArea		= false;--血沼に入っているか？



--------------------------------------------------------------------------------------
--マップ読み込み時に読まれる初期化処理■
--------------------------------------------------------------------------------------
function Initialize_m05_02_00_00(proxy)
	print("Initialize_m05_02_00_00 begin");
-----------------------------------------------------------------------------------------
--ボス関連
-----------------------------------------------------------------------------------------
--■5888■エリアボス死亡■
	proxy:AddFieldInsFilter( 824 );
	if proxy:IsCompleteEvent( 5888 ) ==false then
		proxy:OnCharacterDead(5888, 824, "OnEvent_5888", once);
	else
		proxy:SetEventFlag( 7299 , 1 ); --石柱のアクションIDをON
	end

--■5889■中ボス死亡監視■
	if proxy:IsCompleteEvent( 5889 ) == false then
		--会話からの呼び出しではなくなった
		--proxy:LuaCall(5889, 0, "OnEvent_5889", once);
		proxy:OnCharacterDead(5889, 824, "OnEvent_5889", once);
	end

--■1031■ボス部屋に入る■
	
	--中ボスが生きているときだけイベント登録
	if proxy:IsCompleteEvent( 5889 ) == false then
	
		--ソロのときは一度目にボス部屋に入る用のイベントを毎回登録させたいので、対応するフラグをOFFにする。
		SingleReset(proxy, 1031);
	
		--▽同期アニメ再生用の開始ハンドラ(旋回→歩き)
		proxy:LuaCall( 1032, 1, "OnEvent_1032_1", everytime );
		
		--▽2回目以降にボス部屋に入るためのイベント配信用
		proxy:LuaCall( 1032 , 5 , "OnEvent_1031_GO_TO_IN" , everytime );
		
		--▽フラグセット(同期用)
		proxy:LuaCall( 1032 , 6 , "OnEvent_1031_flag_set" , everytime );
		
		--誰かがボス前扉をまだ通過していない
		if proxy:IsCompleteEvent( 1031 ) == false then
		
			--(セッション中に)ボス前の魔法壁を最初に通れるのは生存の人だけ
			local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;
			
			proxy:NotNetMessage_begin();
				--▼1031▼扉が開いているときに中に入るためのイベントを追加▼
				proxy:OnPlayerActionInRegionAttribute( 1031, 2893, "OnEvent_1031", HELPID_GO_TO_IN, possible_chr_type, everytime );
			proxy:NotNetMessage_end();
		
		else --グレイゴーストできたときようにいると思われる。
		
			proxy:NotNetMessage_begin();
				--▼1032▼扉が開いているときに中に入るためのイベントを追加▼
				proxy:OnPlayerActionInRegion( 1032, 2893, "OnEvent_1031", HELPID_GO_TO_IN, everytime );--ハンドラは上と同じ
			proxy:NotNetMessage_end();
		
		end

	end

	
--■1033■ボス戦闘開始■	
	if proxy:IsCompleteEvent( 5889 ) == false then
		proxy:OnRegionJustIn( 1033 , 10000 , 2885 , "OnEvent_1033" , once );
	end	

--■1030■エリアボスポリ劇再生■
	if proxy:IsCompleteEvent( 1030 ) == false then
	
		proxy:OnRegionJustIn( 1030 , 10000 , 2897 , "OnEvent_1030" , once );
	
		--ポリ劇開始フェード後に呼ばれるハンドラ
		proxy:LuaCall(1030,REMO_START,"OnEvent_1030_RemoStart",once);
		--ポリ劇終了後に呼ばれるハンドラ
		proxy:LuaCall(1030,REMO_FINISH,"OnEvent_1030_RemoFinish",once);

	end

--■ボス関連の初期化処理
	if proxy:IsCompleteEvent( 5889 ) ==true then
		--▽ボス死んでいるとき
		
		--ボスいなくなる
		InvalidBackRead( proxy , 824 );
		
		--魔法壁消える
		proxy:SetColiEnable( 1997 , false );
		proxy:SetDrawEnable( 1997 , false );
		--魔法壁のSFX OFF
		proxy:InvalidSfx( 1989 , false );

		--ホストプレイヤーのみアイテム入手イベントに使用
		local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;
		
		--宝死体(ソウル?)有効化
		proxy:SetDrawEnable( 1980 , true );
		proxy:SetColiEnable( 1980 , true );
		proxy:TreasureDispModeChange2( 1980 , true ,KANAME_SFX);--光らせる
		--ソウルに刺さった剣有効化
		proxy:SetDrawEnable( 1977 , true );
		proxy:SetColiEnable( 1977 , true );
		--proxy:TreasureDispModeChange2( 1977 , true ,KANAME_SFX);--光らせる
		
		--▼(ソウル)アイテム取得用イベント監視追加▼
		if proxy:IsCompleteEvent( 5893 ) == false then
			--SFX有効化
			proxy:ValidSfx( 2401 );--要石のオーラ
			proxy:ValidSfx( 2402 );--光の粒子
			
			proxy:OnDistanceActionAttribute( 5893 , 10000 , 1980 , "OnEvent_5893" , WarpGimmickDist_A , 10010180 , 0 , 180 , possible_chr_type, once );
		else
			--SFXが消える
			proxy:InvalidSfx( 2401 , false );--要石のオーラ
			--proxy:InvalidSfx( 2402 , false );--光の粒子
			--▼要石でワープ用の監視を追加▼
			SingleReset(proxy,5895);
			proxy:OnDistanceActionAttribute( 5895 , 10000 , 1980 , "OnEvent_5895" , WarpGimmickDist_A , HELPID_GO_TO_SEKITYUU , 0 , 180 , ATTR_NOSESSION , everytime );
		end
		--------------------------------------
	else
		--▽ボスが生きている
		proxy:EnableLogic( 824 , false );--ロジックOFFで待機
		
		--宝死体(ソウル?)
		proxy:SetDrawEnable( 1980 , false );
		proxy:SetColiEnable( 1980 , false );
		--ソウルに刺さった剣無効化
		proxy:SetDrawEnable( 1977 , false );
		proxy:SetColiEnable( 1977 , false );		
		
		--SFXが消える
		proxy:InvalidSfx( 2401 , false );--要石のオーラ
		proxy:InvalidSfx( 2402 , false );--光の粒子
		
		--光の壁Sfxを有効化
		proxy:ValidSfx( 1989 );
	end
	
-----------------------------------------------------------------------------------------
--ギミック関連
-----------------------------------------------------------------------------------------
--■1040■はしご１　降りる■
	--▼PCがイベントエリア(2410)の中に居て、反応角度(LadderAngle_A)でアクションボタンを押したとき▼--
	proxy:OnActionEventRegion( 1040, 2410, "OnEvent_1040", LadderAngle_A, HELPID_DOWN, everytime );
--■1041■はしご１　昇る■
	--▼PCがイベントエリア(2411)の中に居て、反応角度(LadderAngle_A)でアクションボタンを押したとき▼--
	proxy:OnActionEventRegion( 1041, 2411, "OnEvent_1041", LadderAngle_A, HELPID_UP, everytime );
	
	
--■1042■はしご２　降りる■
	--▼PCがイベントエリア(2412)の中に居て、反応角度(LadderAngle_A)でアクションボタンを押したとき▼--
	proxy:OnActionEventRegion( 1042, 2412, "OnEvent_1042", LadderAngle_A, HELPID_DOWN, everytime );
--■1043■はしご２　昇る■
	--▼PCがイベントエリア(2413)の中に居て、反応角度(LadderAngle_A)でアクションボタンを押したとき▼--
	proxy:OnActionEventRegion( 1043, 2413, "OnEvent_1043", LadderAngle_A, HELPID_UP, everytime );


	
--[[発動条件不明のためコメントアウト

--■1050■エリアボスが浄化されるポリ劇再生■
	if proxy:IsCompleteEvent( 1050 ) == false then
	
	--	proxy:OnRegionJustIn( 1050 , 10000 , 2000 , "OnEvent_1050" , once );
	
		--ポリ劇開始フェード後に呼ばれるハンドラ
		proxy:LuaCall(1050,REMO_START,"OnEvent_1050_RemoStart",once);
		--ポリ劇終了後に呼ばれるハンドラ
		proxy:LuaCall(1050,REMO_FINISH,"OnEvent_1050_RemoFinish",once);

	end
]]


--■??■徘徊デーモンの登場■ハンドラ登録
	proxy:NotNetMessage_begin();
		--プレイヤーがソロで死亡した時にキックされます。
		proxy:LuaCall( 4000, 100, "PlayerDeath_m05_02_00_00", everytime );
		--プレイヤーが復活した時にキックされます。
		proxy:LuaCall( 4032, 100, "PlayerRevive_m05_02_00_00", everytime );
	proxy:NotNetMessage_end();

	--落下死体領域監視追加
	if proxy:IsCompleteEvent( 1060 ) == false then
		proxy:OnRegionJustIn( 1060, 10000, 2450, "OnEvent_1060", once );
		proxy:ChangeModel( 1440, 1 );
	else
		proxy:SetColiEnable( 1440, false );
		proxy:SetDrawEnable( 1440, false );
	end
	
	if proxy:IsCompleteEvent( 1080 ) == false then
		proxy:OnRegionJustIn( 1080, 10000, 2451, "OnEvent_1080", once );
		proxy:ChangeModel( 1450, 1 );
	else
		proxy:SetColiEnable( 1450, false );
		proxy:SetDrawEnable( 1450, false );
	end
	
	if proxy:IsCompleteEvent( 1081 ) == false then
		proxy:OnRegionJustIn( 1081, 10000, 2451, "OnEvent_1081", once );
		proxy:ChangeModel( 1451, 1 );
	else
		proxy:SetColiEnable( 1451, false );
		proxy:SetDrawEnable( 1451, false );
	end
	
	if proxy:IsCompleteEvent( 1082 ) == false then
		proxy:OnRegionJustIn( 1082, 10000, 2452, "OnEvent_1082", once );
		proxy:ChangeModel( 1452, 1 );
	else
		proxy:SetColiEnable( 1452, false );
		proxy:SetDrawEnable( 1452, false );
	end
	
	if proxy:IsCompleteEvent( 1083 ) == false then
		proxy:OnRegionJustIn( 1083, 10000, 2452, "OnEvent_1083", once );
		proxy:ChangeModel( 1453, 1 );
	else
		proxy:SetColiEnable( 1453, false );
		proxy:SetDrawEnable( 1453, false );
	end
	
	--■1090■毒沼
	proxy:SetEventFlag( 1090, false );
	proxy:NotNetMessage_begin();
		proxy:OnRegistFunc( 1090, "Condition_1090", "dummy", 2, once );
	proxy:NotNetMessage_end();

	proxy:LuaCall( 1069, 2, "OnEvent_1061_1069_call", everytime );


	--ジェネレータOn
	if proxy:IsCompleteEvent( 5889 ) == false then
		proxy:EnableGeneratorSystem(2420,true);
		proxy:EnableGeneratorSystem(2421,true);
		proxy:EnableGeneratorSystem(2422,true);
		proxy:EnableGeneratorSystem(2423,true);
		proxy:EnableGeneratorSystem(2424,true);
		proxy:EnableGeneratorSystem(2425,true);
		proxy:EnableGeneratorSystem(2426,true);
		proxy:EnableGeneratorSystem(2427,true);
		proxy:EnableGeneratorSystem(2428,true);
		proxy:EnableGeneratorSystem(2429,true);
		proxy:EnableGeneratorSystem(2430,true);
		proxy:EnableGeneratorSystem(2431,true);
	end
	
--■1120～1129■リーブラの子供達のターゲット強制変更■
	RegistLibraJr_Target(proxy);
	
	
--■8087■不浄へ来たフラグを立てる■
	proxy:SetEventFlag( 8087, true );

-----------------------------------------------------------------------------------------
--NPC関連
-----------------------------------------------------------------------------------------
	----------------------------------------------------------------------
	--リーブラ関連
	----------------------------------------------------------------------
	--m05_02_00_00_eventboss.luaに記載
	----------------------------------------------------------------------
	--ガル・ゴールドラン関連
	----------------------------------------------------------------------
	--m05_02_00_00_eventboss.lua記載

--~ --■15500■乱入アイテム取得監視■ハンドラはグローバルに定義
--~ 	if proxy:IsCompleteEvent( 15500 ) == false then
--~ 		proxy:AddCorpseEvent( 15500 , 460 );--ガルゴールドラン
--~ 	end

-----------------------------------------------------------------------------------------	
--■999999■フレーム遅れの初期化処理イベントを発行■
-----------------------------------------------------------------------------------------
	proxy:NotNetMessage_begin();
		--▼0秒後▼--
		proxy:OnKeyTime2( 999995, "Second_Initialize_m05_02_00_00", 0.0, 0, 0, once );	
	proxy:NotNetMessage_end();	
	
	print("Initialize_m05_02_00_00 end");
end


--------------------------------------------------------------------------------------
--Initializeから呼ばれる、1フレーム遅れの初期化処理■999999
--------------------------------------------------------------------------------------
--■999999■一部、Initでは処理できないので、残しておく
function Second_Initialize_m05_02_00_00(proxy, param)
	print("Second_Initialize_m05_02_00_00 begin");

--------------------------------▽▽▽QWCイベント関連▽▽▽--------------------------------
--------------------------------△△△QWCイベント関連△△△--------------------------------

	print("Second_Initialize_m05_02_00_00 end");
end





function OnEvent_1060(proxy,param)
	print("OnEvent_1060 begin");
	--■1061～1069■落下死体2～10
	if proxy:IsLivePlayer() == true or proxy:IsGreyGhost() == true then
		local IsAdd = false;
		for index = 1, 9, 1 do
			local evid = 1061 + index - 1;
			if proxy:IsCompleteEvent(evid) == false then
				proxy:ChangeModel( 1441 + index - 1, 1 );
				if IsAdd == false then
					local wait = proxy:GetRandom( M52_Corpse_FallWait_Low * 1000, M52_Corpse_FallWait_High * 1000 ) / 1000;
					proxy:OnKeyTime2( evid, "OnEvent_1061_1069", wait, 0, index, once );
					IsAdd = true;
				end
			else
				proxy:SetColiEnable( 1441 + index - 1, false );
				proxy:SetDrawEnable( 1441 + index - 1, false );
			end
		end
	end
	
	proxy:ChangeModel( 1440, 0 );
	proxy:SetEventFlag( param:GetParam1(), true );
	print("OnEvent_1060 end");
end

function OnEvent_1061_1069(proxy,param)
	print("OnEvent_1061_1069 begin");

	proxy:LuaCallStartPlus( 1069, 2, param:GetParam3() );
	
	--最後まで実行されたら
	if param:GetParam1() == 1069 then
		return;
	end
	
	local wait = proxy:GetRandom(M52_Corpse_FallWait_Low * 1000, M52_Corpse_FallWait_High * 1000 ) / 1000;
	proxy:OnKeyTime2( param:GetParam1() + 1, "OnEvent_1061_1069", wait, 0, param:GetParam3() + 1, once );
	
	print("OnEvent_1061_1069 end");
end

function OnEvent_1061_1069_call(proxy,param)
	print("OnEvent_1061_1069_call begin");
	
	--オブジェをハボックに戻して落下させる
	proxy:ChangeModel( 1441 + param:GetParam3() - 1, 0 );
	
	--オブジェをハボックに戻す
	proxy:SetEventFlag( 1061 + param:GetParam3() - 1, true );
	
	print("OnEvent_1061_1069_call end");
end



function OnEvent_1080(proxy,param)
	print("OnEvent_1080 begin");
	proxy:ChangeModel( 1440, 0 );
	proxy:SetEventFlag( param:GetParam1(), true );
	print("OnEvent_1080 end");
end
function OnEvent_1081(proxy,param)
	print("OnEvent_1081 begin");
	proxy:ChangeModel( 1441, 0 );
	proxy:SetEventFlag( param:GetParam1(), true );
	print("OnEvent_1081 end");
end
function OnEvent_1082(proxy,param)
	print("OnEvent_1082 begin");
	proxy:ChangeModel( 1442, 0 );
	proxy:SetEventFlag( param:GetParam1(), true );
	print("OnEvent_1082 end");
end
function OnEvent_1083(proxy,param)
	print("OnEvent_1083 begin");
	proxy:ChangeModel( 1443, 0 );
	proxy:SetEventFlag( param:GetParam1(), true );
	print("OnEvent_1083 end");
end



--------------------------------------------------------------------------------------
--■5888■エリアボス死亡■
--------------------------------------------------------------------------------------
--■5888■エリアボス死亡■
function OnEvent_5888(proxy, param)
	print("OnEvent_5888 begin");

	proxy:SetEventFlag( 5888, 1 );
	
	proxy:SetEventFlag( 7299, 1 );--石柱のアクションフラグON
	
	print("OnEvent_5888 end");
end


--------------------------------------------------------------------------------------
--徘徊デーモンの登場■??
--------------------------------------------------------------------------------------

--▼グローバルの死亡監視から呼ばれる(ソロ)
function PlayerDeath_m05_02_00_00(proxy, param)
	print("PlayerDeath_m05_02_00_00");
	
--	LuaFunc_VisibleTheWanderingDemon(proxy, param, demon_id_list_m05_02_00_00);
--	proxy:SetEventFlag( 20 , 1 );--フラグは仮、指定があれば変える。
	
	print("PlayerDeath_m05_02_00_00");
end

--▼グローバルの血文字復活から呼ばれる(ソロ)
function PlayerRevive_m05_02_00_00(proxy,param)
	print("PlayerRevive_m05_02_00_00");
	
--	LuaFunc_InvisibleTheWanderingDemon(proxy, param, demon_id_list_m05_02_00_00);
--	proxy:SetEventFlag( 20 , 0 );--フラグは仮、指定があれば変える。
	
	print("PlayerRevive_m05_02_00_00");
end
--------------------------------------------------------------------------------------
--■1030■エリアボスポリ劇再生■
--------------------------------------------------------------------------------------

function OnEvent_1030(proxy , param)
	print("OnEvent_1030 begin");

	--▼エリアボスポリ劇再生
	proxy:RequestRemo(50200,REMO_FLAG,1030,1);
	proxy:SetEventFlag( 1030, true );
	
	print("OnEvent_1030 end");
end


--■ポリ劇再生開始(フェード終了)
function OnEvent_1030_RemoStart(proxy,param)
	print("OnEvent_1030_RemoStart begin");
	print("OnEvent_1030_RemoStart end");
end


--■ポリ劇再生終了(フェード終了)
function OnEvent_1030_RemoFinish(proxy , param)
	print("OnEvent_1030_RemoFinish begin");
	print("OnEvent_1030_RemoFinish end");
end




--------------------------------------------------------------------------------------
--■1050■エリアボスが浄化されるポリ劇再生■
--------------------------------------------------------------------------------------

function OnEvent_1050(proxy , param)
	print("OnEvent_1050 begin");

	--▼エリアボスが浄化されるポリ劇再生
	proxy:RequestRemo(50201,REMO_FLAG,1050,1);
	proxy:SetEventFlag( 1050, true );
	
	print("OnEvent_1050 end");
end


--■ポリ劇再生開始(フェード終了)
function OnEvent_1050_RemoStart(proxy,param)
	print("OnEvent_1050_RemoStart begin");	
	print("OnEvent_1050_RemoStart end");
end


--■ポリ劇再生終了(フェード終了)
function OnEvent_1050_RemoFinish(proxy , param)
	print("OnEvent_1050_RemoFinish begin");
	print("OnEvent_1050_RemoFinish end");
end

--------------------------------------------------------------------------------------
--ボス部屋の中に入る■1031
--------------------------------------------------------------------------------------

--■イベントがループなので、全部リピートにする↓

--■1031■中ボス部屋への扉が開く■
function OnEvent_1031(proxy,param)
	print("OnEvent_1031 begin");
	
	if proxy:IsCompleteEvent( SYSTEM_ID_IGNORE ) == true then
		print("OnEvent_1031 end");
		return;
	end
	
	--クライアントへ、ボス部屋阻止失敗を通知
	if proxy:IsClient() == false then
		proxy:LuaCallStart( 4068 , 1 );	
	end
	
	proxy:LuaCallStart( 1032, 1 );--旋回アニメの同期再生
	--proxy:SetEventFlag( SYSTEM_ID_IGNORE, true );
	--多重起動システムIDをタイムアウトを設定してONにする
	proxy:SetSystemIgnore( SYSTEM_ID_IGNORE , IGNORE_TIME );
	
	--プロファイルセーブ要求
	proxy:SaveRequest_Profile();
	
	print("OnEvent_1031 end");
end


--旋回アニメの同期再生(IDが別)
function OnEvent_1032_1(proxy,param)
	print("OnEvent_1032_1 begin");

	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		if param:IsNetMessage() == true then
			--旋回アニメ再生を行い、その終了時にOnEvent_1032_2を発行する
			proxy:TurnCharactor( 10001 + param:GetPlayID(), 2889 );
		else
			proxy:LockSession();--ルームをロックします！
			--旋回アニメ再生を行い、その終了時にOnEvent_1032_2を発行する
			proxy:OnTurnCharactorEnd( 1032, 10000, 2889, "OnEvent_1032_2", once );
		end
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_1032_1 end");
end

--旋回アニメの同期再生終了後
function OnEvent_1032_2(proxy,param)
	print("OnEvent_1032_2 begin");

	--同期用歩きアニメ再生
	proxy:LuaCallStart( 4012, 1 );
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 1032, 10000, ANIMEID_WALK, "OnEvent_1032_3", once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_1032_2 end");
end

--歩きアニメの同期再生終了後
function OnEvent_1032_3(proxy,param)
	print("OnEvent_1032_3 begin");

	--最初の人がボス部屋の中に入り終わっていたら、既に配信されているはずなので、もうおくらないハンドラ
	if proxy:IsCompleteEvent( 1031 ) == false then
		proxy:LuaCallStart( 1032 , 5 );--2回目以降にボス部屋に入るためのイベント配信用
		proxy:LuaCallStart( 4045 , 1 );	--クライアントへ、ボス部屋に入れるようになったことを通知
		proxy:LuaCallStart( 1032 , 6 );--フラグセット(同期用)
		local eneidlist = {	824,651,530,531,532,533,534,535,536,537,538,
							545,546,551,552,558,559,563,564,565,572,573,
							574,575,576,581,582,583,584,585,586,587,588,
							589,590,591,592,593,594,595,596,597,598,599};
		local num = table.getn(eneidlist);
		for index = 1, num , 1 do
			Lua_MultiDoping(proxy,eneidlist[index] );--マルチプレイドーピング
		end
	end

	--プレイヤーが扉の中に完全にはいったタイミングで、ボスの思考をリセット
	--場所が悪いとプレイヤーを見つけれないため(攻撃してこない)
	if proxy:IsLivePlayer() == true or proxy:IsGreyGhost() == true then
		proxy:ResetThink( 824 );
	end	
	
	proxy:SetEventFlag( SYSTEM_ID_IGNORE, false );

	print("OnEvent_1032_3 end");
end


--■1031 2回目以降にボス部屋に入るためのイベント配信用
function OnEvent_1031_GO_TO_IN(proxy, param)
	print("OnEvent_1031_GO_TO_IN begin");

	proxy:NotNetMessage_begin();
		--▼1032▼扉が開いているときに中に入るためのイベントを追加▼--ハンドラは OnEvent_1031
		proxy:OnPlayerActionInRegion( 1032, 2893, "OnEvent_1031", HELPID_GO_TO_IN, everytime );--
	proxy:NotNetMessage_end();	

	print("OnEvent_1031_GO_TO_IN end");
end


--■1031 フラグセット(同期用)
function OnEvent_1031_flag_set(proxy, param)
	print("OnEvent_1031_flag_set begin");
		
	proxy:SetEventFlag( 1031 , 1 );
	proxy:DeleteEvent( 1031 );

	print("OnEvent_1031_flag_set end");
end



--------------------------------------------------------------------------------------
--ボスが動き出す(戦闘開始)■1033
--------------------------------------------------------------------------------------

function OnEvent_1033(proxy, param)
	print("OnEvent_1033 begin");
	
	--ボス戦用BGM再生開始
	proxy:PlayPointSE( 2400, SOUND_TYPE_M, 50200000, 2 );
	
	proxy:EnableLogic( 824, true );
	
	--読み込みタイミングのとき毎回追加されてほしいのでフラグたてない
	
	--ボスゲージ表示
	proxy:SetBossGauge(824, 0, 6040);
	
	LuaFunc_ForceOmission(proxy,460);
	LuaFunc_ForceOmission(proxy,651);
	LuaFunc_ForceOmission(proxy,824);
	print("OnEvent_1033 end");
end

--------------------------------------------------------------------------------------
--■5889■中ボス死亡時■
--------------------------------------------------------------------------------------
--■5889■中ボス死亡時■
function OnEvent_5889(proxy, param)
	print("OnEvent_5889 begin");

	--リーブラの子供ジェネレータOFF
	proxy:EnableGeneratorSystem(2420,false);
	proxy:EnableGeneratorSystem(2421,false);
	proxy:EnableGeneratorSystem(2422,false);
	proxy:EnableGeneratorSystem(2423,false);
	proxy:EnableGeneratorSystem(2424,false);
	proxy:EnableGeneratorSystem(2425,false);
	proxy:EnableGeneratorSystem(2426,false);
	proxy:EnableGeneratorSystem(2427,false);
	proxy:EnableGeneratorSystem(2428,false);
	proxy:EnableGeneratorSystem(2429,false);
	proxy:EnableGeneratorSystem(2430,false);
	proxy:EnableGeneratorSystem(2431,false);
	--ジェネレータ関連のフラグ(必要ないけど、立てないとバグ報告されちゃうので)
	proxy:SetEventFlag( 1050, true );
	proxy:SetEventFlag( 1051, true );
	
	proxy:NotNetMessage_begin();
		--▼5889_1▼1秒経過▼
		proxy:OnKeyTime2( 5889, "OnEvent_5889_1", 1, 0, 0, once);
		--▼5892▼2秒経過▼
		proxy:OnKeyTime2( 5892, "OnEvent_5892", 2.0, 0, 2, once);
		--マルチ解散監視
		proxy:OnRegistFunc( 5889 , "Check_5889_PT","OnEvent_5889_PT",0,once);
	proxy:NotNetMessage_end();
	
	proxy:SetEventFlag( 5889, 1 );
	
	--ガルの状態を見て処理
	if proxy:IsCompleteEvent( GAL_STATE_LIVE ) == true then
		--やる気を無くす
		proxy:ResetThink( 651 );
		proxy:EnableLogic( 651 , false );
		--proxy:SetSpStayAndDamageAnimId( 651,8821,-1);
		proxy:SetEventCommand( 651 , 900 );
		--再度敵対
		proxy:NotNetMessage_begin();
			proxy:OnSimpleDamage( 1117 , 651 , 10000 , "OnEvent_1117",once);
		proxy:NotNetMessage_end();
	end	
	
	--新ブロッククリア処理へ
	proxy:CustomLuaCallStart( 4050, 824);
	--トカゲリセット
	ResetTokage(proxy);
	
	--[[
	--王城3開放インフォメーション
	if proxy:IsClient() == false then
		if proxy:IsCompleteEvent( 8050 ) == false then
			proxy:NotNetMessage_begin();
				proxy:OnKeyTime2( 8050 , "OnEvent_8050",5.0,0,0,once);
				proxy:SetEventFlag( 8050 , true );
			proxy:NotNetMessage_end();
		end
	end
	]]
	
	--ホスト自キャラ　or　シングル
	if proxy:IsLivePlayer() == true or proxy:IsGreyGhost() == true then	
		proxy:SetEventFlag(	8013, 1 );--クリアフラグON
	end
	
	print("OnEvent_5889 end");
end

--▲5889_1▲中ボス死亡後1秒▲
function OnEvent_5889_1(proxy, param)
	print("OnEvent_5889_1 begin");
	
	--ボスを倒した数を更新(数によってフラグを立てる)
	GetBossFlagCount( proxy, param );
	
	--▼トロフィー取得判定▼
	Lua_RequestUnlockTrophy(proxy, 9);--トロフィの状況を判定し、取得
	
--アイテム入手関連-------
	
	--ホストプレイヤーのみアイテム入手イベントに使用
	local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;

	--宝死体(ソウル?)有効化
	proxy:SetDrawEnable( 1980 , true );
	proxy:SetColiEnable( 1980 , true );
	--ソウルに刺さった剣有効化
	proxy:SetDrawEnable( 1977 , true );
	proxy:SetColiEnable( 1977 , true );
	
	--▼(ソウル)アイテム取得用イベント監視追加▼
	if proxy:IsCompleteEvent( 5893 ) == false then
		--SFX有効化
		proxy:ValidSfx( 2401 );--要石のオーラ
		proxy:ValidSfx( 2402 );--光の粒子
		--ソウルと刺さっている剣を輝かせる
		proxy:TreasureDispModeChange2( 1980 , true ,KANAME_SFX);--光らせる
		--proxy:TreasureDispModeChange2( 1977 , true ,KANAME_SFX);--光らせる
		proxy:OnDistanceActionAttribute( 5893 , 10000 , 1980 , "OnEvent_5893" , WarpGimmickDist_A , 10010180 , 0 , 180 , possible_chr_type, once );
	end

	--中ボス部屋前の移動処理イベントを削除
	proxy:DeleteEvent( 1031 );--一人目が入るとき用
	proxy:DeleteEvent( 1032 );--二人目以降が入るとき用
	proxy:DeleteEvent( 1033 );--ボス戦闘開始用
		
	print("OnEvent_5889_1 end");
end

--▼5892▼2秒経過▼--------------
function OnEvent_5892(proxy,param)
	print("OnEvent_5892 begin");
	
	--ボス戦用のBGM停止
	proxy:StopPointSE( 2 );
	
	proxy:SetEventFlag( 5892, true );
	print("OnEvent_5892 end");
end

--マルチ解散監視
function Check_5889_PT(proxy)
	if proxy:IsInParty() == false then
		return true;
	end
	return false;
end

--マルチじゃない
function OnEvent_5889_PT(proxy,param)
	print("OnEvent_5889_PT begin");
	--中ボス部屋の前後の魔法壁が消える(全プレイヤー)
	proxy:SetColiEnable( 1997 , false );
	proxy:SetDrawEnable( 1997 , false );
	
	--中ボス部屋魔法壁のSFX削除
	proxy:InvalidSfx( 1989 , true );
	print("OnEvent_5889_PT end");
end


--王城３解放の表示
function OnEvent_8050(proxy,param)
	print("OnEvent_8050 begin");
	--インフォ表示
	--システムメッセージ
	--[[
	proxy:InfomationMenu( INFOMENU_TYPE_LIST, -1, 0, -1, 1 );
	proxy:AddInfomationBuffer( 10010750 );	
	]]
	proxy:RequestOpenBriefingMsgPlus(10010750,true);
	proxy:PlayTypeSE( 10000 ,SOUND_TYPE_M ,777777777 );
	print("OnEvent_8050 end");
end


--------------------------------------------------------------------------------------
--■5893■ソウルアイテム入手■
--------------------------------------------------------------------------------------
function OnEvent_5893(proxy,param)
	print("OnEvent_5893 begin");
	
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_PICK ) == true then--新しいアニメ 
		print("OnEvent_5893 end");
		return true;
	end
	
	proxy:NotNetMessage_begin();
		--0.0秒後にアイテム取得イベントを発行
		proxy:OnKeyTime2( 5893, "OnEvent_5893_1", 0.0, 0, 0, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_5893 end");
end

--■5893_1■アイテム取得■
function OnEvent_5893_1(proxy, param)
	print("OnEvent_5893_1 begin");

	--アイテム取得関数
	proxy:GetRateItem(10452);--パラメータ10452参照
	proxy:GetRateItem(10478);--パラメータ10478参照
	proxy:GetRateItem(10479);--パラメータ10479参照
	proxy:GetRateItem(10480);--パラメータ10480参照
	proxy:GetRateItem(10481);--パラメータ10481参照
	
	--アイテムを取得済み
	proxy:SetEventFlag( 5893, 1 );
	
	--宝シェーダーOFF
	--proxy:TreasureDispModeChange( 1980 , false );--光らせるのをやめる
	
	--SFXが消える
	proxy:InvalidSfx( 2401 , true );--要石のオーラ
	--proxy:InvalidSfx( 2402 , true );--光の粒子	
	
	if proxy:IsCompleteEvent( 8035 ) == false then
		proxy:NotNetMessage_begin();
			--瞬間で表示するとメニューが先に出るので待つ
			proxy:OnKeyTime2( 8035 , "OnEvent_8035_wait",0.5 , 0 , 1, once);			
		proxy:NotNetMessage_end();
	else
		--▼要石でワープ用の監視を追加▼
		proxy:OnDistanceActionAttribute( 5895 , 10000 , 1980 , "OnEvent_5895" , WarpGimmickDist_A , HELPID_GO_TO_SEKITYUU , 0 , 180 , ATTR_NOSESSION , everytime );
	end	
	print("OnEvent_5893_1 end");
end

--[[
	
]]
--アイテム取得後のウェイト
function OnEvent_8035_wait(proxy,param)
	print("OnEvent_8035_wait begin");
	proxy:NotNetMessage_begin();
		--インフォメニューが消えるのを待ちたい
		proxy:OnRegistFunc( 8035 , "Check_8035" , "OnEvent_8035" , 1 , ocne);
	proxy:NotNetMessage_end();
	print("OnEvent_8035_wait end");
end	
--インフォ待ち
function Check_8035(proxy)
	if proxy:IsShowMenu_InfoMenu() == true then
		return false;
	end
	return true;
end

--開放インフォ表示
function OnEvent_8035(proxy,param)
	print("OnEvent_8035 begin");
	proxy:NotNetMessage_begin();		
		OnEvent_8050(proxy,param);
		proxy:SetEventFlag( 8035 , true );
	proxy:NotNetMessage_end();
	--▼要石でワープ用の監視を追加▼	
	proxy:OnDistanceActionAttribute( 5895 , 10000 , 1980 , "OnEvent_5895" , WarpGimmickDist_A , HELPID_GO_TO_SEKITYUU , 0 , 180 , ATTR_NOSESSION , everytime );
	print("OnEvent_8035 end");
end



--------------------------------------------------------------------------------------
--石柱にワープ■5895
--------------------------------------------------------------------------------------
--■5895石柱にワープ■
function OnEvent_5895(proxy,param)
	print("OnEvent_5895 begin");
	
	if proxy:IsCompleteEvent( 5895 ) == true then
		return;
	end
	
	proxy:RepeatMessage_begin();
		--▼5895_1▼選択メニューの監視▼
		proxy:OnSelectMenu(5895, "OnEvent_5895_0", 10010710, 0, 2, 1980, 2, once);
	proxy:RepeatMessage_end();
	
	print("OnEvent_5895 end");
end

--▲5895_0▲選択メニューの監視▲
function OnEvent_5895_0(proxy,param)	
	print("OnEvent_5895_0 begin");
	
	if proxy:IsSession() == false then
		
		proxy:PlayAnimation(10000,8283);
		proxy:NoAnimeTurnCharactor( 10000 , 1980 ,TURNSKIP_ANGLE);
		
		proxy:NotNetMessage_begin();
			proxy:OnChrAnimEnd(5895, 10000, 8283, "OnEvent_5895_1", once );
		proxy:NotNetMessage_end();
		
		proxy:SetEventFlag(5895,true);
	else
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010720, 0, 6, 1983, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
	end
	
	print("OnEvent_5895_0 end");
end

--▲5895_1▲選択メニューの監視▲
function OnEvent_5895_1(proxy,param)	
	print("OnEvent_5895_1 begin");
	
	proxy:SetEventFlag(5895,false);
	
	proxy:PlayAnimation( 10000, 8284 );

	proxy:SetEventFlag(5895,true);
	
	OnEvent_5895_2(proxy, param);
	
	print("OnEvent_5895_1 end");
end

--▲5895_2▲選択メニューの監視▲
function OnEvent_5895_2(proxy,param)
	print("OnEvent_5895_2 begin");
	
	--石柱へ戻ってきた判定のフラグを立てる
	proxy:SetEventFlag(8083, true);
	
	proxy:SetEventFlag(5895,false);
	--完全回復要求
	proxy:RequestFullRecover();
	proxy:WarpNextStage( 1, 0, 0, 0, 1009 );
	
	print("OnEvent_5895_2 end");
end





--------------------------------------------------------------------------------------
--ハシゴ
--------------------------------------------------------------------------------------
function OnEvent_1040(proxy,param)
	print("OnEvent_1040 begin");
	if param:IsNetMessage() == true then
		print("IsNetMessage true");
		print("OnEvent_1040 end");
		return;
	end

	--はしご降りに必要な前処理--
	proxy:BeginAction(10000,2,2,2);				--ホバー移動モードに移行
	proxy:HoverMoveValDmy(10000,1430,192,LadderTime_A);--移動位置(192)に0.5秒でホバー移動
	proxy:SetEventCommand(10000,1);				--イベントコマンドID(1)"ハシゴ上から掴"むを送る
	proxy:SetKeepCommandIndex(10000, 0, 1, 3.0 );
	proxy:DisableMove(10000, true);					--キャラクタを移動、旋回不能に
	
	proxy:NotNetMessage_begin();
		--0.5秒(ホバー移動終了)後にはしご降りスタートイベントを発行
		proxy:OnKeyTime2(1040,"OnEvent_1040_1",LadderTime_A,0,0,once);
		--はしご降り専用の関数を3秒間発行(カメラの周り込みなどの処理)
		proxy:OnKeyTime2(1040,"LadderDown",3.0,1,1,once);
	proxy:NotNetMessage_end();
	
	print("OnEvent_1040 end");
end

function OnEvent_1040_1(proxy,param)
	print("OnEvent_1040_1 begin");
	if proxy:GetEventMode(10000) == 0 then
		print("Local Player GetEventMode 0");
		print("OnEvent_1040_1 end");
		return;
	end

	--ハシゴアクションモードに移行--
	--nMax  : はしごの段数 - 補正値(補正値はおおよそ3)
	--nStart: 降りるとき→(nMax + 1) 昇るとき→(-1)
	--nMax   = 段数(14) - 補正値(3) = 11
	--nStart = nMax(11) + 降りるとき(1) = 12
	proxy:BeginAction(10000,1,7,6);
	
	--キャラクタを移動、旋回可能に--
	proxy:DisableMove(10000,0);
	
	print("OnEvent_1040_1 end");
end

function OnEvent_1041(proxy,param)
	print("OnEvent_1041 begin");
	if param:IsNetMessage() == true then
		print("IsNetMessage true");
		print("OnEvent_543 end");
		return;
	end

	--はしご降りに必要な前処理--
	proxy:BeginAction(10000,2,-1,1);			--ホバー移動モードに移行
	proxy:HoverMoveValDmy(10000,1430,191,LadderTime_A);--移動位置(191)に0.5秒でホバー移動
	proxy:SetEventCommand(10000,0);				--イベントコマンドID(0)"ハシゴ下から掴"むを送る
	proxy:SetKeepCommandIndex(10000, 0, 1, 3.0 );
	proxy:DisableMove(10000,1);					--キャラクタを移動、旋回不能に
	
	proxy:NotNetMessage_begin();
		--0.5秒(ホバー移動終了)後にはしご降りスタートイベントを発行
		proxy:OnKeyTime2(1041,"OnEvent_1041_1",LadderTime_A,0,0,once);
		--はしご降り専用の関数を3秒間発行(カメラの周り込みなどの処理)
		proxy:OnKeyTime2(1041,"LadderDown",3.0,1,1,once);
	proxy:NotNetMessage_end();
	print("OnEvent_1041 end");
end

function OnEvent_1041_1(proxy,param)
	print("OnEvent_1041_1 begin");
	if proxy:GetEventMode(10000) == 0 then
		print("Local Player GetEventMode 0");
		print("OnEvent_1041_1 end");
		return;
	end

	--ハシゴアクションモードに移行--
	--nMax  : はしごの段数 - 補正値(補正値はおおよそ3)
	--nStart: 降りるとき→(nMax + 1) 昇るとき→(-1)
	--nMax   = 段数(14) - 補正値(3) = 11
	--nStart = 昇るとき(-1) = -1
	proxy:BeginAction(10000,1,-1,6);
	
	--キャラクタを移動、旋回可能に--
	proxy:DisableMove(10000,0);
	
	print("OnEvent_1041_1 end");
end




function OnEvent_1042(proxy,param)
	print("OnEvent_1042 begin");
	if param:IsNetMessage() == true then
		print("IsNetMessage true");
		print("OnEvent_1042 end");
		return;
	end

	--はしご降りに必要な前処理--
	proxy:BeginAction(10000,2,2,2);				--ホバー移動モードに移行
	proxy:HoverMoveValDmy(10000,1431,192,LadderTime_A);--移動位置(192)に0.5秒でホバー移動
	proxy:SetEventCommand(10000,1);				--イベントコマンドID(1)"ハシゴ上から掴"むを送る
	proxy:SetKeepCommandIndex(10000, 0, 1, 3.0 );
	proxy:DisableMove(10000, true);					--キャラクタを移動、旋回不能に
	
	proxy:NotNetMessage_begin();
		--0.5秒(ホバー移動終了)後にはしご降りスタートイベントを発行
		proxy:OnKeyTime2(1042,"OnEvent_1042_1",LadderTime_A,0,0,once);
		--はしご降り専用の関数を3秒間発行(カメラの周り込みなどの処理)
		proxy:OnKeyTime2(1042,"LadderDown",3.0,1,1,once);
	proxy:NotNetMessage_end();
	
	print("OnEvent_1042 end");
end

function OnEvent_1042_1(proxy,param)
	print("OnEvent_1042_1 begin");
	if proxy:GetEventMode(10000) == 0 then
		print("Local Player GetEventMode 0");
		print("OnEvent_1042_1 end");
		return;
	end

	--ハシゴアクションモードに移行--
	--nMax  : はしごの段数 - 補正値(補正値はおおよそ3)
	--nStart: 降りるとき→(nMax + 1) 昇るとき→(-1)
	--nMax   = 段数(14) - 補正値(3) = 11
	--nStart = nMax(11) + 降りるとき(1) = 12
	proxy:BeginAction(10000,1,11,10);
	
	--キャラクタを移動、旋回可能に--
	proxy:DisableMove(10000,0);
	
	print("OnEvent_1042_1 end");
end

function OnEvent_1043(proxy,param)
	print("OnEvent_1043 begin");
	if param:IsNetMessage() == true then
		print("IsNetMessage true");
		print("OnEvent_1043 end");
		return;
	end

	--はしご降りに必要な前処理--
	proxy:BeginAction(10000,2,-1,1);			--ホバー移動モードに移行
	proxy:HoverMoveValDmy(10000,1431,191,LadderTime_A);--移動位置(191)に0.5秒でホバー移動
	proxy:SetEventCommand(10000,0);				--イベントコマンドID(0)"ハシゴ下から掴"むを送る
	proxy:SetKeepCommandIndex(10000, 0, 1, 3.0 );
	proxy:DisableMove(10000,1);					--キャラクタを移動、旋回不能に
	
	proxy:NotNetMessage_begin();
		--0.5秒(ホバー移動終了)後にはしご降りスタートイベントを発行
		proxy:OnKeyTime2(1043,"OnEvent_1043_1",LadderTime_A,0,0,once);
		--はしご降り専用の関数を3秒間発行(カメラの周り込みなどの処理)
		proxy:OnKeyTime2(1043,"LadderDown",3.0,1,1,once);
	proxy:NotNetMessage_end();
	print("OnEvent_1043 end");
end

function OnEvent_1043_1(proxy,param)
	print("OnEvent_1043_1 begin");
	if proxy:GetEventMode(10000) == 0 then
		print("Local Player GetEventMode 0");
		print("OnEvent_1043_1 end");
		return;
	end

	--ハシゴアクションモードに移行--
	--nMax  : はしごの段数 - 補正値(補正値はおおよそ3)
	--nStart: 降りるとき→(nMax + 1) 昇るとき→(-1)
	--nMax   = 段数(14) - 補正値(3) = 11
	--nStart = 昇るとき(-1) = -1
	proxy:BeginAction(10000,1,-1,10);
	
	--キャラクタを移動、旋回可能に--
	proxy:DisableMove(10000,0);
	
	print("OnEvent_1043_1 end");
end


--------------------------------------------------------------------------------------
--■1090■毒沼■
--------------------------------------------------------------------------------------
--■1090■毒沼■
function Condition_1090(proxy,param)
	--床ダメージ用ポイントの各イベントID
	--2460,2461,2462
	local floorTbl = {2460,2461,2462};
	local tblnum = table.getn( floorTbl );
	IsInBloodArea = false;--とりあえず入ってない事に
	local ACID = 1090;
	
	
	for index = 1, tblnum, 1 do
		if proxy:IsRegionIn( 10000, floorTbl[index] ) == true then
			IsInBloodArea = true;
		end
	end
	
	
	--入った瞬間
	if proxy:IsCompleteEvent( ACID ) == false and
		IsInBloodArea == true then
		print("PoizonFloorDam JustIn", tblnum);
		proxy:SetEventSpecialEffect(10000, 10090);
		proxy:SetEventFlag( ACID, IsInBloodArea );
		proxy:NotNetMessage_begin();
			proxy:OnKeyTime2( 1091, "OnEvent_1091", 0.0, 0, 1, once );
		proxy:NotNetMessage_end();
	end
	
	--抜け出た瞬間
	if  proxy:IsCompleteEvent( ACID ) == true and
		IsInBloodArea == false then
		print("PoizonFloorDam JustOut", tblnum);
		proxy:EraseEventSpecialEffect(10000, 10090);
		proxy:SetEventFlag( ACID, IsInBloodArea );
		proxy:DeleteEvent(1091);
	end

	
	--絶対に結果を成立させないよ
	return false;
end

function dummy(proxy,param)
end

function OnEvent_1091(proxy,param)
	print("OnEvent_1091 begin");
	local set_param = proxy:DivideRest( param:GetParam3() + 1, 2 );
	local reload = Lua_GetReloadTime(proxy,BloodCycle_low,BloodCycle_High);
	
	--継続的に入っている時のみ次の効果を設定できる
	if IsInBloodArea == true then
		proxy:NotNetMessage_begin();
			proxy:OnKeyTime2( 1091, "OnEvent_1091", reload, 0, set_param, once );
		proxy:NotNetMessage_end();
	else
		--念の為重い歩き解除
		proxy:EraseEventSpecialEffect(10000, 10090);
	end
	
	proxy:SetEventSpecialEffect(10000, 10290);
	print("OnEvent_1091 end");
end



--■1120■リーブラの子供達のターゲット強制変更■
--誰が誰を狙っていたかを再現すると大変なことになるので、
--それぞれの世界でざっくりイベントを発動させることにします。(横山さんと相談済み)
function RegistLibraJr_Target(proxy)
	local evid_list = {  360,  361,  362,  363,  372,  373,  374,  375,  377,  391};
	local event_num = table.getn(evid_list);
	for index = 1, event_num, 1 do
		local evid = evid_list[index];
		proxy:NotNetMessage_begin();
			proxy:OnRegionJustIn( 1120, evid, 2470, "OnEvent_1120", once );
		proxy:NotNetMessage_end();
		
		--腐敗人にリーブラを狙わせる
		proxy:SetEventTarget( evid_list[index], 824 );
	end
end



LibraJr_HideDistance		= 12.0;
function OnEvent_1120(proxy,param) 
	print("OnEvent_1120 begin");
	local evid = param:GetParam2();
	for JrId = 530, 599, 1 do
		if	proxy:IsDistance( JrId, evid, LibraJr_HideDistance ) == true then
			print( JrId.." Target to "..evid );
			proxy:ForceChangeTarget( JrId, evid);
		end
	end
	print("OnEvent_1120 end");
end




