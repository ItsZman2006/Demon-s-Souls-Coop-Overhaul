------------------------------------------------------------------------------------------------
--	不浄２徘徊ブラックゴースト用戦闘
--	説明：
--
--	パラメータ0  なし
--	パラメータ1  なし
--	パラメータ2  なし
--	パラメータ3　なし
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_Fujo2BG_839000_Battle, "Fujo2BG_839000Battle");

-- Updateでなにもやっていないので、呼ばないようにする
REGISTER_GOAL_NO_UPDATE( GOAL_Fujo2BG_839000_Battle, 1 );


---------------------------------------------------------
--  ゴール起動
---------------------------------------------------------
function Fujo2BG_839000Battle_Activate(ai, goal)
-------------------------------------------------------------------------------

local targetDist = ai:GetDist(TARGET_ENE_0);			--敵ターゲットとの距離を取得
local fate = ai:GetRandam_Int(1,100)		--確率判定で使用する運命の数字

local FarDist = 30.0						--追撃を諦める距離
local NormalR_Dist = 1.5					--右手攻撃の適正間合い


	--追撃を諦める距離なら
	if targetDist >= FarDist then
		goal:ClearSubGoal();
		--100% 何もしない
		goal:AddSubGoal( GOAL_COMMON_Wait, 5.0, TARGET_ENE_0, 0, 0, 0 );

	--追撃可能な距離なら
	else	
		--100% 走って近づいて攻撃
		goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 3.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, -1 );
		Fujo2BG_839000Battle_NormalR_Comb(ai, goal)

		--50% 攻撃後の行動
		if fate <= 50 then
			Fujo2BG_839000Battle_Kougeki_Noato(ai, goal)
		end
	end
end

---------------------------------------------------------
--  右手コンボ
---------------------------------------------------------
function Fujo2BG_839000Battle_NormalR_Comb(ai, goal)

local NR_fate = ai:GetRandam_Int(1,100)			--確率判定用
local NR_fate2 = ai:GetRandam_Int(1,100)		--確率判定用
local NR_fate3 = ai:GetRandam_Int(1,100)		--確率判定用
local NR_fate4 = ai:GetRandam_Int(1,100)		--確率判定用

	--80% 強攻撃
	--15% 前転強攻撃
	-- 5% 両手持ちコンボ
	if NR_fate2 <= 15 then
		CommonNPC_SwitchOneHandMode(ai, goal)
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_StepF, TARGET_ENE_0, DIST_None, 0 )
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_NONE, DIST_Middle, 0);

	elseif NR_fate2 <= 40 then
		CommonNPC_SwitchOneHandMode(ai, goal)
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_LargeR, TARGET_ENE_0, DIST_Middle, 0);

	elseif NR_fate2 <= 75 then
		CommonNPC_SwitchBothHandMode(ai, goal)
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Middle, 0);		
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Middle, 0);	
	
	elseif NR_fate2 <= 90 then
		CommonNPC_SwitchBothHandMode(ai, goal)
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_StepF, TARGET_ENE_0, DIST_None, 0 )
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_NONE, DIST_Middle, 0);	

	else
		CommonNPC_SwitchBothHandMode(ai, goal)
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_LargeR, TARGET_ENE_0, DIST_Middle, 0);
		
	end
	
	

end
	
	
---------------------------------------------------------
--  攻撃後の行動
---------------------------------------------------------
function Fujo2BG_839000Battle_Kougeki_Noato(ai, goal)

	goal:AddSubGoal(GOAL_COMMON_SidewayMove, ai:GetRandam_Int(2,5), TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(35,55), false, true ,-1 );

end




---------------------------------------------------------
--  ゴール更新
---------------------------------------------------------
function Fujo2BG_839000Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  ゴール終了
---------------------------------------------------------
function Fujo2BG_839000Battle_Terminate(ai, goal)
end



---------------------------------------------------------
--  割り込み
--	割り込んだ場合にはtrueを返してください。
--	ここで割り込み用のサブゴールを追加してください。
--	割り込まなかった場合には、1つ上の層のゴール、またはロジック部分によって割り込みが処理されます。
---------------------------------------------------------
function Fujo2BG_839000Battle_Interupt(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);			--敵ターゲットとの距離を取得

local fate = ai:GetRandam_Int(1,100)					--確率判定用
local fate2 = ai:GetRandam_Int(1,100)					--確率判定用
local fate3 = ai:GetRandam_Int(1,100)					--確率判定用
local fate4 = ai:GetRandam_Int(1,100)					--確率判定用

local NormalR_Dist = 2.5			--右手攻撃の適正間合い


	--空振りしたら攻撃
	if ai:IsInterupt( INTERUPT_MissSwing ) then
local MissSwingDist = 4.0			--空振り追撃する距離
local MissSwingAttPer = 40			--空振り追撃する確率	
		if targetDist <= MissSwingDist then
			if fate <= MissSwingAttPer then
				goal:ClearSubGoal();
				goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 3.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, -1 );
				Fujo2BG_839000Battle_NormalR_Comb(ai, goal)
				return true;
			end
		end	
	end

	--至近距離でダメージ受けたらコンボとみなして反撃・後退
	if ai:IsInterupt( INTERUPT_Damaged ) then
local combRunDist = 1.0				--コンボ逃れする距離
local combRunPer = 60				--コンボ逃れする確率
		if targetDist < combRunDist then
			if fate <= combRunPer then
				goal:ClearSubGoal();
			if fate2 <= 30 then
				goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepL, TARGET_ENE_0, DIST_None, 0);
			elseif fate2 <= 60 then
				goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepR, TARGET_ENE_0, DIST_None, 0);
			else
				goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepB, TARGET_ENE_0, DIST_None, 0);
			end
				return true;
			end
		end
	end	
	

	--飛び道具を撃ってきたら最適行動
	if ai:IsInterupt( INTERUPT_Shoot ) then
local shootIntPer = 30					--飛び道具使用時に最適行動を取る確率
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
local itemUseIntPer = 100				--アイテム使用時に最適行動を取る確率
		if fate <= itemUseIntPer then
			goal:ClearSubGoal();		
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, -1 );
			Fujo2BG_839000Battle_NormalR_Comb(ai, goal)
			return true
		end
	end
	
return false;
end

