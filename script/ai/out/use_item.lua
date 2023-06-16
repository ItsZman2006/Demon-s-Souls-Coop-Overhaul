--[[*******************************************************************************************
	�A�C�e���g�p�B

	�p�����[�^0  �A�[�L�^�C�v�ʏ����p�����[�^.xls�̃A�C�e���p�����[�^�̏��ԁi�O����j
*********************************************************************************************]]
REGISTER_GOAL(GOAL_COMMON_UseItem, "UseItem");

-- �X�V�Ԋu�ݒ�
REGISTER_GOAL_NO_UPDATE(GOAL_COMMON_UseItem, true);
REGISTER_GOAL_NO_INTERUPT(GOAL_COMMON_UseItem, true);

REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_UseItem, 0, "�A�C�e���C���f�b�N�X", 	0);


--[[*****************************************************
	�S�[���J�n�B
*******************************************************]]
function UseItem_Activate(ai, goal)

	local item_index = goal:GetParam(0);
	
	--�A�C�e����؂�ւ��B
	ai:ChangeEquipItem( item_index);
	--�A�C�e���̎g�p�B
	goal:AddSubGoal( GOAL_COMMON_Attack, 5, NPC_ATK_Item, TARGET_NONE, DIST_None);
	
end

--[[*****************************************************
	�S�[���X�V
*******************************************************]]
function UseItem_Update(ai, goal) return GOAL_RESULT_Continue; end

--[[*****************************************************
	�S�[���I���B
*******************************************************]]
function UseItem_Terminate(ai, goal) end

--[[*********************
	���荞�݂Ȃ��B
***********************]]
function UseItem_Interupt(ai, goal)return false;end
