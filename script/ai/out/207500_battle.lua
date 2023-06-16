--[[*******************************************************************************************
	虜囚玉戦闘
	説明：	接近して攻撃。巣からの坑道範囲は極めて小さい。
			非戦闘時の動作はデフォルトの機能を使用。エクセルで調整。
*********************************************************************************************]]
REGISTER_GOAL(GOAL_Ryosyudama207500_Battle, "Ryosyudama207500Battle");
REGISTER_GOAL_NO_UPDATE(GOAL_Ryosyudama207500_Battle, true);
REGISTER_GOAL_NO_INTERUPT(GOAL_Ryosyudama207500_Battle, true);

--[[*****************************************************
    ゴール起動
*******************************************************]]
function Ryosyudama207500Battle_Activate(ai, goal)

	local idParam = ai:GetNpcThinkParamID();

	if 		(idParam==207500) then	CheckRegionID = 2005;
	else 	CheckRegionID = 2205;
	end

	--攻撃距離なら、近接攻撃
		if ai:IsInsideTargetRegion( TARGET_ENE_0, CheckRegionID) then
			Ryosyudama207500Battle_Attack(ai, goal);
		-- 攻撃距離にいないなら待機⇔遠距離攻撃
		else
			Ryosyudama207500Battle_Approach(ai, goal);
		end
		
end

---------------------------------------------------------
--  接近
---------------------------------------------------------
function Ryosyudama207500Battle_Approach(ai, goal)
	local ATTACK_RANGE		= ai:GetDistParam(DIST_Near);	--攻撃距離
	local AT_fate 			= ai:GetRandam_Int(1,100);		--確率判定用

	--50%　遠距離攻撃
	--50%　移動（攻撃）
	if AT_fate <= 50 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_None , 0);
	else
		goal:AddSubGoal( GOAL_COMMON_Wait, 3.0, TARGET_ENE_NONE, 0, 0, 0 );
--~ 		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 3.0, TARGET_ENE_0, ATTACK_RANGE-1, TARGET_ENE_0, true, -1 );
	end
end

---------------------------------------------------------
--  攻撃
---------------------------------------------------------
function Ryosyudama207500Battle_Attack(ai, goal)

	local targetDist 	= ai:GetDist(TARGET_ENE_0);		--敵ターゲットとの距離を取得
	local ATTACK_RANGE	= ai:GetDistParam(DIST_Near);	--攻撃距離
	
	if 	( targetDist > ATTACK_RANGE ) then
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 5.0, TARGET_ENE_0, ATTACK_RANGE-1, TARGET_ENE_0, true, -1 );
	else
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Near);
	end
end

	
--[[*****************************************************
	更新・終了・割り込み
*******************************************************]]
function Ryosyudama207500Battle_Update(ai, goal) return GOAL_RESULT_Continue; end
function Ryosyudama207500Battle_Terminate(ai, goal)end
function Ryosyudama207500Battle_Interupt(ai, goal)return false;end
