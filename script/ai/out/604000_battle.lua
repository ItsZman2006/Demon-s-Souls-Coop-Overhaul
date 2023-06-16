-----------------------------------------------------------------------------------------------
--	Libra604000��p�퓬
--	�����F
--
--	�p�����[�^0  �Ȃ�
--	�p�����[�^1  �Ȃ�
--	�p�����[�^2  �Ȃ�
--	�p�����[�^3�@�Ȃ�
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_Libra604000_Battle, "Libra604000Battle");

-- Update�łȂɂ�����Ă��Ȃ��̂ŁA�Ă΂Ȃ��悤�ɂ���
REGISTER_GOAL_NO_UPDATE( GOAL_Libra604000_Battle, 1 );


---------------------------------------------------------
--  �S�[���N��
---------------------------------------------------------
function Libra604000Battle_Activate(ai, goal)
-------------------------------------------------------------------------------
	--�Ȃɂ����Ȃ�
	goal:AddSubGoal(GOAL_COMMON_Wait, -1.0,TARGET_ENE_0, 0, 0, 0 );
	
end


---------------------------------------------------------
--  �S�[���X�V
---------------------------------------------------------
function Libra604000Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  �S�[���I��
---------------------------------------------------------
function Libra604000Battle_Terminate(ai, goal)
end


---------------------------------------------------------
--  ���荞��
--	���荞�񂾏ꍇ�ɂ�true��Ԃ��Ă��������B
--	�����Ŋ��荞�ݗp�̃T�u�S�[����ǉ����Ă��������B
--	���荞�܂Ȃ������ꍇ�ɂ́A1��̑w�̃S�[���A�܂��̓��W�b�N�����ɂ���Ċ��荞�݂���������܂��B
---------------------------------------------------------
function Libra604000Battle_Interupt(ai, goal)


	local hprate = ai:GetHpRate( TARGET_SELF )	--������HP�������擾
	local state = ai:GetNumber(0);	-- �C���f�b�N�X0�ŃX�e�[�g��ۑ����Ă���
	local targetDist = ai:GetDist(TARGET_ENE_0);	--�G�^�[�Q�b�g�Ƃ̋���
	
	local nearDist = 3.9		--�߂��Ɣ��f���鋗��(�������S�������a���x)
	
	-- �_���[�W�󂯂��犄�荞��
	if( ai:IsInterupt( INTERUPT_Damaged ) ) then

	--[[
			�X�e�[�g�ԍ��Ō��݂̏�Ԃ�����킷
			HP���ւ��Ă������ƂɃX�e�[�g���؂�ւ��A
			�؂�ւ��^�C�~���O�ł����U�������s����
	]]

		-- ��ԍŏ�
		if state == 1 then
			if hprate < 0.55 then
				-- HP�H���ȉ��܂ő҂�
				-- ���܂���Ă��邱�Ƃ����N���A
				goal:ClearSubGoal();
				-- �����ɂ���čU���A�������͉�
				if targetDist < nearDist then
					goal:AddSubGoal(GOAL_COMMON_NonspinningAttack, 10.0, 3000, TARGET_ENE_0, DIST_None, 0);
				else
					goal:AddSubGoal(GOAL_COMMON_NonspinningAttack, 10.0, 3001, TARGET_ENE_0, DIST_None, 0);
				end
				-- ���̃X�e�[�g�� 0�ԃC���f�b�N�X�ɃX�e�[�g1��ݒ肷��
				ai:SetNumber(0, 2);
				return true;
			end
		elseif state == 2 then
			if hprate < 0.3 then
				-- HP�H���ȉ��܂ő҂�
				-- ���܂���Ă��邱�Ƃ����N���A
				goal:ClearSubGoal();
				-- �����ɂ���čU���A�������͉�
				if targetDist < nearDist then
					goal:AddSubGoal(GOAL_COMMON_NonspinningAttack, 10.0, 3000, TARGET_ENE_0, DIST_None, 0);
				else
					goal:AddSubGoal(GOAL_COMMON_NonspinningAttack, 10.0, 3001, TARGET_ENE_0, DIST_None, 0);
				end
				-- ���̃X�e�[�g�� 0�ԃC���f�b�N�X�ɃX�e�[�g1��ݒ肷��
				ai:SetNumber(0, 3);
				return true;
			end
		elseif state == 3 then
			-- ���荞�܂Ȃ�
			return false;
		else
			if hprate < 0.8 then
				-- ��ԍŏ��ɂ���
				-- HP�H���ȉ��܂ő҂�
				-- ���܂���Ă��邱�Ƃ����N���A
				goal:ClearSubGoal();
				-- �����ɂ���čU���A�������͉�
				if targetDist < nearDist then
					goal:AddSubGoal(GOAL_COMMON_NonspinningAttack, 10.0, 3000, TARGET_ENE_0, DIST_None, 0);
				else
					goal:AddSubGoal(GOAL_COMMON_NonspinningAttack, 10.0, 3001, TARGET_ENE_0, DIST_None, 0);
				end
				-- ���̃X�e�[�g�� 0�ԃC���f�b�N�X�ɃX�e�[�g1��ݒ肷��
				ai:SetNumber(0, 1);
				return true;
			end
		end
	end

	return false;
end

