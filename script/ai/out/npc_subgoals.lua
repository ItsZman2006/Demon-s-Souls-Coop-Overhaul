--[[*******************************************************************************************
	ダッシュ攻撃。


	パラメータ0  移動対象			【Type】"		(POINT)
	パラメータ1  攻撃開始距離		【m】		この範囲内に入ったら成功
	パラメータ2  攻撃EzState番号
	パラメータ3  ガードEzState番号

	使用例
	-- ターゲット0の10m以内までガード移動する
	goal:AddSubGoal( GOAL_COMMON_DashAttack, 寿命, TARGET_ENE_0, 10.0, NPC_ATK_NormalR, -1);
*********************************************************************************************]]
REGISTER_GOAL(GOAL_COMMON_DashAttack, "DashAttack");

REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_DashAttack, 0, "移動対象【Type】", 0);
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_DashAttack, 1, "攻撃開始距離【m】", 0);
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_DashAttack, 2, "攻撃EzState番号", 0);
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_DashAttack, 3, "ガードEzState番号", 0);

-- 
REGISTER_GOAL_NO_UPDATE(GOAL_COMMON_DashAttack, true);
REGISTER_GOAL_NO_INTERUPT(GOAL_COMMON_DashAttack, true);

--[[******************************************************
	ゴール起動
********************************************************]]
function DashAttack_Activate(ai, goal)

	--ダッシュ開始。
	ai:StartDash();
	
	--まずは、接近。
	--	この接近ゴールが成功したら、次の攻撃ゴールへ移る。
	
	local target 		= goal:GetParam(0);
	local arrive_range 	= goal:GetParam(1);
	local guard_ezno	= goal:GetParam(3);
	
	goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10, target, arrive_range, TARGET_SELF, false, guard_ezno);

	
	--攻撃。
	
	local attack_ezno	= goal:GetParam(2);
	goal:AddSubGoal(GOAL_COMMON_DashAttack_Attack, 10, target, attack_ezno);
	
	
end


--[[******************************************************
	終了。
********************************************************]]
function DashAttack_Terminate(ai, goal) 

	--ダッシュやめる。
	ai:EndDash();

end

--[[******************************************************
	更新しない、割り込まない。
********************************************************]]
function DashAttack_Update(ai, goal, dT) return GOAL_RESULT_Continue; end
function DashAttack_Interupt(ai, goal)	return false; end


--[[************************************************************************************
	ダッシュ攻撃。
		攻撃を出すときも、移動入力がされていないと駄目みたい。
		なので、移動＋攻撃をやる。
		ai:MoveTo()をやっているのは、攻撃している時間が短いだろうから、
		パスを検索する必要は無いと踏んでの事。
**************************************************************************************]]
REGISTER_GOAL(GOAL_COMMON_DashAttack_Attack, "DashAttack_Attack");
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_DashAttack_Attack, 0, "移動対象【Type】", 0);
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_DashAttack_Attack, 1, "攻撃EzState番号", 0);
REGISTER_GOAL_NO_UPDATE(GOAL_COMMON_DashAttack_Attack, true);
REGISTER_GOAL_NO_INTERUPT(GOAL_COMMON_DashAttack_Attack, true);

function DashAttack_Attack_Activate(ai, goal)
	local target 		= goal:GetParam(0);
	local attack_ezno	= goal:GetParam(1);
	ai:MoveTo(target, AI_DIR_TYPE_CENTER, 0, false);
	goal:AddSubGoal(GOAL_COMMON_Attack, 10, attack_ezno, target, DIST_None);
end
function DashAttack_Attack_Update(ai, goal)  return GOAL_RESULT_Continue; end
function DashAttack_Attack_Terminate(ai, goal)end
function DashAttack_Attack_Interupt(ai, goal) return false; end

