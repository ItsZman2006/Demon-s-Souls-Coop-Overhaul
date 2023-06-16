-----------------------------------------------------------------------------------------------
--	パッチ（坑道）用戦闘
--	説明：
--
--	パラメータ0  なし
--	パラメータ1  なし
--	パラメータ2  なし
--	パラメータ3　なし
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_pachi809000_Battle, "pachi809000Battle");

-- Updateでなにもやっていないので、呼ばないようにする
REGISTER_GOAL_NO_UPDATE( GOAL_pachi809000_Battle, 1 );


---------------------------------------------------------
--  ゴール起動
---------------------------------------------------------
function pachi809000Battle_Activate(ai, goal)
-------------------------------------------------------------------------------

local targetDist = ai:GetDist(TARGET_ENE_0);			--敵ターゲットとの距離を取得
local NormalR_Dist = 2.5								--右手攻撃の適正間合い

	--ガード開始
	ai:StartGuard(4);

	--近いなら
	if targetDist >= NormalR_Dist then
		--基本戦闘（近い）
		pachi809000Battle_Normal_Near(ai, goal)
	--極端に近いなら
	else
		--基本戦闘（極端に近い）
		pachi809000Battle_Normal_TooNear(ai, goal)
	
	end	
end


--------------------------------------------------------
--  基本戦闘（極端に近い）
---------------------------------------------------------
function pachi809000Battle_Normal_TooNear(ai, goal)

local fate = ai:GetRandam_Int(1,100)	--確率判定用
local Attack_fate = 50 					--攻撃する確率
 
	--50% ガード攻撃
	if fate <= Attack_fate then
		pachi809000Battle_NormalR_Comb(ai, goal)
		pachi809000Battle_Kougeki_Noato(ai, goal)
	--50% ガード
	else
		pachi809000Battle_Kougeki_Noato(ai, goal)
	end

end

--------------------------------------------------------
--  基本戦闘（近い）
---------------------------------------------------------
function pachi809000Battle_Normal_Near(ai, goal)

local NormalR_Dist = 2.5				--右手攻撃の適正間合い

local fate = ai:GetRandam_Int(1,100)	--確率判定用
local Attack_fate = 30					--接近攻撃をする確率

	--50% ガードしながら接近
	if fate <= Attack_fate then
		goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, -1 );
		goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Middle, 0);
	
	--50% ガードしながら旋回
	else
		goal:AddSubGoal( GOAL_COMMON_SidewayMove, ai:GetRandam_Int(2,4), TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(25,45), false, true, -1 )

	end
end
	
---------------------------------------------------------
--  右手コンボ
---------------------------------------------------------
function pachi809000Battle_NormalR_Comb(ai, goal)

local fate = ai:GetRandam_Int(1,100)	--確率判定用
local Second_Attack_Per = 15 			--追加攻撃する確率

	goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Middle, 0);

	if fate <= Second_Attack_Per then
		goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Middle, 0);
	end
	
end
	
	
---------------------------------------------------------
--  攻撃後の行動
---------------------------------------------------------
function pachi809000Battle_Kougeki_Noato(ai, goal)

local KN_fate = ai:GetRandam_Int(1,100)			--確率判定用
local KN_fate2 = ai:GetRandam_Int(1,100)		--確率判定用
local BackDist = 3.0							--後退する距離

	--30% ガード
	--30% ガードしながら横移動
	--40% ガードしながら後退
	if KN_fate <= 30 then
		goal:AddSubGoal( GOAL_COMMON_Guard, 3.0, 4, TARGET_ENE_0, false, 0 );
	elseif KN_fate <= 60 then
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, 3.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), 45, false, true , -1 );
	else
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 3.0, TARGET_ENE_0, BackDist, TARGET_ENE_0, false, -1 );				
	end
end




---------------------------------------------------------
--  ゴール更新
---------------------------------------------------------
function pachi809000Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  ゴール終了
---------------------------------------------------------
function pachi809000Battle_Terminate(ai, goal)
end



---------------------------------------------------------
--  割り込み
--	割り込んだ場合にはtrueを返してください。
--	ここで割り込み用のサブゴールを追加してください。
--	割り込まなかった場合には、1つ上の層のゴール、またはロジック部分によって割り込みが処理されます。
---------------------------------------------------------
function pachi809000Battle_Interupt(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);			--敵ターゲットとの距離を取得

local fate = ai:GetRandam_Int(1,100)					--確率判定用
local fate2 = ai:GetRandam_Int(1,100)					--確率判定用
local fate3 = ai:GetRandam_Int(1,100)					--確率判定用
local fate4 = ai:GetRandam_Int(1,100)					--確率判定用

local NormalR_Dist = 2.5			--右手攻撃の適正間合い


	--空振りしたら攻撃
	if ai:IsInterupt( INTERUPT_MissSwing ) then
local MissSwingDist = 4.0			--空振り追撃する距離
local MissSwingAttPer = 20			--空振り追撃する確率	
		if targetDist <= MissSwingDist then
			if fate <= MissSwingAttPer then
				goal:ClearSubGoal();
				pachi809000Battle_NormalR_Comb(ai, goal)
				pachi809000Battle_Kougeki_Noato(ai, goal)
				return true;
			end
		end	
	end

	
	--至近距離でダメージ受けたらコンボとみなして反撃・後退
	if ai:IsInterupt( INTERUPT_Damaged ) then
local combRunDist = 1.0				--コンボ逃れする距離
local combRunPer = 40				--コンボ逃れする確率
local combRunCountPer = 15			--コンボ逃れの後に攻撃する確率	
		if targetDist < combRunDist then
			if fate <= combRunPer then
				goal:ClearSubGoal();
				--逃れる
				pachi809000Battle_Kougeki_Noato(ai, goal)

				--コンボ逃れ後の攻撃
				if fate3 <= combRunCountPer then
					goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Middle, 0);
				end
				return true;
			end
		end
	end	
	
	--至近距離で攻撃されそうになったら超反応ステップ
	if ai:IsInterupt( INTERUPT_FindAttack ) then
local superStepDist = 2.0			--超反応する距離
local superStepPer = 10				--超反応する確率	
		if targetDist <= superStepDist then
			if fate <= superStepPer then
			--逃れる
				pachi809000Battle_Kougeki_Noato(ai, goal)
				return true;
			end
		end
	end
	
	--ガード崩壊したら攻撃
	if ai:IsInterupt( INTERUPT_GuardBreak ) then
local guardBreakConutDist = 2.0			--ガード崩壊で攻撃する距離
local guardBreakConutPer = 50			--ガード崩壊で攻撃する確率
		if targetDist <= guardBreakConutDist then
			if fate <= guardBreakConutPer then
				goal:ClearSubGoal();
				goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_LargeR, TARGET_ENE_0, DIST_Near, 0);
				pachi809000Battle_Kougeki_Noato(ai, goal)
				return true;
			end
		end
	end
	
	--飛び道具を撃ってきたら最適行動
	if ai:IsInterupt( INTERUPT_Shoot ) then
local shootIntPer = 50					--飛び道具使用時に最適行動を取る確率
		if fate <= shootIntPer then
			goal:ClearSubGoal();
			if fate2 <= 50 then
				goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepL, TARGET_ENE_0, DIST_None, 0);
			else
				goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepR, TARGET_ENE_0, DIST_None, 0);
			end
			return true
		end
	end
	
	--アイテムを使ったら最適行動
	if ai:IsInterupt( INTERUPT_UseItem ) then
local itemUseIntPer = 50				--アイテム使用時に最適行動を取る確率
		if fate <= itemUseIntPer then
			goal:ClearSubGoal();		
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, -1 );
			pachi809000Battle_NormalR_Comb(ai, goal)
			pachi809000Battle_Kougeki_Noato(ai, goal)
			return true
		end
	end
	
return false;
end




--[[****************************************************************************************]]
--[[************************************** サブゴール **************************************]]
--[[****************************************************************************************]]

--[[**********************************************************************
	宝箱の位置まで移動。
************************************************************************]]
REGISTER_GOAL(GOAL_pachi809000_MoveToTreasure, "pachi809000MTT");
REGISTER_GOAL_NO_UPDATE(GOAL_pachi809000_MoveToTreasure, true);
REGISTER_GOAL_NO_INTERUPT(GOAL_pachi809000_MoveToTreasure, true);

function pachi809000MTT_Activate(ai, goal)

	goal:AddSubGoal(GOAL_COMMON_MoveToSomewhere, -1, POINT_EVENT, AI_DIR_TYPE_CENTER, 0, TARGET_SELF, false);

end

function pachi809000MTT_Update(ai, goal) return GOAL_RESULT_Continue; end
function pachi809000MTT_Terminate(ai, goal)end
function pachi809000MTT_Interupt(ai, goal) return false; end
