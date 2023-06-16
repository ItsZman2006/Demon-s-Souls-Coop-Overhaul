--[[********************************************************************************************
	【ウロコ鉱夫（積極攻撃型）】用戦闘
	説明：
	
	
	主な修正履歴：
	・08/7/24	hasem
		王城１奴隷兵士200000をたたき台にして、作成。
	・08/7/25   kitat
	　　攻撃周りの調整
	

	パラメータ0  なし
	パラメータ1  なし
	パラメータ2  なし
	パラメータ3　なし
**********************************************************************************************]]
REGISTER_GOAL(GOAL_uroko211008_Battle, "uroko211008Battle");


-- Updateでなにもやっていないので、呼ばないようにする
REGISTER_GOAL_NO_UPDATE( GOAL_uroko211008_Battle, true);


--[[*****************************************************
	起動。
*******************************************************]]
function uroko211008Battle_Activate(ai, goal)

	local targetDist 	= ai:GetDist(TARGET_ENE_0);		--敵ターゲットとの距離を取得

	
	local Att3300Per = 0		--超ジャンプ攻撃の確率
	local Att3003Per = 0		--遠ジャンプ攻撃の確率
	local Att3004Per = 0		--近ジャンプ攻撃の確率
	local AttNormalPer = 100	--近距離攻撃　　の確率	
	
	--距離別に確率を決める
	if targetDist >= 9.0 then
		Att3300Per = 75	
		Att3003Per = 10	
		Att3004Per = 10
		AttNormalPer = 5
		
	elseif targetDist >= 7.0 then
		Att3300Per = 0
		Att3003Per = 70
		Att3004Per = 20	
		AttNormalPer = 10
		
	elseif targetDist >= 2.0 then
		Att3300Per = 0
		Att3003Per = 0
		Att3004Per = 25
		AttNormalPer = 75	
		
	else
		Att3300Per = 0
		Att3003Per = 0
		Att3004Per = 0
		AttNormalPer = 100	
		
	end
	
	--移動
	uroko211008Battle_Approach( ai, goal, 2);
	
	
	--ジャンプ攻撃に最適な間合いの場合。。。
	local rangeJumpAttack_begin = 4;
	local rangeJumpAttack_end 	= 6;
	
	if ( (rangeJumpAttack_begin<targetDist) and (targetDist<rangeJumpAttack_end) ) then
		--大体前方にいたらジャンプ攻撃。
		if ( ai:IsInsideTargetEx(TARGET_SELF, TARGET_ENE_0, AI_DIR_TYPE_F, 45, 20) ) then
			goal:AddSubGoal(GOAL_COMMON_Attack2, 10.0, 3003, TARGET_ENE_0, DIST_Middle, 3);
		end
	else
		uroko211008Battle_Attack(ai, goal)
	end
	
	--攻撃後始末。
	uroko211008Battle_AfterAttack(ai, goal)

end

---------------------------------------------------------
--  攻撃
---------------------------------------------------------
function uroko211008Battle_Attack(ai, goal)

	local K_fate = ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字

	--50% 3000	
	--25% 3001
	--25% 3002
	
	if K_fate <= 50 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
	elseif K_fate <= 65 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);
	else
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3002, TARGET_ENE_0, DIST_Middle, 0);
	end
end
	
	
---------------------------------------------------------
--  攻撃後の行動
---------------------------------------------------------
function uroko211008Battle_AfterAttack(ai, goal)

	local KN_fate = ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字
	local SideTime = 1.0							--横に動く時間
	local BackDist = 1.0							--後退する距離
	local BackTime = 1.0							--後退する時間
	local bRight = ai:GetRandam_Int(0,1);			--右か左か
	-- 同じ方向に左右移動している仲間の数
	local friendNum = ai:GetTeamRecordCount(COORDINATE_TYPE_SideWalk_L+bRight, TARGET_ENE_0, 2.0);

	--85% 一呼吸	--10% 適当に横にガード移動	--5% 後ろにガード移動
	if KN_fate <= 85 then
		goal:AddSubGoal(GOAL_COMMON_Wait, ai:GetRandam_Float (0.5,1.0) ,0,0,0,0)
	elseif KN_fate <= 95 and friendNum < 1 then
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, SideTime, TARGET_ENE_0, bRight, ai:GetRandam_Int(30,45), true, true ,9910 );
	else
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, BackTime, TARGET_ENE_0, BackDist, TARGET_ENE_0, true, 9910 );				
	end
end

---------------------------------------------------------
--  接近。
---------------------------------------------------------
function uroko211008Battle_Approach(ai, goal, dist)
	goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, dist, TARGET_ENE_0, false, -1 );
end

	
	
--[[*****************************************************
	ゴールの更新・終了はなし。
*******************************************************]]
function uroko211008Battle_Update(ai, goal)	return GOAL_RESULT_Continue;end
function uroko211008Battle_Terminate(ai, goal)end


--[[*****************************************************
  割り込み
*******************************************************]]
function uroko211008Battle_Interupt(ai, goal)
	return false;
end


	