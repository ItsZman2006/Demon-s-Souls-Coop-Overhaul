
ANIME_FATE01 = 25;--0～25
ANIME_FATE02 = 50;--26～50
ANIME_FATE03 = 75;--51～75

BEAST_EVENTDAMAGE = 100;
BEAST_EVENTDAMAGE_RATE = 1.0;

BEAST_JR_DEADCOUNT = 0;
BEAST_JR_MAXCOUNT = 6;

EXVEROCITY_TIME = 5.0;
EXVEROCITY_LEN	= 50;

ISONCE1 = true;
ISONCE2 = false;
ISONCE3 = false;
--------------------------------------------------------------------------------------
--イベント初期化■ボス固有のイベントを登録する際に使用してください
--------------------------------------------------------------------------------------
function EventBoss_Initialize_m03_03_00_00(proxy)
	print("EventBoss_Initialize_m03_03_00_00 begin");
	
	--☆☆☆☆☆☆☆☆☆☆☆☆嵐の獣非同期設定☆☆☆☆☆☆☆☆☆☆☆☆
	proxy:SetNoNetSync(822,true);
	--☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆☆
	if proxy:IsCompleteEvent(4992) == false then
		BEAST_JR_DEADCOUNT = 0;
		print("BEAST_JR_DEADCOUNT init to ",BEAST_JR_DEADCOUNT);
		--アニメ配信用?
		SingleReset( proxy, 5030 );
		proxy:NotNetMessage_begin();
			proxy:LuaCall( 5030 ,0, "OnEvent_5030_Regist",everytime);
		proxy:NotNetMessage_end();

	--[[
		proxy:LuaCall(5031,1,"OnEvent_5031",everytime);
		proxy:LuaCall(5032,2,"OnEvent_5032",everytime);
		proxy:LuaCall(5033,3,"OnEvent_5033",everytime);
		proxy:LuaCall(5034,4,"OnEvent_5034",everytime);
	]]
		
		--空中旋回
		proxy:LuaCall(5073,1,"OnEvent_5073",everytime);
		--低空攻撃1
		proxy:LuaCall(5074,1,"OnEvent_5074",everytime);
		--低空攻撃2
		proxy:LuaCall(5075,1,"OnEvent_5075",everytime);
		
		--フェイズ移行アニメ
		SingleReset( proxy , 5080 );
		proxy:LuaCall(5080,1,"OnEvent_5080",everytime);
		
		--[[
		proxy:NotNetMessage_begin();
			--ポリ劇開始フェード終了後
			proxy:LuaCall( 5078,REMO_START,"OnEvent_5078_RemoStart",once);
			--ポリ劇終了フェード前
			proxy:LuaCall( 5078,REMO_FINISH,"OnEvent_5078_RemoFinish",once);
		proxy:NotNetMessage_end();
		]]
		--proxy:OnCharacterHP( 5078 , 822 , "OnEvent_5078",0.0,once);
		
		proxy:OnCharacterDead( 5078 , 822 , "OnEvent_5078",once);
		
		--SFX配信用	
		--proxy:LuaCall(5014,1,"OnEvent_5014",everytime);
		--proxy:LuaCall(5015,1,"OnEvent_5015",everytime);
		
		SingleReset(proxy,5071);
		--クライアントで無いなら　シングル　or　ホスト
		if	proxy:IsClient() == false then
			--ネットワーク更新権限を要求する
			proxy:RequestForceUpdateNetwork( 822 );
			--子エイのネットワーク更新権限を要求する
			local eneID = 400;
			for eneID=400 , 411 , 1 do
				proxy:RequestForceUpdateNetwork(eneID);		
				proxy:AddFieldInsFilter(eneID);
				--子エイの死亡監視
				print("add ",eneID);
				proxy:NotNetMessage_begin();
				proxy:RepeatMessage_begin();
					proxy:OnCharacterDead( 5071, eneID ,"OnEvent_5071_"..eneID,once);		
				proxy:RepeatMessage_end();
				proxy:NotNetMessage_end();
			end
			
			--ジェネレーターにイベントを登録
			proxy:AddGeneEvent( 5071 , 2605 );
			--受け取れるようにハンドラを登録
			proxy:NotNetMessage_begin();
				proxy:CustomLuaCall( 5071 , "OnEvent_5071", everytime);
			proxy:NotNetMessage_end();
		end
		
		--アニメ監視用?
		--[[
			基本
			アニメ選択はホストのみが行う
			アニメ再生を監視するのもホストのみが行う
			ピアは再生するアニメを配信されているだけである。
		]]
		
		--2段目の初期化
		proxy:NotNetMessage_begin();
			proxy:OnKeyTime2(5034,"BossInit_m03_03_00_00_Second_Initialize",0,0,0,once);
		proxy:NotNetMessage_end();
	end
	
	--子エイを初期死亡しないようにフィルターに登録する
	local eneID = 400;
	for eneID=400 , 411 , 1 do
		proxy:AddFieldInsFilter(eneID);
	end
	
	
	print("EventBoss_Initialize_m03_03_00_00 end");
end


--2段目の初期化
function BossInit_m03_03_00_00_Second_Initialize(proxy,param)
	print("BossInit_m03_03_00_00_Second_Initialize beign");
	
	--重力の限界を無視
	proxy:SetDisableGravity(822,true);
	--proxy:DisableDamage( 822, true);--ダメージ入らない
	proxy:SetSuperArmor( 822, true);--スーパーアーマー

	print("BossInit_m03_03_00_00_Second_Initialize end");
end


--------------------------------------------------------------------------------------
--ボス用の初期化処理が必要なときに使用：固有情報の作成等
--------------------------------------------------------------------------------------
function BossInit_StormOfBeast(proxy,param)
	print("BossInit_StormOfBeast begin");
	--描画グループ適用
	proxy:SetDrawGroup(822,2631);
	--重力の限界を無視しない
	proxy:SetDisableGravity(822,true);
	
	--強制更新を開始
	LuaFunc_ForceOmission(proxy,822);
	--クライアントで無いなら　シングル　or　ホスト
	if	proxy:IsClient() == false then
		--アニメ抽選をかねてハンドラコール
		OnEvent_5030(proxy,param);
	end
	
	--子エイロジックON
	local eneID = 400;
	for eneID=400 , 411 , 1 do
		proxy:EnableLogic(eneID,true);
	end
	
	--子エイ用の戦闘領域監視
	--proxy:OnRegistFunc(5020,"Check_5020","OnEvent_5020",1,once);
	
	
	
	print("BossInit_StormOfBeast end");
end


--------------------------------------------------------------------------------------
--ボス用の初期化処理が必要なときに使用：固有情報の作成等
--------------------------------------------------------------------------------------
function BossInit_StormOfBeast2(proxy,param)
	print("BossInit_StormOfBeast2 begin");
	--通常ロジックON
	proxy:EnableLogic(822,true);
	
	--重力の限界を無視しない
	--proxy:SetDisableGravity(822,false);
	--proxy:DisableMapHit(822,true);
	
	proxy:DisableDamage( 822, false);--ダメージ入る
	
	--位置合わせワープ
	proxy:SetExVelocity(822,2603,EXVEROCITY_TIME,EXVEROCITY_LEN);--(822,2603);	
	
	proxy:ForcePlayAnimation(822,0);
	--エイの戦闘領域監視
	proxy:OnRegistFunc( 5010,"Check_5010","OnEvent_5010",1,once);	
	print("BossInit_StormOfBeast2 end");
end

--[[
--------------------------------------------------------------------------------------
--子エイの戦闘領域監視
--------------------------------------------------------------------------------------
function Check_5020(proxy,param)
	local eneID = 400;
	local eneMax = 411;
	local eneNum = 12;
	local deadCount = 0;
	
	for eneID = 400, eneMax , 1 do
		if proxy:IsAlive(eneID) == true then
			local targetID = proxy:GetTargetChrID(eneID);
			if targetID >= 0 then
				if proxy:IsRegionIn( targetID , 2620) == true then			
					--ターゲットが戦闘領域に入っている
					proxy:SetInsideBattleArea(eneID,1);
				else
					--ターゲットが戦闘領域には居ない
					proxy:SetInsideBattleArea(eneID,0);
				end
			else
				--ターゲットが戦闘領域には居ない
				proxy:SetInsideBattleArea(eneID,0);
			end
		else
			deadCount = deadCount + 1;
		end
	end
	
	if deadCount >= eneNum then
		return true;		
	end
	return false;	
end

--子エイ全部死亡
function OnEvent_5020(proxy,param)
	print("OnEvent_5020 begin");
	print("All Dead");
	proxy:DeleteEvent(5020);
	print("OnEvent_5020 end");
end
]]
--------------------------------------------------------------------------------------
--嵐の獣　アニメ監視と抽選
--------------------------------------------------------------------------------------
function OnEvent_5030(proxy,param)
	--突撃ポリ劇が終わってたら抽選しません
	if proxy:IsCompleteEvent(5001) == true then
		return;
	end
	
	if proxy:IsCompleteEvent(5030) == true then
		return;
	end
	
	--死んでいたらアニメ抽選しない
	if proxy:IsAlive( 822 ) == false then
		return; 
	end
	print("OnEvent_5030 begin");
	
	local fate = proxy:GetRandom( 0,100);
	
	if proxy:IsCompleteEvent( 5071 ) == false then
		print("Call A");
		proxy:LuaCallStart(5073,1)
	else
		--フェイズ2へ移行しているが移行アニメがまだ
		if proxy:IsCompleteEvent( 5080 ) == false then
			print("Call shift");
			proxy:LuaCallStart(5080,1);
			proxy:SetEventFlag( 5080,true );
		else		
			if fate <= 100 then
				print("Call B fate ",fate );
				proxy:LuaCallStart(5074,1);
			else		
				print("Call C fate ",fate );
				proxy:LuaCallStart(5075,1);
			end
		end
	end

	--クライアントで無いなら　シングル　or　ホスト
	if	proxy:IsClient() == false then
		proxy:RepeatMessage_begin();
			proxy:NotNetMessage_begin();
			proxy:OnKeyTime2(5030,"OnEvent_5030_1",1,0,0,once);
			proxy:RepeatMessage_end();
		proxy:NotNetMessage_end();
	end
	
	proxy:SetEventFlag(5030,true);
	print("OnEvent_5030 end");
end

--それぞれの監視再登録
function OnEvent_5030_1(proxy,param)
	print("OnEvent_5030_1 begin");
	proxy:SetEventFlag(5030,false);
	--クライアントで無いなら　シングル　or　ホスト
	if	proxy:IsClient() == false then
		proxy:NotNetMessage_begin();
			proxy:RepeatMessage_begin();
				proxy:OnChrAnimEnd( 5030 , 822 , 7010 , "OnEvent_5030" ,once);
			proxy:RepeatMessage_end();
		proxy:NotNetMessage_end();
	end
	print("OnEvent_5030_1 end");
end

--------------------------------------------------------------------------------------
--嵐の獣　アニメ再生
--------------------------------------------------------------------------------------
--[[
--尻尾叩き
function OnEvent_5031(proxy,param)
	print("OnEvent_5031 begin");
	--開始ポイントにワープ
	proxy:SetExVelocity(822,2630,EXVEROCITY_TIME,EXVEROCITY_LEN);--(822,2630);
	proxy:PlayAnimation(822,7010);
	print("OnEvent_5031 end");
end
]]

--[[
--風圧攻撃
function OnEvent_5032(proxy,param)
	print("OnEvent_5032 begin");
	--開始ポイントにワープ
	proxy:SetExVelocity(822,2630,EXVEROCITY_TIME,EXVEROCITY_LEN);--(822,2630);
	proxy:PlayAnimation(822,7020);

	print("OnEvent_5032 end");
end
]]

--[[
--うろこ飛ばし攻撃
function OnEvent_5033(proxy,param)
	print("OnEvent_5033 begin");
	--開始ポイントにワープ
	proxy:SetExVelocity(822,2630,EXVEROCITY_TIME,EXVEROCITY_LEN);--(822,2630);
	proxy:PlayAnimation(822,7030);

	print("OnEvent_5033 end");
end
]]

--[[
--巡回
function OnEvent_5034(proxy,param)
	print("OnEvent_5034 begin");
	--開始ポイントにワープ
	proxy:SetExVelocity(822,2630,EXVEROCITY_TIME,EXVEROCITY_LEN);--(822,2630);
	proxy:ForcePlayAnimation(822,7050);

	print("OnEvent_5034 end");
end
]]


--巡回
function OnEvent_5073(proxy,param)
	print("OnEvent_5073 begin");
	if ISONCE1 == false then
		--開始ポイントにワープ
		proxy:Warp( 822 , 2630 );
		ISONCE1 = true;
	else
		--開始ポイントにワープ
		proxy:SetExVelocity(822,2630,EXVEROCITY_TIME,EXVEROCITY_LEN);--( 822 , 2630 );
	end
	proxy:ForcePlayAnimationStayCancel( 822 , 7050 );
	print("OnEvent_5073 end");
end

--低空攻撃１
function OnEvent_5074(proxy,param)
	print("OnEvent_5074 begin");
	if ISONCE2 == false then
		--開始ポイントにワープ
		proxy:Warp( 822 , 2635 );
		ISONCE2 = true;
	else
		--開始ポイントにワープ
		proxy:SetExVelocity(822,2635,EXVEROCITY_TIME,EXVEROCITY_LEN);--( 822 , 2635 );		
	end
	proxy:ForcePlayAnimationStayCancel( 822 , 7060 );
	print("OnEvent_5074 end");
end

--低空攻撃２
function OnEvent_5075(proxy,param)
	print("OnEvent_5075 begin");
	if ISONCE3 == false then
		--開始ポイントにワープ
		proxy:Warp( 822 , 2635 );		
	else
		--開始ポイントにワープ
		proxy:SetExVelocity(822,2635,EXVEROCITY_TIME,EXVEROCITY_LEN);--( 822 , 2635 );		
	end
	proxy:ForcePlayAnimationStayCancel( 822 , 7070 );
	print("OnEvent_5075 end");
end

--フェイズ移行アニメ
function OnEvent_5080(proxy,param)
	print("OnEvent_5080 begin");
	--開始ポイントにワープ
	--proxy:Warp(822,2630);
	proxy:SetExVelocity(822,2630,EXVEROCITY_TIME,EXVEROCITY_LEN);--( 822 , 2635 );		
	proxy:ForcePlayAnimationStayCancel( 822 , 7100 );
	print("OnEvent_5080 end");
end

--[[
--------------------------------------------------------------------------------------
--嵐の獣　SFX配信イベント
--------------------------------------------------------------------------------------
--風圧攻撃SFX
function OnEvent_5014_RegionIn(proxy,param)
	print("OnEvent_5014_RegionIn begin");
	proxy:LuaCallStart(5014,1);
	print("OnEvent_5014_RegionIn end");
end

--風圧攻撃SFX
function OnEvent_5014(proxy,param)
	print("OnEvent_5014 begin");
	proxy:CreateSfx( 2615 , 15031);
	print("OnEvent_5014 end");
end

--通常接近SFX
function OnEvent_5015_RegionIn(proxy,param)
	print("OnEvent_5015_RegionIn begin");
	proxy:LuaCallStart(5015,1);
	print("OnEvent_5015_RegionIn end");
end

--通常接近SFX
function OnEvent_5015(proxy,param)
	print("OnEvent_5015 begin");		
	proxy:CreateSfx( 2617 , 15030);
	print("OnEvent_5015 end");	
end
]]


--------------------------------------------------------------------------------------
--嵐の獣　戦闘領域監視
--------------------------------------------------------------------------------------
function Check_5010(proxy,param)
	
	--嵐の獣が生きているか？
	if proxy:IsAlive(822) == true then
		--ターゲット取得
		local TargetID = proxy:GetTargetChrID(822);
		
		--ターゲットがいるか？
		if TargetID >= 0 then
			--ターゲットが右にいるか？
			if proxy:IsRegionIn(TargetID,2610) == true then
				proxy:SendEventRequest(822,0,AI_EVENT_FOR_RIGHT);
			
			--ターゲットが正面にいるか？
			elseif proxy:IsRegionIn(TargetID,2611) == true then
				proxy:SendEventRequest(822,0,AI_EVENT_FOR_CENTER);
			
			--ターゲットが左にいるか？
			elseif proxy:IsRegionIn(TargetID,2612) == true then
				proxy:SendEventRequest(822,0,AI_EVENT_FOR_LEFT);
			
			--ターゲットが近くにきているか？
			elseif proxy:IsRegionIn(TargetID,2613) == true then
				proxy:SendEventRequest(822,0,AI_EVENT_NEAR);
			
			--該当エリアのどこにも居ない
			else
				proxy:SendEventRequest(822,0,AI_EVENT_None);
			
			end
		end
		
	else
		--死んでいる
		return true;
	end
	
	return false;
end

--一応死んだ時にハンドラを呼んで削除しておく
function OnEvent_5010(proxy,param)
	print("OnEvent_5010 begin");	
	print("OnEvent_5010 end");
end


--------------------------------------------------------------------------------------
--嵐の獣　ノーダメージ部位
--------------------------------------------------------------------------------------
--ダメージ部位にダメージ蓄積
function OnEvent_5045(proxy,param)
	print("OnEvent_5045 begin");
	if proxy:IsAlive(822 ) == true then
		proxy:PlayAnimation( 822,2000);
		proxy:CheckEventBody(5045);
	end
	print("OnEvent_5045 end");
end

--ノーダメージ部位からイベントが起きた
function OnEvent_5046(proxy,param)
	print("OnEvent_5046 begin");
	proxy:CheckEventBody(5046);
	print("OnEvent_5046 end");
end


function OnEvent_5071(proxy,param)
	print("OnEvent_5071 begin");
	print("Generate enemy ",param:GetParam2() );
	proxy:NotNetMessage_begin();
	proxy:RepeatMessage_begin();
		proxy:OnCharacterDead( 5071, param:GetParam2(),"OnEvent_5071_"..param:GetParam2(),once);
	proxy:RepeatMessage_end();
	proxy:NotNetMessage_end();
end

--------------------------------------------------------------------------------------
--■5071■子エイ死亡監視■
--------------------------------------------------------------------------------------
--死亡監視の統合
function CheckDeadCount(proxy,eneID)
	print("OnEvent_5000_",eneID," begin");	
	
	BEAST_JR_DEADCOUNT = BEAST_JR_DEADCOUNT + 1;
	print(" BEAST_JR_DEADCOUNT = ",BEAST_JR_DEADCOUNT );
	
	if BEAST_JR_DEADCOUNT >= BEAST_JR_MAXCOUNT then
		proxy:SetEventFlag( 5071 , true );
	end	
	print("OnEvent_5000_",eneID," end");	
end

--子エイの死亡監視
function OnEvent_5071_400(proxy,param) CheckDeadCount(proxy,400); end--ID400
function OnEvent_5071_401(proxy,param) CheckDeadCount(proxy,401); end--ID401
function OnEvent_5071_402(proxy,param) CheckDeadCount(proxy,402); end--ID402
function OnEvent_5071_403(proxy,param) CheckDeadCount(proxy,403); end--ID403
function OnEvent_5071_404(proxy,param) CheckDeadCount(proxy,404); end--ID404
function OnEvent_5071_405(proxy,param) CheckDeadCount(proxy,405); end--ID405
function OnEvent_5071_406(proxy,param) CheckDeadCount(proxy,406); end--ID406
function OnEvent_5071_407(proxy,param) CheckDeadCount(proxy,407); end--ID407
function OnEvent_5071_408(proxy,param) CheckDeadCount(proxy,408); end--ID408
function OnEvent_5071_409(proxy,param) CheckDeadCount(proxy,409); end--ID409
function OnEvent_5071_410(proxy,param) CheckDeadCount(proxy,410); end--ID410
function OnEvent_5071_411(proxy,param) CheckDeadCount(proxy,411); end--ID411


--[[
--------------------------------------------------------------------------------------
--■5078■本体のHP監視■
--------------------------------------------------------------------------------------
function OnEvent_5078(proxy,param)
	print("OnEvent_5078 begin");
	proxy:RequestRemo( 30301 , REMO_FLAG,5078,1);
	print("OnEvent_5078 end");
end

--ポリ劇開始前
function OnEvent_5078_RemoStart(proxy,param)
	print("OnEvent_5078_RemoStart begin");
	local eneId = 400;
	
	for eneId = 400 , 411 , 1 do
		--子エイを無理やり殺す（無報酬）
		Lua_EventForceDead(proxy,eneId);
	end
	
	--ジェネレータ止める
	proxy:EnableGeneratorSystem( 2605 , false );
	
	--遠くに飛ばす
	proxy:Warp( 822 , 2640 );

	print("OnEvent_5078_RemoStart end");	
end

--ポリ劇終了後
function OnEvent_5078_RemoFinish(prox,param)
	print("OnEvent_5078_RemoFinish begin");
	print("OnEvent_5078_RemoFinish end");
end
]]

--------------------------------------------------------------------------------------
--■5078■本体の死亡監視■
--------------------------------------------------------------------------------------
function OnEvent_5078(proxy,param)
	print("OnEvent_5078 begin");
	local eneId = 400;
	
	for eneId = 400 , 411 , 1 do
		--子エイを無理やり殺す（無報酬）
		Lua_EventForceDead(proxy,eneId);
	end
	
	--ジェネレータ止める
	proxy:EnableGeneratorSystem( 2605 , false );
	
	print("OnEvent_5078 end");
end
