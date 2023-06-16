--[[*******************************************************************************************
	岩石ミミズ用戦闘
	説明：

	パラメータ0  なし
	パラメータ1  なし
	パラメータ2  なし
	パラメータ3　なし
*********************************************************************************************]]
REGISTER_GOAL(GOAL_mimizu310000_Battle, "mimizu310000_Battle");

REGISTER_GOAL_NO_UPDATE( GOAL_mimizu310000_Battle, true);
REGISTER_GOAL_NO_INTERUPT( GOAL_mimizu310000_Battle, true);

--[[*************************************************************
	ゴール起動
***************************************************************]]
function mimizu310000_Battle_Activate(ai, goal)

	--とりあえず、ターゲットを正面に捕らえようとする。
	goal:AddSubGoal( GOAL_COMMON_Turn, 1, TARGET_ENE_0);

	--攻撃前ため。
	local wait_before_attack = ai:GetRandam_Float( 0, 2);
	goal:AddSubGoal( GOAL_COMMON_Wait, wait_before_attack, TARGET_ENE_0);
	
	--攻撃する
	local idNpcThinkParam = ai:GetNpcThinkParamID();
	if ( idNpcThinkParam==310001 ) then 
		--溶岩シャワーだしまくり。
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3002, TARGET_ENE_0, DIST_None, 0);
		goal:AddSubGoal( GOAL_COMMON_Wait, 0.8, TARGET_ENE_0);
	else
		--通常攻撃
		mimizu310000_Battle_Attack(ai, goal)
	end
end

---------------------------------------------------------
--  攻撃
---------------------------------------------------------
function mimizu310000_Battle_Attack(ai, goal)

	local targetDist 	= ai:GetDist(TARGET_ENE_0);			--敵ターゲットとの距離を取得
	local NEAR_DIST 	= ai:GetDistParam( DIST_Near);
	local fate   	  = ai:GetRandam_Int(1,100)				--確率判定で使用する運命の数字
	local idNpcThinkParam = ai:GetNpcThinkParamID();		--NPCのIDを取得

	if ( targetDist<=NEAR_DIST ) then
		--近距離攻撃。
		--35% 噛み付き
		--35% 薙ぎ払い
		--30% 飲み込み
		if fate <= 35 then
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Near, 0);
		elseif fate <= 70 then
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3004, TARGET_ENE_0, DIST_Near, 0);
		else
			if ( idNpcThinkParam~=310002 ) then 	
				goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3003, TARGET_ENE_0, DIST_Near, 0);
			else
				goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3004, TARGET_ENE_0, DIST_Near, 0);				
			end
		end
		
	else
		--遠距離攻撃。
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_None, 0);
	end

end


	
--[[*************************************************************
	ゴール更新・終了・割り込みはなし。
***************************************************************]]
function mimizu310000_Battle_Update(ai, goal) return GOAL_RESULT_Continue; end
function mimizu310000_Battle_Terminate(ai, goal) end
function mimizu310000_Battle_Interupt(ai, goal) return false; end





			


	