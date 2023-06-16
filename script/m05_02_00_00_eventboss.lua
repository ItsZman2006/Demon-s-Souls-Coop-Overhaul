
--ガル・ゴールドランの状態フラグ
GAL_STATE_LIVE		= 16430;
GAL_STATE_DEAD		= 16431;
gal_flag_list = {
	GAL_STATE_LIVE,
	GAL_STATE_DEAD
};


--------------------------------------------------------------------------------------
--イベント初期化■ボス固有のイベントを登録する際に使用してください
--------------------------------------------------------------------------------------
function EventBoss_Initialize_m05_02_00_00(proxy)
	print("EventBoss_Initialize_m05_02_00_00 begin");
	--ボス用アクションID範囲(5986～6015)
	proxy:NotNetMessage_begin();
	SingleReset( proxy , 5987 );
	proxy:OnRegistFunc( 5986, "Condition_5986", "dummy", 2, once);
	proxy:NotNetMessage_end();
	
	if	proxy:IsCompleteEvent( 5987 ) == false then
		proxy:OnRegionJustIn( 5987, LOCAL_PLAYER, 2500, "OnEvent_5987", once );
		--右上の崖の監視
		proxy:OnRegionJustIn( 5987, 10000, 2502, "OnEvent_5987", once);--右の崖の上の領域
		proxy:OnRegionJustIn( 5987, 651, 2500, "OnEvent_5987", once );
	end

	--クライアントで無いなら　シングル　or　ホスト
	if	proxy:IsClient() == false then
		proxy:RequestForceUpdateNetwork(460);		
		proxy:RequestForceUpdateNetwork(651);		
		proxy:RequestForceUpdateNetwork(824);		
	end
----------------------------------------------------------------------
--リーブラ関連
----------------------------------------------------------------------
--■1034■リーブラの最初の警告会話■
	if proxy:IsCompleteEvent(1034) == false then
		--会話登録
		proxy:RegistSimpleTalk(1034, 2510, 29000, TALK_ATTR_ALL);
		--領域監視追加
		proxy:OnRegionJustIn(1034, 10000, 2510, "OnEvent_1034", once);
	end
--■1036■リーブラ自害■
	proxy:LuaCall( 1036, 0, "OnEvent_1036", everytime );
	proxy:SetCompletelyNoMove(824,true);
	
--■1167■リーブラ死亡会話フラグ同期■
	proxy:LuaCall( 1167 , 0 ,"OnEvent_1167", everytime );
	
----------------------------------------------------------------------
--ガル・ゴールドラン関連
----------------------------------------------------------------------
	--ガルのデフォルト状態セット
	SetFirstNpcStateFlag( proxy, param, gal_flag_list, GAL_STATE_LIVE );
	if	proxy:IsCompleteEvent(1112) == true or	--ガル死んでる
		proxy:IsCompleteEvent(5889) == true or 	--要石調べている
		proxy:IsCompleteEvent(5889) == true then--リーブラ死んでる
		SetNpcStateFlag( proxy, param, gal_flag_list, GAL_STATE_DEAD );
	end
	
--■1115■イカ戦士用の会話フラグセット■
	SingleReset( proxy, 1115 );
	if proxy:IsCompleteEvent(1115) == false then
		--領域監視追加
		proxy:OnRegionJustIn(1115, 10000, 2512, "OnEvent_1115_0", once);--崖の上の領域監視		
	end

	if proxy:IsCompleteEvent(5893) == false then--不浄をクリアしていない
		--[[ノーマル・ゴールドラン処理]]
		if proxy:IsCompleteEvent(GAL_STATE_DEAD) == false then--死亡していない
			--■1112■ゴールドラン死亡監視■
			print("ゴールドラン出現");
			proxy:OnCharacterDead(1112, 651, "OnEvent_1112", once);--死亡監視追加
			
		else--死亡している
			if proxy:IsCompleteEvent( 15615 ) == false then
				--死体を再現する
				proxy:OpeningDeadPlus( 651 , true ,false ,false );
			else
				--■1113■ゴールドラン無効化（死亡）■
				print("ゴールドランは死亡しています");
				InvalidBackRead( proxy, 651 );
			end
		end
		--「ブラック・ゴールドラン処理」
		print("ブラック出現条件を満たしていません");
		InvalidBackRead( proxy, 460 );
		--ココでは黒の死体再現は要らない
		
	else--不浄をクリアしている
	--「ノーマル・ゴールドラン処理」
		--■1114■ゴールドラン無効化（不浄クリア）■
		print("ガル・ゴールドラン出現条件を満たしていない");
		if proxy:IsCompleteEvent( 15615 ) == false then
			--死体を再現する
			proxy:OpeningDeadPlus( 651 , true ,false ,false );
		else			
			InvalidBackRead( proxy, 651 );
		end
	--[[ブラック・ゴールドラン処理]]
		--SingleReset( proxy, 1110 );--シングル時にフラグリセット		
		if proxy:IsCompleteEvent(1110) == true or	--死亡している かつ
		   proxy:IsSuccessQWC(50140) == false then	--ＱＷＣを満たしていないならば
		   if 	proxy:IsCompleteEvent(1110) == true and 
				proxy:IsCompleteEvent( 15601 ) == false then
				--死体を再現する
				proxy:OpeningDeadPlus( 460 , true ,false ,false );
			else
				--■1111■ゴールドラン・ブラック無効■
				print("ブラック・ゴールドラン出現条件を満たしていません");
				InvalidBackRead( proxy, 460 );
			end
		else			
		--■1110■ゴールドラン・ブラック死亡監視追加■
			print("ブラック・ゴールドラン出現");
			proxy:OnCharacterDead(1110, 460, "OnEvent_1110", once);--死亡監視追加
		end
	end
	
	--■15601■ゴールドラン黒の死体を調べてない■
	if proxy:IsCompleteEvent( 15601 ) == false then
		proxy:AddCorpseEvent( 15601 , 460 );
		proxy:NotNetMessage_begin();
			proxy:LuaCall( 15601 ,0 , "OnEvent_15601",once );
		proxy:NotNetMessage_end();
	end
	
	--■15615■ゴールドランの死体を調べてない■
	if proxy:IsCompleteEvent( 15615 ) == false then
		proxy:AddCorpseEvent( 15615 , 651 );
		proxy:NotNetMessage_begin();
			proxy:LuaCall( 15615 , 0 , "OnEvent_15615",once );
		proxy:NotNetMessage_end();
	end
	
	--■1117■ガル再度敵対配信用■
	proxy:LuaCall( 1117 , 0 ,"OnEvent_1117_1",once);
	
	--■1170～1179■リーブラが攻撃を受けた■
	local eventId = {1170,1171,1172,1173,1174,1175,1176,1177,1178,1179};
	local num = table.getn(eventId);
	for index = 1, num ,1 do
		SingleReset( proxy , eventId[ index ] );		
	end
	if proxy:IsCompleteEvent( 1170 ) == false then
		proxy:OnSimpleDamage( 1170 , 824 , 10000 , "OnEvent_1170", once );
	else
		proxy:ChangeThink( 360 , 210004 );
		proxy:ChangeThink( 361 , 210004 );
		proxy:ChangeThink( 362 , 210004 );
		proxy:ChangeThink( 363 , 210004 );
		proxy:ChangeThink( 372 , 210004 );
		proxy:ChangeThink( 373 , 210004 );
		proxy:ChangeThink( 374 , 210004 );
		proxy:ChangeThink( 375 , 210004 );
		proxy:ChangeThink( 377 , 210004 );
		proxy:ChangeThink( 391 , 210004 );		
	end
	
	
	print("EventBoss_Initialize_m05_02_00_00 end");
end

--------------------------------------------------------------------------------------
--ボス用の初期化処理が必要なときに使用：固有情報の作成等
--------------------------------------------------------------------------------------
function BossInit(proxy,param)	
end


function Condition_5986(proxy,param)
	local chrId = 651;
	if	proxy:IsCompleteEvent( 5987 ) == true then
		proxy:SendEventRequest(chrId,0,1);
	else
		proxy:SendEventRequest(chrId,0,AI_EVENT_None);
	end
	return false;
end


----------------------------------------------------
--■1110■ゴールドラン・ブラック死亡監視追加■
----------------------------------------------------
function OnEvent_1110(proxy, param)
	print("OnEvent_1110 begin");
	proxy:SetEventFlag(1110, true);
	print("OnEvent_1110 end");
	
end

----------------------------------------------------
--■15601■ゴールドラン・ブラック死体を調べた■
----------------------------------------------------
function OnEvent_15601(proxy,param)
	print("OnEvent_15601 begin");
	proxy:SetEventFlag( 15601 ,true );
	print("OnEvent_15601 end");
end

-----------------------------------------------------------
--■1112■ゴールドラン死亡■
-----------------------------------------------------------
function OnEvent_1112(proxy, param)
	print("OnEvent_1112 begin");
	proxy:SetEventFlag( 1112, true );
	SetNpcStateFlag( proxy, param, gal_flag_list, GAL_STATE_DEAD );
	print("OnEvent_1112 end");
end

-----------------------------------------------------------
--■15615■ゴールドラン死体を調べた■
-----------------------------------------------------------
function OnEvent_15615(proxy,param)
	print("OnEvent_15615 begin");
	proxy:SetEventFlag( 15615 , true );
	print("OnEvent_15615 end");
end

----------------------------------------------------------------------
--■1115■崖から落ちたフラグセット
----------------------------------------------------------------------
function OnEvent_1115_0(proxy, param)
	print("崖の上に居る…");
	--領域監視追加
	proxy:OnRegionJustIn(1115, 10000, 2514, "OnEvent_1115_In", once);--崖の上の領域に入った
	proxy:OnRegionJustOut( 1115, 10000 , 2514 , "OnEvent_1115_Out",once);--領域から出た
end
function OnEvent_1115_In(proxy, param)
	print("崖から転落！！");
	proxy:SetEventFlag(1115, true);--崖から落ちたフラグをON
	--proxy:DeleteEvent( 1115 );--削除
end
function OnEvent_1115_Out(proxy, param)
	print("OnEvent_1115_Out");
	proxy:SetEventFlag(1115, false);--崖から落ちたフラグをOFF
	--proxy:DeleteEvent( 1115 );--削除
end

--------------------------------------------------------------------------------------
--■1034■リーブラ最初の警告会話■
--------------------------------------------------------------------------------------
function OnEvent_1034(proxy, param)
	print("OnEvent_1034 begin");
	--登録した会話を再生
	proxy:CloseMenu();
	proxy:TalkNextPage(1034);
	--フラグセット
	proxy:SetEventFlag(1034,true);
	
	print("OnEvent_1034 end");
end


--------------------------------------------------------------------------------------
--■1036■リーブラ自害■
--------------------------------------------------------------------------------------
function OnEvent_1036(proxy,param)
	print("OnEvent_1036 begin");
	proxy:OnKeyTime2( 1036, "OnEvent_1036_1", 100.0, 1, 2, once );
	proxy:OnCheckEzStateMessage( 1036, 824, "OnEvent_1036_2", 650 );
	print("OnEvent_1036 end");
end

function OnEvent_1036_1(proxy,param)
	--print("OnEvent_1036_1 begin");
	proxy:SetEventCommand( 824, 800 );
	--print("OnEvent_1036_1 end");
end

function OnEvent_1036_2(proxy,param)
	print("OnEvent_1036_2 begin");
	proxy:DeleteEvent( 1036 );
	print("OnEvent_1036_2 end");
end




function OnEvent_5987(proxy,param)
	print("OnEvent_5987 begin");
	proxy:SetEventFlag( 5987, true );
	proxy:DeleteEvent( 5987 );
	print("OnEvent_5987 end");
end

--■1117■やる気をなくしたガルを殴った■
function OnEvent_1117(proxy,param)
	print("OnEvent_1117 begin");
	proxy:LuaCallStart( 1117 , 0 );
	print("OnEvent_1117 end");
end

--■1117■ガルを殴ったイベントの配信用■
function OnEvent_1117_1(proxy,param)
	print("OnEvent_1117_1 begin");
	--proxy:SetSpStayAndDamageAnimId( 651,-1,-1);--一応回避
	proxy:SetEventCommand( 651 , 901 );
	proxy:EnableLogic( 651 , true );
	proxy:ResetThink( 651 );
	print("OnEvent_1117_1 end");
end

--リーブラがダメージを受けた
function OnEvent_1170(proxy,param)
	print("OnEvent_1170 begin");
	proxy:ChangeThink( 360 , 210004 );
	proxy:ChangeThink( 361 , 210004 );
	proxy:ChangeThink( 362 , 210004 );
	proxy:ChangeThink( 363 , 210004 );
	proxy:ChangeThink( 372 , 210004 );
	proxy:ChangeThink( 373 , 210004 );
	proxy:ChangeThink( 374 , 210004 );
	proxy:ChangeThink( 375 , 210004 );
	proxy:ChangeThink( 377 , 210004 );
	proxy:ChangeThink( 391 , 210004 );
	
	proxy:SetEventFlag( 1170 ,true );
	proxy:SetEventFlag( 1171 ,true );
	proxy:SetEventFlag( 1172 ,true );
	proxy:SetEventFlag( 1173 ,true );
	proxy:SetEventFlag( 1174 ,true );
	proxy:SetEventFlag( 1175 ,true );
	proxy:SetEventFlag( 1176 ,true );
	proxy:SetEventFlag( 1177 ,true );
	proxy:SetEventFlag( 1178 ,true );
	proxy:SetEventFlag( 1179 ,true );
	
	print("OnEvent_1170 end");
end

function OnEvent_1167(proxy,param)
	print("OnEvent_1167 begin");
	proxy:SetEventFlag( 1167 , true );
	print("OnEvent_1167 end");
end
