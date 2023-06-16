-----------------------------------------------------------------------------------------------
--	�h���S���f�[�����i�B���j��p�퓬
--	�����F
--
--	�p�����[�^0  �Ȃ�
--	�p�����[�^1  �Ȃ�
--	�p�����[�^2  �Ȃ�
--	�p�����[�^3�@�Ȃ�
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_DD605001_Battle, "DD605001Battle");


---------------------------------------------------------
--  �S�[���N��
---------------------------------------------------------
function DD605001Battle_Activate(ai, goal)

	
	local fate0 = ai:GetRandam_Int( 0, 100 );
	local eventNo = ai:GetEventRequest();
	local rate = ai:GetHpRate( TARGET_SELF )		--������HP
	local state = ai:GetNumber(0);					-- �C���f�b�N�X0�ŃX�e�[�g��ۑ����Ă���

	
	-- ��L������
	if( eventNo == AI_EVENT_PUNCH1 ) then
		-- �p���`1
			goal:AddSubGoal(GOAL_COMMON_NonspinningAttack, 3.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
			
	-- ��L����O
	elseif( eventNo == AI_EVENT_PUNCH2  ) then	
			-- �p���`2
			if state == 0 then
				goal:AddSubGoal(GOAL_COMMON_NonspinningAttack, 3.0, 3020, TARGET_ENE_0, DIST_Far, 0);
				-- ���̃X�e�[�g�� 0�ԃC���f�b�N�X�ɃX�e�[�g1��ݒ肷��
				ai:SetNumber(0, 1);
			else
				goal:AddSubGoal(GOAL_COMMON_NonspinningAttack, 3.0, 3010, TARGET_ENE_0, DIST_Far, 0);
			end
			
    -- ��L������
	elseif( eventNo == AI_EVENT_PUNCH3   ) then	
		
			-- �p���`3
			if state == 0 then
				goal:AddSubGoal(GOAL_COMMON_NonspinningAttack, 3.0, 3030, TARGET_ENE_0, DIST_Far, 0);
				-- ���̃X�e�[�g�� 0�ԃC���f�b�N�X�ɃX�e�[�g1��ݒ肷��
				ai:SetNumber(0, 1);
			else
				goal:AddSubGoal(GOAL_COMMON_NonspinningAttack, 3.0, 3020, TARGET_ENE_0, DIST_Far, 0);
			end
			
    -- ��L����
	elseif( eventNo == AI_EVENT_PUNCH4) then	
		
			-- �p���`4
			goal:AddSubGoal(GOAL_COMMON_NonspinningAttack, 3.0, 3030, TARGET_ENE_0, DIST_Far, 0);
			
	-- ���L��O
	elseif( eventNo == AI_EVENT_BREATH1) then	
		
			-- �u���X1
			if state == 0 or state == 1 then
				goal:AddSubGoal(GOAL_COMMON_NonspinningAttack, 3.0, 3060, TARGET_ENE_0, DIST_Far, 0);
				-- ���̃X�e�[�g�� 0�ԃC���f�b�N�X�ɃX�e�[�g2��ݒ肷��
				ai:SetNumber(0, 2);
			else
				goal:AddSubGoal(GOAL_COMMON_NonspinningAttack, 3.0, 3050, TARGET_ENE_0, DIST_Far, 0);
			end
	
	-- ���L����
	elseif( eventNo == AI_EVENT_BREATH2) then	
		
			-- �u���X2
			if state == 0 or state == 1 then
				goal:AddSubGoal(GOAL_COMMON_NonspinningAttack, 3.0, 3070, TARGET_ENE_0, DIST_Far, 0);
				-- ���̃X�e�[�g�� 0�ԃC���f�b�N�X�ɃX�e�[�g2��ݒ肷��
				ai:SetNumber(0, 2);
			else
				goal:AddSubGoal(GOAL_COMMON_NonspinningAttack, 3.0, 3060, TARGET_ENE_0, DIST_Far, 0);
			end
			
	-- ���L��
	elseif( eventNo == AI_EVENT_BREATH3) then	
		
			-- �u���X3
			if state == 0 or state == 1 then
				goal:AddSubGoal(GOAL_COMMON_NonspinningAttack, 3.0, 3080, TARGET_ENE_0, DIST_Far, 0);
				-- ���̃X�e�[�g�� 0�ԃC���f�b�N�X�ɃX�e�[�g2��ݒ肷��
				ai:SetNumber(0, 2);
			else
				goal:AddSubGoal(GOAL_COMMON_NonspinningAttack, 3.0, 3070, TARGET_ENE_0, DIST_Far, 0);
			end
			
	-- ���L�K�i
	elseif( eventNo == AI_EVENT_BREATH4) then	
		
			-- �u���X4
			goal:AddSubGoal(GOAL_COMMON_NonspinningAttack, 3.0, 3080, TARGET_ENE_0, DIST_Far, 0);
	
	-- ��̑O
	elseif( eventNo == AI_EVENT_BITEATTACK) then	
	
		if rate <= 0.3 then

			--�����Ԋ��ݕt���P
			goal:AddSubGoal(GOAL_COMMON_NonspinningAttack, 3.0, 3140, TARGET_ENE_0, DIST_None, 0);
			goal:AddSubGoal(GOAL_COMMON_Wait, 1.5, TARGET_ENE_0);

		else

			--����f���u���X
			goal:AddSubGoal(GOAL_COMMON_NonspinningAttack, 3.0, 3130, TARGET_ENE_0, DIST_None, 0);
			goal:AddSubGoal(GOAL_COMMON_Wait, 2.6, TARGET_ENE_0);
		
		end
			
	-- ���̑�
	else
		goal:AddSubGoal( GOAL_COMMON_Wait, 2.0, TARGET_NONE, 0, 0, 0 );
	end
	
end

---------------------------------------------------------
--  �S�[���X�V
---------------------------------------------------------
function DD605001Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  �S�[���I��
---------------------------------------------------------
function DD605001Battle_Terminate(ai, goal)
end


---------------------------------------------------------
--  ���荞��
--	���荞�񂾏ꍇ�ɂ�true��Ԃ��Ă��������B
--	�����Ŋ��荞�ݗp�̃T�u�S�[����ǉ����Ă��������B
--	���荞�܂Ȃ������ꍇ�ɂ́A1��̑w�̃S�[���A�܂��̓��W�b�N�����ɂ���Ċ��荞�݂���������܂��B
---------------------------------------------------------
function DD605001Battle_Interupt(ai, goal)
	
	-- �G���A�C�e�����g�����ꍇ
	if ai:IsInterupt( INTERUPT_UseItem ) then
		-- �S�[���N���A
		goal:ClearSubGoal();

		DD605001Battle_Activate( ai, goal );
		return true;
	elseif ai:IsInterupt( INTERUPT_MissSwing ) then
		-- �S�[���N���A
		goal:ClearSubGoal();
		DD605001Battle_Activate( ai, goal );
		return true;
	end
	
	return false;
end
