--[[*******************************************************************************************
	�y��z�p�퓬
	�����F

	����ȕύX����
		��̍U�����s�v�ɂȂ����̂ŁA�U��������폜�B 08/8/3 hasem
	
	�p�����[�^0  �Ȃ�
	�p�����[�^1  �Ȃ�
	�p�����[�^2  �Ȃ�
	�p�����[�^3�@�Ȃ�
*********************************************************************************************]]
REGISTER_GOAL(GOAL_Taka303000_Battle, "taka303000Battle");


-- Update�łȂɂ�����Ă��Ȃ��̂ŁA�Ă΂Ȃ��悤�ɂ���
REGISTER_GOAL_NO_UPDATE( GOAL_Taka303000_Battle, true);
REGISTER_GOAL_NO_INTERUPT( GOAL_Taka303000_Battle, true);


--[[*****************************************************
	�S�[���N��
*******************************************************]]
function taka303000Battle_Activate(ai, goal)

	local fate 			= ai:GetRandam_Int(1,100)		--�m������Ŏg�p����^���̐���
	local fate2 		= ai:GetRandam_Int(1,100)		--�m������Ŏg�p����^���̐����@���̂Q
	local fate3 		= ai:GetRandam_Int(1,100)		--�m������Ŏg�p����^���̐����@���̂R
	
	--���̃|�C���g�Ɉړ�
	taka303000Battle_MoveToNext(goal);

	--10���@���̃|�C���g�Ɉړ�
	if (fate  <= 10) then	taka303000Battle_MoveToNext(goal);	end
	if (fate2 <= 10) then	taka303000Battle_MoveToNext(goal);	end
	if (fate3 <= 10) then	taka303000Battle_MoveToNext(goal);	end

end

---------------------------------------------------------
--  ���̈ʒu�B
---------------------------------------------------------
function taka303000Battle_MoveToNext(goal)
	goal:AddSubGoal(GOAL_COMMON_MoveToSomewhere, 20.0, POINT_MOVE_POINT, AI_DIR_TYPE_CENTER, 7.0, TARGET_SELF, true);
end

--[[*****************************************************
	�S�[���X�V�E�I��
*******************************************************]]
function taka303000Battle_Update(ai, goal) return GOAL_RESULT_Continue; end
function taka303000Battle_Terminate(ai, goal) end
function taka303000Battle_Interupt(ai, goal) return false; end

