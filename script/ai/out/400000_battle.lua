----------------------------------------------------------------------------------------------
--	�Ȃ肻���Ȃ��p�퓬
--	�����F
--
--	�p�����[�^0  �Ȃ�
--	�p�����[�^1  �Ȃ�
--	�p�����[�^2  �Ȃ�
--	�p�����[�^3�@�Ȃ�
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_Narisoko400000_Battle, "narisoko400000Battle");


-- Update�łȂɂ�����Ă��Ȃ��̂ŁA�Ă΂Ȃ��悤�ɂ���
REGISTER_GOAL_NO_UPDATE( GOAL_Narisoko400000_Battle, 1 );


---------------------------------------------------------
--  �S�[���N��
---------------------------------------------------------
function narisoko400000Battle_Activate(ai, goal)
-------------------------------------------------------------------------------

local targethprate = ai:GetHpRate( TARGET_ENE_0 )		--�G�^�[�Q�b�g��HP�������擾
local targetDist = ai:GetDist(TARGET_ENE_0);			--�G�^�[�Q�b�g�Ƃ̋������擾
local fate = ai:GetRandam_Int(1,100)					--�m������Ŏg�p����^���̐���
local fate2 = ai:GetRandam_Int(1,100)					--�m������Ŏg�p����^���̐����@���̂Q

	if fate <= 50 then
		goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, 2.3, TARGET_ENE_0, true, -1 );
		goal:AddSubGoal(GOAL_COMMON_Attack2, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);		
	else
		goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, 1.2, TARGET_ENE_0, true, -1 );
		goal:AddSubGoal(GOAL_COMMON_Attack2, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);		
	end
	
	if fate <= 50 then
		goal:AddSubGoal(GOAL_COMMON_NonspinningAttack, 10.0, 3002, TARGET_ENE_0, DIST_Middle, 0);
	end


end

	
---------------------------------------------------------
--  �S�[���X�V
---------------------------------------------------------
function narisoko400000Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  �S�[���I��
---------------------------------------------------------
function narisoko400000Battle_Terminate(ai, goal)
end


---------------------------------------------------------
--  ���荞��
--	���荞�񂾏ꍇ�ɂ�true��Ԃ��Ă��������B
--	�����Ŋ��荞�ݗp�̃T�u�S�[����ǉ����Ă��������B
--	���荞�܂Ȃ������ꍇ�ɂ́A1��̑w�̃S�[���A�܂��̓��W�b�N�����ɂ���Ċ��荞�݂���������܂��B
---------------------------------------------------------
function narisoko400000Battle_Interupt(ai, goal)

return false;
end



	