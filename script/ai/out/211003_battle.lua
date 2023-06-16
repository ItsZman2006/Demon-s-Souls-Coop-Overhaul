--[[********************************************************************************************
	【ウロコ鉱夫（積極攻撃型）】用戦闘
	説明：
		大剣・小剣共通戦闘ゴール。
	
	主な修正履歴：
	・08/7/25   kitat
	　　211008からコピー
	・08/7/31	hasem
		チーム概念を追加。

	パラメータ0  なし
	パラメータ1  なし
	パラメータ2  なし
	パラメータ3　なし
**********************************************************************************************]]
REGISTER_GOAL(GOAL_urokoLS211003_Battle, "uroko211003Battle");


-- Updateでなにもやっていないので、呼ばないようにする
REGISTER_GOAL_NO_UPDATE( GOAL_urokoLS211003_Battle, true);
REGISTER_GOAL_NO_INTERUPT( GOAL_urokoLS211003_Battle, true);


--[[*****************************************************
	起動。
*******************************************************]]
function uroko211003Battle_Activate(ai, goal)

--[[■企画調整項目■]]
	
	--岩投げサポート役として認識する岩投げ鉱夫までの距離。
	local RANGE_IWANAGE_SUPPORT_TEAMMATE = 30;
	
--[[■企画調整項目■]]

	local targetDist 	= ai:GetDist(TARGET_ENE_0);		--敵ターゲットとの距離を取得
	local role 			= ai:GetTeamOrder(ORDER_TYPE_Role);			--自分の役割を取得

	-- 最初にちょっとだけ待つ
	if ai:IsFinishTimer(0) == true then
		local firstTime = ai:GetRandam_Float(0.0, 1.0)			--最初の動き出しまでの時間
		goal:AddSubGoal(GOAL_COMMON_Wait, firstTime, TARGET_ENE_0, 0, 0, 0 );
	end
	
	--岩投げサポート中？
	local NowIwanage = 0<ai:GetTeamRecordCount(COORDINATE_TYPE_UROKOIwaSupport, TARGET_NONE, RANGE_IWANAGE_SUPPORT_TEAMMATE);
	
	--
--~ 	if ( NowIwanage) then
--~ 		--岩投げによる支援攻撃中なので、突撃兵は待っておく。
--~ 		uroko211003Battle_Wait(ai, goal);
	if ( role==ROLE_TYPE_Attack ) then 
		--攻撃役。
		uroko211003Battle_AttackRole(ai, goal);
	else
		--他の役割。
		uroko211003Battle_OtherRole(ai, goal);
	end
	
end

---------------------------------------------------------
--  役割別：支援攻撃中なので、待っておく。
---------------------------------------------------------
function uroko211003Battle_Wait(ai, goal)
	
	--待ってはいるけど、ターゲットには旋回して、意識している事を伝える。
	goal:AddSubGoal(GOAL_COMMON_Wait, 0.1, TARGET_ENE_0);
	
end

---------------------------------------------------------
--  役割別：攻撃役以外の役。
---------------------------------------------------------
function uroko211003Battle_OtherRole(ai, goal)
	
--[[■企画調整項目■]]

	local kd_TIME	= 2;
	local kd_NEAR	= 3;
	local kd_FAR	= 4;
	
	local ta_TIME	= 2;
	local ta_ANGLE	= 30;
	
--[[■企画調整項目■]]
	
	--距離を保つ。
	goal:AddSubGoal(GOAL_COMMON_KeepDist, kd_TIME, TARGET_ENE_0, kd_NEAR, kd_FAR, TARGET_ENE_0, true, -1);
	--回り込み。
	goal:AddSubGoal(GOAL_COMMON_TurnAround, sw_TIME, TARGET_ENE_0, AI_DIR_TYPE_B, ta_ANGLE, true, true, -1);
	
end

---------------------------------------------------------
--  役割別：攻撃役。
---------------------------------------------------------
function uroko211003Battle_AttackRole(ai, goal)

	local targetDist 	= ai:GetDist(TARGET_ENE_0);		--敵ターゲットとの距離を取得
	
	local Att3000Per = 0		--遠距離攻撃の確率
	local Att3001Per = 0		--中距離攻撃の確率
	local AttNormalPer = 100	--近距離攻撃の確率	
	local idParam = ai:GetNpcThinkParamID();	--小剣（211002）と大剣（211003）判別用
	

	if 		(idParam==211002) then		

		--距離別に確率を決める
		if targetDist >= 9.0 then
			Att3000Per = 0	
			Att3001Per = 0	
			AttNormalPer = 100
		
		elseif targetDist >= 7.0 then
			Att3000Per = 10
			Att3001Per = 70
			AttNormalPer = 20
		
		elseif targetDist >= 5.0 then
			Att3000Per = 70
			Att3001Per = 25
			AttNormalPer = 5
		
		else
			Att3000Per = 0
			Att3001Per = 0
			AttNormalPer = 100
		
		end

	elseif 	(idParam==211003) then
	
		--距離別に確率を決める
		if targetDist >= 9.0 then
			Att3000Per = 0	
			Att3001Per = 0	
			AttNormalPer = 100
		
		elseif targetDist >= 7.0 then
			Att3000Per = 20
			Att3001Per = 60
			AttNormalPer = 20
		
		elseif targetDist >= 5.0 then
			Att3000Per = 60
			Att3001Per = 35
			AttNormalPer = 5
		
		else
			Att3000Per = 0
			Att3001Per = 0
			AttNormalPer = 100
		
		end
		
	end

	
	--移動
	uroko211003Battle_Approach( ai, goal, 2);
	
	
	--突進攻撃に最適な間合いの場合。。。
	local rangeJumpAttack_begin = 2;
	local rangeJumpAttack_end 	= 4;
	
	if ( (rangeJumpAttack_begin<targetDist) and (targetDist<rangeJumpAttack_end) ) then
		--大体前方にいたら突進攻撃。
		if ( ai:IsInsideTargetEx(TARGET_SELF, TARGET_ENE_0, AI_DIR_TYPE_F, 45, 20) ) then
			goal:AddSubGoal(GOAL_COMMON_Attack2, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 3);
		end
	else
		uroko211003Battle_Attack(ai, goal)
	end
	
	--攻撃後始末。
	uroko211003Battle_AfterAttack(ai, goal)
	
end

---------------------------------------------------------
--  攻撃
---------------------------------------------------------
function uroko211003Battle_Attack(ai, goal)

	local K_fate = ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字
	local idParam = ai:GetNpcThinkParamID();		--小剣（211002）と大剣（211003）判別用

	
	if 		(idParam==211002) then		

		if K_fate <= 80 then
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
		else
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);
		end
		
	elseif 	(idParam==211003) then

		if K_fate <= 50 then
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
		else
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);
		end
	end
end
	
	
---------------------------------------------------------
--  攻撃後の行動
---------------------------------------------------------
function uroko211003Battle_AfterAttack(ai, goal)

	local KN_fate = ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字
	local SideTime = 0.7							--横に動く時間
	local BackDist = 1.0							--後退する距離
	local BackTime = 0.7							--後退する時間
	local bRight = ai:GetRandam_Int(0,1);			--右か左か
	-- 同じ方向に左右移動している仲間の数
	local friendNum = ai:GetTeamRecordCount(COORDINATE_TYPE_SideWalk_L+bRight, TARGET_ENE_0, 2.0);

	--85% 一呼吸	--10% 適当に横にガード移動	--5% 後ろにガード移動
	if KN_fate <= 85 then
		goal:AddSubGoal(GOAL_COMMON_Wait, ai:GetRandam_Float (0.2,0.6) ,0,0,0,0)
	elseif KN_fate <= 95 and friendNum < 1 then
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, SideTime, TARGET_ENE_0, bRight, ai:GetRandam_Int(30,45), true, true ,9910 );
	else
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, BackTime, TARGET_ENE_0, BackDist, TARGET_ENE_0, true, 9910 );				
	end
end

---------------------------------------------------------
--  接近。
---------------------------------------------------------
function uroko211003Battle_Approach(ai, goal, dist)
	goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, dist, TARGET_ENE_0, false, -1 );
end

	
	
--[[*****************************************************
	ゴールの更新・終了はなし。
*******************************************************]]
function uroko211003Battle_Update(ai, goal)	return GOAL_RESULT_Continue;end
function uroko211003Battle_Terminate(ai, goal)end


--[[*****************************************************
  割り込み
*******************************************************]]
function uroko211003Battle_Interupt(ai, goal)
	return false;
end


	