-----------------------------------------------------------------------------------------------
--	ビヨ用戦闘
--	説明：
--
--	パラメータ0  なし
--	パラメータ1  なし
--	パラメータ2  なし
--	パラメータ3　なし
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_Biyo_808000_Battle, "biyo_808000Battle");

-- Updateでなにもやっていないので、呼ばないようにする
REGISTER_GOAL_NO_UPDATE( GOAL_Biyo_808000_Battle, 1 );


---------------------------------------------------------
--  ゴール起動
---------------------------------------------------------
function biyo_808000Battle_Activate(ai, goal)
-------------------------------------------------------------------------------

local targetDist = ai:GetDist(TARGET_ENE_0);			--敵ターゲットとの距離を取得
local targetDistY = ai:GetDistYSigned(TARGET_ENE_0);				--敵ターゲットとの高低差を取得

local Dragon_Dist = 40.0					--飛竜との適性距離
local NormalR_Dist = 2.0					--右手攻撃の適正間合い

	--飛竜と戦う距離なら
	if targetDistY >= 10.0 then
		--飛竜専用攻撃
		biyo_808000Battle_Dragon_Attack(ai, goal)
		
	--攻撃するには遠すぎるなら
	elseif targetDist >= 15.0 then
		--走って近づいて様子を見る
		goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 4.0, TARGET_ENE_0, 8.0, TARGET_ENE_0, false, -1 );
		goal:AddSubGoal( GOAL_COMMON_Wait, 3.0, TARGET_ENE_0, 0, 0, 0 );
		
	--ボウガンで攻撃する距離なら
	elseif targetDist >= 6.0 then
		--遠距離攻撃
		biyo_808000Battle_Normal_FarAttack(ai, goal)
			
	--剣で攻撃する距離なら
	else
		--近距離攻撃
		biyo_808000Battle_Normal_NearAttack(ai, goal)
	end
end

---------------------------------------------------------
--  飛竜攻撃パターン
---------------------------------------------------------
function biyo_808000Battle_Dragon_Attack(ai, goal)

local fate = ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字
local NormalL_Dist = ai:GetRandam_Int(50,60)	--対飛竜戦の適性間合い

	--30% 近づいて発射
	if fate <= 30 then
		goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 4.0, TARGET_ENE_0, NormalL_Dist, TARGET_ENE_0, false, -1 );
		biyo_808000Battle_NormalL_Comb(ai, goal)
		biyo_808000Battle_Kougeki_Noato2(ai, goal)

	--70% 横移動してから発射
	else
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, ai:GetRandam_Int(1,3), TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(35,50), false, true ,-1 );
		goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 4.0, TARGET_ENE_0, NormalL_Dist, TARGET_ENE_0, false, -1 );
		biyo_808000Battle_NormalL_Comb(ai, goal)
		biyo_808000Battle_Kougeki_Noato2(ai, goal)
	end

end

---------------------------------------------------------
--  遠距離攻撃パターン
---------------------------------------------------------
function biyo_808000Battle_Normal_FarAttack(ai, goal)

local fate = ai:GetRandam_Int(1,100)		--確率判定で使用する運命の数字
local NormalR_Dist = 2.0					--右手攻撃の適正間合い

	--30% その場で発射
	if fate <= 30 then
		biyo_808000Battle_NormalL_Comb(ai, goal)
		biyo_808000Battle_Kougeki_Noato(ai, goal)

	--50% 横移動してから発射
	elseif fate <= 80 then
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, 2.5, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(25,45), false, true ,-1 );
		biyo_808000Battle_NormalL_Comb(ai, goal)
		biyo_808000Battle_Kougeki_Noato(ai, goal)
		
	--20% 走って近づいて攻撃
	else
		goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 4.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, -1 );
		biyo_808000Battle_NormalR_Comb(ai, goal)
		biyo_808000Battle_Kougeki_Noato(ai, goal)
	
	end
end

---------------------------------------------------------
--  近距離攻撃パターン
---------------------------------------------------------
function biyo_808000Battle_Normal_NearAttack(ai, goal)

local fate = ai:GetRandam_Int(1,100)		--確率判定で使用する運命の数字
local NormalR_Dist = 2.0					--右手攻撃の適正間合い

	--40% 走って近づいて攻撃
	if fate <= 40 then
		goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 4.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, true, -1 );
		biyo_808000Battle_NormalR_Comb(ai, goal)
		biyo_808000Battle_Kougeki_Noato(ai, goal)

	--40% 走って近づいてガードしながら回り込んで攻撃
	elseif fate <= 80 then
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, 2.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(35,55), false, true , -1 );
		goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 4.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, -1 );
		biyo_808000Battle_NormalR_Comb(ai, goal)
		biyo_808000Battle_Kougeki_Noato(ai, goal)
	--20% 距離を取る
	else 
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 5.0, TARGET_ENE_0, ai:GetRandam_Int(6,8), TARGET_ENE_0, false, -1 );
	end
end

---------------------------------------------------------
--  右手コンボ（近距離）
---------------------------------------------------------
function biyo_808000Battle_NormalR_Comb(ai, goal)

local NR_fate = ai:GetRandam_Int(1,100)			--確率判定用

	--30% 右手攻撃2回
	--70% 強攻撃2回

	if NR_fate <= 30 then
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Middle, 0);
	else
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_LargeR, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_LargeR, TARGET_ENE_0, DIST_Middle, 0);
	end
end
	
---------------------------------------------------------
--  左手攻撃（遠距離）
---------------------------------------------------------
function biyo_808000Battle_NormalL_Comb(ai, goal)

local NR_fate = ai:GetRandam_Int(1,100)			--確率判定用

	--100% 左手攻撃
	-- 30% 左手攻撃２

	goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalL, TARGET_ENE_0, DIST_None, 0);

	if NR_fate <= 10 then
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalL, TARGET_ENE_0, DIST_None, 0);
	end	

end

	
---------------------------------------------------------
--  攻撃後の行動
---------------------------------------------------------
function biyo_808000Battle_Kougeki_Noato(ai, goal)

local KN_fate = ai:GetRandam_Int(1,100)			--確率判定用
local BackDist = 3.5							--後退する距離


	--50％　横に移動
	--50％　後ろに移動
	if KN_fate <= 50 then
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, ai:GetRandam_Int(2,4), TARGET_ENE_0, BackDist, TARGET_ENE_0, false, -1 );				
		goal:AddSubGoal( GOAL_COMMON_SidewayMove, ai:GetRandam_Int(3,5), TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(45,60), false, true , -1 );
	else
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, ai:GetRandam_Int(4,6), TARGET_ENE_0, BackDist, TARGET_ENE_0, true, -1 );				

	end
end


---------------------------------------------------------
--  攻撃後の行動2
---------------------------------------------------------
function biyo_808000Battle_Kougeki_Noato2(ai, goal)

local KN_fate = ai:GetRandam_Int(1,100)			--確率判定用
local KN_fate2 = ai:GetRandam_Int(1,100)		--確率判定用
local BackDist = 5.0

	if KN_fate <= 70 then
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 10.0, TARGET_ENE_0, BackDist, TARGET_ENE_0, false, -1 );				
		goal:AddSubGoal( GOAL_COMMON_SidewayMove, ai:GetRandam_Int(3,5), TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(45,60), false, true , -1 );

	else
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 10.0, TARGET_ENE_0, BackDist, TARGET_ENE_0, true, -1 );				
	end
end


---------------------------------------------------------
--  ゴール更新
---------------------------------------------------------
function biyo_808000Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  ゴール終了
---------------------------------------------------------
function biyo_808000Battle_Terminate(ai, goal)
end



---------------------------------------------------------
--  割り込み
--	割り込んだ場合にはtrueを返してください。
--	ここで割り込み用のサブゴールを追加してください。
--	割り込まなかった場合には、1つ上の層のゴール、またはロジック部分によって割り込みが処理されます。
---------------------------------------------------------
function biyo_808000Battle_Interupt(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);			--敵ターゲットとの距離を取得

local fate = ai:GetRandam_Int(1,100)					--確率判定用
local fate2 = ai:GetRandam_Int(1,100)					--確率判定用
local fate3 = ai:GetRandam_Int(1,100)					--確率判定用
local fate4 = ai:GetRandam_Int(1,100)					--確率判定用

local BackDist = 3.5				--後退する距離
local NormalR_Dist = 2.0			--右手攻撃の適正間合い

	--空振りしたら攻撃
	if ai:IsInterupt( INTERUPT_MissSwing ) then
local MissSwingDist = 4.0			--空振り追撃する距離
local MissSwingAttPer = 40			--空振り追撃する確率	
		if targetDist <= MissSwingDist then
			if fate <= MissSwingAttPer then
				goal:ClearSubGoal();
				goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, -1 );
				biyo_808000Battle_NormalR_Comb(ai, goal)
				biyo_808000Battle_Kougeki_Noato(ai, goal)
				return true;
			end
		end	
	end

	--至近距離でダメージ受けたらコンボとみなして後退・旋回（投げ）
	if ai:IsInterupt( INTERUPT_Damaged ) then
local combRunDist = 2.0				--コンボ逃れする距離
local combRunPer = 40				--コンボ逃れする確率
		if targetDist < combRunDist then
			if fate <= combRunPer then
				goal:ClearSubGoal();
				--逃れる
				if fate2 <= 60 then
					goal:AddSubGoal(GOAL_COMMON_SidewayMove, 2.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(25,45), false, true , -1 );
				else
					goal:AddSubGoal( GOAL_COMMON_LeaveTarget, ai:GetRandam_Int(2,4), TARGET_ENE_0, BackDist, TARGET_ENE_0, false, -1 );
				end	
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
				biyo_808000Battle_NormalR_Comb(ai, goal)
				biyo_808000Battle_Kougeki_Noato(ai, goal)
				return true;
			end
		end
	end
	
	--飛び道具を撃ってきたら最適行動
	if ai:IsInterupt( INTERUPT_Shoot ) then
local shootIntPer = 10					--飛び道具使用時に最適行動を取る確率
		if fate <= shootIntPer then
			goal:ClearSubGoal();
			if fate2 <= 50 then
				goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepL, TARGET_ENE_0, DIST_None, 0);
			else
				goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepR, TARGET_ENE_0, DIST_None, 0);
			end
			return true;
		end
	end
	
	
	--敵がガード開始したら後退・旋回をする
	if ai:IsInterupt( INTERUPT_GuardBegin ) then
local GuardBeginMovePer = 70			--ガード開始時に移動をする確率
		if fate <= GuardBeginMovePer then
			goal:ClearSubGoal();
			if fate2 <= 20 then
				goal:AddSubGoal( GOAL_COMMON_LeaveTarget, ai:GetRandam_Int(2,4), TARGET_ENE_0, 5.0, TARGET_ENE_0, true, -1 );
			else
				goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 1.5, TARGET_ENE_0, 2.5, TARGET_ENE_0, true, -1 );
				goal:AddSubGoal(GOAL_COMMON_SidewayMove, ai:GetRandam_Int(2,4), TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(30,55), true, true ,-1 );
			end
			return true
		end
	end
	


return false;
end

