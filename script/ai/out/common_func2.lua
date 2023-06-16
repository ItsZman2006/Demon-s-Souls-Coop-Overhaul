-----------------------------------------------------------------------------------------------
--	AIで使用する共通LUA関数を記述します。
--	サブゴールにするほどでもない便利関数などを入れてください。
--	キャラ固有のものはここには含めないでください。
-----------------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------------

--[[
--■■NPC用ラップ関数群■■
--
--]]

--[[**************************************************************************
	左手主武器に切り替え。
****************************************************************************]]
function CommonNPC_ChangeWepL1(ai, goal)
	local wep = ai:GetEquipWeaponIndex( ARM_L);
	if ( WEP_Primary ~= wep ) then
		goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_ChangeWep_L1, TARGET_NONE, DIST_None);
	end
end

--[[**************************************************************************
	右手主武器に切り替え。
****************************************************************************]]
function CommonNPC_ChangeWepR1(ai, goal)
	local wep = ai:GetEquipWeaponIndex( ARM_R);
	if ( WEP_Primary ~= wep ) then
		goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_ChangeWep_R1, TARGET_NONE, DIST_None);
	end
end

--[[**************************************************************************
	左手サブ武器に切り替え。
****************************************************************************]]
function CommonNPC_ChangeWepL2(ai, goal)
	local wep = ai:GetEquipWeaponIndex( ARM_L);
	if ( WEP_Secondary ~= wep ) then
		goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_ChangeWep_L2, TARGET_NONE, DIST_None);
	end
end

--[[**************************************************************************
	右手サブ武器に切り替え。
****************************************************************************]]
function CommonNPC_ChangeWepR2(ai, goal)
	local wep = ai:GetEquipWeaponIndex( ARM_R);
	if ( WEP_Secondary ~= wep ) then
		goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_ChangeWep_R2, TARGET_NONE, DIST_None);
	end
end


--[[**************************************************************************
	武器両手もちモードに変更。
****************************************************************************]]
function CommonNPC_SwitchBothHandMode(ai, goal)
	if ( not( ai:IsBothHandMode(TARGET_SELF) ) ) then
		goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_SwitchWep, TARGET_NONE, DIST_None);
	end
end

--[[**************************************************************************
	武器片手もちモードに変更。
****************************************************************************]]
function CommonNPC_SwitchOneHandMode(ai, goal)
	if ( ai:IsBothHandMode(TARGET_SELF) ) then
		goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_SwitchWep, TARGET_NONE, DIST_None);
	end
end




--[[
--■■具体的な行動を明記するシリーズ（お手軽にひとまとめの行動を作れる）■■
--
--]]

--■ダメージ受けたらステップして反撃・ＮＰＣ用
--コンボ逃れなどに使用します
function Damaged_StepCount_NPCPlayer(ai, goal, combRunDist, combRunPer, combRunCountPer, countAct, bkStepPer, leftStepPer, rightStepPer )

--引数説明--
--combRunDist			--コンボ逃れする距離
--combRunPer			--コンボ逃れする確率
--combRunCountPer		--コンボ逃れの後に反撃する確率
--countAct				--反撃の種類ID
--bkStepPer				--バックステップ確率
--leftStepPer			--左ステップ確率
--rightStepPer			--右ステップ確率	

local targetDist = ai:GetDist(TARGET_ENE_0);			--敵ターゲットとの距離を取得
local fate = ai:GetRandam_Int(1,100)					--確率判定用
local fate2 = ai:GetRandam_Int(1,100)					--確率判定用
local fate3 = ai:GetRandam_Int(1,100)					--確率判定用

	--距離内でダメージ受けたらステップ
	--ステップ後に反撃
	if ai:IsInterupt( INTERUPT_Damaged ) then
		if targetDist < combRunDist then
			if fate <= combRunPer then
				goal:ClearSubGoal();
				--逃れる
				if fate2 <= bkStepPer then
					goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepB, TARGET_ENE_0, DIST_None, 0);
				elseif fate2 <= (bkStepPer + leftStepPer ) then
					goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepL, TARGET_ENE_0, DIST_None, 0);
				else
					goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepR, TARGET_ENE_0, DIST_None, 0);
				end	
				
				if fate3 <= combRunCountPer then
					goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, countAct, TARGET_ENE_0, DIST_Middle, 0);
				end
				return true;
			end
		end
	end	
end


--■一定距離内で敵が攻撃したらステップ・ＮＰＣ用
--超反応回避などに使用します
function FindAttack_Step_NPCPlayer(ai, goal, superStepDist, superStepPer, bkStepPer, leftStepPer, rightStepPer )

--引数説明--
--superStepDist			--反応する距離
--superStepPer			--反応する確率	
--bkStepPer				--バックステップ確率
--leftStepPer			--左ステップ確率
--rightStepPer			--右ステップ確率

local targetDist = ai:GetDist(TARGET_ENE_0);			--敵ターゲットとの距離を取得
local fate = ai:GetRandam_Int(1,100)					--確率判定用
local fate2 = ai:GetRandam_Int(1,100)					--確率判定用

	--距離内で敵が攻撃したらステップ
	if ai:IsInterupt( INTERUPT_FindAttack ) then
		if targetDist <= superStepDist then
			if fate <= superStepPer then
			--逃れる
				if fate2 <= bkStepPer then
					goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepB, TARGET_ENE_0, DIST_None, 0);
				elseif fate2 <= (bkStepPer + leftStepPer ) then
					goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepL, TARGET_ENE_0, DIST_None, 0);
				else
					goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepR, TARGET_ENE_0, DIST_None, 0);
				end
				return true;
			end
		end
	end
end


--■ダメージ受けたらステップして反撃・敵用
--コンボ逃れなどに使用します
function Damaged_StepCount(ai, goal, combRunDist, combRunPer, combRunCountPer, countAct, bkStepPer, leftStepPer, rightStepPer )

--引数説明--
--combRunDist			--コンボ逃れする距離
--combRunPer			--コンボ逃れする確率
--combRunCountPer		--コンボ逃れの後に反撃する確率
--countAct				--反撃の種類ID
--bkStepPer				--バックステップ確率
--leftStepPer			--左ステップ確率
--rightStepPer			--右ステップ確率	

local targetDist = ai:GetDist(TARGET_ENE_0);			--敵ターゲットとの距離を取得
local fate = ai:GetRandam_Int(1,100)					--確率判定用
local fate2 = ai:GetRandam_Int(1,100)					--確率判定用
local fate3 = ai:GetRandam_Int(1,100)					--確率判定用

	--距離内でダメージ受けたらステップ
	--ステップ後に反撃
	if ai:IsInterupt( INTERUPT_Damaged ) then
		if targetDist < combRunDist then
			if fate <= combRunPer then
				goal:ClearSubGoal();
				--逃れる
				if fate2 <= bkStepPer then
					goal:AddSubGoal(GOAL_COMMON_SpinStep, 5.0, 701, TARGET_ENE_0, 0);
				elseif fate2 <= (bkStepPer + leftStepPer ) then
					goal:AddSubGoal(GOAL_COMMON_SpinStep, 5.0, 702, TARGET_ENE_0, 0);
				else
					goal:AddSubGoal(GOAL_COMMON_SpinStep, 5.0, 703, TARGET_ENE_0, 0);
				end	
				
				if fate3 <= combRunCountPer then
					goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, countAct, TARGET_ENE_0, DIST_Middle, 0);
				end
				return true;
			end
		end
	end	
end


--■一定距離内で敵が攻撃したらステップ・敵用
--超反応回避などに使用します
function FindAttack_Step(ai, goal, superStepDist, superStepPer, bkStepPer, leftStepPer, rightStepPer )

--引数説明--
--superStepDist			--反応する距離
--superStepPer			--反応する確率	
--bkStepPer				--バックステップ確率
--leftStepPer			--左ステップ確率
--rightStepPer			--右ステップ確率

local targetDist = ai:GetDist(TARGET_ENE_0);			--敵ターゲットとの距離を取得
local fate = ai:GetRandam_Int(1,100)					--確率判定用
local fate2 = ai:GetRandam_Int(1,100)					--確率判定用

	--距離内で敵が攻撃したらステップ
	if ai:IsInterupt( INTERUPT_FindAttack ) then
		if targetDist <= superStepDist then
			if fate <= superStepPer then
				goal:ClearSubGoal();
				--逃れる
				if fate2 <= bkStepPer then
					goal:AddSubGoal(GOAL_COMMON_SpinStep, 5.0, 701, TARGET_ENE_0, 0);
				elseif fate2 <= (bkStepPer + leftStepPer ) then
					goal:AddSubGoal(GOAL_COMMON_SpinStep, 5.0, 702, TARGET_ENE_0, 0);
				else
					goal:AddSubGoal(GOAL_COMMON_SpinStep, 5.0, 703, TARGET_ENE_0, 0);
				end	
				return true;
			end
		end
	end
end


--■一定距離内で敵が攻撃したらステップ・敵用（安全確認する版）
--超反応回避などに使用します
function FindAttack_SafetyStep(ai, goal, superStepDist, superStepPer, bkStepPer, leftStepPer, rightStepPer, safetyDist )

--引数説明--
--superStepDist			--反応する距離
--superStepPer			--反応する確率	
--bkStepPer				--バックステップ確率
--leftStepPer			--左ステップ確率
--rightStepPer			--右ステップ確率
--safetyDist			--安全確認距離

local targetDist = ai:GetDist(TARGET_ENE_0);			--敵ターゲットとの距離を取得
local fate = ai:GetRandam_Int(1,100)					--確率判定用
local fate2 = ai:GetRandam_Int(1,100)					--確率判定用

	--距離内で敵が攻撃したらステップ
	if ai:IsInterupt( INTERUPT_FindAttack ) then
		if targetDist <= superStepDist then
			if fate <= superStepPer then
				goal:ClearSubGoal();
				--逃れる
				if fate2 <= bkStepPer then
					goal:AddSubGoal(GOAL_COMMON_SpinStep, 5.0, 701, TARGET_ENE_0, 0.0, AI_DIR_TYPE_B, safetyDist);
				elseif fate2 <= (bkStepPer + leftStepPer ) then
					goal:AddSubGoal(GOAL_COMMON_SpinStep, 5.0, 702, TARGET_ENE_0, 0.0, AI_DIR_TYPE_L, safetyDist);
				else
					goal:AddSubGoal(GOAL_COMMON_SpinStep, 5.0, 703, TARGET_ENE_0, 0.0, AI_DIR_TYPE_R, safetyDist);
				end	
				return true;
			end
		end
	end
end



--[[
--■■具体的な行動は明記しないシリーズ（行動に関わらず汎用的に使える）■■
--
--]]

-----------------------------------------------------------------------------------------------
--■一定距離内でダメージ受けた
--コンボ逃れなどに使用します
function Damaged_Act(ai, goal, combRunDist, combRunPer )

--引数説明--
--combRunDist			--コンボ逃れする距離
--combRunPer			--コンボ逃れする確率

local targetDist = ai:GetDist(TARGET_ENE_0);			--敵ターゲットとの距離を取得
local fate = ai:GetRandam_Int(1,100)					--確率判定用

	--距離内でダメージ受けたらtrueを返す
	if ai:IsInterupt( INTERUPT_Damaged ) then
		if targetDist < combRunDist then
			if fate <= combRunPer then
				return true;
			end
		end
	end

return false;
end


--■一定距離外でダメージ受けた
--遠くから撃たれて急接近する場合などに使用します
function FarDamaged_Act(ai, goal, farResDist, farResPer )

--引数説明--
--farResDist		--反応する距離
--farResPer			--反応する確率

local targetDist = ai:GetDist(TARGET_ENE_0);			--敵ターゲットとの距離を取得
local fate = ai:GetRandam_Int(1,100)					--確率判定用

	--距離内でダメージ受けたらtrueを返す
	if ai:IsInterupt( INTERUPT_Damaged ) then
		if targetDist >= farResDist then
			if fate <= farResPer then
				return true;
			end
		end
	end

return false;
end



-----------------------------------------------------------------------------------------------
--■一定距離内で敵が空振りした
--空振りの隙を突いて攻撃する場合などに使用します
function MissSwing_Act(ai, goal, missSwingDist, missSwingAttPer )

--引数説明
--missSwingDist			--空振り追撃する距離
--missSwingAttPer		--空振り追撃する確率

local targetDist = ai:GetDist(TARGET_ENE_0);			--敵ターゲットとの距離を取得
local fate = ai:GetRandam_Int(1,100)					--確率判定用

	--距離内で空振りしたらtrueを返す
	if ai:IsInterupt( INTERUPT_MissSwing ) then
		if targetDist <= missSwingDist then
			if fate <= missSwingAttPer then
				return true;
			end
		end	
	end

return false;
end


-----------------------------------------------------------------------------------------------
--■一定距離内で敵が攻撃した
--攻撃をすばやくガードする場合などに使用します
function FindAttack_Act(ai, goal, superStepDist, superStepPer )

--引数説明
--superStepDist			--反応する距離
--superStepPer			--反応する確率

local targetDist = ai:GetDist(TARGET_ENE_0);			--敵ターゲットとの距離を取得
local fate = ai:GetRandam_Int(1,100)					--確率判定用

	--一定距離内で敵が攻撃した
	if ai:IsInterupt( INTERUPT_FindAttack ) then
		if targetDist <= superStepDist then
			if fate <= superStepPer then
				return true;
			end
		end
	end

return false;
end	


-----------------------------------------------------------------------------------------------
--■一定距離内で敵がガード崩れになった
--ガード崩れになった敵を追撃する場合などに使用します
function FindGuardBreak_Act(ai, goal, guardBreakConutDist, guardBreakConutPer )

--引数説明
--guardBreakConutDist		--ガード崩壊で攻撃する距離
--guardBreakConutPer		--ガード崩壊で攻撃する確率

local targetDist = ai:GetDist(TARGET_ENE_0);			--敵ターゲットとの距離を取得
local fate = ai:GetRandam_Int(1,100)					--確率判定用

	--一定距離内で敵がガード崩れになった
	if ai:IsInterupt( INTERUPT_GuardBreak ) then
		if targetDist <= guardBreakConutDist then
			if fate <= guardBreakConutPer then
				return true;
			end
		end
	end

return false;
end	

-----------------------------------------------------------------------------------------------
--■一定距離内で敵がガードを止めた
--ガードを止めたらすかさず攻撃する場合などに使用します
function FindGuardFinish_Act(ai, goal, guardFinishConutDist, guardFinishConutPer )

--引数説明
--guardFinishConutDist		--ガード終了で攻撃する距離
--guardFinishConutPer		--ガード終了で攻撃する確率

local targetDist = ai:GetDist(TARGET_ENE_0);			--敵ターゲットとの距離を取得
local fate = ai:GetRandam_Int(1,100)					--確率判定用

	--一定距離内で敵がガード崩れになった
	if ai:IsInterupt( INTERUPT_GuardFinish ) then
		if targetDist <= guardFinishConutDist then
			if fate <= guardFinishConutPer then
				return true;
			end
		end
	end

return false;
end	

-----------------------------------------------------------------------------------------------
--■敵が飛び道具を撃った
--飛び道具による遠距離攻撃への対処に使用します
function FindShoot_Act(ai, goal, ShootActPer, ShootActPer2, ShootActPer3, ShootActDist, ShootActDist2, ShootActDist3)

--引数説明
--ShootActPer		--反応する確率（近）
--ShootActPer2		--反応する確率（中）
--ShootActPer3		--反応する確率（遠）
--ShootActDist		--反応する距離（近）
--ShootActDist2		--反応する距離（中）
--ShootActDist3		--反応する距離（遠）

local targetDist = ai:GetDist(TARGET_ENE_0);			--敵ターゲットとの距離を取得
local fate = ai:GetRandam_Int(1,100)					--確率判定用

	--ターゲットが飛び道具を撃った
	if ai:IsInterupt( INTERUPT_Shoot ) then
		--近距離の抽選に当たったら01を返す
		if targetDist <= ShootActDist and fate <= ShootActPer then
			return 1;
			
		--中距離の抽選に当たったら02を返す
		elseif targetDist <= ShootActDist2 and fate <= ShootActPer2 then	
			return 2;
			
		--遠距離の抽選に当たったら03を返す
		elseif targetDist <= ShootActDist3 and fate <= ShootActPer3 then	 
			return 3;
			
		--どれにも当たらなかったら00を返す
		else
			return 0;
			
		end
	end
	
return 0;
end	






--[[*******************************************************************************************
	@attention 	AI担当PG以外は触らないように！

	@brief	ウロコ用戦闘ゴール追加関数。
	
	@note	GetNumber(2)が０でないと、戦闘に移行しない。
	
	@param	ai					ai思考
	@param	battleGoalId		戦闘ゴールID
	@param	goal_wait_id		待機時ゴール設定Lua関数。
*********************************************************************************************]]
function _UROKO_AddBattleGoal2(ai, battleGoalId, funcNonBattelAct)

	if ( ai:IsBattleState()) then
	
		-- 戦闘距離内。
		ai:AddTopGoal( battleGoalId, -1);
		
	else
	
		--移動しないし、旋回もしない。
		funcNonBattelAct();
		
	end
end


--[[*******************************************************************************************
	@attention 	AI担当PG以外は触らないように！

	@brief	ウロコ非戦闘ゴール。
	
	@param	ai						ai思考
	@param	goal_wait_id			待機時ゴールID
*********************************************************************************************]]
function _UROKO_NonBattleAct(ai, goal_wait_id)

	local life				= -1;
	local search_dist		= -1;
	local isFoundTarget		= false;
	local runNonBattle		= false;


	ai:AddTopGoal( GOAL_COMMON_NonBattleAct, life, search_dist, false, runNonBattle, TARGET_NONE, 0.5, goal_wait_id);
	if ( not(ai:IsLookToTarget( POINT_INIT_POSE, 5)) ) then
		ai:AddTopGoal( GOAL_COMMON_Turn, life, POINT_INIT_POSE);
	end
end


--[[*******************************************************************************************
	@brief	簡単ウロコ抗夫設定。
	@note	戦闘ゴールになるまで、どんな状態でも旋回しないで、待機。

	@param	goal_wait_id			待機時ゴールID
	@param	funcCautionAndFind		警戒・発見のLua関数。（引き数なし呼び出し。）
*********************************************************************************************]]
function _UROKO_EasySetup( ai, goal_wait_id, funcCautionAndFind)

	local maxBackhomeDist 		= ai:GetExcelParam( AI_EXCEL_THINK_PARAM_TYPE__maxBackhomeDist);
	local backhomeDist 			= ai:GetExcelParam( AI_EXCEL_THINK_PARAM_TYPE__backhomeDist);
	local backhomeBattleDist 	= ai:GetExcelParam( AI_EXCEL_THINK_PARAM_TYPE__backhomeBattleDist);
	local nonBattleActLife 		= ai:GetExcelParam( AI_EXCEL_THINK_PARAM_TYPE__nonBattleActLife);
	local battleGoalId			= ai:GetExcelParam( AI_EXCEL_THINK_PARAM_TYPE__battleGoalID);

	--初期設定。
	local bSet = _COMMON_SetBattleActLogic(
						ai, 
						function () _UROKO_AddBattleGoal2( ai, battleGoalId, funcCautionAndFind) end, 
						function (life, search_dist, isFoundTarget) _UROKO_NonBattleAct(ai, goal_wait_id); end,
						maxBackhomeDist, backhomeDist, backhomeBattleDist, nonBattleActLife);

	if bSet == false then
		-- 何もゴールが設定されなかったので非戦闘行動を入れておく
		ai:AddTopGoal( GOAL_COMMON_NonBattleAct, -1.0, -1.0, true, 0, 0);
	end
end


--[[*******************************************************************************************
	@brief	簡単ウロコ抗夫設定。
	@note	戦闘ゴールになるまで、どんな状態でも旋回しないで、待機。

		@param	goal_wait_id			待機時ゴールID
*********************************************************************************************]]
function UROKO_EasySetup( ai, goal_wait_id)

	_UROKO_EasySetup( ai, goal_wait_id, function () 
											_UROKO_NonBattleAct(ai, goal_wait_id); 
										end);

end


--[[*******************************************************************************************
	@brief	簡単ウロコ抗夫設定２。
	@note	警戒・発見状態は、エクセルの設定に従うように。

	@param	goal_wait_id			待機時ゴールID
	@param
	@param	funcCautionAndFind		警戒・発見のLua関数。（引き数なし呼び出し。）
*********************************************************************************************]]
function UROKO_EasySetup2( ai, goal_wait_id, funcCautionAndFind)

	_UROKO_EasySetup( ai, goal_wait_id, funcCautionAndFind);

end



