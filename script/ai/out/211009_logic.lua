--[[*******************************************************************************************
	�Ⓤ���E���R�z�v�̎v�l���W�b�N
	�����F
	
	ai:SetNumber()�̗p�r�B
		�O�F
		�P�F
		�Q�F���ڂ̓������ǂ����B�O�Ȃ�A�P��ڂ̓����B
		�R�F����̂��߂̃��v�����j���O���ǂ����B
	
*********************************************************************************************]]
REGISTER_LOGIC_FUNC(LOGIC_ID_uroko211009, "uroko211009_Logic", "uroko211009_Interupt");

-----------------------------------------------------------------------------------------------
--	�E���R�z�v�p�̎v�l���W�b�N
--	���̒��Ō��݂̏󋵂𔻕ʂ��A�g�p����g�b�v�S�[�����ЂƂ��肵�܂��B
-----------------------------------------------------------------------------------------------
function	uroko211009_Logic(ai)

	--
--~ 	UROKO_EasySetup2( ai, GOAL_uroko_COMMON_Wait, function () uroko211009_AddCautionAndFindGoal(ai) end);
	UROKO_EasySetup2( ai, GOAL_COMMON_Wait, function () uroko211009_AddCautionAndFindGoal(ai) end);
	
end


-----------------------------------------------------------------------------------------------
--	�E���R�z�v�p�̊��荞�݃��W�b�N
--	���݂̏�Ԃł�肱�߂�̂ł����true���A
--	���̂܂ܖ�������̂ł����false��Ԃ��Ă��������B
-----------------------------------------------------------------------------------------------
function	uroko211009_Interupt(ai, goal)
end

--[[********************************************************************************
	�x���E�������̃S�[���ݒ�֐��B
**********************************************************************************]]
function uroko211009_AddCautionAndFindGoal( ai)
	
--[[����悳�񒲐����ځ�]]

	local CheckRegionID = -1;--���̃C�x���gID�̗̈�ɓ����Ă�����A�Ⓤ���B
	local idParam = ai:GetNpcThinkParamID();
	if 		(idParam==211009) then	CheckRegionID = 2160;	--�X�^�[�g���セ�̂P
	elseif 	(idParam==211010) then	CheckRegionID = 2161;	--�������̂P
	elseif 	(idParam==211011) then	CheckRegionID = 2160;	--�X�^�[�g���セ�̂Q
	elseif 	(idParam==211012) then	CheckRegionID = 2161;	--�������̂Q
	end

	--�X�^�[�g����̊Ⓤ���f�B���C�B
	local start_partner_delay	= 1;
	local eventNo = ai:GetEventRequest();	--�C�x���g����̃��N�G�X�g�ԍ����擾

	
--[[����悳�񒲐����ځ�]]

	if ( ai:IsInsideTargetRegion( TARGET_ENE_0, CheckRegionID) ) then
		
		--�X�^�[�g����̃f�B���C������B
		if ( (idParam==211011) and (0==ai:GetNumber(2))) then
			ai:AddTopGoal( GOAL_COMMON_Wait, start_partner_delay, TARGET_NONE);
			ai:SetNumber(0, 2);
		end

		if eventNo == -1 then
			ai:AddTopGoal( GOAL_uroko_ThrowRock, 100);
		else
			ai:AddTopGoal( GOAL_COMMON_Wait, start_partner_delay, TARGET_NONE);
		end
	
	else
		-- �f�t�H���g�̌x���E�����B
		--������x���X�|���X���グ�邽�߁A�ҋ@�S�[�����Q�b�ŏI���悤�ɁB
		_COMMON_AddCautionAndFindGoal(ai, 2);
	end
end






