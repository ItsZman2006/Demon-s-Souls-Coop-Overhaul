
--------------------------------------------------------------------------------------
--マップ読み込み時に読まれる初期化処理■
--------------------------------------------------------------------------------------
function Initialize_m07_01_00_00(proxy)
print("Initialize_m07_01_00_00 begin");

--■1■浮かび上がる足場A■
	if proxy:IsCompleteEvent(1) ==false then
	--▼OBJ(1000)が破壊された時▼--
		proxy:OnObjectDestroy( 1, 1000, "OnEvent_1", once );
	else
		proxy:ReconstructBreak( 1000 , 1 );
	end
	
		
--■11■浮かび上がる足場B■
	if proxy:IsCompleteEvent(11) ==false then
	--▼OBJ(1001)が破壊された時▼--
		proxy:OnObjectDestroy( 11, 1001, "OnEvent_11", once );
		--proxy:OnPlayerDistanceInTarget( 11, 10000, 1006, "OnEvent_11", 3.0, once );
	else
		proxy:ReconstructBreak( 1001 , 1 );
	end


--■12■浮かび上がる足場C■
	if proxy:IsCompleteEvent(12) ==false then
	--▼ルアーコール▼--
		proxy:NotNetMessage_begin();
			proxy:LuaCall( 12, 1, "OnEvent_12", once );
		proxy:NotNetMessage_end();
	end
	
--[[ オブジェ(扉)がまだないので、コメントアウト

--■120■中ボス部屋への扉が開く■
	if proxy:IsCompleteEvent( 120 ) == false then
		proxy:OnDistanceActionPlus( 120, 10000, 1120, "OnEvent_120", DoorDist_A, HELPID_OPEN, 90, DoorAngle_A, -0.3, 0.0, 2.0, once );
	else
		proxy:EndAnimation( 1120, 1 );--扉が開くアニメを終了
	end
]]	
	

--■6656■中ボス死亡で何かが起こる■
	--▼OBJ(812)が死に、死亡アニメーションも再生し終わった時▼--
	if proxy:IsCompleteEvent(6656) ==false then
		proxy:OnCharacterDead( 6656, 812, "OnEvent_6656", once );
	else
		proxy:EndAnimation( 1004, 1 );--ダミーレバーアニメ
	end

	
--宝死体はイベント発動時に配信しない。アニメのみ別で同期させる。
proxy:NotNetMessage_begin();

--■13568■宝死体A■
	--▼PCがポイント(1005)に対して反応角度(ItemBoxAngle_A)、距離(ItemBoxDist_A)でアクションボタンを押す▼--
	if proxy:IsCompleteEvent(13568) ==false then
		proxy:OnDistanceAction( 13568, 10000, 1005, "OnEvent_13568", ItemBoxDist_A, HELPID_CHECK_GLOWING_CORPS, 0, ItemBoxAngle_A, once );		
		proxy:TreasureDispModeChange( 1005, true );
	end
	
--■13569■宝死体B■
	--▼PCがポイント(1006)に対して反応角度(ItemBoxAngle_A)、距離(ItemBoxDist_A)でアクションボタンを押す▼--
	if proxy:IsCompleteEvent(13569) ==false then
		proxy:OnDistanceAction( 13569, 10000, 1006, "OnEvent_13569", ItemBoxDist_A, HELPID_CHECK_GLOWING_CORPS, 0, ItemBoxAngle_A, once );		
		proxy:TreasureDispModeChange( 1006, true );
	end

proxy:NotNetMessage_end();
	
--■20-32■ノーマル燈台破壊で一部の敵が見えるようになる■
	
	first_action_id = 20;
	first_event_id  = 1007;
	dai_num         = 13;
	
	now_action_id   = first_action_id;
	now_event_id    = first_event_id;
	
	for i=1, dai_num, 1 do
		print( "add action_id " .. now_action_id );
		if proxy:IsCompleteEvent( now_action_id ) ==false then
			proxy:OnObjectDestroy( now_action_id, now_event_id, "OnEvent_"..now_action_id, once );
		else
			proxy:ReconstructBreak( now_event_id , 1 );
		end
		now_action_id = now_action_id + 1;
		now_event_id  = now_event_id  + 1;
	end
	
--■40-104■雑魚的の死亡監視■

	enemy_num_of_dai        = 3;
	enemy_num_offset_of_dai = 2; 	--予備
	dai_num                 = 13;
	enemy_num               = enemy_num_of_dai * dai_num;
	
	first_event_id          = 40;
	first_enemy_id          = 720;
	now_event_id            = first_event_id;
	now_enemy_id            = first_enemy_id;
	
	for i=1, dai_num, 1 do --蜀台の数だけ繰り返す
		for j=1, enemy_num_of_dai, 1 do --蜀台一つに対応する敵の数だけ繰り返す
			print("add enemy_id is " .. now_enemy_id );
			
			--敵一匹分の死亡監視イベント
			if proxy:IsCompleteEvent( now_event_id ) ==false then 
				proxy:OnCharacterDead( now_event_id, now_enemy_id, "OnEvent_"..now_event_id, once ); 
			end
			now_event_id = now_event_id + 1;
			now_enemy_id = now_enemy_id + 1;
		end
		now_event_id = now_event_id + enemy_num_offset_of_dai;
		now_enemy_id = now_enemy_id + enemy_num_offset_of_dai;
	end
	
	
--■110■石柱にワープ■
	proxy:OnDistanceAction( 110, 10000, 1982, "OnEvent_110", WarpGimmickDist_A, HELPID_GO_TO_SEKITYUU, 0, 180, everytime );
	
	
--■??■徘徊デーモンの登場■ハンドラ登録
	proxy:NotNetMessage_begin();
		--プレイヤーがソロで死亡した時にキックされます。
		proxy:LuaCall( 4000, 100, "PlayerDeath_m07_01_00_00", everytime );
		--プレイヤーが復活した時にキックされます。
		proxy:LuaCall( 4032, 100, "PlayerRevive_m07_01_00_00", everytime );
	proxy:NotNetMessage_end();		

	
--■初期化タイミング■
	proxy:NotNetMessage_begin();
		--▼0秒後▼--
		proxy:OnKeyTime2( 999991, "Second_Initialize_m07_01_00_00", 0.0, 0, 0, once );
	proxy:NotNetMessage_end();
	
print("Initialize_m07_01_00_00 end");
end


--------------------------------------------------------------------------------------
--マルチになった時にホストじゃ無かったら■無し
--------------------------------------------------------------------------------------
function ConnectPartyEvent(proxy)
	print("ConnectPartyEvent begin");
	print("ConnectPartyEvent end");
end

--描画と当たりを同時に切り替え用
function SetColiAndDraw( proxy, event_id, enable )
	print("SetColiAndDraw");
	proxy:SetColiEnable( event_id, enable );
	proxy:SetDrawEnable( event_id, enable );
end


--■初期化タイミング■
function Second_Initialize_m07_01_00_00(proxy, param)
	print( "Second_Initialize_m07_01_00_00 begin" );
	
	--▼蜀台破壊で浮かび上がる足場A
	if proxy:IsCompleteEvent( 1 ) == false then
		SetColiAndDraw( proxy, 1002, false ); --足場A非表示
	else
		SetColiAndDraw( proxy, 1002, true  ); --足場A表示
	--	proxy:ReconstructBreak( 1000 , 1 );
	end
	
	--▼蜀台破壊で浮かび上がる足場B
	if proxy:IsCompleteEvent( 11 ) == false then
		SetColiAndDraw( proxy, 1003, false ); --足場B非表示
	else
		SetColiAndDraw( proxy, 1003, true  ); --足場B表示
	--	proxy:ReconstructBreak( 1001 , 1 );	
	end
	
	--▼蜀台Aと蜀台Bを破壊で浮かび上がる足場C
	if proxy:IsCompleteEvent( 12 ) == false then
		SetColiAndDraw( proxy, 1033, false ); --足場C非表示
	else
		SetColiAndDraw( proxy, 1033, true  ); --足場C表示
	end
	
	
	--▼ノーマル蜀台破壊で一部の敵が見えるようになるA〜M
	local first_id_enemy  = 720;
	local first_id_shadow = first_id_enemy + 2300;
	local draw_num 		  = 3;
	local draw_num_offset = 2;--表示数の予備
	local end_id_enemy    = first_id_enemy  + draw_num;
	local end_id_shadow   = first_id_shadow + draw_num;
	
	local first_id_dai    = 1007;
	local now_id_dai      = first_id_dai;
	local first_event_id  = 20;
	local dai_num         = 13;
--	local end_id_dai      = first_id_dai + dai_num;
	local end_event_id    = first_event_id + dai_num;
	
	--敵と影の表示を初期化
	for k=first_event_id, end_event_id, 1 do		
	
		if proxy:IsCompleteEvent( k ) == false then
			for i=first_id_enemy , end_id_enemy -1, 1 do proxy:SetDrawEnable( i, false ); end --敵を非表示
			for j=first_id_shadow, end_id_shadow-1, 1 do proxy:SetDrawEnable( j, true  ); end --影を表示
		else 
			for i=first_id_enemy , end_id_enemy -1, 1 do proxy:SetDrawEnable( i, true  ); end --敵を表示
			for j=first_id_shadow, end_id_shadow-1, 1 do proxy:SetDrawEnable( j, false ); end --影を非表示
			
		--	proxy:ReconstructBreak( now_id_dai , 1 );
		end
		
		first_id_enemy  = first_id_enemy  + draw_num + draw_num_offset;
		first_id_shadow = first_id_shadow + draw_num + draw_num_offset;
		end_id_enemy    = first_id_enemy  + draw_num;
		end_id_shadow   = first_id_shadow + draw_num;
		
		now_id_dai = now_id_dai + 1;
	end

	--蜀台の影の同期
	
	local first_event_id = 40;
	local end_event_id   = ( draw_num + draw_num_offset ) * dai_num + first_event_id;
		
	local first_id_shadow = 3020;
	local now_id_shadow   = first_id_shadow;
	
	for i=first_event_id, end_event_id-1, 1 do
		
		--対応する敵が死んだら影を消す。
		if proxy:IsCompleteEvent( i ) == true then
			proxy:SetDrawEnable( now_id_shadow , false );
		end
		
		now_id_shadow = now_id_shadow + 1;
	end
	
	
--[[
	--■徘徊デーモン用 (フラグは仮、指定があれば変える)
	if proxy:IsCompleteEvent( 20 ) == true then
		LuaFunc_VisibleTheWanderingDemon  (proxy, param, demon_id_list_m07_01_00_00);
	else
		LuaFunc_InvisibleTheWanderingDemon(proxy, param, demon_id_list_m07_01_00_00);
	end
]]	
	
	
	print( "Second_Initialize_m07_01_00_00 end" );
end


--------------------------------------------------------------------------------------
--浮かび上がる足場A■1
--------------------------------------------------------------------------------------
--■1■浮かび上がる足場A■
function OnEvent_1(proxy, param)
print("OnEvent_1 begin");

	SetColiAndDraw( proxy, 1002, true );

	--もう片方の蜀台が壊れていたら、両方壊れたので足場Cイベント発動
	if proxy:IsCompleteEvent(11) ==true then
		proxy:LuaCallStart( 12, 1 );
	end
	
	proxy:SetEventFlag( 1, 1 );
	
	if param:IsNetMessage()==true  then
		--自分の画面で破壊されていても、必ず他のプレイヤーの画面で壊れているとは限らない為、ここで改めて破壊する
		proxy:ChangeModel( 1000, 1 );
		proxy:SetBrokenPiece(1000);
	end
	
print("OnEvent_1 end");
end


--------------------------------------------------------------------------------------
--浮かび上がる足場B■11
--------------------------------------------------------------------------------------
--■11■浮かび上がる足場B■
function OnEvent_11(proxy, param)
	print("OnEvent_11 begin");

	SetColiAndDraw( proxy, 1003, true );
	
	--もう片方の蜀台が壊れていたら、両方壊れたので足場Cイベント発動
	if proxy:IsCompleteEvent(1) ==true then
		proxy:LuaCallStart( 12, 1 );
	end
	
	proxy:SetEventFlag( 11, 1 );
	
	if param:IsNetMessage()==true  then
		--自分の画面で破壊されていても、必ず他のプレイヤーの画面で壊れているとは限らない為、ここで改めて破壊する
		--proxy:ObjectDestroy(1001);
		proxy:ChangeModel( 1001, 1 );
		proxy:SetBrokenPiece(1001);
	end
	
	print("OnEvent_11 end");
end


--------------------------------------------------------------------------------------
--浮かび上がる足場C■12
--------------------------------------------------------------------------------------
--■12■浮かび上がる足場C■
function OnEvent_12(proxy, param)
	print("OnEvent_12 begin");
	
	SetColiAndDraw( proxy, 1033, true );
	proxy:SetEventFlag( 12, 1 );
	
	print("OnEvent_12 end");
end



--------------------------------------------------------------------------------------
--■120■中ボス部屋への扉が開く■
--------------------------------------------------------------------------------------
--■120■中ボス部屋への扉が開く■
function OnEvent_120(proxy, param)
	print("OnEvent_120 begin")
	
	proxy:PlayAnimation( 1120, 1 );
	
	proxy:NotNetMessage_begin();
		--▼120_2▼***条件追加***扉アニメ終了▼
		proxy:OnCharacterAnimEnd( 120, 1120, 1, "OnEvent_120_2", once );
	proxy:NotNetMessage_end();
	
	--プレイヤーの同期アニメーション(true:パーティープレイヤーがアニメーションした)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_OPEN ) == true then 
		return;
	end
--[[	
	proxy:NotNetMessage_begin();
		--▼120_1▼***条件追加***プレイヤーアニメ終了▼
		proxy:OnChrAnimEnd( 120, 10000, ANIMEID_OPEN, "OnEvent_120_1", once );
	proxy:NotNetMessage_end();
]]		
--	proxy:Warp( 10000 , 2013 );		--プレイヤーを所定位置にワープ
--	proxy:DisableMove( 10000, 1 );	--プレイヤーを操作不能に
	
	print("OnEvent_120 end")
end

--[[
--▲120_1▲プレイヤーアニメ終了▲
function OnEvent_120_1(proxy, param)
	print("OnEvent_120_1 begin")
		
	proxy:DisableMove( 10000, 0 );	--プレイヤーを操作可能に
	
	print("OnEvent_120_1 end")
end
]]

--▲120_2▲扉アニメ終了▲
function OnEvent_120_2(proxy, param)
	print("OnEvent_120_2 begin")
	
	--ここで、ポリ劇再生予定
	
	proxy:SetEventFlag( 120 , 1 );
	
	print("OnEvent_120_2 end")
end


--------------------------------------------------------------------------------------
--中ボス死亡で何かが起こる■6656
--------------------------------------------------------------------------------------
--■6656■中ボス死亡で何かが起こる■
function OnEvent_6656(proxy, param)
	print("OnEvent_6656 begin");
	
	proxy:NotNetMessage_begin();
		--▼6656_1▼***条件追加***1秒後▼
		proxy:OnKeyTime2( 6656, "OnEvent_6656_1", 1.0, 0, 0, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_6656 end");
end

--▲6656_1▲1秒後▲
function OnEvent_6656_1(proxy, param)
	print("OnEvent_6656_1 begin");
	
	proxy:SetEventFlag( 6656, 1);
	--ダミーでレバー(ID:1004)のアニメ(ID:1)を再生
	proxy:PlayAnimation( 1004, 1 );
	
	print("OnEvent_6656_1 end");
end


--------------------------------------------------------------------------------------
--宝死体A■13568
--------------------------------------------------------------------------------------
--■13568■宝死体A■
function OnEvent_13568(proxy, param)
	print("OnEvent_13568 begin");
	
	--同期アニメーション用のイベント
	proxy:LuaCallStart( 4010 , 1 );
	
	proxy:NotNetMessage_begin();
		--▼13568_1▼***条件追加***宝死体Aアイテム取得▼
		proxy:OnKeyTime2( 13568, "OnEvent_13568_1", 0.0, 0, 0, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_13568 end");
end

--▲13568_1▲宝死体Aアイテム取得▲
function OnEvent_13568_1(proxy, param)
	print("OnEvent_13568_1 begin");
	
	proxy:GetItem(10000, TYPE_WEAPON);			--アイテム入手
	proxy:SetEventFlag( 13568, 1 );				--フラグを立てる
	proxy:TreasureDispModeChange( 1005, false );--光ってるのを消す
	
	print("OnEvent_13568_1 end");
end


--------------------------------------------------------------------------------------
--宝死体B■13569
--------------------------------------------------------------------------------------
--■13569■宝死体B■
function OnEvent_13569(proxy, param)
	print("OnEvent_13569 begin");
	
	--同期アニメーション用のイベント
	proxy:LuaCallStart( 4010 , 1 );
	
	proxy:NotNetMessage_begin();
		--▼13569_1▼***条件追加***宝死体Bアイテム取得▼
		proxy:OnKeyTime2( 13569, "OnEvent_13569_1", 0.0, 0, 0, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_13569 end");
end

--▲13569_1▲宝死体Bアイテム取得▲
function OnEvent_13569_1(proxy, param)
	print("OnEvent_13569_1 begin");
	
	proxy:GetItem(10000, TYPE_WEAPON);			--アイテム入手
	proxy:SetEventFlag( 13569, 1 );				--フラグを立てる
	proxy:TreasureDispModeChange( 1006, false );--光ってるのを消す
	
	print("OnEvent_13569_1 end");
end


--------------------------------------------------------------------------------------
--ノーマル燭台破壊で一部の敵が見えるようになるA■20
--------------------------------------------------------------------------------------
--■20■ノーマル燭台破壊で一部の敵が見えるようになる■
function OnEvent_20(proxy, param)
	print("OnEvent_20 begin");
	
	--▼表示の切り替え
	
	--敵を表示
	proxy:SetDrawEnable( 720 , true );
	proxy:SetDrawEnable( 721 , true );
	proxy:SetDrawEnable( 722 , true );
	
	--影を非表示
	proxy:SetDrawEnable( 3020 , false );
	proxy:SetDrawEnable( 3021 , false );
	proxy:SetDrawEnable( 3022 , false );
	
	--IDのルールが未定なので仮対応。今は増やさないでください。
	--proxy:InvalidSfx(5);
	--proxy:InvalidSfx(1007);
	
	if param:IsNetMessage()==true  then
		--自分の画面で破壊されていても、必ず他のプレイヤーの画面で壊れているとは限らない為、ここで改めて破壊する
		proxy:ChangeModel( 1007, 1 );
		proxy:SetBrokenPiece(1007);
	end
	
	proxy:SetEventFlag( 20, 1 );
	
	print("OnEvent_20 end");
end


--------------------------------------------------------------------------------------
--ノーマル燭台破壊で一部の敵が見えるようになるB■21
--------------------------------------------------------------------------------------
--■21■ノーマル燭台破壊で一部の敵が見えるようになる■
function OnEvent_21(proxy, param)
	print("OnEvent_21 begin");
	
	--▼表示の切り替え
	
	--敵を表示
	proxy:SetDrawEnable( 725 , true );
	proxy:SetDrawEnable( 726 , true );
	proxy:SetDrawEnable( 727 , true );
	
	--影を非表示
	proxy:SetDrawEnable( 3025 , false );
	proxy:SetDrawEnable( 3026 , false );
	proxy:SetDrawEnable( 3027 , false );
	
	--IDのルールが未定なので仮対応。今は増やさないでください。
	--proxy:InvalidSfx(12);
	--proxy:InvalidSfx(1008);
	
	if param:IsNetMessage()==true  then
		--自分の画面で破壊されていても、必ず他のプレイヤーの画面で壊れているとは限らない為、ここで改めて破壊する
		proxy:ChangeModel( 1008, 1 );
		proxy:SetBrokenPiece(1008);
	end
	
	proxy:SetEventFlag( 21, 1 );
	
	print("OnEvent_21 end");
end


--------------------------------------------------------------------------------------
--ノーマル燭台破壊で一部の敵が見えるようになるC■22
--------------------------------------------------------------------------------------
--■22■ノーマル燭台破壊で一部の敵が見えるようになる■
function OnEvent_22(proxy, param)
	print("OnEvent_22 begin");
	
	--▼表示の切り替え
	
	--敵を表示
	proxy:SetDrawEnable( 730 , true );
	proxy:SetDrawEnable( 731 , true );
	proxy:SetDrawEnable( 732 , true );
	
	--影を非表示
	proxy:SetDrawEnable( 3030 , false );
	proxy:SetDrawEnable( 3031 , false );
	proxy:SetDrawEnable( 3032 , false );
	
	if param:IsNetMessage()==true  then
		--自分の画面で破壊されていても、必ず他のプレイヤーの画面で壊れているとは限らない為、ここで改めて破壊する
		proxy:ChangeModel( 1009, 1 );
		proxy:SetBrokenPiece( 1009 );
	end
	
	proxy:SetEventFlag( 22, 1 );
	
	print("OnEvent_22 end");
end


--------------------------------------------------------------------------------------
--ノーマル燭台破壊で一部の敵が見えるようになるD■23
--------------------------------------------------------------------------------------
--■23■ノーマル燭台破壊で一部の敵が見えるようになる■
function OnEvent_23(proxy, param)
	print("OnEvent_23 begin");
	
	--▼表示の切り替え
	
	--敵を表示
	proxy:SetDrawEnable( 735 , true );
	proxy:SetDrawEnable( 736 , true );
	proxy:SetDrawEnable( 737 , true );
	
	--影を非表示
	proxy:SetDrawEnable( 3035 , false );
	proxy:SetDrawEnable( 3036 , false );
	proxy:SetDrawEnable( 3037 , false );
	
	if param:IsNetMessage()==true  then
		--自分の画面で破壊されていても、必ず他のプレイヤーの画面で壊れているとは限らない為、ここで改めて破壊する
		proxy:ChangeModel( 1010, 1 );
		proxy:SetBrokenPiece( 1010 );
	end
	
	proxy:SetEventFlag( 23, 1 );
	
	print("OnEvent_23 end");
end


--------------------------------------------------------------------------------------
--ノーマル燭台破壊で一部の敵が見えるようになるE■24
--------------------------------------------------------------------------------------
--■24■ノーマル燭台破壊で一部の敵が見えるようになる■
function OnEvent_24(proxy, param)
	print("OnEvent_24 begin");
	
	--▼表示の切り替え
	
	--敵を表示
	proxy:SetDrawEnable( 740 , true );
	proxy:SetDrawEnable( 741 , true );
	proxy:SetDrawEnable( 742 , true );
	
	--影を非表示
	proxy:SetDrawEnable( 3040 , false );
	proxy:SetDrawEnable( 3041 , false );
	proxy:SetDrawEnable( 3042 , false );
	
	if param:IsNetMessage()==true  then
		--自分の画面で破壊されていても、必ず他のプレイヤーの画面で壊れているとは限らない為、ここで改めて破壊する
		proxy:ChangeModel( 1011, 1 );
		proxy:SetBrokenPiece(1011);
	end
	
	proxy:SetEventFlag( 24, 1 );
	
	print("OnEvent_24 end");
end


--------------------------------------------------------------------------------------
--ノーマル燭台破壊で一部の敵が見えるようになるF■25
--------------------------------------------------------------------------------------
--■25■ノーマル燭台破壊で一部の敵が見えるようになる■
function OnEvent_25(proxy, param)
	print("OnEvent_25 begin");
	
	--▼表示の切り替え
	
	--敵を表示
	proxy:SetDrawEnable( 745 , true );
	proxy:SetDrawEnable( 746 , true );
	proxy:SetDrawEnable( 747 , true );
	
	--影を非表示
	proxy:SetDrawEnable( 3045 , false );
	proxy:SetDrawEnable( 3046 , false );
	proxy:SetDrawEnable( 3047 , false );
	
	if param:IsNetMessage()==true  then
		--自分の画面で破壊されていても、必ず他のプレイヤーの画面で壊れているとは限らない為、ここで改めて破壊する
		proxy:ChangeModel( 1012, 1 );
		proxy:SetBrokenPiece(1012);
	end
	
	proxy:SetEventFlag( 25, 1 );
	
	print("OnEvent_25 end");
end


--------------------------------------------------------------------------------------
--ノーマル燭台破壊で一部の敵が見えるようになるG■26
--------------------------------------------------------------------------------------
--■26■ノーマル燭台破壊で一部の敵が見えるようになる■
function OnEvent_26(proxy, param)
	print("OnEvent_26 begin");
	
	--▼表示の切り替え
	
	--敵を表示
	proxy:SetDrawEnable( 750 , true );
	proxy:SetDrawEnable( 751 , true );
	proxy:SetDrawEnable( 752 , true );
	
	--影を非表示
	proxy:SetDrawEnable( 3050 , false );
	proxy:SetDrawEnable( 3051 , false );
	proxy:SetDrawEnable( 3052 , false );
	
	if param:IsNetMessage()==true  then
		--自分の画面で破壊されていても、必ず他のプレイヤーの画面で壊れているとは限らない為、ここで改めて破壊する
		proxy:ChangeModel( 1013, 1 );
		proxy:SetBrokenPiece(1013);
	end
	
	proxy:SetEventFlag( 26, 1 );
	
	print("OnEvent_26 end");
end


--------------------------------------------------------------------------------------
--ノーマル燭台破壊で一部の敵が見えるようになるH■27
--------------------------------------------------------------------------------------
--■27■ノーマル燭台破壊で一部の敵が見えるようになる■
function OnEvent_27(proxy, param)
	print("OnEvent_27 begin");
	
	--▼表示の切り替え
	
	--敵を表示
	proxy:SetDrawEnable( 755 , true );
	proxy:SetDrawEnable( 756 , true );
	proxy:SetDrawEnable( 757 , true );
	
	--影を非表示
	proxy:SetDrawEnable( 3055 , false );
	proxy:SetDrawEnable( 3056 , false );
	proxy:SetDrawEnable( 3057 , false );
	
	if param:IsNetMessage()==true  then
		--自分の画面で破壊されていても、必ず他のプレイヤーの画面で壊れているとは限らない為、ここで改めて破壊する
		proxy:ChangeModel( 1014, 1 );
		proxy:SetBrokenPiece(1014);
	end
	
	proxy:SetEventFlag( 27, 1 );
	
	print("OnEvent_27 end");
end


--------------------------------------------------------------------------------------
--ノーマル燭台破壊で一部の敵が見えるようになるI■28
--------------------------------------------------------------------------------------
--■28■ノーマル燭台破壊で一部の敵が見えるようになる■
function OnEvent_28(proxy, param)
	print("OnEvent_28 begin");
	
	--▼表示の切り替え
	
	--敵を表示
	proxy:SetDrawEnable( 760 , true );
	proxy:SetDrawEnable( 761 , true );
	proxy:SetDrawEnable( 762 , true );
	
	--影を非表示
	proxy:SetDrawEnable( 3060 , false );
	proxy:SetDrawEnable( 3061 , false );
	proxy:SetDrawEnable( 3062 , false );
	
	if param:IsNetMessage()==true  then
		--自分の画面で破壊されていても、必ず他のプレイヤーの画面で壊れているとは限らない為、ここで改めて破壊する
		proxy:ChangeModel( 1015, 1 );
		proxy:SetBrokenPiece(1015);
	end
	
	proxy:SetEventFlag( 28, 1 );
	
	print("OnEvent_28 end");
end


--------------------------------------------------------------------------------------
--ノーマル燭台破壊で一部の敵が見えるようになるJ■29
--------------------------------------------------------------------------------------
--■29■ノーマル燭台破壊で一部の敵が見えるようになる■
function OnEvent_29(proxy, param)
	print("OnEvent_29 begin");
	
	--▼表示の切り替え
	
	--敵を表示
	proxy:SetDrawEnable( 765 , true );
	proxy:SetDrawEnable( 766 , true );
	proxy:SetDrawEnable( 767 , true );
	
	--影を非表示
	proxy:SetDrawEnable( 3065 , false );
	proxy:SetDrawEnable( 3066 , false );
	proxy:SetDrawEnable( 3067 , false );
	
	if param:IsNetMessage()==true  then
		--自分の画面で破壊されていても、必ず他のプレイヤーの画面で壊れているとは限らない為、ここで改めて破壊する
		proxy:ChangeModel( 1016, 1 );
		proxy:SetBrokenPiece(1016);
	end
	
	proxy:SetEventFlag( 29, 1 );
	
	print("OnEvent_29 end");
end


--------------------------------------------------------------------------------------
--ノーマル燭台破壊で一部の敵が見えるようになるK■30
--------------------------------------------------------------------------------------
--■30■ノーマル燭台破壊で一部の敵が見えるようになる■
function OnEvent_30(proxy, param)
	print("OnEvent_30 begin");
	
	--▼表示の切り替え
	
	--敵を表示
	proxy:SetDrawEnable( 770 , true );
	proxy:SetDrawEnable( 771 , true );
	proxy:SetDrawEnable( 772 , true );
	
	--影を非表示
	proxy:SetDrawEnable( 3070 , false );
	proxy:SetDrawEnable( 3071 , false );
	proxy:SetDrawEnable( 3072 , false );
	
	if param:IsNetMessage()==true  then
		--自分の画面で破壊されていても、必ず他のプレイヤーの画面で壊れているとは限らない為、ここで改めて破壊する
		proxy:ChangeModel( 1017, 1 );
		proxy:SetBrokenPiece(1017);
	end
	
	proxy:SetEventFlag( 30, 1 );
	
	print("OnEvent_30 end");
end


--------------------------------------------------------------------------------------
--ノーマル燭台破壊で一部の敵が見えるようになるL■31
--------------------------------------------------------------------------------------
--■31■ノーマル燭台破壊で一部の敵が見えるようになる■
function OnEvent_31(proxy, param)
	print("OnEvent_31 begin");
	
	--▼表示の切り替え
	
	--敵を表示
	proxy:SetDrawEnable( 775 , true );
	proxy:SetDrawEnable( 776 , true );
	proxy:SetDrawEnable( 777 , true );
	
	--影を非表示
	proxy:SetDrawEnable( 3075 , false );
	proxy:SetDrawEnable( 3076 , false );
	proxy:SetDrawEnable( 3077 , false );
	
	if param:IsNetMessage()==true  then
		--自分の画面で破壊されていても、必ず他のプレイヤーの画面で壊れているとは限らない為、ここで改めて破壊する
		proxy:ChangeModel( 1018, 1 );
		proxy:SetBrokenPiece(1018);
	end
	
	proxy:SetEventFlag( 31, 1 );
	
	print("OnEvent_31 end");
end


--------------------------------------------------------------------------------------
--ノーマル燭台破壊で一部の敵が見えるようになるM■32
--------------------------------------------------------------------------------------
--■32■ノーマル燭台破壊で一部の敵が見えるようになる■
function OnEvent_32(proxy, param)
	print("OnEvent_32 begin");
	
	--▼表示の切り替え
	
	--敵を表示
	proxy:SetDrawEnable( 780 , true );
	proxy:SetDrawEnable( 781 , true );
	proxy:SetDrawEnable( 782 , true );
	
	--影を非表示
	proxy:SetDrawEnable( 3080 , false );
	proxy:SetDrawEnable( 3081 , false );
	proxy:SetDrawEnable( 3082 , false );
	
	if param:IsNetMessage()==true  then
		--自分の画面で破壊されていても、必ず他のプレイヤーの画面で壊れているとは限らない為、ここで改めて破壊する
		proxy:ChangeModel( 1019, 1 );
		proxy:SetBrokenPiece(1019);
	end
	
	proxy:SetEventFlag( 32, 1 );
	
	print("OnEvent_32 end");
end

--------------------------------------------------------------------------------------
--ザコ敵の死亡監視■40
--------------------------------------------------------------------------------------
--■40■ザコ敵の死亡監視■
function OnEvent_40(proxy, param)
	print("OnEvent_40 begin");
	
	proxy:SetDrawEnable( 3020 , false );
	proxy:SetEventFlag( 40, 1 );
	
	print("OnEvent_40 end");
end

--------------------------------------------------------------------------------------
--ザコ敵の死亡監視■41
--------------------------------------------------------------------------------------
--■41■ザコ敵の死亡監視■
function OnEvent_41(proxy, param)
	print("OnEvent_41 begin");
	
	proxy:SetDrawEnable( 3021 , false );
	proxy:SetEventFlag( 41, 1 );
	
	print("OnEvent_41 end");
end

--------------------------------------------------------------------------------------
--ザコ敵の死亡監視■42
--------------------------------------------------------------------------------------
--■42■ザコ敵の死亡監視■
function OnEvent_42(proxy, param)
	print("OnEvent_42 begin");
	
	proxy:SetDrawEnable( 3022 , false );
	proxy:SetEventFlag( 42, 1 );
	
	print("OnEvent_42 end");
end

--------------------------------------------------------------------------------------
--ザコ敵の死亡監視■43
--------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------
--ザコ敵の死亡監視■44
--------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------
--ザコ敵の死亡監視■45
--------------------------------------------------------------------------------------
--■45■ザコ敵の死亡監視■
function OnEvent_45(proxy, param)
	print("OnEvent_45 begin");
	
	proxy:SetDrawEnable( 3025 , false );
	proxy:SetEventFlag( 45, 1 );
	
	print("OnEvent_45 end");
end

--------------------------------------------------------------------------------------
--ザコ敵の死亡監視■46
--------------------------------------------------------------------------------------
--■46■ザコ敵の死亡監視■
function OnEvent_46(proxy, param)
	print("OnEvent_46 begin");
	
	proxy:SetDrawEnable( 3026 , false );
	proxy:SetEventFlag( 46, 1 );
	
	print("OnEvent_46 end");
end

--------------------------------------------------------------------------------------
--ザコ敵の死亡監視■47
--------------------------------------------------------------------------------------
--■47■ザコ敵の死亡監視■
function OnEvent_47(proxy, param)
	print("OnEvent_47 begin");
	
	proxy:SetDrawEnable( 3027 , false );
	proxy:SetEventFlag( 47, 1 );
	
	print("OnEvent_47 end");
end

--------------------------------------------------------------------------------------
--ザコ敵の死亡監視■48
--------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------
--ザコ敵の死亡監視■49
--------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------
--ザコ敵の死亡監視■50
--------------------------------------------------------------------------------------
--■50■ザコ敵の死亡監視■
function OnEvent_50(proxy, param)
	print("OnEvent_50 begin");
	
	proxy:SetDrawEnable( 3030 , false );
	proxy:SetEventFlag( 50, 1 );
	
	print("OnEvent_50 end");
end

--------------------------------------------------------------------------------------
--ザコ敵の死亡監視■51
--------------------------------------------------------------------------------------
--■51■ザコ敵の死亡監視■
function OnEvent_51(proxy, param)
	print("OnEvent_51 begin");
	
	proxy:SetDrawEnable( 3031 , false );
	proxy:SetEventFlag( 51, 1 );
	
	print("OnEvent_51 end");
end

--------------------------------------------------------------------------------------
--ザコ敵の死亡監視■52
--------------------------------------------------------------------------------------
--■52■ザコ敵の死亡監視■
function OnEvent_52(proxy, param)
	print("OnEvent_52 begin");
	
	proxy:SetDrawEnable( 3032 , false );
	proxy:SetEventFlag( 52, 1 );
	
	print("OnEvent_52 end");
end

--------------------------------------------------------------------------------------
--ザコ敵の死亡監視■53
--------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------
--ザコ敵の死亡監視■54
--------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------
--ザコ敵の死亡監視■55
--------------------------------------------------------------------------------------
--■55■ザコ敵の死亡監視■
function OnEvent_55(proxy, param)
	print("OnEvent_55 begin");
	
	proxy:SetDrawEnable( 3035 , false );
	proxy:SetEventFlag( 55, 1 );
	
	print("OnEvent_55 end");
end

--------------------------------------------------------------------------------------
--ザコ敵の死亡監視■56
--------------------------------------------------------------------------------------
--■56■ザコ敵の死亡監視■
function OnEvent_56(proxy, param)
	print("OnEvent_56 begin");
	
	proxy:SetDrawEnable( 3036 , false );
	proxy:SetEventFlag( 56, 1 );
	
	print("OnEvent_56 end");
end

--------------------------------------------------------------------------------------
--ザコ敵の死亡監視■57
--------------------------------------------------------------------------------------
--■57■ザコ敵の死亡監視■
function OnEvent_57(proxy, param)
	print("OnEvent_57 begin");
	
	proxy:SetDrawEnable( 3037 , false );
	proxy:SetEventFlag( 57, 1 );
	
	print("OnEvent_57 end");
end

--------------------------------------------------------------------------------------
--ザコ敵の死亡監視■58
--------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------
--ザコ敵の死亡監視■59
--------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------
--ザコ敵の死亡監視■60
--------------------------------------------------------------------------------------
--■60■ザコ敵の死亡監視■
function OnEvent_60(proxy, param)
	print("OnEvent_60 begin");
	
	proxy:SetDrawEnable( 3040 , false );
	proxy:SetEventFlag( 60, 1 );
	
	print("OnEvent_60 end");
end

--------------------------------------------------------------------------------------
--ザコ敵の死亡監視■61
--------------------------------------------------------------------------------------
--■61■ザコ敵の死亡監視■
function OnEvent_61(proxy, param)
	print("OnEvent_61 begin");
	
	proxy:SetDrawEnable( 3041 , false );
	proxy:SetEventFlag( 61, 1 );
	
	print("OnEvent_61 end");
end

--------------------------------------------------------------------------------------
--ザコ敵の死亡監視■62
--------------------------------------------------------------------------------------
--■62■ザコ敵の死亡監視■
function OnEvent_62(proxy, param)
	print("OnEvent_62 begin");
	
	proxy:SetDrawEnable( 3042 , false );
	proxy:SetEventFlag( 62, 1 );
	
	print("OnEvent_62 end");
end

--------------------------------------------------------------------------------------
--ザコ敵の死亡監視■63
--------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------
--ザコ敵の死亡監視■64
--------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------
--ザコ敵の死亡監視■65
--------------------------------------------------------------------------------------
--■65■ザコ敵の死亡監視■
function OnEvent_65(proxy, param)
	print("OnEvent_65 begin");
	
	proxy:SetDrawEnable( 3045 , false );
	proxy:SetEventFlag( 65, 1 );
	
	print("OnEvent_65 end");
end

--------------------------------------------------------------------------------------
--ザコ敵の死亡監視■66
--------------------------------------------------------------------------------------
--■66■ザコ敵の死亡監視■
function OnEvent_66(proxy, param)
	print("OnEvent_66 begin");
	
	proxy:SetDrawEnable( 3046 , false );
	proxy:SetEventFlag( 66, 1 );
	
	print("OnEvent_66 end");
end

--------------------------------------------------------------------------------------
--ザコ敵の死亡監視■67
--------------------------------------------------------------------------------------
--■67■ザコ敵の死亡監視■
function OnEvent_67(proxy, param)
	print("OnEvent_67 begin");
	
	proxy:SetDrawEnable( 3047 , false );
	proxy:SetEventFlag( 67, 1 );
	
	print("OnEvent_67 end");
end

--------------------------------------------------------------------------------------
--ザコ敵の死亡監視■68
--------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------
--ザコ敵の死亡監視■69
--------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------
--ザコ敵の死亡監視■70
--------------------------------------------------------------------------------------
--■70■ザコ敵の死亡監視■
function OnEvent_70(proxy, param)
	print("OnEvent_70 begin");
	
	proxy:SetDrawEnable( 3050 , false );
	proxy:SetEventFlag( 70, 1 );
	
	print("OnEvent_70 end");
end

--------------------------------------------------------------------------------------
--ザコ敵の死亡監視■71
--------------------------------------------------------------------------------------
--■71■ザコ敵の死亡監視■
function OnEvent_71(proxy, param)
	print("OnEvent_71 begin");
	
	proxy:SetDrawEnable( 3051 , false );
	proxy:SetEventFlag( 71, 1 );
	
	print("OnEvent_71 end");
end

--------------------------------------------------------------------------------------
--ザコ敵の死亡監視■72
--------------------------------------------------------------------------------------
--■72■ザコ敵の死亡監視■
function OnEvent_72(proxy, param)
	print("OnEvent_72 begin");
	
	proxy:SetDrawEnable( 3052 , false );
	proxy:SetEventFlag( 72, 1 );
	
	print("OnEvent_72 end");
end

--------------------------------------------------------------------------------------
--ザコ敵の死亡監視■73
--------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------
--ザコ敵の死亡監視■74
--------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------
--ザコ敵の死亡監視■75
--------------------------------------------------------------------------------------
--■75■ザコ敵の死亡監視■
function OnEvent_75(proxy, param)
	print("OnEvent_75 begin");
	
	proxy:SetDrawEnable( 3055 , false );
	proxy:SetEventFlag( 75, 1 );
	
	print("OnEvent_75 end");
end

--------------------------------------------------------------------------------------
--ザコ敵の死亡監視■76
--------------------------------------------------------------------------------------
--■76■ザコ敵の死亡監視■
function OnEvent_76(proxy, param)
	print("OnEvent_76 begin");
	
	proxy:SetDrawEnable( 3056 , false );
	proxy:SetEventFlag( 76, 1 );
	
	print("OnEvent_76 end");
end

--------------------------------------------------------------------------------------
--ザコ敵の死亡監視■77
--------------------------------------------------------------------------------------
--■77■ザコ敵の死亡監視■
function OnEvent_77(proxy, param)
	print("OnEvent_77 begin");
	
	proxy:SetDrawEnable( 3057 , false );
	proxy:SetEventFlag( 77, 1 );
	
	print("OnEvent_77 end");
end

--------------------------------------------------------------------------------------
--ザコ敵の死亡監視■78
--------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------
--ザコ敵の死亡監視■79
--------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------
--ザコ敵の死亡監視■80
--------------------------------------------------------------------------------------
--■80■ザコ敵の死亡監視■
function OnEvent_80(proxy, param)
	print("OnEvent_80 begin");
	
	proxy:SetDrawEnable( 3060 , false );
	proxy:SetEventFlag( 80, 1 );
	
	print("OnEvent_80 end");
end

--------------------------------------------------------------------------------------
--ザコ敵の死亡監視■81
--------------------------------------------------------------------------------------
--■81■ザコ敵の死亡監視■
function OnEvent_81(proxy, param)
	print("OnEvent_81 begin");
	
	proxy:SetDrawEnable( 3061 , false );
	proxy:SetEventFlag( 81, 1 );
	
	print("OnEvent_81 end");
end

--------------------------------------------------------------------------------------
--ザコ敵の死亡監視■82
--------------------------------------------------------------------------------------
--■82■ザコ敵の死亡監視■
function OnEvent_82(proxy, param)
	print("OnEvent_82 begin");
	
	proxy:SetDrawEnable( 3062 , false );
	proxy:SetEventFlag( 82, 1 );
	
	print("OnEvent_82 end");
end

--------------------------------------------------------------------------------------
--ザコ敵の死亡監視■83
--------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------
--ザコ敵の死亡監視■84
--------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------
--ザコ敵の死亡監視■85
--------------------------------------------------------------------------------------
--■85■ザコ敵の死亡監視■
function OnEvent_85(proxy, param)
	print("OnEvent_85 begin");
	
	proxy:SetDrawEnable( 3065 , false );
	proxy:SetEventFlag( 85, 1 );
	
	print("OnEvent_85 end");
end

--------------------------------------------------------------------------------------
--ザコ敵の死亡監視■86
--------------------------------------------------------------------------------------
--■86■ザコ敵の死亡監視■
function OnEvent_86(proxy, param)
	print("OnEvent_86 begin");
	
	proxy:SetDrawEnable( 3066 , false );
	proxy:SetEventFlag( 86, 1 );
	
	print("OnEvent_86 end");
end

--------------------------------------------------------------------------------------
--ザコ敵の死亡監視■87
--------------------------------------------------------------------------------------
--■87■ザコ敵の死亡監視■
function OnEvent_87(proxy, param)
	print("OnEvent_87 begin");
	
	proxy:SetDrawEnable( 3067 , false );
	proxy:SetEventFlag( 87, 1 );
	
	print("OnEvent_87 end");
end

--------------------------------------------------------------------------------------
--ザコ敵の死亡監視■88
--------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------
--ザコ敵の死亡監視■89
--------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------
--ザコ敵の死亡監視■90
--------------------------------------------------------------------------------------
--■90■ザコ敵の死亡監視■
function OnEvent_90(proxy, param)
	print("OnEvent_90 begin");
	
	proxy:SetDrawEnable( 3070 , false );
	proxy:SetEventFlag( 90, 1 );
	
	print("OnEvent_90 end");
end

--------------------------------------------------------------------------------------
--ザコ敵の死亡監視■91
--------------------------------------------------------------------------------------
--■91■ザコ敵の死亡監視■
function OnEvent_91(proxy, param)
	print("OnEvent_91 begin");
	
	proxy:SetDrawEnable( 3071 , false );
	proxy:SetEventFlag( 91, 1 );
	
	print("OnEvent_91 end");
end

--------------------------------------------------------------------------------------
--ザコ敵の死亡監視■92
--------------------------------------------------------------------------------------
--■92■ザコ敵の死亡監視■
function OnEvent_92(proxy, param)
	print("OnEvent_92 begin");
	
	proxy:SetDrawEnable( 3072 , false );
	proxy:SetEventFlag( 92, 1 );
	
	print("OnEvent_92 end");
end

--------------------------------------------------------------------------------------
--ザコ敵の死亡監視■93
--------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------
--ザコ敵の死亡監視■94
--------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------
--ザコ敵の死亡監視■95
--------------------------------------------------------------------------------------
--■95■ザコ敵の死亡監視■
function OnEvent_95(proxy, param)
	print("OnEvent_95 begin");
	
	proxy:SetDrawEnable( 3075 , false );
	proxy:SetEventFlag( 95, 1 );
	
	print("OnEvent_95 end");
end

--------------------------------------------------------------------------------------
--ザコ敵の死亡監視■96
--------------------------------------------------------------------------------------
--■96■ザコ敵の死亡監視■
function OnEvent_96(proxy, param)
	print("OnEvent_96 begin");
	
	proxy:SetDrawEnable( 3076 , false );
	proxy:SetEventFlag( 96, 1 );
	
	print("OnEvent_96 end");
end

--------------------------------------------------------------------------------------
--ザコ敵の死亡監視■97
--------------------------------------------------------------------------------------
--■97■ザコ敵の死亡監視■
function OnEvent_97(proxy, param)
	print("OnEvent_97 begin");
	
	proxy:SetDrawEnable( 3077 , false );
	proxy:SetEventFlag( 97, 1 );
	
	print("OnEvent_97 end");
end

--------------------------------------------------------------------------------------
--ザコ敵の死亡監視■98
--------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------
--ザコ敵の死亡監視■99
--------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------
--ザコ敵の死亡監視■100
--------------------------------------------------------------------------------------
--■100■ザコ敵の死亡監視■
function OnEvent_100(proxy, param)
	print("OnEvent_100 begin");
	
	proxy:SetDrawEnable( 3080 , false );
	proxy:SetEventFlag( 100, 1 );
	
	print("OnEvent_100 end");
end

--------------------------------------------------------------------------------------
--ザコ敵の死亡監視■101
--------------------------------------------------------------------------------------
--■101■ザコ敵の死亡監視■
function OnEvent_101(proxy, param)
	print("OnEvent_101 begin");
	
	proxy:SetDrawEnable( 3081 , false );
	proxy:SetEventFlag( 101, 1 );
	
	print("OnEvent_101 end");
end

--------------------------------------------------------------------------------------
--ザコ敵の死亡監視■102
--------------------------------------------------------------------------------------
--■102■ザコ敵の死亡監視■
function OnEvent_102(proxy, param)
	print("OnEvent_102 begin");
	
	proxy:SetDrawEnable( 3082 , false );
	proxy:SetEventFlag( 102, 1 );
	
	print("OnEvent_102 end");
end

--------------------------------------------------------------------------------------
--ザコ敵の死亡監視■103
--------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------
--ザコ敵の死亡監視■104
--------------------------------------------------------------------------------------



--------------------------------------------------------------------------------------
--石柱にワープ■110
--------------------------------------------------------------------------------------
--■110■石柱にワープ■
function OnEvent_110(proxy,param)	
	print("OnEvent_110 begin");
	
	proxy:WarpNextStage( 1, 0, 0, 0, 1011 );
	
	print("OnEvent_110 end");
end



--------------------------------------------------------------------------------------
--徘徊デーモンの登場■??
--------------------------------------------------------------------------------------

--▼グローバルの死亡監視から呼ばれる(ソロ)
function PlayerDeath_m07_01_00_00(proxy, param)
	print("PlayerDeath_m07_01_00_00");
	
--	LuaFunc_VisibleTheWanderingDemon(proxy, param, demon_id_list_m07_01_00_00);
--	proxy:SetEventFlag( 20 , 1 );--フラグは仮、指定があれば変える。
	
	print("PlayerDeath_m07_01_00_00");
end

--▼グローバルの血文字復活から呼ばれる(ソロ)
function PlayerRevive_m07_01_00_00(proxy,param)
	print("PlayerRevive_m07_01_00_00");
	
--	LuaFunc_InvisibleTheWanderingDemon(proxy, param, demon_id_list_m07_01_00_00);
--	proxy:SetEventFlag( 20 , 0 );--フラグは仮、指定があれば変える。
	
	print("PlayerRevive_m07_01_00_00");
end

