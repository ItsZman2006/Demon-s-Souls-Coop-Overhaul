-----------------------------------------------------------------------------------------------
--	Namekuji307100��p�퓬
--	�����F
--
--	�p�����[�^0  �Ȃ�
--	�p�����[�^1  �Ȃ�
--	�p�����[�^2  �Ȃ�
--	�p�����[�^3�@�Ȃ�
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_Namekuji307100_Battle, "Namekuji307100Battle");


-- Update�łȂɂ�����Ă��Ȃ��̂ŁA�Ă΂Ȃ��悤�ɂ���
REGISTER_GOAL_NO_UPDATE( GOAL_Namekuji307100_Battle, 1 );


---------------------------------------------------------
--  �S�[���N��
---------------------------------------------------------
function Namekuji307100Battle_Activate(ai, goal)
-------------------------------------------------------------------------------

local targetDist = ai:GetDist(TARGET_ENE_0);			--�G�^�[�Q�b�g�Ƃ̋������擾
local fate1 = ai:GetRandam_Int(1,100)					--�m������Ŏg�p����^���̐���	
local fate2 = ai:GetRandam_Int(1,100)
local fate3 = ai:GetRandam_Int(1,100)
local fate4 = ai:GetRandam_Int(1,100)

local Att3000_Dist_min = 0.0					--3000�Ԃ̓K���ԍ����i�ŏ��j
local Att3000_Dist_max = 1.5					--3000�Ԃ̓K���ԍ����i�ő�j
local Att3002_Dist_min = 0.0					--3002�Ԃ̓K���ԍ����i�ŏ��j
local Att3002_Dist_max = 3.0					--3002�Ԃ̓K���ԍ����i�ő�j
local Att3003_Dist_min = 0.0					--3003�Ԃ̓K���ԍ����i�ŏ��j
local Att3003_Dist_max = 5.0					--3003�Ԃ̓K���ԍ����i�ő�j

local Act01Per = 0		--���s�����ݕt��
local Act02Per = 0		--���s����ъ|��
local Act03Per = 0		--���s�����S�t

	--�i���N�W�I�ɉ����Ȃ�
	if targetDist >= 4.0 then
		Act01Per = 0		--���s�����ݕt��
		Act02Per = 5		--���s����ъ|��
		Act03Per = 95		--���s�����S�t
		
	--�i���N�W�I�ɂ�≓���Ȃ�	
	elseif targetDist >= 2.0 then
		Act01Per = 5		--���s�����ݕt��
		Act02Per = 35		--���s����ъ|��
		Act03Per = 60		--���s�����S�t
		
	--�����Ƌ߂��Ȃ�
	else
		Act01Per = 20		--���s�����ݕt��
		Act02Per = 20		--���s����ъ|��
		Act03Per = 60		--���s�����S�t
	end

	--�s��01�@���s�����ݕt��
	if fate2 <= Act01Per then
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3000_Dist_max, TARGET_ENE_0, true, -1 );
		goal:AddSubGoal(GOAL_COMMON_Attack2, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
		
	--�s��02�@���s����ъ|��
	elseif fate2 <= (Act01Per + Act02Per) then
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3002_Dist_max, TARGET_ENE_0, true, -1 );
		goal:AddSubGoal(GOAL_COMMON_Attack2, 10.0, 3002, TARGET_ENE_0, DIST_Middle, 0);
		
	--�s��03�@���s�����S�t
	else
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, Att3003_Dist_max, TARGET_ENE_0, true, -1 );
		goal:AddSubGoal(GOAL_COMMON_Attack2, 10.0, 3003, TARGET_ENE_0, DIST_Middle, 0);	
	end
	goal:AddSubGoal(GOAL_COMMON_Wait, ai:GetRandam_Float (2.0,4.0) ,0,0,0,0)

	
end

---------------------------------------------------------
--  �S�[���X�V
---------------------------------------------------------
function Namekuji307100Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  �S�[���I��
---------------------------------------------------------
function Namekuji307100Battle_Terminate(ai, goal)
end


---------------------------------------------------------
--  ���荞��
--	���荞�񂾏ꍇ�ɂ�true��Ԃ��Ă��������B
--	�����Ŋ��荞�ݗp�̃T�u�S�[����ǉ����Ă��������B
--	���荞�܂Ȃ������ꍇ�ɂ́A1��̑w�̃S�[���A�܂��̓��W�b�N�����ɂ���Ċ��荞�݂���������܂��B
---------------------------------------------------------
function Namekuji307100Battle_Interupt(ai, goal)

return false;

end
