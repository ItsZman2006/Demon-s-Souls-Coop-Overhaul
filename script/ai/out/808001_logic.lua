--[[*******************************************************************************************
	����S�r�����W�b�N
	�����F
	�@�E�h���S�����O�̏�ǂɏo�Ă��鎞�́A�U�����Ȃ��B�i�C�x���g���N�G�X�g�O���A-1�ȊO�ɂȂ�B�j
	�@�E�w��̐퓬�̈�(EvID:2730)����^�[�Q�b�g���o����A�U�����Ȃ��B
	
	TIPS�F
	�@�E����S�Ńr�����o�����߂ɂ́A�C�x���g�t���O�F16072�𗧂Ăē���B
*********************************************************************************************]]
REGISTER_LOGIC_FUNC(LOGIC_ID_Biyo808001, "Biyo808001_Logic", "Biyo808001_Interupt");

--[[***********************************************************************
	���W�b�N�B
*************************************************************************]]
function Biyo808001_Logic(ai)

--[[���������ځ�]]

	local 	BATTLE_REGION_EVID	= 2730;		--�퓬�̈�B

--[[���������ځ�]]

	if ( 	ai:IsInsideTargetRegion(TARGET_ENE_0, BATTLE_REGION_EVID) 
		and ai:IsSearchTarget(TARGET_ENE_0)
		and (-1==ai:GetEventRequest())) then
		
		--�퓬�̈���Ȃ̂ŁA�퓬�B
		ai:AddTopGoal(GOAL_Biyo_808000_Battle, -1);
	
	else
		--NonBattleAct��Activate����B�B�B
		local pointDist = ai:GetMovePointEffectRange();		-- �ړ��|�C���g����̉e���͈�
		if (pointDist<3) then
			-- ���̏�őҋ@
			ai:AddTopGoal( GOAL_COMMON_Stay, 10, 0, POINT_INIT_POSE);
		else
			-- �ړ��|�C���g�Ȃ� �����ʒu�ɖ߂�
			ai:AddTopGoal( GOAL_COMMON_BackToHome, 10, 0);
		end
	end
end

--[[***********************************************************************
	���荞�݁B
*************************************************************************]]
function Biyo808001_Interupt(ai, goal)
end


