--[[*******************************************************************************************
	ターゲットの指定範囲内に近づく
	指定範囲に近づければ成功。


	パラメータ0  移動対象【Type】		(POINT)
	パラメータ1  到達判定距離【m】		この範囲内に入ったら成功
	パラメータ2  旋回対象【Type】		(TARGET)
	パラメータ3  歩くか					(true、false)
	パラメータ4  ガードEzState番号

	使用例
	-- ターゲット0の10m以内までガード移動する
	goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 寿命, TARGET_ENE_0, 10.0, TARGET_ENE_0, true, 6000 );
*********************************************************************************************]]
REGISTER_GOAL(GOAL_COMMON_ApproachTarget, "ApproachTarget");

REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_ApproachTarget, 0, "移動対象【Type】", 0);
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_ApproachTarget, 1, "到達判定距離【m】", 0);
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_ApproachTarget, 2, "旋回対象【Type】", 0);
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_ApproachTarget, 3, "歩く?", 0);
REGISTER_DBG_GOAL_PARAM(GOAL_COMMON_ApproachTarget, 4, "ガードEzState番号", 0);

-- 
REGISTER_GOAL_NO_UPDATE(GOAL_COMMON_ApproachTarget, true);
REGISTER_GOAL_NO_INTERUPT(GOAL_COMMON_ApproachTarget, true);

--[[******************************************************
	ゴール起動
********************************************************]]
function ApproachTarget_Activate(ai, goal)

	-- パラメータ取得
	local targetType 	= goal:GetParam(0);	-- 移動対象
	local range 		= goal:GetParam(1);	-- 到達判定距離
	local turnTarget 	= goal:GetParam(2);	-- 旋回対象
	local bWalk 		= goal:GetParam(3);	-- 歩くか
	local guardActionId = goal:GetParam(4);	-- ガードするか
	
	local life_time		= goal:GetLife();
	
	-- 移動サブゴール
	goal:AddSubGoal( GOAL_COMMON_MoveToSomewhere, life_time, 
						targetType, 
						AI_DIR_TYPE_CENTER,
						range,
						turnTarget,
						bWalk);
	

	if guardActionId > 0 then
	
		-- もうすでに到着距離にいる場合は、ガードしない。
		local targetDist = ai:GetDist(targetType);
		if (range < targetDist) then
			-- ガード行動
			ai:DoEzAction( life_time, guardActionId);
		end
	end
end

--[[******************************************************
	更新しない、割り込まない。ゴール終了で何もしない。
********************************************************]]
function ApproachTarget_Update(ai, goal, dT)end
function ApproachTarget_Terminate(ai, goal) end
function ApproachTarget_Interupt(ai, goal)	return false; end
