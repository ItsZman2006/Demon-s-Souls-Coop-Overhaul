-----------------------------------------------------------------------------------------------
--	翁召還ブラック専用戦闘
--	説明：
--
--	パラメータ0  なし
--	パラメータ1  なし
--	パラメータ2  なし
--	パラメータ3　なし
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_OKINA_833000_Battle, "OKINA_833000Battle");

-- Updateでなにもやっていないので、呼ばないようにする
REGISTER_GOAL_NO_UPDATE( GOAL_OKINA_833000_Battle, 1 );


---------------------------------------------------------
--  ゴール起動
---------------------------------------------------------
function OKINA_833000Battle_Activate(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);			--敵ターゲットとの距離を取得
local fate = ai:GetRandam_Int(1,100)		--確率判定で使用する運命の数字
local fate2 = ai:GetRandam_Int(1,100)		--確率判定で使用する運命の数字　その２

local farDist = 15.0						--遠いと判断する距離
local nearDist = 4.0						--近いと判断する距離
local NormalR_Dist = 0.5			--右手攻撃の適正間合い
local DashR_Dist = 3.0				--ダッシュ攻撃の発動距離

	--左手に武器を持っていなければ持ち替える
	CommonNPC_ChangeWepL1(ai, goal)

	--遠くもないが、近くもないなら
	if targetDist >= nearDist then

		if fate <= 20 then
			OKINA_833000Battle_Magic_Comb(ai, goal)
		elseif fate <= 40 then
			goal:AddSubGoal( GOAL_COMMON_DashAttack, 10.0, TARGET_ENE_0, DashR_Dist, NPC_ATK_NormalR, -1);
			OKINA_833000Battle_NormalR_Comb(ai, goal)
			OKINA_833000Battle_Kougeki_Noato(ai, goal)
		else
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, -1 );
			OKINA_833000Battle_NormalR_Comb(ai, goal)
			OKINA_833000Battle_Kougeki_Noato(ai, goal)
		end
		
	--近いなら
	elseif targetDist >= NormalR_Dist then
		--100％　走って近づいてくる	
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 3.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, -1 );
			OKINA_833000Battle_NormalR_Comb(ai, goal)
			OKINA_833000Battle_Kougeki_Noato(ai, goal)
		
	--極端に近いなら
	else
		--65％　攻撃
		--35％　ステップで後退
		if fate <= 75 then
			OKINA_833000Battle_NormalR_Comb(ai, goal)
			OKINA_833000Battle_Kougeki_Noato(ai, goal)
		else
			if fate2 <= 50 then
				goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 5.0, TARGET_ENE_0, ai:GetRandam_Int(3,5), TARGET_ENE_0, false, -1 );
			else
				goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 2.0, TARGET_ENE_0, ai:GetRandam_Int(2,4), TARGET_ENE_0, false, -1 );
				goal:AddSubGoal( GOAL_COMMON_SidewayMove, 5.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(30,55), false, true ,-1 );
			end
		end
	end
end

---------------------------------------------------------
--  右手コンボ
---------------------------------------------------------
function OKINA_833000Battle_NormalR_Comb(ai, goal)

local NR_fate = ai:GetRandam_Int(1,100)			--確率判定用
local NR_fate2 = ai:GetRandam_Int(1,100)		--確率判定用
local NR_fate3 = ai:GetRandam_Int(1,100)		--確率判定用
local NR_fate4 = ai:GetRandam_Int(1,100)		--確率判定用

	
	--15％　右左右左右
	if NR_fate <= 15 then
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalL, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalL, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Middle, 0);
		
		--40％　追加　左
		if NR_fate2 <= 40 then
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalL, TARGET_ENE_0, DIST_Middle, 0);
		end
	
	--15％　左右左
	elseif NR_fate <= 30 then
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalL, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalL, TARGET_ENE_0, DIST_Middle, 0);
		
		--35％　追加　強
		if NR_fate2 <= 35 then
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_LargeR, TARGET_ENE_0, DIST_Middle, 0);
		end
	
	--15％　左右右右
	elseif NR_fate <= 45 then
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalL, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Middle, 0);

	--15％　強
	elseif NR_fate <= 60 then
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_LargeR, TARGET_ENE_0, DIST_Middle, 0);	
	
	--40％　前転右
	else
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_StepF, TARGET_ENE_0, DIST_None, 0);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_NONE, DIST_Middle, 0);
		
		--30％　追加　右右
		if NR_fate2 <= 30 then
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalL, TARGET_ENE_0, DIST_Middle, 0);
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Middle, 0);
		end
		
		--30％　追加　強
		if NR_fate3 <= 30 then
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_LargeR, TARGET_ENE_0, DIST_Middle, 0);
		end
	end	
end
	

---------------------------------------------------------
--  魔法攻撃
---------------------------------------------------------
function OKINA_833000Battle_Magic_Comb(ai, goal)

local selfmp = ai:GetMp(TARGET_SELF)			--自分の残りMPを取得
local NormalR_Dist = 0.5						--武器攻撃の間合い

	--魔法を使えるなら
	if selfmp >= 15 then
	
		--触媒に持ち替える
		CommonNPC_ChangeWepL2(ai, goal)

		--魔法で攻撃
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_Magic, TARGET_ENE_0, DIST_None, 0);
		OKINA_833000Battle_Kougeki_Noato(ai, goal)
	
	--魔法を使えないなら
	else

		--走って近づいて攻撃
		goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 3.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, -1 );
		OKINA_833000Battle_NormalR_Comb(ai, goal)
		OKINA_833000Battle_Kougeki_Noato(ai, goal)
	
	end
end	
	
---------------------------------------------------------
--  攻撃後の行動
---------------------------------------------------------
function OKINA_833000Battle_Kougeki_Noato(ai, goal)

local KN_fate = ai:GetRandam_Int(1,100)			--確率判定用
local BackDist = ai:GetRandam_Int(3,5)			--後退する距離


	if KN_fate <= 70 then
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 3.0, TARGET_ENE_0, BackDist, TARGET_ENE_0, false, -1 );	
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, 3.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(25,45), false, true ,-1 );
	else
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 5.0, TARGET_ENE_0, BackDist, TARGET_ENE_0, false, -1 );				
		
	end
end




---------------------------------------------------------
--  ゴール更新
---------------------------------------------------------
function OKINA_833000Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  ゴール終了
---------------------------------------------------------
function OKINA_833000Battle_Terminate(ai, goal)
end



---------------------------------------------------------
--  割り込み
--	割り込んだ場合にはtrueを返してください。
--	ここで割り込み用のサブゴールを追加してください。
--	割り込まなかった場合には、1つ上の層のゴール、またはロジック部分によって割り込みが処理されます。
---------------------------------------------------------
function OKINA_833000Battle_Interupt(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);			--敵ターゲットとの距離を取得

local fate = ai:GetRandam_Int(1,100)					--確率判定用
local fate2 = ai:GetRandam_Int(1,100)					--確率判定用
local fate3 = ai:GetRandam_Int(1,100)					--確率判定用
local fate4 = ai:GetRandam_Int(1,100)					--確率判定用

local NormalR_Dist = 0.5			--右手攻撃の適正間合

	--空振りしたら攻撃
	if ai:IsInterupt( INTERUPT_MissSwing ) then
local MissSwingDist = 3.0			--空振り追撃する距離
local MissSwingAttPer = 80			--空振り追撃する確率	
		if targetDist <= MissSwingDist then
			if fate <= MissSwingAttPer then
				goal:ClearSubGoal();
				OKINA_833000Battle_NormalR_Comb(ai, goal)
				OKINA_833000Battle_Kougeki_Noato(ai, goal)
				return true;
			end
		end	
	end

	--至近距離でダメージ受けたらコンボとみなして反撃・後退
	if ai:IsInterupt( INTERUPT_Damaged ) then
local combRunDist = 2.0				--コンボ逃れする距離
local combRunPer = 40				--コンボ逃れする確率
		if targetDist < combRunDist then
			if fate <= combRunPer then
				goal:ClearSubGoal();
				--逃れる
				goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_StepB, TARGET_ENE_0, DIST_None, 0);
				goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, -1 );
				OKINA_833000Battle_NormalR_Comb(ai, goal)
				OKINA_833000Battle_Kougeki_Noato(ai, goal)
				return true;
			end
		end
	end	
	
	--至近距離で攻撃されそうになったら超反応パリィ
	if ai:IsInterupt( INTERUPT_FindAttack ) then
local superStepDist = 2.0			--超反応する距離
local superStepPer = 80				--超反応する確率	
		if targetDist <= superStepDist then
			if fate <= superStepPer then
			--パリィ
			goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_Parry, TARGET_ENE_0, DIST_None, 0);
			goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Middle, 0);
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
				goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_StepL, TARGET_ENE_0, DIST_None, 0);
			else
				goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_StepR, TARGET_ENE_0, DIST_None, 0);
			end
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, -1 );
			OKINA_833000Battle_NormalR_Comb(ai, goal)
			OKINA_833000Battle_Kougeki_Noato(ai, goal)
			return true
		end
	end
	
	
	--アイテムを使ったら最適行動
	if ai:IsInterupt( INTERUPT_UseItem ) then
local itemUseIntPer = 100				--アイテム使用時に最適行動を取る確率
		if fate <= itemUseIntPer then
			goal:ClearSubGoal();
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, -1 );
			OKINA_833000Battle_NormalR_Comb(ai, goal)
			OKINA_833000Battle_Kougeki_Noato(ai, goal)
			return true
		end
	end
	 
	--敵がガード開始したらプッシュを行う
	if ai:IsInterupt( INTERUPT_GuardBegin ) then
local GuardBeginMovePer = 100			--ガード開始時にプッシュする確率
		if fate <= GuardBeginMovePer then
			goal:ClearSubGoal();
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, -1 );
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_PushR, TARGET_ENE_0, DIST_Near, 0);
			return true
		end
	end	
	
	
	--敵のガードで武器がはじかれたら
	if ai:IsInterupt( INTERUPT_ReboundByOpponentGuard ) then
local GuardReboundMovePer = 100			--はじかれた時に~をする確率
		if fate <= GuardReboundMovePer then
			goal:ClearSubGoal();
			if fate2 <= 50 then
				goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepR, TARGET_ENE_0, DIST_None, 0);
			else
				goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepL, TARGET_ENE_0, DIST_None, 0);
			end
			ai:Replaning();
			return true;
		end
	end
	
	--ガード崩壊したら攻撃
	if ai:IsInterupt( INTERUPT_GuardBreak ) then
local guardBreakConutDist = 1.0			--ガード崩壊で攻撃する距離
local guardBreakConutPer = 100			--ガード崩壊で攻撃する確率
		if targetDist <= guardBreakConutDist then
			if fate <= guardBreakConutPer then
				goal:ClearSubGoal();
				OKINA_833000Battle_NormalR_Comb(ai, goal)
				doran_822000Battle_Kougeki_Noato(ai, goal)
				return true;
			end
		end
	end	
	
	
return false;
end

