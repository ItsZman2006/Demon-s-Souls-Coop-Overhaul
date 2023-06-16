--[[*******************************************************************************************
	汎用結晶トカゲ用戦闘
	説明：
		・逃げて一定時間したら消える。
		・逃げている最中にダメージを受けたら、最初から。
		
	●ai:SetNumber()の使用状況。
		０：０以外ですでに隠れている。
		
*********************************************************************************************]]
REGISTER_GOAL(GOAL_tokage311010_Battle, "tokage311010Battle");
REGISTER_GOAL_NO_UPDATE( GOAL_tokage311010_Battle, true);
--REGISTER_GOAL_NO_INTERUPT( GOAL_tokage311010_Battle, true);

--[[*****************************************************
	起動。
*******************************************************]]
function tokage311010Battle_Activate(ai, goal)

--[[■調整項目■]]

	--逃げる時間[sec]。
	local RUNAWAY_LIFETIME	= 6;

--[[■調整項目■]]

	if ( 0==ai:GetNumber(0) ) then
		goal:AddSubGoal(GOAL_tokage311010_Runaway, RUNAWAY_LIFETIME);
	end
	goal:AddSubGoal(GOAL_tokage311010_Hide, 10);
end

	
--[[*****************************************************
	更新・終了・割り込み。
*******************************************************]]
function tokage311010Battle_Update(ai, goal) return GOAL_RESULT_Continue; end
function tokage311010Battle_Terminate(ai, goal) end
function tokage311010Battle_Interupt(ai, goal)

	--ダメージを食らった。
	if ( ai:IsInterupt(INTERUPT_Damaged) or ai:IsInterupt(INTERUPT_Damaged_Stranger) ) then
		--リプランニング.
		ai:Replaning();
		--隠れましたフラグを戻す。
		ai:SetNumber(0,0);
	end
	
	return false;
end




--[[*****************************************************************************]]
--[[******************************** サブゴール *********************************]]
--[[*****************************************************************************]]


--[[*****************************************************
	逃げる。
*******************************************************]]
REGISTER_GOAL(GOAL_tokage311010_Runaway, "tokage311010Runaway");
--~ REGISTER_GOAL_NO_UPDATE(GOAL_tokage311010_Runaway, true);
REGISTER_GOAL_NO_INTERUPT(GOAL_tokage311010_Runaway, true);

function tokage311010Runaway_Activate(ai, goal)
	local life_time = goal:GetLife();
	goal:AddSubGoal(GOAL_COMMON_LeaveTarget, life_time, TARGET_ENE_0, 100.0, TARGET_SELF, false, -1 );
end

function tokage311010Runaway_Update(ai, goal)

	--サブゴールが失敗しても必ず成功。
	if ( goal:GetLastSubGoalResult() == GOAL_RESULT_Failed ) then
		return GOAL_RESULT_Success
	end
	
	return GOAL_RESULT_Continue;
end
function tokage311010Runaway_Terminate(ai, goal) end

function tokage311010Runaway_Interupt(ai, goal) return false; end


--[[*****************************************************
	隠れる。（ずっと）
*******************************************************]]
REGISTER_GOAL(GOAL_tokage311010_Hide, "tokage311010Hide");
REGISTER_GOAL_NO_UPDATE(GOAL_tokage311010_Hide, true);
REGISTER_GOAL_NO_INTERUPT(GOAL_tokage311010_Hide, true);

function tokage311010Hide_Activate(ai, goal)
	
	--隠れる(攻撃)。
	--ai:StartGuard(3301);
	-- ガードにするとずっと出続けるので単独攻撃に変更
	goal:AddSubGoal(GOAL_COMMON_NonspinningAttack, 10.0,3301, TARGET_EVENT, DIST_None, 0);

	--とりあえず、まち。
	local life_time = goal:GetLife();
	goal:AddSubGoal(GOAL_COMMON_Wait, life_time, TARGET_ENE_0);
	
	--隠れましたフラグを立てる。
	ai:SetNumber(0,1);
	
end

function tokage311010Hide_Update(ai, goal) return GOAL_RESULT_Continue; end
function tokage311010Hide_Terminate(ai, goal) end
function tokage311010Hide_Interupt(ai, goal) return false; end




