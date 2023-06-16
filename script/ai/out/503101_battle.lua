--[[*******************************************************************************************
	子エイ用戦闘
	説明：
		単独行動用。
	
	履歴：
	・作成	08/7/28	hasem

	パラメータ0  なし
	パラメータ1  なし
	パラメータ2  なし
	パラメータ3　なし
*********************************************************************************************]]
REGISTER_GOAL(GOAL_koei_503101_Battle, "koei_503101Battle");


-- Updateでなにもやっていないので、呼ばないようにする
REGISTER_GOAL_NO_UPDATE( GOAL_koei_503101_Battle, 1 );


--[[*****************************************************
	ゴール起動
*******************************************************]]
function koei_503101Battle_Activate(ai, goal)
	
	local hprate 	= ai:GetHpRate( TARGET_SELF )		--自分のHP割合を取得
	local fate 		= ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字
	local fate2 	= ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字　その２
	local fate3 	= ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字　その３
	local role 		= ai:GetTeamOrder(ORDER_TYPE_Role);	--自分の役割を取得

	--攻撃役なら攻撃。
	if ( koei_503101Battle_IsEnableAttack(ai)) then
		if ( role == ROLE_TYPE_Attack ) then
			if (ai:IsLookToTarget()) then
				koei_503101Battle_Kougeki(ai, goal)
			end
		end
	end
	
	--次のポイントに移動
	koei_503101Battle_MoveToNext(goal);
	if (fate  <= 10) then	koei_503101Battle_MoveToNext(goal);	end
	if (fate2 <= 10) then	koei_503101Battle_MoveToNext(goal);	end
	if (fate3 <= 10) then	koei_503101Battle_MoveToNext(goal);	end

end

---------------------------------------------------------
--  攻撃していい位置にいるか？
---------------------------------------------------------
function koei_503101Battle_IsEnableAttack(ai)
	local idParam 	= ai:GetNpcThinkParamID();
	local idRegion	= -1;
	if 		(idParam==503101) then	idRegion = 2430;
	elseif	(idParam==503102) then	idRegion = 2431;
	elseif	(idParam==503103) then	idRegion = 2432;
	elseif	(idParam==503104) then	idRegion = 2433;
	end
	
	return ai:IsInsideTargetRegion(TARGET_ENE_0, idRegion);
end

---------------------------------------------------------
--  攻撃
---------------------------------------------------------
function koei_503101Battle_Kougeki(ai, goal)

	koei_503101Battle_OneAttack(goal);

end

---------------------------------------------------------
--  一回の攻撃。
---------------------------------------------------------
function koei_503101Battle_OneAttack(goal)
--~ 	goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 20.0, TARGET_ENE_0, 20, AI_DIR_TYPE_ToB , true, -1 );
--~ 	goal:AddSubGoal(GOAL_COMMON_NonspinningAttack, 10.0, 3010, TARGET_ENE_0, DIST_None, 0);
	goal:AddSubGoal(GOAL_COMMON_Attack2, 10.0, 3010, TARGET_ENE_0, DIST_None, 0);
	goal:AddSubGoal(GOAL_COMMON_SpecialTurn, 10.0, 3020, POINT_MOVE_POINT, 90);
--	goal:AddSubGoal( GOAL_COMMON_Turn,	10.0, POINT_MOVE_POINT, 0, 0, 0 );		--おためし中

end

---------------------------------------------------------
--  次の位置へ。
---------------------------------------------------------
function koei_503101Battle_MoveToNext(goal)
	goal:AddSubGoal(GOAL_COMMON_MoveToSomewhere, 20.0, POINT_MOVE_POINT, AI_DIR_TYPE_CENTER, 10.0, TARGET_SELF, true);
end

	
--[[*****************************************************
	ゴール更新はなし。
*******************************************************]]
function koei_503101Battle_Update(ai, goal)	return GOAL_RESULT_Continue; end

--[[*****************************************************
	ゴール終了。
*******************************************************]]
function koei_503101Battle_Terminate(ai, goal)
end

--[[*****************************************************
	割り込み
*******************************************************]]
function koei_503101Battle_Interupt(ai, goal)
	-- 戦闘領域離脱割り込み
	if (ai:IsInterupt( INTERUPT_LeaveBattleArea )) then
		-- 攻撃しようとしているだけ再実行
		if (not(goal:GetNumber(0) == 0)) then
			goal:ClearSubGoal();
			koei_503101Battle_MoveToNext(goal);
			return true;
		end
	end

	return false;
end







	