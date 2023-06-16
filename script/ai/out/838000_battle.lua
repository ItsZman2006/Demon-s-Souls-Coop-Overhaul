------------------------------------------------------------------------------------------------
--	王城三銃士B専用戦闘
--	説明：
--
--	パラメータ0  なし
--	パラメータ1  なし
--	パラメータ2  なし
--	パラメータ3　なし
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_TroisM_B838000_Battle, "TroisM_B838000Battle");

-- Updateでなにもやっていないので、呼ばないようにする
REGISTER_GOAL_NO_UPDATE( GOAL_TroisM_B838000_Battle, 1 );


---------------------------------------------------------
--  ゴール起動
---------------------------------------------------------
function TroisM_B838000Battle_Activate(ai, goal)
-------------------------------------------------------------------------------

local hprate = ai:GetHpRate( TARGET_SELF )				--自分のHP割合を取得

local targetDist = ai:GetDist(TARGET_ENE_0);			--敵ターゲットとの距離を取得
local fate = ai:GetRandam_Int(1,100)		--確率判定で使用する運命の数字
local fate2 = ai:GetRandam_Int(1,100)		--確率判定で使用する運命の数字　その２

local NormalR_Dist = 2.0			--右手攻撃の適正間合い

	--自分のHP残りが1割以上
	if hprate >= 0.1 then

		--近いなら
		if targetDist >= NormalR_Dist then

			--70％　走って近づき攻撃
			if fate <= 70 then
				goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, -1 );
				TroisM_B838000Battle_NormalR_Comb(ai, goal)
				TroisM_B838000Battle_Kougeki_Noato(ai, goal)
				
			--30% 走って旋回して様子見
			else
				goal:AddSubGoal(GOAL_COMMON_SidewayMove, ai:GetRandam_Int(2,4), TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(25,55), false, true ,-1 );
			end
			
		--極端に近いなら
		else
			--65％　攻撃
			if fate2 <= 65 then
				TroisM_B838000Battle_NormalR_Comb(ai, goal)
				
			--35％　ステップで後退
			else
				TroisM_B838000Battle_Kougeki_Noato(ai, goal)
			end
		end
	
	--自分のHP残りが1割以下
	else
	
		--50% 近づいて突きまくり
		if fate <= 50 then
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, -1 );
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_LargeR, TARGET_ENE_0, DIST_Middle, 0);
		
		--50% 近づいて旋回して突きまくり
		else
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, -1 );
			goal:AddSubGoal(GOAL_COMMON_SidewayMove, ai:GetRandam_Int(2,4), TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(25,55), false, true ,-1 );
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_LargeR, TARGET_ENE_0, DIST_Middle, 0);
		end
	end
end

---------------------------------------------------------
--  右手コンボ（通常）
---------------------------------------------------------
function TroisM_B838000Battle_NormalR_Comb(ai, goal)

local NR_fate = ai:GetRandam_Int(1,100)			--確率判定用
local NR_fate2 = ai:GetRandam_Int(1,100)		--確率判定用
local NR_fate3 = ai:GetRandam_Int(1,100)		--確率判定用

local NormalATKPer	= 70		--通常攻撃の割合

	if NR_fate <= NormalATKPer then

		--30% 前転攻撃
		if NR_fate2 <= 30 then
			CommonNPC_SwitchOneHandMode(ai, goal)
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_StepF, TARGET_ENE_0, DIST_None, 0 )
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_NONE, DIST_Middle, 0);
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_LargeR, TARGET_ENE_0, DIST_Middle, 0);

		--30% 右手攻撃2回
		elseif NR_fate2 <= 60 then
			CommonNPC_SwitchOneHandMode(ai, goal)
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Middle, 0);
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Middle, 0);

		--40% 両手持ちコンボ
		else
			CommonNPC_SwitchBothHandMode(ai, goal)
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Middle, 0);
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_LargeR, TARGET_ENE_0, DIST_Middle, 0);		
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Middle, 0);		
		end
	
	else
		CommonNPC_SwitchOneHandMode(ai, goal)
		--右手強攻撃１回
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_LargeR, TARGET_ENE_0, DIST_Middle, 0);

		--30% 右手強攻撃２回
		if NR_fate3 <= 30 then
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_LargeR, TARGET_ENE_0, DIST_Middle, 0);
		end
	end
end	



---------------------------------------------------------
--  攻撃後の行動
---------------------------------------------------------
function TroisM_B838000Battle_Kougeki_Noato(ai, goal)

local KN_fate = ai:GetRandam_Int(1,100)			--確率判定用
local KN_fate2 = ai:GetRandam_Int(1,100)			--確率判定用

	--50% バックステップ
	if KN_fate <= 50 then
		goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepB, TARGET_ENE_0, DIST_None, 0);

	--25% 左サイドステップ
	elseif KN_fate <= 25	then
		goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepL, TARGET_ENE_0, DIST_None, 0);

	--25% 右サイドステップ
	else
		goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepR, TARGET_ENE_0, DIST_None, 0);
	end

	--50% ステップ後旋回
	if KN_fate2 <= 50 then
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, ai:GetRandam_Int(2,4), TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(25,55), false, true ,-1 );
	end
end




---------------------------------------------------------
--  ゴール更新
---------------------------------------------------------
function TroisM_B838000Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  ゴール終了
---------------------------------------------------------
function TroisM_B838000Battle_Terminate(ai, goal)
end



---------------------------------------------------------
--  割り込み
--	割り込んだ場合にはtrueを返してください。
--	ここで割り込み用のサブゴールを追加してください。
--	割り込まなかった場合には、1つ上の層のゴール、またはロジック部分によって割り込みが処理されます。
---------------------------------------------------------
function TroisM_B838000Battle_Interupt(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);			--敵ターゲットとの距離を取得

local fate = ai:GetRandam_Int(1,100)					--確率判定用
local fate2 = ai:GetRandam_Int(1,100)					--確率判定用
local fate3 = ai:GetRandam_Int(1,100)					--確率判定用
local fate4 = ai:GetRandam_Int(1,100)					--確率判定用

local NormalR_Dist = 2.0			--右手攻撃の適正間合い


	--空振りしたら攻撃
	if ai:IsInterupt( INTERUPT_MissSwing ) then
local MissSwingDist = 2.0			--空振り追撃する距離
local MissSwingAttPer = 20			--空振り追撃する確率	
		if targetDist <= MissSwingDist then
			if fate <= MissSwingAttPer then
				goal:ClearSubGoal();
				TroisM_B838000Battle_NormalR_Comb(ai, goal)
				TroisM_B838000Battle_Kougeki_Noato(ai, goal)
				return true;
			end
		end	
	end

	
	--至近距離でダメージ受けたらコンボとみなして反撃・後退
	if ai:IsInterupt( INTERUPT_Damaged ) then
local combRunDist = 1.0				--コンボ逃れする距離
local combRunPer = 40				--コンボ逃れする確率
local combRunCountPer = 20			--コンボ逃れの後に攻撃する確率	
		if targetDist < combRunDist then
			if fate <= combRunPer then
				goal:ClearSubGoal();
				--逃れる
				TroisM_B838000Battle_Kougeki_Noato(ai, goal)

				--コンボ逃れ後の攻撃
				if fate3 <= combRunCountPer then
					goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, -1 );
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
				TroisM_B838000Battle_Kougeki_Noato(ai, goal)
				return true;
			end
		end
	end
	
	--ガード崩壊したら攻撃
	if ai:IsInterupt( INTERUPT_GuardBreak ) then
local guardBreakConutDist = 3.0			--ガード崩壊で攻撃する距離
local guardBreakConutPer = 70			--ガード崩壊で攻撃する確率
		if targetDist <= guardBreakConutDist then
			if fate <= guardBreakConutPer then
				goal:ClearSubGoal();
				CommonNPC_SwitchOneHandMode(ai, goal)
				goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, -1 );
				goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_LargeR, TARGET_ENE_0, DIST_Near, 0);
				TroisM_B838000Battle_Kougeki_Noato(ai, goal)
				return true;
			end
		end
	end
	
	--飛び道具を撃ってきたら最適行動
	if ai:IsInterupt( INTERUPT_Shoot ) then
local shootIntPer = 70					--飛び道具使用時に最適行動を取る確率
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
local itemUseIntPer = 40				--アイテム使用時に最適行動を取る確率
		if fate <= itemUseIntPer then
			goal:ClearSubGoal();		
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, -1 );
			TroisM_B838000Battle_NormalR_Comb(ai, goal)
			TroisM_B838000Battle_Kougeki_Noato(ai, goal)
			return true
		end
	end
	
return false;
end

