once = 1;
everytime = 0;





function Initialize_m99_99_11_00(proxy)
print("Initialize m99_99_11_00 begin");


--[[▼チュートリアル用のイベント]]



--■1000■ハシゴA(斜め10度)降り■
	proxy:OnActionEventRegion(1000, 2100, "OnEvent_1000", LadderAngle_A, HELPID_DOWN, everytime);
--■1001■ハシゴA(斜め10度)昇り■
	proxy:OnActionEventRegion(1001, 2101, "OnEvent_1001", LadderAngle_A, HELPID_UP,   everytime);

	


	
--■6000■NPC会話■--汎用会話一挙登録(入力判定、可聴判定、範囲外判定)	※ValueBuffer　20010使
	if proxy:IsCompleteEvent( 6000 ) == false then
		OnTalk(proxy,6000,101,TalkDist_N,TalkAngle_N,20010,HELPID_TALK,"OnEvent_6000","OnEvent_6000_1","OnEvent_6000_2",everytime);
		--■1103■NPC会話:PCから攻撃をされた処理■--NPC(101)がプレイヤーから攻撃された時
		proxy:OnSimpleDamage(1103,101,10000,"OnEvent_1103",everytime);
		--■1101■NPC会話：死亡処理■--PCがイベントID101のHPを0にしたとき
		proxy:OnCharacterHP(1101,101,"OnEvent_1101",0.0,once);
		--■1102■NPC会話：完全死亡処理■--イベントID101が完全に死んだとき
		proxy:OnCharacterDead(1102,101,"OnEvent_1102",once);
	end
	
		

--エリアリセットしないようにフラグ変えました。

--■6020■扉を開ける■
--ＰＣが、イベントエリア(1)の中に居て、
--特定の角度を向いていて、
--アクションボタンを押したとき
	if proxy:IsCompleteEvent( 6020 ) == false then
		proxy:OnPlayerActionInRegionAngle( 6020, 1, "OnEvent_6020", 30, HELPID_PULL_LEVER, once);
	else
		proxy:EndAnimation( 1, 1 );--レバー
		proxy:EndAnimation( 2, 1 );--扉
	end

		
--エリアリセットしないようにフラグ変えました。

--■6010■崩れる柱1
--・ＰＣ又はヘビ兵士（c0000/6010）が、イベントエリア（2）に到達したとき
	if proxy:IsCompleteEvent( 6010 ) == false then
		proxy:OnRegionJustIn( 6010, 10000, 2, "OnEvent_6010", once);
	end

--■6011■蛇兵士起動?
--・ＰＣが、イベントエリア（3）に到達したとき
	if proxy:IsCompleteEvent( 6011 ) == false then
		proxy:OnRegionJustIn( 6011, 10000, 3, "OnEvent_6011", once);
	end

--■6012■崩れる柱2
--・ＰＣまたはヘビ兵士（c0000/6011）が、イベントエリア（4）に到達したとき
	if proxy:IsCompleteEvent( 6012 ) == false then
		proxy:OnRegionJustIn( 6012, 10000, 4, "OnEvent_6012", once);	
	end		
		

		
		
--エリアリセットしないようにフラグ変えました。

		
--■6030■デブデーモン部屋扉開放
--・デブデーモン(120)死亡演出イベント（イベントID122）が、終了したとき
	if proxy:IsCompleteEvent( 6030 ) == false then
		proxy:OnCharacterDead( 6030, 120, "OnEvent_6030", once);
	else
		proxy:EndAnimation( 123 , 1 );
	end
	
	
		

--[[▼今まであったイベント]]


--	誰が無視　プレイアだけ
--	EventID, Who(無視), RegionID, handler, bOnce	

--[[　以前のです。

--■131■扉を開ける■
--ＰＣが、イベントエリア(1)の中に居て、
--特定の角度を向いていて、
--アクションボタンを押したとき
	proxy:OnPlayerActionInRegionAngle( 131, 1, "OnEvent_131", 30, HELPID_PULL_LEVER, once);

]]


	
--[[ 以前のです。

--■102■崩れる柱1
--・ＰＣ又はヘビ兵士（c0000/102）が、イベントエリア（2）に到達したとき
	proxy:OnRegionJustIn( 102, 10000, 2, "OnEvent_102", once);


--■103■崩れる柱1
--・ＰＣが、イベントエリア（3）に到達したとき
	proxy:OnRegionJustIn( 103, 10000, 3, "OnEvent_103", once);


--■104■崩れる柱2
--・ＰＣまたはヘビ兵士（c0000/103）が、イベントエリア（4）に到達したとき
	proxy:OnRegionJustIn( 104, 10000, 4, "OnEvent_104", once);
]]
	
	
--■110■血文字再生1
--・ＰＣがイベントエリア(10)内でアクションボタンを押した時
	
	--proxy:OnPlayerActionInRegion( 110, 10, "OnEvent_110",1, everytime);

	
--[[ 以前のです。

--■123■デブデーモン部屋扉開放
--・デブデーモン(120)死亡演出イベント（イベントID122）が、終了したとき
	proxy:OnCharacterDead( 123, 120, "OnEvent_123", once);
	
]]	
	
	
	

--■155■マップ移動（→砦水路1Ｆ）
--・ＰＣが、イベントエリア（55）に到達したとき
	proxy:OnRegionJustIn( 155, 10000, 55, "OnEvent_155", everytime);


--■165■マップ移動（→砦水路2Ｆ）
--・ＰＣが、イベントエリア（65）に到達したとき
	proxy:OnRegionJustIn( 165, 10000, 65, "OnEvent_165", everytime);


--■175■マップ移動（→溶岩広場）
--・ＰＣが、イベントエリア（75）に到達したとき
	proxy:OnRegionJustIn( 175, 10000, 75, "OnEvent_175", everytime);
	
	
--■??■徘徊デーモンの登場■ハンドラ登録
	proxy:NotNetMessage_begin();
		--プレイヤーがソロで死亡した時にキックされます。
		proxy:LuaCall( 4000, 100, "PlayerDeath_m99_99_11_00", everytime );
		--プレイヤーが復活した時にキックされます。
		proxy:LuaCall( 4032, 100, "PlayerRevive_m99_99_11_00", everytime );
	proxy:NotNetMessage_end();
	
	
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 99998, "MapInit", 0.0, 0, 0, once );
	proxy:NotNetMessage_end();


print("Initialize m99_99_11_00 end");
end

function MapInit(proxy,param )

--[[まえに書いてあったもの

	if proxy:IsCompleteEvent( 102 ) ==true then
--		proxy:ChangeModel(20, 1);
--		proxy:SetBrokenPiece(20);
		proxy:ReconstructBreak( 20 , 1 );
	end
	if proxy:IsCompleteEvent(131) ==true then
		proxy:EndAnimation(1, 1);
		proxy:EndAnimation(2, 1);
	end
]]


--NPCの死亡再現

	if proxy:IsCompleteEvent( 6000 ) == true then
		proxy:ForceDead( 101 );
	end

--中ボスの死亡再現
	
	if proxy:IsCompleteEvent( 6030 ) == true then
		proxy:ForceDead( 120 );
	end

--ロジック制御

--■6011■蛇兵士起動?
	if proxy:IsCompleteEvent( 6011 ) == true then
		proxy:EnableLogic( 103 , 1 );
	else
		proxy:EnableLogic( 103 , 0 );
	end
	
	
--柱の破壊再現(エリア入りなおしたとき用)
	
--■6010■崩れる柱1
	if proxy:IsCompleteEvent( 6010 ) == true then
		proxy:ReconstructBreak( 20 , 1 );
	end

--■6012■崩れる柱2
	if proxy:IsCompleteEvent( 6012) == true then
		proxy:ReconstructBreak( 41 , 1 );
	end

--[[
	--■徘徊デーモン用 (フラグは仮、指定があれば変える)
	if proxy:IsCompleteEvent( 20 ) == true then
		LuaFunc_VisibleTheWanderingDemon  (proxy, param, demon_id_list_m99_99_11_00);
	else
		LuaFunc_InvisibleTheWanderingDemon(proxy, param, demon_id_list_m99_99_11_00);
	end
]]

end

--------------------------------------------------------------------------------------
--マルチになった時にホストじゃ無かったら■無し
--------------------------------------------------------------------------------------
function ConnectPartyEvent(proxy)
	print("ConnectPartyEvent begin");
	print("ConnectPartyEvent end");
end





--[[ チュートリアル用 ]]


--■6020■扉を開ける
function OnEvent_6020(proxy, param)
print("OnEvent_6020 begin");

	if param:IsNetMessage()==true  then
		return;         
	end

--・PCをイベントエリア(100)に移動
	proxy:Warp(10000, 100);
--・PCのレバー動作アニメーション(ID 4000)再生
	proxy:PlayAnimation(10000, 8000);
	
--・イベントフラグを立てる
	proxy:SetEventFlag( 6020, 1 );
--・スイッチＯＢＪ（o0210/1）が作動するアニメーション（ID 1）を再生
--　（あれば）作動ＳＥ（ID****）を鳴らす
	proxy:PlayAnimation(1, 1)

--・同時に扉ＯＢＪ（o0211/2）が開くアニメーション（ID 1）を再生
--　（あれば）扉が開くＳＥ（ID****）を鳴らす
--・扉の当たりを動かし、移動できるようにする
	proxy:PlayAnimation(2, 1)

print("OnEvent_6020 end");
end




--■6010■崩れる柱1
function OnEvent_6010(proxy, param)
print("OnEvent_6010 begin");

--・イベントフラグを立てる
	proxy:SetEventFlag( 6010, 1 );
--・天井ＯＢＪ（o0224/20）を
--　ハボックＯＢＪ（o0224_1/20）に差し替えて、落下させる
	proxy:ChangeModel(20, 1);
	proxy:SetBrokenPiece(20);

--・ハボックＯＢＪに攻撃あたりを発生させる
--・ハボックＯＢＪがキャラクターのカプセルあたりに当たった場合、
--　ダメージモーションを再生する
--・ハボックＯＢＪの攻撃あたりは、床、壁あたりにあたった時点で消す
--・（あれば）柱がぶつかるＳＥ（ID****）を鳴らす

print("OnEvent_6010 end");
end



--■6011■ヘビ兵士起動
function OnEvent_6011(proxy, param)
print("OnEvent_6011 begin");

--・ヘビ兵士（c1000/6011）のロジックを通常に切り替える
	proxy:EnableLogic(103, true);

print("OnEvent_6011 end");
end




--■6012■崩れる柱2
function OnEvent_6012(proxy, param)
print("OnEvent_6012 begin");

--・イベントフラグを立てる
	proxy:SetEventFlag( 6012, 1 );
--・柱ＯＢＪ（o0225/41）を
--　ハボックＯＢＪ（o0225_1/41）に差し替えて、落下させる

	proxy:ChangeModel(41, 1);
	proxy:SetBrokenPiece(41);

--・ハボックＯＢＪに攻撃あたりを発生させる
--・ハボックＯＢＪがキャラクターのカプセルあたりに当たった場合、
--　ダメージモーションを再生する
--・ハボックＯＢＪの攻撃あたりは、床、壁あたりにあたった時点で消す
--・（あれば）柱がぶつかるＳＥ（ID****）を鳴らす

print("OnEvent_6012 end");
end





--■6030■デブデーモン部屋扉開放
function OnEvent_6030(proxy, param)
print("OnEvent_6030 begin");

--・イベントフラグを立てる
	proxy:SetEventFlag( 6030, 1 );

--・デブデーモン部屋の扉（o0212/6030)の開くアニメーション（ID 1)を再生
--・（あれば）扉が開くSEを鳴らす
--・扉の当たりを動かし、ＰＣが通れるようにする。
	proxy:PlayAnimation(123, 1)


print("OnEvent_6030 end");
end



--------------------------------------------------------------------------------------
--ハシゴB降り■1000
--------------------------------------------------------------------------------------
--■1000■ハシゴB降りスタート■
function OnEvent_1000(proxy, param)
	print("OnEvent_1000 begin");
	
	if param:IsNetMessage() == true then
		print("IsNetMessage true");
		print("OnEvent_1000 end");
		return;
	end

	--はしご降りに必要な前処理--
	proxy:BeginAction(10000,2,2,2);				--ホバー移動モードに移行
	proxy:HoverMoveVal(10000,2102,LadderTime_A);--移動位置(2102)に0.5秒でホバー移動
	proxy:SetEventCommand(10000,1);				--イベントコマンドID(1)"ハシゴ上から掴"むを送る
	proxy:SetKeepCommandIndex(10000, 4, 1, 3.0 );
	proxy:DisableMove(10000,1);					--キャラクタを移動、旋回不能に
	
	proxy:NotNetMessage_begin();
		--0.5秒(ホバー移動終了)後にはしご降りスタートイベントを発行
		proxy:OnKeyTime2(1000,"OnEvent_1000_1",LadderTime_A,0,0,once);
		--はしご降り専用の関数を3秒間発行(カメラの周り込みなどの処理)
		proxy:OnKeyTime2(1000,"LadderDown",3,1,1,once);
	proxy:NotNetMessage_end();

	print("OnEvent_1000 end");
end

--■1000_1■ハシゴB降りスタート:ホバー移動終了■
function OnEvent_1000_1(proxy, param)
	print("OnEvent_1000_1 begin");
	
	if proxy:GetEventMode(10000) == 0 then
		print("Local Player GetEventMode 0");
		print("OnEvent_1000_1 end");
		return;
	end

	--ハシゴアクションモードに移行--
	--nMax  : はしごの段数 - 補正値(補正値はおおよそ3)
	--nStart: 降りるとき→(nMax + 1) 昇るとき→(-1)
	proxy:BeginAction(10000,1,8,7);
	
	--キャラクタを移動、旋回可能に--
	proxy:DisableMove(10000,0);
	
	print("OnEvent_1000_1 end");
end


--------------------------------------------------------------------------------------
--ハシゴB昇り■1001
--------------------------------------------------------------------------------------
--■1001■ハシゴB昇りスタート■
function OnEvent_1001(proxy, param)
	print("OnEvent_1001 begin");
	
	if param:IsNetMessage() == true then
		print("IsNetMessage true");
		print("OnEvent_1001 end");
		return;
	end
	
	--はしご昇りに必要な前処理--
	proxy:BeginAction(10000,2,-1,1);			--ホバー移動モードに移行
	proxy:HoverMoveVal(10000,2103,LadderTime_A);--移動位置(2103)に0.5秒でホバー移動
	proxy:SetEventCommand(10000,0);				--イベントコマンドID(0)"ハシゴ下から掴"むを送る
	proxy:SetKeepCommandIndex(10000, 4, 1, 3.0 );
	proxy:DisableMove(10000,1);					--キャラクタを移動、旋回不能に
	
	proxy:NotNetMessage_begin();
		--0.5秒(ホバー移動終了)後にはしご昇りスタートイベントを発行
		proxy:OnKeyTime2(1001,"OnEvent_1001_1",LadderTime_A,0,0,once);
		--はしご昇り用の関数を1秒間発行(イベントメニューの中断処理?)
		proxy:OnKeyTime2(1001,"EventMenuBrake",1,1,1,once);
	proxy:NotNetMessage_end();
	
	print("OnEvent_1001 end");
end

--■1001_1■ハシゴA昇りスタート:ホバー移動終了■
function OnEvent_1001_1(proxy, param)
	print("OnEvent_1001_1 begin");
	
	if proxy:GetEventMode(10000) == 0 then
		print("Local Player GetEventMode 0");
		print("OnEvent_1001_1 end");
		return;
	end

	--ハシゴアクションモードに移行--
	--nMax  : はしごの段数 - 補正値(補正値はおおよそ3)
	--nStart: 降りるとき→(nMax + 1) 昇るとき→(-1)
	proxy:BeginAction(10000,1,-1,7);
	
	--キャラクタを移動、旋回可能に--
	proxy:DisableMove(10000,0);
	
	print("OnEvent_1001_1 end");
end




--------------------------------------------------------------------------------------
--NPC会話■6000※ValueBuffer 20010使用
--------------------------------------------------------------------------------------
--■6000■NPC会話■AnctionButton判定
function OnEvent_6000(proxy, param)
	print("OnEvent_6000 begin");
	if param:IsNetMessage()==true  then
		return;
	end
	
	FlagValue = proxy:IsCompleteEventValue(20010);

	if FlagValue ==0 then proxy:SetEventFlag( 20010, 1 ); end
	if FlagValue ==1 then
		proxy:SetEventFlag( 20010, 0 );		
	end
	print("OnEvent_6000 end");
end

--■6000_1■NPC会話■現在表示するメッセージ
function OnEvent_6000_1(proxy, param)
	print("OnEvent_6000_1 begin");
	
	--ValueBuffer20010の値を取得する
	FlagValue = proxy:IsCompleteEventValue(20010);
	--ページを捲ってなければ抜ける
	if FlagValue ==0 then return;	 end
	if FlagValue ==1 then proxy:StartTalk(80000130,0);	 end
	
	if FlagValue ==4 then proxy:StartTalk(90000700,0);	 end--死んでるとき？
	
	print("OnEvent_6000_1 end");
end

--■6000_2■NPC会話■反応距離から出た場合の処理
function OnEvent_6000_2(proxy, param)
	print("OnEvent_6000_2 begin");

	--ValueBuffer20010の値を取得する
	FlagValue = proxy:IsCompleteEventValue(20010);

	if FlagValue >=1 then
		proxy:SetEventFlag( 20010, 0 );		
	end

	print("OnEvent_6000_2 end");
end

--■1101■NPC会話■NPCのHPが0になった瞬間
function OnEvent_1101(proxy, param)
	print("OnEvent_1101 begin");
	--殺した時の距離が範囲内なら
	if proxy:IsDistance(10000,101,TalkDist_N) == true then	
		--ValueBuffer20010の値を設定する
		proxy:SetEventFlag(20010,4);
	else
		--範囲外ならページを何も表示しないページに
		--ValueBuffer20010の値を設定する
		proxy:SetEventFlag(20010,5);
	
	end
		
	print("OnEvent_1101 end");
end

--■1102■NPC会話■NPC死んだ
function OnEvent_1102(proxy, param)
	print("OnEvent_1102 begin");
	--ValueBuffer20010の値を設定する
	proxy:SetEventFlag(20010,0 );
	proxy:SetEventFlag(6000,1);
	--キャラクタが死んで必要なくなるので会話イベントを削除する
	proxy:DeleteEvent(6000);
	proxy:DeleteEvent(1103);
	print("OnEvent_1102 end");
end

--■1103■NPC会話:PCから攻撃された処理■
function OnEvent_1103(proxy, param)
	print("OnEvent_1103 begin");
	if proxy:IsDistance(10000,101,TalkDist_N) == false then
		return ;
	end
	print("OnEvent_1103 end");
end






















--[[以前のです。]]


--[[

--■131■扉を開ける
function OnEvent_131(proxy, param)
print("OnEvent_131 begin");

	if param:IsNetMessage()==true  then
		return;         
	end

--・PCをイベントエリア(100)に移動
	proxy:Warp(10000, 100);
--・PCのレバー動作アニメーション(ID 4000)再生
	proxy:PlayAnimation(10000, 8000);
	
--・イベントフラグを立てる
	proxy:SetEventFlag( 131, 1 );
--・スイッチＯＢＪ（o0210/1）が作動するアニメーション（ID 1）を再生
--　（あれば）作動ＳＥ（ID****）を鳴らす
	proxy:PlayAnimation(1, 1)

--・同時に扉ＯＢＪ（o0211/2）が開くアニメーション（ID 1）を再生
--　（あれば）扉が開くＳＥ（ID****）を鳴らす
--・扉の当たりを動かし、移動できるようにする
	proxy:PlayAnimation(2, 1)

print("OnEvent_131 end");
end

]]







--[[

--■102■崩れる柱1
function OnEvent_102(proxy, param)
print("OnEvent_102 begin");

--・イベントフラグを立てる
	proxy:SetEventFlag( 102, 1 );
--・天井ＯＢＪ（o0224/20）を
--　ハボックＯＢＪ（o0224_1/20）に差し替えて、落下させる
	proxy:ChangeModel(20, 1);
	proxy:SetBrokenPiece(20);

--・ハボックＯＢＪに攻撃あたりを発生させる
--・ハボックＯＢＪがキャラクターのカプセルあたりに当たった場合、
--　ダメージモーションを再生する
--・ハボックＯＢＪの攻撃あたりは、床、壁あたりにあたった時点で消す
--・（あれば）柱がぶつかるＳＥ（ID****）を鳴らす

print("OnEvent_102 end");
end






--■103■ヘビ兵士起動
function OnEvent_103(proxy, param)
print("OnEvent_103 begin");

--・ヘビ兵士（c1000/103）のロジックを通常に切り替える
	proxy:EnableLogic(103, true);

print("OnEvent_103 end");
end






--■104■崩れる柱2
function OnEvent_104(proxy, param)
print("OnEvent_104 begin");

--・イベントフラグを立てる
	proxy:SetEventFlag( 104, 1 );
--・柱ＯＢＪ（o0225/41）を
--　ハボックＯＢＪ（o0225_1/41）に差し替えて、落下させる

	proxy:ChangeModel(41, 1);
	proxy:SetBrokenPiece(41);

--・ハボックＯＢＪに攻撃あたりを発生させる
--・ハボックＯＢＪがキャラクターのカプセルあたりに当たった場合、
--　ダメージモーションを再生する
--・ハボックＯＢＪの攻撃あたりは、床、壁あたりにあたった時点で消す
--・（あれば）柱がぶつかるＳＥ（ID****）を鳴らす

print("OnEvent_104 end");
end


]]



--■110■血文字再生1
--・ＰＣがイベントエリア(10)内でアクションボタンを押した時
function OnEvent_110(proxy, param)
print("OnEvent_110 begin");
--・リプレイゴースト（****/110）出現演出
--・リプレイゴーストのアニメーション（ID****）を再生
--＞ゴーストのルートは３Ｄさんと相談
--
--※血文字は、演出不要（ＳＦＸ、サウンドともに）

	proxy:BeginReplayGhost(0);


print("OnEvent_110 end");
end



--[[

--■123■デブデーモン部屋扉開放
function OnEvent_123(proxy, param)
print("OnEvent_123 begin");

--・イベントフラグを立てる
	proxy:SetEventFlag( 123, 1 );

--・デブデーモン部屋の扉（o0212/123)の開くアニメーション（ID 1)を再生
--・（あれば）扉が開くSEを鳴らす
--・扉の当たりを動かし、ＰＣが通れるようにする。
	proxy:PlayAnimation(123, 1)


print("OnEvent_123 end");
end

]]




--■155■マップ移動（→砦水路1Ｆ）
function OnEvent_155(proxy, param)
print("OnEvent_155 begin");
	if param:IsNetMessage()==true  then
		return;         
	end
--マルチプレイの時のエリア移動を止める
	if proxy:IsInParty() == true then
		return;
	end 

--・たどり着いたＰＣのみ、砦から砦水路（m99_99_10_00）の指定位置に移動する
--・移動先（m99_99_10_00）の対応キャライベントID
--　ＰＣ（0）→キャラ（10）
--　ＰＣ（1）→キャラ（11）
--　ＰＣ（2）→キャラ（12）
--　ＰＣ（3）→キャラ（13）
	playerId = proxy:GetLocalPlayerId();
	if playerId ==0 then proxy:WarpNextStage(99,99,10,00, 10); end
	if playerId ==1 then proxy:WarpNextStage(99,99,10,00, 11); end
	if playerId ==2 then proxy:WarpNextStage(99,99,10,00, 12); end
	if playerId ==3 then proxy:WarpNextStage(99,99,10,00, 13); end

--※移動するキャラクターは、移動時にパッと消してしまいます

print("OnEvent_155 end");
end






--■165■マップ移動（→砦水路2Ｆ）
function OnEvent_165(proxy, param)
print("OnEvent_165 begin");
	if param:IsNetMessage()==true  then
		return;         
	end
--マルチプレイの時のエリア移動を止める
	if proxy:IsInParty() == true then
		return;
	end 

--・たどり着いたＰＣのみ、砦から砦水路（m99_99_10_00）の指定位置に移動する
--・移動先（m99_99_10_00）の対応キャライベントID
--　ＰＣ（0）→キャラ（20）
--　ＰＣ（1）→キャラ（21）
--　ＰＣ（2）→キャラ（22）
--　ＰＣ（3）→キャラ（23）
	playerId = proxy:GetLocalPlayerId();
	if playerId ==0 then proxy:WarpNextStage(99,99,10,00, 20); end
	if playerId ==1 then proxy:WarpNextStage(99,99,10,00, 21); end
	if playerId ==2 then proxy:WarpNextStage(99,99,10,00, 22); end
	if playerId ==3 then proxy:WarpNextStage(99,99,10,00, 23); end

--※移動するキャラクターは、移動時にパッと消してしまいます

print("OnEvent_165 end");
end






--■175■マップ移動（→溶岩広場）
function OnEvent_175(proxy, param)
print("OnEvent_175 begin");
	if param:IsNetMessage()==true  then
		return;         
	end
--マルチプレイの時のエリア移動を止める
	if proxy:IsInParty() == true then
		return;
	end 

--・たどり着いたＰＣのみ、砦から溶岩広場（m99_99_12_00）の指定位置に移動
--・移動先（m99_99_12_00）の対応キャライベントID
--　ＰＣ（0）→キャラ（30）
--　ＰＣ（1）→キャラ（31）
--　ＰＣ（2）→キャラ（32）
--　ＰＣ（3）→キャラ（33）
	playerId = proxy:GetLocalPlayerId();
	if playerId ==0 then proxy:WarpNextStage(99,99,12,00, 30); end
	if playerId ==1 then proxy:WarpNextStage(99,99,12,00, 31); end
	if playerId ==2 then proxy:WarpNextStage(99,99,12,00, 32); end
	if playerId ==3 then proxy:WarpNextStage(99,99,12,00, 33); end

--※移動するキャラクターは、移動時にパッと消してしまいます

print("OnEvent_175 end");
end




--------------------------------------------------------------------------------------
--徘徊デーモンの登場■??
--------------------------------------------------------------------------------------

--▼グローバルの死亡監視から呼ばれる(ソロ)
function PlayerDeath_m99_99_11_00(proxy, param)
	print("PlayerDeath_m99_99_11_00");
	
--	LuaFunc_VisibleTheWanderingDemon(proxy, param, demon_id_list_m99_99_11_00);
--	proxy:SetEventFlag( 20 , 1 );--フラグは仮、指定があれば変える。
	
	print("PlayerDeath_m99_99_11_00");
end

--▼グローバルの血文字復活から呼ばれる(ソロ)
function PlayerRevive_m99_99_11_00(proxy,param)
	print("PlayerRevive_m99_99_11_00");
	
--	LuaFunc_InvisibleTheWanderingDemon(proxy, param, demon_id_list_m99_99_11_00);
--	proxy:SetEventFlag( 20 , 0 );--フラグは仮、指定があれば変える。
	
	print("PlayerRevive_m99_99_11_00");
end


