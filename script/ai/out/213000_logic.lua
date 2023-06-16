--[[*******************************************************************************************
	�e�����W�b�N�B
	�����F
	
	��ai:SetNumber()�̎g�p�󋵁B
		�O�F
		�P�F
		�Q�F�N��OK���H�					�O�ȊO�ŋN���B
		�R�F�R�b�\���ړ��I���������H�@	�O�ȊO�ŏI���Ƃ���B
		
	��ai:AddObserveRegion()�̎g�p�󋵁B
		�O�F
		�P�F
		�Q�F
		�R�F�^�[�Q�b�g����������N������̈�B
*********************************************************************************************]]
REGISTER_LOGIC_FUNC(LOGIC_ID_KageOnna213000, "KageOnna213000_Logic", "KageOnna213000_Interupt");

--[[*********************************************************
	���W�b�N�B
***********************************************************]]
function KageOnna213000_Logic(ai)

	local BOOTUP_REGION	= -1;
	local param_id		= ai:GetNpcThinkParamID();
	if 		(param_id==213000) then		BOOTUP_REGION = 2460;
	elseif	(param_id==213001) then		BOOTUP_REGION = 2461;
	end

	--�Ď��̈�ǉ��B
	ai:AddObserveRegion( 3, TARGET_ENE_0, BOOTUP_REGION);
	--�K�[�h�J�n�B
	ai:StartGuard(9910);

	--�������Ă�����A�퓬��ԉ����B
	if ( not(ai:IsSearchTarget(TARGET_ENE_0)) ) then
		ai:SetNumber(2, 0);
	end
	
	---------------------------------------------
	if ( not(0==ai:GetNumber(2)) ) then
	
		--�퓬��ԁB
		--	�܂��́A�R�b�\���U���B
		if (0==ai:GetNumber(3)) then
			--�R�b�\���B
			ai:AddTopGoal(GOAL_kageonna213000_SneakAttack, -1);
		else
			--�ʏ�퓬���́A�p���K�[�h���Ȃ��B
			ai:EndGuard();
		
			--�ʏ�퓬�B
			ai:AddTopGoal(GOAL_kageonna213000_Battle, -1);
		end
	
	else
	
		--��퓬�s���B
		ai:AddTopGoal(GOAL_kageonna213000_NonBattle, -1);
	
		--�N���t���O��������B
		ai:SetNumber(2, 0);
	end
end

--[[*********************************************************
	���荞�݁B
***********************************************************]]
function KageOnna213000_Interupt(ai, goal)

	--�N���̈�ɍ����|��������A�N���B
	if ( ai:IsInterupt(INTERUPT_Inside_ObserveArea) ) then
		if ( ai:IsInsideObserveRegion(3) ) then
			
			--�N���t���O�������Ă��Ȃ�������.
			if ( 0==ai:GetNumber(2) ) then
				--�N���t���O�𗧂Ă�B
				ai:SetNumber(2, 1);
				--���݂̃S�[���������āA�������v�����j���O�B
				goal:ClearSubGoal();
			end
			
		end
	end

	--�^�[�Q�b�g��Y�ꂽ��A�N���t���O��������B
	if ( ai:IsInterupt(INTERUPT_ForgetTarget) ) then
		ai:SetNumber(2, 0);
	end
	
end


