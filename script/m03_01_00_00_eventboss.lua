
--審判者部位ＨＰ
--SINPANSY_EVENTBODY_HP = 572;
SINPANSY_EVENTBODY_HP = 423.7;
--審判者部位ダメージ倍率--基本ダメージはパラメータと同じ　*　値
SINPANSY_EVENTBODY_DAMAGE_RATE = 1;


--審判者弱点分HP


--------------------------------------------------------------------------------------
--イベント初期化■ボス固有のイベントを登録する際に使用してください
--------------------------------------------------------------------------------------
function EventBoss_Initialize_m03_01_00_00(proxy)
	print("EventBoss_Initialize m03_01_00_00 begin");
	
	--ボスが生きていたら
	if proxy:IsCompleteEvent( 4756 ) == false then
		BossInit_Sinpansya(proxy,param);--審判者用の初期化			
		--クライアントで無いなら　シングル　or　ホスト
		if	proxy:IsClient() == false then
			--ネットワークの権限を取れるように要求
			proxy:RequestForceUpdateNetwork(804);
		end
	end

	
	SingleReset( proxy ,4741);
	--EzState命令用秒数イベント削除
	proxy:LuaCall(4741,0,"OnEvent_4741",everytime);
	proxy:LuaCall(4741,1,"OnEvent_4741_1",everytime);
	
	SingleReset( proxy ,4742);
	--EzState命令配信用
	proxy:LuaCall(4742,1,"OnEvent_4742_1",everytime);
	proxy:LuaCall(4742,2,"OnEvent_4742_2",everytime);
	
	SingleReset( proxy ,4743);
	SingleReset( proxy ,4744);
	--EzStateの監視
	proxy:OnCheckEzStateMessage(4743,804,"OnEvent_4743",250);
	proxy:OnCheckEzStateMessage(4744,804,"OnEvent_4744",260);
	
	print("EventBoss_Initialize m03_01_00_00 end");
end

--------------------------------------------------------------------------------------
--ボス用の初期化処理が必要なときに使用：固有情報の作成等
--------------------------------------------------------------------------------------
function BossInit_Sinpansya(proxy,param)	
	--部位ダメージ監視
	SingleReset( proxy ,4740);
	if proxy:CreateEventBodyPlus( 4740, 804,"OnEvent_4740",SINPANSY_EVENTBODY_HP,SINPANSY_EVENTBODY_DAMAGE_RATE,0.0,everytime) == true then				
		proxy:SetEventBodyMaterialSeAndSfx( 4740 , 59 , 59 );
		proxy:AddEventParts(4740,804,"Ragdoll_Fat 02");				
		print("CreateEventBody");
	else
		print("Create Error");
	end
	
	
	SingleReset( proxy ,4746);
	--はじき部位ダメージ
	if proxy:CreateEventBody( 4746, 804,"OnEvent_4746",1000000,0.0,everytime) == true then
		proxy:AddEventParts_Ignore(4746,804,"Ragdoll_Pelvis01");
		proxy:AddEventParts_Ignore(4746,804,"Ragdoll_Fat 01");
		proxy:AddEventParts_Ignore(4746,804,"Ragdoll_Fat 03");
		proxy:AddEventParts_Ignore(4746,804,"Ragdoll_L HipsFat01");
		proxy:AddEventParts_Ignore(4746,804,"Ragdoll_L Thigh01");
		proxy:AddEventParts_Ignore(4746,804,"Ragdoll_R HipsFat01");
		proxy:AddEventParts_Ignore(4746,804,"Ragdoll_R Thigh01");
		proxy:AddEventParts_Ignore(4746,804,"Ragdoll_Spine01");
		proxy:AddEventParts_Ignore(4746,804,"Ragdoll_R Calf01");
		proxy:AddEventParts_Ignore(4746,804,"Ragdoll_L Calf01");
		proxy:AddEventParts_Ignore(4746,804,"Ragdoll_Spine02");
		proxy:AddEventParts_Ignore(4746,804,"Ragdoll_L Foot01");
		proxy:AddEventParts_Ignore(4746,804,"Ragdoll_L legFat 01");
		proxy:AddEventParts_Ignore(4746,804,"Ragdoll_L legFat 02");
		proxy:AddEventParts_Ignore(4746,804,"Ragdoll_R Foot01");
		proxy:AddEventParts_Ignore(4746,804,"Ragdoll_R legFat 01");
		proxy:AddEventParts_Ignore(4746,804,"Ragdoll_R legFat 02");
		proxy:AddEventParts_Ignore(4746,804,"Ragdoll_R legFat 03");
		proxy:AddEventParts_Ignore(4746,804,"Ragdoll_R legFat 04");
		proxy:AddEventParts_Ignore(4746,804,"Ragdoll_L legFat 03");
		proxy:AddEventParts_Ignore(4746,804,"Ragdoll_L legFat 04");
		proxy:AddEventParts_Ignore(4746,804,"Ragdoll_L Clavicle01");
		proxy:AddEventParts_Ignore(4746,804,"Ragdoll_R Clavicle01");
		proxy:AddEventParts_Ignore(4746,804,"Ragdoll_L UpperArm01");
		proxy:AddEventParts_Ignore(4746,804,"Ragdoll_R UpperArm01");
		proxy:AddEventParts_Ignore(4746,804,"Ragdoll_L Forearm01");
		proxy:AddEventParts_Ignore(4746,804,"Ragdoll_R Forearm01");
		proxy:AddEventParts_Ignore(4746,804,"Ragdoll_R Hand01");
		print("Create EventBody Ignore");
	else
		print("Create error2");
	end
	
	SingleReset( proxy ,4747);
	--はじき部位ダメージ
	if proxy:CreateEventBody( 4747, 804,"OnEvent_4747",1000000,0.0,everytime) == true then
		print("Create EventBody Ignore2");				
		proxy:AddEventParts_Ignore(4747,804,"Ragdoll_L ArmFat 03");
		proxy:AddEventParts_Ignore(4747,804,"Ragdoll_L ArmFat 04");
		proxy:AddEventParts_Ignore(4747,804,"Ragdoll_L ArmFat 01");
		proxy:AddEventParts_Ignore(4747,804,"Ragdoll_L ArmFat 02");
		proxy:AddEventParts_Ignore(4747,804,"Ragdoll_R ArmFat 01");
		proxy:AddEventParts_Ignore(4747,804,"Ragdoll_R ArmFat 02");
		proxy:AddEventParts_Ignore(4747,804,"Ragdoll_R ArmFat 03");
		proxy:AddEventParts_Ignore(4747,804,"Ragdoll_R ArmFat 04");
		proxy:AddEventParts_Ignore(4747,804,"Ragdoll_L ArmFat1 03");
		proxy:AddEventParts_Ignore(4747,804,"Ragdoll_L ArmFat1 04");
		proxy:AddEventParts_Ignore(4747,804,"Ragdoll_L Hand01");
		proxy:AddEventParts_Ignore(4747,804,"Ragdoll_L ArmFat1 01");	
		proxy:AddEventParts_Ignore(4747,804,"Ragdoll_L ArmFat1 02");
		proxy:AddEventParts_Ignore(4747,804,"Ragdoll_R ArmFat1 01");
		proxy:AddEventParts_Ignore(4747,804,"Ragdoll_R ArmFat1 02");
		proxy:AddEventParts_Ignore(4747,804,"Ragdoll_R ArmFat1 03");
		proxy:AddEventParts_Ignore(4747,804,"Ragdoll_R ArmFat1 04");		
		
	else
		print("Create error3");
	end
	
	SingleReset( proxy , 4748 );
	if proxy:CreateEventBody( 4748, 804,"OnEvent_4748",1000000,1.0,everytime) == true then	
		--弱点部位のSEとSFXを設定
		proxy:SetEventBodyMaterialSeAndSfx( 4748 , 59 , 59 );
		proxy:AddEventParts( 4748 ,804 , "Ragdoll_Head01");
	else
		print("Create error4");
	end
	
end

--------------------------------------------------------------------------------------
--ボス用の初期化処理が必要なときに使用：固有情報の作成等
--------------------------------------------------------------------------------------
function BossEventStart_Sinpansya(proxy,param)
	--イベント呼んだ本人にだけチェックしてもらう
	if param:IsNetMessage() == false then
		print("BossEventStart_Sinpansya begin");
			--proxy:OnRegistFunc(648,"Check_648","OnEvent_648",1,once);
		print("BossEventStart_Sinpansya end");
	end
end

--審判者部位ダメージの準備
function StandBy_Sinpansya(proxy,param)
	print("StandBy_Sinpansya begin");	
	proxy:SetEventBodyMaxHp(4740,SINPANSY_EVENTBODY_HP);	
	print("StandBy_Sinpansya end");
end

--------------------------------------------------------------------------------------
--4740■審判者部位ダメージ発動
--------------------------------------------------------------------------------------
function OnEvent_4740(proxy,param)
	if proxy:IsCompleteEvent(4740) == true then
		return;
	end
	print("OnEvent_4740 begin");
	--一旦回復
	--proxy:CheckEventBody(4740);
	--ダウンイベント重複禁止用
	proxy:SetEventFlag(4740,true);
	--ダウンできるように命令配信
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2(4745,"OnEvent_4745_1",5,1,0,once);
	proxy:NotNetMessage_end();
	
	print("OnEvent_4740 end");
end


--------------------------------------------------------------------------------------
--4741■審判者EzStateへの命令削除(秒数監視
--------------------------------------------------------------------------------------
function OnEvent_4741(proxy,param)
	print("OnEvent_4741 begin");
	proxy:DeleteEvent(4745);
	print("OnEvent_4741 end");
end

--------------------------------------------------------------------------------------
--4741■審判者EzStateへの命令削除(秒数監視
--------------------------------------------------------------------------------------
function OnEvent_4741_1(proxy,param)
	print("OnEvent_4741_1 begin");
	proxy:DeleteEvent(4745);
	--部位のダメージをもう一度回復
	proxy:CheckEventBody(4740);
	--ダウンイベント可能
	proxy:SetEventFlag(4740,false);
	print("OnEvent_4741_1 end");
end

--------------------------------------------------------------------------------------
--4742■審判者EzStateへの命令配信用
--------------------------------------------------------------------------------------
function OnEvent_4742_1(proxy,param)
	--ダウン命令送信
	proxy:SetEventCommand(804, 300);
	--ロックダミポリ無効
	proxy:SetLockActPntInvalidateMask( 804 , 221 ,true );
end

function OnEvent_4742_2(proxy,param)
	--起き上がり命令送信
	proxy:SetEventCommand(804, 310);
	--ロックダミポリ無効
	proxy:SetLockActPntInvalidateMask( 804 , 221 ,false );
end


--------------------------------------------------------------------------------------
--4743■EzStateから"ダウン始めた"を受け取った
--------------------------------------------------------------------------------------
function OnEvent_4743(proxy,param)
	print("OnEvent_4743 begin");
	print("審判者ダウンし始めた");
	proxy:LuaCallStart(4741,0);
	
	proxy:NotNetMessage_begin();
		--10秒後に起き上がるイベント
		proxy:OnKeyTime2(4743,"OnEvent_4743_1",10.0,0,1,once);
	proxy:NotNetMessage_end();
	
	print("OnEvent_4743 end");
end


function OnEvent_4743_1(proxy,param)
	print("OnEvent_4743_1 begin");
	--起き始めるまで命令を送る
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2(4745,"OnEvent_4745_2",5,1,20,once);
	proxy:NotNetMessage_end();
	print("OnEvent_4743_1 end");
end



--------------------------------------------------------------------------------------
--4744■EzStateから"起き上がり始めた"を受け取った
--------------------------------------------------------------------------------------
function OnEvent_4744(proxy,param)
	print("OnEvent_4744 begin");
	print("審判者起き上がり始めた");
	proxy:LuaCallStart(4741,1);	
	print("OnEvent_4744 end");
end


--------------------------------------------------------------------------------------
--4745■審判者EzStateへの命令用
--------------------------------------------------------------------------------------
function OnEvent_4745_1(proxy,param)
	--print("OnEvent_4745_1 begin");
	--ダウン命令を送信し続ける
	proxy:LuaCallStart(4742,1);
	--print("OnEvent_4745_1 end");
end

function OnEvent_4745_2(proxy,param)
	--print("OnEvent_4745_2 begin");
	--起き上がり命令を送信し続ける
	proxy:LuaCallStart(4742,2);
	--print("OnEvent_4745_2 end");
end

--[[
--------------------------------------------------------------------------------------
--648■審判者攻撃ターゲット監視
--------------------------------------------------------------------------------------
function Check_648(proxy)
	if proxy:IsAlive(804) == true then
		--審判者のターゲットしているキャラクタのID取得
		local targetID = proxy:GetTargetChrID(804);
		if targetID >= 0 then
			--ターゲットがエリア１に入っているか？
			if proxy:IsRegionIn(targetID,2281) == true then
				proxy:SendEventRequest(804,0,AI_EVENT_AREA01);
			--ターゲットがエリア２に入っているか？
			elseif proxy:IsRegionIn(targetID,2282) == true then
				proxy:SendEventRequest(804,0,AI_EVENT_AREA02);
			--ターゲットがエリア３に入っているか？
			elseif proxy:IsRegionIn(targetID,2283) == true then
				proxy:SendEventRequest(804,0,AI_EVENT_AREA03);
			--ターゲットがエリア４に入っているか？
			elseif proxy:IsRegionIn(targetID,2290) == true then
				proxy:SendEventRequest(804,0,AI_EVENT_AREA04);
			--ターゲットがエリア５に入っているか？
			elseif proxy:IsRegionIn(targetID,2291) == true then
				proxy:SendEventRequest(804,0,AI_EVENT_AREA05);
			--ターゲットがエリア３に入っているか？
			elseif proxy:IsRegionIn(targetID,2292) == true then
				proxy:SendEventRequest(804,0,AI_EVENT_AREA06);
			else
				--何処にも入っていない
				proxy:SendEventRequest(804,0,AI_EVENT_None);
			end
		end		
		return false;
	end
	return true;	
end

function OnEvent_648(proxy,param)
	print("OnEvent_648 begin");
	print("審判者は死んでます");
	proxy:DeleteEvent(648);
	print("OnEvent_648 end");
end
]]

function OnEvent_4748(proxy,param)
	--ダミー
end
