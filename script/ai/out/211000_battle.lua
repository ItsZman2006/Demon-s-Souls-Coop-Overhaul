--[[*******************************************************************************************
	�E���R�z�v�i�s�b�N���E���j�p�퓬
	�����F

	�p�����[�^0  �Ȃ�
	�p�����[�^1  �Ȃ�
	�p�����[�^2  �Ȃ�
	�p�����[�^3�@�Ȃ�
*********************************************************************************************]]
REGISTER_GOAL(GOAL_urokoP211000_Battle, "urokoP211000_Battle");


-- Update�łȂɂ�����Ă��Ȃ��̂ŁA�Ă΂Ȃ��悤�ɂ���
REGISTER_GOAL_NO_UPDATE( GOAL_urokoP211000_Battle, true);


--[[*****************************************************
	�S�[���N��
*******************************************************]]
function urokoP211000_Battle_Activate(ai, goal)

	--�����̔w��ɂ���ꍇ�́A�����U������A�j�����B
	if ( ai:IsInsideTargetEx( TARGET_SELF, TARGET_ENE_0, AI_DIR_TYPE_B, 90, 4 ) ) then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3006, TARGET_ENE_0, DIST_None);
	end

	--�U���������鋗���܂ŁA�ڋ߂���B
	goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, 3, TARGET_ENE_0, false, -1 );

	--�U������
	urokoP211000_Battle_Kougeki(ai, goal)
	
	--�U����s��
	urokoP211000_Battle_Kougeki_Noato(ai, goal)
end

---------------------------------------------------------
--  �U��
---------------------------------------------------------
function urokoP211000_Battle_Kougeki(ai, goal)

local K_fate = ai:GetRandam_Int(1,100)			--�m������Ŏg�p����^���̐���

	--80% 3000
	--20% 3000-3001
	if K_fate < 80 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
	else
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);
	
	end
end

	
	
---------------------------------------------------------
--  �U����̍s��
---------------------------------------------------------
function urokoP211000_Battle_Kougeki_Noato(ai, goal)

local KN_fate = ai:GetRandam_Int(1,100)			--�m������Ŏg�p����^���̐���
local SideDist = 1.0							--���ɓ�������
local SideTime = 0.5							--���ɓ�������
local BackDist = 1.0							--��ނ��鋗��
local BackTime = 0.5							--��ނ��鎞��
local bRight = ai:GetRandam_Int(0,1);			--�E������
-- ���������ɍ��E�ړ����Ă��钇�Ԃ̐�
local friendNum = ai:GetTeamRecordCount(COORDINATE_TYPE_SideWalk_L+bRight, TARGET_ENE_0, 2.0);

	
	--50% �K���ɉ��Ɉړ�(�K�[�h����)
	--50% ���Ɉړ�(�K�[�h�Ȃ�)
	if  KN_fate < 70 and friendNum < 1 then
	    goal:AddSubGoal( GOAL_COMMON_LeaveTarget, BackTime, TARGET_ENE_0, BackDist, TARGET_ENE_0, true, -1 );				
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, SideTime, TARGET_ENE_0, bRight, ai:GetRandam_Int(30,45), true, true ,-1 );
	else
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, BackTime, TARGET_ENE_0, BackDist, TARGET_ENE_0, true, -1 );				
	end
end






--[[*****************************************************
	�S�[���X�V�i�X�V���܂���B�j
*******************************************************]]
function urokoP211000_Battle_Update(ai, goal)return GOAL_RESULT_Continue;end

--[[*****************************************************
	�S�[���I��
*******************************************************]]
function urokoP211000_Battle_Terminate(ai, goal)
end

--[[*****************************************************
--  ���荞��
--	���荞�񂾏ꍇ�ɂ�true��Ԃ��Ă��������B
--	�����Ŋ��荞�ݗp�̃T�u�S�[����ǉ����Ă��������B
--	���荞�܂Ȃ������ꍇ�ɂ́A1��̑w�̃S�[���A�܂��̓��W�b�N�����ɂ���Ċ��荞�݂���������܂��B
*******************************************************]]
function urokoP211000_Battle_Interupt(ai, goal)
	return false;
end


--[[************************************************************************************************************]]
--[[************************************ �E���R�z�v�T�u�S�[�� **************************************************]]
--[[************************************************************************************************************]]



--[[*******************************************************************************************
	�E���R�z�v�p�҂��S�[���B
	�����F
		�E���R�z�v�p�̑ҋ@���ɍs���A�N�V�����������B
		�҂����̃����_�����͂����ŁB
		
	�p�����[�^0  �Ȃ��B
*********************************************************************************************]]
REGISTER_GOAL(GOAL_uroko_COMMON_Wait, "UROKOWait");
REGISTER_GOAL_NO_UPDATE( GOAL_uroko_COMMON_Wait, true);
REGISTER_GOAL_NO_INTERUPT( GOAL_uroko_COMMON_Wait, true);

--[[*****************************************************
	�S�[���N��
*******************************************************]]
function UROKOWait_Activate(ai, goal)

	--�p�����[�^ID�ŁA�ω���������;
	local idParam 	= ai:GetNpcThinkParamID();
	local ezStateNo	= 0;

	
	if 		(idParam==211000) then		ezStateNo	= 3300; --�s�b�P��
	elseif 	(idParam==211001) then		ezStateNo	= 3301;	--��
	elseif 	(idParam==211002) then		ezStateNo	= 0;	--����
	elseif 	(idParam==211003) then		ezStateNo	= 0;	--�匕
	elseif 	(idParam==211004) then		ezStateNo	= 0;	--�S�N���艺
	elseif 	(idParam==211006) then		ezStateNo	= 3300;	--�n���}�[
	elseif 	(idParam==211007) then		ezStateNo	= 3302;	--�f��
	elseif 	(idParam==211008) then		ezStateNo	= 0;	--�U���^�B
	elseif 	(idParam==211009) then		ezStateNo	= 3302;	--�Ⓤ���B
	end


	--�A�N�V�����O�A�ԁB
	local wait_time = ai:GetRandam_Float( 1.0, 3.0);
	goal:AddSubGoal( GOAL_COMMON_Wait, wait_time, TARGET_NONE);
	
	--�܂��A�N�V�����B
	if ( 0<ezStateNo) then
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 100, ezStateNo, TARGET_NONE, DIST_None);
	end
	
end

--[[*****************************************************
	�S�[���X�V�E�I���E���荞�݂��s��Ȃ��B
*******************************************************]]
function UROKOWait_Update(ai, goal) return GOAL_RESULT_Continue; end
function UROKOWait_Terminate(ai, goal) end
function UROKOWait_Interupt(ai, goal) return false; end





			


