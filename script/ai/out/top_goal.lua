--[[*******************************************************************************************
--	一番上になるゴール
--	説明：プログラムから直接よびだされます。
--		  このゴール自体は特になにもしません。
--
--	パラメータ0  なし
--	パラメータ1  なし
--	パラメータ2  なし
--	パラメータ3　なし
*********************************************************************************************]]
REGISTER_GOAL(GOAL_COMMON_TopGoal, "TopGoal");


-- Updateでなにもやっていないので、呼ばないようにする
REGISTER_GOAL_NO_UPDATE( GOAL_COMMON_TopGoal, 1 );
--割込みだけ。
function TopGoal_Activate(ai, goal)end
function TopGoal_Update(ai, goal) return GOAL_RESULT_Continue; end
function TopGoal_Terminate(ai, goal)end


--[[*****************************************************
--  割り込み
*******************************************************]]
function TopGoal_Interupt(ai, goal)
	if ( ai:IsInterupt( INTERUPT_CANNOT_MOVE)) then

		--アクション。
		local idAction = ai:GetExcelParam(AI_EXCEL_THINK_PARAM_TYPE__CannotMoveAction);

		--破壊可能なオブジェクトに接触して動けなくなっている場合、
		--破壊して先に進む。
		if ( ai:IsTouchBreakableObject() and (0<=idAction) ) then
		
			--引っかかったOBJが正面にあれば。。。
			if ( ai:IsLookToTarget(POINT_CurrRequestPosition, 90) ) then
				--エクセルに設定してあるアクションを追加。
				goal:ClearSubGoal();
				goal:AddSubGoal( GOAL_COMMON_NonspinningAttack, -1, idAction, TARGET_NONE, DIST_None);
				return true;
			end
		end
	end
	
	-- 割り込み無効中にのみ呼ばれる障害物検出
	-- バグ対策
	if ( ai:IsInterupt( INTERUPT_CANNOT_MOVE_DisableInterupt)) then

		--アクション。
		local idAction = ai:GetExcelParam(AI_EXCEL_THINK_PARAM_TYPE__CannotMoveAction);

		--破壊可能なオブジェクトに接触して動けなくなっている場合、
		--破壊して先に進む。
		if ( ai:IsTouchBreakableObject() and (0<=idAction) ) then
		
			--引っかかったOBJが正面にあれば。。。
			if ( ai:IsLookToTarget(POINT_CurrRequestPosition, 90) ) then
				--エクセルに設定してあるアクションを追加。
				--goal:ClearSubGoal();
				--goal:AddSubGoal( GOAL_COMMON_NonspinningAttack, -1, idAction, TARGET_NONE, DIST_None);
				-- 先頭ゴールに割り込み追加することで、今まで実行していたものを保持する。
				goal:AddSubGoal_Front( GOAL_COMMON_NonspinningAttack, -1, idAction, TARGET_NONE, DIST_None);
				return true;
			end
		end
	end
	
	
	--敵壁に接触している。
	if ( ai:IsInterupt(INTERUPT_HitEnemyWall) ) then
	
		local backhome_life	= ai:GetExcelParam(AI_EXCEL_THINK_PARAM_TYPE__BackHomeLife_OnHitEnemyWall);
		if ( 0 < backhome_life ) then
			--問答無用で一定時間、自宅に帰ります。
			goal:ClearSubGoal();
			goal:AddSubGoal(GOAL_COMMON_BackToHome, backhome_life, 0);
			return true;
		end
	end
	
	return false;
end
