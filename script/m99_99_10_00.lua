once = 1;
everytime = 0;


--■チュートリアル用
TO_NEXT_MESSAGE_TIME          = 0.0;--メッセージが連続するときの、次のメッセージを表示するまでの時間
GET_ITEM_TO_NEXT_MESSAGE_TIME = 3.0;--アイテム取得→メッセージ表示のときはちょっと時間を空ける

DISPLAY_MESSAGE_TIME          = 4.5;



function Initialize_m99_99_10_00(proxy)
	print("Initialize m99_99_10_00 begin");

--■050■初期配置■
--・ゲーム開始時
--・ＰＣキャラクターを指定の位置に配置する
--　ＰＣ（0）→キャラ（0）
--　ＰＣ（1）→キャラ（1）
--　ＰＣ（2）→キャラ（2）
--　ＰＣ（3）→キャラ（3）
--	proxy:OnRegionJustIn( 0, 0, 1, "OnEvent_050", once);



--▼変更しないもの

--■055■マップ移動（→砦1F)■
--・ＰＣが、イベントエリア（55）に到達したとき
	proxy:OnRegionJustIn( 55, 10000, 55, "OnEvent_055", everytime);


--■065■マップ移動（→砦2F)■
--・ＰＣが、イベントエリア（65）に到達したとき
	proxy:OnRegionJustIn( 65, 10000, 65, "OnEvent_065", everytime);


--※IDをラスボスリセットにしたので、フラグが重複しないように注意(m99_99_10_00 から m99_99_12_00で)
	
	
--▼チュートリアル用に追加したもの

--チュートリアル用のヘルプメッセージ、宝死体はエリアリセットしないように
--ラスボスリセットのほうのフラグになっています。
	
--■5020■チュートリアル01■初期移動関連説明(カメラ旋回説明→ダッシュステップ説明)
	if proxy:IsCompleteEvent( 5020 ) == false then
		proxy:OnKeyTime2(5020,"OnEvent_5020",1,0,0,once);
	end
	
--■5022■チュートリアル03■よじ登り説明
	if proxy:IsCompleteEvent( 5022) == false then
		proxy:OnRegionJustIn(5022,10000,2000,"OnEvent_5022",once);
	end

--■5023■チュートリアル04■乗り越え説明
	if proxy:IsCompleteEvent( 5023 ) == false then
		proxy:OnRegionJustIn(5023,10000,2001,"OnEvent_5023",once);
	end
	
--■5024■チュートリアル05■近接攻撃関連説明(左手･右手攻撃→溜め攻撃→両手･片手攻撃)
	if proxy:IsCompleteEvent( 5024 ) == false then
		proxy:OnRegionJustIn(5024,10000,2002,"OnEvent_5024",once);
	end
	
--■5027■チュートリアル08■遠隔攻撃関連説明(魔法攻撃→弓攻撃)
	if proxy:IsCompleteEvent( 5027 ) == false then
		proxy:OnRegionJustIn(5027,10000,2003,"OnEvent_5027",once);
	end
	
--■5031■チュートリアル11■死体調べるとアイテム取得できますよメッセージ
	if proxy:IsCompleteEvent( 5031 ) == false then
		proxy:OnRegionJustIn(5031,10000,2004,"OnEvent_5031",once);
	end

--■1100■待機のままの腐敗人■
	if proxy:IsCompleteEvent( 1100 ) == false then
		proxy:OnKeyTime2(1100, "OnEvent_1100" , 1 , 0 , 1 , once );
	end

--■5000■宝死体A■→矢を取得→武器の入れ替えメッセージ表示
	if proxy:IsCompleteEvent( 5000 ) ==false then
		proxy:OnDistanceAction( 5000, 10000, 1040, "OnEvent_5000", ItemBoxDist_A, HELPID_CHECK_GLOWING_CORPS, 0, ItemBoxAngle_A, once );
		proxy:TreasureDispModeChange( 1040, true );
	end

--■5010■宝死体B■→ポーション取得→アイテム説明のメッセージ表示
	if proxy:IsCompleteEvent( 5010 ) ==false then
		proxy:OnDistanceAction( 5010, 10000, 1041, "OnEvent_5010", ItemBoxDist_A, HELPID_CHECK_GLOWING_CORPS, 0, ItemBoxAngle_A, once );
		proxy:TreasureDispModeChange( 1041, true );
	end

	
--■??■徘徊デーモンの登場■ハンドラ登録
	proxy:NotNetMessage_begin();
		--プレイヤーがソロで死亡した時にキックされます。
		proxy:LuaCall( 4000, 100, "PlayerDeath_m99_99_10_00", everytime );
		--プレイヤーが復活した時にキックされます。
		proxy:LuaCall( 4032, 100, "PlayerRevive_m99_99_10_00", everytime );
	proxy:NotNetMessage_end();
	
	
--■999910■フレーム遅れの初期化処理イベントを発行■
	proxy:NotNetMessage_begin();
		--▼0秒後▼--
		proxy:OnKeyTime2( 999910, "Second_Initialize_m99_99_10_00", 0.1, 0, 0, once );	
	proxy:NotNetMessage_end();	
	
	
	print("Initialize m99_99_10_00 end");
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
--■999910■初期化■
function Second_Initialize_m99_99_10_00(proxy, param)
	print("Second_Initialize_m99_99_10_00 begin");
	
--[[
	--■徘徊デーモン用 (フラグは仮、指定があれば変える)
	if proxy:IsCompleteEvent( 20 ) == true then
		LuaFunc_VisibleTheWanderingDemon  (proxy, param, demon_id_list_m99_99_10_00);
	else
		LuaFunc_InvisibleTheWanderingDemon(proxy, param, demon_id_list_m99_99_10_00);
	end
]]
	
	print("Second_Initialize_m99_99_10_00 end");
end



--■055■マップ移動（→砦1F)■
function OnEvent_055(proxy, param)
print("OnEvent_055 begin");
	if param:IsNetMessage()==true  then
		return;         
	end

--マルチプレイの時のエリア移動を止める
	if proxy:IsInParty() == true then
		return;
	end 

--・たどり着いたＰＣのみ、砦水路から砦（m99_99_11_00）の指定位置に移動する
--・移動先（m99_99_11_00）の対応キャライベントID
--　ＰＣ（0）→キャラ（10）
--　ＰＣ（1）→キャラ（11）
--　ＰＣ（2）→キャラ（12）
--　ＰＣ（3）→キャラ（13）
	playerId = proxy:GetLocalPlayerId();
	if playerId ==0 then proxy:WarpNextStage(99,99,11,00, 10); end
	if playerId ==1 then proxy:WarpNextStage(99,99,11,00, 11); end
	if playerId ==2 then proxy:WarpNextStage(99,99,11,00, 12); end
	if playerId ==3 then proxy:WarpNextStage(99,99,11,00, 13); end

--※移動するキャラクターは、移動時にパッと消してしまいます

print("OnEvent_055 end");
end







--■065■マップ移動（→砦2F)■
function OnEvent_065(proxy, param)
print("OnEvent_065 begin");

	if param:IsNetMessage()==true  then
		return;         
	end
--マルチプレイの時のエリア移動を止める
	if proxy:IsInParty() == true then
		return;
	end 

--・たどり着いたＰＣのみ、砦水路から砦（m99_99_11_00）の指定位置に移動する
--・移動先（m99_99_11_00）の対応キャライベントID
--　ＰＣ（0）→キャラ（20）
--　ＰＣ（1）→キャラ（21）
--　ＰＣ（2）→キャラ（22）
--　ＰＣ（3）→キャラ（23）
	playerId = proxy:GetLocalPlayerId();
	if playerId ==0 then proxy:WarpNextStage(99,99,11,00, 20); end
	if playerId ==1 then proxy:WarpNextStage(99,99,11,00, 21); end
	if playerId ==2 then proxy:WarpNextStage(99,99,11,00, 22); end
	if playerId ==3 then proxy:WarpNextStage(99,99,11,00, 23); end

--※移動するキャラクターは、移動時にパッと消します

print("OnEvent_065 end");
end


--------------------------------------------------------------------------------------
--■チュートリアル01■移動、カメラ操作説明
--------------------------------------------------------------------------------------
function OnEvent_5020(proxy,param)
	print("OnEvent_5020 begin");
	--メッセージ表示ID：80000000
	proxy:OnKeyTime2(5021,"OnEvent_5021",TO_NEXT_MESSAGE_TIME,0,0,once);
	
	proxy:SetEventFlag( 5020 , 1 );
	print("OnEvent_5020 end");
end

--------------------------------------------------------------------------------------
--■チュートリアル02・03■走り方・ステップ、スタミナ説明
--------------------------------------------------------------------------------------
function OnEvent_5021(proxy,param)
	print("OnEvent_5021 begin");
	
	proxy:SetEventFlag( 5021 , 1 );
	print("OnEvent_5021 end");
end

--------------------------------------------------------------------------------------
--■チュートリアル04■よじ登り説明
--------------------------------------------------------------------------------------
function OnEvent_5022(proxy,param)
	print("OnEvent_5022 begin");
	
	proxy:SetEventFlag( 5022 , 1 );
	print("OnEvent_5022 end");
end

--------------------------------------------------------------------------------------
--■チュートリアル05■乗り越え説明
--------------------------------------------------------------------------------------
function OnEvent_5023(proxy,param)
	print("OnEvent_5023 begin");
	
	proxy:SetEventFlag( 5023 , 1 );
	print("OnEvent_5023 end");
end

--------------------------------------------------------------------------------------
--■チュートリアル05■左手攻撃・右手攻撃方法説明
--------------------------------------------------------------------------------------
function OnEvent_5024(proxy,param)
	print("OnEvent_5024 begin");
	proxy:OnKeyTime2(5025,"OnEvent_5025",TO_NEXT_MESSAGE_TIME,0,0,once);		
	
	proxy:SetEventFlag( 5024 , 1 );
	print("Onevent_5024 end");
end

--------------------------------------------------------------------------------------
--■チュートリアル06■溜め攻撃方法説明
--------------------------------------------------------------------------------------
function OnEvent_5025(proxy,param)
	print("OnEvent_5025 begin");
	proxy:OnKeyTime2(5026,"OnEvent_5026",TO_NEXT_MESSAGE_TIME,0,0,once);	
	
	proxy:SetEventFlag( 5025 , 1 );
	print("OnEvent_5025 end");
end

--------------------------------------------------------------------------------------
--■チュートリアル07■両手・片手攻撃方法説明
--------------------------------------------------------------------------------------
function OnEvent_5026(proxy,param)
	print("OnEvent_5026 begin");
	
	proxy:SetEventFlag( 5026 , 1 );
	print("OnEvent_5026 end");
end

--------------------------------------------------------------------------------------
--■チュートリアル08■魔法攻撃方法説明
--------------------------------------------------------------------------------------
function OnEvent_5027(proxy,param)
	print("OnEvent_5027 begin");
	
	proxy:SetEventFlag( 5027 , 1 );
	print("Onevent_5027 end");
end

--------------------------------------------------------------------------------------
--■チュートリアル09■弓矢攻撃方法説明
--------------------------------------------------------------------------------------
function OnEvent_5028(proxy,param)
	print("OnEvent_5028 begin");
	proxy:OnKeyTime2(5029,"OnEvent_5029",TO_NEXT_MESSAGE_TIME,0,0,once);

	proxy:SetEventFlag( 5028 , 1 );
	print("Onevent_5028 end");
end

--------------------------------------------------------------------------------------
--■チュートリアル10■武器の入れ替え方法説明
--------------------------------------------------------------------------------------
function OnEvent_5029(proxy,param)
	print("OnEvent_5029 begin");
	
	proxy:SetEventFlag( 5029 , 1 );
	print("Onevent_5029 end");
end

--------------------------------------------------------------------------------------
--■チュートリアル11■アイテム説明
--------------------------------------------------------------------------------------
function OnEvent_5030(proxy,param)
	print("OnEvent_5030 begin");
	
	proxy:SetEventFlag( 5030 , 1 );
	print("Onevent_5030 end");
end

--------------------------------------------------------------------------------------
--■チュートリアル12■実は死体調べるとアイテム取得できるんですよ。
--------------------------------------------------------------------------------------
function OnEvent_5031(proxy,param)
	print("OnEvent_5031 begin");
	
	proxy:SetEventFlag( 5031 , 1 );
	print("Onevent_5031 end");
end



--------------------------------------------------------------------------------------
--■待機のままの腐敗人■
--------------------------------------------------------------------------------------
function OnEvent_1100(proxy,param)
	print("OnEvent_1100 begin");

	proxy:PlayLoopAnimation( 100 , 0 );--待機アニメの再生
	
	print("Onevent_1100 end");
end



--------------------------------------------------------------------------------------
--■宝死体A■
--------------------------------------------------------------------------------------
--■5000■宝死体A■
function OnEvent_5000(proxy,param)
	print("OnEvent_5000 begin");

	proxy:PlayAnimation( 10000 , ANIMEID_PICK );
	
	proxy:NotNetMessage_begin();
		--▼5000_1▼0秒後▼
		proxy:OnKeyTime2( 5000, "OnEvent_5000_1", 0.0, 0, 0, once );
	proxy:NotNetMessage_end();
	
	print("Onevent_5000 end");
end


--■5000_1■0秒後 アイテムの取得■
function OnEvent_5000_1(proxy, param)
	print("OnEvent_5000_1 begin");
	
	proxy:SetEventFlag( 5000 , 1 );

--[[ 2種類同時取得は無理･･･?

	--ショートボウ
	proxy:GetItem(130000,TYPE_WEAPON);			 --アイテム取得の表示処理
	proxy:AddInventoryItem(130000,TYPE_WEAPON,1);--実際のアイテム取得(数量を変化させる)
]]
	--矢
	proxy:GetItem(160000,TYPE_WEAPON);
	proxy:AddInventoryItem(160000,TYPE_WEAPON,99);
	proxy:TreasureDispModeChange( 1040, false ); --アイテムを取得したので、宝が光っているのを消す
	
	--弓矢攻撃のメッセージ表示
	proxy:OnKeyTime2(5028,"OnEvent_5028",GET_ITEM_TO_NEXT_MESSAGE_TIME,0,0,once);	

	print("OnEvent_5000_1 end");
end


--------------------------------------------------------------------------------------
--■宝死体B■
--------------------------------------------------------------------------------------
--■5010■宝死体B■
function OnEvent_5010(proxy,param)
	print("OnEvent_5010 begin");
	
	proxy:PlayAnimation( 10000 , ANIMEID_PICK );
	
	proxy:NotNetMessage_begin();
		--▼5010_1▼0秒後▼
		proxy:OnKeyTime2( 5010, "OnEvent_5010_1", 0.0, 0, 0, once );
	proxy:NotNetMessage_end();
	
	print("Onevent_5010 end");
end


--■5010_1■0秒後 アイテムの取得■
function OnEvent_5010_1(proxy, param)
	print("OnEvent_5010_1 begin");
	
	proxy:SetEventFlag( 5010 , 1 );
	
	--ポーション10個
	proxy:GetItem(1,TYPE_GOODS);				--アイテム取得の表示処理
	proxy:AddInventoryItem(1,TYPE_GOODS,10);	--実際のアイテム取得(数量を変化させる)
	proxy:TreasureDispModeChange( 1041, false );--アイテムを取得したので、宝が光っているのを消す
	
	--アイテム説明のメッセージ表示
	proxy:OnKeyTime2(5030,"OnEvent_5030",GET_ITEM_TO_NEXT_MESSAGE_TIME,0,0,once);
	
	print("OnEvent_5010_1 end");
end



--------------------------------------------------------------------------------------
--徘徊デーモンの登場■??
--------------------------------------------------------------------------------------

--▼グローバルの死亡監視から呼ばれる(ソロ)
function PlayerDeath_m99_99_10_00(proxy, param)
	print("PlayerDeath_m99_99_10_00");
	
--	LuaFunc_VisibleTheWanderingDemon(proxy, param, demon_id_list_m99_99_10_00);
--	proxy:SetEventFlag( 20 , 1 );--フラグは仮、指定があれば変える。
	
	print("PlayerDeath_m99_99_10_00");
end

--▼グローバルの血文字復活から呼ばれる(ソロ)
function PlayerRevive_m99_99_10_00(proxy,param)
	print("PlayerRevive_m99_99_10_00");
	
--	LuaFunc_InvisibleTheWanderingDemon(proxy, param, demon_id_list_m99_99_10_00);
--	proxy:SetEventFlag( 20 , 0 );--フラグは仮、指定があれば変える。
	
	print("PlayerRevive_m99_99_10_00");
end

