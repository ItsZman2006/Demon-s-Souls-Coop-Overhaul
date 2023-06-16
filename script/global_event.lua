once = 1;
everytime = 0;

--Time adjustment here
Tutorial_pausewait = 0.14;

ClearBossId = -900;
ClearBoss = true;

--Forced recall flag
IsForceSummon = false;

---------------------------------------------------------------------------------------------------------------------------------
--	��List of system event IDs (4000~4095) used
---------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------
-- 4000 own death events
-- 4001 EzState action abort processing
-- 4002 When pressing the ladder event input (up)
-- 4003 When pressing the ladder event input (down)
-- 4004 When EzState gives you "One step up"
-- When 4005 EzState gave you "One step down"
-- 4010 Animation Synchronization (Treasure Corpse Animation)
-- 4012 Animation synchronization (walking animation)
-- 4013 Animation synchronization (with animation ID specified)
-- 4015 Super Armor Sync (Enabled)
-- 4016 Super Armor Sync (disabled)
-- 4017 Full Invincibility Synchronization (Enabled)
-- 4018 Full Invincibility Synchronization (Disabled)
-- 4020 Death Irregular Monitoring (If this is ON,
-- 4021 debug load event
-- 4030 PK resurrection
-- 4031
-- 4032 Own Blood Letter Event
-- 4033 Session expired

-- 3001 for multi-wall synchronization
-- 3002 for multi-wall synchronization
-- 3003 for multi-wall synchronization
-- Use 3001, 3002, 3003 for 4034 multi-time magic wall (session connected)
-- 4035 For multi-time magic wall (disconnected from the time the session was connected)
-- Warp to 4036 SOS position (for white initial position)
-- Warp to 4037 mini block head position (for block initial position)
-- 4038 Session information monitoring (event when session failed due to timeout etc.)
-- 4039 Intrusion
-- 4040 block clear (obsolete)
-- 4041 Summon Notice
-- 4042 Death Notice
-- 4043 Participant gone
-- 4044 notify kicked out
-- 4045 Notify (to clients) that the magic wall to the boss room is traversable
-- 4046 for exit
-- 4047 Reload-related event interrupt prevention flag
-- 4048 Generic Action Button Restriction Flag (Reserved)
-- 4049 Boss Room Event
-- 4050 new block clear
-- 4051 Gate item (warp to stone pillar)
-- 4052 Warp animation connection from stone pillar
-- 4053 Hall of Fame
-- for 4054 checkpoints
-- 4055 White Ghost Resurrection Notification (for Resurrection White Count)
-- For 4056 QWC additive processing distribution
-- 4057 For registering general-purpose synchronous handlers (Actual handler registration is done here in each map's script, function descriptions here)
-- 4058 Summoning Delivery
-- 4059 End of text presentation
-- 4060 for block movement detection
-- 4061 Close dialog For distance judgment
-- 4062 for returning to title
-- 4063 Processing to know who leaves for game reasons
-- 4064 Call to cancel invincibility because it's stabilized
-- PC on top of 4065 OBJ
-- The PC on the 4066 OBJ got off
-- 4067 Ignore death expression
-- 4068 boss room blocking failure expression
-- 4069 Fire Event!
-- 4070 special effect synchronization
-- 15500 Intrusion Item Acquisition Monitor


function g_Initialize(proxy)
print("g_Initialize global_event begin");
	--Turn off tutorial death branch flag
	proxy:SetEventFlag(14080,false);--for fort entrance
	proxy:SetEventFlag(14209,false);--Walled with
	proxy:SetEventFlag(14337,false);--for lava
	
	--Attempted Acquisition Soul Reacquisition
	proxy:AddBlockClearBonus();
	--penalty check
	proxy:CheckPenalty();
	
--�� 4000 �� When you die, restart or end ��
	proxy:OnCharacterDead(99999, 10000, "OnEvent_4000", everytime);	
	proxy:NotNetMessage_begin();
		proxy:OnCharacterHP(99999,10000,"OnEvent_4000_Hp",0.0,once);
	proxy:NotNetMessage_end();
	proxy:LuaCall( 99999 , 0 , "OnEvent_4000_Hp_dummy",everytime);
	
--�� 4000_1 �� death for party delivery ��
	proxy:LuaCall( 4000, 1,"HostDead",everytime );

--�� 4001 �� When the action is interrupted by the PC ��
	proxy:OnCheckEzStateMessage(4001,10000,"OnEvent_4001",10000);
	
--�� 4006 �� When the PC is pressing the action button in the ladder event �� Described first due to priority issues
	proxy:OnActionCheckKey(4006,10000,"OnEvent_4006",0,1);		
--��4002��PC���n�V�S�C�x���g�ŃL�[���́i��j�������Ă���Ƃ���
	proxy:OnActionCheckKey(4002,10000,"OnEvent_4002",1,1);
--��4003��PC���n�V�S�C�x���g�ŃL�[���́i���j�������Ă���Ƃ���
	proxy:OnActionCheckKey(4003,10000,"OnEvent_4003",2,1);
--��4004��PC���n�V�S�C�x���g����EzState����"1�i���I����"�������������
	proxy:OnCheckEzStateMessage(4004,10000,"OnEvent_4004",0);
--��4005��PC���n�V�S�C�x���g����EzState����"1�i����I����"�������������
	proxy:OnCheckEzStateMessage(4005,10000,"OnEvent_4005",1);

--��4010���A�j���[�V�����̓����p�֐�(�󎀑̗p)��
	proxy:LuaCall( 4010 , 1 , "OnEvent_4010" , everytime );
--��4012���A�j���[�V�����̓����p�֐���
	proxy:LuaCall( 4012 , 1 , "OnEvent_4012" , everytime );
	
--��4013���A�j���[�V�����̓����p�֐���
	proxy:LuaCall( 4013 , 1 , "OnEvent_4013" , everytime );
	proxy:CustomLuaCall( SYNCHROANIM, "SynchroAnim_4013", everytime );
	
	
--��4015���X�[�p�[�A�[�}�[�̓����L������
	proxy:LuaCall( 4015 , 1 , "OnEvent_4015" , everytime );
--��4016���X�[�p�[�A�[�}�[�̓�����������
	proxy:LuaCall( 4016 , 1 , "OnEvent_4016" , everytime );
	
--��4017�����S���G�̓����L������
	proxy:LuaCall( 4017 , 1 , "OnEvent_4017" , everytime );
--��4018�����S���G�̓�����������
	proxy:LuaCall( 4018 , 1 , "OnEvent_4018" , everytime );
	
--��4019���A�^���L�������̓����p��
	proxy:LuaCall( 4019 , 1 , "OnEvent_4019" ,everytime );

--[[	
--��4020��PC���ǂ͂���C�x���g�ŃL�[����(�E)�������Ă���Ƃ���
	proxy:OnActionCheckKey(4020,10000,"OnEvent_4020",4,4);
--��4021��PC���ǂ͂���C�x���g�ŃL�[����(��)�������Ă���Ƃ���
	proxy:OnActionCheckKey(4021,10000,"OnEvent_4021",3,4);	
--��4022��PC���ǂ͂���C�x���g����EzState����"�E��1���i�ݏI����"�������������
	proxy:OnCheckEzStateMessage(4022,10000,"OnEvent_4022",20);	
--��4023��PC���ǂ͂���C�x���g����EzState����"����1���i�ݏI����"�������������
	proxy:OnCheckEzStateMessage(4023,10000,"OnEvent_4023",21);
	]]
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 4030, "g_second_Initialize", 0.1, 0, 1, once );
--��4032�������̌�������
		proxy:OnSelfBloodMark( 4032, "SelfBloodMark", ATTR_LIVE + ATTR_GREY, everytime );
--��4033���Z�b�V�����؂ꁡ
		--proxy:OnSessionJustOut( 4033, "SessionJustOut", everytime );

	SingleReset(proxy,3001);--�u���b�N2�œ�����
	SingleReset(proxy,3002);--�u���b�N3�œ�����
	SingleReset(proxy,3003);--�u���b�N4�œ�����

--��4034���}���`�����@�Ǘp(�Z�b�V�������Ȃ�����)��
		proxy:OnSessionJustIn( 4034 , "OnEvent_4034" , everytime );
--��4035���}���`�����@�Ǘp(�Z�b�V�������Ȃ����Ă���Ƃ�����؂ꂽ)��
		proxy:OnSessionJustOut( 4035 , "OnEvent_4035" , everytime );
	proxy:NotNetMessage_end();
	

	
--��4038���Z�b�V�������Ď���
	proxy:NotNetMessage_begin();
		proxy:OnSessionInfo( 4038, "OnEvent_4038" );
	proxy:NotNetMessage_end();
	
--��4040���u���b�N�N���A��
	--proxy:LuaCall( 4040 , 1 , "BlockClear" , everytime );
--�� 4050 �� New block clear ��
	proxy:CustomLuaCall( 4050 , "BlockClear2" , everytime );
	--�A�j�������p
	proxy:LuaCall( 4050 , 20, "BlockClearSynchroAnime", everytime );
	--�����������p
	proxy:LuaCall( 4050 , 30, "BlockClearSynchroInvalid", everytime );
	
--��4041�������ʒm��
	proxy:LuaCall( 4041, 1, "SummonInfoMsg_White", everytime );
	proxy:LuaCall( 4041, 2, "SummonInfoMsg_Black", everytime );
	proxy:LuaCall( 4041, 3, "SummonInfoMsg_ForceJoinBlack", everytime );
	proxy:LuaCall( 4041, 4, "SummonInfoMsg_ForceSummonBlack", everytime );
	
--��4042�����S�ʒm��
	proxy:LuaCall( 4042, 1, "DeadInfoMsg_White", everytime );
	proxy:LuaCall( 4042, 2, "DeadInfoMsg_Black", everytime );
	proxy:LuaCall( 4042, 3, "DeadInfoMsg_Host",  everytime );
	proxy:LuaCall( 4042, 4, "dummy", everytime );--�����PK�Ŏ��S�������ɂ��u���b�N���S��m��ׁA���g����̃_�~�[���Ă�
	proxy:LuaCall( 4042, 5, "dummy", everytime );--����͘S��3�ŋ��������ŌĂ΂ꂽ�u���b�N�����񂾂Ƃ������ׁA���g����̃_�~�[���Ă�
	proxy:LuaCall( 4042, 6, "DeadInfoMsg_ForceJoinBlack", everytime );--����͘S��3�ŋ��������ŌĂ΂ꂽ�u���b�N�����񂾂Ƃ������ׁA���g����̃_�~�[���Ă�
	
--��4043���Q���҂����Ȃ��Ȃ�����
	proxy:NotNetMessage_begin();
		proxy:LuaCall( 4043, 1, "OnLeavePlayer", everytime );--�z���C�g�\�E���̃z���C�g�����Ȃ��Ȃ���
		proxy:LuaCall( 4043, 2, "OnLeavePlayer", everytime );--�u���b�N�\�E���̃u���b�N�����Ȃ��Ȃ���
		proxy:LuaCall( 4043, 3, "OnLeavePlayer", everytime );--�����u���b�N�����Ȃ��Ȃ���
		proxy:LuaCall( 4043, 4, "dummy", everytime );--�����������ꂽ�u���b�N�����Ȃ��Ȃ���
		proxy:LuaCall( 4043, 5, "dummy", everytime );--�d��OFF�A���Z�b�g���Ŗ��ӔC�ɂ��Ȃ��Ȃ���
	proxy:NotNetMessage_end();
	
--��4044���L�b�N�A�E�g�����̂�ʒm��
	proxy:LuaCall( 4044, 1, "OnKickOut", everytime );
--��4044�����ӃL�b�N�����̂�ʒm��
	proxy:LuaCall( 4044, 2, "OnThxKickOut", everytime );
	
	--[[����Ȃ��q�H
	proxy:NotNetMessage_begin();
		proxy:OnRegistFunc(4000, "Condition_AliveMotion", "Result_AliveMotion", 1, once );
	proxy:NotNetMessage_end();
	]]

--��4045���{�X�����ւ̖��@�ǂ��ʉ߉\�ł���ƒʒm(�N���C�A���g�ɑ΂���)��
	proxy:LuaCall( 4045, 1, "PossibleInfo_GoToTheBossArea", everytime );
--��4068���{�X�����ւ̑j�~�����s��������ʒm(�N���C�A���g�ɑ΂���)��
	proxy:LuaCall( 4068, 1, "Failed_BossArea" ,everytime);
	
--��4046���ޏo�ʒm��
	proxy:LuaCall( 4046, 1, "LeaveMessage", everytime );--�z���C�g
	proxy:LuaCall( 4046, 2, "LeaveMessage", everytime );--�u���b�N
	proxy:LuaCall( 4046, 3, "dummy", everytime );--�����������ꂽ�u���b�N���ޏo����
	
	
--��4055�������z���C�g�J�E���g��
	proxy:LuaCall( 4055, 1, "WhiteReviveCount", everytime );
	
--��4056��QWC���Z�����z�M�p
	proxy:LuaCall( 4056, 1, "SynchroAddQWC", everytime );
	
--��4058���������z�M
	proxy:LuaCall( 4058, 1, "Call_WhiteSos", everytime );--�z���C�g
	proxy:LuaCall( 4058, 2, "Call_BlackSos", everytime );--�u���b�N
	
--��4060���u���b�N�ړ�����	
--(ASSERT����̈�dummy�A�g�p����ۂ͊e�}�b�v��CustomLuaCall��4060�ŌĂт����n���h����o�^����)
--�u���b�N�ړ��̂��тɌĂ΂�A
--param2�Ƀu���b�NID,param3�ɃG���AID���擾�ł��܂��B
--�u���b�N�ړ�����̓��[�J���v���C���̃v���C�̈�ID���ς�������A-1�ȊO�̎�
	proxy:NotNetMessage_begin();
		proxy:CustomLuaCall( 4060, "dummy", everytime );
	proxy:NotNetMessage_end();
	
	--�Q�[���I���R�ŒN�����������Ƃ��ɔz�M
	proxy:CustomLuaCall( 4063 ,"OnGameLeave",everytime);	
	
--��4064�����薳�G�����C�x���g��
	proxy:LuaCall( 4064 ,1,"OnDisableInvincible",everytime);
	
	--��4065��OBJ�̏��PC���������
	proxy:CustomLuaCall( 4065 ,"OnEnterRideObj",everytime);	
	--��4066��OBJ�ɏ���Ă���PC���~�肽��
	proxy:CustomLuaCall( 4066 ,"OnLeaveRideObj",everytime);
	
	
	if proxy:IsLivePlayer() == true then
		proxy:SetEventFlag( 15112,true );
		proxy:SetEventFlag( 15113,true );
		proxy:SetEventFlag( 15114,true );
		proxy:SetEventFlag( 15115,true );
		
		proxy:SetEventFlag( 15116,true );
		proxy:SetEventFlag( 15117,true );
		proxy:SetEventFlag( 15118,true );
		proxy:SetEventFlag( 15119,true );			
	end
	
--�� 15500 �� Intrusion item acquisition monitoring ��
	if proxy:IsCompleteEvent( 15500 ) == false then
		proxy:NotNetMessage_begin();
			proxy:LuaCall( 15500 , 0 , "OnEvent_15500",everytime);
		proxy:NotNetMessage_end();
	end
	
	local actidlist = {
		14500,14501,14502,14503,14504,14505,14506,14507,14508,14509,
		14510,14511,14512,14513,14514,14515,14516,14517,14518,14519,
		14520,14521,14522,14523,14524,14525,14526,14527,14528,14529,
		14530,14531,14532,14533,14534,14535,14536,14537,14538,14539,
		14540,14541,14542,
	};
	local num = table.getn(actidlist);
	for index = 1 , num , 1 do
		proxy:SetEventFlag( actidlist[index],false );
	end

	if	proxy:GetTempSummonParam() > 0 then
		IsForceSummon = true;
	end
	
--Reinitialize the party size limit to 4 (It is a process to return the value changed in the prison, but to ensure temporary safety, the initial value is reset here.)
--Fixed as soon as network �� is tightened
	proxy:SetPartyRestrictNum(4);

print("g_Initialize global_event end");
end

function InGameStart(proxy,param)
	print("InGameStart begin");
		proxy:LuaCallStart( 4064,1 );
		--resurrection animation playback
		if proxy:IsAliveMotion() == true then
			print("Condition_AliveMotion Alive");			
			proxy:SetTextEffect(TEXT_TYPE_Revival);
			proxy:PlayAnimation( 10000, 6100 );
			proxy:SetAliveMotion(false);
		else
			print("Condition_AliveMotion Not Alive");
			if	proxy:IsLivePlayer() == true then
				--HpMpSpMax
				--proxy:PlayerParamRecover();
				--proxy:PlayerRecover();
				proxy:PlayAnimation( 10000, 6100 );
				proxy:NotNetMessage_begin();
					proxy:OnChrAnimEnd( SYSTEM_WARP, 10000, 6100, "AliveMotion_End", once );
				proxy:NotNetMessage_end();
			elseif	proxy:IsGreyGhost() == true then
				--HpMpSpMax
				--proxy:PlayerParamRecover();
				--proxy:PlayerRecover();
				if	proxy:IsReviveWait() == true then
					proxy:RevivePlayer();
					proxy:SetReviveWait( false );
				end
				proxy:PlayAnimation( 10000, 6100 );
				proxy:NotNetMessage_begin();
					proxy:OnChrAnimEnd( SYSTEM_WARP, 10000, 6100, "AliveMotion_End", once );
				proxy:NotNetMessage_end();
			elseif	proxy:IsWhiteGhost() == true then
				print("IsWhiteAnim");
				proxy:NotNetMessage_begin();
					proxy:OnKeyTime2(4013,"AliveMotion_wait",0.1,0,0,once);
				proxy:NotNetMessage_end();
				--[[
				proxy:CustomLuaCallStartPlus( 4013, LOCAL_PLAYER, 6100 );
				--Luafunc_PlaySynchroAnimation(proxy,param,6100);
				--proxy:PlayAnimation( 10000, 6100 );
				proxy:NotNetMessage_begin();
					proxy:OnChrAnimEnd( SYSTEM_WARP, 10000, 6100, "AliveMotion_End", once );
				proxy:NotNetMessage_end();
				]]
			elseif	proxy:IsBlackGhost() == true then
				print("IsBlackAnim");
				proxy:NotNetMessage_begin();
					proxy:OnKeyTime2(4013,"AliveMotion_wait",0.1,0,0,once);
				proxy:NotNetMessage_end();
				--[[
				proxy:CustomLuaCallStartPlus( 4013, LOCAL_PLAYER, 6100 );
				--Luafunc_PlaySynchroAnimation(proxy,param,6100);
				--proxy:PlayAnimation( 10000, 6100 );
				if	proxy:GetTempSummonParam() > 0 then
					proxy:SetEventSpecialEffect( LOCAL_PLAYER, 10180 );
				end
				proxy:NotNetMessage_begin();
					proxy:OnChrAnimEnd( SYSTEM_WARP, 10000, 6100, "AliveMotion_End", once );
				proxy:NotNetMessage_end();
				]]
				if	proxy:GetTempSummonParam() > 0 then
					proxy:SetEventSpecialEffect( LOCAL_PLAYER, 10180 );					
					--�u���b�N���������ʒm
					--�|�����ʒm
					REMO_FLAG = 2;
					proxy:LuaCallStart( 5500, 0 );
					proxy:LuaCallStart( 1030, 2 );					
				end
			end
		end
		proxy:ParamInitialize();
		
		if	proxy:IsGreyGhost()  == true or
			proxy:IsWhiteGhost() == true then
			print("SetEventSpecialEffect 10000, 101");
			proxy:SetEventSpecialEffect( 10000, 101 );
		elseif proxy:IsBlackGhost() == true then
			print("SetEventSpecialEffect 10000, 102");
			proxy:SetEventSpecialEffect( 10000, 102 );
		end
	print("InGameStart end");
end

--��4064�����薳�G������
function OnDisableInvincible(proxy,param)
	print("OnDisableInvincible begin");	
	if param:IsNetMessage() == false then		
		--�z�M�҂�����
		proxy:EnableInvincible( 10000 , false );
	else
		proxy:EnableInvincible( param:GetPlayID()+10001 , false );
	end
	print("OnDisableInvincible end");
end

--[[
function Condition_AliveMotion(proxy,param)
	if proxy:IsValidInstance( 10000, 1 ) == true then
		print("Condition_AliveMotion Success");
		return true;
	end
	return false;
end

function Result_AliveMotion(proxy,param)
print("Result_AliveMotion begin");
print("Result_AliveMotion end");
end

function AliveMotion_2(proxy,param)
	print("AliveMotion_2 begin");
	proxy:CustomLuaCallStartPlus( 4013, LOCAL_PLAYER, 8288 );
	--Luafunc_PlaySynchroAnimation(proxy,param,8288);
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( SYSTEM_WARP, 10000, 8288, "AliveMotion_End", once );
	proxy:NotNetMessage_end();
	print("AliveMotion_2 end");
end
]]

function AliveMotion_wait(proxy,param)
	print("AliveMotion_wait begin");
	proxy:CustomLuaCallStartPlus( 4013, LOCAL_PLAYER, 6100 );
	--Luafunc_PlaySynchroAnimation(proxy,param,6100);
	--proxy:PlayAnimation( 10000, 6100 );
	proxy:NotNetMessage_begin();
		proxy:OnChrAnimEnd( SYSTEM_WARP, 10000, 6100, "AliveMotion_End", once );
	proxy:NotNetMessage_end();
	print("AliveMotion_wait end");
end

------------------------------------------------------------------------------------------------
----After playing the initial animation------------------------------------------------------------------------
------------------------------------------------------------------------------------------------
function AliveMotion_End(proxy,param)
	if proxy:IsInParty() == true then
	print("AliveMotion_End begin");
	
		-----------------------------------------------------------------------------
		--Summon notification *Moved here because the timing was changed after the initial animation
		-----------------------------------------------------------------------------
		--Normally 0 is returned, so this process does not pass
		--Judgment is made only when summoned
		if		proxy:GetTempSummonParam() == -1 then
			--white summons notice
			proxy:LuaCallStartPlus( 4041, 1, proxy:GetLocalPlayerId() );
		elseif 	proxy:GetTempSummonParam() == -2 then
			--�u���b�N�����ʒm
			proxy:LuaCallStartPlus( 4041, 2, proxy:GetLocalPlayerId() );
		elseif 	proxy:GetTempSummonParam() == -3 then
			--�u���b�N�����ʒm
			proxy:LuaCallStartPlus( 4041, 3, proxy:GetLocalPlayerId() );
		elseif 	proxy:GetTempSummonParam() >   0 then
			--�u���b�N���������ʒm
			proxy:LuaCallStartPlus( 4041, 4, proxy:GetLocalPlayerId() );
		end

		print("AliveMotion_End end");
	else
		proxy:ResetSummonParam();
		proxy:WARN("AliveMotion_End ���Ƀ��[��������");
	end
end



function g_second_Initialize(proxy, param)
print("g_second_Initialize begin");
--�����t���[�����ƁA�L�����N�^�̃^�C�v�����肵�Ă��Ȃ����ۂ��̂�
--0�b��ł��炵�Ă݂܂����B
--��4030��PK�Ď�(�u���b�N�S�[�X�g�p)��
	print("PK�Ď��ǉ�");
	proxy:OnPlayerKill( 4030, "PlayerKill_4030_sub", everytime );
	proxy:CustomLuaCall( 4030, "PlayerKill_4030", everytime );
	
--�� Disable the magic wall for multiplayer
	if proxy:GetLocalPlayerChrType() == CHR_TYPE_GreyGhost or proxy:GetLocalPlayerChrType() == CHR_TYPE_LivePlayer or proxy:GetLocalPlayerChrType == CHR_TYPE_WhiteGhost then
		proxy:NotNetMessage_begin();
			proxy:OnKeyTime2( 4035 , "OnEvent_4035" , 0.0 , 0 , 1 , once );
		proxy:NotNetMessage_end();
	end
	
	if proxy:IsInParty() == false then
	end
	
print("g_second_Initialize end");
end


function OnEvent_4000_Hp(proxy,param)
	print("OnEvent_4000_Hp begin");
	--Hp��0�ɂȂ����̂�
	--���S�񕜗v��
	proxy:RequestFullRecover();
	if proxy:IsClient() == false then
		proxy:LuaCallStart( 99999 , 0 );
	end
	print("OnEvent_4000_Hp end");
end

function OnEvent_4000_Hp_dummy(proxy,param)	
end

--�� 4000 �� Restart when you die ��
function OnEvent_4000(proxy, param)
	if proxy:IsCompleteEvent(4000) == true then
		--print("OnEvent_4000 IsCompleteEvent return end");
		return;
	end
	if param:IsNetMessage()==true  then
		--print("OnEvent_4000 IsNetMessage return end");
		return;
	end
	print("OnEvent_4000 begin");
	--�`���[�g���A���ԓ�����}�b�v�̃t���O���������Ă���Ȃ�
	if proxy:IsCompleteEvent(14080) == true then
		proxy:SetTextEffect(TEXT_TYPE_Dead);
		proxy:OnKeyTime2(4000,"m08_00Death",0.0,0,0,once);
		return;
	end
	--�`���[�g���A���ԃ}�b�v�̃t���O���������Ă���Ȃ�
	if proxy:IsCompleteEvent(14209) == true then--m08_01�̎��S�C�x���g�ɔ��
		proxy:SetTextEffect(TEXT_TYPE_Dead);
		proxy:OnKeyTime2(4000,"m08_01Death",0.0,0,0,once);
		return;
	end
	--�`���[�g���A���n��}�b�v�̃t���O���������Ă���Ȃ�
	if proxy:IsCompleteEvent(14337) == true then--m08_02�̎��S�C�x���g�ɔ��
		proxy:SetTextEffect(TEXT_TYPE_Dead);
		proxy:OnKeyTime2(4000,"m08_02Death",0.0,0,0,once);
		return;
	end
	
	
	--���S���̓��삪���ɓ����Ă���ꍇ�͔��肵�Ȃ�
	if proxy:GetReturnState() >0 then
		return;
	end
	
	local Live  = proxy:IsLivePlayer();	--����
	local Grey  = proxy:IsGreyGhost();	--�O���C�S�[�X�g
	local White = proxy:IsWhiteGhost();	--�z���C�g�S�[�X�g
	local Black = proxy:IsBlackGhost();	--�u���b�N�S�[�X�g
	local Host  = proxy:IsHost();		--�z�X�g���H
	local Party = proxy:IsInParty();	--PT���H
	local dead  = false;				--�����Ǝ��񂾂��H

	--�g�D���[�f�X����
	
	if proxy:IsCompleteEvent(4067) == false then
		if Live == true then
			proxy:SetTextEffect(TEXT_TYPE_Dead);
		else
			proxy:SetTextEffect( TEXT_TYPE_GhostDead );
		end
	end
	
	--�z�X�g���S����
	if Live == true or Grey == true then		
		if Live == true then
			proxy:SetEventFlag( 15112,false );
			proxy:SetEventFlag( 15113,false );
			proxy:SetEventFlag( 15114,false );
			proxy:SetEventFlag( 15115,false );
			
			proxy:SetEventFlag( 15116,false );
			proxy:SetEventFlag( 15117,false );
			proxy:SetEventFlag( 15118,false );
			proxy:SetEventFlag( 15119,false );			
		end
		if Party == true and Host == true then			
			--�O���C�S�[�X�g�t���OON
			proxy:SetEventFlag( 16700 , true );
			--���S���J�E���g�A�b�v
			proxy:AddDeathCount();
			proxy:NotNetMessage_begin();
				--�z�X�g�{�l�̓\���v���C���S�Ɠ���
				proxy:OnKeyTime2(4000,"SoloPlayDeath",0.0,0,1,once);
			proxy:NotNetMessage_end();
			--�p�[�e�B�[�z�M�p�̎��S�C�x���g�𔭍s(�z�X�g�͓����ł͂������)
			proxy:LuaCallStart(4000, 1 );
			dead = true;
		end
	end
	
	--client death
	if Black == true or White == true then		
		proxy:NotNetMessage_begin();
			proxy:OnKeyTime2(4000,"PartyGhostDeath",0.0,0,1,once);
		proxy:NotNetMessage_end();
		dead = true;
	end

	--survival solo play death
	if Live == true or Grey == true then
		if Party == false then			
			--�O���C�S�[�X�g�t���OON
			proxy:SetEventFlag( 16700 , true );
			--���S���J�E���g�A�b�v
			proxy:AddDeathCount();
			proxy:NotNetMessage_begin();
				proxy:OnKeyTime2(4000,"SoloPlayDeath", 0.0, 0,1,once);
			proxy:NotNetMessage_end();
			dead = true;
		end
	end
	
	if dead == false then
		print("Check ChrType!!");
		--�ُ��ʒm(�C�x���g�ǈȊO�Ŏ��S�Ŗ�肪�����������ɂ͂��̃t���O�����Ă�������)
		--�L�����^�C�v�������A�O���C�A�z���C�g�A�u���b�N�ȊO�̉\��������܂��B
		--���[�h�������Ȃ��ŁA�L�����^�C�v���m�F���Ă��������B
		proxy:NotNetMessage_begin();
			proxy:OnKeyTime2(4000,"SoloPlayDeath", 0.0, 0,1,once);
		proxy:NotNetMessage_end();
		proxy:SetEventFlag(4020,true);
	end	
	proxy:SetEventFlag(4000,true);
	print("OnEvent_4000 end");
end




--��4000_1���p�[�e�B�[�z�M�p���S��
function HostDead(proxy, param)	
	if proxy:IsHost() == true or proxy:IsGreyGhost() == true then
		return;
	end
	if proxy:IsCompleteEvent( 4047 ) == true then
		return;
	end
	
	--�u���b�N�S�[�X�g�̏ꍇ�͖ڕW�B���̗����
	if	proxy:IsBlackGhost() == true then
		proxy:NotNetMessage_begin();
			--���̍ēǂݍ��݌n�C�x���g�̊��荞�݂�h�~
			proxy:SetEventFlag( 4047, true );
			--�C�x���g�����ɂ����[�h�҂��ł��鎖��ʒm
			proxy:SetLoadWait();
			
		proxy:NotNetMessage_end();
		
		--�V�X�e�����b�Z�[�W		
		proxy:SetTextEffect( TEXT_TYPE_TargetClear );
		
		proxy:NotNetMessage_begin();
			proxy:OnTextEffectEnd(4059, TEXT_TYPE_TargetClear, "TextEffectEnd_PK_Success");
		proxy:NotNetMessage_end();
		
		--proxy:SetTextEffect( TEXT_TYPE_Revival );
		--proxy:LuaCallStartPlus( 4056, 1, 210 );--AddQWC�z�M(�}���`�Ńz�X�g���E����QWC���Z)
		return;
	end
	
	--���̍ēǂݍ��݌n�C�x���g�̊��荞�݂�h�~
	proxy:SetEventFlag(4047, true);
	--�C�x���g�����ɂ����[�h�҂��ł��鎖��ʒm
	proxy:SetLoadWait();
	
	print("HostDead begin");
	
	
	
	--�ڕW���s
	MissionFailed(proxy,param);
	
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2(4000,"HostDead_1",5.0,0,0,once);
		proxy:OnKeyTime2(4000,"EventMenuBrake",5.0,1,1,once);
	proxy:NotNetMessage_end();
	
	--�C�x���g�I��
	proxy:SetEventFlag(4000,true);
	
	
	print("HostDead end");
end

function HostDead_1(proxy, param)
	print("HostDead_1 begin");
	
	--�C�x���g�t���O���[���o�b�N
	proxy:SetFlagInitState(2);
	
	--�����O�̈ʒu�ݒ�
	proxy:SetSummonedPos();	
	
	--���݂̃}�b�v�Ɠ���ID�����}�b�vID�Ƃ��Đݒ�
	proxy:SetDefaultMapUid(-1);	
	
	--���[�v���s��
	proxy:WarpNextStageKick();
	
	--�O���C�S�[�X�g��
	--proxy:SetChrTypeDataGrey();
	proxy:SetChrTypeDataGreyNext();
	
	print("HostDead_1 end");
end



--[[
--��4000_2���g�D���[�f�X�p���S��
function TrueDeath(proxy,param)
	print("TrueDeath begin");
	
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 4000, "TrueDeath_1", 5.0, 0, 3, once );
	proxy:NotNetMessage_end();
	
	--�V�X�e�����b�Z�[�W	
	proxy:SetEventFlag( 4000, true );
end

function TrueDeath_1(proxy,param)
	print("TrueDeath_1 begin");
	
	--�g�D���[�f�X�y�i���e�B
	proxy:TrueDeathPenalty();
	
	--�v���C���[����
	proxy:RevivePlayer();
	
	--���[�v��w��
	proxy:SetMapUid( 1, 0, 0, 0, -1 );	
	
	--0.2�b��ATrueDeath_2�����s
	proxy:OnKeyTime2(4000,"TrueDeath_2",0.2,0,0,once);
	
	proxy:LuaCallStartPlus( 4056, 1, 110 );--AddQWC�z�M
	
	print("TrueDeath_1 end");
end


function TrueDeath_2(proxy,param)
	print("TrueDeath_2 begin");
	
	--���[�v���s��
	proxy:WarpNextStageKick();
	
	print("TrueDeath_2 end");
end
]]



--��4000_3���p�[�e�B�[���U�p��
function OnEvent_4000_3(proxy,param)

	print("�}���`���U");
	proxy:ReturnMapSelect();
end




--��4000_4���\���ʏ펀�S��
function SoloPlayDeath(proxy,param)
	print("SoloPlayDeath SetRestart");
	
	if proxy:IsCompleteEvent( 4047 ) == true then
		return;
	end
	
	--���̍ēǂݍ��݌n�C�x���g�̊��荞�݂�h�~
	proxy:SetEventFlag(4047, true);
	
	
	--�ڕW���s
	MissionDeadFailed(proxy,param);
	
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 4000, "SoloPlayDeath_1", 3, 0, 3, once );
	proxy:NotNetMessage_end();
	
	--PK�ɂ�鎀�S�ł͂Ȃ����A�z�X�g���S�̃��b�Z�[�W��z�M
	if proxy:IsCompleteEvent( 4030 ) == false then
		proxy:LuaCallStartPlus( 4042, 3, proxy:GetLocalPlayerId() );
	end
	
	print("SoloPlayDeath end");
end

function SoloPlayDeath_1(proxy,param)
	print("SoloPlayDeath_1 begin");
	
	proxy:NotNetMessage_begin();
		--proxy:OnBloodMenuClose(4000,"SoloPlayDeath_2",300.0, once);
		SoloPlayDeath_2(proxy,param);
	proxy:NotNetMessage_end();
	
	print("SoloPlayDeath_1 end");
end


function SoloPlayDeath_2(proxy,param)
	print("SoloPlayDeath_2 begin");

	--�t���O�̏������X�L�b�v
	proxy:SetFlagInitState(1);
	
	--�G���A�����ʒu�̃}�b�vID�Z�b�g
	--proxy:SetAreaStartMapUid(-1);
	proxy:SetDefaultMapUid( 999 - proxy:GetLastBlockId() );
	
	--���[�v���s��
	proxy:WarpNextStageKick();
	
	--�����A�j���Đ�
	proxy:PlayAnimation( 10000, 6100 );
	
	--���S�C�x���g��t�\
	proxy:SetEventFlag(4000,false);
	
	--�p�j�f�[�����p
	proxy:LuaCallStart( 4000, 100 );
	
	--�O���C�S�[�X�g��
	--proxy:SetChrTypeDataGrey();
	if proxy:IsCompleteEvent(4067) == false then
		proxy:SetChrTypeDataGreyNext();
	end
	
	--�������X�V
	proxy:UpDateBloodMark();
	if proxy:IsLivePlayer() == true then
		--���S��QWC�ϓ����폜
		proxy:LuaCallStartPlus( 4056, 1, 100 );--AddQWC�z�M�i�S�[�X�g������QWC���Z�j
	end
	print("SoloPlayDeath_2 end");
end




--��4000_5���z���C�g�u���b�N�S�[�X�g���̎��S�p��
function PartyGhostDeath(proxy,param)
	print("PartyGhostDeath begin");
	
	if proxy:IsCompleteEvent( 4047 ) == true then
		return;
	end
	--���̍ēǂݍ��݌n�C�x���g�̊��荞�݂�h�~
	proxy:SetEventFlag(4047, true);
	--���̍ēǂݍ��݌n�C�x���g�̊��荞�݂�h�~
	proxy:SetEventFlag(4047, true);
	
	--�����̃v���C���[ID��z�M���ăQ�[���I�ɔ����鎖��ʒm
	proxy:CustomLuaCallStart( 4063 , proxy:GetLocalPlayerId() );
	
	--�C�x���g�t���O���[���o�b�N
	proxy:SetFlagInitState(2);
	
	proxy:NotNetMessage_begin();
		proxy:OnTextEffectEnd( 4059, TEXT_TYPE_GhostDead, "PartyGhostDeath_1");
	proxy:NotNetMessage_end();
	
	
	--proxy:NotNetMessage_begin();
	--	proxy:OnKeyTime2( 4000, "PartyGhostDeath_1", 5.0, 0, 3, once );
	--proxy:NotNetMessage_end();
	
	--PK�ɂ�鎀�S�ł͂Ȃ����A���S�̃��b�Z�[�W��z�M
	if proxy:IsCompleteEvent( 4030 ) == false then
		if proxy:IsWhiteGhost() == true then
			proxy:LuaCallStartPlus( 4042, 1, proxy:GetLocalPlayerId() );
		else
			proxy:LuaCallStartPlus( 4042, 2, proxy:GetLocalPlayerId() );
			if	proxy:GetTempSummonParam() > 0 then
				proxy:LuaCallStartPlus( 4042, 5, proxy:GetLocalPlayerId() );
			end
		end
	else
		--PK�Ŏ��񂾏ꍇ���A�����������ꂽ�u���b�N�̏ꍇ�͋����������S�Ƃ��ăJ�E���g
		if	proxy:GetTempSummonParam() > 0 then
			proxy:LuaCallStartPlus( 4042, 2, proxy:GetLocalPlayerId() );
			proxy:LuaCallStartPlus( 4042, 5, proxy:GetLocalPlayerId() );			
		--�z���C�g�\�E��
		elseif	proxy:GetTempSummonParam() == -1 then
			proxy:LuaCallStartPlus( 4042, 1, proxy:GetLocalPlayerId() );
			proxy:LuaCallStartPlus( 4042, 4, proxy:GetLocalPlayerId() );			
		--�u���b�N�\�E��
		elseif	proxy:GetTempSummonParam() == -2 then
			proxy:LuaCallStartPlus( 4042, 2, proxy:GetLocalPlayerId() );
			proxy:LuaCallStartPlus( 4042, 4, proxy:GetLocalPlayerId() );			
		--����
		elseif	proxy:GetTempSummonParam() == -3 then
			proxy:LuaCallStartPlus( 4042, 6, proxy:GetLocalPlayerId() );
			proxy:LuaCallStartPlus( 4042, 4, proxy:GetLocalPlayerId() );			
		end
	end
	
	
	proxy:SetEventFlag(4000,true);
	
	print("PartyGhostDeath end");
end

function PartyGhostDeath_1(proxy,param)
	print("PartyGhostDeath_1 begin");
	
	if ClearBoss == false then
		--target failure
		MissionDeadFailed(proxy,param);	
		proxy:NotNetMessage_begin();
			proxy:OnRequestMenuEnd(4000, "PartyGhostDeath_2");
		proxy:NotNetMessage_end();
	else
		--proxy:NotNetMessage_begin();
		--	proxy:OnKeyTime2( 4050 ,"BlockClear2_3" , 5.0 , 0 , 100 , once );
		--proxy:NotNetMessage_end();
	end
	
	print("PartyGhostDeath_1 end");
end



function PartyGhostDeath_2(proxy,param)
	print("PartyGhostDeath_2 begin");
	
	if ClearBoss == false then
		if proxy:IsCompleteEvent( 4030 ) == false then
			print("�f�X�y�i���e�B�I�I");
			--�\�E���y�i���e�B
			--proxy:DeathPenalty( DeathPenalty_SoulAdjust, DeathPenalty_SoulMAX );
				
			if	proxy:IsBlackGhost() == true then				
				--�������҂Ȃ�
				if	proxy:GetTempSummonParam() > 0 then					
					--�������҈ȊO�̃u���b�N�Ȃ�
				else
					--�y�i���e�B
					proxy:SetLeaveSoulSteel();
					print("�f�X�y�i���e�B�I�I");
				end
			end
		end
		--�����O�̈ʒu�ݒ�
		proxy:SetSummonedPos();
		--���݂̃}�b�v�Ɠ���ID�����}�b�vID�Ƃ��Đݒ�
		proxy:SetDefaultMapUid(-1);
		--���[�v���s��
		proxy:WarpNextStageKick();
		--���S�񕜗v��
		--proxy:RequestFullRecover();
		--�O���C�S�[�X�g��
		--proxy:SetChrTypeDataGrey();
		proxy:SetChrTypeDataGreyNext();
	else
		--proxy:NotNetMessage_begin();
		--	proxy:OnKeyTime2( 4050 ,"BlockClear2_3" , 2.0 , 0 , 100 , once );
		--proxy:NotNetMessage_end();
	end
		
	print("PartyGhostDeath_2 end");
end


--��4042�����S�ʒm��
function DeadInfoMsg_White(proxy,param)
	print("DeadInfoMsg_White begin");
	--�����ȊO�̎�
	if param:IsNetMessage() == true then
		--�z�X�g
		if	proxy:IsGreyGhost() == true or proxy:IsLivePlayer() == true then
			if proxy:EventTagInsertString_forPlayerNo( TAG_IDX_deadChara, param:GetParam3() ) == true then
				proxy:RecallMenuEvent( 0, 8980 );
			end
		--��O��
		else
			if proxy:EventTagInsertString_forPlayerNo( TAG_IDX_deadChara, param:GetParam3() ) == true then
				--�z���C�g�\�E��
				if	proxy:GetTempSummonParam() == -1 then
					proxy:RecallMenuEvent( 0, 8983 );
				--�u���b�N�\�E��
				elseif	proxy:GetTempSummonParam() == -2 then
					proxy:RecallMenuEvent( 0, 8984 );
				--����
				elseif	proxy:GetTempSummonParam() == -3 then
					proxy:RecallMenuEvent( 0, 8985 );
				--��������
				elseif	proxy:GetTempSummonParam() >   0 then
					proxy:RecallMenuEvent( 0, 8986 );
				end
			else
				proxy:WARN("PCName�̃^�O�����ւ����s");
			end
		end		
	--���񂾂̂�����
	else		
	end
	print("DeadInfoMsg_White end");
end

function DeadInfoMsg_Black(proxy,param)
	print("DeadInfoMsg_Black begin");
	--�����ȊO�̎�
	if param:IsNetMessage() == true then
		--�z�X�g
		if	proxy:IsGreyGhost() == true or proxy:IsLivePlayer() == true then
			if proxy:EventTagInsertString_forPlayerNo( TAG_IDX_deadChara, param:GetParam3() ) == true then
				proxy:RecallMenuEvent( 0, 8991 );
			end
		--��O��
		else
			if proxy:EventTagInsertString_forPlayerNo( TAG_IDX_deadChara, param:GetParam3() ) == true then
				--�z���C�g�\�E��
				if	proxy:GetTempSummonParam() == -1 then
					proxy:RecallMenuEvent( 0, 8993 );
				--�u���b�N�\�E��
				elseif	proxy:GetTempSummonParam() == -2 then
					proxy:RecallMenuEvent( 0, 8994 );
				--����
				elseif	proxy:GetTempSummonParam() == -3 then
					proxy:RecallMenuEvent( 0, 8995 );
				--��������
				elseif	proxy:GetTempSummonParam() >   0 then
					proxy:RecallMenuEvent( 0, 8996 );
				end
			else
				proxy:WARN("PCName�̃^�O�����ւ����s");
			end
		end		
	--���񂾂̂�����
	else
		--�u���b�N�\�E��
		if	proxy:GetTempSummonParam() == -2 then
			--proxy:RecallMenuEvent( 0, 9004 );
		--����
		elseif	proxy:GetTempSummonParam() == -3 then
			--proxy:RecallMenuEvent( 0, 9005 );
		end		
	end
	print("DeadInfoMsg_Black end");
end

function DeadInfoMsg_Host(proxy,param)
	print("DeadInfoMsg_Host begin");
	if param:IsNetMessage() == true then		
	end
	print("DeadInfoMsg_Host end");
end

function DeadInfoMsg_ForceJoinBlack(proxy,param)
	print("DeadInfoMsg_ForceJoinBlack begin");
	--�����ȊO�̎�
	if param:IsNetMessage() == true then
		--�z�X�g
		if	proxy:IsGreyGhost() == true or proxy:IsLivePlayer() == true then
			if proxy:EventTagInsertString_forPlayerNo( TAG_IDX_deadChara, param:GetParam3() ) == true then
				proxy:RecallMenuEvent( 0, 8992 );
			end
		--��O��
		else
			if proxy:EventTagInsertString_forPlayerNo( TAG_IDX_deadChara, param:GetParam3() ) == true then
				--�z���C�g�\�E��
				if	proxy:GetTempSummonParam() == -1 then
					proxy:RecallMenuEvent( 0, 8993 );
				--�u���b�N�\�E��
				elseif	proxy:GetTempSummonParam() == -2 then
					proxy:RecallMenuEvent( 0, 8994 );
				--����
				elseif	proxy:GetTempSummonParam() == -3 then
					proxy:RecallMenuEvent( 0, 8995 );
				--��������
				elseif	proxy:GetTempSummonParam() >   0 then
					proxy:RecallMenuEvent( 0, 8996 );
				end
			else
				proxy:WARN("PCName�^�O�̍����ւ��Ɏ��s");
			end
		end		
	--���񂾂̂�����
	else
		--�u���b�N�\�E��
		if	proxy:GetTempSummonParam() == -2 then
			--proxy:RecallMenuEvent( 0, 9004 );
		--����
		elseif	proxy:GetTempSummonParam() == -3 then
			--proxy:RecallMenuEvent( 0, 9005 );
		end		
	end
	print("DeadInfoMsg_ForceJoinBlack end");
end


----------------------------------------------------------------------------------------------------------------
--��4030��PK������
----------------------------------------------------------------------------------------------------------------
--param2:�E���ꂽ�l��PlayerNo
--param3:�E�����l��PlayerNo
function PlayerKill_4030_sub( proxy,param)
	local nDeadPlayerNo = proxy:VariableExpand_22_param1( param:GetParam2() );
	local nKillPlayerNo = proxy:VariableExpand_22_param2( param:GetParam2() );
	local nDeadPlayerSummonParam = param:GetParam3();--���񂾃v���C���̏������ꂽ�^�C�v
	local nThisPlayerNo = proxy:GetLocalPlayerId();
	local nThisSummonParam = proxy:GetTempSummonParam();
	if	nThisPlayerNo == nKillPlayerNo then
		--�E�����l�����߂čĔz�M(�E�����l�̏����^�C�v���擾�����)
		local nOrderParam = proxy:VariableOrder_22( nDeadPlayerSummonParam, nThisSummonParam );
		proxy:CustomLuaCallStartPlus( 4030, param:GetParam2(), nOrderParam );
		--proxy:SetEventFlag( 4030, true );
	end
end

function PlayerKill_4030(proxy, param)
	print("PlayerKill_4030 begin");
	local nDeadPlayerNo			 = proxy:VariableExpand_22_param1( param:GetParam2() );
	local nKillPlayerNo 		 = proxy:VariableExpand_22_param2( param:GetParam2() );
	local nDeadPlayerSummonParam = proxy:VariableExpand_22_param1( param:GetParam3() );--���񂾐l�̏����^�C�v
	local nKillPlayerSummonParam = proxy:VariableExpand_22_param2( param:GetParam3() );--�E�����l�̏����^�C�v
	local nThisPlayerNo			 = proxy:GetLocalPlayerId();
	local nHostNo				 = proxy:GetHostPlayerNo();
	
	print("nDeadPlayerNo = ",nDeadPlayerNo);
	print("nKillPlayerNo = ",nKillPlayerNo);
	print("nDeadPlayerSummonParam = ",nDeadPlayerSummonParam);
	print("nKillPlayerSummonParam = ",nKillPlayerSummonParam)
	print("nThisPlayerNo = ",nThisPlayerNo);
	print("nHostNo = ",nHostNo);
	
	local IsHostDead;
	if nHostNo == nDeadPlayerNo then
		IsHostDead = true;
	else
		IsHostDead = false;
	end
	local IsWhite		= proxy:IsWhiteGhost();
	local IsBlack		= proxy:IsBlackGhost();
	
	--�p��ŏ����Ɠǂ߂Ȃ������̂ŁA���[�}���ő�p
	print( "PlayerNo:<",nDeadPlayerNo, "> ga ","PlayerNo:<",nKillPlayerNo, "> ni korosareta" );
	print( "LocalPlayerNo:<",nThisPlayerNo, "> LocalPlayerType<",proxy:GetLocalPlayerChrType(), ">");
	print( "HostNo<",nHostNo,">IsHostDead<",IsHostDead,">IsWhite<",IsWhite,">IsBlack<",IsBlack,">")
	
	
	if proxy:IsCompleteEvent( 4047 ) == true then
		print("EventFlag4047 is true return");
		return;
	end
	
	--���񂾂̂������ł͂Ȃ���
	if nThisPlayerNo ~= nDeadPlayerNo then
		--�u���b�N���������E����
		if IsHostDead == true and nThisPlayerNo == nKillPlayerNo and IsBlack == true then
			print("�z�X�gPK�@QWC�@black > host");
			proxy:LuaCallStartPlus( 4056, 1, 210 );--AddQWC�z�M(�}���`�Ńz�X�g���E����QWC���Z)
		end
		
		--�z���C�g���������E����
		if IsHostDead == true and nThisPlayerNo == nKillPlayerNo and IsWhite == true then			
			print("�s�\�ƍ߁@white > host");
			proxy:LuaCallStartPlus( 4056, 1, 210 );--AddQWC�z�M(�}���`�Ńz�X�g���E����QWC���Z)
		end
		
		--�����ȊO���������E����
		if IsHostDead == true and nThisPlayerNo ~= nKillPlayerNo then
		end
		
		--�����ȊO�������ȊO���E����
		if IsHostDead == false and nThisPlayerNo ~= nKillPlayerNo then			
		end
		
		--�����������ȊO���E����
		if IsHostDead == false and nThisPlayerNo == nKillPlayerNo then
			print("�����������ȊO���E����");			
			print("NetChrType = ",proxy:GetNetPlayerChrType(nDeadPlayerNo) );
			--�z���C�g���E����
			if	proxy:IsWhiteGhost_NetPlayer(nDeadPlayerNo) == true then
				print("�z���C�g�E��QWC");				
				proxy:LuaCallStartPlus( 4056, 1, 220 );--AddQWC�z�M(�}���`�Ńz���C�g���E����QWC���Z)
			--�u���b�N���E����
			elseif	proxy:IsBlackGhost_NetPlayer(nDeadPlayerNo) == true then
				print("�u���b�N�E��QWC");
				--�����̂݃e�L�X�g���o��\��
				if	IsWhite == false then
					proxy:SetTextEffect( TEXT_TYPE_BlackClear );
					proxy:NotNetMessage_begin();
						proxy:OnTextEffectEndPlus(4059, TEXT_TYPE_BlackClear, nDeadPlayerSummonParam,"TextEffectEnd_BlackPK_Success");
					proxy:NotNetMessage_end();
				end
				proxy:LuaCallStartPlus( 4056, 1, 230 );--AddQWC�z�M(�}���`�Ńu���b�N���E����QWC���Z)
				proxy:AddKillBlackGhost();--�E�����u���b�N�̐������Z				
			end
			
			print("NetChrSummonParam = ",nDeadPlayerSummonParam );
			print("nDeadPlayerNo = ",nDeadPlayerNo);
			--�z���C�g�\�E��
			if		nDeadPlayerSummonParam == -1 then
				if nKillPlayerSummonParam == -3 then
					print("�����u���b�N���z���C�g�E�Q�{�[�i�X");
					proxy:SoulPenaltyPK2(nDeadPlayerNo,-0.5);
				end
			--�u���b�N�\�E��
			elseif	nDeadPlayerSummonParam == -2 then
			--����
			elseif	nDeadPlayerSummonParam == -3 then
				--if proxy:IsClient() == false then
					print("�����u���b�N�E�Q�{�[�i�X")
					--proxy:SoulPenaltyPK( -PK_Soul_Penalty_FIX, -PK_Soul_Penalty_BASE, PK_Soul_Penalty_MAX, PK_Soul_Penalty_Adjust );
					proxy:SoulPenaltyPK2(nDeadPlayerNo,-0.5);
				--end
			--��������
			elseif	nDeadPlayerSummonParam  >  0 then			
			end
		end
	--���񂾂̂������̎�
	else
		print("PlayerKill_4030 ThisDead");
		proxy:SetEventFlag( 4030, true );
		--���񂾂̂��z�X�g
		if	proxy:IsLivePlayer() == true or proxy:IsGreyGhost() == true then
			print("PlayerKill_4030 LiveDead");
			--�ʏ�u���b�N�ɎE���ꂽ
			if	nKillPlayerSummonParam ==  -2 then
				print("SoulSteel Black -> Host");
				--�\�E���X�e�B�[��
				proxy:SetEventSpecialEffectOwner_2( nKillPlayerNo + 10001, LOCAL_PLAYER, 13 );
			--�����u���b�N�ɎE���ꂽ
			elseif	nKillPlayerSummonParam ==  -3 then
				--�ʏ�̎��S�̂�
			end
		end
		
		--�z���C�g�\�E��
		if		proxy:GetTempSummonParam() == -1 then
			print("PlayerKill_4030 WhiteDead");
			--�ʏ�u���b�N�ɎE���ꂽ
			if		nKillPlayerSummonParam ==  -2 then
				print("PKPenalty");
				--PK�̃\�E���y�i���e�B
				--proxy:SoulPenaltyPK( PK_Soul_Penalty_FIX, PK_Soul_Penalty_BASE, PK_Soul_Penalty_MAX, PK_Soul_Penalty_Adjust );
				--proxy:SoulPenaltyPK2(nDeadPlayerNo,0.5);
				--�\�E���X�e�B�[��
				proxy:SetEventSpecialEffectOwner_2( nKillPlayerNo + 10001, LOCAL_PLAYER, 13 );
			--�����u���b�N�ɎE���ꂽ
			elseif	nKillPlayerSummonParam ==  -3 then
				print("PKPenalty");
				--PK�̃\�E���y�i���e�B
				--proxy:SoulPenaltyPK( PK_Soul_Penalty_FIX, PK_Soul_Penalty_BASE, PK_Soul_Penalty_MAX, PK_Soul_Penalty_Adjust );
				proxy:SoulPenaltyPK2(nDeadPlayerNo,0.5);
			end			
		--�u���b�N�\�E��
		elseif	proxy:GetTempSummonParam() == -2 then
			print("PlayerKill_4030 BlackDead");
			--����or�z���C�g�ɎE���ꂽ
			if	nKillPlayerSummonParam ==  0 or
				nKillPlayerSummonParam == -1 then
				print("SoulSteel Live or White -> Black");
				--�\�E���X�e�B�[��
				proxy:SetEventSpecialEffectOwner_2( nKillPlayerNo + 10001, LOCAL_PLAYER, 13 );
			end
		--����
		elseif	proxy:GetTempSummonParam() == -3 then
			print("PlayerKill_4030 ForceJoinDead");
			--�����ɎE���ꂽ
			if	nKillPlayerSummonParam ==  0 then
				print("PKPenalty");
				proxy:SoulPenaltyPK2(nDeadPlayerNo,0.5);
			end
			--�z���C�g�ɎE���ꂽ
			if	nKillPlayerSummonParam == -1 then
				print("PKPenalty");
				--PK�̃\�E���y�i���e�B
				--proxy:SoulPenaltyPK( PK_Soul_Penalty_FIX, PK_Soul_Penalty_BASE, PK_Soul_Penalty_MAX, PK_Soul_Penalty_Adjust );				
				proxy:SoulPenaltyPK2(nDeadPlayerNo,0.5);
			end
		end
	end
	
	print("PlayerKill_4030 end");
end

function PlayerKill_4030_1(proxy, param)
	print("PlayerKill_4030_1 begin");
	
	--�t���O�����[���o�b�N���܂��B
	proxy:SetFlagInitState(2);
	
	--��������̂Ńy�i���e�B�Ō��������p�����[�^�����ɖ߂�(�ő�l�̂�)
	proxy:EraseEventSpecialEffect( 10000, 101 );
	--proxy:PlayerParamRecover();
	
	--���O���C�Ȃ畜��
	if proxy:IsPrevGreyGhost() == true then
		--��������̂ŕ����A�j���t���O���Z�b�g
		proxy:SetAliveMotion( true );
	end
	
	--HpMpSp�����S��
	--proxy:PlayerRecover();
	
	--������Ԃɐݒ肵����ŁA�����̌������ʒu�փ��[�v
	--proxy:WarpSelfBloodMark(false);
	proxy:SetSelfBloodMapUid();
	--proxy:RevivePlayer();
	proxy:RevivePlayerNext();--���̃��[�h�őh��
	proxy:RequestFullRecover();
	proxy:WarpNextStageKick();
	
	print("PlayerKill_4030_1 end");
end

----------------------------------------------------------------------------------------------------------------
--��4059���e�L�X�g���o�I����
----------------------------------------------------------------------------------------------------------------
--�i�u���b�N���������E�����jPK�ɐ����������̃e�L�X�g���o�I����
--���Ҏ҂�|�����e�L�X�g���o�\����
function TextEffectEnd_PK_Success(proxy,param)
	print("TextEffectEnd_PK_Success begin");
	proxy:NotNetMessage_begin();
		proxy:OnRequestMenuEnd( 4059, "RequestMenuEnd_PK_Sucess" );
	proxy:NotNetMessage_end();
	
--[[
	--�u���b�N�\�E��
	if	proxy:GetTempSummonParam()		== -2 then
		proxy:RecallMenuEvent( 0, 8914 );
	--����
	elseif	proxy:GetTempSummonParam()	== -3 then
		proxy:RecallMenuEvent( 0, 8915 );
	end
]]

	--���������u���b�N���ڕW�B���������̓^�[�o���������A��
	--local tmpSummonParam = proxy:GetTempSummonParam();
	--print("���҃p�����[�^:",tmpSummonParam);
	--if	proxy:GetTempSummonParam() > 0 then
	if IsForceSummon == true then
		print("�^�[�o���C�x���g����");
		proxy:GetRateItem(16581);
	end
	
	--�ڕW�B��
	MissionSuccessed(proxy,param);

	print("TextEffectEnd_PK_Success end");
end

--�i�u���b�N���������E�����jPK�ɐ����������̗v�����j���[�I����
function RequestMenuEnd_PK_Sucess(proxy,param)
	print("RequestMenuEnd_PK_Sucess begin");
	
	--PK�����C�x���g�J�n
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 4030, "PlayerKill_4030_1", 2.0, 0, 3, once );
	proxy:NotNetMessage_end();
	
	print("RequestMenuEnd_PK_Sucess end");
end

--(Survival/White killed Black) At the end of the text effect when the PK was successful
--After displaying the black kill text effect
function TextEffectEnd_BlackPK_Success(proxy,param)
	print("TextEffectEnd_BlackPK_Success begin");
	local nDeadPlayerSummonParam = param:GetParam3();
	print("TextEffectEnd_BlackPK_Success nDeadPlayerSummonParam = ", nDeadPlayerSummonParam);
--[[
	if		nDeadPlayerSummonParam == -2 then
		proxy:RecallMenuEvent( 0, 8971 );
	elseif	nDeadPlayerSummonParam == -3 then
		proxy:RecallMenuEvent( 0, 8972 );
	end
]]
	print("TextEffectEnd_BlackPK_Success end");
end



----------------------------------------------------------------------------------------------------------------
--�� 4032 �� Resurrection of own blood letter ��
----------------------------------------------------------------------------------------------------------------
function SelfBloodMark(proxy, param)
	print("SelfBloodMark begin");
	
	--�����̌����������́u�ēǂݍ��݂�ʂ��Ȃ��v�̂ŏ������X�L�b�v�̂�
	--proxy:SetFlagInitState(1);
	
	--�V�X�e�����b�Z�[�W	
	proxy:SetTextEffect(TEXT_TYPE_SoulGet);		
	
	--��������̂Ńy�i���e�B�Ō��������p�����[�^�����ɖ߂�(�ő�l�̂�)
	--proxy:EraseEventSpecialEffect( 10000, 101 );
	--proxy:PlayerParamRecover();
	--proxy:ResetEventQwcSpEffect(LOCAL_PLAYER);	
	--�L�����N�^�̃^�C�v�𐶑��ɕύX(�ēǂݍ��݂�ʂ��Ȃ��ׁA����ŉ��Ή�)���K�̓v���C���[��p�̐����^�C�v�ݒ胁�\�b�h�őΉ�
	--proxy:SetChrType( 10000, 0 );

	--�����̌�������\��
	proxy:InvalidMyBloodMarkInfo();
	
	--�p�j�f�[�������A�p�C�x���g�n���h��
	proxy:LuaCallStart( 4032, 100 );
	
	print("SelfBloodMark end");
end


----------------------------------------------------------------------------------------------------------------
---4033��Session expired��
----------------------------------------------------------------------------------------------------------------
function OnIrregularLeaveSession(proxy,param)
	print("OnIrregularLeaveSession begin");

	proxy:NotNetMessage_begin();
		--��4033��0.1�b��(�Z�b�V�����؂�^�C�~���O��������)
		proxy:OnKeyTime2( 4033, "OnIrregularLeaveSession_1", 0.1, 0, 1, once );
		--���̍ēǂݍ��݌n�C�x���g�̊��荞�݂�h�~
	proxy:NotNetMessage_end();
	
	print("OnIrregularLeaveSession end");
end

function OnIrregularLeaveSession_1(proxy,param)
	print("OnIrregularLeaveSession_1 begin");
	--�N���C�A���g�Ŗ����Ȃ�@�V���O���@or�@�z�X�g
	--if	proxy:IsClient() == false then
	--���̎��_�ł͂��Ȃ炸IsClient��false���A��I
	if proxy:IsLivePlayer() == true or proxy:IsGreyGhost() == true then
		return;
	end
	if proxy:IsCompleteEvent( 4047 ) == true then
		print("EventFlag4047 is true return");
		return;
	end
	--���̍ēǂݍ��݌n�C�x���g�̊��荞�݂�h�~
	proxy:SetEventFlag(4047, true);
	--�C�x���g�����ɂ����[�h�҂��ł��鎖��ʒm
	proxy:SetLoadWait();
	--���[�����Ȃ��Ȃ������O
	proxy:InfomationMenu( INFOMENU_TYPE_LIST, -1, 0, -1, 1 );
	proxy:AddInfomationTosBuffer( 20001001 );
	
	--�C�x���g�t���O���[���o�b�N
	proxy:SetFlagInitState(2);
	
	proxy:NotNetMessage_begin();
		--��4046��5�b��
		proxy:OnKeyTime2( 4046, "OnLeave_Limit", 5.0, 0, 2, once );
	proxy:NotNetMessage_end();
	print("OnIrregularLeaveSession_1 end");
end


----------------------------------------------------------------------------------------------------------------
--�� Warp to 4036 �� SOS position �� For white summon position
----------------------------------------------------------------------------------------------------------------
function WarpSosPos(proxy,param)
	print("WarpSosPos begin");
	print("WarpSosPos end");
end

----------------------------------------------------------------------------------------------------------------
--��4037���~�j�u���b�N�̓��Ƀ��[�v���u���b�N�����ʒu�p
----------------------------------------------------------------------------------------------------------------
function WarpMiniblockPos(proxy,param)
	print("WarpMiniblockPos begin");
	--���������̏ꍇ�A�z�X�g�̃v���C�̈�ɍ��킹��
	if	proxy:IsForceSummoned() == true then
		--proxy:SetHostMiniBlockIndex();
	end
	--proxy:WarpMiniBlock();
	print("WarpMiniblockPos end");
end


function OnServerError_Maintenance(proxy,param)
	print("OnServerError_Maintenance begin");
	if proxy:IsCompleteEvent( 4047 ) == true then
		return;
	end	
	proxy:InfomationMenu(INFOMENU_TYPE_LIST,-1,0,-1,1);
	proxy:AddInfomationTosBufferPlus(51200,MSG_CATEGORY_DIALOG);
	--�^�C�g���ɖ߂鏈��
	proxy:WARN("�f�����Y�T�[�o�����e�i���X��");
	RegistReturnTitle(proxy,param);
	print("OnServerError_Maintenance end");
end

function OnServerError_ServiceStop(proxy,param)
	print("OnServerError_ServiceStop begin");
	if proxy:IsCompleteEvent( 4047 ) == true then
		return;
	end
	proxy:InfomationMenu(INFOMENU_TYPE_LIST,-1,0,-1,1);
	proxy:AddInfomationTosBufferPlus(51201,MSG_CATEGORY_DIALOG);
	--�^�C�g���ɖ߂鏈��
	proxy:WARN("�f�����Y�T�[�o�̃T�[�r�X���ԊO");
	RegistReturnTitle(proxy,param);
	print("OnServerError_ServiceStop end");
end

function OnServerError_TimeOut(proxy,param)
	print("OnServerError_TimeOut begin");
	if proxy:IsCompleteEvent( 4047 ) == true then
		return;
	end
	proxy:InfomationMenu(INFOMENU_TYPE_LIST,-1,0,-1,1);
	proxy:AddInfomationTosBufferPlus(51300,MSG_CATEGORY_DIALOG);
	--�^�C�g���ɖ߂鏈��
	proxy:WARN("�T�[�o����̉���������");
	RegistReturnTitle(proxy,param);
	print("OnServerError_TimeOut end");
end

function OnSummonResult_Empty(proxy,param)
	print("OnResultEmpty begin");
	proxy:InfomationMenu(INFOMENU_TYPE_LIST,-1,0,-1,1);
	proxy:AddInfomationTosBuffer(20000105);
	print("OnResultEmpty end");
end

function OnSummonResult_Move(proxy,param)
	print("OnSummonResult_Move begin");
	proxy:InfomationMenu(INFOMENU_TYPE_LIST,-1,0,-1,1);
	proxy:AddInfomationTosBuffer(20000110);
	print("OnSummonResult_Move end");
end

function OnSummonResult_TimeOut(proxy,param)
	print("OnSummonResult_TimeOut begin");
	proxy:InfomationMenu(INFOMENU_TYPE_LIST,-1,0,-1,1);
	proxy:AddInfomationTosBuffer(20000100);
	print("OnSummonResult_TimeOut end");
end

function OnSummonResult_OtherError(proxy,param)
	--no handling
end

----------------------------------------------------------------------------------------------------------------
--�� 4038 �� Session information monitoring ��
----------------------------------------------------------------------------------------------------------------
function OnEvent_4038(proxy,param)
	print("OnEvent_4038 begin");
	local info = param:GetParam2();
	
	--SummonResult�֘A
--~ 	if info == 1 then--���ɏ�������Ă���
--~ 		proxy:InfomationMenu(INFOMENU_TYPE_LIST,-1,0,-1,1);
--~ 		proxy:AddInfomationTosBuffer(20000105);
--~ 	elseif info == 2 then--�ʃu���b�N�Ɉړ����Ă���
--~ 		proxy:InfomationMenu(INFOMENU_TYPE_LIST,-1,0,-1,1);
--~ 		proxy:AddInfomationTosBuffer(20000110);
--~ 	elseif info == 3 then--�^�C���A�E�g���Ă���
--~ 		proxy:InfomationMenu(INFOMENU_TYPE_LIST,-1,0,-1,1);
--~ 		proxy:AddInfomationTosBuffer(20000100);
--~ 	--elseif info == 4 then--���̑��Ŏ��s	
--~ 	end
	
	--NetworkError�֘A
--~ 	if info == 11 then--�f�����Y�T�[�o�����e�i���X��
--~ 		if proxy:IsCompleteEvent( 4047 ) == true then
--~ 			return;
--~ 		end	
--~ 		proxy:InfomationMenu(INFOMENU_TYPE_LIST,-1,0,-1,1);
--~ 		proxy:AddInfomationTosBufferPlus(51200,MSG_CATEGORY_DIALOG);
--~ 		--�^�C�g���ɖ߂鏈��
--~ 		proxy:WARN("�f�����Y�T�[�o�����e�i���X��");
--~ 		RegistReturnTitle(proxy,param);
--~ 	elseif info == 12 then--�f�����Y�T�[�o�̃T�[�r�X���ԊO
--~ 		if proxy:IsCompleteEvent( 4047 ) == true then
--~ 			return;
--~ 		end
--~ 		proxy:InfomationMenu(INFOMENU_TYPE_LIST,-1,0,-1,1);
--~ 		proxy:AddInfomationTosBufferPlus(51201,MSG_CATEGORY_DIALOG);
--~ 		--�^�C�g���ɖ߂鏈��
--~ 		proxy:WARN("�f�����Y�T�[�o�̃T�[�r�X���ԊO");
--~ 		RegistReturnTitle(proxy,param);
--~ 	elseif info == 13 then--�T�[�o����̉����������i���񐔈ȏ�A���Ń^�C���A�E�g�����j
--~ 		if proxy:IsCompleteEvent( 4047 ) == true then
--~ 			return;
--~ 		end
--~ 		proxy:InfomationMenu(INFOMENU_TYPE_LIST,-1,0,-1,1);
--~ 		proxy:AddInfomationTosBufferPlus(51300,MSG_CATEGORY_DIALOG);
--~ 		--�^�C�g���ɖ߂鏈��
--~ 		proxy:WARN("�T�[�o����̉���������");
--~ 		RegistReturnTitle(proxy,param);
--~ 	end
	
	--ForceSummonResult�֘A
	if	info == 20 then--����
		ForceSummonSuccess(proxy,param);
	elseif	info == 21 then--no SOS
		ForceSummonFail(proxy,param);
	elseif	info == 22 then--Move to another block
		ForceSummonFail(proxy,param);
	elseif	info == 23 then--time out
		ForceSummonFail(proxy,param);
	elseif	info == 24 then--failed in other
		ForceSummonFail(proxy,param);
	end
	
	print("OnEvent_4038 end");
end


--Forced summoning failed
function ForceSummonFail(proxy,param)
	print("ForceSummonFail begin");
	if	proxy:IsClient() == false then
		OnEvent_1090(proxy,param);
	end
	
	proxy:DeleteEvent( 1090 );
	proxy:SetEventFlag( 1090, true );
	
	print("ForceSummonFail end");
end

--Compulsory summoning succeeded
function ForceSummonSuccess(proxy,param)
	print("ForceSummonSuccess begin");
	print("ForceSummonSuccess end");
end

----------------------------------------------------------------------------------------------------------------
--��4050��Block Clear 2��Regular Version
----------------------------------------------------------------------------------------------------------------
function BlockClear2(proxy,param)	
	--Only Me
	if param:IsNetMessage() == true then
		return;
	end
	--Clear does not come to forced summons
	if	proxy:GetTempSummonParam() >   0 then
		return;
	end
--~ 	if proxy:IsCompleteEvent( 4047 ) == true then
--~ 		return;
--~ 	end
--~ 	if proxy:IsCompleteEvent( 4000 ) == true then
--~ 		return;		
--~ 	end
	print("BlockClear2 begin");	
	ClearBossId = -900;
	
	--Survival or Gray Invincible if neither is applicable
	--if proxy:IsLivePlayer() == false and proxy:IsGreyGhost() == false then
		--���S���G�ݒ�(�z�M�K�v���낤���H)
		--proxy:EnableInvincible( 10000,true);
	--end
	
	--Call handler for white resuscitation count, QWC addition (for host)
	if	proxy:IsWhiteGhost() == true then
		proxy:LuaCallStart( 4055, 1 );
	end
	
	--Clear SOS sign once
	--proxy:ClearSosSign();
	
	--Remember number of sessions
	--proxy:SetClearSesiionCount();
	
	--Clear Boss Gauge
	proxy:ClearBossGauge();	

	--Network Lock
	--proxy:LockSession();
	
	--Calculate Clear Bonus
	proxy:SetClearBonus(ClearBossId);
	
	--At the time of survival
	if proxy:IsLivePlayer() == true then		
		proxy:SetTextEffect(TEXT_TYPE_KillDemon);		
		--Prevents interrupts of other reload events
		proxy:SetEventFlag(4047, true);		
		--Prevent deaths from getting stuck and complicated
		proxy:SetEventFlag( 4000, true );
	--Gray Time
	elseif proxy:IsGreyGhost() == true then		
		proxy:SetTextEffect(TEXT_TYPE_KillDemon);
		proxy:SetTextEffect(TEXT_TYPE_Revival);
		proxy:SetReviveWait( true );--Put a waiting state flag (in case it is removed in gray)
		--Prevents interrupts of other reload events
		proxy:SetEventFlag(4047, true);		
		--Prevent deaths from getting stuck and complicated
		proxy:SetEventFlag( 4000, true );
		--When you die here in Grey, you can come back to life
		proxy:SetEventFlag( 4067, true );
	--White Ghost Time
	--This may be what dictates if you can summon after boss
	elseif proxy:IsWhiteGhost() == true then
		ClearBoss = true;
		proxy:SetTextEffect(TEXT_TYPE_KillDemon);		
		--Prevents interrupts of other reload events
		proxy:SetEventFlag(4047, true);
		--Notify the event that it is waiting to be loaded
		proxy:SetLoadWait();		
		--Prevent deaths from getting stuck and complicated
		proxy:SetEventFlag( 4000, true );
	--�u���b�N�S�[�X�g��
	elseif proxy:IsBlackGhost() == true then
		--Stream your Player ID to notify you that you will leave the game
		proxy:CustomLuaCallStart( 4063 , proxy:GetLocalPlayerId() );
		--Goal failure
		MissionFailed(proxy,param);		
		--Prevents interrupts of other reload events
		proxy:SetEventFlag(4047, true);
		--Notify the event that it is waiting to be loaded
		proxy:SetLoadWait();		
		--Prevent deaths from getting stuck and complicated
		proxy:SetEventFlag( 4000, true );
		--Black is included in the evaluation, so get out first
		proxy:LeaveSession();
	end

	--�Z���N�g���j���[�}���J�n
	if proxy:IsInParty_FriendMember() == true then
		proxy:SetSubMenuBrake( true );		
	end
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 4050, "BlockClear2_1", 5.0, 0, 2, once );
	proxy:NotNetMessage_end();
	
	--Self-World Animation Processing	
	if proxy:IsWhiteGhost() == true or proxy:IsBlackGhost() == true then
		proxy:RepeatMessage_begin();
			proxy:NotNetMessage_begin();
				--Self-character monitoring for anime playback
				proxy:OnRegistFunc( 4050 , "Check_BlockClearAnim","BlockClearAnim",20,once);
			proxy:NotNetMessage_end();
		proxy:RepeatMessage_end();		
	end
	
	print("BlockClear2 end");
end
--This is the revival process--
function BlockClear2_1(proxy,param)
	print("BlockClear2_1 begin");
	
	if proxy:IsInParty_FriendMember() == true then
		--When Alive or --White Ghost or--When Grey Ghost
		if proxy:IsLivePlayer() == true or proxy:IsWhiteGhost() == true or proxy:IsGreyGhost() == true then		
			--And only when the Grey Ghost
			if proxy:IsGreyGhost() == true then
				if proxy:IsAlive(10000) == true then
					--Happy Resurrection
					proxy:RevivePlayer();
					proxy:SetReviveWait( false );--Flag pending revival
				end
				proxy:SetEventFlag( 15112,true );
				proxy:SetEventFlag( 15113,true );
				proxy:SetEventFlag( 15114,true );
				proxy:SetEventFlag( 15115,true );
				
				proxy:SetEventFlag( 15116,true );
				proxy:SetEventFlag( 15117,true );
				proxy:SetEventFlag( 15118,true );
				proxy:SetEventFlag( 15119,true );	
				--Since it will be restored, the parameters reduced by the penalty will be restored (only the maximum value)
				proxy:EraseEventSpecialEffect( 10000, 101 );
			end
			--Was there a friendly ghost in the room? --White should be fine because she's there.
			--The host should be the result of examining other members, so when you are in a PT with only black, you will be ignored
			--Evaluation menu
			proxy:NotNetMessage_begin();
			proxy:RepeatMessage_begin();
				
				proxy:OnPlayerAssessMenu(4050,ClearBossId,"BlockClear2_2",once);
			proxy:RepeatMessage_end();
			proxy:NotNetMessage_end();			
		--�u���b�N�S�[�X�g��
		elseif proxy:IsBlackGhost() == true then
			--soul penalty
			proxy:DeathPenalty( DeathPenalty_SoulAdjust, DeathPenalty_SoulMAX );
			--eventflag rollback
			proxy:SetFlagInitState(2);
			--Position setting before summoning
			proxy:SetSummonedPos();			
			--Set the same ID as the current map as the next map ID
			proxy:SetDefaultMapUid(-1);
			--do warp
			proxy:WarpNextStageKick();
			--gray ghost
			--proxy:SetChrTypeDataGrey();
			proxy:SetChrTypeDataGreyNext();
		end		
	else
		if proxy:IsLivePlayer() == true then
			proxy:NotNetMessage_begin();
				proxy:OnKeyTime2( 4050, "SoloBlockClear", 3.0, 0, 6, once );
			proxy:NotNetMessage_end();			
		--�O���C��
		elseif proxy:IsGreyGhost() == true then
			if proxy:IsAlive( 10000 ) == true then
				--�߂ł�������
				proxy:RevivePlayer();
				proxy:SetReviveWait( false );--�����҂���ԃt���O�����낵�Ă���
			end
			proxy:SetEventFlag( 15112,true );
			proxy:SetEventFlag( 15113,true );
			proxy:SetEventFlag( 15114,true );
			proxy:SetEventFlag( 15115,true );
			
			proxy:SetEventFlag( 15116,true );
			proxy:SetEventFlag( 15117,true );
			proxy:SetEventFlag( 15118,true );
			proxy:SetEventFlag( 15119,true );
			
			--��������̂Ńy�i���e�B�Ō��������p�����[�^�����ɖ߂�(�ő�l�̂�)
			proxy:EraseEventSpecialEffect( 10000, 101 );
			proxy:NotNetMessage_begin();
				proxy:OnKeyTime2( 4050, "SoloBlockClear", 6.0, 0, 6, once );
			proxy:NotNetMessage_end();					
		--�z���C�g�S�[�X�g��
		elseif proxy:IsWhiteGhost() == true then
			--�U�{�[�i�X�̎擾
			proxy:GetClearBonus(ClearBossId);
			--���E�ɋA��
			proxy:NotNetMessage_begin();		
				proxy:OnKeyTime2(4050,"BlockClear2_3",CLEAR_TIMEOUT,0,0,once);
			proxy:NotNetMessage_end();
		--�u���b�N�S�[�X�g��
		elseif proxy:IsBlackGhost() == true then
			--�\�E���y�i���e�B
			proxy:DeathPenalty( DeathPenalty_SoulAdjust, DeathPenalty_SoulMAX );			
			--�C�x���g�t���O���[���o�b�N
			proxy:SetFlagInitState(2);			
			--�����O�̈ʒu�ݒ�
			proxy:SetSummonedPos();			
			--���݂̃}�b�v�Ɠ���ID�����}�b�vID�Ƃ��Đݒ�
			proxy:SetDefaultMapUid(-1);			
			--���[�v���s��
			proxy:WarpNextStageKick();			
			--�O���C�S�[�X�g��
			--proxy:SetChrTypeDataGrey();
			proxy:SetChrTypeDataGreyNext();
		end
	end
	print("BlockClear2_1 end");
end

--�v���C���[�]�����j���[�I���̃E�F�C�g
function BlockClear2_2(proxy,param)
	print("BlockClear2_2 begin");
	if proxy:IsWhiteGhost() == true then
		--�����̃v���C���[ID��z�M���ăQ�[���I�ɔ����鎖��ʒm
		proxy:CustomLuaCallStart( 4063 , proxy:GetLocalPlayerId() );
	end
		
	--���S���G��r��
	--proxy:EnableInvincible(10000,false);
	proxy:NotNetMessage_begin();		
		proxy:OnKeyTime2(4050,"BlockClear2_3",CLEAR_TIMEOUT,0,0,once);
		proxy:OnKeyTime2(4050,"BlockClear2_3Leave",2.0,0,3,once);
	proxy:NotNetMessage_end();
	
	MissionSuccessed(proxy,param);
	print("BlockClear2_2 end");
end

--Dissolution processing
function BlockClear2_3Leave(proxy,param)
	print("BlockClear2_3Leave begin");
		proxy:LeaveSession();		
	print("BlockClear2_3Leave end");
end

--The process of returning to one's own world
function BlockClear2_3(proxy,param)
	--���j���[�}������
	proxy:SetSubMenuBrake( false );
	
	--������
	if proxy:IsLivePlayer() == true or proxy:IsGreyGhost() == true then	
		--Start interrupting other reload events
		proxy:SetEventFlag(4047, false);		
		--���S�\
		proxy:SetEventFlag( 4000, false );
		if proxy:IsAlive(10000) == true then
			proxy:SetEventFlag( 4067, false );
		end
	end
	
	if proxy:IsWhiteGhost() == true then	
		--��������̂ŕ����A�j���t���O���Z�b�g
		proxy:SetAliveMotion( true );
	
		--�C�x���g�t���O���[���o�b�N
		proxy:SetFlagInitState(2);	
		
		--��������̂Ńy�i���e�B�Ō��������p�����[�^�����ɖ߂�(�ő�l�̂�)
		proxy:EraseEventSpecialEffect( 10000, 101 );
		
		--���S�񕜗v��
		proxy:RequestFullRecover();
		
		--������Ԃɐݒ肵����ŁA�����̌������ʒu�փ��[�v
		--proxy:WarpSelfBloodMark(false);
		proxy:SetSelfBloodMapUid();
		--proxy:RevivePlayer();
		proxy:RevivePlayerNext();--���̃��[�h�őh��
		proxy:WarpNextStageKick();
	end
	
end

function SoloBlockClear(proxy,param)
	print("SoloBlockClear begin");
	--������]�����j���[���o���O�Ƀ��[����̂������p
	proxy:SetSubMenuBrake( false );
	proxy:GetSoloClearBonus(ClearBossId);
		
	--���̍ēǂݍ��݌n�C�x���g�̊��荞�݂��J�n
	proxy:SetEventFlag(4047, false);		
	--���S�\
	proxy:SetEventFlag( 4000, false );	
	if proxy:IsAlive(10000) == true then
		proxy:SetEventFlag( 4067, false );
	end
	--�O�̈׃��[�����
	proxy:LeaveSession();
	print("SoloBlockClear end");
end


--��4050���A�j���Đ��҂���
function Check_BlockClearAnim(proxy,param)
	--�C�x���g�A�j���Đ������H
	if proxy:IsEventAnim(10000,8289) == false then
		--���L�����̃A�j���Đ��ɒ���
		proxy:PlayAnimation(10000,8289);
		return false;
	else
		--�C�x���g�A�j���Đ����Ȃ̂ŁA�����Ƃ���
		return true;
	end
end

--�� 4050 �� Block clear animation ��
function BlockClearAnim(proxy,param)
	print("BlockClearAnim begin");
	--�����E�A�j���̓���
	proxy:LuaCallStart(4050,20);
	--proxy:StopPlayer();
	print("BlockClearAnim end");
end

--��4050���u���b�N�N���A�����A�j����
function BlockClearSynchroAnime(proxy,param)
	print("BlockClearSynchroAnime begin");
	if param:IsNetMessage() == true then
		proxy:PlayAnimation(param:GetPlayID()+10001 , 8289);--�A�j���Đ�
		proxy:EnableLogic(param:GetPlayID()+10001,false);--����s�\
		return;
	end
	
	--[[--�����E�A�j���Đ������͓���Ȃ̂ŁA���L�����̍Đ����͕ۗ��Ƃ���]]
	--���L�����̓A�j���Ď���ǉ�����
	proxy:NotNetMessage_begin();
	proxy:RepeatMessage_begin();
		proxy:OnChrAnimEnd( 4050 , 10000 , 8289 , "BlockClearAnim_1",once);
	proxy:RepeatMessage_end();
	proxy:NotNetMessage_end();
	print("BlockClearSynchroAnime end");
end

--��4050���A�j���Ď���
function BlockClearAnim_1(proxy,param)
	print("BlockClearAnim_1 begin");
	--�������̓���
	proxy:LuaCallStart(4050,30);
	print("BlockClearAnim_1 end");
end

--��4050��������������
function BlockClearSynchroInvalid(proxy,param)
	print("BlockClearSynchroInvalid begin");
	if param:IsNetMessage() == true then
		--�l�b�g���[�NID�Ŗ�����
		InvalidCharactor( proxy , param:GetPlayID() + 10001 );
		return;
	else
		--���L����������
		--InvalidCharactor( proxy , 10000 );
		--�\��OFF
		proxy:SetDrawEnable( 10000 , false );
	end
	
	print("BlockClearSynchroInvalid end");
end







--��4001���A�N�V�������f��
function OnEvent_4001(proxy, param)
	if param:IsNetMessage() == true then
		return;
	end
	--print("OnEvent_4001 begin");
	--�A�N�V�����𒆒f����i�������j
	proxy:ActionEnd(10000);
	--print("OnEvent_4001 end");
end


--��4002��������q���@����́�
function OnEvent_4002(proxy, param)
	if param:IsNetMessage() == true then
		return;
	end
	--print("OnEvent_4002 begin");

	if proxy:IsAction(10000,0) == false then
	--�C�x���g�R�}���hID(2)"�n�V�S������"�𑗂�
		proxy:SetEventCommand(10000,2);

	else
	--�C�x���g�R�}���hID(2)"�n�V�S����I����"�𑗂�
		proxy:SetEventCommand(10000,4);

	end
--print("OnEvent_4002 end");
end

--��4003��������q���@�����́�
function OnEvent_4003(proxy, param)
	if param:IsNetMessage() == true then
		return;
	end
	--print("OnEvent_4003 begin");

	if proxy:IsAction(10000,1) == false then
	--�C�x���g�R�}���hID(2)"�n�V�S�~�肽"�𑗂�
		proxy:SetEventCommand(10000,3);

	else

	--�C�x���g�R�}���hID(2)"�n�V�S�~��I����"�𑗂�
		proxy:SetEventCommand(10000,5);
	end
	--print("OnEvent_4003 end");
end

--��4006���n�V�S�� �A�N�V�����{�^�����́�
function OnEvent_4006(proxy,param)
	print("OnEvent_4006 begin");
	print("OnEvent_4006 end");
end


--��4004��������q�@1�i�㏸�I����
function OnEvent_4004(proxy, param)
	if param:IsNetMessage() == true then
		return;
	end
	print("OnEvent_4004 begin");
	--�A�N�V�����J�E���g�����Z�A�s���񐔃I�[�o�[����"�n�V�S����I����"�𑗂�
	proxy:AddActionCount(10000,4);
	--	proxy:CamReset(10000,1);
	print("OnEvent_4004 end");
end

--��4005��������q�@1�i���~�I����
function OnEvent_4005(proxy, param)
	if param:IsNetMessage() == true then
		return;
	end
	print("OnEvent_4005 begin");
	--�A�N�V�����J�E���g�����Z�A�s���񐔂������������"�n�V�S����I����"�𑗂�
	proxy:SubActionCount(10000,5);
	--	proxy:CamReset(10000,1);
	print("OnEvent_4005 end");
end

--��ID�s�⁡���j���[�̕\����}������Fsec�֐��Ő��䂳��遡
function EventMenuBrake(proxy, param)
	if param:IsNetMessage() == true then
		return;
	end
	--���j���[�����
	--print("Call EventMenuClose");
	proxy:CloseMenu();
	--���j���[�}�����Ă�
	--print("Call EventMenuBrake");
	proxy:SetMenuBrake();
end

--��ID�s�⁡���j���[�����I����
function EventMenuClose(proxy, param)
	if param:IsNetMessage() == true then
		return;
	end
	--print("Call EventMenuClose");
	--���j���[�����
	proxy:CloseMenu();
end

--��ID�s�⁡�n�V�S�~��p�b�ԃC�x���g������3�b�ĂԂ���
function LadderDown(proxy,param)
	--print("Event_LadderDown begin");
	proxy:CloseMenu();
	proxy:SetMenuBrake();
	--proxy:CamReset(10000,1);
	--print("Event_LadderDown end");
end


--���ėp��b�p����ID���ėp��b��o�^����L�q�ʂ����炷(���ǃn���h�����͑�����)
function OnTalk(proxy,EventID,TargetID,Dist,Ang,ValueBuffer,HelpID,func1,func2,func3,bOnce)

	--��EventID��NPC�ėp��b��--PC���C�x���gID����Dist�̋����ɓ����Ă��鎞	
	proxy:OnTalkEventDistIn(EventID,TargetID,func2,Dist,bOnce );
	
	--��EventID��NPC�ėp��b��--PC���C�x���gID����Dist�̋����ɓ�������o���Ƃ�	
	proxy:OnTalkEventDistOut(EventID,TargetID,func3,Dist,bOnce );
	
	--��EventID��NPC�ėp��b��--PC���C�x���gID����Dist�ɓ����Ĕ����p�x�ȓ��ŃA�N�V�����{�^������������	
	proxy:OnTalkEvent(EventID,TargetID,func1, Dist, HelpID, Ang ,ValueBuffer,bOnce );
end

function OnUpDate(proxy,nEventID,nEventID2,nRegionID,func,func1)
	proxy:OnRegionIn(nEventID,10000,nRegionID,func,everytime);
	proxy:OnRegionJustOut(nEventID2,10000,nRegionID,func1,everytime);
end


function SetDisable(proxy,nChrID,bFlag)
	proxy:ChrDisableUpDate(nChrID,bFlag);	
end


--��Lua��`�֐����������ꂽ�A�j���[�V�����Đ���
--�l��ʂɒ�`�������Ȃ������̂ŁA
--true : �p�[�e�B�[�̃v���C���[���A�j���[�V��������
--false: �������A�j���[�V�������� �ƒ�`�B
function Luafunc_PlaySynchroAnimation(proxy,param,nAnimeID)
	print("Luafunc_PlaySynchroAnimation begin");
	
	--�p�[�e�B�[�̃v���C���[���A�j���[�V����
	if param:IsNetMessage() == true then 
		proxy:PlayAnimation( param:GetPlayID()+10001 , nAnimeID );
		print("Luafunc_PlaySynchroAnimation return true");
		return true;
	end
	--�������A�j���[�V����
	proxy:PlayAnimation( 10000 , nAnimeID );
	print("Luafunc_PlaySynchroAnimation return false");
	return false;
end


--��4010���A�j���[�V�����̓����p�֐�(�󎀑̗p)��
function OnEvent_4010(proxy , param )
	print("OnEvent_4010 begin");
	
	--�v���C���[�̓����A�j���[�V����(true:�p�[�e�B�[�v���C���[���A�j���[�V��������)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_PICK ) == true then
		print("return true ");
		print("OnEvent_4010 end");
		return true;
	end
	
	print("return false ");
	print("OnEvent_4010 end");
	return false;
end


--��4012���A�j���[�V�����̓����p�֐���
function OnEvent_4012(proxy , param )
	print("OnEvent_4012 begin");
	
	--�v���C���[�̓����A�j���[�V����(true:�p�[�e�B�[�v���C���[���A�j���[�V��������)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_WALK ) == true then
		return;
	end
	
	print("OnEvent_4012 end" );
end

--��4013���A�j���[�V�����̓����p�֐���
function OnEvent_4013(proxy,param)
	print("OnEvent_4013 begin");
	--�v���C���[�̓����A�j���[�V����(true:�p�[�e�B�[�v���C���[���A�j���[�V��������)
	if Luafunc_PlaySynchroAnimation( proxy, param, param:GetParam3() ) == true then
		print("return true ");
		print("OnEvent_4013 end");
		return true;
	end
	
	print("return false ");
	print("OnEvent_4013 end");
	return false;
end

--��4013�������A�j���Đ���
--(���ӁF������g�p����ƁA1�̃A�j���Đ��Ƀp�P�b�g1���̕��S�ɂȂ�̂ŁA
--�Z���Ԃŉ��x���Ă΂��悤�ȏꏊ�ł͎g�p���T����)
--����Ȃ�̉񐔌Ă΂�邱�Ƃ�z�肵�ă��O�͂����Ă���
function SynchroAnim_4013(proxy,param)
	print("SynchroAnim_4013 begin");
	local targetId = param:GetParam2();
	local animId   = param:GetParam3();
	print("Target :",targetId," animId :",animId);
	--�v���C���Ȃ�
	if	targetId >= LOCAL_PLAYER then
		Luafunc_PlaySynchroAnimation( proxy, param, animId );
	else
		proxy:PlayAnimation( targetId, animId );
	end
	--print("SynchroAnim_4013 end");
end


--[[
--------------------------------------------------------------------------------------
--�ǂ͂���C�x���g��
--------------------------------------------------------------------------------------

--��4020���ǒ���t���@�E���́�
function OnEvent_4020(proxy, param)
	if param:IsNetMessage() == true then
		return;
	end
	print("OnEvent_4020 begin");

	if proxy:IsAction(10000,0) == false then
	--�C�x���g�R�}���hID(22)"�E��1���i��"�𑗂�
		proxy:SetEventCommand(10000,22);

	else
	--�C�x���g�R�}���hID(24)"�E�ɓn��I����"�𑗂�
		proxy:SetEventCommand(10000,24);

	end
print("OnEvent_4020 end");
end

--��4021���ǒ���t�� �����́�
function OnEvent_4021(proxy, param)
	if param:IsNetMessage() == true then
		return;
	end
	print("OnEvent_4021 begin");

	if proxy:IsAction(10000,1) == false then
	--�C�x���g�R�}���hID(23)"���ɐi��"�𑗂�
		proxy:SetEventCommand(10000,23);

	else

	--�C�x���g�R�}���hID(25)"���ɓn��I����"�𑗂�
		proxy:SetEventCommand(10000,25);
	end
	print("OnEvent_4021 end");
end

--��4022���ǒ���t���@�E����ړ��I����
function OnEvent_4022(proxy, param)
	if param:IsNetMessage() == true then
		return;
	end
	print("OnEvent_4022 begin");
	--�A�N�V�����J�E���g�����Z�A�s���񐔃I�[�o�[����"�E�ɓn��I����"�𑗂�
	proxy:AddActionCount(10000,24);	
	print("OnEvent_4022 end");
end

--��4023���ǒ���t���@������ړ��I����
function OnEvent_4023(proxy, param)
	if param:IsNetMessage() == true then
		return;
	end
	print("OnEvent_4023 begin");
	--�A�N�V�����J�E���g�����Z�A�s���񐔂������������"���ɓn��I����"�𑗂�
	proxy:SubActionCount(10000,25);	
	print("OnEvent_4023 end");
end
]]


--------------------------------------------------------------------------------------
--���p�j�f�[�����̏o������p
--------------------------------------------------------------------------------------

--���p�j�f�[������\��
function LuaFunc_VisibleTheWanderingDemon(proxy, param, demon_id_list)
	print("VisibleTheWanderingDemon begin");
	
	local demon_num = table.getn( demon_id_list );
	local i =0;
	for i=1 , demon_num , 1 do
		ValidCharactor( proxy , demon_id_list[i] );
	end

	print("VisibleTheWanderingDemon end");
end

--���p�j�f�[�������\��
function LuaFunc_InvisibleTheWanderingDemon(proxy, param, demon_id_list)
	print("InvisibleTheWanderingDemon begin");
	
	local demon_num = table.getn( demon_id_list );
	local i=0;
	for i=1 , demon_num , 1 do
		InvalidCharactor( proxy , demon_id_list[i] );
	end

	print("InvisibleTheWanderingDemon end");
end

--���p�j�f�[�����̕\�����\������p(�G���A�ǂݍ��ݎ��̏������֐��ŌĂ�)
function LuaFunc_WanderingDemonJudge( proxy , param , demon_id_list )

	if proxy:GetLocalPlayerChrType() == CHR_TYPE_GreyGhost then 
		LuaFunc_VisibleTheWanderingDemon( proxy, param, demon_id_list );
	else
		LuaFunc_InvisibleTheWanderingDemon( proxy, param, demon_id_list );
	end
	
end


--------------------------------------------------------------------------------------
--���X�[�p�[�A�[�}�[�L����/������
--------------------------------------------------------------------------------------

--���X�[�p�[�A�[�}�[�L����
function OnEvent_4015(proxy, param)
	local set_id = 10000;
	
	if param:IsNetMessage() == true then
		set_id = 10001 + param:GetPlayID();
	end
	proxy:SetSuperArmor( set_id , true );
end

--���X�[�p�[�A�[�}�[������
function OnEvent_4016(proxy, param)
	local set_id = 10000;
	
	if param:IsNetMessage() == true then
		set_id = 10001 + param:GetPlayID();
	end

	proxy:SetSuperArmor( set_id , false );
end


--------------------------------------------------------------------------------------
--�����S���G �L����/������
--------------------------------------------------------------------------------------

--�����S���G�L����
function OnEvent_4017(proxy, param)
	local set_id = 10000;
	
	if param:IsNetMessage() == true then
		set_id = 10001 + param:GetPlayID();
	end
	
	proxy:EnableInvincible( set_id , true );
end

--�����S���G������
function OnEvent_4018(proxy, param)
	local set_id = 10000;
	
	if param:IsNetMessage() == true then
		set_id = 10001 + param:GetPlayID();
	end

	proxy:EnableInvincible( set_id , false );
end

--------------------------------------------------------------------------------------
--���A�^������
--------------------------------------------------------------------------------------
function OnEvent_4019(proxy,param)
	local set_id = 10000;
	
	if param:IsNetMessage() == true then
		set_id = 10001 + param:GetPlayID();
	end
	--�}�b�v�ւ̓�����L����
	proxy:DisableMapHit( set_id , false );
	proxy:SetDisableGravity( set_id , false );
	
	--����ȂǗL��
	proxy:DisableMove( set_id , false );
end


--[[
	�C�x���g�̈�ւ̈ړ��֐��@�c��MoveRegion	
	proxy		�c�C�x���g�v���L�V
	targetid	�c�ړ����������^�[�Q�b�g
	regionid	�c�̈�ID
	ftime		�c�ړ���Ԃɂ����������ԁ@�@-1������
	frad		�c���蔼�a					��{0.0��OK
	movetype	�c���������肩				true������
]]
function MoveRegion(proxy, targetid, regionid, ftime ,frad,movetype)
	--AI�ɃC�x���g�|�C���g���L��
	proxy:SetMovePoint(targetid,regionid,frad);
	--AI�ɃC�x���g���߂𔭍s(�ړ�) 
	proxy:AddEventGoal(targetid, GOAL_COMMON_MoveToSomewhere, ftime, POINT_EVENT, AI_DIR_TYPE_CENTER, frad, TARGET_SELF, movetype,0,0,0);	
end

--[[
	�C�x���g�̈�ւ̈ړ��֐��@�c��MoveRegion	
	proxy		�c�C�x���g�v���L�V
	targetid	�c�ړ����������^�[�Q�b�g
	regionid	�c�̈�ID
	ftime		�c�ړ���Ԃɂ����������ԁ@�@-1������
	frad		�c���蔼�a					��{0.0��OK
	movetype	�c���������肩				true������
]]
function MoveRegion2(proxy, targetid, regionid, ftime ,frad,movetype)
	--AI�ɃC�x���g�|�C���g���L��
	proxy:SetMovePoint(targetid,regionid,frad);
	--AI�ɃC�x���g���߂𔭍s(�ړ�) 
	proxy:AddEventGoal(targetid, GOAL_COMMON_MoveToSomewhere, ftime, POINT_EVENT, AI_DIR_TYPE_CENTER, frad, TARGET_ENE_0, movetype,0,0,0);	
end

--[[
	�^�[�Q�b�g(�L����)�ւ̐���֐��@�c��TurnTarget	
	�g�p��̒��ӁF�C�x���g�^�[�Q�b�g�𗘗p���Ă���̂ŁA
	�@�@�@�@�@�@�@�C�x���g�^�[�Q�b�g����݂̃C�x���g�Ŏg���ꍇ�A
	�@�@�@�@�@�@�@���삪�ۏ�ł��܂���B
				�@���̏ꍇ�̓|�C���g�w���Turn�֐���V���ɂ�p�ӂ���ȂǁA
				�@�ʂ̑Ή����l���������ǂ��Ǝv���܂��B
	proxy			�c�C�x���g�v���L�V
	targetid		�c���񂳂��������������^�[�Q�b�g(�C�x���gID�w��)
	goal_target_id	�c���񂵂��������̃^�[�Q�b�g(�C�x���gID�w��)
	ftime			�c�ړ���Ԃɂ����������ԁ@�@-1������
]]
function TurnTarget(proxy, targetid, goal_target_id, ftime )
	--�����̑S�p�����[�^���m�F�ł���̂ŁA���O�Ŋm�F���������͂ǂ���
	--print("TurnTarget targetid = ", targetid, ", goal_target_id = ", goal_target_id, ", ftime = ", ftime);
	
	--�C�x���g�^�[�Q�b�g��ݒ�
	proxy:SetEventTarget( targetid, goal_target_id );
	--AI�ɃC�x���g�^�[�Q�b�g�ɐU������悤�ɃC�x���g���߂𔭍s(����)
	proxy:AddEventGoal(targetid, GOAL_COMMON_Turn, ftime, TARGET_EVENT, 0,0,0,0,0,0,0);
end

--[[
	�^�[�Q�b�g(�L����)�ւ̐���֐��@�c��TurnTarget	
	�g�p��̒��ӁF�C�x���g�^�[�Q�b�g�𗘗p���Ă���̂ŁA
	�@�@�@�@�@�@�@�C�x���g�^�[�Q�b�g����݂̃C�x���g�Ŏg���ꍇ�A
	�@�@�@�@�@�@�@���삪�ۏ�ł��܂���B
				�@���̏ꍇ�̓|�C���g�w���Turn�֐���V���ɂ�p�ӂ���ȂǁA
				�@�ʂ̑Ή����l���������ǂ��Ǝv���܂��B
	proxy			�c�C�x���g�v���L�V
	targetid		�c���񂳂��������������^�[�Q�b�g(�C�x���gID�w��)
	goal_target_id	�c���񂵂��������̃^�[�Q�b�g(�C�x���gID�w��)
	ftime			�c�ړ���Ԃɂ����������ԁ@�@-1������
]]
function TurnTarget2(proxy, targetid, goal_target_id, ftime )
	--�����̑S�p�����[�^���m�F�ł���̂ŁA���O�Ŋm�F���������͂ǂ���
	--print("TurnTarget targetid = ", targetid, ", goal_target_id = ", goal_target_id, ", ftime = ", ftime);
	
	--�C�x���g�^�[�Q�b�g��ݒ�
	proxy:SetMovePoint(targetid,goal_target_id,0.0);
	--AI�ɃC�x���g�^�[�Q�b�g�ɐU������悤�ɃC�x���g���߂𔭍s(����)
	--proxy:AddEventGoal(targetid, GOAL_COMMON_Turn, ftime, TARGET_EVENT, 0,0,0,0,0,0,0);
end

--[[
	�w��^�[�Q�b�g�̉E�蕐���؂�ւ��܂�
	���x���Ă΂Ȃ��ŉ������B�����T�c�L��p�ł������퓮�삷�邩�͂킩��Ȃ��ł��B
]]
function TargetChangeWepR2(proxy,targetid)
	proxy:AddEventGoal(targetid, GOAL_COMMON_Attack, 10.0, NPC_ATK_ChangeWep_R2,TARGET_ENE_0, DIST_None,0,0,0,0,0);
end



--�L�����N�^������
function InvalidCharactor(proxy, eventId)
	proxy:SetDisable( eventId, true );
	proxy:CharacterAllAttachSys(eventId);
end

--�L�����N�^�L����
function ValidCharactor(proxy, eventId)
	proxy:SetDisable( eventId, false );
end

--�o�b�N���[�h�L�����N�^�𖳌���
function InvalidBackRead(proxy,eventId)
	proxy:SetDisable( eventId, true );--�����ݒ�
	proxy:SetDisableBackread_forEvent( eventId, true );--�o�b�N���[�h������
end

--�o�b�N���[�h�L�����N�^��L����
function ValidBackRead(proxy,eventId)
	proxy:SetDisable( eventId, false );--�L���ݒ�
	proxy:SetDisableBackread_forEvent( eventId, false );--�o�b�N���[�h�L����
end


--[[�C���t�H���[�V�������j���[�\���p]]
--[[�����S���w��]]
--[[
	proxy 	          �c �C�x���g�v���N�V
	type  	       	  �c 0:�ʏ�(�����s) 1:�Ȉ�(1�s)
	title_icon_id  	  �c �^�C�g�����b�Z�[�W�̃A�C�R��ID
	title_category_id �c �^�C�g�����b�Z�[�W�̃J�e�S���[ID(30���C�x���g�p�J�e�S���[)
	title_msg_id      �c �^�C�g�����b�Z�[�W�̃��b�Z�[�WID
	sys_msg_id        �c 0�Ń_�C�A���O�\��
	icon_list         �c �s���ƂɃA�C�R�����w�肷��ꍇ�Ɏw��(���X�g�œn����āA�ŏ��̈���f�t�H���g�ɂȂ�)
	category_list     �c ���b�Z�[�W�̃J�e�S���[ID(���X�g�œn����āA�ŏ��̈���f�t�H���g�ɂȂ�)
	msg_list    �@�@�@�c ���b�Z�[�WID���ʂɎw��(���X�g�œn����āA�ŏ��̈���f�t�H���g�ɂȂ�)
	msg_num           �c ���b�Z�[�W�̍s��(�Ȃ��Ă��ǂ���������Ȃ����)
]]

function Display_InfomationMenu
(proxy, type, title_icon_id, title_category_id, title_msg_id, sys_msg_id, icon_list, category_list, msg_list, msg_num)
	print( "Display_InfomationMenu begin" );
	
	--�C���t�H���[�V�������j���[�\��
	proxy:InfomationMenu( type , title_icon_id , title_category_id , title_msg_id , sys_msg_id );
	
	--���b�Z�[�W�Ȃǂ̐�������Ȃ��Ƃ��̓f�t�H���g�̒l�ő�p����
	--(���X�g�ɂ͒l���P�ȏ�����Ă��邱�ƑO��ŁA�P�ԍŏ��̂��f�t�H���g�ɂ���)
	
	local default_icon_id     = icon_list[1];
	local default_category_id = category_list[1];
	local default_msg_id      = msg_list[1];
	
	if type == 0 then -- �ʏ탁�j���[
		local i=1;
		for i=1, msg_num, 1 do
		
			--�Z�b�g����l���f�t�H���g�ŏ�����
			local set_icon_id     = default_icon_id;
			local set_category_id = default_category_id;
			local set_msg_id      = default_msg_id;
			
			--�l������ꍇ������g��
			if icon_list[i]     ~= nil then set_icon_id     = icon_list[i];     end
			if category_list[i] ~= nil then set_category_id = category_list[i]; end
			if msg_list[i]      ~= nil then set_msg_id      = msg_list[i];      end
			
			--�C���t�H���[�V�������j���[�̃��X�g�ɒǉ�
			proxy:AddInfomationList( set_icon_id , set_category_id , set_msg_id );
		
		end	
	
	elseif type == 1 then -- �ȈՃ��j���[
		--�C���t�H���[�V�������j���[�̃��X�g�ɒǉ�
		proxy:AddInfomationList( default_icon_id , default_category_id , default_msg_id );
	end

	print( "Display_InfomationMenu end" );
end


--[[�C���t�H���[�V�������j���[�\���p]]
--[[���b�Z�[�WID�ЂƂ����ƘA�Ԃŏ���Ɏw��]]
--[[
	proxy 	          �c �C�x���g�v���N�V
	type  	       	  �c 0:�ʏ�(�����s) 1:�Ȉ�(1�s)
	title_icon_id  	  �c �^�C�g�����b�Z�[�W�̃A�C�R��ID
	title_category_id �c �^�C�g�����b�Z�[�W�̃J�e�S���[ID(30���C�x���g�p�J�e�S���[)
	title_msg_id      �c �^�C�g�����b�Z�[�W�̃��b�Z�[�WID
	sys_msg_id        �c 0�Ń_�C�A���O�\��
	icon_id           �c �s���ƂɃA�C�R�����w�肷��ꍇ�Ɏw��(���̊֐��ł͂��ׂē����ɂȂ�)
	category_id       �c ���b�Z�[�W�̃J�e�S���[ID
	first_msg_id      �c ���b�Z�[�WID �ŏ��̂ЂƂ��w�肷���msg_num�s�����A�ԂŒǉ������
	msg_num           �c ���b�Z�[�W�̍s��
]]
function Display_InfomationMenu_2
(proxy, type, title_icon_id, title_category_id, title_msg_id, sys_msg_id, icon_id, category_id, first_msg_id, msg_num)
	print( "Display_InfomationMenu begin" );
	proxy:ShowGenDialog(first_msg_id,1,1,true);
	--[[
	--�C���t�H���[�V�������j���[�\��
	proxy:InfomationMenu( type , title_icon_id , title_category_id , title_msg_id , sys_msg_id );
	
	if type == 0 then -- �ʏ탁�j���[

		local now_msg_id = first_msg_id;
		local i=1;
		for i=1, msg_num, 1 do
			--�C���t�H���[�V�������j���[�̃��X�g�ɒǉ�
			proxy:AddInfomationList( icon_id , category_id , now_msg_id );
			now_msg_id = now_msg_id + 1;
		end
	
	elseif type == 1 then -- �ȈՃ��j���[
		--�C���t�H���[�V�������j���[�̃��X�g�ɒǉ�
		proxy:AddInfomationList( icon_id , category_id , first_msg_id );
	end
	]]
	print( "Display_InfomationMenu end" );
end



function LengthOut_SosDialog(proxy,param)
	print("LengthOut_SosDialog begin");	
	--�C���t�H���[�V�������j���[�\��		
	print("LengthOut_SosDialog end");
end


--[[
		�ȉ��v���O��������R�[�������V�X�e�����O
]]
--------------------------------------------------------------------------------------
--��SOS���������狗��������ď������Ƃ��̃��O
--------------------------------------------------------------------------------------
function LengthOut_SosDialog(proxy,param)
	print("LengthOut_SosDialog begin");	
	--�C���t�H���[�V�������j���[�\��			
	proxy:InfomationMenu( INFOMENU_TYPE_LIST, -1, 0, -1, 1 );
	proxy:AddInfomationTosBuffer( 20000005 );
	print("LengthOut_SosDialog end");
end


--------------------------------------------------------------------------------------
--�����Ґ�����ʒm���郍�O�i�z���C�g���ҁj
--------------------------------------------------------------------------------------
function SummonSuccess_White(proxy,param)
	print("SummonSuccess_White begin");
	--�C���t�H���[�V�������j���[�\��			
	print("SummonSuccess_White end");
end

--------------------------------------------------------------------------------------
--�����Ґ�����ʒm���郍�O�i�u���b�N���ҁj
--------------------------------------------------------------------------------------
function SummonSuccess_Black(proxy,param)
	print("SummonSuccess_Black begin");
	--�C���t�H���[�V�������j���[�\��			
	print("SummonSuccess_Black end");
end

--------------------------------------------------------------------------------------
--�����҂��ꂽ����ʒm���郍�O�i�z���C�g���ҁj
--------------------------------------------------------------------------------------
function OnBeSummoned_White(proxy,param)
	print("OnBeSummoned_White begin");
	
	--�z���C�g�����ʒm
	--proxy:LuaCallStartPlus( 4041, 1, proxy:GetLocalPlayerId() );
--[[
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 4036, "WarpSosPos", 0.1, 0, 2, once );
	proxy:NotNetMessage_end();
]]
	
	print("OnBeSummoned_White end");
end


--------------------------------------------------------------------------------------
--�����҂��ꂽ����ʒm���郍�O�i�u���b�N���ҁj
--------------------------------------------------------------------------------------
function OnBeSummoned_Black(proxy,param)
	print("OnBeSummoned_Black begin");
	
	--�u���b�N�����ʒm
	--proxy:LuaCallStartPlus( 4041, 2, proxy:GetLocalPlayerId() );
--[[
	proxy:NotNetMessage_begin();
		proxy:OnKeyTime2( 4037, "WarpMiniblockPos", 0.1, 0, 2, once );
	proxy:NotNetMessage_end();
]]
	--�z�X�g�̃v���C�̈悩�烏�[�v���ݒ�
	--proxy:LuaCallStart( 4037, 2 );
	
	print("OnBeSummoned_Black end");
end

--------------------------------------------------------------------------------------
--�����҂��ꂽ����ʒm���郍�O�i�u���b�N���������j
--------------------------------------------------------------------------------------
function OnBeSummoned_ForceJoinBlack(proxy,param)
	print("OnBeSummoned_ForceJoinBlack begin");
	
	--�u���b�N�����ʒm
	--proxy:LuaCallStartPlus( 4041, 3, proxy:GetLocalPlayerId() );
	
	print("OnBeSummoned_ForceJoinBlack end");
end

--------------------------------------------------------------------------------------
--�����҂��ꂽ����ʒm���郍�O�i�u���b�N��������<���ł����g���Ă��Ȃ�>�j
--------------------------------------------------------------------------------------
function OnBeForceSummoned_Black(proxy,param)
	print("OnBeForceSummoned_Black begin");
	
	--�u���b�N���������ʒm
	--proxy:LuaCallStartPlus( 4041, 4, proxy:GetLocalPlayerId() );
	
	print("OnBeForceSummoned_Black end");
end



------------------------------------------------------------------------------------
--�ڕW�B��
------------------------------------------------------------------------------------
function MissionSuccessed(proxy,param)
	print("MissionSuccessed begin");
	--�z���C�g
	if		proxy:GetTempSummonParam() == -1 then
		proxy:RecallMenuEvent( 0, 8933 );
	--�u���b�N
	elseif	proxy:GetTempSummonParam() == -2 then
		--�ʏ�PK�̏ꍇ�����ƃO���C�̏ꍇ�Ő����������ς��
		if proxy:IsPrevGreyGhost() == true then
			proxy:RecallMenuEvent( 0, 8934 );
		else
			proxy:RecallMenuEvent( 0, 8937 );
		end
	--����
	elseif	proxy:GetTempSummonParam() == -3 then
		proxy:RecallMenuEvent( 0, 8935 );
	--��������
	elseif	proxy:GetTempSummonParam() >   0 then
		proxy:RecallMenuEvent( 0, 8936 );
	end
	print("MissionSuccessed end");
end


------------------------------------------------------------------------------------
--�ڕW���s
------------------------------------------------------------------------------------
function MissionFailed(proxy,param)
	print("MissionFailed begin");
	--�z���C�g
	if		proxy:GetTempSummonParam() == -1 then
		proxy:RecallMenuEvent( 0, 8943 );
	--�u���b�N
	elseif	proxy:GetTempSummonParam() == -2 then
		proxy:RecallMenuEvent( 0, 8944 );
	--����
	elseif	proxy:GetTempSummonParam() == -3 then
		proxy:RecallMenuEvent( 0, 8945 );
	--��������
	elseif	proxy:GetTempSummonParam() >   0 then
		proxy:RecallMenuEvent( 0, 8946 );
	end
	--���S�񕜗v��
	proxy:RequestFullRecover();
	
	print("MissionFailed end");
end


------------------------------------------------------------------------------------
--���S�ɂ��ڕW���s
------------------------------------------------------------------------------------
function MissionDeadFailed(proxy,param)
	print("MissionDeadFailed begin");
	--�z���C�g
	if		proxy:GetTempSummonParam() == -1 then
		proxy:RecallMenuEvent( 0, 8953 );
	--�u���b�N
	elseif	proxy:GetTempSummonParam() == -2 then
		proxy:RecallMenuEvent( 0, 8954 );
	--����
	elseif	proxy:GetTempSummonParam() == -3 then
		proxy:RecallMenuEvent( 0, 8955 );
	--��������
	elseif	proxy:GetTempSummonParam() >   0 then
		proxy:RecallMenuEvent( 0, 8956 );
	end
	print("MissionDeadFailed end");
end

--------------------------------------------------------------------------------------
--��SOS�T�C��������������ʒm���郍�O(�~�j�u���b�N�ړ���)
--------------------------------------------------------------------------------------
function OnEvent_Delete_SOS(proxy,param)
	print("OnEvent_Delete_SOS begin");	
	proxy:InfomationMenu( INFOMENU_TYPE_LIST, -1, 0, -1, 1 );
	proxy:AddInfomationTosBuffer( 20000000 );
	print("OnEvent_Delete_SOS end");
end
--�z���C�g�\�E���T�C��
function OnEvent_Delete_WhiteSOS(proxy,param)
	print("OnEvent_Delete_WhiteSOS begin");	
	proxy:InfomationMenu( INFOMENU_TYPE_LIST, -1, 0, -1, 1 );
	proxy:AddInfomationTosBuffer( 20000000 );
	proxy:SetInfomationPriority(USER_ID_Event_SosLost_White);
	print("OnEvent_Delete_WhiteSOS end");
end
--�u���b�N�\�E���T�C��
function OnEvent_Delete_BlackSOS(proxy,param)
	print("OnEvent_Delete_BlackSOS begin");	
	proxy:InfomationMenu( INFOMENU_TYPE_LIST, -1, 0, -1, 1 );
	proxy:AddInfomationTosBuffer( 20000001 );
	proxy:SetInfomationPriority(USER_ID_Event_SosLost_Red);
	print("OnEvent_Delete_BlackSOS end");
end
--�����\�E���T�C��
function OnEvent_Delete_ForceJoinSOS(proxy,param)
	print("OnEvent_Delete_ForceJoinSOS begin");	
	proxy:InfomationMenu( INFOMENU_TYPE_LIST, -1, 0, -1, 1 );
	proxy:AddInfomationTosBuffer( 20000002 );
	proxy:SetInfomationPriority(USER_ID_Event_SosLost_Black);
	print("OnEvent_Delete_ForceJoinSOS end");
end

--------------------------------------------------------------------------------------
--��LAN���ؒf���ꂽ����ʒm���郍�O
--------------------------------------------------------------------------------------
function OnLanCutError(proxy,param)
	print("OnLanCutError begin");
	
	if proxy:IsCompleteEvent( 4047 ) == true then
		return;
	end
	proxy:InfomationMenu( INFOMENU_TYPE_LIST, -1, 0, -1, 1 );
	proxy:AddInfomationTosBuffer( 20001005 );
	


	proxy:NotNetMessage_begin();
		--[[
		--��4046��5�b��
		proxy:OnKeyTime2( 4046, "OnLeave_Limit", 5.0, 0, 1, once );
				
		--���̍ēǂݍ��݌n�C�x���g�̊��荞�݂�h�~
		proxy:SetEventFlag(4047, true);
		--�C�x���g�����ɂ����[�h�҂��ł��鎖��ʒm
		proxy:SetLoadWait();
		]]
		RegistReturnTitle(proxy,param);
		proxy:WARN("OnLanCutError!");
	proxy:NotNetMessage_end();
	
	print("OnLanCutError end");
end


--------------------------------------------------------------------------------------
--��NP�T�[�o����̃T�C���A�E�g��ʒm���郍�O
--------------------------------------------------------------------------------------
function OnNpServerSignOut(proxy,param)
	if proxy:IsCompleteEvent( 4047 ) == true then
		return;
	end
	print("OnNpServerSignOut begin");
	proxy:InfomationMenu( INFOMENU_TYPE_LIST, -1, 0, -1, 1 );
	proxy:AddInfomationTosBuffer( 20001010 );
	
	--�^�C�g���ɖ߂�
	proxy:WARN("NpSignOut Error");
	RegistReturnTitle(proxy,param);
	print("OnNpServerSignOut end");
end

--------------------------------------------------------------------------------------
--��P2P�ڑ��̃^�C���A�E�g��ʒm���郍�O
--------------------------------------------------------------------------------------
function OnP2PTimeOut(proxy,param)
	print("OnP2PTimeOut begin");
	if proxy:IsCompleteEvent( 4047 ) == true then
		return;
	end
	proxy:InfomationMenu( INFOMENU_TYPE_LIST, -1, 0, -1, 1 );
	proxy:AddInfomationTosBuffer( 20001015 );
	if proxy:IsLivePlayer() == false and proxy:IsGreyGhost() == false then
		proxy:NotNetMessage_begin();
			--��4046��5�b��
			proxy:OnKeyTime2( 4046, "OnLeave_Limit", 5.0, 0, 1, once );
			
			--���̍ēǂݍ��݌n�C�x���g�̊��荞�݂�h�~
			proxy:SetEventFlag(4047, true);
			--�C�x���g�����ɂ����[�h�҂��ł��鎖��ʒm
			proxy:SetLoadWait();
			
		proxy:NotNetMessage_end();
	end
	print("OnP2PTimeOut end");
end


function OnFailedGetBlockNum(proxy,param)
	print("OnFailedGetBlockNum begin");
	if proxy:IsCompleteEvent( 4047 ) == true then
		return;
	end
	proxy:InfomationMenu( INFOMENU_TYPE_LIST, -1, 0, -1, 1 );
	proxy:AddInfomationTosBuffer( 20001002 );	
	--�^�C�g���ɖ߂�
	proxy:WARN("OnFailedGetBlockNum Error");
	RegistReturnTitle(proxy,param);
	print("OnFailedGetBlockNum end");
end

--------------------------------------------------------------------------------------
--��4043���Q���҂����Ȃ��Ȃ����i�ޏo�A�L�b�N�A���S�ȊO�j
--------------------------------------------------------------------------------------
function OnLeavePlayer(proxy,param)
	print("OnLeavePlayer begin");
	if proxy:IsCompleteEvent( 4047 ) == true then
		return;
	end
	
	if proxy:IsCompleteEvent( 4044 ) == true then
		proxy:SetEventFlag( 4044, false );
		return;
	end
	
	--�ޏo�A�L�b�N�A���S�ȊO�����Ȃ��̂ŁA��悸�R�����g�A�E�g
	proxy:InfomationMenu( INFOMENU_TYPE_LIST, -1, 0, -1, 1 );
	proxy:AddInfomationTimeMsgTag( 20001020, TAG_IDX_leaveChara, param:GetParam3() );
	if param:GetParam3() == proxy:GetLocalPlayerId() then
		proxy:NotNetMessage_begin();
			--��4046��5�b��
			proxy:OnKeyTime2( 4046, "OnLeave_Limit", 5.0, 0, 1, once );
			
			--���̍ēǂݍ��݌n�C�x���g�̊��荞�݂�h�~
			proxy:SetEventFlag(4047, true);
			--�C�x���g�����ɂ����[�h�҂��ł��鎖��ʒm
			proxy:SetLoadWait();
			
		proxy:NotNetMessage_end();
	end
	print("OnLeavePlayer end");
end

--------------------------------------------------------------------------------------
--���Q�[���I�ޏo�������l��ʒm����
--------------------------------------------------------------------------------------
function OnGameLeave(proxy,param)
	if param:GetParam2() ~= proxy:GetLocalPlayerId() then
		print("OnGameLeave begin");
		local leavePlayer = param:GetParam2();
		print("LeavePlayer :",leavePlayer);
		proxy:ReqularLeavePlayer( leavePlayer );
		print("OnGameLeave begin");
	end
end

--------------------------------------------------------------------------------------
--���L�b�N�A�E�g���ꂽ�̂�ʒm���郍�O
--------------------------------------------------------------------------------------
function OnBeKickOut(proxy,param)
	print("OnBeKickOut begin");
	if proxy:IsCompleteEvent( 4047 ) == true then
		return;
	end
	proxy:InfomationMenu( INFOMENU_TYPE_LIST, -1, 0, -1, 1 );
	proxy:AddInfomationTosBuffer( 20000420 );
	
	--��4046��5�b��
	proxy:OnKeyTime2( 4046, "OnLeave_Limit", 5.0, 0, 1, once );
	--���̍ēǂݍ��݌n�C�x���g�̊��荞�݂�h�~
	proxy:SetEventFlag(4047, true);
	--�C�x���g�����ɂ����[�h�҂��ł��鎖��ʒm
	proxy:SetLoadWait();
	
	print("OnBeKickOut end");
end

--------------------------------------------------------------------------------------
--�����ӃL�b�N�A�E�g���ꂽ�̂�ʒm���郍�O
--------------------------------------------------------------------------------------
function OnBeThxKickOut(proxy,param)
	print("OnBeThxKickOut begin");
	if proxy:IsCompleteEvent( 4047 ) == true then
		return;
	end
	proxy:InfomationMenu( INFOMENU_TYPE_LIST, -1, 0, -1, 1 );
	proxy:AddInfomationTosBuffer( 20000421 );
	
	--��4046��5�b��
	proxy:OnKeyTime2( 4046, "OnLeave_Limit", 5.0, 0, 1, once );
	--���̍ēǂݍ��݌n�C�x���g�̊��荞�݂�h�~
	proxy:SetEventFlag(4047, true);
	--�C�x���g�����ɂ����[�h�҂��ł��鎖��ʒm
	proxy:SetLoadWait();
	
	print("OnBeThxKickOut end");
end


--------------------------------------------------------------------------------------
--��4044���L�b�N�A�E�g�����̂�ʒm���郍�O
--------------------------------------------------------------------------------------
function OnKickOut(proxy,param)
	print("OnKickOut begin");	
	--�L�b�N�A�E�g�����̂������̎�
	if proxy:IsHost() == true then
		proxy:InfomationMenu( INFOMENU_TYPE_LIST, -1, 0, -1, 1 );	
		proxy:AddInfomationTosBuffer( 20000415 );
		proxy:SetEventFlag( 4044, true );
	--�����ȊO�̐l���L�b�N�A�E�g���ꂽ��		
	elseif proxy:GetLocalPlayerId() ~= param:GetParam3() then
		proxy:InfomationMenu( INFOMENU_TYPE_LIST, -1, 0, -1, 1 );	
		proxy:AddInfomationTimeMsgTag( 20000425, TAG_IDX_leaveChara, param:GetParam3() );
	end
	print("OnKickOut end");
end

--------------------------------------------------------------------------------------
--��4044�����ӃL�b�N�A�E�g�����̂�ʒm���郍�O
--------------------------------------------------------------------------------------
function OnThxKickOut(proxy,param)
	print("OnThxKickOut begin");	
	--�L�b�N�A�E�g�����̂������̎�
	if proxy:IsHost() == true then
		proxy:InfomationMenu( INFOMENU_TYPE_LIST, -1, 0, -1, 1 );	
		proxy:AddInfomationTosBuffer( 20000416 );
		proxy:SetEventFlag( 4044, true );
	--�����ȊO�̐l���L�b�N�A�E�g���ꂽ��
	elseif proxy:GetLocalPlayerId() ~= param:GetParam3() then
		proxy:InfomationMenu( INFOMENU_TYPE_LIST, -1, 0, -1, 1 );	
		proxy:AddInfomationTimeMsgTag( 20000425, TAG_IDX_leaveChara, param:GetParam3() );
	end
	print("OnThxKickOut end");
end


--------------------------------------------------------------------------------------
--���ޏo���@�g�p��ʒm���郍�O
--------------------------------------------------------------------------------------
function OnLeaveMagic(proxy,param)
	print("OnLeaveMagic begin");
	--���̓ǂݍ��݂̗���ɓ����Ă�����A�_�C�A���O����o���Ȃ�
	if proxy:IsCompleteEvent( 4047 ) == true then
		return;
	end
--[[
	proxy:NotNetMessage_begin();
		--��4046���ޏo�m�F���j���[��Yes��I��
		proxy:OnYesNoDialog( 4046, "OnLeaveMenu_Yes", 20000430, 0, 2, once );
	proxy:NotNetMessage_end();
]]
	--�����̃v���C���[ID��z�M���ăQ�[���I�ɔ����鎖��ʒm
	proxy:CustomLuaCallStart( 4063 , proxy:GetLocalPlayerId() );
	OnLeaveMenu_Yes(proxy,param);
	print("OnLeaveMagic end");
end

--------------------------------------------------------------------------------------
--�������A�C�e���g�p��ʒm���郍�O
--------------------------------------------------------------------------------------
function OnForceJoinBlack(proxy,param)
	print("OnForceJoinBlack begin");
	--���̓ǂݍ��݂̗���ɓ����Ă�����A�_�C�A���O����o���Ȃ�
	if proxy:IsCompleteEvent( 4047 ) == true then
		return;
	end
--[[
	proxy:NotNetMessage_begin();
		--��4039�������m�F���j���[��Yes��I��
		proxy:OnYesNoDialog( 4039, "OnForceJoinBlackMenu_Yes", 20000440, 0, 2, once );
	proxy:NotNetMessage_end();
]]
	OnForceJoinBlackMenu_Yes(proxy,param);
	print("OnForceJoinBlack end");
end

--------------------------------------------------------------------------------------
--��4039�������m�F���j���[��Yes��I��
--------------------------------------------------------------------------------------
function OnForceJoinBlackMenu_Yes(proxy,param)
	print("OnForceJoinBlackMenu_Yes begin");
	
	--�������N�G�X�g���Ă��K���Q���ł���Ƃ͌���Ȃ��̂ŁA4047�͗��ĂȂ�(�኱�s��������)
	--�����Q��(����)���L�b�N
	proxy:SetForceJoinBlackRequest();
	
	print("OnForceJoinBlackMenu_Yes end");
end


--------------------------------------------------------------------------------------
--�����������Ԑ؂ꂵ���̂�ʒm
--------------------------------------------------------------------------------------
function OnFailedForceJoinBlack(proxy,param)
	print("OnFailedForceJoinBlack begin");
	proxy:RecallMenuEvent(0,8855);
	print("OnFailedForceJoinBlack end");
end


--------------------------------------------------------------------------------------
--�������𑼂�SOS�ŏ㏑�������̂�ʒm
--------------------------------------------------------------------------------------
function OnCancelForceJoinBlack(proxy,param)
	print("OnCancelForceJoinBlack begin");
	proxy:InfomationMenu( INFOMENU_TYPE_LIST, -1, 0, -1, 1 );
	proxy:AddInfomationTosBuffer( 20000002 );
	print("OnCancelForceJoinBlack end");
end

--------------------------------------------------------------------------------------
--�����[���쐬���s�����̂�ʒm
--------------------------------------------------------------------------------------
function OnFailedCreateSession(proxy,param)
	print("OnFailedCreateSession begin");
	proxy:InfomationMenu( INFOMENU_TYPE_LIST, -1, 0, -1, 1 );
	proxy:AddInfomationTosBuffer( 20001003 );
	print("OnFailedCreateSession end");
end

--------------------------------------------------------------------------------------
--�����[���Q�����s���s�����̂�ʒm
--------------------------------------------------------------------------------------
function OnFailedJoinSession(proxy,param)
	print("OnFailedJoinSession begin");
	proxy:InfomationMenu( INFOMENU_TYPE_LIST, -1, 0, -1, 1 );
	proxy:AddInfomationTosBuffer( 20001004 );
	print("OnFailedJoinSession end");
end

--------------------------------------------------------------------------------------
--�����[�h�O�ɃL�b�N�����̂�ʒm
--------------------------------------------------------------------------------------
function OnJoinClearedRoom(proxy,param)
	print("OnJoinClearedRoom begin");
	proxy:RecallMenuEvent(0,8870);
	print("OnJoinClearedRoom end");
end

--------------------------------------------------------------------------------------
--���u���b�N���L�b�N���ꂽ�̂�Event���ɒʒm
--------------------------------------------------------------------------------------
function OnBeBlackKickOut(proxy,param)
	print("OnBeBlackKickOut begin");
	
	--�z���C�g���Ă΂��̂Ő�ɂ͂����Ă���
	if proxy:IsWhiteGhost() == true then
		return;
	end
	
	--�����̃v���C���[ID��z�M���ăQ�[���I�ɔ����鎖��ʒm
	proxy:CustomLuaCallStart( 4063 , proxy:GetLocalPlayerId() );

	proxy:LeaveSession();
	
	proxy:InfomationMenu( INFOMENU_TYPE_LIST, -1, 0, -1, 1 );
	proxy:AddInfomationTosBuffer( 20000450 );
	
	proxy:NotNetMessage_begin();
		--��4046��5�b��
		proxy:OnKeyTime2( 4046, "OnLeave_Limit", 5.0, 0, 1, once );
		--���̍ēǂݍ��݌n�C�x���g�̊��荞�݂�h�~
		proxy:SetEventFlag(4047, true);
		--�C�x���g�����ɂ����[�h�҂��ł��鎖��ʒm
		proxy:SetLoadWait();
		
	proxy:NotNetMessage_end();
	
	print("OnBeBlackKickOut end");
end

--------------------------------------------------------------------------------------
--���Β��Ƀ��[�v�i��ՁF�Q�[�g�j��Event���ɒʒm
--------------------------------------------------------------------------------------
function OnGateEnchant(proxy,param)
	print("OnGateEnchant begin");
	
	--���S�񕜗v��
	proxy:RequestFullRecover();
	--�����v���L�����Z��
	proxy:ResetSummonParam();
	proxy:WarpNextStage( 1, 0, 0, 0, -1 );
	
	print("OnGateEnchant end");
end


--���[���̃^�C���A�E�g
function OnRoomTimeOut(proxy,param)
	print("OnRoomTimeOut begin");	
	print("OnRoomTimeOut end");
end

--�����̃^�C���A�E�g
function OnSummonTimeOut(proxy,param)
	print("OnSummonTimeOut begin");	
	print("OnSummonTimeOut end");
end


--��������ă��[�h���O�A�}���`�Q���J�n�@in the (�z���C�g�\�E��) 
function OnBeJoinStart_White(proxy,param)
	if proxy:IsAlive(10000) == true then
		print("OnBeJoinStart_White begin");
		proxy:RecallMenuEvent( 0, 8823 );
		proxy:NotNetMessage_begin();
		proxy:OnRequestMenuEnd( 4059, "SummonReloadStart");
		proxy:NotNetMessage_end();
		print("OnBeJoinStart_White end");
	else
		--�O�̈׃��[�u
		proxy:LeaveSession();
		proxy:ResetSummonParam();
		proxy:WARN("OnBeJoinStart_White ���Ɏ���ł�");
	end
end

--��������ă��[�h���O�A�}���`�Q���J�n�@in the (�u���b�N�\�E��) 
function OnBeJoinStart_Black(proxy,param)
	if proxy:IsAlive( 10000 ) == true then
		print("OnBeJoinStart_Black begin");
		proxy:RecallMenuEvent( 0, 8824 );
		proxy:NotNetMessage_begin();
		proxy:OnRequestMenuEnd( 4059, "SummonReloadStart");
		proxy:NotNetMessage_end();
		print("OnBeJoinStart_Black end");
	else
		--�O�̈׃��[�u
		proxy:LeaveSession();
		proxy:ResetSummonParam();
		proxy:WARN("OnBeJoinStart_Black ���Ɏ���ł�");
	end
end

--��������ă��[�h���O�A�}���`�Q���J�n�@in the (����) 
function OnBeJoinStart_ForceJoin(proxy,param)
	if proxy:IsAlive(10000) == true then	
		print("OnBeJoinStart_ForceJoin begin");
		proxy:RecallMenuEvent( 0, 8825 );
		proxy:NotNetMessage_begin();
		proxy:OnRequestMenuEnd( 4059, "SummonReloadStart");
		proxy:NotNetMessage_end();
		print("OnBeJoinStart_ForceJoin end");
	else
		--�O�̈׃��[�u
		proxy:LeaveSession();
		proxy:ResetSummonParam();
		proxy:WARN("OnBeJoinStart_ForceJoin ���Ɏ���ł�");
	end	
end

--��������ă��[�h���O�A�}���`�Q���J�n�@in the (��������) 
function OnBeJoinStart_ForceSummon(proxy,param)
	if proxy:IsAlive( 10000 ) == true then
		print("OnBeJoinStart_ForceSummon begin");
		proxy:RecallMenuEvent( 0, 8826 );
		proxy:NotNetMessage_begin();
		proxy:OnRequestMenuEnd( 4059, "ForceSummonReloadStart");
		proxy:NotNetMessage_end();
		print("OnBeJoinStart_ForceSummon end");
	else
		--�O�̈׃��[�u
		proxy:LeaveSession();
		proxy:ResetSummonParam();
		proxy:WARN("OnBeJoinStart_ForceSummon ���Ɏ���ł�");
	end
end

--�������ꂽ���Ƃɂ��ēǂݍ��݂��L�b�N
function SummonReloadStart(proxy,param)
	print("SummonReloadStart begin");
	--���[�������݂��������
	if	proxy:IsInParty() == true then
		--�����Ă�����
		if proxy:IsAlive(10000)  == true then
			proxy:SummonedMapReload();
		else
			--�O�̈׃��[�u
			proxy:LeaveSession();
			proxy:ResetSummonParam();
			proxy:WARN("SummonReloadStart ���[���L�莀��ł�");
		end
	else
		if proxy:IsAlive(10000)  == false then
			proxy:ResetSummonParam();
			proxy:WARN("SummonReloadStart ���[����������ł�");
		end
	end
	print("SummonReloadStart end");
end

--�������ꂽ���Ƃɂ��ēǂݍ��݂��L�b�N(�������җp)
function ForceSummonReloadStart(proxy,param)
	print("ForceSummonReloadStart begin");
	--���[�������݂��������
	if	proxy:IsInParty() == true then
		if proxy:IsAlive(10000) == true then
			--���S�񕜗v��
			proxy:RequestFullRecover();
			proxy:SummonedMapReload();
		else
			--�O�̈׃��[�u
			proxy:LeaveSession();
			proxy:ResetSummonParam();
			proxy:WARN("ForceSummonReloadStart ���[���L�莀��ł�");
		end
	else
		if proxy:IsAlive(10000) == false then
			proxy:ResetSummonParam();
			proxy:WARN("ForceSummonReloadStart ���[����������ł�");
		end
	end
	print("ForceSummonReloadStart end");
end


--�}���`�v���C�ɎQ���������̃��b�Z�[�W
function OnJoinMutiplay(proxy,param)
	print("OnJoinMutiplay begin");	
	print("OnJoinMutiplay end");
end

-------------------------------------------------------------------------------------
--�Z�b�V�����ɎQ���������̃��b�Z�[�W
-------------------------------------------------------------------------------------
--�z���C�g�\�E��
function JoinSession_White(proxy,param)
	print("JoinSession_White begin");
	proxy:RecallMenuEvent( 0, 8813 );
	print("JoinSession_White end");
end

--�u���b�N�\�E��
function JoinSession_Black(proxy,param)
	print("JoinSession_Black begin");
	proxy:RecallMenuEvent( 0, 8814 );
	print("JoinSession_Black end");
end

--����
function JoinSession_ForceJoin(proxy,param)
	print("JoinSession_ForceJoin begin");
	proxy:RecallMenuEvent( 0, 8815 );
	print("JoinSession_ForceJoin end");
end

--��������
function JoinSession_ForceSummon(proxy,param)
	print("JoinSession_ForceSummon begin");
	proxy:RecallMenuEvent( 0, 8816 );
	print("JoinSession_ForceSummon end");
end



function JoinSession(proxy,param)
	print("JoinSession begin");	
	--�z���C�g�\�E��
	if proxy:GetTempSummonParam() == -1 then
		proxy:RecallMenuEvent( 0, 8813 );
	--�u���b�N�\�E��
	elseif proxy:GetTempSummonParam() == -2 then
		proxy:RecallMenuEvent( 0, 8814 );
	end
	print("JoinSession end");
end

--�Z�b�V�����ɋ����Q���������̃��b�Z�[�W
function ForceJoinSession(proxy,param)
	print("ForceJoinSession begin");	
	proxy:RecallMenuEvent( 0, 8815 );
	print("ForceJoinSession end");
end

---------------------------------------------------------------------------------------------------------
--��4058���������z�M
---------------------------------------------------------------------------------------------------------
--4058�������������z�M������--
function OnEvent_Call_SOS(proxy,param)
	print("OnEvent_Call_SOS begin");
	proxy:LuaCallStartPlus(4058, 1, proxy:GetLocalPlayerId());
	print("OnEvent_Call_SOS end");
end

function OnEvent_Call_BlackSOS(proxy,param)
	print("OnEvent_Call_BlackSOS begin");
	proxy:LuaCallStartPlus(4058, 2, proxy:GetLocalPlayerId());
	print("OnEvent_Call_BlackSOS end");
end

--�z���C�g�\�E���T�C��������(SOS���j���[��OK���������^�C�~���O)
--(4058, 1, playerId)
function Call_WhiteSos(proxy,param)
	print("Call_WhiteSos begin");
	proxy:RecallMenuEvent( 0, 8810 );
	print("Call_WhiteSos end");
end

--�u���b�N�\�E���T�C��������(SOS���j���[��OK���������^�C�~���O)
--(4058, 2, playerId)
function Call_BlackSos(proxy,param)
	print("Call_BlackSos begin");
	proxy:RecallMenuEvent( 0, 8811 );
	print("Call_BlackSos end");
end
--4058�������������z�M������--





--�z���C�g�\�E���T�C�����o����
function OnEvent_SendSoulSign_White(proxy,param)
	print("OnEvent_SendSoulSign_White begin");
	print("OnEvent_SendSoulSign_White end");
end

--�u���b�N�\�E���T�C�����o����
function OnEvent_SendSoulSign_Black(proxy,param)
	print("OnEvent_SendSoulSign_Black begin");
	print("OnEvent_SendSoulSign_Black end");
end

--�����\�E���T�C�����o����
function OnEvent_SendSoulSign_ForceJoin(proxy,param)
	print("OnEvent_SendSoulSign_ForceJoin begin");
	proxy:RecallMenuEvent( 0, 8805 );
	print("OnEvent_SendSoulSign_ForceJoin end");
end

--------------------------------------------------------------------------------------
--���h����Event���ɒʒm
--------------------------------------------------------------------------------------
function OnReviveMagic(proxy,param)
	print("OnReviveMagic begin");
	if proxy:IsBlackGhost() == true then
		return;
	end
	
	--(�z�X�g�̂��߂�)�z���C�g�h���J�E���g�AQWC���Z�p�̃n���h�����Ă�
	if	proxy:IsWhiteGhost() == true then
		proxy:LuaCallStart( 4055, 1 );
	end
	
	--�����̃v���C���[ID��z�M���ăQ�[���I�ɔ����鎖��ʒm
	proxy:CustomLuaCallStart( 4063 , proxy:GetLocalPlayerId() );
	
	--�ޏo
	proxy:LeaveSession();
	
	proxy:InfomationMenu( INFOMENU_TYPE_LIST, -1, 0, -1, 1 );
	proxy:AddInfomationTosBuffer( 20000445 );
	
	proxy:NotNetMessage_begin();
		--��4046��5�b��
		proxy:OnKeyTime2( 4046, "OnReviveMagic_1", 5.0, 0, 1, once );
		--���̍ēǂݍ��݌n�C�x���g�̊��荞�݂�h�~
		proxy:SetEventFlag(4047, true);
		--�C�x���g�����ɂ����[�h�҂��ł��鎖��ʒm
		proxy:SetLoadWait();
		
	proxy:NotNetMessage_end();
	
	print("OnReviveMagic end");
end

function OnReviveMagic_1(proxy,param)
	print("OnReviveMagic_1 begin");	
	--��������̂ŕ����A�j���t���O���Z�b�g
	proxy:SetAliveMotion( true );
	--���S�񕜗v��
	proxy:RequestFullRecover();
	
	--�C�x���g�t���O���[���o�b�N
	proxy:SetFlagInitState(2);
	--��������̂Ńy�i���e�B�Ō��������p�����[�^�����ɖ߂�(�ő�l�̂�)
	proxy:EraseEventSpecialEffect( 10000, 101 );	
	
	--������Ԃɐݒ肵����ŁA�����̌������ʒu�փ��[�v	
	proxy:SetSelfBloodMapUid();
	--proxy:RevivePlayer();
	proxy:RevivePlayerNext();--���̃��[�h�őh��
	proxy:WarpNextStageKick();
	print("OnReviveMagic_1 end");	
end

--------------------------------------------------------------------------------------
--���O���C�S�[�X�g����f�����Y�\�E���ɂ�镜��
--------------------------------------------------------------------------------------
function OnDemonsSoulRevive(proxy,param)
	print("OnDemonsSoulRevive begin");
	
	--��������̂Ńy�i���e�B�Ō��������p�����[�^�����ɖ߂�(�ő�l�̂�)
	proxy:EraseEventSpecialEffect( 10000, 101 );
	
	proxy:RevivePlayer();
	proxy:SetReviveWait( false );--�����҂���ԃt���O�����낵�Ă���
	
	--�����̌�������\��
	--proxy:InvalidMyBloodMarkInfo();
	
	proxy:SetEventFlag( 15112,true );
	proxy:SetEventFlag( 15113,true );
	proxy:SetEventFlag( 15114,true );
	proxy:SetEventFlag( 15115,true );
	
	proxy:SetEventFlag( 15116,true );
	proxy:SetEventFlag( 15117,true );
	proxy:SetEventFlag( 15118,true );
	proxy:SetEventFlag( 15119,true );	
	
	--�e�L�X�g���o
	proxy:SetTextEffect(TEXT_TYPE_Revival);
	
	--�p�j�f�[�������A�p�C�x���g�n���h��
	proxy:LuaCallStart( 4032, 100 );
	
	print("OnDemonsSoulRevive end");
end


--------------------------------------------------------------------------------------
--��4046���ޏo�m�F���j���[��Yes��I��
--------------------------------------------------------------------------------------
function OnLeaveMenu_Yes(proxy,param)
	print("OnLeaveMenu_Yes begin");
	--�_�C�A���O���J����Ă���Œ��ɕʂ̗���ɓ���ꍇ������̂ŁA
	--�����ł�����x�͂���
	if proxy:IsCompleteEvent( 4047 ) == true then
		return;
	end
	
	--�C�x���g�����ɂ����[�h�҂��ł��鎖��ʒm
	proxy:SetLoadWait();
	--�ޏo���b�Z�[�W��z�M
	if	proxy:IsWhiteGhost() == true then
	proxy:LuaCallStartPlus(4046, 1, proxy:GetLocalPlayerId() );
	elseif	proxy:IsBlackGhost() == true then
		proxy:LuaCallStartPlus(4046, 2, proxy:GetLocalPlayerId() );
		--�������҂Ȃ�
		if	proxy:GetTempSummonParam() > 0 then
			proxy:LuaCallStartPlus( 4046, 3, proxy:GetLocalPlayerId() );		
		--�������҈ȊO�̃u���b�N�Ȃ�
		else
			--�E�ރy�i���e�B
			proxy:SetLeaveSoulSteel();
		end
	end

	--�Z�b�V������؂�
	proxy:LeaveSession();
	
	--�����������烍�[�h�͕K�v�Ȃ��̂ŃJ�b�g
	if	proxy:IsLivePlayer() == true then
		print("OnLeaveMenu_Yes return end");
		return;
	end
	
	--PT�ɎQ�����Ď��S�����ꍇ�A���甲�����ꍇ�̓\�E���̃y�i���e�B������܂��B
	--�\�E���y�i���e�B
	proxy:DeathPenalty( DeathPenalty_SoulAdjust, DeathPenalty_SoulMAX );
	
	--���̍ēǂݍ��݌n�C�x���g�̊��荞�݂�h�~
	proxy:SetEventFlag(4047, true);
	
	proxy:NotNetMessage_begin();
		--��4046��5�b��
		proxy:OnKeyTime2( 4046, "OnLeave_Limit", 5.0, 0, 1, once );
	proxy:NotNetMessage_end();
	print("OnLeaveMenu_Yes end");
end

function LeaveMessage(proxy,param)
	print("LeaveMessage begin");
	if proxy:GetLocalPlayerId() == param:GetParam3() then
		proxy:InfomationMenu( INFOMENU_TYPE_LIST, -1, 0, -1, 1 );
		proxy:AddInfomationTosBuffer( 20000430 );
	else
		proxy:InfomationMenu( INFOMENU_TYPE_LIST, -1, 0, -1, 1 );
		proxy:AddInfomationTimeMsgTag( 20000435, TAG_IDX_leaveChara, param:GetParam3() );
	end
	print("LeaveMessage end");
end

function OnLeave_Limit(proxy,param)
	print("OnLeave_Limit begin");
	
	--�C�x���g�t���O���[���o�b�N
	proxy:SetFlagInitState(2);
	
	--�����O�̈ʒu�ݒ�
	proxy:SetSummonedPos();
	
	--���݂̃}�b�v�Ɠ���ID�����}�b�vID�Ƃ��Đݒ�
	proxy:SetDefaultMapUid(-1);
	
	--���[�v���s��
	proxy:WarpNextStageKick();

	--�O���C�S�[�X�g��
	--proxy:SetChrTypeDataGrey();
	proxy:SetChrTypeDataGreyNext();

	print("OnLeave_Limit end");
end

--------------------------------------------------------------------------------------
--���񐳏�Ƀl�b�g���[�N���ؒf���ꂽ(�z�X�g�����Ȃ��Ȃ�����Ƃ�)�̂�ʒm���郍�O
--------------------------------------------------------------------------------------
function OnRoomDisappeared(proxy,param)
	print("OnRoomDisappeared begin");
	if proxy:IsCompleteEvent( 4047 ) == true then
		return;
	end
	proxy:InfomationMenu( INFOMENU_TYPE_LIST, -1, 0, -1, 1 );
	proxy:AddInfomationTosBuffer( 20001000 );
	if proxy:IsLivePlayer() == false and proxy:IsGreyGhost() == false then
		proxy:NotNetMessage_begin();
			--��4046��5�b��
			proxy:OnKeyTime2( 4046, "OnLeave_Limit", 5.0, 0, 1, once );
			
			--���̍ēǂݍ��݌n�C�x���g�̊��荞�݂�h�~
			proxy:SetEventFlag(4047, true);
			--�C�x���g�����ɂ����[�h�҂��ł��鎖��ʒm
			proxy:SetLoadWait();
			--�t���O�̃��[���o�b�N
			proxy:SetFlagInitState(2);
			
		proxy:NotNetMessage_end();
	end
	print("OnRoomDisappeared end");
end


--------------------------------------------------------------------------------------
--��4041�������ʒm��
--------------------------------------------------------------------------------------
--�z���C�g�\�E���T�C���p
function SummonInfoMsg_White(proxy,param)
	if param:IsNetMessage() == true then	
		--�N���C�A���g�Ŗ����Ȃ�@�V���O���@or�@�z�X�g
		if	proxy:IsClient() == false then
			if proxy:EventTagInsertString_forPlayerNo( TAG_IDX_joinChara, param:GetParam3() ) == true then
				proxy:RecallMenuEvent( 0, 8830 );			
				SummonSuccess(proxy,param:GetParam3());
			else
				proxy:WARN("�S�[�X�g���擾�ł��Ȃ�����");
			end
		else
			if proxy:EventTagInsertString_forPlayerNo( TAG_IDX_joinChara, param:GetParam3() ) == true then
				proxy:RecallMenuEvent( 0, 8843 );
			else
				proxy:WARN("�z�X�g���擾�ł��Ȃ�����");
			end
		end
	else
		if proxy:EventTagInsertString_forPlayerNo( TAG_IDX_liveChara, proxy:GetHostPlayerNo() ) == true then
			proxy:RecallMenuEvent( 0, 8833 );
		end
	end
end

--�u���b�N�\�E���T�C���p
function SummonInfoMsg_Black(proxy,param)
	if param:IsNetMessage() == true then
		--�N���C�A���g�Ŗ����Ȃ�@�V���O���@or�@�z�X�g
		if	proxy:IsClient() == false then
			if proxy:EventTagInsertString_forPlayerNo( TAG_IDX_joinChara, param:GetParam3() ) == true then
				proxy:RecallMenuEvent( 0, 8831 );			
				SummonSuccess(proxy,param:GetParam3());
			end
		else
			if proxy:EventTagInsertString_forPlayerNo( TAG_IDX_joinChara, param:GetParam3() ) == true then
				proxy:RecallMenuEvent( 0, 8844 );			
			end
		end
	else
		if proxy:EventTagInsertString_forPlayerNo( TAG_IDX_liveChara, proxy:GetHostPlayerNo() ) == true then
			proxy:RecallMenuEvent( 0, 8834 );		
		end
	end
end

--�����Q��(����)�p
function SummonInfoMsg_ForceJoinBlack(proxy,param)
	if param:IsNetMessage() == true then
		--�N���C�A���g�Ŗ����Ȃ�@�V���O���@or�@�z�X�g
		if	proxy:IsClient() == false then
			if proxy:EventTagInsertString_forPlayerNo( TAG_IDX_joinChara, param:GetParam3() ) == true then
				proxy:RecallMenuEvent( 1, 8832 );			
				SummonSuccess(proxy,param:GetParam3());
			end
		--��O��
		else
			if proxy:EventTagInsertString_forPlayerNo( TAG_IDX_joinChara, param:GetParam3() ) == true then
				proxy:RecallMenuEvent( 1, 8845 );			
			end
		end
	else
		if proxy:EventTagInsertString_forPlayerNo( TAG_IDX_liveChara, proxy:GetHostPlayerNo() ) == true then
			proxy:RecallMenuEvent( 1, 8835 );		
		end
	end
end

--���������p
function SummonInfoMsg_ForceSummonBlack(proxy,param)
	if param:IsNetMessage() == true then
		--�N���C�A���g�Ŗ����Ȃ�@�V���O���@or�@�z�X�g
		if	proxy:IsClient() == false then
			if proxy:EventTagInsertString_forPlayerNo( TAG_IDX_joinChara, param:GetParam3() ) == true then
				proxy:RecallMenuEvent( 1, 8846 );
				SummonSuccess(proxy,param:GetParam3());
			end
			
		else
			if proxy:EventTagInsertString_forPlayerNo( TAG_IDX_joinChara, param:GetParam3() ) == true then
				proxy:RecallMenuEvent( 1, 8846 );			
			end
		end
	else
		if proxy:EventTagInsertString_forPlayerNo( TAG_IDX_liveChara, proxy:GetHostPlayerNo() ) == true then
			proxy:RecallMenuEvent( 1, 8836 );		
		end
	end
end

function SummonSuccess(proxy, playerId)
	proxy:SummonSuccess(playerId);
end




--------------------------------------------------------------------------------------
--���l�b�g�v���C�������̃^�C���A�E�g(�܂萶����)
--------------------------------------------------------------------------------------
function LiveSide_SummonTimeOut(proxy,param)
	print("LiveSide_SummonTimeOut begin");
	proxy:InfomationMenu( INFOMENU_TYPE_LIST, -1, 0, -1, 1 );
	proxy:AddInfomationTosBuffer( 20000100 );
	print("LiveSide_SummonTimeOut end");
end

--------------------------------------------------------------------------------------
--��4045���{�X�����ւ̖��@�ǂ��ʉ߉\�ł���ƒʒm(�N���C�A���g�ɑ΂���)��
--------------------------------------------------------------------------------------

function PossibleInfo_GoToTheBossArea(proxy, param)
	print("PossibleInfo_GoToTheBossArea begin");
	
	--������Ԃ̐l���{�X�����O��ǂ�ʉ߂���������Ƃ��ɃR�[�������
	
	if param:IsNetMessage() == true then --�z�M�Ŏ󂯎�����l�� �N���C�A���g		
		--���������ȊO�̃S�[�X�g		
		if		proxy:GetTempSummonParam() == -1 then
			--�z���C�g�Ƀ{�X�����ʒm
			--proxy:ShowGenDialog(10010700,1,1,true);
			proxy:RecallMenuEvent( 0, 9500 );
		elseif 	proxy:GetTempSummonParam() == -2 then
			--�ʏ�u���b�N�Ɏ��s�ʒm
			--Failed_BossAreaMission(proxy,param);
		elseif 	proxy:GetTempSummonParam() == -3 then
			--�����u���b�N�Ɏ��s�ʒm
			--Failed_BossAreaMission(proxy,param);
		end
		
	else --�z�M�ȊO�ł��̃n���h�����Ă΂ꂽ�Ƃ��́A�Ă񂾖{�l�̂Ƃ�
		print("�N���C�A���g�փ{�X�����ɓ����悤�ɂȂ����ƒʒm���܂���");
	end	
	print("PossibleInfo_GoToTheBossArea end");
end

function Failed_BossArea(proxy,param)
	print("Failed_BossArea begin");
	--������Ԃ̐l���{�X�����O��ǂ𒲂ׂ��Ƃ��ɃR�[�������	
	if param:IsNetMessage() == true then --�z�M�Ŏ󂯎�����l�� �N���C�A���g
		--���������ȊO�̃S�[�X�g		
		if		proxy:GetTempSummonParam() == -1 then
			--�������Ȃ�
		elseif 	proxy:GetTempSummonParam() == -2 then
			--�ʏ�u���b�N�Ɏ��s�ʒm
			Failed_BossAreaMission(proxy,param);
		elseif 	proxy:GetTempSummonParam() == -3 then
			--�����u���b�N�Ɏ��s�ʒm
			Failed_BossAreaMission(proxy,param);
		end
		
	else --�z�M�ȊO�ł��̃n���h�����Ă΂ꂽ�Ƃ��́A�Ă񂾖{�l�̂Ƃ�
		print("�{�X�����j�~���s��ʒm���܂���");
	end	
	print("Failed_BossArea end");
end

function Failed_BossAreaMission(proxy,param)
	print("Failed_BossAreaMission begin");
	if proxy:IsCompleteEvent(4047) == false then
		--�{�X�Q�[�W���N���A
		proxy:ClearBossGauge();	
		--�����̃v���C���[ID��z�M���ăQ�[���I�ɔ����鎖��ʒm
		--proxy:CustomLuaCallStart( 4063 , proxy:GetLocalPlayerId() );
		--�ڕW���s
		MissionFailed(proxy,param);		
		--���̍ēǂݍ��݌n�C�x���g�̊��荞�݂�h�~
		proxy:SetEventFlag(4047, true);
		--�C�x���g�����ɂ����[�h�҂��ł��鎖��ʒm
		proxy:SetLoadWait();
		--���S�����܂��Ă�₱�����Ȃ�Ȃ��l�ɂ���
		proxy:SetEventFlag( 4000, true );
		--�����]���Ɋ܂܂��̂Ő�ɔ�����
		proxy:LeaveSession()
		
		proxy:NotNetMessage_begin();
			--2�b��ɂ̓��[�����甲����
			--proxy:OnKeyTime2( 4045 , "Failed_BossAreaMission_LeavePT",2.0,0,0,once);
			--5�b��ɂ͍ă��[�h
			proxy:OnKeyTime2( 4045 , "Failed_BossAreaMission_LeaveMap",5.0,0,0,once);
		proxy:NotNetMessage_end();
		--�����E�A�j������	
		if 	proxy:IsBlackGhost() == true then
			proxy:RepeatMessage_begin();
			proxy:NotNetMessage_begin();
				--�A�j���Đ��ׂ̈̎��L�����Ď�
				proxy:OnRegistFunc( 4050 , "Check_BlockClearAnim","BlockClearAnim",20,once);
			proxy:NotNetMessage_end();
			proxy:RepeatMessage_end();		
		end
	end
	print("Failed_BossAreaMission end");
end

function Failed_BossAreaMission_LeavePT(proxy,param)
	print("Failed_BossAreaMission_LeavePT begin");
	--�����]���Ɋ܂܂��̂Ő�ɔ�����
	proxy:LeaveSession();
	print("Failed_BossAreaMission_LeavePT end");
end

function Failed_BossAreaMission_LeaveMap(proxy,param)
	print("Failed_BossAreaMission_LeaveMap begin");
	--�\�E���y�i���e�B
	proxy:DeathPenalty( DeathPenalty_SoulAdjust, DeathPenalty_SoulMAX );
	--�C�x���g�t���O���[���o�b�N
	proxy:SetFlagInitState(2);
	--�����O�̈ʒu�ݒ�
	proxy:SetSummonedPos();			
	--���݂̃}�b�v�Ɠ���ID�����}�b�vID�Ƃ��Đݒ�
	proxy:SetDefaultMapUid(-1);
	--���[�v���s��
	proxy:WarpNextStageKick();
	--�O���C�S�[�X�g��
	--proxy:SetChrTypeDataGrey();
	proxy:SetChrTypeDataGreyNext();
	print("Failed_BossAreaMission_LeaveMap end");
end

--------------------------------------------------------------------------------------
--��4034��For multi-time magic wall (session connected)�� - Huh a multiplayer barreier
--------------------------------------------------------------------------------------
--function OnEvent_4034(proxy, param)
--	print("OnEvent_4034 begin");
--	
--	if proxy:IsClient() == false then
--		if proxy:GetBlockId() > 0 then
--			print("�}���`�����@��ON BlockId ",proxy:GetBlockId() );
--			local MultiWall = 1995 - proxy:GetBlockId() + 1;
--			Lua_MultiWall(proxy,MultiWall);
--			proxy:SetEventFlag( 3000 + proxy:GetBlockId() , true );
--		else
--			print("�u���b�N0�Ȃ̂Ŗ��@�Ǐ����X���[���܂�");
--		end
--	else--�N���C�A���g
--		if proxy:IsCompleteEvent( 3001 ) == true then
--			Lua_MultiWall(proxy,1995);
--		elseif proxy:IsCompleteEvent( 3002 ) == true then
--			Lua_MultiWall(proxy,1994);
--		elseif proxy:IsCompleteEvent( 3003 ) == true then
--			Lua_MultiWall(proxy,1993);
--		else
--			print("�N���C�A���g �u���b�N0����")
--		end		
--	end
--	
--	print("�|�����萔�}���`�ύX");
--	REMO_FLAG = 2;
--	
--	print("OnEvent_4034 end");
--end

--Multi-wall function
function Lua_MultiWall(proxy,id)
	print("�}���`�����@��ON");	
	local MultiSfx = id - 8;
	print("�}���`��ID: ",id);
	print("�}���`��SFX�@ID:",MultiSfx);
	proxy:SetColiEnable( id, true );
	proxy:SetDrawEnable( id, true );	
	proxy:ValidSfx( MultiSfx );
end

--------------------------------------------------------------------------------------
--��4035 �� For multi-time magic wall (cut off from when the session is connected) ��
--------------------------------------------------------------------------------------
--function OnEvent_4035(proxy, param)
--	print("OnEvent_4035 begin");
--	
--	proxy:SetEventFlag( 3001,false);
--	proxy:SetEventFlag( 3002,false);
--	proxy:SetEventFlag( 3003,false);
--	
--	if proxy:GetBlockId() > 0 then	
--		print("�}���`�����@��OFF BlockId ",proxy:GetBlockId() );
--		local MultiWall = 1995 - proxy:GetBlockId() + 1;
--		local MultiSfx = MultiWall - 8;
--		print("�}���`��ID: ",MultiWall);
--		print("�}���`��SFX�@ID:",MultiSfx);
--		proxy:SetColiEnable( MultiWall, false );
--		proxy:SetDrawEnable( MultiWall, false );
--		proxy:InvalidSfx( MultiSfx ,true);
--	else
--		print("�u���b�N0�Ȃ̂Ŗ��@�Ǐ����X���[���܂�");
--	end
--		
--	print("�|�����萔�V���O���ύX");
--	REMO_FLAG = 0;
--	
--	print("OnEvent_4035 end");
--end

function WhiteReviveCount(proxy,param)
	print("WhiteReviveCount begin");
	--If not a client Single or Host
	if	proxy:IsClient() == false then
		print("WhiteReviveCount AddQWC AddHelpWhiteCount");
		--Added white resurrection count addition processing here
		proxy:LuaCallStartPlus( 4056, 1, 200 );--AddQWC distribution (QWC addition that revived White)
		proxy:AddHelpWhiteGhost();--Add the number of whites helped
	end
	print("WhiteReviveCount end");
end

--------------------------------------------------------------------------------------
--��NPC��Ԋ֘A�i�擾�E�ݒ�j
--------------------------------------------------------------------------------------
--�n�������X�g���珉����(1���t���O�������Ă��Ȃ��ꍇ�͎w�肵�������t���O�𗧂Ă�)
function SetFirstNpcStateFlag(proxy, param, state_list, set_flag )	
	--�t���O��1�ł������Ă��邩�H
	local nowflag = GetNpcStateFlag(proxy,param,state_list);
	if nowflag ~= 0 then
		print("SetFirstNpcStateFlag Now to ", nowflag );
		return;
	end
	print("SetFirstNpcStateFlag Initialize set to ", set_flag );
	proxy:SetEventFlag( set_flag, true );
end

--�n�������X�g����Z�b�g
function SetNpcStateFlag(proxy, param, state_list, set_flag )
	print("SetNpcStateFlag begin set to ", set_flag );
	
	--���݂̂����Ă���t���O���擾
	local now_state = GetNpcStateFlag(proxy,param,state_list);
	
	--���݂̏�ԂƃZ�b�g��������Ԃ��Ⴄ��
	if now_state ~= set_flag then
		--���X�g�ɃZ�b�g�������A�N�V����ID���o�^����Ă����ꍇ�A
		--���݂̏�ԃt���O�����낵�A�V���ɏ�ԃt���O���Z�b�g����
		local flag_num = table.getn( state_list );
		for i=1, flag_num , 1 do
			if state_list[i] == set_flag then
				proxy:SetEventFlag( set_flag, true );
				proxy:SetEventFlag( now_state, false );
			end
		end
	end
end

--�n�������X�g����t���O�������Ă���A�N�V����ID���擾
function GetNpcStateFlag(proxy, param, state_list)

	--�v�f�����擾
	local flag_num = table.getn( state_list );
	
	
	for i=1, flag_num , 1 do
		if proxy:IsCompleteEvent( state_list[i] ) == true then
			return state_list[i];
		end
	end
	return 0;
end


--------------------------------------------------------------------------------------
--�������h�����q�֘A�C�x���g�ŗ��p����֐�
--------------------------------------------------------------------------------------

--����ԍŏ��ɉ���1�ɂ����Ƃ��̏�ԃZ�b�g�p(����1��Initialize�ŌĂ�)
function SetFirstRendolState( proxy , param )
	
	--�����q�̏�Ԃ����ݒ�̂Ƃ� ������Ԃ��Z�b�g
	
	if GetRendolState(proxy , param) ~= 0 then
		return false;
	end
	
	--�z�ꕺ�m�����ď�ԂɑJ�ڂ����݂�
	return ( SetRendolStateFlag( proxy, param, RENDOL_STATE_HELP_FOR_DOREI_HEISI , possible_transration_list_m02_00_00_00 ) );
	
end
	
	
--�� Get the current state of Prince Lendl
function GetRendolState( proxy , param )
	
	local state_flag_num = 0;
	state_flag_num = table.getn(possible_transration_list_m02_00_00_00);--����1�̃t���O��
	
	for i=1, state_flag_num, 1 do
		local look_state = possible_transration_list_m02_00_00_00[i];
		if proxy:IsCompleteEvent( look_state ) == true then
--			print("�����h�����q�̏�ԃt���O��["..look_state.."]�ł�");
			return look_state;
		end
	end
	
	state_flag_num = table.getn(possible_transration_list_m02_01_00_00);--����2�̃t���O��
	
	for i=1, state_flag_num, 1 do
		local look_state = possible_transration_list_m02_01_00_00[i];
		if proxy:IsCompleteEvent( look_state ) == true then
--			print("�����h�����q�̏�ԃt���O��["..look_state.."]�ł�");
			return look_state;
		end
	end
	
	state_flag_num = table.getn(possible_transration_list_m02_02_00_00);--����3�̃t���O��

	for i=1, state_flag_num, 1 do
		local look_state = possible_transration_list_m02_02_00_00[i];
		if proxy:IsCompleteEvent( look_state ) == true then
--			print("�����h�����q�̏�ԃt���O��["..look_state.."]�ł�");
			return look_state;
		end
	end
	
	state_flag_num = table.getn(possible_transration_list_m02_03_00_00);--����4�̃t���O��

	for i=1, state_flag_num, 1 do
		local look_state = possible_transration_list_m02_03_00_00[i];
		if proxy:IsCompleteEvent( look_state ) == true then
--			print("�����h�����q�̏�ԃt���O��["..look_state.."]�ł�");
			return look_state;
		end
	end
	
--	print("No set state flags found");
	return 0;
end

-----------------------------------------------------------------------------
--Determination of the number of deaths of various bosses
-----------------------------------------------------------------------------
function GetBossFlagCount( proxy , param )
	
	--Variable definition
	boss_flagCount = 0;		 	--Number of Boss Souls Obtained
	block_boss_flagCount = 0;	--Number of Block Boss Souls Obtained
	area_boss_flagCount = 0;	--Number of Area Boss Souls Obtained
	
	
	--Get the number of flags that have defeated each boss
	local boss_actionId_list = {0,--4096, 4224, 4360, 4480,	--royal castle (Bolitaria)
								0,--5123, 5251, 5380,		--Prison (Prison of Hope)
								0,--5650, 5770, 5888,		--dirtiness (Swamp of Sorrow)
								0,--4756, 4895, 4992,		--Gufort (Island of Storms)
								0,};--6174, 6272, 6400 };	--tunnel (Stonefang Tunnel
	local boss_actIdNum = table.getn(boss_actionId_list);
	for index = 1, boss_actIdNum, 1 do
		if proxy:IsCompleteEvent( boss_actionId_list[index] ) == true then
			boss_flagCount = boss_flagCount + 0;
		end
	end

	--Get the number of flags that are defeating block bosses
	local block_boss_actionId_list = {0,--4096, 4224, 4360,	--Wangseong 1.2.3 Seoul Acquisition
									  0,--5123, 5251,		--Prison 1.2 Get Seoul
									  0,--5650, 5770,		--Get 1.2 Unholy Souls
									  0,--4756, 4895,		--Old Fortress 1.2 Get Seoul
									  0,};--6174, 6272 };		--Mine 1.2 Seoul acquisition
	local block_boss_actIdNum = table.getn(block_boss_actionId_list);
	for index = 1, block_boss_actIdNum, 1 do
		if proxy:IsCompleteEvent( block_boss_actionId_list[index] ) == true then
			block_boss_flagCount = block_boss_flagCount + 0;
		end
	end
	
	--Get the number of flags that have defeated the area boss
	local area_boss_actionId_list = {0,--4480,		--Acquisition of Wangseong 4 Seoul
									 0,--5380,		--Prison 3 Soul Acquisition
									 0,--5888,		--Unclean 3 Soul Acquisition
									 0,--4992,		--Acquired 3 Seoul Fortress
									 0,};--6400 };	--Acquired Tunnel 3 Seoul
	local area_boss_actIdNum = table.getn(area_boss_actionId_list);
	for index = 1, area_boss_actIdNum, 1 do
		if proxy:IsCompleteEvent( area_boss_actionId_list[index] ) == true then
			area_boss_flagCount = area_boss_flagCount + 0;
		end
	end
	
--[[Boss Soul acquisition]]
	--�� 8067 ���{�X�\�E�����u1�v��
	if boss_flagCount == 1 then
		--�����𖞂������̂ŁA�t���O��ON
		proxy:SetEventFlag(8067, true);
	end	
	--�� 8068 ���{�X�\�E�����u2�v��
	if boss_flagCount == 2 then
		--�����𖞂������̂ŁA�t���O��ON
		proxy:SetEventFlag(8068, true);
	end
	--�� 8069 ���{�X�\�E�����u3�v��
	if boss_flagCount == 3 then
		--�����𖞂������̂ŁA�t���O��ON
		proxy:SetEventFlag(8069, true);
	end	
	--�� 8070 ���{�X�\�E�����u4�v��
	if boss_flagCount == 4 then
		--�����𖞂������̂ŁA�t���O��ON
		proxy:SetEventFlag(8070, true);
	end
	--�� 8071 ���{�X�\�E�����u5] ��
	if boss_flagCount == 5 then
		--�����𖞂������̂ŁA�t���O��ON
		proxy:SetEventFlag(8071, true);
	end	
	--�� 8072 ���{�X�\�E�����u6�v��
	if boss_flagCount == 6 then
		--�����𖞂������̂ŁA�t���O��ON
		proxy:SetEventFlag(8072, true);
	end
	--�� 8073 ���{�X�\�E�����u7�v��
	if boss_flagCount == 7 then
		--�����𖞂������̂ŁA�t���O��ON
		proxy:SetEventFlag(8073, true);
	end
	--�� 8074 ���{�X�\�E�����u8�v��
	if boss_flagCount == 8 then
		--�����𖞂������̂ŁA�t���O��ON
		proxy:SetEventFlag(8074, true);
	end
	--�� 8075 ���{�X�\�E�����u9�v��
	if boss_flagCount == 9 then
		--�����𖞂������̂ŁA�t���O��ON
		proxy:SetEventFlag(8075, true);
	end
	--�� 8076 ���{�X�\�E�����u10�v��
	if boss_flagCount == 10 then
		--�����𖞂������̂ŁA�t���O��ON
		proxy:SetEventFlag(8076, true);
	end
	--�� 8077 ���{�X�\�E�����u11] ��
	if boss_flagCount == 11 then
		--�����𖞂������̂ŁA�t���O��ON
		proxy:SetEventFlag(8077, true);
	end	
	--�� 8078 ���{�X�\�E�����u12�v��
	if boss_flagCount == 12 then
		--�����𖞂������̂ŁA�t���O��ON
		proxy:SetEventFlag(8078, true);
	end
	--�� 8079 ���{�X�\�E�����u13�v��
	if boss_flagCount == 13 then
		--�����𖞂������̂ŁA�t���O��ON
		proxy:SetEventFlag(8079, true);
	end
	--�� 8080 ���{�X�\�E�����u14�v��
	if boss_flagCount == 14 then
		--�����𖞂������̂ŁA�t���O��ON
		proxy:SetEventFlag(8080, true);
	end
	--�� 8081 ���{�X�\�E�����u15�v��
	if boss_flagCount == 15 then
		--�����𖞂������̂ŁA�t���O��ON
		proxy:SetEventFlag(8081, true);
	end	
	--�� 8082 ���{�X�\�E�����u16�v��
	if boss_flagCount == 16 then
		--�����𖞂������̂ŁA�t���O��ON
		proxy:SetEventFlag(8082, true);
	end
	
--[[�u���b�N�{�X�\�E���擾���֘A]]
	--�� 8056 ���u���b�N�{�X���j���u1�v��
	if block_boss_flagCount == 1 then
		--�����𖞂������̂ŁA�t���O��ON
		proxy:SetEventFlag(8056, true);
	end	
	--�� 8057 ���u���b�N�{�X���j���u2�v��
	if block_boss_flagCount == 2 then
		--�����𖞂������̂ŁA�t���O��ON
		proxy:SetEventFlag(8057, true);
	end
	--�� 8058 ���u���b�N�{�X���j���u3�v��
	if block_boss_flagCount == 3 then
		--�����𖞂������̂ŁA�t���O��ON
		proxy:SetEventFlag(8058, true);
	end	
	--�� 8059 ���u���b�N�{�X���j���u4�v��
	if block_boss_flagCount == 4 then
		--�����𖞂������̂ŁA�t���O��ON
		proxy:SetEventFlag(8059, true);
	end
	--�� 8060 ���u���b�N�{�X���j���u5�v��
	if block_boss_flagCount == 5 then
		--�����𖞂������̂ŁA�t���O��ON
		proxy:SetEventFlag(8060, true);
	end
	--�� 8061 ���u���b�N�{�X���j���u6�v��
	if block_boss_flagCount == 6 then
		--�����𖞂������̂ŁA�t���O��ON
		proxy:SetEventFlag(8061, true);
	end	
	--�� 8062 ���u���b�N�{�X���j���u7�v��
	if block_boss_flagCount == 7 then
		--�����𖞂������̂ŁA�t���O��ON
		proxy:SetEventFlag(8062, true);
	end	
	--�� 8063 ���u���b�N�{�X���j���u8�v��
	if block_boss_flagCount == 8 then
		--�����𖞂������̂ŁA�t���O��ON
		proxy:SetEventFlag(8063, true);
	end	
	--�� 8064 ���u���b�N�{�X���j���u9�v��
	if block_boss_flagCount == 9 then
		--�����𖞂������̂ŁA�t���O��ON
		proxy:SetEventFlag(8064, true);
	end	
	--�� 8065 ���u���b�N�{�X���j���u10�v��
	if block_boss_flagCount == 10 then
		--�����𖞂������̂ŁA�t���O��ON
		proxy:SetEventFlag(8065, true);
	end	
	--�� 8066 ���u���b�N�{�X���j���u11�v��
	if block_boss_flagCount >= 11 then
		--�����𖞂������̂ŁA�t���O��ON
		proxy:SetEventFlag(8066, true);
	end
	
--[[�G���A�{�X�\�E���擾���֘A]]
	--�� 8050 ���G���A�{�X���j���u1�v��
	if area_boss_flagCount == 1 then
		--�����𖞂������̂ŁA�t���O��ON
		proxy:SetEventFlag(8050, true);
	end	
	--�� 8051 ���G���A�{�X���j���u2�v��
	if area_boss_flagCount == 2 then
		--�����𖞂������̂ŁA�t���O��ON
		proxy:SetEventFlag(8051, true);
	end
	--�� 8052 ���G���A�{�X���j���u3�v��
	if area_boss_flagCount == 3 then
		--�����𖞂������̂ŁA�t���O��ON
		proxy:SetEventFlag(8052, true);
	end	
	--�� 8053 ���G���A�{�X���j���u4�v��
	if area_boss_flagCount == 4 then
		--�����𖞂������̂ŁA�t���O��ON
		proxy:SetEventFlag(8053, true);
	end	
	--�� 8054 ���G���A�{�X���j���u5�v��
	if area_boss_flagCount >= 5 then
		--�����𖞂������̂ŁA�t���O��ON
		proxy:SetEventFlag(8054, true);
	end
	
end

--[[�X�V���\�b�h���b�p�[��LuaFunc_NoOmission]]
--[[�L���������S�ɍX�V���Ȃ��Ȃ�܂�]]
--[[
	proxy 	        	�c �C�x���g�v���N�V	
	who					�c�N
	LuaFunc_NormalOmission�Ō��ɖ߂��̂�Y��Ȃ��ŉ������B
]]
function LuaFunc_NoOmission(proxy,who)
	proxy:ForceSetOmissionLevel(who,true,-1);
end

--[[�X�V���\�b�h���b�p�[��LuaFunc_NormalOmission]]
--[[�L������ʏ�X�V���܂�]]
--[[
	proxy 	        	�c �C�x���g�v���N�V	
	who					�c�N
]]
function LuaFunc_NormalOmission(proxy,who)
	proxy:ForceSetOmissionLevel(who,false,0);
end

--[[�X�V���\�b�h���b�p�[��LuaFunc_ForceOmission]]
--[[�L���������S�X�V���܂�]]
--[[
	proxy 	        	�c �C�x���g�v���N�V	
	who					�c�N
	LuaFunc_NormalOmission�Ō��ɖ߂��̂�Y��Ȃ��ŉ������B
]]
function LuaFunc_ForceOmission(proxy,who)
	proxy:ForceSetOmissionLevel(who,true,0);
end


--[[��i�j��SecondStageBreak]]
--[[2�i�K�j��̃��[�g�}�g���N�X�ړ��A���f�������ւ��A�����x�ݒ�A�j�Аݒ�����b�s���O]]
--[[
	proxy 	        	�c �C�x���g�v���N�V	
	who					�c�N
	model				�c�����ւ��郂�f��
]]
function SecondStageBreak(proxy,who,model)
	--�}�X�^�[�̈ʒu�A�p�x�Ƀ_�~�|���̈ʒu�A�p�x��ݒ�
	--�_�~�|�����g���̂Ń��f�������ւ��Ȃǂ̃^�C�~���O�ɒ���!!
	--�����ւ�����̃��f���Ɏw��ID�̃_�~�|���������ꍇ�ۏ�ł��܂���B)
	proxy:ObjRootMtxMove(who);
	
	--���f���������ւ���
	proxy:ChangeModel( who, model);
	
	--�����x��ݒ�i��ɂ΂炯������ׁj
	proxy:SetFirstSpeed(who);

	--�I�u�W�F�N�g��j�Ђɂ��Ă����蔻�������
	proxy:SetBrokenPiece(who);
end



--[[�{�X�����̏����𓝈ꂷ��ׁA�e�X�g���ł��B ]]
--[[����4��22���ł����A5���ɂȂ��Ă����̃R�����g���c���Ă���ꍇ�́A
�@�@�L�������킳�������Ă��������B�ɓ��L]]

--[[�{�X�����C�x���g��BossRoomIn]]
--[[�{�X�����ɓ���C�x���g���܂Ƃ߂ēo�^]]
--[[
	proxy 	        	�c�C�x���g�v���L�V	
	BossID				�c�{�X���S�̃A�N�V����ID
	FirstIn				�c�ŏ��Ƀz�X�g������ۂ̃A�N�V����ID
	SecondIn			�c2��ڈȍ~�̃{�X�����ɓ���A�N�V����ID
	RegionID			�c�A�N�V�����{�^������p�̗̈�̃C�x���gID
]]
--[[
function BossRoomIn(proxy,param)
	print("BossRoomIn begin");
	local FirstIn = param:GetParam1();
	local SecondIn = param:GetParam1() + 1;
	local BossID	= param:GetParam3();
	if proxy:IsCompleteEvent( param:GetParam3() ) == false then
		--�������A�j���Đ��p�̊J�n�n���h��(���񁨕���)
		proxy:LuaCall( FirstIn + 1, 1, "OnEvent_SynchroTurn", everytime );
		--��2��ڈȍ~�Ƀ{�X�����ɓ��邽�߂̃C�x���g�z�M�p
		proxy:LuaCall( param:GetParam1(), 5 , "OnEvent_"..FirstIn.."_GO_TO_IN" , everytime );
		--���t���O�Z�b�g(�����p)
		proxy:LuaCall( param:GetParam1(), 6 , "OnEvent_"..FirstIn.."_flag_set" , everytime );
		
		--�N�����{�X�O�����܂��ʉ߂��Ă��Ȃ�
		if proxy:IsCompleteEvent( param:GetParam1() ) == false then
		
			--(�Z�b�V��������)�{�X�O�̖��@�ǂ��ŏ��ɒʂ��̂͐����̐l����
			local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;
			
			proxy:NotNetMessage_begin();
				--��FirstIn�����ɓ��邽�߂̃C�x���g��ǉ���
				proxy:OnPlayerActionInRegionAttribute( param:GetParam1(), 2891 - param:GetParam2(), "OnEvent_"..FirstIn, HELPID_GO_TO_IN, possible_chr_type, once );
			proxy:NotNetMessage_end();
			
		else --�O���C�S�[�X�g�ł����Ƃ��悤�ɂ���Ǝv����B
		
			proxy:NotNetMessage_begin();
				--��SecondIn�����ɓ��邽�߂̃C�x���g��ǉ���--�n���h���͏�Ɠ���
				proxy:OnPlayerActionInRegion( param:GetParam1() + 1, 2891 - param:GetParam2(), "OnEvent_"..FirstIn, HELPID_GO_TO_IN, everytime );
			proxy:NotNetMessage_end();
		end
	end
	print("BossRoomIn end");
end

function BossRoomIn( proxy, BossID, FirstIn, SecondIn, RegionID )
	if proxy:IsCompleteEvent( BossID ) == false then
		--�������A�j���Đ��p�̊J�n�n���h��(���񁨕���)
		proxy:LuaCall( SecondIn, 1, "OnEvent_SynchroTurn", everytime );
		--��2��ڈȍ~�Ƀ{�X�����ɓ��邽�߂̃C�x���g�z�M�p
		proxy:LuaCall( FirstIn , 5 , "OnEvent_"..FirstIn.."_GO_TO_IN" , everytime );
		--���t���O�Z�b�g(�����p)
		proxy:LuaCall( FirstIn , 6 , "OnEvent_"..FirstIn.."_flag_set" , everytime );
		
		--�N�����{�X�O�����܂��ʉ߂��Ă��Ȃ�
		if proxy:IsCompleteEvent( FirstIn ) == false then
		
			--(�Z�b�V��������)�{�X�O�̖��@�ǂ��ŏ��ɒʂ��̂͐����̐l����
			local possible_chr_type = ATTR_HOST + ATTR_LIVE + ATTR_GREY;
			
			proxy:NotNetMessage_begin();
				--��FirstIn�����ɓ��邽�߂̃C�x���g��ǉ���
				proxy:OnPlayerActionInRegionAttribute( FirstIn, RegionID, "OnEvent_"..FirstIn, HELPID_GO_TO_IN, possible_chr_type, once );
			proxy:NotNetMessage_end();
			
		else --�O���C�S�[�X�g�ł����Ƃ��悤�ɂ���Ǝv����B
		
			proxy:NotNetMessage_begin();
				--��SecondIn�����ɓ��邽�߂̃C�x���g��ǉ���--�n���h���͏�Ɠ���
				proxy:OnPlayerActionInRegion( SecondIn, RegionID, "OnEvent_"..FirstIn, HELPID_GO_TO_IN, everytime );
			proxy:NotNetMessage_end();
		end
	end
end

function OnEvent_SynchroTurn(proxy,param)
end
]]


--[[
�V���O�����t���O���Z�b�g�֐���SingleReset
proxy	�c�C�x���g�v���L�V
flag	�c�t���O
]]
function SingleReset(proxy,flag)
	if proxy:IsClient() == false then
		proxy:SetEventFlag( flag,false);
	end
end


--[[
OnRegistFunc�̌��ʂ̕������g��Ȃ����Ɏw�肷��󃁃\�b�h
]]
function dummy(proxy,param)
end

--[[
�n����EventID���X�g�̃C�x���g��Z�߂ď����֐���DeleteConditionList
proxy		�c�C�x���g�v���L�V
acid_list	�c�A�N�V����ID���X�g�i�����o�^����ID�j
]]
function DeleteConditionList(proxy,acid_list)
	local id_num = table.getn(acid_list);
	for index = 1, id_num, 1 do
		proxy:DeleteEvent( acid_list[index] );
	end
end

function SynchroAddQWC(proxy,param)
	print("SynchroAddQWC begin");
	local qwcId = param:GetParam3();
	print("QwcAddId = ", qwcId );
	proxy:AddQWC(qwcId,param:IsNetMessage());
	print("SynchroAddQWC end");
end

--[[
�g���t�B�[�擾���b�p�[�֐���Lua_RequestUnlockTrophy
proxy		�c�C�x���g�v���L�V
TrophyId	�c�A�����b�N�v������g���t�B�[��ID
]]
function Lua_RequestUnlockTrophy(proxy,TrophyId)
	if proxy:IsClient() == false then --�V���O���@or�@�z�X�g
		if proxy:IsLivePlayer() == true or proxy:IsGreyGhost() == true then
			print("�g���t�B�[ID:(",TrophyId,")�̎擾�̌����𓾂܂���");
			--�܂��g���t�B�[(TrophyId)����ɓ���ĂȂ����
			if proxy:IsUnlockTrophy( TrophyId ) == false then	--���͖�������false��Ԃ��B
				--�g���t�B�[�̎擾
				proxy:RequestUnlockTrophy( TrophyId );
				print("�g���t�B�[ID:(",TrophyId,")����ɓ��ꂽ");
			else
				print("�g���t�B�[ID:(",TrophyId,")�͂��łɎ����Ă��܂�");
			end
		else
			print("�g���t�B�[�擾�̌����͂���܂���");
		end
	else--�L�����^�C�v����L�̂����ꂩ�ł��Ȃ��ꍇ
		print("�g���t�B�[�擾�̌����͂���܂���");
	end
end

--[[
�C�x���g�������S�\�E������s���b�p�[�֐���Lua_EventForceDead
proxy		�c�C�x���g�v���L�V
TargetID	�c���S�^�[�Q�b�g
]]
function Lua_EventForceDead(proxy,TargetID)
	print("Lua_EventForceDead TargetID ",TargetID);
	proxy:DisableCollection( TargetID, true );
	proxy:ForceDead( TargetID );	
end


--------------------------------------------------------------------------------------------
--�� 4057 �� General Synchronization
--------------------------------------------------------------------------------------------
--DeleteEvent
function SynchroDeleteEvent_4057(proxy,param)
	proxy:DeleteEvent( param:GetParam3() );
end

--SetEventFlag true�ݒ�
function SynchroSetEventFlag_4057(proxy,param)
	proxy:SetEventFlag( param:GetParam3(), true );
end

--SetEventFlag false�ݒ�
function SynchroResetEventFlag_4057(proxy,param)
	proxy:SetEventFlag( param:GetParam3(), false );
end


--------------------------------------------------------------------------------------------
--�����`���[�g���A���p���j���[�҂�
--------------------------------------------------------------------------------------------
function Lua_PauseTutorial(proxy)
	proxy:NotNetMessage_begin();
	proxy:RepeatMessage_begin();
	proxy:OnKeyTime2( 14000,"OnEvent_TutorialWait",Tutorial_pausewait,0,0,once);
	proxy:RepeatMessage_end();
	proxy:NotNetMessage_end();
end

function OnEvent_TutorialWait(proxy,param)
	proxy:StopPlayer();
	proxy:PauseTutorial();
	proxy:NotNetMessage_begin();
	proxy:RepeatMessage_begin();
	proxy:OnKeyTime2( 14000,"OnEvent_TutorialWait_2",0.1,0,2,once);
	proxy:RepeatMessage_end();
	proxy:NotNetMessage_end();	
end

function OnEvent_TutorialWait_2(proxy,param)	
	
	proxy:EnableLogic( 10000 , true );
end


--------------------------------------------------------------------------------------------
--��15500�������A�C�e�����擾���Ă��邩�H�����S�[�X�gNPC�ɑ΂��āA���̕�𒲂ׂ�ƌĂ΂��
--------------------------------------------------------------------------------------------
function OnEvent_15500(proxy,param)
	if proxy:IsCompleteEvent(15500) == false then
		print("OnEvent_15500 begin");
		proxy:SetEventFlag( 15500 ,true );
		print("OnEvent_15500 end");
	end
end

--�e�ۃI�[�i�[�쐬
function CreateBulletOwner(proxy,nwho)		
	InvalidCharactor( proxy , nwho  );
	proxy:SetAlwayEnableBackread_forEvent( nwho , true );	
end


----------------------------------------------------------------------------------------------------------------------------------------------------------------
--��4061���ėp�_�C�A���O�̋�������p
----------------------------------------------------------------------------------------------------------------------------------------------------------------
function MenuClose(proxy,param)
	print("MenuClose begin");
	proxy:CloseGenDialog();
	print("MenuClose end");
end

--�^�C�g�����j���[�ւ�
function RegistReturnTitle(proxy,param)
	print("RegistReturnTitle begin");
	--�Z�[�u�v��
	proxy:SaveRequest();
	--�L�����N�^����̒�~
	proxy:StopPlayer();
	--���̍ēǂݍ��݌n�C�x���g�̊��荞�݂�h�~
	proxy:SetEventFlag(4047, true);
	--�C�x���g�����ɂ����[�h�҂��ł��鎖��ʒm
	proxy:SetLoadWait();	
	
	proxy:NotNetMessage_begin();
	proxy:RepeatMessage_begin();
		proxy:OnKeyTime2( 4062 , "ReturnTitle_wait",0.5,0,20,once);
	proxy:RepeatMessage_end();
	proxy:NotNetMessage_end();
	
	print("RegistReturnTitle end");
end

function ReturnTitle_wait(proxy,param)
	proxy:NotNetMessage_begin();
	proxy:RepeatMessage_begin();
		proxy:OnRegistFunc( 4062 , "Check_ReturnTitle","OnReturnTitle",1,once);
	proxy:RepeatMessage_end();
	proxy:NotNetMessage_end();
end

--�^�C�g���ɖ߂鏈���̃��j���[�\���҂�
function Check_ReturnTitle(proxy)
	if proxy:IsShowMenu_InfoMenu() == true then
		return false;
	end
	return true;
end

--�^�C�g���ɖ߂鏈���̎��s
function OnReturnTitle(proxy,param)
	print("OnReturnTitle begin");
	--�^�C�g��or�}�b�v�Z���N�g�ɖ߂�܂�
	proxy:ReturnMapSelect();
	print("OnReturnTitle end");
end


function Lua_GetReloadTime(proxy,low,high)
	local tempLow  = low  * 1000;
	local tempHigh = high * 1000;
	local rand = proxy:GetRandom( tempLow, tempHigh ) / 1000;
	return rand;
end

--�g�J�Q�C�x���g�o�^�p
function RegistTokage(proxy,eventId,TokageId,index)
	local count = 0;
	proxy:AddFieldInsFilter( TokageId );
	--�g�J�Q�V�d�l�Ή��@����̓z�X�g�̂ݍs��
	if proxy:IsClient() == false then
		--�g�J�Q������ł���or�����Ă���Ȃ�
		if proxy:IsCompleteEvent(eventId) == true then
			--�J�E���^�擾
			count = proxy:GetEventCount(index);
			--�J�E���^���c���Ă���
			if count > 0 then
				--�t���OOFF
				proxy:SetEventFlag( eventId ,false );
				--�J�E���^�����炵�čĐݒ�
				count = count-1;			
				proxy:SetEventCount(index,count);
			end
		end
	end
	
	--�R�R�͑S���ʂ�
		--����ł��Ȃ������ĂȂ��Ȃ�Ď���ǉ�
	if proxy:IsCompleteEvent(eventId) == false then
		print("Add TokageEvent ",TokageId);
		proxy:OnCharacterDead(eventId,TokageId,"OnEvent_"..eventId,once);
		proxy:OnCheckEzStateMessage( eventId,TokageId,"OnEvent_"..eventId,1000);
	else
		--����ł�������Ă���Ȃ疳����
		InvalidBackRead(proxy,TokageId);
	end
end

--�J�E���^���Z
function AddEventCounter(proxy,index)
	--�N���C�A���g�̂�
	if proxy:IsClient() == false then
		local count = proxy:GetEventCount(index);
		count = count + 1;
		proxy:SetEventCount( index, count );
	end
end


--��4065��OBJ�̏��PC���������
function OnEnterRideObj(proxy,param)
	if param:IsNetMessage() == true then
		print("OnEnterRideObj begin");
		local obj 		= param:GetParam2();
		local sysidx 	= param:GetParam3();
		print("obj :",obj," sysidx :",sysidx);
		proxy:SetSyncRideObjInfo(param:GetPlayID()+10001,obj,sysidx);
		print("OnEnterRideObj end");
	end
end

--��4066��OBJ�ɏ���Ă���PC���~�肽��
function OnLeaveRideObj(proxy,param)
	if param:IsNetMessage() == true then
		print("OnLeaveRideObj begin");
		proxy:ResetSyncRideObjInfo(param:GetPlayID()+10001);
		print("OnLeaveRideObj end");
	end
end


--[[
	��Lua_MultiDoping �c�}���`�h�[�s���O�p�A�_�v�^
	proxy	�c�C�x���g�v���L�V
	eneid	�c�G�C�x���gID
]]
function Lua_MultiDoping(proxy,eneId)	
	--�z�X�g�̂ݔ���
	--if proxy:IsClient() == false then		
		local whiteCount = proxy:GetWhiteGhostCount();
		--�z���C�g0�@�������Ȃ�
		if whiteCount == 0 then
			print("No Doping");
		end
		--�z���C�g1�@Lv1�@���� HP1.5�{
		if whiteCount == 1 then
			print("Doping Lv 1 ",eneId);
			proxy:SetEventSpecialEffect_2(eneId,7500);
		end
		--�z���C�g2�@Lv2�@���� HP2�{
		if whiteCount == 2 then
			print("Doping Lv 2 ",eneId);
			proxy:SetEventSpecialEffect_2(eneId,7501);
		end				
	--end	
	proxy:NotNetMessage_begin();	
		proxy:OnKeyTime2( 4070, "ForceUpdate",0.1,0,eneId,once);
	proxy:NotNetMessage_end();
end

function ForceUpdate(proxy,param)
	proxy:ForceUpdateNextFrame( param:GetParam3() );
end

function Lua_MultiDopingm04_02(proxy,eneId)	
	
	local whiteCount = proxy:GetWhiteGhostCount();
	--�z���C�g0�@�������Ȃ�
	if whiteCount == 0 then
		print("No Doping");
	end
	--�z���C�g1�@Lv1�@���� HP1.5�{
	if whiteCount == 1 then
		print("Doping Lv 1 ",eneId);
		proxy:SetEventSpecialEffect_2(10000,7500);
	end
	--�z���C�g2�@Lv2�@���� HP2�{
	if whiteCount == 2 then
		print("Doping Lv 2 ",eneId);
		proxy:SetEventSpecialEffect_2(10000,7501);
	end			
end
