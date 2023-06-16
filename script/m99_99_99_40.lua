once = 1;
everytime = 0;





function Initialize_m99_99_99_40(proxy)
print("Initialize m99_99_99_40 begin");
--■191■入り口灯台■
--ＰＣが、イベントエリア(91)の中に居て、
--特定の角度を向いていて、
--アクションボタンを押したとき
	proxy:OnPlayerActionInRegionAngle( 191, 91, "OnEvent_191", 90,1, once);
--	proxy:OnRegionJustIn( 191, 10000, 91, "OnEvent_191", once);

--■192■通路灯台■
--・ＰＣが、イベントエリア(92)に到達したとき
--	proxy:OnRegionJustIn( 192, 10000, 92, "OnEvent_192", once);
--■193■部屋灯台１■
--・ＰＣが、イベントエリア（93）に到達したとき
	proxy:OnRegionJustIn( 193, 10000, 93, "OnEvent_193", once);

--■194■部屋灯台３■
--・ＰＣが、イベントエリア(94)に到達したとき
--	proxy:OnRegionJustIn( 194, 10000, 94, "OnEvent_194", once);
--	proxy:OnPlayerDistanceAngleInTarget(194,10000,94,"OnEvent_194",1.0,once);
--■195■部屋灯台２■
--ＰＣが、イベントエリア(95)の中に居て、
--アクションボタンを押したとき
	proxy:OnPlayerActionInRegion( 195, 95, "OnEvent_195",1, once);
	
--■196■円領域（サークル）テスト■
--ＰＣが、イベントエリア(30)の中に居て、
--アクションボタンを押したとき
	proxy:OnPlayerActionInRegion( 196, 30, "OnEvent_196",1, once);
	
--■197■球領域（スフィア）テスト■
--ＰＣが、イベントエリア(31)の中に居て、
--アクションボタンを押したとき
	proxy:OnPlayerActionInRegion( 197, 31, "OnEvent_197",1, once);
	
--■198■矩形（レクト）領域テスト■
--ＰＣが、イベントエリア(32)の中に居て、
--アクションボタンを押したとき
	proxy:OnPlayerActionInRegion( 198, 32, "OnEvent_198",1, once);

--■192■通路灯台■
--・ＰＣが、イベントエリア(92)に到達したとき
	proxy:OnPlayerActionInRegionAngle( 196, 92, "OnEvent_196",90,1, once);

--■199■会話テスト■
--PCがイベントID94から1.5の距離に入っていて、アクションボタンを押したとき
	proxy:OnDistanceAction(199,10000,94,"OnEvent_199",3,1,0,90,everytime );

--■200■会話テスト■
--PCがイベントID94から1.5の距離に入っている時
	proxy:OnPlayerDistanceInTarget(200,10000,94,"OnEvent_200",3,everytime );

--■201■会話テスト■
--PCがイベントID94から1.5の距離に入った後出たとき
	proxy:OnPlayerDistanceOut(201,10000,94,"OnEvent_201",3,everytime );

--■202■会話テスト■
--PCがイベントID94のHPを0にしたとき
	proxy:OnCharacterHP(202,94,"OnEvent_202_1",0.0,once);

--イベントID94が完全に死んだとき
	proxy:OnCharacterDead(202,94,"OnEvent_202_2",once);

print("Initialize m99_99_99_40 end");
end



--■191■入り口灯台■
function OnEvent_191(proxy, param)
print("OnEvent_191 begin");
--・イベントフラグを立てる
	proxy:SetEventFlag( 191, 1 );

--・PCをイベントエリア(193)に移動
	proxy:Warp(10000, 193);

print("OnEvent_191 end");
end



--■192■通路灯台■
function OnEvent_192(proxy, param)
print("OnEvent_192 begin");

--・イベントフラグを立てる
	proxy:SetEventFlag( 192, 1 );
--・PCのレバー動作アニメーション(ID 4000)再生
	proxy:PlayAnimation(10000, 4000);

print("OnEvent_192 end");
end



--■193■部屋灯台１■
function OnEvent_193(proxy, param)
print("OnEvent_193 begin");

--・イベントフラグを立てる
	proxy:SetEventFlag( 193, 1 );
--・会話(ID 0)を再生
	proxy:PlayTalk(0);

print("OnEvent_193 end");
end



--■194■部屋灯台３■
function OnEvent_194(proxy, param)
print("OnEvent_194 begin");

--・イベントフラグを立てる
	proxy:SetEventFlag( 194, 1 );
--・アイテム(ID 0)を取得
	proxy:GetItem(0);
	proxy:PlayAnimation(10000, 4000);
print("OnEvent_194 end");
end


--■195■部屋灯台２■
function OnEvent_195(proxy, param)
print("OnEvent_195 begin");

--・イベントフラグを立てる
	proxy:SetEventFlag( 195, 1 );
--・PCのレバー動作アニメーション(ID 4000)再生
	proxy:PlayAnimation(10000, 4000);

print("OnEvent_195 end");
end

--■196■円領域（サークル）テスト■
function OnEvent_196(proxy, param)
print("OnEvent_196 begin");

--・イベントフラグを立てる
	proxy:SetEventFlag( 196, 1 );
--・PCのレバー動作アニメーション(ID 4000)再生
	proxy:PlayAnimation(10000, 4000);

print("OnEvent_196 end");
end

--■197■球領域（スフィア）テスト■
function OnEvent_197(proxy, param)
print("OnEvent_197 begin");

--・イベントフラグを立てる
	proxy:SetEventFlag( 197, 1 );
--・PCのレバー動作アニメーション(ID 4000)再生
	proxy:PlayAnimation(10000, 4000);

print("OnEvent_197 end");
end

--■198■矩形（レクト）領域テスト■
function OnEvent_198(proxy, param)
print("OnEvent_198 begin");

--・イベントフラグを立てる
	proxy:SetEventFlag( 198, 1 );
--・PCのレバー動作アニメーション(ID 4000)再生
	proxy:PlayAnimation(10000, 4000);

print("OnEvent_198 end");
end

--■192■通路灯台■
function OnEvent_196(proxy, param)
print("OnEvent_196 begin");

--・イベントフラグを立てる
	proxy:SetEventFlag( 196, 1 );
--・PCのレバー動作アニメーション(ID 4000)再生
	proxy:PlayAnimation(10000, 4000);

print("OnEvent_196 end");
end


--■199■入り口付近敵■
function OnEvent_199(proxy, param)
print("OnEvent_199 begin");
	FlagValue = proxy:IsCompleteEventValue(199);

	if FlagValue ==0 then proxy:SetEventFlag( 199, 1 ); end

	if FlagValue ==1 then proxy:SetEventFlag( 199, 2 ); end
	if FlagValue ==2 then proxy:SetEventFlag( 199, 3 ); end
	if FlagValue ==3 then 
		proxy:SetEventFlag( 199, 0 );		
	 end

print("OnEvent_199 end");
end


--■200■入り口付近敵：会話■
function OnEvent_200(proxy, param)
print("OnEvent_200 begin");
--199イベントのフラグを取得する
	FlagValue = proxy:IsCompleteEventValue(199);
	if FlagValue ==0 then return; end

	if FlagValue ==1 then proxy:StartTalk(90000000,1);	 end
	if FlagValue ==2 then proxy:StartTalk(90000001,1);	 end
	if FlagValue ==3 then proxy:StartTalk(90000002,0);	 end
	if FlagValue ==4 then proxy:StartTalk(90000700,0);	 end

print("OnEvent_200 end");
end

--■201■入り口付近敵：会話■
function OnEvent_201(proxy, param)
print("OnEvent_201 begin");
--199イベントのフラグを取得する
	FlagValue = proxy:IsCompleteEventValue(199);
	if FlagValue ==4 then return; end
	if FlagValue ==5 then return; end

	if FlagValue >=1 then proxy:SetEventFlag( 199, 0 );	 end

print("OnEvent_201 end");
end

--■202_1■入り口付近敵：会話■
function OnEvent_202_1(proxy, param)
print("OnEvent_202_1 begin");
--199イベントのフラグを取得する
	proxy:SetEventFlag(199,4);

print("OnEvent_202_1 end");
end

--■202_2■入り口付近敵：会話■
function OnEvent_202_2(proxy, param)
print("OnEvent_202_2 begin");
--199イベントのフラグを取得する
	proxy:SetEventFlag(199,5);

print("OnEvent_202_2 end");
end

