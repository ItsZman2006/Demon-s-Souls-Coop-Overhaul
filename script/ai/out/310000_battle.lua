--[[*******************************************************************************************
	��΃~�~�Y�p�퓬
	�����F

	�p�����[�^0  �Ȃ�
	�p�����[�^1  �Ȃ�
	�p�����[�^2  �Ȃ�
	�p�����[�^3�@�Ȃ�
*********************************************************************************************]]
REGISTER_GOAL(GOAL_mimizu310000_Battle, "mimizu310000_Battle");

REGISTER_GOAL_NO_UPDATE( GOAL_mimizu310000_Battle, true);
REGISTER_GOAL_NO_INTERUPT( GOAL_mimizu310000_Battle, true);

--[[*************************************************************
	�S�[���N��
***************************************************************]]
function mimizu310000_Battle_Activate(ai, goal)

	--�Ƃ肠�����A�^�[�Q�b�g�𐳖ʂɕ߂炦�悤�Ƃ���B
	goal:AddSubGoal( GOAL_COMMON_Turn, 1, TARGET_ENE_0);

	--�U���O���߁B
	local wait_before_attack = ai:GetRandam_Float( 0, 2);
	goal:AddSubGoal( GOAL_COMMON_Wait, wait_before_attack, TARGET_ENE_0);
	
	--�U������
	local idNpcThinkParam = ai:GetNpcThinkParamID();
	if ( idNpcThinkParam==310001 ) then 
		--�n��V�����[�����܂���B
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3002, TARGET_ENE_0, DIST_None, 0);
		goal:AddSubGoal( GOAL_COMMON_Wait, 0.8, TARGET_ENE_0);
	else
		--�ʏ�U��
		mimizu310000_Battle_Attack(ai, goal)
	end
end

---------------------------------------------------------
--  �U��
---------------------------------------------------------
function mimizu310000_Battle_Attack(ai, goal)

	local targetDist 	= ai:GetDist(TARGET_ENE_0);			--�G�^�[�Q�b�g�Ƃ̋������擾
	local NEAR_DIST 	= ai:GetDistParam( DIST_Near);
	local fate   	  = ai:GetRandam_Int(1,100)				--�m������Ŏg�p����^���̐���
	local idNpcThinkParam = ai:GetNpcThinkParamID();		--NPC��ID���擾

	if ( targetDist<=NEAR_DIST ) then
		--�ߋ����U���B
		--35% ���ݕt��
		--35% �ガ����
		--30% ���ݍ���
		if fate <= 35 then
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Near, 0);
		elseif fate <= 70 then
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3004, TARGET_ENE_0, DIST_Near, 0);
		else
			if ( idNpcThinkParam~=310002 ) then 	
				goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3003, TARGET_ENE_0, DIST_Near, 0);
			else
				goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3004, TARGET_ENE_0, DIST_Near, 0);				
			end
		end
		
	else
		--�������U���B
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_None, 0);
	end

end


	
--[[*************************************************************
	�S�[���X�V�E�I���E���荞�݂͂Ȃ��B
***************************************************************]]
function mimizu310000_Battle_Update(ai, goal) return GOAL_RESULT_Continue; end
function mimizu310000_Battle_Terminate(ai, goal) end
function mimizu310000_Battle_Interupt(ai, goal) return false; end





			


	