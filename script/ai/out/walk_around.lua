-----------------------------------------------------------------------------------------------
--	うろうろ行動
--	説明：初期位置を中心にうろうろとする行動
--
--	パラメータ0  なし
--	パラメータ1  なし
--	パラメータ2  なし
--	パラメータ3　なし
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_COMMON_WalkAround, "WalkAround");




---------------------------------------------------------
--  ゴール起動
---------------------------------------------------------
function WalkAround_Activate(ai, goal)
	
	-- パラメータ取得
	-- 敵に反応する距離
	local attackDist = goal:GetParam(0);
	
	-- 旋回方向(0:右回り, 1:左回り)
	local turnDir = ai:GetRandam_Int(0, 1);
	-- 歩く円の半径
	local dist = 1.5;	
	-- 歩くか
	local walk = 1;	
	-- 寿命
	local life = 10.0;

	if turnDir == 0 then
		-- 右回り
		
		-- 初期位置の前に移動
		goal:AddSubGoal(GOAL_COMMON_MoveToSomewhere, life, POINT_INITIAL, AI_DIR_TYPE_F, dist, TARGET_SELF, walk);
		-- 初期位置の右に移動
		goal:AddSubGoal(GOAL_COMMON_MoveToSomewhere, life, POINT_INITIAL, AI_DIR_TYPE_R, dist, TARGET_SELF, walk);
		-- 初期位置の後に移動
		goal:AddSubGoal(GOAL_COMMON_MoveToSomewhere, life, POINT_INITIAL, AI_DIR_TYPE_B, dist, TARGET_SELF, walk);
		-- 初期位置の左に移動
		goal:AddSubGoal(GOAL_COMMON_MoveToSomewhere, life, POINT_INITIAL, AI_DIR_TYPE_L, dist, TARGET_SELF, walk);
	else
		-- 左回り
		
		-- 初期位置の後に移動
		goal:AddSubGoal(GOAL_COMMON_MoveToSomewhere, life, POINT_INITIAL, AI_DIR_TYPE_B, dist, TARGET_SELF, walk);
		-- 初期位置の左に移動
		goal:AddSubGoal(GOAL_COMMON_MoveToSomewhere, life, POINT_INITIAL, AI_DIR_TYPE_L, dist, TARGET_SELF, walk);
		-- 初期位置の前に移動
		goal:AddSubGoal(GOAL_COMMON_MoveToSomewhere, life, POINT_INITIAL, AI_DIR_TYPE_F, dist, TARGET_SELF, walk);
		-- 初期位置の右に移動
		goal:AddSubGoal(GOAL_COMMON_MoveToSomewhere, life, POINT_INITIAL, AI_DIR_TYPE_R, dist, TARGET_SELF, walk);
	end

	-- 初期位置に移動
--	goal:AddSubGoal(GOAL_COMMON_MoveToSomewhere, life, POINT_INITIAL, AI_DIR_TYPE_CENTER, 1.0, TARGET_SELF, walk);
end


---------------------------------------------------------
--  ゴール更新
---------------------------------------------------------
function WalkAround_Update(ai, goal)
	
	-- パラメータ取得
	-- 敵に反応する距離
	local attackDist = goal:GetParam(0);
	
	if ai:IsSearchTarget(TARGET_ENE_0) == true then
		if ai:GetDist(TARGET_ENE_0) < attackDist then
			return GOAL_RESULT_Failed;
		end
	end
	
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  ゴール終了
---------------------------------------------------------
function WalkAround_Terminate(ai, goal)
end


---------------------------------------------------------
--  割り込み
--	割り込んだ場合にはtrueを返してください。
--	ここで割り込み用のサブゴールを追加してください。
--	割り込まなかった場合には、1つ上の層のゴール、またはロジック部分によって割り込みが処理されます。
---------------------------------------------------------
function WalkAround_Interupt(ai, goal)
	return false;
end
