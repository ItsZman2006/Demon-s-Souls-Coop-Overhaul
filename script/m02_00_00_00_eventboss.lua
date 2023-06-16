
--�t�@�����N�XJr�̃C�x���gID�̗񋓗p�A�ŏ��ƍŌ�
PHALANXJRID_START = 860;
PHALANXJRID_END = 897;
--Jr�ʏ��Ԃł����鎞�Ԃ̃E�F�C�g
--�����Ԍo�ߌ�ɖ߂萔�ɋ󂫂��Ȃ���΃E�F�C�g���Čv�Z���Đݒ肵�܂�
PHALANXTIMER_NormalMin = 20;
PHALANXTIMER_NormalMax = 40;
--Jr���R�A��ڎw���Ă��鎞�Ԃ̃E�F�C�g
--��AI���R�A�ɓ��������ƕԂ��O�ɂ��̎��Ԃ��؂ꂽ��ʏ�ɖ߂�܂�
--�����̎��Ԃ��s����܂łɃR�A�ɂ��ǂ蒅�����ƔF�����ꂽ��z���ֈȍ~���܂�
PHALANXTIMER_ToCoreMin = 20;
PHALANXTIMER_ToCoreMax = 40;

PHALANXCORE_STATE = -1;

--�����ꏈ���Ŏg�p����e�p�����[�^�萔
BEGINFADEDIST = 0.30;	--�����J�n����[m]
ENDFADEDIST = 1.0;		--�����I������[m]
BEGINVELOCITY = 5.0;	--�����O�����x[m/sec]
ENDVELOCITY = 1.0;		--����������x[m/sec]

--�P���^���ʒl
PAHALNX_ANGULARDAMPING = 20.0;

PHALANX_1st_DOPING = 15;
PHALANX_2nd_DOPING = 25;

function EventBoss_Initialize_m02_00_00_00(proxy)
	print("EventBoss_Initialize begin");
	
	--�t�@�����N�X����������
	--���{�X�����Ă���Ƃ�
	if proxy:IsCompleteEvent( 4096 ) == false then
		if proxy:IsClient() == false then--�V���O�����z�X�g�Ȃ��			
			--�t�@�����N�X�p�̏���������
			BossInit_Phalanx(proxy,param);
			print("���t�@�����N�X ��������");
		else--�N���C�A���g�Ȃ��
			proxy:NotNetMessage_begin();
				--�N���C�A���g�p�̏��������s��
				BossInit_Phalanx_ForClient(proxy,param);
				--proxy:OnKeyTime2( 4175 ,"BossInit_Phalanx3",0.1,0,3,once);
				BossInit_Phalanx3(proxy,param);
			proxy:NotNetMessage_end();
		end
	else--�{�X�͎���ł���Ƃ�
		--�t�@�����N�X���S
		PhalanxEventDead(proxy,param);
		print("���t�@�����N�X ���S��������");
	end
	
	--------------------------------------------------------------------------------------
	--4173�`4223���t�@�����N�X�C�x���g
	--------------------------------------------------------------------------------------
	proxy:NotNetMessage_begin();
		if proxy:IsClient() == false then--PT���ᖳ��������
			--��4173���t�@�����N�X�C�x���g���ːi�U���J�n
			proxy:OnCheckEzStateMessage(4173,800,"OnEvent_4173",RES_PHALANX_TotugekiStart);	
			--��4174���t�@�����N�X�C�x���g���ːi�U���I��
			proxy:OnCheckEzStateMessage(4174,800,"OnEvent_4174",RES_PHALANX_TotugekiEnd);
			
		end
	proxy:NotNetMessage_end();	
	
	--��4176��Jr�̃A�^���ύX�F�{�X����
	proxy:LuaCall( 4176 , 1 ,"OnEvent_4176" , everytime);
	--��4177��Jr�̃A�^���ύX�F�ʏ퉻��
	proxy:LuaCall( 4177 , 1 , "OnEvent_4177", everytime);
	
	--��4177��Jr��HP�񕜓�����ʉ�����
	proxy:CustomLuaCall( 4177, "OnEvent_4177_Doping", everytime);
	
	print("EventBoss_Initialize end");
end

--------------------------------------------------------------------------------------
--�{�X�p�̏������������K�v�ȂƂ��Ɏg�p�F�ŗL���̍쐬��
--------------------------------------------------------------------------------------
function BossInit_Phalanx(proxy,param)
	print("BossInit_Phalanx begin");
	--�t�@�����N�X�̎v�l���~�߂Ă���
    proxy:EnableLogic(800, false );		
	local JrID =0;
    for JrID = PHALANXJRID_START,PHALANXJRID_END,1 do		
        proxy:EnableLogic(JrID, false );
		proxy:AddFieldInsFilter( JrID );
    end
	
	--�N���C�A���g�Ŗ����Ȃ�@�V���O���@or�@�z�X�g
	if	proxy:IsClient() == false then
		--�l�b�g���[�N�̍X�V�������擾
		proxy:RequestForceUpdateNetwork(800);
		for JrID = PHALANXJRID_START,PHALANXJRID_END,1 do
			--�l�b�g���[�N�̍X�V������v��
			proxy:RequestForceUpdateNetwork(JrID);
		end
	end
	
	if proxy:IsClient() == false then--PT���ᖳ��������
		--�t�@�����N�X�쐬
		proxy:CreatePhalanx(800,PHALANXJRID_START,0.95,1020);
		proxy:SetPhalanxCollision();
		--Jr�̃_�~�|���Ԉړ��̃E�F�C�g
		proxy:SetBaseDmyPolyMoveWait(JR_BaseDmyPolyMoveWait);
		--Jr�̖߂��Ԃ̍ő吔
		proxy:SetMaxReturnCount(PHALANX_MaxReturnCount);
		--Jr�̔����ꏈ���Ɏg�p����p�����[�^
		proxy:SetVelocityParam(BEGINFADEDIST,ENDFADEDIST,BEGINVELOCITY,ENDVELOCITY);
		--�t�@�����N�X�̊p���x�P���^���ʌ����l��ݒ�
		proxy:SetAngularDampingByPhalanx( PAHALNX_ANGULARDAMPING );
		--�����t���ɂȂ邽�߂ɍX�V�͕K�v
		proxy:SetDoesUpdateByPhalanx(true);
	end	
	proxy:NotNetMessage_begin();
		--proxy:OnKeyTime2( 4175 ,"BossInit_Phalanx2",0.1,0,0,once);
		BossInit_Phalanx2(proxy,param);
	proxy:NotNetMessage_end();
	print("BossInit_Phalanx end");
end

--�N���C�A���g�p�̏�����
function BossInit_Phalanx_ForClient(proxy,param)
	print("BossInit_Phalanx_ForClient begin");
	--�t�@�����N�X�̃A�^����ς���
    proxy:SetPhalanxCollision();
	local JrID =0;
    for JrID = PHALANXJRID_START,PHALANXJRID_END,1 do		
        proxy:SetBossUnitJrHit(JrID, true );
    end
	print("BossInit_Phalanx_ForClient end");
end


--------------------------------------------------------------------------------------
--���ԍ��ōX�VOFF
--------------------------------------------------------------------------------------
function BossInit_Phalanx2(proxy,param)
	print("BossInit_Phalanx2 begin");	
	--�t�@�����N�X�C�x���g�����͏d�߂Ȃ̂ōX�V��OFF
	proxy:SetDoesUpdateByPhalanx(false);	
	print("BossInit_Phalanx2 end");
	BossInit_Phalanx3(proxy,param);
end

function BossInit_Phalanx3(proxy,param)
	print("BossInit_Phalanx3 begin");		
	--�t�@�����N�X�L�����X�VOFF
	--proxy:ForceSetOmissionLevel(800,true,-1);
	LuaFunc_NoOmission(proxy,800);
	local JrID =0;
    for JrID = PHALANXJRID_START,PHALANXJRID_END,1 do		        
		--proxy:ForceSetOmissionLevel(JrID,true,-1);
		LuaFunc_NoOmission(proxy,JrID);
    end
	print("BossInit_Phalanx3 end");
end


--------------------------------------------------------------------------------------
--�t�@�����N�X�̓���J�n����
--------------------------------------------------------------------------------------
function PhalanxEventStart(proxy,param)
	print("PhalanxEventStart");
	--�N���C�A���g�Ŗ����Ȃ�@�V���O���@or�@�z�X�g
	if	proxy:IsClient() == false then
		--��4175���t�@�����N�X�C�x���g��Jr�Ď�
		proxy:OnRegistFunc(4180,"Check_PhalanxJr","OnEvent_4175",1,once);
	end
	
	--�t�@�����N�X�̃��W�b�N���I��
    proxy:EnableLogic(800, true );
	--proxy:ForceSetOmissionLevel(800,true,0);	
end

function PhalanxStandBy(proxy,param)
	print("PhalanxStandBy");
	if	proxy:IsClient() == false then
		--�t�@�����N�X�����̍X�V��ON
		proxy:SetDoesUpdateByPhalanx(true);		
	end	
	LuaFunc_ForceOmission(proxy,800);
	proxy:SetAlwaysDrawForEvent(800,true);
	local JrID=0;
    for JrID = PHALANXJRID_START,PHALANXJRID_END,1 do
        proxy:EnableLogic(JrID, true );
		--proxy:ForceSetOmissionLevel(JrID,true,0);
		LuaFunc_ForceOmission(proxy,JrID);
		proxy:SetAlwaysDrawForEvent(JrID,true);
    end
end

--------------------------------------------------------------------------------------
--�t�@�����N�X�p���S����
--------------------------------------------------------------------------------------
function PhalanxDead(proxy,param)
	proxy:ForceDead(800);
	--proxy:ForceSetOmissionLevel(800,false,0);
	LuaFunc_NormalOmission(proxy,800);
	local JrID=0;
	for JrID = PHALANXJRID_START,PHALANXJRID_END,1 do
		--Jr���E��
		--if proxy:IsAlive(JrID) == true then
			proxy:EventIdDetach_PhalanxJr(JrID);			
			proxy:ForceDead_ByJrId(JrID,JR_STATE_Dead);
			--proxy:ForceSetOmissionLevel(JrID,false,0);
			LuaFunc_NormalOmission(proxy,JrID);
		--end
	end
	--�t�@�����N�X�C�x���g�̊Ď����폜����
	proxy:DeleteEvent(4173);
	proxy:DeleteEvent(4174);
	proxy:DeleteEvent(4175);
	proxy:DeleteEvent(4180);
end


--------------------------------------------------------------------------------------
--�t�@�����N�X�Č��p���S����
--------------------------------------------------------------------------------------
function PhalanxEventDead(proxy,param)
	InvalidBackRead(proxy,800);
	local JrID =0;
	for JrID = PHALANXJRID_START,PHALANXJRID_END,1 do
		--Jr���E��
		--if proxy:IsAlive(JrID) == true then
			InvalidBackRead(proxy,JrID);
		--end
	end	
end

--------------------------------------------------------------------------------------
--4173�`4223���ȉ��t�@�����N�X
--------------------------------------------------------------------------------------




--------------------------------------------------------------------------------------
--4173���ˌ��U���J�n
--------------------------------------------------------------------------------------
function OnEvent_4173(proxy,param)
	print("OnEvent_4173 begin");
	proxy:SetEventCommand_PhalanxJr(PHALANX_Jr_Totugeki);
	PHALANXCORE_STATE = PHALANX_Jr_Totugeki;
	print("OnEvent_4173 end");
end

--------------------------------------------------------------------------------------
--4174���ˌ��U���I��
--------------------------------------------------------------------------------------
function OnEvent_4174(proxy,param)
	print("OnEvent_4174 begin");
	proxy:SetEventCommand_PhalanxCore(-1);
	PHALANXCORE_STATE = -1;
	proxy:SetEventCommand_PhalanxJr(-1);
	print("OnEvent_4174 end");
end


--------------------------------------------------------------------------------------
--�t�@�����N�XJr�̏�ԃ`�F�b�N��???
--------------------------------------------------------------------------------------
function Check_PhalanxJr(proxy,param)
	--[[
	if proxy:IsCompleteEvent( 111 ) ==false then
		return false;
	end
	]]
	--print(" begin");
	--Jr�̃��[�v
	if PHALANXCORE_STATE ~= PHALANX_Jr_Totugeki then
	end
	
	local attachCount = proxy:GetAttachCount();
	
	local dopi1 = 5020;
	local dopi2 = 5021;
	--���������ő�h�[�s���O�����ォ�H
	if attachCount >= PHALANX_2nd_DOPING then
		--��h�[�s���O������
		proxy:EraseEventSpecialEffect( 800 , dopi1);
		--���h�[�s���O��ݒ�
		proxy:SetEventSpecialEffect( 800 , dopi2);
	elseif attachCount >= PHALANX_1st_DOPING then
		--���h�[�s���O������
		proxy:EraseEventSpecialEffect( 800 , dopi2);
		--��h�[�s���O��ݒ�
		proxy:SetEventSpecialEffect( 800 , dopi1);
	else
		--���h�[�s���O������		
		proxy:EraseEventSpecialEffect( 800 , dopi1);		
		proxy:EraseEventSpecialEffect( 800 , dopi2);
	end
	
	for JrID = PHALANXJRID_START,PHALANXJRID_END,1 do
	--local FOREND = PHALANXJRID_START+1;
	--for JrID = PHALANXJRID_START,FOREND,1 do
		--�C�x���gID����v����Jr��񂪂��邩�H
		if proxy:FindJrByEventID(JrID) == true then	
			if proxy:IsAlive(JrID) == true then			
				local state = proxy:GetTempJrState();
				
				--HP��Jr�̏�Ԃ�J�ڂ���,������s���͈̂�l�g�ȊO��Jr�ł�
				if state ~= JR_STATE_Single then
					PHALANX_JR_HPRATE = 0.3;
					if proxy:GetHpRate_ByTempJr() <= PHALANX_JR_HPRATE then
						--�ʏ�
						if state == JR_STATE_Normal then
							--���ڈ�l�g�Ɉڍs
							proxy:SetTempJrState( JR_STATE_Single );									
						--�_�~�|���ւ̊��S�z��
						elseif state == JR_STATE_DmyAttach then
							--������Ɉڍs
							proxy:PlayAnimation(JrID,9015);
							proxy:EventIdDetach_PhalanxJr(JrID);
							proxy:SetTempJrState( JR_STATE_HavokFly );
						end
					end					
				end
				
				--��Ԃ𔻒肷��
				--�ʏ�
				if state == JR_STATE_Normal then
					--�R�A��ڎw���Ɉڍs�����������
					if proxy:IsTempJrNoWait() == true then--�E�F�C�g�������Ȃ��Ă���
						--�߂��Ԃɋ󂫂����邩�H
						local rand = proxy:GetRandom(PHALANXTIMER_ToCoreMin,PHALANXTIMER_ToCoreMax);
						local rand2 = rand+1;
						if proxy:IsReturn_PhalanxJr() == true then						
							if proxy:SetNearDmyPoint_Core(JrID,0.0) == true then						
								proxy:SetTempJrState( JR_STATE_ToCore );	--��Ԃ��R�A��ڎw���ړ���
								proxy:SetTempJrWait(rand);	--�������������_���E�F�C�g��ݒ�						
								if proxy:AddEventGoal(JrID, GOAL_COMMON_MoveToSomewhere, rand2, POINT_EVENT, AI_DIR_TYPE_CENTER, 0.0, TARGET_SELF, false,0,0,0) == true then			
									--print("�ݒ萬�� :",JrID);
									proxy:DisableInterupt(JrID,true);
								else
									--print("�ݒ莸�s :",JrID);
								end
								--proxy:DisableInterupt(JrID,true);							
							else
								--print("Point�ݒ莸�s :",JrID);
								proxy:SetTempJrWait(rand);	--�������������_���E�F�C�g��ݒ�
								proxy:SetReserveDmyPolyIDByTempJr(0);--�\��_�~�|����������(�Č����p�H)
							end
						else--�߂��Ԃ������ς��ł�
							proxy:SetTempJrWait(rand);	--�������������_���E�F�C�g��ݒ�
							--��ԕύX����:�ʏ�̂܂�
						end
					end			
				--�R�A��ڎw���ړ�
				elseif state == JR_STATE_ToCore then
					--�_�~�|���ւ̃z�o�[�ړ��Ɉڍs�����������
					if proxy:IsProcessEventGoal(JrID) == true then	--���s��
						proxy:SetNearDmyPoint_Core(JrID,0.0);--�ړ���|�C���g�ݒ�
						if proxy:IsBossCollisionByTempJr() == false then
							if proxy:IsDistance(JrID,800,6.0) == true then	--�������ɓ�������
								if proxy:AddEventGoal(JrID, GOAL_COMMON_MoveToSomewhere, -1, POINT_EVENT, AI_DIR_TYPE_CENTER, 0.0, TARGET_SELF, false,0,0,0) == true then
									--print("�A�^���ύX�A���������ړ��J�n :",JrID);								
									proxy:SetTempJrWait(100);
									proxy:TempJrChangeBossCollision();
								else
									--print("�A�^���ύX�����A���������ړ��ݒ莸�s :",JrID);
									--proxy:SetTempJrWait(100);
								end
							end
						end
					else--���s���ĂȂ�
						local rand = proxy:GetRandom(PHALANXTIMER_NormalMin,PHALANXTIMER_NormalMax);
						local rand2 = rand+1;
						
						if proxy:GetEventGoalState( JrID ) == -1 then--�S�[�������s������ʏ�
						--if proxy:IsTempJrNoWait() == true then--�E�F�C�g�������Ȃ��Ă���Ȃ�ړI�n�������s
							--print("ID:",JrID," �ړI�n�������s");
							proxy:SetTempJrState( JR_STATE_Normal );	--��Ԃ�ʏ��
							proxy:SetBossUnitJrHit(JrID, false );						
							proxy:SetTempJrWait(rand);	--�������������_���E�F�C�g��ݒ�
							proxy:SetReserveDmyPolyIDByTempJr(0);--�\��_�~�|����������(�Č����p�H)
						elseif proxy:GetEventGoalState( JrID ) == 1 then--�S�[���������Ȃ���t��
						--�E�F�C�g���܂�����Ȃ�ړI�n����						
							--local rand = proxy:GetRandom(2,4);						
							if proxy:Attach_PhalanxJr(JrID) == true then
								--��荇�����z��
								--print("ID:",JrID," �ړI�n����")
								proxy:PlayAnimation(JrID,602);
								proxy:SetTempJrWait(2);--3�b��
								proxy:SetTempJrState(JR_STATE_HoverMove);							
								proxy:DisableInterupt(JrID,false);
							else
								--print("���t�����s�Č���:",JrID);
								proxy:SetTempJrState( JR_STATE_Normal );	--��Ԃ�ʏ��
								proxy:SetBossUnitJrHit(JrID, false );
								proxy:SetTempJrWait(rand);	--�������������_���E�F�C�g��ݒ�
								proxy:SetReserveDmyPolyIDByTempJr(0);--�\��_�~�|����������(�Č����p�H)							
							end
						else
							print("�ςȓz������I",JrID);
							proxy:SetTempJrState( JR_STATE_Normal );	--��Ԃ�ʏ��
							proxy:SetBossUnitJrHit(JrID, false );
							proxy:SetTempJrWait(rand);	--�������������_���E�F�C�g��ݒ�
							proxy:SetReserveDmyPolyIDByTempJr(0);--�\��_�~�|����������(�Č����p�H)
						end					
					end
					
				--�_�~�|���ւ̃z�o�[�ړ�
				elseif state == JR_STATE_HoverMove then
					--�_�~�|���ւ̃z�o�[�z���ւ̏�������				
					if proxy:IsTempJrNoWait() == true then--�E�F�C�g�������Ȃ�Ύ��̏�Ԃ�					
						proxy:SetTempJrState(JR_STATE_DmyAttach);
						proxy:SetTempJrWait(1);															
					end
					
				--�_�~�|���ւ̃z�o�[�z��
				elseif state == JR_STATE_DmyHover then
					--�_�~�|���ւ̊��S�z���ւ̏�������
				
				--�_�~�|���ւ̊��S�z��
				elseif state == JR_STATE_DmyAttach then
					--�_�~�|������̐؂藣���ւ̏�������
					if proxy:IsTempJrNoWait() == true then
						if proxy:CheckEventChr_Proxy(JrID,3001) == true then
							--if proxy:IsLimitOver_ByTempJr() == true then
							--if PHALANXCORE_STATE == PHALANX_Jr_Totugeki then
								proxy:PlayAnimation(JrID,9015);
								proxy:EventIdDetach_PhalanxJr(JrID);
								proxy:SetTempJrState( JR_STATE_HavokFly );
							--end
							--end
						end
					end							
				--Havok������		
				elseif state == JR_STATE_HavokFly then
					--���肵����ʏ��
					if proxy:IsBalanceByTempJr() == true then					
						--proxy:SetTempJrState( JR_STAET_Reverse );	--�]�|�A�j���Đ���
						local rand = proxy:GetRandom(PHALANXTIMER_NormalMin,PHALANXTIMER_NormalMax);		--��������
						proxy:SetTempJrWait(rand);					--�����E�F�C�g�ݒ�
						proxy:SetTempJrState( JR_STATE_Normal );	--�ʏ��Ԃ�
					end
				elseif state == JR_STATE_Dead then--���S��ԍX�V��
					proxy:EventIdDetach_PhalanxJr(JrID);			
					proxy:ForceDead_ByJrId(JrID,JR_STATE_Dead);				
				end				
			else--����ł�����
				proxy:SetTempJrState( JR_STATE_Dead );	--���S��ԍX�V��				
			end
		end
	end
	return false;
	--print(" end");
end

--------------------------------------------------------------------------------------
--4175����
--------------------------------------------------------------------------------------
function OnEvent_4175(proxy,param)
	print("OnEvent_4175 begin");
	print("�Ă΂�鎖�͖����͂��̃C�x���g���������Ă��܂�");
	--�Ă΂�鎖�͖����͂�
	print("OnEvent_4175 end");
end

--------------------------------------------------------------------------------------
--4176���{�X�A�^����
--------------------------------------------------------------------------------------
function OnEvent_4176(proxy,param)
	print("OnEvent_4176 begin");
	--param3�@�ύX�������L������ID
	if param:IsNetMessage() == true then
		proxy:SetBossUnitJrHit( param:GetParam3(),true);
	end
	
	print("OnEvent_4176 end");
end

--------------------------------------------------------------------------------------
--4177���ʏ�A�^����
--------------------------------------------------------------------------------------
function OnEvent_4177(proxy,param)
	print("OnEvent_4177 begin");
	--param3 �ύX�������L������ID
	if param:IsNetMessage() == true then
		proxy:SetBossUnitJrHit( param:GetParam3(),false);
	end	
	print("OnEvent_4177 end");
end

function OnEvent_4177_Doping(proxy,param)
	proxy:EraseEventSpecialEffect_2(param:GetParam2(), 5066 );
end
--~ --------------------------------------------------------------------------------------
--~ --��
--~ --------------------------------------------------------------------------------------
--~ function (proxy,param)
--~ 	print(" begin");
--~ 	print(" end");
--~ end

