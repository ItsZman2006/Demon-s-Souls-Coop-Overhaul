-----------------------------------------------------------------------------------------------
--	AIで使用する共通LUA関数を記述します。
--	サブゴールにするほどでもない便利関数などを入れてください。
--	キャラ固有のものはここには含めないでください。
-----------------------------------------------------------------------------------------------

--[[*******************************************************************************************
	@attention 	AI担当PG以外は触らないように！
	@brief		プログラム側実装ゴール登録。
*********************************************************************************************]]
REGISTER_GOAL(GOAL_COMMON_Wait, 			"Wait");
REGISTER_GOAL(GOAL_COMMON_Stay, 			"Stay");
REGISTER_GOAL(GOAL_COMMON_MoveToSomewhere, 	"MoveToSomewhere");
REGISTER_GOAL(GOAL_COMMON_Guard, 			"Guard");
REGISTER_GOAL(GOAL_COMMON_Attack, 			"Attack");
REGISTER_GOAL(GOAL_COMMON_ComboAttack, 		"ComboAttack");
REGISTER_GOAL(GOAL_COMMON_SidewayMove, 		"SidewayMove");
REGISTER_GOAL(GOAL_COMMON_KeepDist, 		"KeepDist");
REGISTER_GOAL(GOAL_COMMON_BackToHome, 		"BackToHome");
REGISTER_GOAL(GOAL_COMMON_GuardBreakAttack, "GuardBreakAttack");
REGISTER_GOAL(GOAL_COMMON_SpinStep, 		"SpinStep");
REGISTER_GOAL(GOAL_COMMON_LeaveTarget, 		"LeaveTarget");
REGISTER_GOAL(GOAL_COMMON_ApproachStep,		"ApproachStep");
REGISTER_GOAL(GOAL_COMMON_Parry,			"Parry");


--[[*******************************************************************************************
	@attention 	AI担当PG以外は触らないように！

	@brief	非戦闘時トップゴール設定：ターゲットへ向く
	@param	ai						ai思考
*********************************************************************************************]]
function _COMMON_SetNBGoal_TurnToTarget(ai, life_time)
	ai:AddTopGoal( GOAL_COMMON_Stay, life_time, 0, TARGET_ENE_0);
end


--[[*******************************************************************************************
	@attention 	AI担当PG以外は触らないように！

	@brief	非戦闘時トップゴール設定：ターゲットへ歩く
	@param	ai						ai思考
*********************************************************************************************]]
function _COMMON_SetNBGoal_WalkToTarget(ai, life_time)
	
	local targetDist = ai:GetDist(TARGET_ENE_0);			--敵ターゲットとの距離を取得
	if( targetDist > 2.0 ) then
		ai:AddTopGoal( GOAL_COMMON_MoveToSomewhere, life_time, TARGET_ENE_0, AI_DIR_TYPE_CENTER, 1.5, TARGET_ENE_0, true);
	else
		-- 近づいたので見るだけ
		ai:AddTopGoal( GOAL_COMMON_Stay, life_time, 0, TARGET_ENE_0);
	end
end


--[[*******************************************************************************************
	@attention 	AI担当PG以外は触らないように！

	@brief	非戦闘時トップゴール設定：ターゲットへ走る。
	@param	ai						ai思考
*********************************************************************************************]]
function _COMMON_SetNBGoal_RunToTarget(ai, life_time)
	local targetDist = ai:GetDist(TARGET_ENE_0);			--敵ターゲットとの距離を取得
	if( targetDist > 2.0 ) then
		ai:AddTopGoal( GOAL_COMMON_MoveToSomewhere, life_time, TARGET_ENE_0, AI_DIR_TYPE_CENTER, 1.5, TARGET_ENE_0, false);
	else
		-- 近づいたので見るだけ
		ai:AddTopGoal( GOAL_COMMON_Stay, life_time, 0, TARGET_ENE_0);
	end
end


--[[*******************************************************************************************
	@attention 	AI担当PG以外は触らないように！

	@brief	非戦闘時トップゴール設定：指定ゴール設定。
	@param	ai						ai思考
*********************************************************************************************]]
function _COMMON_SetNBGoal_SetUserGoal(ai, life_time)
	
	local idGoal = ai:GetReplanningGoalID();
	ai:AddTopGoal( idGoal, life_time);
end


--[[*******************************************************************************************
	@attention 	AI担当PG以外は触らないように！

	@brief	非戦闘時トップゴール設定　ver2
	@param	ai						ai思考
	@param	life_time				ゴール時間。
*********************************************************************************************]]
function _COMMON_AddCautionAndFindGoal(ai, life_time)

	local idAction = ai:GetReplanningGoalAction();
	
	if    (idAction==NPC_THINK_GOAL_ACTION__TURN_TO_TGT) then
		_COMMON_SetNBGoal_TurnToTarget(ai, life_time);
	elseif(idAction==NPC_THINK_GOAL_ACTION__WALK_TO_TGT) then
		_COMMON_SetNBGoal_WalkToTarget(ai, life_time);
	elseif(idAction==NPC_THINK_GOAL_ACTION__RUN_TO_TGT) then
		_COMMON_SetNBGoal_RunToTarget(ai, life_time);
	elseif(idAction==NPC_THINK_GOAL_ACTION__SET_GOAL) then
		_COMMON_SetNBGoal_SetUserGoal(ai, life_time);
	else
		-- NPC_THINK_GOAL_ACTION__NONE、その他のケース。
		--何もしない。
		if( ai:HasTopSubgoal() ~= true ) then
			-- サブゴールがなにもなかったので非戦闘行動を入れておく
			_COMMON_AddNonBattleGoal(ai, -1.0, -1.0, true, false, 0.0);
		end
	end

end


--[[*******************************************************************************************
	@attention 	AI担当PG以外は触らないように！

	@brief	非戦闘ゴールを設定。
	
	@param	ai						ai思考
	@param	life					寿命
	@param	search_dist				敵に反応する距離。
	@param	isFoundTarget			敵を認識しているか？
	@param	runNonBattle			非戦闘時走るか？
*********************************************************************************************]]
function _COMMON_AddNonBattleGoal(ai, life, search_dist, isFoundTarget, runNonBattle, nonBattleBackhomeDist)

	ai:AddTopGoal( GOAL_COMMON_NonBattleAct, life, search_dist, false, runNonBattle, POINT_INIT_POSE, nonBattleBackhomeDist);
end


--[[*******************************************************************************************
	@attention 	AI担当PG以外は触らないように！

	@brief	戦闘ゴールを追加します。ver3
	
	@param	ai					ai思考
	@param	battleGoalId		戦闘ゴールID
*********************************************************************************************]]
function _COMMON_AddBattleGoal3(ai, battleGoalId)
	if ( ai:IsBattleState()) then
	
		-- 戦闘距離内。
		ai:AddTopGoal( battleGoalId, -1);
		
	else
	
		-- 警戒・発見状態。
		_COMMON_AddCautionAndFindGoal(ai, -1);
		
	end
end


--[[*******************************************************************************************
	@attention 	AI担当PG以外は触らないように！

	戦闘するかどうかを距離によって判別する
	ロジックから呼ばれることを想定しています。
	ai					ai思考
	funcBattle			戦闘ゴール追加lua関数。
	funcNonBattle		非戦闘ゴール追加lua関数。
 	maxBackhomeDist		何があっても帰宅する距離
 	backhomeDist		戦闘しつつ帰宅する距離
 	backhomeBattleDist	敵が近づいてきたら戦闘する距離
	nonBattleActLife	敵を意識しているときの非戦闘行動時間

	return				なんらかのゴールを設定したか
*********************************************************************************************]]
function _COMMON_SetBattleActLogic(ai, funcBattle, funcNonBattle, maxBackhomeDist, backhomeDist, backhomeBattleDist, nonBattleActLife)

	-- ポイントからの影響範囲
	local pointDist = ai:GetMovePointEffectRange();
	-- ターゲットがいるか
	local isFindTarget = ai:IsSearchTarget(TARGET_ENE_0);

	if isFindTarget == false then
		-- ターゲットなし　
		-- 非戦闘行動　敵みつけたらすぐに終了
		funcNonBattle( -1, -1, true);
		return true;
	else
		-- ターゲットまでの距離
		local targetDist = ai:GetDist(TARGET_ENE_0);

		-- ターゲットあり
		-- 何があっても帰宅する距離より外だった
		if  pointDist > maxBackhomeDist then
			
			-- 問答無用で巡回
			funcNonBattle( nonBattleActLife, -1, false);
			return true;
			
		-- 戦闘しつつ帰宅する距離より外だった
		elseif pointDist > backhomeDist then
	
			-- 敵がいなければ帰宅する
			if (targetDist < backhomeBattleDist) then
				-- 敵が回りにいれば戦闘
				funcBattle();
				return true;
			else
				-- 敵を気にしながら帰宅
				funcNonBattle( nonBattleActLife, backhomeBattleDist, false);
				return true;
			end
			
		-- 戦闘しつつ帰宅する距離より内だった	
		else
			-- 敵が最低帰宅範囲内にいれば戦う
			if (targetDist < backhomeDist) then
				-- 敵が回りにいれば戦闘
				funcBattle();
				return true;
			else
				-- 待機
				funcNonBattle( nonBattleActLife, backhomeDist, false);
				return true;
			end
			
		end;
	end
	
	return false;
end

--[[*******************************************************************************************
	@brief	簡単設定ver3
	
	@param	ai					ai思考
	@return	なし
	
	@param	[説明]
			XXXX_logic.luaのXXXX_Logic()で呼び出します。
			従来のCOMMON_SetBattleActLogic()の各種パラメータをエクセルの値を見るようにし、
			logic.luaを使いまわしやすい形にするというコンセプトに基づいています。
			
	@param	[ver3]
			ターゲット状態が変更したときのゴールの挙動をエクセルに設定してあるものを適用する。
			
	@param	[サンプル]
			function XXXX_Logic( ai )
				COMMON_EasySetup3( ai);
			end
			
*********************************************************************************************]]
function COMMON_EasySetup3( ai)
	_COMMON_EasySetup3(ai, false, 0);
end
function COMMON_EasySetup3_SetRunNonBattle( ai, isRunNonBattle)
	_COMMON_EasySetup3(ai, isRunNonBattle, 0);
end
function HEROINE_EasySetup3( ai)
	_COMMON_EasySetup3(ai, false, 999);
end
function _COMMON_EasySetup3( ai, isRunNonBattle, nonBattleBackhomeDist)

	local maxBackhomeDist 		= ai:GetExcelParam( AI_EXCEL_THINK_PARAM_TYPE__maxBackhomeDist);
	local backhomeDist 			= ai:GetExcelParam( AI_EXCEL_THINK_PARAM_TYPE__backhomeDist);
	local backhomeBattleDist 	= ai:GetExcelParam( AI_EXCEL_THINK_PARAM_TYPE__backhomeBattleDist);
	local nonBattleActLife 		= ai:GetExcelParam( AI_EXCEL_THINK_PARAM_TYPE__nonBattleActLife);
	local battleGoalId			= ai:GetExcelParam( AI_EXCEL_THINK_PARAM_TYPE__battleGoalID);

	--初期設定。
	local bSet = _COMMON_SetBattleActLogic(
						ai, 
						function () _COMMON_AddBattleGoal3( ai, battleGoalId) end, 
						function (life, search_dist, isFoundTarget) _COMMON_AddNonBattleGoal(ai, life, search_dist, isFoundTarget, isRunNonBattle, nonBattleBackhomeDist) end,
						maxBackhomeDist, backhomeDist, backhomeBattleDist, nonBattleActLife);

	if bSet == false then
		-- 何もゴールが設定されなかったので非戦闘行動を入れておく
		ai:AddTopGoal( GOAL_COMMON_NonBattleAct, -1.0, -1.0, true, 0, 0);
	end
end

