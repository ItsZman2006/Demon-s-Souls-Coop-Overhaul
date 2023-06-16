once = 1;
everytime = 0;



function Initialize_m99_99_11_01(proxy)
print("Initialize m99_99_11_01 begin");


--	誰が無視　プレイアだけ
--	EventID, Who(無視), RegionID, handler, bOnce	


--■101■扉を開ける■
--ＰＣが、イベントエリア(1)の中に居て、
--特定の角度を向いていて、
--アクションボタンを押したとき
	proxy:OnPlayerActionInRegionAngle( 101, 1, "OnEvent_101", 30,1, once);

--■131■扉を開ける■
--ＰＣが、イベントエリア(1)の中に居て、
--特定の角度を向いていて、
--アクションボタンを押したとき

	proxy:OnPlayerActionInRegionAngle( 131, 1, "OnEvent_131", 30,1, once);


--■102■崩れる柱1
--・ＰＣ又はヘビ兵士（c0000/102）が、イベントエリア（2）に到達したとき
	proxy:OnRegionJustIn( 102, 10000, 2, "OnEvent_102", once);


--■103■崩れる柱1
--・ＰＣが、イベントエリア（3）に到達したとき
	proxy:OnRegionJustIn( 103, 10000, 3, "OnEvent_103", once);


--■104■崩れる柱2
--・ＰＣまたはヘビ兵士（c0000/103）が、イベントエリア（4）に到達したとき
	proxy:OnRegionJustIn( 104, 10000, 4, "OnEvent_104", once);


--■110■血文字再生1
--・ＰＣがイベントエリア(10)内でアクションボタンを押した時
	proxy:OnPlayerActionInRegion( 110, 10, "OnEvent_110",1, everytime);


--■123■デブデーモン部屋扉開放
--・デブデーモン(120)死亡演出イベント（イベントID122）が、終了したとき
	proxy:OnCharacterDead( 123, 120, "OnEvent_123", once);


--■155■マップ移動（→砦水路1Ｆ）
--・ＰＣが、イベントエリア（55）に到達したとき
	proxy:OnRegionJustIn( 155, 10000, 55, "OnEvent_155", everytime);


--■165■マップ移動（→砦水路2Ｆ）
--・ＰＣが、イベントエリア（65）に到達したとき
	proxy:OnRegionJustIn( 165, 10000, 65, "OnEvent_165", everytime);


--■175■マップ移動（→溶岩広場）
--・ＰＣが、イベントエリア（75）に到達したとき
	proxy:OnRegionJustIn( 175, 10000, 75, "OnEvent_175", everytime);


print("Initialize m99_99_11_01 end");
end







--■101■扉を開ける
function OnEvent_101(proxy, param)
print("OnEvent_101 begin");
	if param:IsNetMessage()==TRUE  then
		return;         
	end


--・イベントフラグを立てる
	proxy:SetEventFlag( 101, true );
--・PCをイベントエリア(100)に移動
	proxy:Warp(10000, 100);
--・PCのレバー動作アニメーション(ID 4000)再生
	proxy:PlayAnimation(10000, 4000);

print("OnEvent_101 end");
end
--■131■扉を開ける
function OnEvent_131(proxy, param)
print("OnEvent_131 begin");

--・イベントフラグを立てる
	proxy:SetEventFlag( 131, true );
--・スイッチＯＢＪ（o0210/1）が作動するアニメーション（ID 1）を再生
--　（あれば）作動ＳＥ（ID****）を鳴らす
	proxy:PlayAnimation(1, 1)

--・同時に扉ＯＢＪ（o0211/2）が開くアニメーション（ID 1）を再生
--　（あれば）扉が開くＳＥ（ID****）を鳴らす
--・扉の当たりを動かし、移動できるようにする
	proxy:PlayAnimation(2, 1)

print("OnEvent_101 end");
end






--■102■崩れる柱1
function OnEvent_102(proxy, param)
print("OnEvent_102 begin");

--・イベントフラグを立てる
	proxy:SetEventFlag( 102, true );
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
	proxy:SetEventFlag( 104, true );
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






--■123■デブデーモン部屋扉開放
function OnEvent_123(proxy, param)
print("OnEvent_123 begin");

--・イベントフラグを立てる
	proxy:SetEventFlag( 123, true );

--・デブデーモン部屋の扉（o0212/123)の開くアニメーション（ID 1)を再生
--・（あれば）扉が開くSEを鳴らす
--・扉の当たりを動かし、ＰＣが通れるようにする。
	proxy:PlayAnimation(123, 1)


print("OnEvent_123 end");
end






--■155■マップ移動（→砦水路1Ｆ）
function OnEvent_155(proxy, param)
print("OnEvent_155 begin");
	if param:IsNetMessage()==TRUE  then
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
	if param:IsNetMessage()==TRUE  then
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
	if param:IsNetMessage()==TRUE  then
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



















