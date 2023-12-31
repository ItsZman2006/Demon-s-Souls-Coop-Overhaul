
--大蜘蛛　足イベントダメージ伝播率
SPIDER_DAMAGERATE = 0;
--地べた時間
SPIDER_DOWNTIME = 10.0;

--------------------------------------------------------------------------------------
--イベント初期化■ボス固有のイベントを登録する際に使用してください
--------------------------------------------------------------------------------------
function EventBoss_Initialize_m06_00_00_00(proxy)
	print("EventBoss_Initialize_m06_00_00_00 begin");
	if proxy:IsCompleteEvent( 6174 ) == false then--ボスが生きていたら
		print("ボスは生きているので、初期化開始")
		--ボスの初期化
		BossInit_Spider(proxy,param);
		--クライアントで無いなら　シングル　or　ホスト
		if	proxy:IsClient() == false then
			proxy:RequestForceUpdateNetwork( 810 );			
		end	
		--[[
		6200〜7020
		]]
		proxy:NotNetMessage_begin();
			--■211■蜘蛛の巣領域に入った■
			proxy:OnRegionIn( 211 , 10000 , 2055 , "OnEvent_211" , everytime );
			--■212■蜘蛛の巣領域に入った■
			proxy:OnRegionIn( 212 , 10000 , 2056 , "OnEvent_212" , everytime );
			--■213■蜘蛛の巣領域に入った■
			proxy:OnRegionIn( 213 , 10000 , 2057 , "OnEvent_213" , everytime );		
		proxy:NotNetMessage_end();	
	end
	
	--[[
	SingleReset( proxy ,6201);
	--EzState命令用秒数イベント削除
	proxy:LuaCall(6201,0,"OnEvent_6201",everytime);
	proxy:LuaCall(6201,1,"OnEvent_6201_1",everytime);
	
	SingleReset( proxy ,6202);
	--EzState命令配信用
	proxy:LuaCall(6202,1,"OnEvent_6202_1",everytime);
	proxy:LuaCall(6202,2,"OnEvent_6202_2",everytime);
	
	SingleReset( proxy ,6203);
	SingleReset( proxy ,6204);
	--EzStateの監視
	proxy:OnCheckEzStateMessage(6203,810,"OnEvent_6203",550);
	proxy:OnCheckEzStateMessage(6204,810,"OnEvent_6204",560);
	]]
		
	--ボスが生きている時だけだったけど変更されて常時になった。	
		
	print("EventBoss_Initialize_m06_00_00_00 end");
end

--------------------------------------------------------------------------------------
--ボス用の初期化処理が必要なときに使用：固有情報の作成等
--------------------------------------------------------------------------------------
function BossInit_Spider(proxy,param)
	print("BossInit_Spider begin");
	local eveid = 6187;
	local bossid = 810;
	
	proxy:SetSuperArmor( 810, true);--スーパーアーマー	

	if proxy:CreateEventBody(eveid,bossid,"OnEvent_"..eveid,1000000,SPIDER_DAMAGERATE,everytime) == true then				
		proxy:AddEventParts_Ignore(eveid,bossid,"Ragdoll_FootLarge_R_03");		
		proxy:AddEventParts_Ignore(eveid,bossid,"Ragdoll_FootLarge_R_04");		
		proxy:AddEventParts_Ignore(eveid,bossid,"Ragdoll_FootLarge_R_06");		
		proxy:AddEventParts_Ignore(eveid,bossid,"Ragdoll_FootLarge_R_21");		
		proxy:AddEventParts_Ignore(eveid,bossid,"Ragdoll_FootLarge_R_09");		
		proxy:AddEventParts_Ignore(eveid,bossid,"Ragdoll_FootLarge_R_16");		
		proxy:AddEventParts_Ignore(eveid,bossid,"Ragdoll_FootLarge_R_10");		
		proxy:AddEventParts_Ignore(eveid,bossid,"Ragdoll_FootLarge_R_11");
		
		proxy:AddEventParts_Ignore(eveid,bossid,"Ragdoll_FootLarge_L_20");		
		proxy:AddEventParts_Ignore(eveid,bossid,"Ragdoll_FootLarge_L_22");		
		proxy:AddEventParts_Ignore(eveid,bossid,"Ragdoll_FootLarge_L_04");		
		proxy:AddEventParts_Ignore(eveid,bossid,"Ragdoll_FootLarge_L_01");		
		proxy:AddEventParts_Ignore(eveid,bossid,"Ragdoll_FootLarge_L_09");
		proxy:AddEventParts_Ignore(eveid,bossid,"Ragdoll_FootLarge_L_10");
		proxy:AddEventParts_Ignore(eveid,bossid,"Ragdoll_FootLarge_L_15");
		proxy:AddEventParts_Ignore(eveid,bossid,"Ragdoll_FootLarge_L_16");
	end
	
--[[
	SPIDER_EVENTHP = 1;
	SingleReset( proxy, 6200 );
	if proxy:CreateEventBodyPlus(6200,bossid,"OnEvent_6200",SPIDER_EVENTHP,1,0,everytime) == true then
		proxy:AddEventParts(6200,bossid,"Ragdoll_FootSmall_L_05");		
		proxy:AddEventParts(6200,bossid,"Ragdoll_FootSmall_L_04");
		proxy:AddEventParts(6200,bossid,"Ragdoll_FootSmall_L_01");
		proxy:AddEventParts(6200,bossid,"Ragdoll_FootSmall_L_06");
		proxy:AddEventParts(6200,bossid,"Ragdoll_FootSmall_L_02");
		proxy:AddEventParts(6200,bossid,"Ragdoll_FootSmall_L_03");
		proxy:AddEventParts(6200,bossid,"Ragdoll_FootSmall_R_05");
		proxy:AddEventParts(6200,bossid,"Ragdoll_FootSmall_R_04");
		proxy:AddEventParts(6200,bossid,"Ragdoll_FootSmall_R_01");
		proxy:AddEventParts(6200,bossid,"Ragdoll_FootSmall_R_06");
		proxy:AddEventParts(6200,bossid,"Ragdoll_FootSmall_R_02");
		proxy:AddEventParts(6200,bossid,"Ragdoll_FootSmall_R_03");
		
	else
		print("Create EventBody Error");
	end
	]]
	print("BossInit_Spider end");
end

--------------------------------------------------------------------------------------
--ボス開始の関数
--------------------------------------------------------------------------------------
function BossEventStart_Spider(proxy,param)
	print("BossEventStart_Spider begin");
	--proxy:OnRegistFunc(6180,"Check_6180","OnEvent_6180",1,once);	
	print("BossEventStart_Spider end");
end


--[[
--------------------------------------------------------------------------------------
--ボスの状態判定
--------------------------------------------------------------------------------------
function Check_6180(proxy,param)
	if proxy:IsAlive(810) == true then
		
		local targetID = proxy:GetTargetChrID(810);
		if targetID ~= -1 then
			--トンネルにいるか？
			if proxy:IsRegionIn(targetID,2060) == true then
			
				proxy:SendEventRequest(810,0,AI_EVENT_STAY_TUNNEL);
				
				--右側
				if proxy:IsRegionIn(targetID,2080) == true then
					proxy:SendEventRequest(810,1,AI_EVENT_TUNNEL_RIGHT);
				--中央
				elseif proxy:IsRegionIn(targetID,2090) == true then
					proxy:SendEventRequest(810,1,AI_EVENT_TUNNEL_CENTER);
				--左側
				elseif proxy:IsRegionIn(targetID,2100) == true then
					proxy:SendEventRequest(810,1,AI_EVENT_TUNNEL_LEFT);
				--どれにも該当しない
				else
					proxy:SendEventRequest(810,1,AI_EVENT_NONE);			
				end
				
			--部屋の中にいるか？
			elseif proxy:IsRegionIn(targetID,2070) == true then
			
				proxy:SendEventRequest(810,0,AI_EVENT_STAY_ROOM);
				
				--右側
				if proxy:IsRegionIn(targetID,2110) == true then
					proxy:SendEventRequest(810,1,AI_EVENT_ROOM_RIGHT);
				--中央
				elseif proxy:IsRegionIn(targetID,2120) == true then
					proxy:SendEventRequest(810,1,AI_EVENT_NONE);
				--左側
				elseif proxy:IsRegionIn(targetID,2130) == true then
					proxy:SendEventRequest(810,1,AI_EVENT_ROOM_LEFT);
				--どれにも該当しない
				else
					proxy:SendEventRequest(810,1,AI_EVENT_NONE);			
				end
				
			--どれにも該当しない
			else		
				proxy:SendEventRequest(810,0,AI_EVENT_NONE);
			end
		end
		return false;
	end
	return true;
end
]]

--[[
function OnEvent_6180(proxy,param)
	print("OnEvent_6180 begin");
	print("Spider dead");
	proxy:DeleteEvent(6187);--イベント部位ダメージ削除
	print("OnEvent_6180 end");
end
]]

--------------------------------------------------------------------------------------
--大蜘蛛の足ダメージ
--------------------------------------------------------------------------------------
function OnEvent_6187(proxy,param)
	print("OnEvent_6187 begin");
	proxy:CheckEventBody(6187);--イベント部位の回復
	print("OnEvent_6187 end");
end


--------------------------------------------------------------------------------------
--■211■蜘蛛の巣領域に入った■
--------------------------------------------------------------------------------------
function OnEvent_211( proxy,param )
	if proxy:IsAlive( 810 ) == true then
		proxy:SetEventSpecialEffect( 10000 , 10110 );
	end
end

--------------------------------------------------------------------------------------
--■212■蜘蛛の巣領域に入った■
--------------------------------------------------------------------------------------
function OnEvent_212( proxy,param )
	if proxy:IsAlive( 810 ) == true then
		proxy:SetEventSpecialEffect( 10000 , 10110 );
	end
end

--------------------------------------------------------------------------------------
--■213■蜘蛛の巣領域に入った■
--------------------------------------------------------------------------------------
function OnEvent_213( proxy,param )
	if proxy:IsAlive( 810 ) == true then
		proxy:SetEventSpecialEffect( 10000 , 10110 );
	end
end


--------------------------------------------------------------------------------------
--6200■大蜘蛛部位ダメージ発動
--------------------------------------------------------------------------------------
function OnEvent_6200(proxy,param)
	if proxy:IsCompleteEvent(6200) == true then
		return;
	end
	print("OnEvent_6200 begin");
	--一旦回復
	--proxy:CheckEventBody(6200);
	--ダウンイベント重複禁止用
	proxy:SetEventFlag(6200,true);
	--ダウンできるように命令配信
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2(6205,"OnEvent_6205_1",5,1,0,once);
	proxy:NotNetMessage_end();
	
	print("OnEvent_6200 end");
end

--------------------------------------------------------------------------------------
--6201■大蜘蛛EzStateへの命令削除(秒数監視
--------------------------------------------------------------------------------------
function OnEvent_6201(proxy,param)
	print("OnEvent_6201 begin");
	proxy:DeleteEvent(6205);
	print("OnEvent_6201 end");
end

--------------------------------------------------------------------------------------
--6201■審判者EzStateへの命令削除(秒数監視
--------------------------------------------------------------------------------------
function OnEvent_6201_1(proxy,param)
	print("OnEvent_6201_1 begin");
	proxy:DeleteEvent(6205);
	--部位のダメージをもう一度回復
	proxy:CheckEventBody(6200);
	--ダウンイベント可能
	proxy:SetEventFlag(6200,false);
	print("OnEvent_6201_1 end");
end


--------------------------------------------------------------------------------------
--6202■大蜘蛛EzStateへの命令配信用
--------------------------------------------------------------------------------------
function OnEvent_6202_1(proxy,param)
	--地べた命令送信
	proxy:SetEventCommand(810, 650);	
end

function OnEvent_6202_2(proxy,param)
	--起き上がり攻撃命令送信
	proxy:SetEventCommand(810, 660);	
end


--------------------------------------------------------------------------------------
--6203■EzStateから"地べた始めた"を受け取った
--------------------------------------------------------------------------------------
function OnEvent_6203(proxy,param)
	print("OnEvent_6203 begin");
	print("大蜘蛛地べた始めた");
	proxy:LuaCallStart(6201,0);
	
	proxy:NotNetMessage_begin();
		--10秒後に起き上がるイベント
		proxy:OnKeyTime2(6203,"OnEvent_6203_1",SPIDER_DOWNTIME,0,1,once);
	proxy:NotNetMessage_end();
	
	print("OnEvent_6203 end");
end


function OnEvent_6203_1(proxy,param)
	print("OnEvent_6203_1 begin");
	--起き始めるまで命令を送る
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2(6205,"OnEvent_6205_2",5,1,20,once);
	proxy:NotNetMessage_end();
	print("OnEvent_6203_1 end");
end



--------------------------------------------------------------------------------------
--6204■EzStateから"起き上がり攻撃始めた"を受け取った
--------------------------------------------------------------------------------------
function OnEvent_6204(proxy,param)
	print("OnEvent_6204 begin");
	print("大蜘蛛起き上がり攻撃始めた");
	proxy:LuaCallStart(6201,1);	
	print("OnEvent_6204 end");
end

--------------------------------------------------------------------------------------
--6205■大蜘蛛EzStateへの命令用
--------------------------------------------------------------------------------------
function OnEvent_6205_1(proxy,param)
	--print("OnEvent_6205_1 begin");
	--ダウン命令を送信し続ける
	proxy:LuaCallStart(6202,1);
	--print("OnEvent_6205_1 end");
end

function OnEvent_6205_2(proxy,param)
	--print("OnEvent_6205_2 begin");
	--起き上がり命令を送信し続ける
	proxy:LuaCallStart(6202,2);
	--print("OnEvent_6205_2 end");
end
