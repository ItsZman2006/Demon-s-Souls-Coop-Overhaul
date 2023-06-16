once = 1;
everytime = 0;




function Initialize_m99_99_12_00(proxy)
print("Initialize m99_99_12_00 begin");


--	誰が無視　プレイアだけ
--	EventID, Who(無視), RegionID, handler, bOnce	


--■201■ドラゴンデーモン登場■
--・PCが、イベントエリア（1）に到達したとき
	proxy:OnRegionJustIn( 201, 10000, 1, "OnEvent_201", once);


--■202■ドラゴンデーモン戦闘状態に移行■
--・PCが、イベントエリア（2）に到達したとき
	proxy:OnRegionJustIn( 202, 10000, 2, "OnEvent_202", once);

--[[ チュートリアル用にコメントアウト

--■210■バリスタ発射0■
--・PCが、イベントエリア(210)の中に居て、
--　特定の角度を向いていて、
--　アクションボタンを押したとき
	proxy:OnPlayerActionInRegionAngle( 210, 210, "OnEvent_210", 30,1, once);
--■211■バリスタ発射0■
--・PCが、イベントエリア(210)の中に居て、
--　特定の角度を向いていて、
--　アクションボタンを押したとき
	proxy:OnPlayerActionInRegionAngle( 211, 210, "OnEvent_211", 30,1, once);


--■220■バリスタ発射1■
--・PCが、イベントエリア(220)の中に居て、
--　特定の角度を向いていて、
--　アクションボタンを押したとき
	proxy:OnPlayerActionInRegionAngle( 220, 220, "OnEvent_220", 30,1, once);
--■221■バリスタ発射1■
--・PCが、イベントエリア(220)の中に居て、
--　特定の角度を向いていて、
--　アクションボタンを押したとき
	proxy:OnPlayerActionInRegionAngle( 221, 220, "OnEvent_221", 30,1, once);
]]

--■275■マップ移動（→砦）■
--・ＰＣが、イベントエリア（75）に到達したとき
	proxy:OnRegionJustIn( 275, 10000, 75, "OnEvent_275", everytime);



--■299■ボス死亡■
--・ボス(200)死亡
	proxy:OnCharacterDead( 299, 200, "OnEvent_299", once);
	
--■7000■マップ入ったら■
	proxy:OnKeyTime2(7000,"OnEvent_7000",0.0,0,0,once);
	
--■7010■領域はいったら■
	proxy:OnRegionIn(7010,10000,2200,"OnEvent_7010",once);

	

--■??■徘徊デーモンの登場■ハンドラ登録
	proxy:NotNetMessage_begin();
		--プレイヤーがソロで死亡した時にキックされます。
		proxy:LuaCall( 4000, 100, "PlayerDeath_m99_99_12_00", everytime );
		--プレイヤーが復活した時にキックされます。
		proxy:LuaCall( 4032, 100, "PlayerRevive_m99_99_12_00", everytime );
	proxy:NotNetMessage_end();
	
	
--■999912■フレーム遅れの初期化処理イベントを発行■
	proxy:NotNetMessage_begin();
		--▼0秒後▼--
		proxy:OnKeyTime2( 999912, "Second_Initialize_m99_99_12_00", 0.1, 0, 0, once );	
	proxy:NotNetMessage_end();	

print("Initialize m99_99_12_00 end");
end


--------------------------------------------------------------------------------------
--マルチになった時にホストじゃ無かったら■無し
--------------------------------------------------------------------------------------
function ConnectPartyEvent(proxy)
	print("ConnectPartyEvent begin");
	print("ConnectPartyEvent end");
end



--------------------------------------------------------------------------------------
--Initializeから呼ばれる、1フレーム遅れの初期化処理■999999
--------------------------------------------------------------------------------------
--■999912■初期化■
function Second_Initialize_m99_99_12_00(proxy, param)
	print("Second_Initialize_m99_99_12_00 begin");
	
--[[
	--■徘徊デーモン用 (フラグは仮、指定があれば変える)
	if proxy:IsCompleteEvent( 20 ) == true then
		LuaFunc_VisibleTheWanderingDemon  (proxy, param, demon_id_list_m99_99_12_00);
	else
		LuaFunc_InvisibleTheWanderingDemon(proxy, param, demon_id_list_m99_99_12_00);
	end
]]
	
	print("Second_Initialize_m99_99_12_00 end");
end



--■201■ドラゴンデーモン登場■
function OnEvent_201(proxy, param)
print("OnEvent_201 begin");
	if param:IsNetMessage()==true  then
		return;         
	end
	
--・ドラゴンデーモン(c1020/200)の登場アニメーション(99_0000）を再生
	proxy:PlayAnimation(200, 990000);

print("OnEvent_201 end");
end







--■202■ドラゴンデーモン戦闘状態に移行■
function OnEvent_202(proxy, param)
print("OnEvent_202 begin");

--・ドラゴンデーモン(c1020/200)を戦闘ロジックに切り替える？
--⇒ドラゴンデーモンの戦闘がイベントかキャラか？
	proxy:EnableLogic(200, true);

print("OnEvent_202 end");
end







--■210■バリスタ発射0■
function OnEvent_210(proxy, param)
print("OnEvent_210 begin");
	print( "212 destroyed? %d", proxy:IsDestroyed(212) );
	
	if param:IsNetMessage()==true  then
		return;         
	end

--	バリスタ破壊されたら何もしない
	if proxy:IsDestroyed(212) == false then 
--      {
--・PCをイベントエリア(215)に移動
	proxy:Warp(10000, 215);
--・PCのレバー動作アニメーション(ID 4000)再生
	proxy:PlayAnimation(10000, 8000);

--・同時にドラゴンデーモンのバリスタ1ダメージモーション(990040)再生
    --local boss = proxy:GetBoss(200);
    --boss:Damage_LeftArm();

--・モーション後バリスタの矢は消してください
--  	}
	end

print("OnEvent_210 end");
end


--■211■バリスタ発射0■
function OnEvent_211(proxy, param)
print("OnEvent_211 begin");
--	バリスタ破壊されたら何もしない
	if proxy:IsDestroyed(212) == false then 
--      {
--・バリスタ0用レバー（o0210_00/210）のアニメーション(ID 1)再生
	proxy:PlayAnimation(210, 1);

--・バリスタの矢（o0001_00/211)の発射アニメーション(ID 1)再生
	proxy:PlayAnimation(211, 1);

--・バリスタ0OBJ（o0000/212)の発射アニメーション（ID 1）再生
	proxy:PlayAnimation(212, 1);

--・モーション後バリスタの矢は消してください
--  	}
	end


print("OnEvent_211 end");
end







--■220■バリスタ発射1■
function OnEvent_220(proxy, param)
print("OnEvent_220 begin");
	if param:IsNetMessage()==true  then
		return;         
	end
	
--	バリスタ破壊されたら何もしない
	if proxy:IsDestroyed(222) == false then 
--      {
--・PCをイベントエリア(216)に移動
	proxy:Warp(10000, 216);
--・PCのレバー動作アニメーション(ID 4000)再生
	proxy:PlayAnimation(10000, 8000);

--・同時にドラゴンデーモンのバリスタ1ダメージモーション(990041)再生
    --local boss = proxy:GetBoss(200);
    --boss:Damage_RightArm();

--・モーション後バリスタの矢は消してください
--  	}
	end

print("OnEvent_220 end");
end


--■221■バリスタ発射1■
function OnEvent_221(proxy, param)
print("OnEvent_221 begin");
--	バリスタ破壊されたら何もしない
	if proxy:IsDestroyed(222) == false then 
--      {
--・バリスタ1用レバー（o0210_01/220）のアニメーション(ID 1)のアニメーション再生
	proxy:PlayAnimation(220, 1);

--・バリスタの矢（o0001_01/221)の発射アニメーション(ID 1)再生
	proxy:PlayAnimation(221, 1);

--・バリスタ1OBJ（o0000/222)の発射アニメーション（ID 1）再生
	proxy:PlayAnimation(222, 1);

--・モーション後バリスタの矢は消してください
--  	}
	end

print("OnEvent_221 end");
end







--■275■マップ移動（→砦）■
function OnEvent_275(proxy, param)
print("OnEvent_275 begin");
	if param:IsNetMessage()==true  then
		return;         
	end
--マルチプレイの時のエリア移動を止める
	if proxy:IsInParty() == true then
		return;
	end 
	
--・たどり着いたＰＣのみ、溶岩広場から砦（m99_99_11_00）の指定位置に移動
--・移動先（m99_99_11_00）の対応キャライベントID
--　ＰＣ（0）→キャラ（30）
--　ＰＣ（1）→キャラ（31）
--　ＰＣ（2）→キャラ（32）
--　ＰＣ（3）→キャラ（33）
	playerId = proxy:GetLocalPlayerId();
	if playerId ==0 then proxy:WarpNextStage(99,99,11,00, 30); end
	if playerId ==1 then proxy:WarpNextStage(99,99,11,00, 31); end
	if playerId ==2 then proxy:WarpNextStage(99,99,11,00, 32); end
	if playerId ==3 then proxy:WarpNextStage(99,99,11,00, 33); end

--※移動するキャラクターは、移動時にパッと消してしまいます

print("OnEvent_275 end");
end







--■299■ボス死亡■
function OnEvent_299(proxy, param)
print("OnEvent_299 begin");

--とりあえずメニューへ
	--proxy:WarpNextStage(0,0,0,-1, -1);
--上記の処理が使えなくなっている様なのでこちらに移行
	proxy:ReturnMapSelect();
print("OnEvent_299 end");
end









--------------------------------------------------------------------------------------
--マップに入ったら■7000
--------------------------------------------------------------------------------------
function OnEvent_7000(proxy,param)
	print("OnEvent_7000 begin");
	if proxy:IsCompleteEvent(7000) == false then 
		proxy:SetChrType(10000,8);
		proxy:SetEventFlag(7000,true);
	end
	print("OnEvent_7000 end");
end


--------------------------------------------------------------------------------------
--2200領域に入ったら■7010
--------------------------------------------------------------------------------------
function OnEvent_7010(proxy,param)
	print("OnEvent_7010 begin");
	if proxy:IsCompleteEvent(7010) == false then
		proxy:SetEventFlag(7010,true);
		proxy:OnKeyTime2(7010,"OnEvent_7010_1",9.0,0,0,once);
	end
	print("OnEvent_7010 end");
end


--------------------------------------------------------------------------------------
--○秒後■7010 マップ抜けます
--------------------------------------------------------------------------------------
function OnEvent_7010_1(proxy,param)
	print("OnEvent_7010_1 begin");
	proxy:ReturnMapSelect();
	print("OnEvent_7010_1 end");
end



--------------------------------------------------------------------------------------
--徘徊デーモンの登場■??
--------------------------------------------------------------------------------------

--▼グローバルの死亡監視から呼ばれる(ソロ)
function PlayerDeath_m99_99_12_00(proxy, param)
	print("PlayerDeath_m99_99_12_00");
	
--	LuaFunc_VisibleTheWanderingDemon(proxy, param, demon_id_list_m99_99_12_00);
--	proxy:SetEventFlag( 20 , 1 );--フラグは仮、指定があれば変える。
	
	print("PlayerDeath_m99_99_12_00");
end

--▼グローバルの血文字復活から呼ばれる(ソロ)
function PlayerRevive_m99_99_12_00(proxy,param)
	print("PlayerRevive_m99_99_12_00");
	
--	LuaFunc_InvisibleTheWanderingDemon(proxy, param, demon_id_list_m99_99_12_00);
--	proxy:SetEventFlag( 20 , 0 );--フラグは仮、指定があれば変える。
	
	print("PlayerRevive_m99_99_12_00");
end



