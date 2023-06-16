--[[*******************************************************************************************
	�ėp�����g�J�Q�p�퓬
	�����F
		�E�����Ĉ�莞�Ԃ����������B
		�E�����Ă���Œ��Ƀ_���[�W���󂯂���A�ŏ�����B
		
	��ai:SetNumber()�̎g�p�󋵁B
		�O�F�O�ȊO�ł��łɉB��Ă���B
		
*********************************************************************************************]]
REGISTER_GOAL(GOAL_tokage311010_Battle, "tokage311010Battle");
REGISTER_GOAL_NO_UPDATE( GOAL_tokage311010_Battle, true);
--REGISTER_GOAL_NO_INTERUPT( GOAL_tokage311010_Battle, true);

--[[*****************************************************
	�N���B
*******************************************************]]
function tokage311010Battle_Activate(ai, goal)

--[[���������ځ�]]

	--�����鎞��[sec]�B
	local RUNAWAY_LIFETIME	= 6;

--[[���������ځ�]]

	if ( 0==ai:GetNumber(0) ) then
		goal:AddSubGoal(GOAL_tokage311010_Runaway, RUNAWAY_LIFETIME);
	end
	goal:AddSubGoal(GOAL_tokage311010_Hide, 10);
end

	
--[[*****************************************************
	�X�V�E�I���E���荞�݁B
*******************************************************]]
function tokage311010Battle_Update(ai, goal) return GOAL_RESULT_Continue; end
function tokage311010Battle_Terminate(ai, goal) end
function tokage311010Battle_Interupt(ai, goal)

	--�_���[�W��H������B
	if ( ai:IsInterupt(INTERUPT_Damaged) or ai:IsInterupt(INTERUPT_Damaged_Stranger) ) then
		--���v�����j���O.
		ai:Replaning();
		--�B��܂����t���O��߂��B
		ai:SetNumber(0,0);
	end
	
	return false;
end




--[[*****************************************************************************]]
--[[******************************** �T�u�S�[�� *********************************]]
--[[*****************************************************************************]]


--[[*****************************************************
	������B
*******************************************************]]
REGISTER_GOAL(GOAL_tokage311010_Runaway, "tokage311010Runaway");
--~ REGISTER_GOAL_NO_UPDATE(GOAL_tokage311010_Runaway, true);
REGISTER_GOAL_NO_INTERUPT(GOAL_tokage311010_Runaway, true);

function tokage311010Runaway_Activate(ai, goal)
	local life_time = goal:GetLife();
	goal:AddSubGoal(GOAL_COMMON_LeaveTarget, life_time, TARGET_ENE_0, 100.0, TARGET_SELF, false, -1 );
end

function tokage311010Runaway_Update(ai, goal)

	--�T�u�S�[�������s���Ă��K�������B
	if ( goal:GetLastSubGoalResult() == GOAL_RESULT_Failed ) then
		return GOAL_RESULT_Success
	end
	
	return GOAL_RESULT_Continue;
end
function tokage311010Runaway_Terminate(ai, goal) end

function tokage311010Runaway_Interupt(ai, goal) return false; end


--[[*****************************************************
	�B���B�i�����Ɓj
*******************************************************]]
REGISTER_GOAL(GOAL_tokage311010_Hide, "tokage311010Hide");
REGISTER_GOAL_NO_UPDATE(GOAL_tokage311010_Hide, true);
REGISTER_GOAL_NO_INTERUPT(GOAL_tokage311010_Hide, true);

function tokage311010Hide_Activate(ai, goal)
	
	--�B���(�U��)�B
	--ai:StartGuard(3301);
	-- �K�[�h�ɂ���Ƃ����Əo������̂ŒP�ƍU���ɕύX
	goal:AddSubGoal(GOAL_COMMON_NonspinningAttack, 10.0,3301, TARGET_EVENT, DIST_None, 0);

	--�Ƃ肠�����A�܂��B
	local life_time = goal:GetLife();
	goal:AddSubGoal(GOAL_COMMON_Wait, life_time, TARGET_ENE_0);
	
	--�B��܂����t���O�𗧂Ă�B
	ai:SetNumber(0,1);
	
end

function tokage311010Hide_Update(ai, goal) return GOAL_RESULT_Continue; end
function tokage311010Hide_Terminate(ai, goal) end
function tokage311010Hide_Interupt(ai, goal) return false; end




