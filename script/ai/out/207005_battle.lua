-----------------------------------------------------------------------------------------------
--	虜囚戦闘
--	説明：牢城2の虜囚専用
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_Ryosyu207005_Battle, "Ryosyu207005Battle");


-- Updateでなにもやっていないので、呼ばないようにする
REGISTER_GOAL_NO_UPDATE( GOAL_Ryosyu207005_Battle, 1 );


---------------------------------------------------------
--  ゴール起動
---------------------------------------------------------
function Ryosyu207005Battle_Activate(ai, goal)
-------------------------------------------------------------------------------

	local hpRate 		= ai:GetHpRate( TARGET_SELF )		--自分のHP割合を取得
	local targetHpRate 	= ai:GetHpRate( TARGET_ENE_0 )	--敵ターゲットのHP割合を取得
	local targetDist 	= ai:GetDist(TARGET_ENE_0);		--敵ターゲットとの距離を取得
	local fate 			= ai:GetRandam_Int(1,100)					--確率判定で使用する運命の数字
	local fate2 		= ai:GetRandam_Int(1,100)					--確率判定で使用する運命の数字　その２
	
	if ( targetDist <= ai:GetDistParam( DIST_far ) ) then
		goal:AddSubGoal( GOAL_COMMON_Attack, 7, 3300, TARGET_NONE,DIST_None, 0 )
		goal:AddSubGoal( GOAL_COMMON_Wait, 3, TARGET_NONE);
	end
	
	
--~ 	-- 近距離
--~ 	if( targetDist <= ai:GetDistParam( DIST_Near ) ) then
--~ 			
--~ 			-- たまにお祈り
--~ 			if( fate2 <= 30 ) then
--~ 				goal:AddSubGoal( GOAL_COMMON_Attack, 7, 3300, TARGET_EVENT,DIST_None, 0 )
--~ 			
--~ 			-- プレイヤーの左右を走り回る
--~ 			elseif( fate2 <= 70) then
--~ 				goal:AddSubGoal( GOAL_COMMON_MoveToSomewhere, 3.0, TARGET_ENE_0, AI_DIR_TYPE_L, 0.5, TARGET_ENE_0, false );
--~ 				goal:AddSubGoal( GOAL_COMMON_MoveToSomewhere, 3.0, TARGET_ENE_0, AI_DIR_TYPE_R, 0.5, TARGET_ENE_0, false );
--~ 				
--~ 			else
--~ --				goal:AddSubGoal( GOAL_COMMON_WalkAround, 15, -1, 0, 0, 0 );
--~ 				goal:AddSubGoal( GOAL_COMMON_MoveToSomewhere, 15, TARGET_ENE_0, AI_DIR_TYPE_CENTER, 1, TARGET_ENE_0, false );
--~ 			end
--~ 			
--~ 			
--~ 			-- たまに攻撃
--~ 			if( fate <= 5 ) then
--~ 				goal:AddSubGoal( GOAL_COMMON_Attack, 7, 3000, TARGET_ENE_0, DIST_Near, 0 )
--~ 			end
--~ 			
--~ 	-- 中距離
--~ 	elseif( targetDist <= ai:GetDistParam( DIST_Middle ) ) then
--~ 		-- たまにお祈り
--~ 		if( fate2 <= 30 ) then
--~ 			goal:AddSubGoal( GOAL_COMMON_Attack, 7, 3300, TARGET_EVENT,DIST_None, 0 )
--~ 		end

--~ 		-- 歩いて追いかける
--~ 		if( fate <= 99 ) then
--~ --			goal:AddSubGoal( GOAL_COMMON_WalkAround, 15, -1, 0, 0, 0 );
--~ 			goal:AddSubGoal( GOAL_COMMON_MoveToSomewhere, 15, TARGET_ENE_0, AI_DIR_TYPE_CENTER, 1, TARGET_ENE_0, false );
--~ 		
--~ 		-- 稀にダッシュ
--~ 		else
--~ 			goal:AddSubGoal( GOAL_COMMON_MoveToSomewhere, 5, TARGET_EVENT, AI_DIR_TYPE_CENTER, 1, TARGET_EVENT, false );
--~ 			goal:AddSubGoal( GOAL_COMMON_Attack, 7, 3300, TARGET_EVENT,DIST_None, 0 )
--~ 			goal:AddSubGoal(GOAL_COMMON_BackToHome, 60, -1, 0, 0, 0 );
--~ 		end	
--~ 	
--~ 	-- 遠距離以上
--~ 	else
--~ 		-- たまにお祈り
--~ 		if( fate2 <= 20 ) then
--~ 			goal:AddSubGoal( GOAL_COMMON_Attack, 7, 3300, TARGET_EVENT,DIST_None, 0 )
--~ 		end
--~ 	
--~ 		-- 追いかける
--~ 		if( fate <= 90 ) then
--~ --			goal:AddSubGoal( GOAL_COMMON_WalkAround, 15, -1, 0, 0, 0 );
--~ 			goal:AddSubGoal( GOAL_COMMON_MoveToSomewhere, 15, TARGET_ENE_0, AI_DIR_TYPE_CENTER, 1, TARGET_ENE_0, false );
--~ 		
--~ 		-- 稀にダッシュ
--~ 		else
--~ 			goal:AddSubGoal( GOAL_COMMON_MoveToSomewhere, 5, TARGET_EVENT, AI_DIR_TYPE_CENTER, 1, TARGET_EVENT, false );
--~ 			goal:AddSubGoal( GOAL_COMMON_Attack, 7, 3300, TARGET_EVENT,DIST_None, 0 )
--~ 			goal:AddSubGoal(GOAL_COMMON_BackToHome, 60, -1, 0, 0, 0 );
--~ 		end	
--~ 	end


end

---------------------------------------------------------
--  ゴール更新
---------------------------------------------------------
function Ryosyu207005Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  ゴール終了
---------------------------------------------------------
function Ryosyu207005Battle_Terminate(ai, goal)
end



--~ ---------------------------------------------------------
--~ --  割り込み
--~ --	割り込んだ場合にはtrueを返してください。
--~ --	ここで割り込み用のサブゴールを追加してください。
--~ --	割り込まなかった場合には、1つ上の層のゴール、またはロジック部分によって割り込みが処理されます。
--~ ---------------------------------------------------------
--~ function Ryosyu207005Battle_Interupt(ai, goal)

--~ 	

--~ 	if( ai:IsInterupt( INTERUPT_FindAttack ) ) then
--~ 		local targetDist 	= ai:GetDist(TARGET_ENE_0);		--敵ターゲットとの距離を取得
--~ 		if( targetDist <= 2 ) then
--~ 			goal:ClearSubGoal();
--~ 			goal:AddSubGoal( GOAL_COMMON_Attack, 7, 3300, TARGET_ENE_0, DIST_Near, 0 )
--~ 		end
--~ 	end

--~ 	-- 攻撃された
--~ 	if( ai:IsInterupt( INTERUPT_Damaged ) ) then
--~ 		goal:ClearSubGoal();
--~ 		local dist = 5.0;
--~ 		-- 敵とは逆方向に逃げる
--~ 		goal:AddSubGoal( GOAL_COMMON_MoveToSomewhere, 8, TARGET_ENE_0, AI_DIR_TYPE_F, dist, TARGET_SELF, false );
--~ 		
--~ 		-- 初期位置に戻る
--~ 		goal:AddSubGoal( GOAL_COMMON_PathMovePoint, 5, POINT_INITIAL, AI_DIR_TYPE_CENTER, 1.0, TARGET_SELF, true );

--~ 		-- お祈り
--~ 		goal:AddSubGoal( GOAL_COMMON_Attack, 7, 3300, TARGET_EVENT,DIST_None, 0 )
--~ 		
--~ 		return true;
--~ 	elseif( ai:IsInterupt( INTERUPT_Damaged_Stranger ) ) then
--~ 		goal:ClearSubGoal();
--~ 		local dist = 5.0;
--~ 		-- 敵とは逆方向に逃げる
--~ 		goal:AddSubGoal( GOAL_COMMON_MoveToSomewhere, 8, TARGET_ENE_0, AI_DIR_TYPE_F, dist, TARGET_SELF, false );
--~ 		
--~ 		-- 初期位置に戻る
--~ 		goal:AddSubGoal( GOAL_COMMON_PathMovePoint, 5, POINT_INITIAL, AI_DIR_TYPE_CENTER, 1.0, TARGET_SELF, true );

--~ 		-- お祈り
--~ 		goal:AddSubGoal( GOAL_COMMON_Attack, 7, 3300, TARGET_EVENT,DIST_None, 0 )
--~ 		
--~ 		return true;
--~ 	end
--~ 	

--~ 	return false;
--~ end	

