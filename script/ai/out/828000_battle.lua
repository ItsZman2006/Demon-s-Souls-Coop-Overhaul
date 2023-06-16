-----------------------------------------------------------------------------------------------
--	物識り用戦闘
--	説明：
--
--	パラメータ0  なし
--	パラメータ1  なし
--	パラメータ2  なし
--	パラメータ3　なし
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_Monosiri_828000_Battle, "monosiri_828000Battle");

-- Updateでなにもやっていないので、呼ばないようにする
REGISTER_GOAL_NO_UPDATE( GOAL_Monosiri_828000_Battle, 1 );


---------------------------------------------------------
--  ゴール起動
---------------------------------------------------------
function monosiri_828000Battle_Activate(ai, goal)
-------------------------------------------------------------------------------

local targetDist = ai:GetDist(TARGET_ENE_0);			--敵ターゲットとの距離を取得
local fate = ai:GetRandam_Int(1,100)		--確率判定で使用する運命の数字
local fate2 = ai:GetRandam_Int(1,100)		--確率判定で使用する運命の数字　その２

--local farDist = 15.0						--遠いと判断する距離
--local nearDist = 4.0						--近いと判断する距離
local NormalR_Dist = 2.5					--右手攻撃の適正間合い

	--極端に近くないなら
	if targetDist >= NormalR_Dist then
		--100％　歩いて近づいてくる	
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 3.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, -1 );
			monosiri_828000Battle_NormalR_Comb(ai, goal)
			monosiri_828000Battle_Kougeki_Noato(ai, goal)
		
	--極端に近いなら
	else
		--85％　攻撃
		--15％　ステップで後退
		if fate <= 85 then
			monosiri_828000Battle_NormalR_Comb(ai, goal)
			monosiri_828000Battle_Kougeki_Noato(ai, goal)
		else
			if fate2 <= 60 then
				goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepB, TARGET_ENE_0, DIST_None, 0);
			elseif fate2 <= 80 then
				goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepL, TARGET_ENE_0, DIST_None, 0);
			else
				goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepR, TARGET_ENE_0, DIST_None, 0);
			end
		end
	end
end

---------------------------------------------------------
--  右手コンボ
---------------------------------------------------------
function monosiri_828000Battle_NormalR_Comb(ai, goal)

local NR_fate = ai:GetRandam_Int(1,100)			--確率判定用
local NR_fate2 = ai:GetRandam_Int(1,100)		--確率判定用
local NR_fate3 = ai:GetRandam_Int(1,100)		--確率判定用
local NR_fate4 = ai:GetRandam_Int(1,100)		--確率判定用

	--右手攻撃
	--50% 右手攻撃
	--0% 右手攻撃
	--0% 右手攻撃
	--25% 右手大攻撃
	goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Middle, 0);

	if NR_fate <= 50 then
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Middle, 0);
	end
	
--	if NR_fate2 <= 50 then
--		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Middle, 0);
--	end
	
--	if NR_fate3 <= 25 then
--		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Middle, 0);
--	end	

	if NR_fate4 <= 25 then
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_LargeR, TARGET_ENE_0, DIST_Middle, 0);
	end
end
	
	
---------------------------------------------------------
--  攻撃後の行動
---------------------------------------------------------
function monosiri_828000Battle_Kougeki_Noato(ai, goal)

local KN_fate = ai:GetRandam_Int(1,100)			--確率判定用
local KN_fate2 = ai:GetRandam_Int(1,100)		--確率判定用
local BackDist = 2.5							--後退する距離



--後ろに下がった後にときどき横移動させると良いかも
--あまりに近すぎる横移動よりも、すこし下がってから横移動させると良いかも

	--50％　少し待つ
	--25％　横に移動
	--15％　後ろに移動
	--10％　ステップで後退
	if KN_fate <= 50 then
		goal:AddSubGoal( GOAL_COMMON_Wait, 1.0, TARGET_NONE, 0, 0, 0 );
	elseif KN_fate <= 75 then
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, 2.5, TARGET_ENE_0, ai:GetRandam_Int(0,1), 45, true, true ,-1 );
	elseif KN_fate <= 90 then
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 3.0, TARGET_ENE_0, BackDist, TARGET_ENE_0, true, -1 );				
	else
		if KN_fate2 <= 60 then
			goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepB, TARGET_ENE_0, DIST_None, 0);
		elseif KN_fate2 <= 80 then
			goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepL, TARGET_ENE_0, DIST_None, 0);
		else
			goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepR, TARGET_ENE_0, DIST_None, 0);
		end			
	end
end




---------------------------------------------------------
--  ゴール更新
---------------------------------------------------------
function monosiri_828000Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  ゴール終了
---------------------------------------------------------
function monosiri_828000Battle_Terminate(ai, goal)
end



---------------------------------------------------------
--  割り込み
--	割り込んだ場合にはtrueを返してください。
--	ここで割り込み用のサブゴールを追加してください。
--	割り込まなかった場合には、1つ上の層のゴール、またはロジック部分によって割り込みが処理されます。
---------------------------------------------------------
function monosiri_828000Battle_Interupt(ai, goal)

--	local hprate = ai:GetHpRate( TARGET_SELF )				--自分のHP割合を取得
--	local targethprate = ai:GetHpRate( TARGET_ENE_0 )		--敵ターゲットのHP割合を取得
local targetDist = ai:GetDist(TARGET_ENE_0);			--敵ターゲットとの距離を取得

local fate = ai:GetRandam_Int(1,100)					--確率判定用
local fate2 = ai:GetRandam_Int(1,100)					--確率判定用
local fate3 = ai:GetRandam_Int(1,100)					--確率判定用
local fate4 = ai:GetRandam_Int(1,100)					--確率判定用

local NormalR_Dist = 2.5			--右手攻撃の適正間合い

	--空振りしたら攻撃
	if ai:IsInterupt( INTERUPT_MissSwing ) then
local MissSwingDist = 4.0			--空振り追撃する距離
local MissSwingAttPer = 30			--空振り追撃する確率	
		if targetDist <= MissSwingDist then
			if fate <= MissSwingAttPer then
				goal:ClearSubGoal();
				monosiri_828000Battle_NormalR_Comb(ai, goal)
				monosiri_828000Battle_Kougeki_Noato(ai, goal)
				return true;
			end
		end	
	end

	--至近距離でダメージ受けたらコンボとみなして後退
	if ai:IsInterupt( INTERUPT_Damaged ) then
local combRunDist = 1.0				--コンボ逃れする距離
local combRunPer = 65				--コンボ逃れする確率
local combRunCountPer = 35			--コンボ逃れの後に攻撃する確率	
		if targetDist < combRunDist then
			if fate <= combRunPer then
				goal:ClearSubGoal();
				--逃れる
				if fate2 <= 60 then
					goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepB, TARGET_ENE_0, DIST_None, 0);
				elseif fate2 <= 80 then
					goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepL, TARGET_ENE_0, DIST_None, 0);
				else
					goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepR, TARGET_ENE_0, DIST_None, 0);
				end	
					if fate3 <= combRunCountPer then
						goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Middle, 0);
					end
				return true;
			end
		end
	end	
	
	--至近距離で攻撃されそうになったら超反応ステップ
	if ai:IsInterupt( INTERUPT_FindAttack ) then
local superStepDist = 2.0			--コンボ逃れする距離
local superStepPer = 20				--コンボ逃れする確率	
		if targetDist <= superStepDist then
			if fate <= superStepPer then
			--逃れる
				if fate2 <= 60 then
					goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepB, TARGET_ENE_0, DIST_None, 0);
				elseif fate2 <= 80 then
					goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepL, TARGET_ENE_0, DIST_None, 0);
				else
					goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepR, TARGET_ENE_0, DIST_None, 0);
				end
				return true;
			end
		end
	end
	
	--ガード崩壊したら攻撃
	if ai:IsInterupt( INTERUPT_GuardBreak ) then
local guardBreakConutDist = 4.0			--ガード崩壊で攻撃する距離
local guardBreakConutPer = 65			--ガード崩壊で攻撃する確率
		if targetDist <= guardBreakConutDist then
			if fate <= guardBreakConutPer then
				goal:ClearSubGoal();
				monosiri_828000Battle_NormalR_Comb(ai, goal)
				monosiri_828000Battle_Kougeki_Noato(ai, goal)
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
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, -1 );
			monosiri_828000Battle_NormalR_Comb(ai, goal)
			monosiri_828000Battle_Kougeki_Noato(ai, goal)
			return true
		end
	end
	
	--アイテムを使ったら最適行動
	if ai:IsInterupt( INTERUPT_UseItem ) then
local itemUseIntPer = 50				--アイテム使用時に最適行動を取る確率
		if fate <= itemUseIntPer then
			goal:ClearSubGoal();		
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, -1 );
			monosiri_828000Battle_NormalR_Comb(ai, goal)
			monosiri_828000Battle_Kougeki_Noato(ai, goal)
			return true
		end
	end
	
return false;
end