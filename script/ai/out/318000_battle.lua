--[[*******************************************************************************************
	Chidani318000��p�퓬
	�����F
		������Ԃ���U������Ă��ڂ�ł���AI�����n�߂�B
		����܂́A�C�x���g��AI��OFF�ɂȂ��Ă���B
		�Ȃ̂ŁAAI�́A�����邾���B
*********************************************************************************************]]
REGISTER_GOAL(GOAL_Chidani318000_Battle, "Chidani318000Battle");
REGISTER_GOAL_NO_UPDATE(GOAL_Chidani318000_Battle, true);
REGISTER_GOAL_NO_INTERUPT(GOAL_Chidani318000_Battle, true);

--[[*****************************************************
	�S�[���N��
*******************************************************]]
function Chidani318000Battle_Activate(ai, goal)

--[[���������ځ�]]
	
	--�����鋗��
	local RUNAWAY_DIST	= 10;

--[[���������ځ�]]

	--�Ђ����瓦����B
	goal:AddSubGoal(GOAL_COMMON_LeaveTarget, 10, TARGET_ENE_0, RUNAWAY_DIST, TARGET_SELF, false, -1);
end



--[[*****************************************************
	�X�V�E�I���E���荞�݁B
*******************************************************]]
function Chidani318000Battle_Update(ai, goal)return GOAL_RESULT_Continue;end
function Chidani318000Battle_Terminate(ai, goal)end
function Chidani318000Battle_Interupt(ai, goal)return false;end
