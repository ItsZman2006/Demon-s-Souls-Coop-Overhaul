
--��w偁@���C�x���g�_���[�W�`�d��
SPIDER_DAMAGERATE = 0;
--�n�ׂ�����
SPIDER_DOWNTIME = 10.0;

--------------------------------------------------------------------------------------
--�C�x���g���������{�X�ŗL�̃C�x���g��o�^����ۂɎg�p���Ă�������
--------------------------------------------------------------------------------------
function EventBoss_Initialize_m06_00_00_00(proxy)
	print("EventBoss_Initialize_m06_00_00_00 begin");
	if proxy:IsCompleteEvent( 6174 ) == false then--�{�X�������Ă�����
		print("�{�X�͐����Ă���̂ŁA�������J�n")
		--�{�X�̏�����
		BossInit_Spider(proxy,param);
		--�N���C�A���g�Ŗ����Ȃ�@�V���O���@or�@�z�X�g
		if	proxy:IsClient() == false then
			proxy:RequestForceUpdateNetwork( 810 );			
		end	
		--[[
		6200�`7020
		]]
		proxy:NotNetMessage_begin();
			--��211���w偂̑��̈�ɓ�������
			proxy:OnRegionIn( 211 , 10000 , 2055 , "OnEvent_211" , everytime );
			--��212���w偂̑��̈�ɓ�������
			proxy:OnRegionIn( 212 , 10000 , 2056 , "OnEvent_212" , everytime );
			--��213���w偂̑��̈�ɓ�������
			proxy:OnRegionIn( 213 , 10000 , 2057 , "OnEvent_213" , everytime );		
		proxy:NotNetMessage_end();	
	end
	
	--[[
	SingleReset( proxy ,6201);
	--EzState���ߗp�b���C�x���g�폜
	proxy:LuaCall(6201,0,"OnEvent_6201",everytime);
	proxy:LuaCall(6201,1,"OnEvent_6201_1",everytime);
	
	SingleReset( proxy ,6202);
	--EzState���ߔz�M�p
	proxy:LuaCall(6202,1,"OnEvent_6202_1",everytime);
	proxy:LuaCall(6202,2,"OnEvent_6202_2",everytime);
	
	SingleReset( proxy ,6203);
	SingleReset( proxy ,6204);
	--EzState�̊Ď�
	proxy:OnCheckEzStateMessage(6203,810,"OnEvent_6203",550);
	proxy:OnCheckEzStateMessage(6204,810,"OnEvent_6204",560);
	]]
		
	--�{�X�������Ă��鎞�������������ǕύX����ď펞�ɂȂ����B	
		
	print("EventBoss_Initialize_m06_00_00_00 end");
end

--------------------------------------------------------------------------------------
--�{�X�p�̏������������K�v�ȂƂ��Ɏg�p�F�ŗL���̍쐬��
--------------------------------------------------------------------------------------
function BossInit_Spider(proxy,param)
	print("BossInit_Spider begin");
	local eveid = 6187;
	local bossid = 810;
	
	proxy:SetSuperArmor( 810, true);--�X�[�p�[�A�[�}�[	

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
--�{�X�J�n�̊֐�
--------------------------------------------------------------------------------------
function BossEventStart_Spider(proxy,param)
	print("BossEventStart_Spider begin");
	--proxy:OnRegistFunc(6180,"Check_6180","OnEvent_6180",1,once);	
	print("BossEventStart_Spider end");
end


--[[
--------------------------------------------------------------------------------------
--�{�X�̏�Ԕ���
--------------------------------------------------------------------------------------
function Check_6180(proxy,param)
	if proxy:IsAlive(810) == true then
		
		local targetID = proxy:GetTargetChrID(810);
		if targetID ~= -1 then
			--�g���l���ɂ��邩�H
			if proxy:IsRegionIn(targetID,2060) == true then
			
				proxy:SendEventRequest(810,0,AI_EVENT_STAY_TUNNEL);
				
				--�E��
				if proxy:IsRegionIn(targetID,2080) == true then
					proxy:SendEventRequest(810,1,AI_EVENT_TUNNEL_RIGHT);
				--����
				elseif proxy:IsRegionIn(targetID,2090) == true then
					proxy:SendEventRequest(810,1,AI_EVENT_TUNNEL_CENTER);
				--����
				elseif proxy:IsRegionIn(targetID,2100) == true then
					proxy:SendEventRequest(810,1,AI_EVENT_TUNNEL_LEFT);
				--�ǂ�ɂ��Y�����Ȃ�
				else
					proxy:SendEventRequest(810,1,AI_EVENT_NONE);			
				end
				
			--�����̒��ɂ��邩�H
			elseif proxy:IsRegionIn(targetID,2070) == true then
			
				proxy:SendEventRequest(810,0,AI_EVENT_STAY_ROOM);
				
				--�E��
				if proxy:IsRegionIn(targetID,2110) == true then
					proxy:SendEventRequest(810,1,AI_EVENT_ROOM_RIGHT);
				--����
				elseif proxy:IsRegionIn(targetID,2120) == true then
					proxy:SendEventRequest(810,1,AI_EVENT_NONE);
				--����
				elseif proxy:IsRegionIn(targetID,2130) == true then
					proxy:SendEventRequest(810,1,AI_EVENT_ROOM_LEFT);
				--�ǂ�ɂ��Y�����Ȃ�
				else
					proxy:SendEventRequest(810,1,AI_EVENT_NONE);			
				end
				
			--�ǂ�ɂ��Y�����Ȃ�
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
	proxy:DeleteEvent(6187);--�C�x���g���ʃ_���[�W�폜
	print("OnEvent_6180 end");
end
]]

--------------------------------------------------------------------------------------
--��w偂̑��_���[�W
--------------------------------------------------------------------------------------
function OnEvent_6187(proxy,param)
	print("OnEvent_6187 begin");
	proxy:CheckEventBody(6187);--�C�x���g���ʂ̉�
	print("OnEvent_6187 end");
end


--------------------------------------------------------------------------------------
--��211���w偂̑��̈�ɓ�������
--------------------------------------------------------------------------------------
function OnEvent_211( proxy,param )
	if proxy:IsAlive( 810 ) == true then
		proxy:SetEventSpecialEffect( 10000 , 10110 );
	end
end

--------------------------------------------------------------------------------------
--��212���w偂̑��̈�ɓ�������
--------------------------------------------------------------------------------------
function OnEvent_212( proxy,param )
	if proxy:IsAlive( 810 ) == true then
		proxy:SetEventSpecialEffect( 10000 , 10110 );
	end
end

--------------------------------------------------------------------------------------
--��213���w偂̑��̈�ɓ�������
--------------------------------------------------------------------------------------
function OnEvent_213( proxy,param )
	if proxy:IsAlive( 810 ) == true then
		proxy:SetEventSpecialEffect( 10000 , 10110 );
	end
end


--------------------------------------------------------------------------------------
--6200����w偕��ʃ_���[�W����
--------------------------------------------------------------------------------------
function OnEvent_6200(proxy,param)
	if proxy:IsCompleteEvent(6200) == true then
		return;
	end
	print("OnEvent_6200 begin");
	--��U��
	--proxy:CheckEventBody(6200);
	--�_�E���C�x���g�d���֎~�p
	proxy:SetEventFlag(6200,true);
	--�_�E���ł���悤�ɖ��ߔz�M
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2(6205,"OnEvent_6205_1",5,1,0,once);
	proxy:NotNetMessage_end();
	
	print("OnEvent_6200 end");
end

--------------------------------------------------------------------------------------
--6201����w�EzState�ւ̖��ߍ폜(�b���Ď�
--------------------------------------------------------------------------------------
function OnEvent_6201(proxy,param)
	print("OnEvent_6201 begin");
	proxy:DeleteEvent(6205);
	print("OnEvent_6201 end");
end

--------------------------------------------------------------------------------------
--6201���R����EzState�ւ̖��ߍ폜(�b���Ď�
--------------------------------------------------------------------------------------
function OnEvent_6201_1(proxy,param)
	print("OnEvent_6201_1 begin");
	proxy:DeleteEvent(6205);
	--���ʂ̃_���[�W��������x��
	proxy:CheckEventBody(6200);
	--�_�E���C�x���g�\
	proxy:SetEventFlag(6200,false);
	print("OnEvent_6201_1 end");
end


--------------------------------------------------------------------------------------
--6202����w�EzState�ւ̖��ߔz�M�p
--------------------------------------------------------------------------------------
function OnEvent_6202_1(proxy,param)
	--�n�ׂ����ߑ��M
	proxy:SetEventCommand(810, 650);	
end

function OnEvent_6202_2(proxy,param)
	--�N���オ��U�����ߑ��M
	proxy:SetEventCommand(810, 660);	
end


--------------------------------------------------------------------------------------
--6203��EzState����"�n�ׂ��n�߂�"���󂯎����
--------------------------------------------------------------------------------------
function OnEvent_6203(proxy,param)
	print("OnEvent_6203 begin");
	print("��w偒n�ׂ��n�߂�");
	proxy:LuaCallStart(6201,0);
	
	proxy:NotNetMessage_begin();
		--10�b��ɋN���オ��C�x���g
		proxy:OnKeyTime2(6203,"OnEvent_6203_1",SPIDER_DOWNTIME,0,1,once);
	proxy:NotNetMessage_end();
	
	print("OnEvent_6203 end");
end


function OnEvent_6203_1(proxy,param)
	print("OnEvent_6203_1 begin");
	--�N���n�߂�܂Ŗ��߂𑗂�
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2(6205,"OnEvent_6205_2",5,1,20,once);
	proxy:NotNetMessage_end();
	print("OnEvent_6203_1 end");
end



--------------------------------------------------------------------------------------
--6204��EzState����"�N���オ��U���n�߂�"���󂯎����
--------------------------------------------------------------------------------------
function OnEvent_6204(proxy,param)
	print("OnEvent_6204 begin");
	print("��w偋N���オ��U���n�߂�");
	proxy:LuaCallStart(6201,1);	
	print("OnEvent_6204 end");
end

--------------------------------------------------------------------------------------
--6205����w�EzState�ւ̖��ߗp
--------------------------------------------------------------------------------------
function OnEvent_6205_1(proxy,param)
	--print("OnEvent_6205_1 begin");
	--�_�E�����߂𑗐M��������
	proxy:LuaCallStart(6202,1);
	--print("OnEvent_6205_1 end");
end

function OnEvent_6205_2(proxy,param)
	--print("OnEvent_6205_2 begin");
	--�N���オ�薽�߂𑗐M��������
	proxy:LuaCallStart(6202,2);
	--print("OnEvent_6205_2 end");
end
