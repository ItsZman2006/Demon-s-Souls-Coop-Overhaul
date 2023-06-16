--[[*******************************************************************************************
	子エイ用戦闘
	説明：古砦３ボスの所に出てくる子エイ。

	パラメータ0  なし
	パラメータ1  なし
	パラメータ2  なし
	パラメータ3　なし
*********************************************************************************************]]
REGISTER_GOAL(GOAL_koei_503100_Battle, "koei_503100Battle");

REGISTER_GOAL_NO_UPDATE( GOAL_koei_503100_Battle, true);
REGISTER_GOAL_NO_INTERUPT( GOAL_koei_503100_Battle, true);

--[[*****************************************************
	ゴール起動
*******************************************************]]
function koei_503100Battle_Activate(ai, goal)

--[[■調整項目■]]

	--XZ平面状で、これ以上近い場合は攻撃しない。
	local NEAR_DMZ	= 5;

	--ターゲット視界外から射撃していい確率。
	local UNVISIBLE_SHOOT_RATE	= 10;

--[[■調整項目■]]


	local hprate 		= ai:GetHpRate( TARGET_SELF )		--自分のHP割合を取得
	local targetDist 	= ai:GetDist(TARGET_ENE_0);			--敵ターゲットとの距離を取得
	local fate 			= ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字
	local fate2 		= ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字　その２
	local fate3 		= ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字　その３
	local role 			= ai:GetTeamOrder(ORDER_TYPE_Role);	--自分の役割を取得

	--ターゲットにとって、正面？
	local isFrontForTarget	= ai:IsInsideTargetEx( TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_F, 90, 1000);
	
	--ターゲットと近すぎ？
	local tooNear = ai:GetDistXZ(TARGET_ENE_0) < NEAR_DMZ;
	
	--ターゲットにとって正面じゃないけど、一定確率で、撃っていい。
	local isEnableUnvisibleShoot	= not(isFrontForTarget) and (ai:GetRandam_Int(1,100) < UNVISIBLE_SHOOT_RATE);
	
	
	if ( not(tooNear) ) then
		if ( isFrontForTarget or isEnableUnvisibleShoot) then
			koei_503100Battle_Kougeki(ai, goal)
		end
	end

		
--[[
	--攻撃役なら攻撃。
	if ( role == ROLE_TYPE_Attack ) then
		koei_503100Battle_Kougeki(ai, goal)
	end
]]
	
	--次のポイントに移動
	koei_503100Battle_MoveToNextPoint(goal);
	if (fate <= 10) then koei_503100Battle_MoveToNextPoint(goal); end
	if (fate2<= 10) then koei_503100Battle_MoveToNextPoint(goal); end
	if (fate3<= 10) then koei_503100Battle_MoveToNextPoint(goal); end
end

---------------------------------------------------------
--  次のポイントへ移動。
---------------------------------------------------------
function koei_503100Battle_MoveToNextPoint(goal)
	goal:AddSubGoal(GOAL_COMMON_MoveToSomewhere, 20.0, POINT_MOVE_POINT, AI_DIR_TYPE_CENTER, 10.0, TARGET_SELF, true);
end

---------------------------------------------------------
--  攻撃
---------------------------------------------------------
function koei_503100Battle_Kougeki(ai, goal)
	goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 20.0, TARGET_ENE_0, 20, AI_DIR_TYPE_ToB , true, -1 );
	goal:AddSubGoal(GOAL_COMMON_Attack2, 10.0, 3010, TARGET_ENE_0, DIST_None, 0);
end
	
--[[*****************************************************
	更新
*******************************************************]]
function koei_503100Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end

--[[*****************************************************
	終了。
*******************************************************]]
function koei_503100Battle_Terminate(ai, goal)

	--失敗しようが何しようが、強制的に別のポイントへ。
	ai:StepNextMovePoint();
	
end

--[[*****************************************************
	割り込み。
*******************************************************]]
function koei_503100Battle_Interupt(ai, goal)
	return false;
end


	