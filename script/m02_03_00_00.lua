
--飛竜の長の攻撃待ち時間(0に設定すると0で割ったあまりを取る処理がおかしくなって数値が壊れるので、必ず0.01以上をtopに入れてやってください。)
HiryuOsa_AttackDelay_under	= 0.00;--飛竜の長の攻撃の待ち時間の下限
HiryuOsa_AttackDelay_top	= 0.01;--飛竜の長の攻撃の待ち時間の上限

HiryuOsa_b4_evid			= 501;--王城4の飛竜の長のイベントID

ElevatorTimer = 10.0;
--------------------------------------------------------------------------------------
--マップ読み込み時に読まれる初期化処理■
--------------------------------------------------------------------------------------
function Initialize_m02_03_00_00(proxy)
	print("Initialize_m02_03_00_00 begin");
	
--■1560■飛竜の長、出現■
	if proxy:IsCompleteEvent( 1560 ) == false then
		proxy:OnRegionJustIn( 1560 , LOCAL_PLAYER , 2600 , "OnEvent_1560" , everytime );
		
		proxy:NotNetMessage_begin();
			--ポリ劇開始フェード後に呼ばれるハンドラ
			proxy:LuaCall(1560,REMO_START,"OnEvent_1560_RemoStart",once);
			--ポリ劇終了後に呼ばれるハンドラ
			proxy:LuaCall(1560,REMO_FINISH,"OnEvent_1560_RemoFinish",once);
			proxy:Warp(  HiryuOsa_b4_evid , 2700 );
		proxy:NotNetMessage_end();
	else
		--演出用(?)のOBJを有効化/無効化する
		proxy:SetDrawEnable( 1720 , true );
		proxy:SetColiEnable( 1720 , true );		
		proxy:SetDrawEnable( 1721 , true );
		proxy:SetColiEnable( 1721 , true );		
		proxy:SetDrawEnable( 1710 , false );
		proxy:SetColiEnable( 1710 , false );		
		proxy:SetDrawEnable( 1711 , false );
		proxy:SetColiEnable( 1711 , false );		
		proxy:SetDrawEnable( 1700 , false );
		proxy:SetColiEnable( 1700 , false );		
		proxy:SetDrawEnable( 1701 , false );
		proxy:SetColiEnable( 1701 , false );
	end


--■1570■ボス部屋に入る■			
	--BossRoomIn( proxy, 4480, 1570, 1571, 2892 );--[[グローバルのがコメントアウトされていた]]

	--中ボスが生きているときだけイベント登録
	if proxy:IsCompleteEvent( 4480 ) == false then
	
		--ソロのときは一度目にボス部屋に入る用のイベントを毎回登録させたいので、対応するフラグをOFFにする。
		SingleReset(proxy, 1570);		
	
		--▽同期アニメ再生用の開始ハンドラ(旋回→歩き)
		proxy:LuaCall( 1571, 1, "OnEvent_1571_1", everytime );
		--▽2回目以降にボス部屋に入るためのイベント配信用
		proxy:LuaCall( 1571 , 5 , "OnEvent_1570_GO_TO_IN" , everytime );
		--▽フラグセット(同期用)
		proxy:LuaCall( 1571 , 6 , "OnEvent_1570_flag_set" , everytime );
		
		--誰かがボス前扉をまだ通過していない
		if proxy:IsCompleteEvent( 1570 ) == false then
		
			--(セッション中に)ボス前の魔法壁を最初に通れるのは生存の人だけ
			local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;
			
			proxy:NotNetMessage_begin();
				--▼1570▼扉が開いているときに中に入るためのイベントを追加▼
				proxy:OnPlayerActionInRegionAttribute( 1570, 2892, "OnEvent_1570", HELPID_GO_TO_IN, possible_chr_type, everytime );
			proxy:NotNetMessage_end();
		
		else --グレイゴーストできたときようにいると思われる。
		
			proxy:NotNetMessage_begin();
				--▼1571▼扉が開いているときに中に入るためのイベントを追加▼
				proxy:OnPlayerActionInRegion( 1571, 2892, "OnEvent_1570", HELPID_GO_TO_IN, everytime );--ハンドラは上と同じ
			proxy:NotNetMessage_end();
		
		end
	end
	

--■1540■ボスのポリ劇再生■

	if proxy:IsCompleteEvent( 1540 ) == false and proxy:IsCompleteEvent( 1545 ) == false then 
	
		--▼ボス前のポリ劇再生用監視追加
		proxy:OnRegionJustIn( 1540 , LOCAL_PLAYER , 2896 , "OnEvent_1540" , once );
		
		proxy:NotNetMessage_begin();
--[[
		--■飛竜の長が生きていた場合■
			--ポリ劇開始に呼ばれるハンドラ
			proxy:LuaCall(1540, REMO_START, "OnEvent_1540_RemoStart", once);
			--ポリ劇終了後に呼ばれるハンドラ(トリガー起こした人用)
			proxy:LuaCall(1540, REMO_FINISH, "OnEvent_1540_RemoFinish", once);
]]

		--■飛竜の長が死んでいた場合■
			--ポリ劇開始に呼ばれるハンドラ
			proxy:LuaCall(1545, REMO_START, "OnEvent_1545_RemoStart", once);
			--ポリ劇終了後に呼ばれるハンドラ(トリガー起こした人用)
			proxy:LuaCall(1545, REMO_FINISH, "OnEvent_1545_RemoFinish", once);
		proxy:NotNetMessage_end();
	else
		proxy:SetEventFlag( 4490 , true );
	end


--■1572■ボスが動きだす■	
	if proxy:IsCompleteEvent( 4480 ) == false then
		proxy:OnRegionJustIn( 1572 , LOCAL_PLAYER , 2884 , "OnEvent_1572" , everytime );
	end
	

--■4480■ボス死亡■	
	proxy:AddFieldInsFilter( 821 );
	if proxy:IsCompleteEvent( 4480 ) ==false then
		proxy:NotNetMessage_begin();
			proxy:OnCharacterDead(4480, 821, "OnEvent_4480", once);
		proxy:NotNetMessage_end();
	end

------------- ▼飛竜系▼ -----------------------------------------------

--■1620■領域監視■
	proxy:OnNetRegion(1620 , 2610);	
--■1621■領域監視■
	proxy:OnNetRegion(1621 , 2620);	
--■1622■領域監視■
	proxy:OnNetRegion(1622 , 2630);	
--■1623■領域監視■
	proxy:OnNetRegion(1623 , 2640);
--■1624■領域監視■
	proxy:OnNetRegion(1624 , 2641);
--■1625■領域監視■
	proxy:OnNetRegion(1625 , 2642);
--■1626■領域監視■
	proxy:OnNetRegion(1626 , 2643);
--■1651■領域監視■
	proxy:OnNetRegion(1651 , 2710);
	
--■1590■飛竜の長が警戒している■
	--Second_Initializeで追加(状態フラグをセットした後)
	
--■1591■飛竜の長が領域Aをブレス攻撃をする■
--■1592■飛竜の長が領域Bをブレス攻撃をする■
--■1593■飛竜の長が領域Cをブレス攻撃をする■
--■1594■飛竜の長が広場に対してブレス攻撃をする■
--■1599■飛竜の長がゲート前で警戒している■


--■1597■飛竜の長がゲート前に飛んでいく■
--■1598■飛竜の長が通路前に飛んでいく■

--■1600■飛竜の長が王の間に飛んでいく（通路前から）■
--■1601■飛竜の長が王の間に飛んでいく（ゲート前から）■
--■1602■飛竜の長が王の間を警戒している■
--■1603■飛竜の長が王の間にブレス攻撃をする■
--■1604■飛竜の長が、王の間から撤退する■
	
	if	proxy:IsCompleteEvent( TYO_STATE_DEAD ) == false then
	--■1670■飛竜の長のHpが75％以下■
		SingleReset( proxy, 1670 );
		if	proxy:IsCompleteEvent( 1670 ) == false then
			proxy:OnCharacterHP( 1670, HiryuOsa_b4_evid, "OnEvent_1670", 0.75, once );
		end
		
	--■1671■飛竜の長のHpが50％以下■
		SingleReset( proxy, 1671 );
		if	proxy:IsCompleteEvent( 1671 ) == false then
			proxy:OnCharacterHP( 1671, HiryuOsa_b4_evid, "OnEvent_1671", 0.50, once );
		end
			
		--▼飛竜アニメの同期再生用▼
		proxy:LuaCall( 1590 , 1 , "OnEvent_1590"   				, everytime );--アニメ管理
		proxy:LuaCall( 1590 , 2 , "OnEvent_1590_syncroInvalid"	, everytime );--同期無効化
		
		proxy:LuaCall( 1590 , 3 , "OnEvent_1590_3"				, everytime );--通路待機
		
		proxy:LuaCall( 1590 ,10 , "Osa_ForceSynchroAnime" 			, everytime );--同期アニメ用
		
		proxy:LuaCall( 1591 , 1 , "OnEvent_1591_1"				, everytime );--ブレスA
		proxy:LuaCall( 1591 , 2 , "OnEvent_1591_2"				, everytime );--ブレスA
		proxy:LuaCall( 1592 , 1 , "OnEvent_1592_1"				, everytime );--ブレスB
		proxy:LuaCall( 1592 , 2 , "OnEvent_1592_2"				, everytime );--ブレスB
		proxy:LuaCall( 1593 , 1 , "OnEvent_1593_1"				, everytime );--ブレスC
		proxy:LuaCall( 1593 , 2 , "OnEvent_1593_2"				, everytime );--ブレスC
		
		proxy:LuaCall( 1594 , 1 , "OnEvent_1594_1"				, everytime );--広場ブレスA
		proxy:LuaCall( 1594 , 2 , "OnEvent_1594_2"				, everytime );--広場ブレスA
		proxy:LuaCall( 1660 , 1 , "OnEvent_1660_1"				, everytime );--広場ブレスB
		proxy:LuaCall( 1660 , 2 , "OnEvent_1660_2"				, everytime );--広場ブレスB
		proxy:LuaCall( 1661 , 1 , "OnEvent_1661_1"				, everytime );--広場ブレスC
		proxy:LuaCall( 1661 , 2 , "OnEvent_1661_2"				, everytime );--広場ブレスC
		
		proxy:LuaCall( 1662 , 1 , "OnEvent_1662_1"				, everytime );--広場待機
		
		proxy:LuaCall( 1596 , 1 , "OnEvent_1596_1"				, everytime );--ゲート死亡
		proxy:LuaCall( 1597 , 1 , "OnEvent_1597_1"				, everytime );--ゲートへ移動
		proxy:LuaCall( 1598 , 1 , "OnEvent_1598_1"				, everytime );--通路へ移動
		
		proxy:LuaCall( 1595 , 1 , "OnEvent_1595_1"				, everytime );--通路で死亡
	end
	
	
	

----------- ▲飛竜系▲ ---------------------------------------------------------


--■1635■エレベータが昇る■
--■1636■エレベータが降りる■
--(Second_Initializeで監視追加)



--■4500■クライアントPCワープ演出■
	--(ボス死亡:OnEvent_4480 から連動)

--■4502■シングル：光の壁、BGM消去■
	--(ボス死亡:OnEvent_4480 から連動)

--■4503■ソウル入手■
	--(ボス死亡:OnEvent_4480 から連動)

--■4504■ボスアイテム入手処理■
	--(ボス死亡:OnEvent_4480 から連動)

--■4505■石柱にワープ■
	--(ソウル入手:OnEvent_4503 から連動)



--■??■徘徊デーモンの登場■ハンドラ登録
	proxy:NotNetMessage_begin();
		--プレイヤーがソロで死亡した時にキックされます。
		proxy:LuaCall( 4000, 100, "PlayerDeath_m02_03_00_00", everytime );
		--プレイヤーが復活した時にキックされます。
		proxy:LuaCall( 4032, 100, "PlayerRevive_m02_03_00_00", everytime );
	proxy:NotNetMessage_end();
	


--■1635,1636■エレベータ関連初期化■
--エレベータギミック：アクションID内訳
--1630		エレベータの上下状態管理(false:下	true:上)
--1631		エレベータのアニメ中判定用
--1635		エレベータの発動領域監視
--1636		エレベータが上にあるときに誰もエレベータ内にいなくなった時、下に降ろす判定用
	proxy:SetIsAnimPauseOnRemoPlayForEvent(1620,true);
	proxy:OnNetRegion( 1636, 2651 );
	--ホストの場合は必ず初期状態を下に(もし、ボス戦で敗れて上にあるままだと進行不能な為)
	if	proxy:IsClient() == false then
		proxy:SetEventFlag( 1630, false );
		proxy:SetEventFlag( 1631, false );
		proxy:PlayLoopAnimation( 1620 , 0 );
	--クライアントの場合は上下の状態を見て合わせる
	else
		--エレベータ上下の状態をホストの世界にあわせる
		if	proxy:IsCompleteEvent( 1630 ) == true then
			proxy:EndAnimation( 1620, 1 );
		else
			proxy:EndAnimation( 1620, 0 );
		end
	end
	
	proxy:OnPlayerActionInRegion( 1635 , 2650 , "OnEvent_1635" , HELPID_START , everytime );--昇る用
	--[[
	proxy:NotNetMessage_begin();
		proxy:OnRegionJustOut( 1635, LOCAL_PLAYER, 2651, "OnEvent_1635_Out", everytime );
	proxy:NotNetMessage_end();
	]]
	proxy:LuaCall(1635, 2, "OnEvent_1635_flag", everytime);--上下フラグ同期
	proxy:LuaCall(1635, 3, "OnEvent_1635", everytime );--動作同期
	proxy:LuaCall(1635, 4, "OnEvent_1635_animeflag",everytime);--アニメ中同期
	
	proxy:LuaCall(1635, 5, "OnEvent_1635_UpAnime",everytime);
	proxy:LuaCall(1635, 6, "OnEvent_1635_DownAnime",everytime);
	


	--proxy:SetEventFlag( 1630 , true ); --エレベータが下にあるフラグON
	--proxy:SetEventFlag( 1631 , false );--エレベータが上にあるフラグOFF

	--proxy:OnDistanceActionPlus( 1635 , LOCAL_PLAYER, 1620, "OnEvent_1635" , 1, HELPID_START , 0, 100, 0.0, 0.0, 0.0, everytime );--昇る用
--	proxy:OnPlayerActionInRegion( 1636 , 2651 , "OnEvent_1636" , HELPID_START , everytime );--降りる用

	
--■1780■敵が落ちてくる■
	if	proxy:IsCompleteEvent( 1780 ) == false then
		proxy:OnRegionJustIn( 1780, LOCAL_PLAYER, 2656, "OnEvent_1780", once );
		proxy:OnSimpleDamage( 1780, 512, -1, "OnEvent_1780", once );
		proxy:EnableLogic( 512, false );
		proxy:Warp( 512, 2655 );
	end
	
--■ボス関連の初期化処理
	if proxy:IsCompleteEvent( 4480 ) ==true then
		
		--▽ボス死んでいるとき
		--ボスいなくなる
		InvalidBackRead( proxy , 821 );
		
		--魔法壁消える(このマップは魔法壁一つ)
		proxy:SetColiEnable( 1996 , false );
		proxy:SetDrawEnable( 1996 , false );	

		--魔法壁のSFX OFF
		proxy:InvalidSfx( 1988 , true );
		
	else
	    --▽ボス生きているとき		
		proxy:EnableLogic( 821 , false );--ロジックOFFで待機		
	end		

	--レンドル王の死んだ後、要石でボイス再生
	proxy:RegistSimpleTalk( 4510 , 1979 , 28000, TALK_ATTR_ALL );

--■4503,4505■ソウル入手、要石でワープ■
	if proxy:IsCompleteEvent( 4480 ) ==true then--ボスが死んでいるとき
		
		proxy:TreasureDispModeChange2( 1979 , true ,KANAME_SFX);--光らせる
		--▼(ソウル)アイテム取得用イベント監視追加▼
		if proxy:IsCompleteEvent( 4503 ) == false then
			proxy:ValidSfx( 1640 );--SFX 有効化
			proxy:ValidSfx( 1641 );--光の粒子			
			proxy:OnDistanceActionAttribute( 4503 , LOCAL_PLAYER , 1979 , "OnEvent_4503" , WarpGimmickDist_A , 10010180 , 0 , 180 , ATTR_HOST + ATTR_LIVE + ATTR_GREY, once );

			--ソウル有効化
			proxy:SetDrawEnable( 1979 , true );
			proxy:SetColiEnable( 1979 , true );
			--ソウル2有効化
			proxy:SetDrawEnable( 1978 , true );
			proxy:SetColiEnable( 1978 , true );

		else
			--▼要石でワープ用の監視を追加▼
			proxy:InvalidSfx( 1640, false );--SFX 無効化
			--proxy:InvalidSfx( 1641, false );--光の粒子
			SingleReset( proxy , 4505);
			proxy:OnDistanceActionAttribute( 4505 , LOCAL_PLAYER , 1979 , "OnEvent_4505" , WarpGimmickDist_A , HELPID_GO_TO_SEKITYUU , 0 , 180 , ATTR_NOSESSION , everytime );
		end

	else
		--ソウル無効化
		proxy:SetDrawEnable( 1979 , false );
		proxy:SetColiEnable( 1979 , false );
		--ソウル2無効化
		proxy:SetDrawEnable( 1978 , false );
		proxy:SetColiEnable( 1978 , false );
		--SFX 無効化
		proxy:InvalidSfx( 1640 , false );
		proxy:InvalidSfx( 1641 , false );
	end
	
	


--■飛竜(長)イベント関連初期化
	if	proxy:IsClient() == false then
		proxy:RequestForceUpdateNetwork(HiryuOsa_b4_evid);
	end
	

--■8084■王城に来たフラグを立てる■
	proxy:SetEventFlag(8084, true);
	
	--■1706■一定領域進入で王子が死ぬ■
	RegistEvent_1706(proxy);
	
	--■1640■レンドル王子・ブラック死亡■
	RegistEvent_1640(proxy);
	
	--結晶トカゲイベント
	RegistTokage(proxy,1680,257,4);
	RegistTokage(proxy,1682,258,5);
	RegistTokage(proxy,1684,259,6);	
	
--■1690■三銃士1が死んだ■
	if proxy:IsCompleteEvent( 1690 ) == false then
		proxy:OnCharacterDead( 1690 , 530 , "OnEvent_1690",once);
	else
		InvalidBackRead( proxy,530 );
	end
--■1691■三銃士2が死んだ■
	if proxy:IsCompleteEvent( 1691 ) == false then
		proxy:OnCharacterDead( 1691 , 531 , "OnEvent_1691",once);
	else
		InvalidBackRead( proxy, 531 );
	end
--■1692■三銃士3が死んだ■
	if proxy:IsCompleteEvent( 1692 ) == false then
		proxy:OnCharacterDead( 1692 , 532 , "OnEvent_1692",once);
	else
		InvalidBackRead( proxy, 532 );
	end


--------------------------------▽▽▽QWCイベント関連▽▽▽--------------------------------
--------------------------------△△△QWCイベント関連△△△--------------------------------
	--■999999■フレーム遅れの初期化処理イベントを発行■
	proxy:NotNetMessage_begin();
		--▼0秒後▼--
		proxy:OnKeyTime2( 999993, "Second_Initialize_m02_03_00_00", 0.0, 0, 0, once );
	proxy:NotNetMessage_end();	


	--■15500■乱入アイテム取得監視■ハンドラはグローバルに定義
	--if proxy:IsCompleteEvent( 15500 ) == false then
	--	proxy:AddCorpseEvent( 15500 , 530 );--三銃士A
	--	proxy:AddCorpseEvent( 15500 , 531 );--三銃士B
	--	proxy:AddCorpseEvent( 15500 , 532 );--三銃士C
	--end
	
	print("Initialize_m02_03_00_00 end");
end

function Second_Initialize_m02_03_00_00(proxy,param)
	print("Second_Initialize_m02_03_00_00 begin");
--------------------------------▽▽▽QWCイベント関連▽▽▽--------------------------------
--------------------------------△△△QWCイベント関連△△△--------------------------------
	print("Second_Initialize_m02_03_00_00 end");
end

--------------------------------------------------------------------------------------
--マルチになった時にホストじゃ無かったら■無し
--------------------------------------------------------------------------------------
function ConnectPartyEvent(proxy)
	print("ConnectPartyEvent begin");
	print("ConnectPartyEvent end");
end


--------------------------------------------------------------------------------------
--徘徊デーモンの登場■??
--------------------------------------------------------------------------------------

--▼グローバルの死亡監視から呼ばれる(ソロ)
function PlayerDeath_m02_03_00_00(proxy, param)
	print("PlayerDeath_m02_03_00_00");
	print("PlayerDeath_m02_03_00_00");
end

--▼グローバルの血文字復活から呼ばれる(ソロ)
function PlayerRevive_m02_03_00_00(proxy,param)
	print("PlayerRevive_m02_03_00_00");
	print("PlayerRevive_m02_03_00_00");
end




--------------------------------------------------------------------------------------
--■1560■飛竜の長、出現■
--------------------------------------------------------------------------------------

function OnEvent_1560(proxy , param)
	print("OnEvent_1560 begin");

	--多重発動防止
	if proxy:IsCompleteEvent( 1560 ) == true then
		print("OnEvent_1560 end");
		return;
	end
	
	--現在の状態取得
	local now_state = GetNpcStateFlag(proxy ,param, tyo_flag_list);
	
	--飛竜の状態が警戒(通路)のとき
	if now_state == TYO_STATE_WARNING_AISLE then 
		
		--ポリ劇再生
		proxy:RequestRemo(20300,REMO_FLAG,1560,1);
		proxy:SetEventFlag( 1560 , 1 );--フラグセット
	end
	
	print("OnEvent_1560 end");
end


--■ポリ劇再生開始(フェード終了)
function OnEvent_1560_RemoStart(proxy,param)
	print("OnEvent_1560_RemoStart begin");
	
	--このタイミングで有効化するオブジェ
	proxy:SetDrawEnable( 1710 , true );
	proxy:SetColiEnable( 1710 , true );
	
	proxy:SetDrawEnable( 1711 , true );
	proxy:SetColiEnable( 1711 , true );
	ValidCharactor( proxy , HiryuOsa_b4_evid );--飛竜有効化
	
	print("OnEvent_1560_RemoStart end");
end


--■ポリ劇再生終了(フェード終了)
function OnEvent_1560_RemoFinish(proxy , param)
	print("OnEvent_1560_RemoFinish begin");
	
	proxy:DeleteEvent( 1560 );--everytimeなので消す
	
	proxy:Warp(  HiryuOsa_b4_evid , 2700 );	
	proxy:ForcePlayAnimationStayCancel( HiryuOsa_b4_evid, 7001 );

	--▼飛竜が再生するアニメの判定用トリガー(生存orグレイのみ)▼
	if proxy:IsClient() == false then
		proxy:NotNetMessage_begin();
			proxy:OnKeyTime2( 1590 , "OnEvent_1590" , 0.0 , 0 , 1 , once );
		proxy:NotNetMessage_end();
	end

	--演出用(?)のOBJを有効化/無効化する
	proxy:SetDrawEnable( 1720 , true );
	proxy:SetColiEnable( 1720 , true );
	
	proxy:SetDrawEnable( 1721 , true );
	proxy:SetColiEnable( 1721 , true );
	
	proxy:SetDrawEnable( 1710 , false );
	proxy:SetColiEnable( 1710 , false );
	
	proxy:SetDrawEnable( 1711 , false );
	proxy:SetColiEnable( 1711 , false );
	
	proxy:SetDrawEnable( 1700 , false );
	proxy:SetColiEnable( 1700 , false );
	
	proxy:SetDrawEnable( 1701 , false );
	proxy:SetColiEnable( 1701 , false );	

	print("OnEvent_1560_RemoFinish end");
end




--------------------------------------------------------------------------------------
--ボス部屋の中に入る■1570
--------------------------------------------------------------------------------------

--■イベントがループなので、全部リピートにする↓

--■1570■中ボス部屋への扉が開く■
function OnEvent_1570(proxy,param)
	print("OnEvent_1570 begin");
	
	--エレベータアニメ再生中は入れないようにはじく
	if proxy:IsCompleteEvent( 1631 ) == true then
		print("OnEvent_1570 return end");
		return;
	end

	if proxy:IsCompleteEvent( SYSTEM_ID_IGNORE ) == true then
		print("OnEvent_1570 end");
		return;
	end
	
	--クライアントへ、ボス部屋阻止失敗を通知
	if proxy:IsClient() == false then
		proxy:LuaCallStart( 4068 , 1 );	
	end
	
	proxy:LuaCallStart( 1571 , 1 );--旋回アニメの同期再生
	--proxy:SetEventFlag( SYSTEM_ID_IGNORE , 1 );--多重発動防止用
	--多重起動システムIDをタイムアウトを設定してONにする
	proxy:SetSystemIgnore( SYSTEM_ID_IGNORE , IGNORE_TIME );
	
	--プロファイルセーブ要求
	proxy:SaveRequest_Profile();
	
	print("OnEvent_1570 end");
end


--旋回アニメの同期再生(IDが別)
function OnEvent_1571_1(proxy,param)
	print("OnEvent_1571_1 begin");
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		if param:IsNetMessage() == true then
			--旋回アニメ再生を行い、その終了時にOnEvent_1571_2を発行する
			proxy:TurnCharactor( 10001 + param:GetPlayID(), 2888 );
		else
			proxy:LockSession();--ルームをロックします！
			--旋回アニメ再生を行い、その終了時にOnEvent_1571_2を発行する
			proxy:OnTurnCharactorEnd( 1571, LOCAL_PLAYER, 2888, "OnEvent_1571_2", once );
		end
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_1571_1 end");
end

--旋回アニメの同期再生終了後
function OnEvent_1571_2(proxy,param)
	print("OnEvent_1571_2 begin");
	
	--同期用歩きアニメ再生
	proxy:LuaCallStart( 4012, 1 );
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 1571, LOCAL_PLAYER, ANIMEID_WALK, "OnEvent_1571_3", once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
		
	print("OnEvent_1571_2 end");
end

--歩きアニメの同期再生終了後
function OnEvent_1571_3(proxy,param)
	print("OnEvent_1571_3 begin");

	--最初の人がボス部屋の中に入り終わっていたら、既に配信されているはずなので、もうおくらないハンドラ
	if proxy:IsCompleteEvent( 1570 ) == false then
		proxy:LuaCallStart( 1571 , 5 );--2回目以降にボス部屋に入るためのイベント配信用
		proxy:LuaCallStart( 4045 , 1 );	--クライアントへ、ボス部屋に入れるようになったことを通知
		proxy:LuaCallStart( 1571 , 6 );--フラグセット(同期用)
		Lua_MultiDoping(proxy,821);--マルチプレイドーピング
	end

	--プレイヤーが扉の中に完全にはいったタイミングで、ボスの思考をリセット
	--場所が悪いとプレイヤーを見つけれないため(攻撃してこない)
	if proxy:IsClient() == false then
		proxy:ResetThink( 821 );
	end
	
	proxy:SetEventFlag( SYSTEM_ID_IGNORE , 0 );--多重発動防止用	
	
	print("OnEvent_1571_3 end");
end


--■1570 2回目以降にボス部屋に入るためのイベント配信用
function OnEvent_1570_GO_TO_IN(proxy, param)
	print("OnEvent_1570_GO_TO_IN begin");
		
	proxy:NotNetMessage_begin();
		--▼1571▼扉が開いているときに中に入るためのイベントを追加▼--ハンドラは OnEvent_1570
		proxy:OnPlayerActionInRegion( 1571, 2892, "OnEvent_1570", HELPID_GO_TO_IN, everytime );--
	proxy:NotNetMessage_end();	
	
	print("OnEvent_1570_GO_TO_IN end");
end


--■1570 フラグセット(同期用)
function OnEvent_1570_flag_set(proxy, param)
	print("OnEvent_1570_flag_set begin");
		
	proxy:SetEventFlag( 1570 , 1 );
	proxy:DeleteEvent( 1570 );

	print("OnEvent_1570_flag_set end");
end



--------------------------------------------------------------------------------------
--中ボスポリ劇再生■1540
--------------------------------------------------------------------------------------

function OnEvent_1540(proxy, param)
	print("OnEvent_1540 begin");
--[[	

	--現在の状態取得
	local now_tyo_state = GetNpcStateFlag( proxy , param , tyo_flag_list );
	if now_tyo_state == TYO_STATE_DEAD then
		--ポリ劇再生開始
		proxy:RequestRemo(20302,REMO_FLAG,1545,1);
	else
		--ポリ劇再生開始
		proxy:RequestRemo(20301,REMO_FLAG,1540,1);
	end
]]
	proxy:RequestRemo(20302,REMO_FLAG,1545,1);
	proxy:SetEventFlag( 1545 , 1 );--ポリ劇再生終了
	print("OnEvent_1540 end");
end

--[[
--■1540_RemoStart■ポリ劇開始 フェードアウト完了■
function OnEvent_1540_RemoStart(proxy,param)
	print( "OnEvent_1540_RemoStart begin" );
	
	proxy:SetDrawEnable( 821 , false );
	
	print( "OnEvent_1540_RemoStart end" );
end


--■1540_RemoFinish■ポリ劇再生終了後■
function OnEvent_1540_RemoFinish(proxy , param)
	print( "OnEvent_1540_RemoFinish begin" );

	proxy:SetDrawEnable( 821 , true );
	proxy:SetEventFlag( 1540 , 1 );--ポリ劇再生終了

	print( "OnEvent_1540_RemoFinish end" );
end
]]

--■1545_RemoStart■ポリ劇開始 フェードアウト完了■
function OnEvent_1545_RemoStart(proxy,param)
	print( "OnEvent_1545_RemoStart begin" );
	
	proxy:SetDrawEnable( 821 , false );
	
	print( "OnEvent_1545_RemoStart end" );
end


--■1545_RemoFinish■ポリ劇再生終了後■
function OnEvent_1545_RemoFinish(proxy , param)
	print( "OnEvent_1545_RemoFinish begin" );

	proxy:SetDrawEnable( 821 , true );
	proxy:SetEventFlag( 4490 , true );

	print( "OnEvent_1545_RemoFinish end" );
end

--[[
--------------------------------------------------------------------------------------
--中ボスポリ劇2再生■1545
--------------------------------------------------------------------------------------

function OnEvent_1545(proxy, param)
	print("OnEvent_1545 begin");

	--ポリ劇再生開始
	proxy:RequestRemo(20302,REMO_FLAG,1545,1);
	
	print("OnEvent_1545 end");
end


--■1540_RemoStart■ポリ劇開始 フェードアウト完了■
function OnEvent_1545_RemoStart(proxy,param)
	print( "OnEvent_1545_RemoStart begin" );
	
	proxy:SetDrawEnable( 821 , false );
	
	print( "OnEvent_1545_RemoStart end" );
end


--■1540_RemoFinish■ポリ劇再生終了後■
function OnEvent_1545_RemoFinish(proxy , param)
	print( "OnEvent_1545_RemoFinish begin" );

	proxy:SetDrawEnable( 821 , true );
	proxy:SetEventFlag( 1545 , 1 );--ポリ劇再生終了

	print( "OnEvent_1545_RemoFinish end" );
end
]]


--------------------------------------------------------------------------------------
--ボスが動き出す(戦闘開始)■1572
--------------------------------------------------------------------------------------

function OnEvent_1572(proxy, param)
	if proxy:IsCompleteEvent( 4490 ) == false then
		return;
	end
	print("OnEvent_1572 begin");
	
	--ボス戦用BGM再生開始
	proxy:PlayPointSE( 2660, SOUND_TYPE_M, 20300000, 3 );
	
	--ボスロジックON
	proxy:EnableLogic( 821 , true );
	
	--読み込みタイミングのとき毎回追加されてほしいのでフラグたてない
	
	--ボスゲージ表示
	proxy:SetBossGauge( 821 , 0 ,6010 );
	
	--監視削除
	proxy:DeleteEvent( 1572 );
	
	print("OnEvent_1572 end");
end




--------------------------------------------------------------------------------------
--■4480■中ボス死亡■
--------------------------------------------------------------------------------------

--■4480■中ボス死亡■
function OnEvent_4480(proxy, param)
	print("OnEvent_4480 begin");

	proxy:NotNetMessage_begin();
		--▼4500▼クライアントPCワープ演出▼
		proxy:OnKeyTime2( 4500, "OnEvent_4500", 0, 0, 0, once);	
		--▼4481▼1秒経過▼
		proxy:OnKeyTime2( 4481, "OnEvent_4481", 1, 0, 1, once);
		--▼4502▼2秒経過▼
		proxy:OnKeyTime2( 4502, "OnEvent_4502", 2, 0, 2, once);	
		--マルチ解散監視
		proxy:OnRegistFunc( 4480 , "Check_4480_PT","OnEvent_4480_PT",0,once);
	proxy:NotNetMessage_end();
	
	--PCに付いた特殊効果を無効化
	if proxy:EraseEventSpecialEffect_2(LOCAL_PLAYER, 5007) == true then
		print("★★5030のエフェクトを消去★★");
	else
		print("5030のエフェクトを消去失敗");
	end
	if proxy:EraseEventSpecialEffect_2(LOCAL_PLAYER, 5008) == true then
		print("★★5031のエフェクトを消去★★");
	else	
		print("5031のエフェクトを消去失敗");
	end
	if proxy:EraseEventSpecialEffect_2(LOCAL_PLAYER, 5009) == true then
		print("★★5032のエフェクトを消去★★");
	else	
		print("5032のエフェクトを消去失敗");
	end
	
	--proxy:EraseEventSpecialEffect(LOCAL_PLAYER, 5030);
	--proxy:EraseEventSpecialEffect(LOCAL_PLAYER, 5031);
	--proxy:EraseEventSpecialEffect(LOCAL_PLAYER, 5032);
	
	--ブロッククリア処理へ
	proxy:CustomLuaCallStart( 4050, 821 );	
	--結晶トカゲリセット
	ResetTokage(proxy);
	
	proxy:SetEventFlag( 4480, 1 );--ボス死亡フラグON
	
	--レンドル死亡に連動してレンドル王子がもういない状態に
	--[[
	if	proxy:IsCompleteEvent( RENDOL_STATE_LIFT_FRONT ) == true then
		SetNpcStateFlag( proxy, param, rendol_flag_list, RENDOL_STATE_ERASE );
			InvalidCharactor( proxy, 626 );
	end
	]]

	--ビヨルングルム(レンドル王を倒した時に、飛竜の長と戦っていたらもういない状態へ)
	if proxy:IsCompleteEvent( BIYO_STATE_BATTLE_FLY_DRAGON ) == true then
		SetNpcStateFlag( proxy , param , biyo_flag_list , BIYO_STATE_EXIT );
		proxy:SetEventFlag( 1710, true );
	end	
	
	print("OnEvent_4480 end");
end

--▲4481▲中ボス死亡後1秒▲
function OnEvent_4481(proxy, param)
	print("OnEvent_4481 begin");
	
	--ボスを倒した数を更新(数によってフラグを立てる)
	GetBossFlagCount( proxy, param );
	
	--▼トロフィー取得判定▼
	Lua_RequestUnlockTrophy(proxy, 6);
	
	--▼(ソウル)アイテム取得用イベント監視追加▼
	if proxy:IsCompleteEvent( 4503 ) == false then
	
		--ソウル有効化
		proxy:SetDrawEnable( 1979 , true );
		proxy:SetColiEnable( 1979 , true );
		--ソウル2有効化
		proxy:SetDrawEnable( 1978 , true );
		proxy:SetColiEnable( 1978 , true );

		proxy:ValidSfx( 1640 );--SFX 有効化
		proxy:ValidSfx( 1641 );--SFX 有効化
		proxy:TreasureDispModeChange2( 1979 , true ,KANAME_SFX);--光らせる
		proxy:OnDistanceActionAttribute( 4503 , LOCAL_PLAYER , 1979 , "OnEvent_4503" , WarpGimmickDist_A , 10010180 , 0 , 180 , ATTR_HOST + ATTR_LIVE + ATTR_GREY, once );
	else
		--ソウル無効化(取ったら消えるので･･･)
		proxy:SetDrawEnable( 1979 , false );
		proxy:SetColiEnable( 1979 , false );
	end

	--王城クリアフラグON
	if proxy:IsClient() == false then
		proxy:SetEventFlag( 8010 , 1 );
	end

	print("OnEvent_4481 end");
end



--------------------------------------------------------------------------------------
--■4500■クライアントPCワープ演出■
--------------------------------------------------------------------------------------

--■4500■クライアントPCワープ演出■
function OnEvent_4500(proxy, param)
	print("OnEvent_4500 begin");

	if proxy:IsClient() == true then
		proxy:PlayAnimation( LOCAL_PLAYER , 8284 );--ワープアニメを再生
	end

	proxy:SetEventFlag( 4500 , 1 );
	
	print("OnEvent_4500 end");
end



--------------------------------------------------------------------------------------
--■4502■シングル：光の壁、BGM消去■
--------------------------------------------------------------------------------------

--■4502■シングル：光の壁、BGM消去■
function OnEvent_4502(proxy, param)
	print("OnEvent_4502 begin");
	
	--ボス戦用のBGM停止
	proxy:StopPointSE( 3 );	

	proxy:SetEventFlag( 4502 , 1 );
	
	print("OnEvent_4502 end");
end

--マルチ解散監視
function Check_4480_PT(proxy)
	if proxy:IsInParty() == false then
		return true;
	end
	return false;
end

--マルチじゃない
function OnEvent_4480_PT(proxy,param)
	print("OnEvent_4480_PT beign");
	--中ボス部屋の前後の魔法壁が消える(全プレイヤー、このマップは魔法壁が一つ)
	proxy:SetColiEnable( 1996 , false );	
	proxy:SetDrawEnable( 1996 , false );
	
	--proxy:SetObjDeactivate( 1996 , true );--デアクティブ
	
	--中ボス部屋魔法壁のSFX削除(ボス扉のIDとは別)
	proxy:InvalidSfx( 1988 , true );
	
	--中ボス部屋前の移動処理イベントを削除
	proxy:DeleteEvent( 1570 );--一人目が入るとき用
	proxy:DeleteEvent( 1571 );--二人目以降が入るとき用
	proxy:DeleteEvent( 1540 );--ポリ劇再生用
	proxy:DeleteEvent( 1572 );--ボス戦闘開始用	
	print("OnEvent_4480_PT end");
end


--------------------------------------------------------------------------------------
--■1590■飛竜の長が警戒している■
--------------------------------------------------------------------------------------

--飛竜(長)が再生するアニメID
tyo_play_anime_id = -1;--最初はアニメを再生していないので-1

--■1590■飛竜の長が警戒している■
function OnEvent_1590(proxy, param)
	print("OnEvent_1590 begin");
	
	
	--[[現在の状態取得]]
	local now_state = GetNpcStateFlag( proxy, param, tyo_flag_list );
	
	--[[王城４に誰もいない]]
	if	proxy:IsCompleteEvent( 1651 )	==	false and	--2710
		proxy:IsCompleteEvent( 1670 )	==	false then	--HP75%以上
		SetNpcStateFlag(proxy, param, tyo_flag_list, TYO_STATE_WARNING_AISLE );
		--→OnEvent_1590_3
		proxy:LuaCallStart( 1590 , 3 );
	--[[状態が、「通路を警戒」]]
	elseif	proxy:IsCompleteEvent( TYO_STATE_WARNING_AISLE ) == true then
			
		--[[通路前で死亡]] --[[死亡優先]]
		if proxy:IsCompleteEvent( 1770 ) == true then--死亡用のHP監視フラグがON
		   
			--→OnEvent_1595_1
			proxy:LuaCallStart( 1595 , 1 );--通路で死亡アニメの同期再生

		--[[ゲート前に移動]]
		elseif
		   proxy:IsCompleteEvent( 1623 ) == true or		--2640
		   proxy:IsCompleteEvent( 1671 ) == true then	--Hp50％以下
			
			print("飛竜(長)、ゲート前に移動開始");
			--→OnEvent_1597_1
			proxy:LuaCallStart( 1597 , 1 );
			
		--[[待機(通路)]]
		elseif
		   proxy:IsCompleteEvent( 1620 ) == false and	--2610
		   proxy:IsCompleteEvent( 1621 ) == false and	--2620
		   proxy:IsCompleteEvent( 1622 ) == false and	--2630
		   proxy:IsCompleteEvent( 1623 ) == false then	--2640
		   
			print("待機(通路)");
			--→OnEvent_1590_3
			proxy:LuaCallStart( 1590 , 3 );
		
		--[[領域Aブレス]]
		elseif
		   proxy:IsCompleteEvent( 1620 ) == true  and  --2610
		   proxy:IsCompleteEvent( 1621 ) == false and  --2620
		   proxy:IsCompleteEvent( 1622 ) == false and  --2630
		   proxy:IsCompleteEvent( 1623 ) == false then --2640
			
			
			--[[攻撃の前に通路で待機を挟む]]
			--→OnEvent_1591_1
			proxy:LuaCallStart( 1591 , 1 );
		
		--[[領域Bブレス]]
		elseif
		   proxy:IsCompleteEvent( 1621 ) == true  and  --2620
		   proxy:IsCompleteEvent( 1622 ) == false and  --2630
		   proxy:IsCompleteEvent( 1623 ) == false then --2640
			
			print("領域Bブレス");
			--[[攻撃の前に通路で待機を挟む]]
			--→OnEvent_1592_1
			proxy:LuaCallStart( 1592 , 1 );

		--[[領域Cブレス]]
		elseif
		   proxy:IsCompleteEvent( 1622 ) == true  and  --2630
		   proxy:IsCompleteEvent( 1623 ) == false then --2640
			
			print("領域Cブレス");
			--[[攻撃の前に通路で待機を挟む]]
			--→OnEvent_1593_1
			proxy:LuaCallStart( 1593 , 1 );
		
		end
	--[[状態が、「ゲートを警戒」]]
	elseif	proxy:IsCompleteEvent( TYO_STATE_WARNING_GATE ) == true then
			
		--[[ゲート前で死亡]] --[[死亡優先]]
		if proxy:IsCompleteEvent( 1770 ) == true then--死亡用のHP監視フラグがON

			--→OnEvent_1596_1
			proxy:LuaCallStart( 1596 , 1  );
		   
		--[[広場Aブレス]]
		elseif 
		  (proxy:IsCompleteEvent( 1624 ) == true	and		--2641
		   proxy:IsCompleteEvent( 1625 ) == false	and		--2642
		   proxy:IsCompleteEvent( 1626 ) == false	) or	--2643
		  (proxy:IsCompleteEvent( TYO_STATE_WARNING_GATE ) 			== true	 and 	--飛竜の長が「ゲート前を警戒」
		   proxy:IsCompleteEvent( BIYO_STATE_BATTLE_FLY_DRAGON )	== true) then	--ビヨが「飛竜と戦う」
			print("広場Aブレス");
			--→OnEvent_1594_1
			proxy:LuaCallStart( 1594 , 1 );
			
		--[[広場Bブレス]]
		elseif 
		   proxy:IsCompleteEvent( 1625 ) == true	and		--2642
		   proxy:IsCompleteEvent( 1626 ) == false	and		--2643
		   proxy:IsCompleteEvent( BIYO_STATE_BATTLE_FLY_DRAGON ) == false	then	--ビヨが「飛竜と戦う」ではない
		   
			print("広場Bブレス");
			--→OnEvent_1660_1
			proxy:LuaCallStart( 1660 , 1 );
		--[[広場Cブレス]]
		elseif 
		   proxy:IsCompleteEvent( 1626 ) == true	and		--2643
		   proxy:IsCompleteEvent( BIYO_STATE_BATTLE_FLY_DRAGON ) == false	then	--ビヨが「飛竜と戦う」ではない
		   
			print("広場Cブレス");
			--→OnEvent_1661_1
			proxy:LuaCallStart( 1661 , 1 );
		--[[通路前に飛んでいく]]
		elseif
		    proxy:IsCompleteEvent( 1623 )	==	false	and		--2640
		  ( proxy:IsCompleteEvent( 1620 )	==	true	or		--2610
		    proxy:IsCompleteEvent( 1621 )	==	true	or		--2620
		    proxy:IsCompleteEvent( 1622 )	==	true )	and		--2630
			proxy:IsCompleteEvent( 1670 )	==	false 	then	--Hp75%以上

			print("飛竜(長)、通路前に移動開始");
			--→OnEvent_1598_1
			proxy:LuaCallStart( 1598 , 1 );
		
		--[[待機(ゲート)]]
		elseif
		   proxy:IsCompleteEvent( 1624 ) == false and		--2641
		   proxy:IsCompleteEvent( 1625 ) == false and		--2642
		   proxy:IsCompleteEvent( 1626 ) == false then		--2643

			print("待機(ゲート)");
			--→OnEvent_1662_1
			proxy:LuaCallStart( 1662 , 1 );
			
		end

	--[[状態が、「死亡」]]
	elseif	proxy:IsCompleteEvent( TYO_STATE_DEAD ) == true then
		print("OnEvent_1590 Dead end")
	
		--(監視削除?)
	end
	
	print("OnEvent_1590 end");
end

--▲1590_anime_end▲アニメの終了のふしに必ず通る▲
function OnEvent_1590_anime_end(proxy, param)
	print("OnEvent_1590_anime_end begin");
	
	proxy:NotNetMessage_begin();
		--▼飛竜の長が警戒している▼
		proxy:OnKeyTime2( 1590 , "OnEvent_1590" , 0.0 , 0 , 1 , once );
	proxy:NotNetMessage_end();

	print("OnEvent_1590_anime_end end");
end


--LuaCallParam(1662,1)
function OnEvent_1662_1(proxy,param)
	print("OnEvent_1662_1 begin");
	tyo_play_anime_id = 7007;
	proxy:Warp( HiryuOsa_b4_evid , 2701 );--通路側の領域にワープ
	--proxy:ForcePlayAnimationStayCancel( HiryuOsa_b4_evid, tyo_play_anime_id );
	proxy:ForcePlayAnimationStayCancel( HiryuOsa_b4_evid, tyo_play_anime_id );
	
	if	param:IsNetMessage() == true then
		print("OnEvent_1662_1 return end");
		return;
	end
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 1661, HiryuOsa_b4_evid, tyo_play_anime_id, "OnEvent_1590_anime_end", once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_1662_1 end");
end

--秒数で終了したか、アニメの尺で終了したかの判定をきっちり分けるため、フラグで後から来た方は蹴るようにする
Osa_WaitAnim_EndFlag_A = 0;
Osa_IsWaitAnimCondition_A = 0;
--LuaCallParam(1590,3)
function OnEvent_1590_3(proxy,param)
	print("OnEvent_1590_3 begin");
	
	proxy:Warp( HiryuOsa_b4_evid , 2700 );
	
	--既に待機アニメだったら上書きしない
	print("tyo_play_anime_id = ", tyo_play_anime_id);
	
	if	tyo_play_anime_id ~= 7001 then
		tyo_play_anime_id = 7001;
		proxy:ForcePlayAnimationStayCancel( HiryuOsa_b4_evid, tyo_play_anime_id );
	end
	
	if	param:IsNetMessage() == true then
		print("OnEvent_1590_3 return end");
		return;
	end
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 1661, "OnEvnet_1590_4", 1.0, 0, 2, once );
		if	Osa_IsWaitAnimCondition_A ~= 1 then
			proxy:OnChrAnimEnd( 1661, HiryuOsa_b4_evid, tyo_play_anime_id, "OnEvnet_1590_5", once );
			Osa_IsWaitAnimCondition_A = 1;
		end
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	Osa_WaitAnim_EndFlag_A = 0;
	
	print("OnEvent_1590_3 end");
end


--秒数経過で判定を抜ける時
function OnEvnet_1590_4(proxy,param)
	print("OnEvnet_1590_4 begin");
	if	Osa_WaitAnim_EndFlag_A == 0 then
		Osa_WaitAnim_EndFlag_A = 1;
		OnEvent_1590_anime_end(proxy,param);
	end
	print("OnEvnet_1590_4 end");
end

--アニメ終了で判定を抜ける時
function OnEvnet_1590_5(proxy,param)
	print("OnEvnet_1590_5 begin");
	if	Osa_WaitAnim_EndFlag_A == 0 then
		Osa_WaitAnim_EndFlag_A = 2;
		proxy:LuaCallStartPlus( 1590, 10, tyo_play_anime_id );
		OnEvent_1590_anime_end(proxy,param);
	end
	Osa_IsWaitAnimCondition_A = 0;
	print("OnEvnet_1590_5 end");
end




------------------------------------------------------------------------------------------------------
--■1591■領域Aをブレス
------------------------------------------------------------------------------------------------------
--LuaCallParam(1591,1)
function OnEvent_1591_1(proxy,param)
	print("OnEvent_1591_1 begin");
	tyo_play_anime_id = 7001;
	proxy:Warp( HiryuOsa_b4_evid , 2700 );--通路側の領域にワープ
	proxy:ForcePlayAnimationStayCancel( HiryuOsa_b4_evid, tyo_play_anime_id );
	
	if	param:IsNetMessage() == true then
		print("OnEvent_1591 return end");
		return;
	end
--[[	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 1591, HiryuOsa_b4_evid, tyo_play_anime_id, "OnEvent_1591_1_1", once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
]]	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		local Delay = GetDelay_HiryuOsa(proxy);
		proxy:OnKeyTime2( 1591, "OnEvent_1591_1_2", Delay, 0, 2, once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	print("OnEvent_1591_1 end");
end


function OnEvent_1591_1_1(proxy,param)
	print("OnEvent_1591_1_1 begin");
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		local Delay = GetDelay_HiryuOsa(proxy);
		proxy:OnKeyTime2( 1591, "OnEvent_1591_1_2", Delay, 0, 2, once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_1591_1_1 end");
end

function OnEvent_1591_1_2(proxy,param)
	print("OnEvent_1591_1_2 begin");
	
	--OnEvent_1591_2
	proxy:LuaCallStart(1591,2);
	
	print("OnEvent_1591_1_2 end");
end


--LuaCallParam(1591,1)
function OnEvent_1591_2(proxy,param)
	print("OnEvent_1591_2 begin");
	tyo_play_anime_id = 7002;
	proxy:Warp( HiryuOsa_b4_evid , 2700 );--通路側の領域にワープ
	proxy:ForcePlayAnimationStayCancel( HiryuOsa_b4_evid, tyo_play_anime_id );
	
	if	param:IsNetMessage() == true then
		print("OnEvent_1591_2 return end");
		return;
	end
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 1591, HiryuOsa_b4_evid, tyo_play_anime_id, "OnEvent_1590_anime_end", once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_1591_2 end");
end




------------------------------------------------------------------------------------------------------
--■1592■領域Bをブレス
------------------------------------------------------------------------------------------------------
--LuaCallParam(1592,1)
function OnEvent_1592_1(proxy,param)
	print("OnEvent_1592_1 begin");
	tyo_play_anime_id = 7001;
	proxy:Warp( HiryuOsa_b4_evid , 2700 );--通路側の領域にワープ
	proxy:ForcePlayAnimationStayCancel( HiryuOsa_b4_evid, tyo_play_anime_id );
	
	if	param:IsNetMessage() == true then
		print("OnEvent_1592 return end");
		return;
	end
--[[	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 1592, HiryuOsa_b4_evid, tyo_play_anime_id, "OnEvent_1592_1_1", once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
]]	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		local Delay = GetDelay_HiryuOsa(proxy);
		proxy:OnKeyTime2( 1592, "OnEvent_1592_1_2", Delay, 0, 2, once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	print("OnEvent_1592_1 end");
end


function OnEvent_1592_1_1(proxy,param)
	print("OnEvent_1592_1_1 begin");
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		local Delay = GetDelay_HiryuOsa(proxy);
		proxy:OnKeyTime2( 1592, "OnEvent_1592_1_2", Delay, 0, 2, once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_1592_1_1 end");
end

function OnEvent_1592_1_2(proxy,param)
	print("OnEvent_1592_1_2 begin");
	
	--OnEvent_1592_2
	proxy:LuaCallStart(1592,2);
	
	print("OnEvent_1592_1_2 end");
end


--LuaCallParam(1592,1)
function OnEvent_1592_2(proxy,param)
	print("OnEvent_1592_2 begin");
	tyo_play_anime_id = 7003;
	proxy:Warp( HiryuOsa_b4_evid , 2700 );--通路側の領域にワープ
	proxy:ForcePlayAnimationStayCancel( HiryuOsa_b4_evid, tyo_play_anime_id );
	
	if	param:IsNetMessage() == true then
		print("OnEvent_1592_2 return end");
		return;
	end
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 1592, HiryuOsa_b4_evid, tyo_play_anime_id, "OnEvent_1590_anime_end", once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_1592_2 end");
end





------------------------------------------------------------------------------------------------------
--■1593■領域Cをブレス
------------------------------------------------------------------------------------------------------
--LuaCallParam(1593,1)
function OnEvent_1593_1(proxy,param)
	print("OnEvent_1593_1 begin");
	tyo_play_anime_id = 7001;
	proxy:Warp( HiryuOsa_b4_evid , 2700 );--通路側の領域にワープ
	proxy:ForcePlayAnimationStayCancel( HiryuOsa_b4_evid, tyo_play_anime_id );
	
	if	param:IsNetMessage() == true then
		print("OnEvent_1593 return end");
		return;
	end
	--[[
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 1593, HiryuOsa_b4_evid, tyo_play_anime_id, "OnEvent_1593_1_1", once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	]]
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		local Delay = GetDelay_HiryuOsa(proxy);
		proxy:OnKeyTime2( 1593, "OnEvent_1593_1_2", Delay, 0, 2, once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_1593_1 end");
end


function OnEvent_1593_1_1(proxy,param)
	print("OnEvent_1593_1_1 begin");
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		local Delay = GetDelay_HiryuOsa(proxy);
		proxy:OnKeyTime2( 1593, "OnEvent_1593_1_2", Delay, 0, 2, once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_1593_1_1 end");
end

function OnEvent_1593_1_2(proxy,param)
	print("OnEvent_1593_1_2 begin");
	
	--OnEvent_1593_2
	proxy:LuaCallStart(1593,2);
	
	print("OnEvent_1593_1_2 end");
end


--LuaCallParam(1593,1)
function OnEvent_1593_2(proxy,param)
	print("OnEvent_1593_2 begin");
	tyo_play_anime_id = 7004;
	proxy:Warp( HiryuOsa_b4_evid , 2700 );--通路側の領域にワープ
	proxy:ForcePlayAnimationStayCancel( HiryuOsa_b4_evid, tyo_play_anime_id );
	
	if	param:IsNetMessage() == true then
		print("OnEvent_1593_2 return end");
		return;
	end
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 1593, HiryuOsa_b4_evid, tyo_play_anime_id, "OnEvent_1590_anime_end", once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_1593_2 end");
end



------------------------------------------------------------------------------------------------------
--■1594■広場Aにブレス
------------------------------------------------------------------------------------------------------
--LuaCallParam(1594,1)
function OnEvent_1594_1(proxy,param)
	print("OnEvent_1594_1 begin");
	tyo_play_anime_id = 7007;
	proxy:Warp( HiryuOsa_b4_evid , 2701 );--通路側の領域にワープ
	proxy:ForcePlayAnimationStayCancel( HiryuOsa_b4_evid, tyo_play_anime_id );
	
	if	param:IsNetMessage() == true then
		print("OnEvent_1594 return end");
		return;
	end
--[[	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 1594, HiryuOsa_b4_evid, tyo_play_anime_id, "OnEvent_1594_1_1", once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
]]	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		local Delay = GetDelay_HiryuOsa(proxy);
		proxy:OnKeyTime2( 1594, "OnEvent_1594_1_2", Delay, 0, 2, once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	print("OnEvent_1594_1 end");
end


function OnEvent_1594_1_1(proxy,param)
	print("OnEvent_1594_1_1 begin");
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		local Delay = GetDelay_HiryuOsa(proxy);
		proxy:OnKeyTime2( 1594, "OnEvent_1594_1_2", Delay, 0, 2, once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_1594_1_1 end");
end

function OnEvent_1594_1_2(proxy,param)
	print("OnEvent_1594_1_2 begin");
	
	--OnEvent_1594_2
	proxy:LuaCallStart(1594,2);
	
	print("OnEvent_1594_1_2 end");
end


--LuaCallParam(1594,2)
function OnEvent_1594_2(proxy,param)
	print("OnEvent_1594_2 begin");
	tyo_play_anime_id = 7005;
	proxy:Warp( HiryuOsa_b4_evid , 2701 );--通路側の領域にワープ
	proxy:ForcePlayAnimationStayCancel( HiryuOsa_b4_evid, tyo_play_anime_id );
	
	if	param:IsNetMessage() == true then
		print("OnEvent_1594_2 return end");
		return;
	end
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 1594, HiryuOsa_b4_evid, tyo_play_anime_id, "OnEvent_1590_anime_end", once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_1594_2 end");
end



------------------------------------------------------------------------------------------------------
--■1660■広場Bにブレス
------------------------------------------------------------------------------------------------------
--LuaCallParam(1660,1)
function OnEvent_1660_1(proxy,param)
	print("OnEvent_1660_1 begin");
	tyo_play_anime_id = 7007;
	proxy:Warp( HiryuOsa_b4_evid , 2701 );--通路側の領域にワープ
	proxy:ForcePlayAnimationStayCancel( HiryuOsa_b4_evid, tyo_play_anime_id );
	
	if	param:IsNetMessage() == true then
		print("OnEvent_1660 return end");
		return;
	end
--[[	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 1660, HiryuOsa_b4_evid, tyo_play_anime_id, "OnEvent_1660_1_1", once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
]]	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		local Delay = GetDelay_HiryuOsa(proxy);
		proxy:OnKeyTime2( 1660, "OnEvent_1660_1_2", Delay, 0, 2, once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	print("OnEvent_1660_1 end");
end


function OnEvent_1660_1_1(proxy,param)
	print("OnEvent_1660_1_1 begin");
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		local Delay = GetDelay_HiryuOsa(proxy);
		proxy:OnKeyTime2( 1660, "OnEvent_1660_1_2", Delay, 0, 2, once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_1660_1_1 end");
end

function OnEvent_1660_1_2(proxy,param)
	print("OnEvent_1660_1_2 begin");
	
	--OnEvent_1660_2
	proxy:LuaCallStart(1660,2);
	
	print("OnEvent_1660_1_2 end");
end


--LuaCallParam(1660,2)
function OnEvent_1660_2(proxy,param)
	print("OnEvent_1660_2 begin");
	tyo_play_anime_id = 7017;
	proxy:Warp( HiryuOsa_b4_evid , 2701 );--通路側の領域にワープ
	proxy:ForcePlayAnimationStayCancel( HiryuOsa_b4_evid, tyo_play_anime_id );
	
	if	param:IsNetMessage() == true then
		print("OnEvent_1660_2 return end");
		return;
	end
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 1660, HiryuOsa_b4_evid, tyo_play_anime_id, "OnEvent_1590_anime_end", once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_1660_2 end");
end





------------------------------------------------------------------------------------------------------
--■1661■広場Cにブレス
------------------------------------------------------------------------------------------------------
--LuaCallParam(1661,1)
function OnEvent_1661_1(proxy,param)
	print("OnEvent_1661_1 begin");
	tyo_play_anime_id = 7007;
	proxy:Warp( HiryuOsa_b4_evid , 2701 );--通路側の領域にワープ
	proxy:ForcePlayAnimationStayCancel( HiryuOsa_b4_evid, tyo_play_anime_id );
	
	if	param:IsNetMessage() == true then
		print("OnEvent_1661 return end");
		return;
	end
--[[	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 1661, HiryuOsa_b4_evid, tyo_play_anime_id, "OnEvent_1661_1_1", once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
]]	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		local Delay = GetDelay_HiryuOsa(proxy);
		proxy:OnKeyTime2( 1661, "OnEvent_1661_1_2", Delay, 0, 2, once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_1661_1 end");
end


function OnEvent_1661_1_1(proxy,param)
	print("OnEvent_1661_1_1 begin");
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		local Delay = GetDelay_HiryuOsa(proxy);
		proxy:OnKeyTime2( 1661, "OnEvent_1661_1_2", Delay, 0, 2, once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_1661_1_1 end");
end

function OnEvent_1661_1_2(proxy,param)
	print("OnEvent_1661_1_2 begin");
	
	--OnEvent_1661_2
	proxy:LuaCallStart(1661,2);
	
	print("OnEvent_1661_1_2 end");
end


--LuaCallParam(1661,2)
function OnEvent_1661_2(proxy,param)
	print("OnEvent_1661_2 begin");
	tyo_play_anime_id = 7019;
	proxy:Warp( HiryuOsa_b4_evid , 2701 );--通路側の領域にワープ
	proxy:ForcePlayAnimationStayCancel( HiryuOsa_b4_evid, tyo_play_anime_id );
	
	if	param:IsNetMessage() == true then
		print("OnEvent_1661_2 return end");
		return;
	end
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 1661, HiryuOsa_b4_evid, tyo_play_anime_id, "OnEvent_1590_anime_end", once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_1661_2 end");
end




------------------------------------------------------------------------------------------------------
--■1662■広場警戒ループ
------------------------------------------------------------------------------------------------------
Osa_WaitAnim_EndFlag_B = 0;
Osa_IsWaitAnimCondition_B = 0;
--LuaCallParam(1662,1)
function OnEvent_1662_1(proxy,param)
	print("OnEvent_1662_1 begin");
	--proxy:ForcePlayAnimationStayCancel( HiryuOsa_b4_evid, tyo_play_anime_id );
	proxy:Warp( HiryuOsa_b4_evid , 2701 );--通路側の領域にワープ
	if	tyo_play_anime_id ~= 7007 then
		tyo_play_anime_id = 7007;
		proxy:ForcePlayAnimationStayCancel( HiryuOsa_b4_evid, tyo_play_anime_id );
	end
	
	if	param:IsNetMessage() == true then
		print("OnEvent_1662_1 return end");
		return;
	end
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 1661, "OnEvent_1662_2", 1.0, 0, 2, once );
		if	Osa_IsWaitAnimCondition_B ~= 1 then
			proxy:OnChrAnimEnd( 1661, HiryuOsa_b4_evid, tyo_play_anime_id, "OnEvent_1662_3", once );
			Osa_IsWaitAnimCondition_B = 1;
		end
		Osa_WaitAnim_EndFlag_B = 0;
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_1662_1 end");
end

--秒数経過で判定を抜ける時
function OnEvent_1662_2(proxy,param)
	print("OnEvent_1662_2 begin");
	if	Osa_WaitAnim_EndFlag_B == 0 then
		Osa_WaitAnim_EndFlag_B = 1;
		OnEvent_1590_anime_end(proxy,param);
	end
	print("OnEvent_1662_2 end");
end

--アニメ終了で判定を抜ける時
function OnEvent_1662_3(proxy,param)
	print("OnEvent_1662_3 begin");
	if	Osa_WaitAnim_EndFlag_B == 0 then
		Osa_WaitAnim_EndFlag_B = 2;
		proxy:LuaCallStartPlus( 1590, 10, tyo_play_anime_id );
		OnEvent_1590_anime_end(proxy,param);
	end
	Osa_IsWaitAnimCondition_B = 0;
	print("OnEvent_1662_3 end");
end










------------------------------------------------------------------------------------------------------
--■1595■飛竜の長が死ぬ(通路版)
------------------------------------------------------------------------------------------------------
--LuaCallParam(1595,1)
function OnEvent_1595_1(proxy,param)
	print("OnEvent_1595_1 begin");
	tyo_play_anime_id = 7006;
	proxy:Warp( HiryuOsa_b4_evid , 2700 );--通路側の領域にワープ
	proxy:ForcePlayAnimation( HiryuOsa_b4_evid, tyo_play_anime_id );
	
	
	
	if	param:IsNetMessage() == true then
		print("OnEvent_1595_1 return end");
		return;
	end
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 1595, HiryuOsa_b4_evid, tyo_play_anime_id, "OnEvent_1595_2", once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	
	print("OnEvent_1595_1 end");
end


function OnEvent_1595_2(proxy,param)
	print("OnEvent_1595_2 begin");
	
	SetNpcStateFlag(proxy, param, tyo_flag_list, TYO_STATE_DEAD );
	
	--飛竜の長がちゃんと死んでいたら、トロフィーアンロック
	if	proxy:IsCompleteEvent( 1770 ) == true then
		HiryuOsaDead(proxy,param);
	end
	
	--OnEvent_1590_syncroInvalid
	proxy:LuaCallStartPlus( 1590, 2, HiryuOsa_b4_evid );
	
	print("OnEvent_1595_2 end");
end



------------------------------------------------------------------------------------------------------
--■1596■飛竜の長が死ぬ(ゲート前版)
------------------------------------------------------------------------------------------------------
--LuaCallParam(1596,1)
function OnEvent_1596_1(proxy,param)
	print("OnEvent_1596_1 begin");
	tyo_play_anime_id = 7010;
	proxy:Warp( HiryuOsa_b4_evid , 2701 );--通路側の領域にワープ
	proxy:ForcePlayAnimation( HiryuOsa_b4_evid, tyo_play_anime_id );
	
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 1596, HiryuOsa_b4_evid, tyo_play_anime_id, "OnEvent_1596_2", once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_1596_1 end");
end


function OnEvent_1596_2(proxy,param)
	print("OnEvent_1596_2 begin");
	
	--飛竜の長がちゃんと死んでいたら、トロフィーアンロック
	if	proxy:IsCompleteEvent( 1770 ) == true then
		HiryuOsaDead(proxy,param);
	end
	
	--OnEvent_1590_syncroInvalid
	proxy:LuaCallStartPlus( 1590, 2, HiryuOsa_b4_evid );
	
	print("OnEvent_1596_2 end");
end











------------------------------------------------------------------------------------------------------
--■1597■飛竜の長が移動(通路→ゲート前)
------------------------------------------------------------------------------------------------------
--LuaCallParam(1597,1)
function OnEvent_1597_1(proxy,param)
	print("OnEvent_1597_1 begin");
	tyo_play_anime_id = 7008;
	proxy:Warp( HiryuOsa_b4_evid , 2700 );--通路側の領域にワープ
	proxy:ForcePlayAnimationStayCancel( HiryuOsa_b4_evid, tyo_play_anime_id );
	SetNpcStateFlag(proxy, param, tyo_flag_list, TYO_STATE_WARNING_GATE );
	
	if	param:IsNetMessage() == true then
		print("OnEvent_1597_1 return end");
		return;
	end
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 1597, HiryuOsa_b4_evid, tyo_play_anime_id, "OnEvent_1590_anime_end", once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_1597_1 end");
end


------------------------------------------------------------------------------------------------------
--■1598■飛竜の長が移動(ゲート前→通路)
------------------------------------------------------------------------------------------------------
--LuaCallParam(1598,1)
function OnEvent_1598_1(proxy,param)
	print("OnEvent_1598_1 begin");
	tyo_play_anime_id = 7009;
	proxy:Warp( HiryuOsa_b4_evid , 2701 );--通路側の領域にワープ
	proxy:ForcePlayAnimationStayCancel( HiryuOsa_b4_evid, tyo_play_anime_id );
	SetNpcStateFlag(proxy, param, tyo_flag_list, TYO_STATE_WARNING_AISLE );
	
	if	param:IsNetMessage() == true then
		print("OnEvent_1598_1 return end");
		return;
	end
	
	proxy:RepeatMessage_begin();
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( 1598, HiryuOsa_b4_evid, tyo_play_anime_id, "OnEvent_1590_anime_end", once );
	proxy:NotNetMessage_end();
	proxy:RepeatMessage_end();
	
	print("OnEvent_1598_1 end");
end



--LuaCallParam(1590,2)
function OnEvent_1590_syncroInvalid(proxy,param)
	print("OnEvent_1590_syncroInvalid begin");
	
	local evid = param:GetParam3()
	InvalidCharactor( proxy, evid );
	
	print("OnEvent_1590_syncroInvalid end");
end



function Osa_ForceSynchroAnime(proxy,param)
	print("Osa_ForceSynchroAnime begin");
	local animId = param:GetParam3();
	tyo_play_anime_id = animId;
	proxy:ForcePlayAnimationStayCancel( HiryuOsa_b4_evid, tyo_play_anime_id );
	print("Osa_ForceSynchroAnime end");
end


--------------------------------------------------------------------------------------
--■1770■飛竜の長が死ぬ■
--------------------------------------------------------------------------------------

--■1770■飛竜の長が死ぬ■(HP監視)
function OnEvent_1770(proxy, param)
	print("OnEvent_1770 begin");

	proxy:SetEventFlag( 1770 , 1 );--HP監視フラグON
	
	print("OnEvent_1770 end");
end



--------------------------------------------------------------------------------------
--■1635■エレベータが昇る■
--------------------------------------------------------------------------------------

--■1635■エレベータが昇る■
function OnEvent_1635(proxy, param)
	print("OnEvent_1635 begin");

	--アニメ再生中は発動しない
	if	proxy:IsCompleteEvent( 1631 ) == true then
		--発動者だけインフォ
		if param:IsNetMessage() == false then
			--扉が開かない場合のメッセージを表示
			--proxy:InfomationMenu( INFOMENU_TYPE_SIMPLE, 0, MSG_CATEGORY_EVENT, 10010170, 1);
			--proxy:ShowGenDialog(10010170,1,1,true);
			proxy:RepeatMessage_begin();
			proxy:NotNetMessage_begin();
				proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010170, 0, 6, -1, GEN_DIALOG_DIST, once );
			proxy:NotNetMessage_end();
			proxy:RepeatMessage_end();
		end		
		print("OnEvent_1635 return end");
		return;
	end	
	
	ElevatorEvent(proxy,param);	
	
	print("OnEvent_1635 end");
end

function OnEvent_1633(proxy,param)
	print("OnEvent_1633")
	--アニメ再生中は発動しない
	if	proxy:IsCompleteEvent( 1631 ) == true then
--~ 		--発動者だけインフォ
--~ 		if param:IsNetMessage() == false then
--~ 			--扉が開かない場合のメッセージを表示
--~ 			--proxy:InfomationMenu( INFOMENU_TYPE_SIMPLE, 0, MSG_CATEGORY_EVENT, 10010170, 1);
--~ 			--proxy:ShowGenDialog(10010170,1,1,true);
--~ 			proxy:RepeatMessage_begin();
--~ 			proxy:NotNetMessage_begin();
--~ 				proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010170, 0, 6, -1, GEN_DIALOG_DIST, once );
--~ 			proxy:NotNetMessage_end();
--~ 			proxy:RepeatMessage_end();
--~ 		end		
		print("OnEvent_1633 return end");
		return;
	end	
	
	ElevatorEvent(proxy,param);
	print("OnEvent_1633 end")
end

function ElevatorEvent(proxy,param)
	proxy:DeleteEvent( 1633 );
	--上にある状態なら降り、下にある状態なら昇りアニメ再生
	if proxy:IsClient() == false then
		if	proxy:IsCompleteEvent( 1630 ) == false then
			proxy:LuaCallStart( 1635 , 5 );
			--proxy:ForcePlayAnimation( 1620 , 1 );--エレベータが昇るアニメ再生
		else
			proxy:LuaCallStart( 1635 , 6 );
			--proxy:ForcePlayAnimation( 1620 , 2 );--エレベータが降りるアニメ再生
			proxy:DeleteEvent(1632);
		end
	end
	
	--プレイヤのアニメは無し
	
	local evId_list   = {1650,1651,1652,1653,1654,1655,1660,1661,1662};
	local animId_list = {	2,	 2,	  2,   2,   2,   2,   0,   0,   0};
	local obj_num = table.getn(evId_list);
	for index = 1, obj_num, 1 do
		proxy:PlayAnimation( evId_list[index], animId_list[index] );
	end

	--発動者だけがアニメ終了を監視(必ずクライアントの世界でエレベータオブジェクトが読み込まれているわけではないので)
	if	proxy:IsClient() == false then
		proxy:NotNetMessage_begin();
			proxy:RepeatMessage_begin();
				if	proxy:IsCompleteEvent( 1630 ) == false then
					--▼1635▼エレベータが昇るアニメ終了▼
					proxy:OnCharacterAnimEnd( 1635 , 1620 , 1 , "OnEvent_1635_anime_end" , once );
					proxy:LuaCallStart( 1635, 2 );--この時点で上下は確定
				else
					--▼1635▼エレベータが降りるアニメ終了▼
					proxy:OnCharacterAnimEnd( 1635 , 1620 , 2 , "OnEvent_1635_anime_end" , once );
					proxy:LuaCallStart( 1635, 2 );--この時点で上下は確定
				end
			proxy:RepeatMessage_end();
		proxy:NotNetMessage_end();
	end
end

--▲1635_anime_end▲エレベータが昇るアニメ終了▲
function OnEvent_1635_anime_end(proxy, param)
	print("OnEvent_1635_anime_end begin");
	
	--▼エレベータが降りる監視追加▼
	--proxy:OnPlayerActionInRegion( 1636 , 2651 , "OnEvent_1636" , HELPID_START , everytime );
	--proxy:OnDistanceActionPlus( 1636 , LOCAL_PLAYER, 1620, "OnEvent_1635" , 1, HELPID_START , 0, 100, 0.0, 0.0, 0.0, everytime );--昇る用
	
	
	--フラグ同期ルアーコール()--アニメ終了フラグ同期
	proxy:LuaCallStart( 1635, 4 );
	
	if proxy:IsCompleteEvent( 1630 ) == true then
		proxy:NotNetMessage_begin();
		proxy:RepeatMessage_begin();
			proxy:OnKeyTime2( 1632 , "OnEvent_1632",0.5,0,1,once);
		proxy:RepeatMessage_end();
		proxy:NotNetMessage_end();
	end
	
	print("OnEvent_1635_anime_end end");
end

function OnEvent_1635_flag(proxy,param)
	print("OnEvent_1635_flag begin");
	
	if	proxy:IsCompleteEvent( 1630 ) == true then
		proxy:SetEventFlag( 1630, false );
	else
		proxy:SetEventFlag( 1630, true );
	end	
	print("OnEvent_1635_flag end");
end

function OnEvent_1635_animeflag(proxy,param)
	print("OnEvent_1635_animeflag begin");
	--アニメ中フラグOFF
	proxy:SetEventFlag( 1631 , false );
	print("OnEvent_1635_animeflag end");
end
 
--[[
function OnEvent_1635_Out(proxy,param)
	print("OnEvent_1635_Out begin");
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 1635, "OnEvent_1635_Out_1", 0.0, 0, 2, once );
	proxy:NotNetMessage_end();
	print("OnEvent_1635_Out end");
end

--その瞬間だとOnNetRegionのフラグ設定が有効にならないので、1フレーム遅らせる
function OnEvent_1635_Out_1(proxy,param)
	print("OnEvent_1635_Out_1 begin");
	--全員がエレベータ領域からいなくなっていたらエレベータを動かす
	if	proxy:IsCompleteEvent( 1636 ) == false then
		--エレベータが上にある状態じゃないと発動させない(必要ないかも)
		if	proxy:IsCompleteEvent( 1630 ) == true then
			--→OnEvent_1635
			proxy:LuaCallStart( 1635, 3 );
		end
	end
	print("OnEvent_1635_Out_1 end");
end
]]


--上に上がりきった時の監視
function OnEvent_1632( proxy,param)
	print("OnEvent_1632 begin");
	proxy:NotNetMessage_begin();
	proxy:RepeatMessage_begin();
		proxy:OnRegistFunc( 1632 , "Check_1632_1","OnEvent_1632_1",1,once);
		
		--領域にずっと居ても一定時間で降りるように
		proxy:OnKeyTime2( 1633 , "OnEvent_1633",ElevatorTimer,0,100,once);
	proxy:RepeatMessage_end();
	proxy:NotNetMessage_end();
	print("OnEvent_1632 end");
end

--領域に誰も居ないか？
function Check_1632_1(proxy,param)
	if proxy:IsCompleteEvent( 1636 ) == true then
		return false;
	end
	return true;
end

--領域に誰も居ないのでエレベーターを下ろす
function OnEvent_1632_1(proxy,param)
	print("OnEvent_1632_1 begin");
	if proxy:IsClient() == false then
		proxy:LuaCallStart( 1635, 3 );
	end
	print("OnEvent_1632_1 end");
end

function OnEvent_1635_UpAnime(proxy,param)
	if proxy:IsCompleteEvent( 1631 ) == false then
		proxy:ForcePlayAnimation( 1620 , 1 );--エレベータが昇るアニメ再生
		--アニメ中フラグON
		proxy:SetEventFlag( 1631 , true );
	end
end

function OnEvent_1635_DownAnime(proxy,param)
	if proxy:IsCompleteEvent( 1631 ) == false then
		proxy:ForcePlayAnimation( 1620 , 2 );--エレベータが降りるアニメ再生
		--アニメ中フラグON
		proxy:SetEventFlag( 1631 , true );
	end
end

--[[
--------------------------------------------------------------------------------------
--■1636■エレベータが降りる■
--------------------------------------------------------------------------------------

--■1636■エレベータが降りる■
function OnEvent_1636(proxy, param)
	print("OnEvent_1636 begin");
		
	--エレベータが上にあるときだけ反応
	if proxy:IsCompleteEvent( 1631 ) == true then
	
		proxy:PlayAnimation( 1620 , 2 );--エレベータが降りるアニメ再生
	
		local evId_list   = {1650,1651,1652,1653,1654,1655,1660,1661,1662};
		local animId_list = {	2,	 2,	  2,   2,   2,   2,   0,   0,   0};
		local obj_num = table.getn(evId_list);
		for index = 1, obj_num, 1 do
			proxy:PlayAnimation( evId_list[index], animId_list[index] );
		end
		
		proxy:NotNetMessage_begin();
			--▼1636▼エレベータが降りるアニメ終了▼
			proxy:OnCharacterAnimEnd( 1636 , 1620 , 2 , "OnEvent_1636_anime_end" , once );
		proxy:NotNetMessage_end();
		
		--エレベータが上にある状態にフラグを合わせる
		proxy:SetEventFlag( 1630 , true ); --下にある
		proxy:SetEventFlag( 1631 , false );--上にない
	end		

	print("OnEvent_1636 end");
end

--▲1636_anime_end▲エレベータが降りるアニメ終了▲
function OnEvent_1636_anime_end(proxy, param)
	print("OnEvent_1636_anime_end begin");

	proxy:DeleteEvent( 1636 );--エレベータが降りるの監視削除
	--▼エレベータが昇る監視追加▼
	proxy:OnPlayerActionInRegion( 1635 , 2650 , "OnEvent_1635" , HELPID_START , everytime );
	--proxy:OnDistanceActionPlus( 1635 , LOCAL_PLAYER, 1620, "OnEvent_1635" , 1, HELPID_START , 0, 100, 0.0, 0.0, 0.0, everytime );--昇る用
	
	print("OnEvent_1636_anime_end end");
end

]]

--------------------------------------------------------------------------------------
--■4503■ソウル入手■
--------------------------------------------------------------------------------------

function OnEvent_4503(proxy, param)
	print("OnEvent_4503 begin");
	
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_PICK ) == true then--新しいアニメ 
		print("OnEvent_4503 end");
		return true;
	end
	
	proxy:NotNetMessage_begin();
		--0.0秒後にアイテム取得イベントを発行
		proxy:OnKeyTime2( 4503, "OnEvent_4503_1", 0.0, 0, 0, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_4103 end");
end


--■4503_1■アイテム取得■
function OnEvent_4503_1(proxy, param)
	print("OnEvent_4503_1 begin");

	--アイテム取得関数--パラメータ10101参照
	proxy:GetRateItem(10101);	
	proxy:GetRateItem(10182);
	proxy:GetRateItem(10183);
	proxy:GetRateItem(10184);
	proxy:GetRateItem(10185);
	
	--アイテムを取得済み
	proxy:SetEventFlag( 4503, 1 );
	
	--宝箱シェーダーは消えません
	--proxy:TreasureDispModeChange( 1979 , false );

	--SFXが消える
	proxy:InvalidSfx( 1640, true );--SFX 無効化
	--proxy:InvalidSfx( 1641, true );--光の粒子
		
	if proxy:IsCompleteEvent( 4510 ) == false then
		proxy:NotNetMessage_begin();
			--瞬間で表示するとメニューが先に出るので待つ
			proxy:OnKeyTime2( 4510 , "OnEvent_4510_wait",0.5 , 0 , 1, once);			
		proxy:NotNetMessage_end();
	else
		--▼要石でワープ用の監視を追加▼
		proxy:OnDistanceActionAttribute( 4505 , LOCAL_PLAYER , 1979 , "OnEvent_4505" , WarpGimmickDist_A , HELPID_GO_TO_SEKITYUU , 0 , 180 , ATTR_NOSESSION , everytime );
	end		

	print("OnEvent_4503_1 end");
end


--アイテム取得後のウェイト
function OnEvent_4510_wait(proxy,param)
	print("OnEvent_4510_wait begin");
	proxy:NotNetMessage_begin();
		--インフォメニューが消えるのを待ちたい
		proxy:OnRegistFunc( 4510 , "Check_4510" , "OnEvent_4510" , 1 , ocne);
	proxy:NotNetMessage_end();
	print("OnEvent_4510_wait end");
end	
--インフォ待ち
function Check_4510(proxy)
	if proxy:IsShowMenu_InfoMenu() == true then
		return false;
	end
	return true;
end

--会話発動表示
function OnEvent_4510(proxy,param)
	print("OnEvent_4510 begin");
	proxy:NotNetMessage_begin();
		--会話発動
		proxy:CloseMenu();
		proxy:TalkNextPage( 4510 );
		proxy:SetEventFlag( 4510 , true );
	proxy:NotNetMessage_end();
	--▼要石でワープ用の監視を追加▼	
	proxy:OnDistanceActionAttribute( 4505 , LOCAL_PLAYER , 1979 , "OnEvent_4505" , WarpGimmickDist_A , HELPID_GO_TO_SEKITYUU , 0 , 180 , ATTR_NOSESSION , everytime );
	print("OnEvent_4510 end");
end

--------------------------------------------------------------------------------------
--石柱にワープ(ボス倒した後用)■4505
--------------------------------------------------------------------------------------

--■4505■石柱にワープ■
function OnEvent_4505(proxy,param)	

	if proxy:IsCompleteEvent( 4505 ) == true then
		return;
	end	

	print("OnEvent_4505 begin");
	
	proxy:RepeatMessage_begin();
		--▼4505_1▼選択メニューの監視▼
		proxy:OnSelectMenu(4505, "OnEvent_4505_0", 10010710, 0, 2, 1979, 2, once);			
	proxy:RepeatMessage_end();
	
	print("OnEvent_4505 end");
end

--▲4505_0▲選択メニューの監視▲
function OnEvent_4505_0(proxy, param)
	print("OnEvent_4505_0 begin");	
	
	if proxy:IsSession() == false then
		proxy:PlayAnimation( LOCAL_PLAYER , 8283 );--要石に触れるアニメを再生
		proxy:NoAnimeTurnCharactor( 10000 , 1979 ,TURNSKIP_ANGLE);
		
		proxy:NotNetMessage_begin();
			--▼要石に触れるアニメ再生終了▼
			proxy:OnChrAnimEnd( 4505 , LOCAL_PLAYER , 8283 , "OnEvent_4505_1" , once );
		proxy:NotNetMessage_end();
		
		proxy:SetEventFlag( 4505 , 1 );
	else
		proxy:RepeatMessage_begin();
		proxy:NotNetMessage_begin();
			proxy:OnSelectMenu( SYSTEM_GENDIALOG, "MenuClose", 10010720, 0, 6, 1983, GEN_DIALOG_DIST, once );
		proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();
	end
	
	print("OnEvent_4505_0 end");
end

--▲4505_1▲自世界に帰るアニメを再生終了▲
function OnEvent_4505_1(proxy,param)	
	print("OnEvent_4505_1 begin");
	
	proxy:PlayAnimation( 10000 , 8284 );--自世界に帰るアニメを再生
	--石柱へ戻ってきた判定のフラグを立てる
	proxy:SetEventFlag(8083, true);
	
	proxy:SetEventFlag( 4505 , 0 );	
	--完全回復要求
	proxy:RequestFullRecover();
	proxy:WarpNextStage( 1, 0, 0, 0, 1006 );
	
	print("OnEvent_4505_1 end");
end

--------------------------------------------------------------------------------------
--ビヨルングルムが敵対■1712
--------------------------------------------------------------------------------------
--■1712■ビヨルングルムが敵対
function OnEvent_1711(proxy,param)
	print("OnEvent_1711 begin");
	
	if proxy:IsCompleteEvent(BIYO_STATE_BATTLE_FLY_DRAGON) == true then
		SetNpcStateFlag( proxy , param , biyo_flag_list , BIYO_STATE_HOSTILE_IN_GATE_FRONT );
		proxy:SetEventCommand( 698 , 51 );--EzStateに制御番号(立ち上がる)を渡す
		proxy:EnableLogic( 698, true );--ビヨロジックON
		proxy:SetTeamType( 698, TEAM_TYPE_AngryFriend );
		proxy:EraseEventSpecialEffect_2(698,5064);
		proxy:SetEventFlag( 1711, true );
	end
	
	print("OnEvent_1711 end");
end

--■1712■ビヨルングルム死亡
function OnEvent_1712(proxy,param)
	print("OnEvent_1712 begin");
	
	SetNpcStateFlag( proxy , param , biyo_flag_list , BIYO_STATE_DEAD );
	proxy:SetEventFlag( 1712, true );
	
	print("OnEvent_1712 end");
end


--■1717■ビヨルングルムが寝る
function OnEvent_1717(proxy,param)
	print("OnEvent_1717 begin");
	
	proxy:EnableLogic( 698, false );--ビヨロジックOFF
	proxy:SetTeamType( 698 , TEAM_TYPE_Friend );
	proxy:SetEventCommand( 698, 60 );--EzStateに制御番号(寝る)を渡す
	
	proxy:SetEventFlag( 1717, true );
	print("OnEvent_1717 end");
end


--■1700■レンドル王子　死亡する
function OnEvent_1700(proxy,param)
	print("OnEvent_1700 begin");
	
	--もういない状態のときに死んでも、状態は切り替えない
	if	proxy:IsCompleteEvent( RENDOL_STATE_ERASE ) == true then
		return;
	end
	
	SetNpcStateFlag( proxy, param, rendol_flag_list, RENDOL_STATE_DEAD );
	RendolCheck(proxy,param);
	--死亡でRendolCheckする場合、その瞬間に消えてしまうので、
	--距離を見て再度有効にするか決める
	if	proxy:IsDistance( LOCAL_PLAYER, 626, 20 ) == true then
		ValidCharactor( proxy, 626 );
	end
	proxy:SetEventFlag( 1700, true );

	print("OnEvent_1700 end");
end

--■1702■レンドル王子　敵対する
function OnEvent_1702(proxy,param)
	print("OnEvent_1702 begin");
	SetNpcStateFlag( proxy, param, rendol_flag_list, RENDOL_STATE_HOSTILE_4_LIFT_FRONT );
		proxy:SetTeamType( 626, TEAM_TYPE_AngryFriend );
	
	proxy:SetEventFlag( 1702, true );
	
	print("OnEvent_1702 end");
end



--■11790■レンドル王子　会話からアイテム取得
function OnEvent_11790(proxy,param)
	print("OnEvent_11790 begin");
	if proxy:IsCompleteEvent( 11790 ) == true then
		return;
	end
	
	if proxy:IsClient() == false then
		proxy:GetRateItem(10190);
	end
	proxy:SetHp( 626, 0.0 );
	proxy:SetEventFlag( 11790, true );
	
	SetNpcStateFlag( proxy, param, rendol_flag_list, RENDOL_STATE_ERASE );
	RendolCheck(proxy,param);
	--死亡でRendolCheckする場合、その瞬間に消えてしまうので、
	--距離を見て再度有効にするか決める
	if	proxy:IsDistance( LOCAL_PLAYER, 626, 20 ) == true then
		ValidCharactor( proxy, 626 );
	end
	
	print("ドラン手加減");
	proxy:SendEventRequest( 697 ,0, 1);
	proxy:SetEventSpecialEffect_2( 697 , 5042 );
	
	print("OnEvent_11790 end");
end


-----------------------------------------------------------------------------
--■1760■QWCソウルモンスター出現１■
-----------------------------------------------------------------------------
function OnEvent_1760(proxy,param)
	print("OnEvent_1760 begin");
	ValidCharactor( proxy, 510 );
	proxy:PlayAnimation( 510, 6100 );
	proxy:SetEventFlag( 1760, true );
	print("OnEvent_1760 end");
end


--飛竜の長死亡
function HiryuOsaDead(proxy,param)
	print("HiryuOsaDead begin");
	
	SetNpcStateFlag(proxy, param, tyo_flag_list, TYO_STATE_DEAD );
	
	--ホストのみ入手
	if	proxy:IsClient() == false then
		--▼トロフィー取得判定▼
		Lua_RequestUnlockTrophy(proxy, 12);
		proxy:GetRateItem(10117);--アイテム入手
	end
	
	--王城１の長を消す
	InvalidCharactor(proxy,300);
	proxy:DeleteEvent(220);
	proxy:DeleteEvent(235);
	print("HiryuOsaDead end");
end

------------------------------------------------------------------------------------
--■1706■一定領域進入で王子が死ぬ■
------------------------------------------------------------------------------------
--■初期化時のイベント登録■--------------------------------------------------------
function RegistEvent_1706(proxy)
	if	proxy:IsCompleteEvent( 1706 ) == false then
		if proxy:IsClient() == false then
			proxy:NotNetMessage_begin();
				proxy:OnRegionIn( 1706, LOCAL_PLAYER, 2720, "OnEvent_1706", once );
			proxy:NotNetMessage_end();
		end
		proxy:LuaCall( 1706 , 0 , "OnEvent_1706_1",once);
	end	
end

function OnEvent_1706(proxy,param)
	print("OnEvent_1706 begin");
	--proxy:SetEventFlag( 15492, true );
	--proxy:SetEventFlag( 15493, true );
	--proxy:SetEventFlag( 15494, true );
	
	--死亡では無いなら
	if proxy:IsCompleteEvent( RENDOL_STATE_DEAD ) == false then		
		--もういない状態のときに殺しても、死んだ判定の方で死亡に移行しないようになっているので
		--ここで死んでもらいます。
		--proxy:SetHp( 626, 0.0 );
		--Lua_EventForceDead( proxy , 626 );
		--エレベーター前の状態の時のみ殺す
		if 	proxy:IsCompleteEvent( RENDOL_STATE_LIFT_FRONT ) == true or
			proxy:IsCompleteEvent( RENDOL_STATE_HOSTILE_4_LIFT_FRONT ) == true then
			SetNpcStateFlag( proxy, param, rendol_flag_list, RENDOL_STATE_ERASE );
			proxy:ForceDead( 626 );
		else
			SetNpcStateFlag( proxy, param, rendol_flag_list, RENDOL_STATE_ERASE );
		end
	end
	
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 1706 , "OnEvent_1706_wait",3.0,0,0,once);
	proxy:NotNetMessage_end();
	proxy:SetEventFlag( 1706 , true );
	print("OnEvent_1706 end");
end

--待ち時間
function OnEvent_1706_wait(proxy,param)
	print("OnEvent_1706_wait begin");
	proxy:LuaCallStart( 1706 , 0 );
	print("OnEvent_1706_wait end");
end

--レンドルブラック出現
function OnEvent_1706_1(proxy,param)
	--レンドル・ブラックが死んでない
	if proxy:IsCompleteEvent( 1640 ) == false then
		print("OnEvent_1706_1 begin");	
		ValidCharactor( proxy, 502 );
		proxy:PlayAnimation( 502 , 6100);
		print("OnEvent_1706_1 end");
	end
end



------------------------------------------------------------------------------------
--■1640■レンドル王子・ブラック死亡■
------------------------------------------------------------------------------------
--■初期化時のイベント登録■--------------------------------------------------------
function RegistEvent_1640(proxy)
	if	proxy:IsCompleteEvent( 1640 ) == false then
		proxy:OnCharacterDead( 1640, 502, "OnEvent_1640", once );
		if proxy:IsCompleteEvent( 1706 ) == false then
			InvalidCharactor( proxy, 502 );
		end
	else
		InvalidCharactor( proxy, 502 );
	end
end

function OnEvent_1640(proxy,param)
	print("OnEvent_1640 begin");
	proxy:SetEventFlag( 1640, true );
	print("OnEvent_1640 end");
end


--------------------------------------------------------------------------------------
--■飛竜の長の攻撃待ち時間を取得します。
--------------------------------------------------------------------------------------
function GetDelay_HiryuOsa(proxy)
	--ブレスA～Cで使う攻撃ディレイ用の時間
	local Delay_under	= HiryuOsa_AttackDelay_under * 100;
	local Delay_top		= HiryuOsa_AttackDelay_top * 100;
	local scale_dilay 	= proxy:GetRandom( Delay_under , Delay_top );--2～4秒
	local atack_dilay_time = scale_dilay / 100;--2～4秒
	return atack_dilay_time;
end


function OnEvent_1780(proxy,param)
	print("OnEvent_1780 begin");
	proxy:PlayAnimation( 512, 7000 );
	proxy:EnableLogic( 512, true );
	print("OnEvent_1780 end");
end


--■1670■飛竜の長のHPが75%以下■
function OnEvent_1670(proxy,param)
	print("OnEvent_1670 begin");
	proxy:SetEventFlag( 1670, true );
	print("OnEvent_1670 end");
end

--■1671■飛竜の長のHPが50%以下■
function OnEvent_1671(proxy,param)
	print("OnEvent_1671 begin");
	proxy:SetEventFlag( 1671, true );
	print("OnEvent_1671 end");
end




--■1790■飛竜の情報をビヨルングルムに教える
function Condition_1790(proxy,param)
	if	proxy:IsCompleteEvent( TYO_STATE_WARNING_AISLE )		== true then
		proxy:SendEventRequest( 698, 0, AI_EVENT_HIRYU_GATE );
	else
		proxy:SendEventRequest( 698, 0, AI_EVENT_None );
	end
end



-----------------------------------------------------------------------------
--■1680■結晶トカゲイベント5
-----------------------------------------------------------------------------
function OnEvent_1680(proxy,param)
	print("OnEvent_1680 begin");
	proxy:SetEventFlag( 1680, true);
	proxy:DeleteEvent( 1680 );
	print("OnEvent_1680 end");
end

-----------------------------------------------------------------------------
--■1682■結晶トカゲイベント6
-----------------------------------------------------------------------------
function OnEvent_1682(proxy,param)
	print("OnEvent_1682 begin");
	proxy:SetEventFlag( 1682, true);
	proxy:DeleteEvent( 1682 );
	print("OnEvent_1682 end");
end

-----------------------------------------------------------------------------
--■1684■結晶トカゲイベント7
-----------------------------------------------------------------------------
function OnEvent_1684(proxy,param)
	print("OnEvent_1684 begin");
	proxy:SetEventFlag( 1684, true);
	proxy:DeleteEvent( 1684 );
	print("OnEvent_1684 end");
end


-----------------------------------------------------------------------------
--■1690■三銃士１死んだ
-----------------------------------------------------------------------------
function OnEvent_1690(proxy,param)
	print("OnEvent_1690 begin");
	proxy:SetEventFlag( 1690 , true );
	print("OnEvent_1690 end");
end

-----------------------------------------------------------------------------
--■1691■三銃士2死んだ
-----------------------------------------------------------------------------
function OnEvent_1691(proxy,param)
	print("OnEvent_1691 begin");
	proxy:SetEventFlag( 1691 , true );
	print("OnEvent_1691 end");
end

-----------------------------------------------------------------------------
--■1692■三銃士3死んだ
-----------------------------------------------------------------------------
function OnEvent_1692(proxy,param)
	print("OnEvent_1692 begin");
	proxy:SetEventFlag( 1692 , true );
	print("OnEvent_1692 end");
end
