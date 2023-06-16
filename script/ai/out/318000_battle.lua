--[[*******************************************************************************************
	Chidani318000専用戦闘
	説明：
		満腹状態から攻撃されてしぼんでからAIが回り始める。
		それまは、イベントでAIがOFFになっている。
		なので、AIは、逃げるだけ。
*********************************************************************************************]]
REGISTER_GOAL(GOAL_Chidani318000_Battle, "Chidani318000Battle");
REGISTER_GOAL_NO_UPDATE(GOAL_Chidani318000_Battle, true);
REGISTER_GOAL_NO_INTERUPT(GOAL_Chidani318000_Battle, true);

--[[*****************************************************
	ゴール起動
*******************************************************]]
function Chidani318000Battle_Activate(ai, goal)

--[[■調整項目■]]
	
	--逃げる距離
	local RUNAWAY_DIST	= 10;

--[[■調整項目■]]

	--ひたすら逃げる。
	goal:AddSubGoal(GOAL_COMMON_LeaveTarget, 10, TARGET_ENE_0, RUNAWAY_DIST, TARGET_SELF, false, -1);
end



--[[*****************************************************
	更新・終了・割り込み。
*******************************************************]]
function Chidani318000Battle_Update(ai, goal)return GOAL_RESULT_Continue;end
function Chidani318000Battle_Terminate(ai, goal)end
function Chidani318000Battle_Interupt(ai, goal)return false;end
