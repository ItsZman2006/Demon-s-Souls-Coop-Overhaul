--[[*******************************************************************************************
	�K�[�S�C����
	�����F
	
	��ai:SetNumber()�̎g�p�󋵁B
		�O�F�N���̈�ɓ��������H	�����Ă���O�ȊO�B
		�P�F�n��ڍs�^�C�}�A�ݒ�ς݂��H�@�O�ȊO�ŁA�ݒ�ς݁B
		�Q�F�n��ڍs���[�h�ɂȂ������H
		�R�F�N�����n��ړ����[�h�ɂȂ������H
		
	��ai:AddObserveRegion()�̎g�p�󋵁B
		�O�F�K�[�S�C���N���̈�
		�P�F
		�Q�F
		�R�F
		
	��ai:SetTimer()�̎g�p�󋵁B
		�O�F�n��ֈڍs�^�C�}�B
		�P�F
		�Q�F
		�R�F
		
*********************************************************************************************]]
REGISTER_LOGIC_FUNC(LOGIC_ID_Gagoiru305000, "Gagoiru305000_Logic", "Gagoiru305000_Interupt");

--[[********************************************************
	���W�b�N�B
**********************************************************]]
function	Gagoiru305000_Logic(ai)

--[[���������ځ�]]
	--�N���̈�̃C�x���gID�B
	local BOOTUP_REGION	= -1;
	
	local idThinkParam = ai:GetNpcThinkParamID();
	if 		(idThinkParam==305099) then		BOOTUP_REGION	= 2260;		--	���z�u���ɂ����𑝂₷�B
	elseif	(idThinkParam==305098) then		BOOTUP_REGION	= 2261;
	elseif	(idThinkParam==305097) then		BOOTUP_REGION	= 2262;
	elseif	(idThinkParam==305096) then		BOOTUP_REGION	= 2263;
	elseif	(idThinkParam==305095) then		BOOTUP_REGION	= 2264;
	elseif	(idThinkParam==305094) then		BOOTUP_REGION	= 2265;
	else									BOOTUP_REGION	= -1;
	end
--[[���������ځ�]]


	--�N���̈�Ď��B
	ai:AddObserveRegion(0, TARGET_ENE_0, BOOTUP_REGION);

	--�S�[���I���B
	--	�N���̈���ɓ����Ă��Ȃ��ꍇ�́A���ɂ����Ȃ��B�˗ׂ̐Α��Ɗ��Ⴂ������B
	if ( 0==ai:GetNumber(0) ) then
		ai:AddTopGoal(GOAL_COMMON_Wait, -1, TARGET_NONE);
	else
	
		--�n�ʂɏ���Ă��Ȃ�������A�܂��͗�������B
		if ( not(ai:IsLanding()) and (0==ai:GetNumber(3))) then
			ai:AddTopGoal( GOAL_Gagoiru305000_LandingOnGround, 10);
			ai:SetNumber(3, 1);
		end
		
		--�ʏ�ǂ���B
		COMMON_EasySetup3(ai);
	end

end

--[[********************************************************
	���荞�݁B
**********************************************************]]
function	Gagoiru305000_Interupt(ai, goal)

	--�̈抄�荞�݁B
	if ( ai:IsInterupt(INTERUPT_Inside_ObserveArea) ) then
		--�N���p�̈�ɓ��������H
		if ( ai:IsInsideObserveRegion (0) ) then
			ai:SetNumber(0, 1);
		end
	end

	--�_���[�W��H�������A�N���B
	if ( ai:IsInterupt(INTERUPT_Damaged) ) then
		ai:SetNumber(0, 1);
	end
	
end


