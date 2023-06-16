--[[---------------------------------------------------------------------------------------------
--	マスターサツキ用戦闘
--	説明：
--
--	パラメータ0  なし
--	パラメータ1  なし
--	パラメータ2  なし
--	パラメータ3　なし

--	Number(0)　：　回復薬を使う回数制御用
--　Number(1)　：　戦闘開始をちょっと待つ制御用

-----------------------------------------------------------------------------------------------]]
REGISTER_GOAL(GOAL_satuki830000_Battle, "satuki830000Battle");

-- Updateでなにもやっていないので、呼ばないようにする
REGISTER_GOAL_NO_UPDATE( GOAL_satuki830000_Battle, 1 );


---------------------------------------------------------
--  ゴール起動
---------------------------------------------------------
function satuki830000Battle_Activate(ai, goal)
-------------------------------------------------------------------------------

local targetDist = ai:GetDist(TARGET_ENE_0);	--敵ターゲットとの距離を取得
local waitDist = 25								--攻撃をちょっと待つ距離
local waitTime = 3.5							--最初の動き出しまでの時間

--[[------------------------------------------------------
-- イベントリクエストを見て、誠を渡されていたら誠に持ち替える
---------------------------------------------------------]]

	if ( 10 == ai:GetEventRequest() ) then
	CommonNPC_ChangeWepR2(ai, goal) 
	end

--[[------------------------------------------------------
-- プレイヤーがブロックに入ってきたときに一回だけちょっと待つ
---------------------------------------------------------]]

	if targetDist >= waitDist then
		if ( 0 == ai:GetNumber(1) ) then
			goal:AddSubGoal( GOAL_COMMON_Wait, waitTime, TARGET_NONE, 0, 0, 0 );
		end
	end
	
	--もう待たない
	ai:SetNumber(1,1);
	satuki830000Battle_Normal_Act(ai, goal)
	
end

---------------------------------------------------------
-- 基本行動
---------------------------------------------------------
function satuki830000Battle_Normal_Act(ai, goal)

local hprate = ai:GetHpRate( TARGET_SELF )		--自分のHP割合を取得

	--自分のHPが3割以下なら
	if hprate <= 0.3 then

		--10回まで回復薬を使う
		if ( 10 >= ai:GetNumber(0) ) then
		
			--瀕死行動
			satuki830000Battle_Dying_Attack(ai, goal)
	local 	count = ai:GetNumber(0);
			count = count + 1;
			ai:SetNumber( 0, count ) ;

		end
	end

	--基本攻撃
	satuki830000Battle_Normal_Attack(ai, goal)

end

---------------------------------------------------------
-- 基本攻撃
---------------------------------------------------------
function satuki830000Battle_Normal_Attack(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);			--敵ターゲットとの距離を取得

local DashStart_Dist = 10.0			--ダッシュ攻撃を開始する距離
local NormalR_Dist = 2.0			--右手攻撃の適正間合い
local DashR_Dist = 5.0				--ダッシュ攻撃の発動距離

local fate = ai:GetRandam_Int(1,100)		--確率判定で使用する運命の数字
local fate2 = ai:GetRandam_Int(1,100)		--確率判定で使用する運命の数字　その２


	--ダッシュ攻撃できる距離なら
	if targetDist >= DashStart_Dist then
		
		--100% ダッシュ攻撃後、通常攻撃
		goal:AddSubGoal( GOAL_COMMON_DashAttack, 10.0, TARGET_ENE_0, DashR_Dist, NPC_ATK_NormalR, -1);
		satuki830000Battle_NormalR_Comb(ai, goal)
		satuki830000Battle_Kougeki_Noato(ai, goal)

	--ダッシュ攻撃できない距離なら
	elseif	targetDist >= NormalR_Dist then

		--100% 走って近づいて攻撃
		goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 3.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, -1 );
		satuki830000Battle_NormalR_Comb(ai, goal)
		satuki830000Battle_Kougeki_Noato(ai, goal)

	--極端に近いなら
	else
		--30% 攻撃
		--70% ステップで後退
		if fate <= 30 then
			satuki830000Battle_NormalR_Comb(ai, goal)
			satuki830000Battle_Kougeki_Noato(ai, goal)
		else
			if fate2 <= 20 then
				goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepB, TARGET_ENE_0, DIST_None, 0);
			elseif fate2 <= 60 then
				goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepL, TARGET_ENE_0, DIST_None, 0);
			else
				goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepR, TARGET_ENE_0, DIST_None, 0);
			end
		end
	end
end


---------------------------------------------------------
-- 瀕死行動
---------------------------------------------------------
function satuki830000Battle_Dying_Attack(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);			--敵ターゲットとの距離を取得

local NormalR_Dist = 2.0			--右手攻撃の適正間合い
local ItemUesDist = 10.0			--アイテムを使うか判断する距離
local BackDist = 6.0				--アイテム使用前に後退する距離

local fate = ai:GetRandam_Int(1,100)		--確率判定で使用する運命の数字
local fate2 = ai:GetRandam_Int(1,100)		--確率判定で使用する運命の数字２

	--遠いなら
	if targetDist >= ItemUesDist then
	
		--その場でアイテム使用
		goal:AddSubGoal( GOAL_COMMON_UseItem, 10.0, 0 );
		satuki830000Battle_Kougeki_Noato(ai, goal)
		
	--近いなら
	elseif targetDist >= NormalR_Dist then
	
		--後退してアイテム使用
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 10.0, TARGET_ENE_0, BackDist, TARGET_ENE_0, false, -1 );
		goal:AddSubGoal( GOAL_COMMON_UseItem, 10.0, 0 );
		satuki830000Battle_Kougeki_Noato(ai, goal)

	--極端に近いなら
	else
	
		--攻撃して威嚇してからステップ後退してアイテム使用
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
		
		--ステップ後退
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_StepB, TARGET_ENE_0, DIST_None, 0);
		
		--移動
		if fate2 <= 50 then
			goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 10.0, TARGET_ENE_0, BackDist, TARGET_ENE_0, false, -1 );
		else
			goal:AddSubGoal( GOAL_COMMON_SidewayMove, 3.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), 25, false, true ,-1 );
			goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 10.0, TARGET_ENE_0, BackDist, TARGET_ENE_0, false, -1 );		
		end
		
		--アイテム使用
		goal:AddSubGoal( GOAL_COMMON_UseItem, 10.0, 0 );
		satuki830000Battle_Kougeki_Noato(ai, goal)

	end
end


---------------------------------------------------------
--  右手コンボ（通常）
---------------------------------------------------------
function satuki830000Battle_NormalR_Comb(ai, goal)

local NR_fate = ai:GetRandam_Int(1,100)			--確率判定用
local NR_fate2 = ai:GetRandam_Int(1,100)		--確率判定用
local NR_fate3 = ai:GetRandam_Int(1,100)		--確率判定用

	--70% 片手攻撃
	if NR_fate <= 70 then
	
		--片手持ちに切り替える
		CommonNPC_SwitchOneHandMode(ai, goal)
		
		--70% 片手攻撃4回
		if NR_fate2 <= 70 then
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
		
		--30% 片手攻撃3回・強入り
		else
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_LargeR, TARGET_ENE_0, DIST_Near, 0);
		end
	
	--30% 両手攻撃
	else
	
		--両手持ちに切り替える
		CommonNPC_SwitchBothHandMode(ai, goal)
		
		--70% 両手攻撃2回
		if NR_fate3 <= 70 then
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
		
		--30% 両手攻撃3回・強入り
		else
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_LargeR, TARGET_ENE_0, DIST_Near, 0);
			
		end
	end	
end

---------------------------------------------------------
--  右手コンボ（止め）
---------------------------------------------------------
function satuki830000Battle_Todome_Comb(ai, goal)

local NR_fate = ai:GetRandam_Int(1,100)			--確率判定用

	--50% 片手攻撃
	--50% 両手攻撃

	if NR_fate <= 50 then
		CommonNPC_SwitchBothHandMode(ai, goal)
		
	else
		CommonNPC_SwitchOneHandMode(ai, goal)
	
	end
	
	goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
	goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
	goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_LargeR, TARGET_ENE_0, DIST_Near, 0);

end
	
	
---------------------------------------------------------
--  攻撃後の行動
---------------------------------------------------------
function satuki830000Battle_Kougeki_Noato(ai, goal)

local KN_fate = ai:GetRandam_Int(1,100)			--確率判定用
local KN_fate2 = ai:GetRandam_Int(1,100)		--確率判定用
local BackDist = 2.5							--後退する距離

	--50% 横に移動
	--15% 後ろに移動してから横移動
	--20% ステップで後退
	if KN_fate <= 65 then
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, ai:GetRandam_Int(2,4), TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(25,55), false, true ,-1 );

	elseif KN_fate <= 80 then
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 2.0, TARGET_ENE_0, BackDist, TARGET_ENE_0, false, -1 );				
		goal:AddSubGoal( GOAL_COMMON_SidewayMove, 2.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), 45, false, true ,-1 );

	else
		if KN_fate2 <= 40 then
			goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepB, TARGET_ENE_0, DIST_None, 0);
		elseif KN_fate2 <= 70 then
			goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepL, TARGET_ENE_0, DIST_None, 0);
		else
			goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepR, TARGET_ENE_0, DIST_None, 0);
		end			
	end
end




---------------------------------------------------------
--  ゴール更新
---------------------------------------------------------
function satuki830000Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  ゴール終了
---------------------------------------------------------
function satuki830000Battle_Terminate(ai, goal)
end



---------------------------------------------------------
--  割り込み
--	割り込んだ場合にはtrueを返してください。
--	ここで割り込み用のサブゴールを追加してください。
--	割り込まなかった場合には、1つ上の層のゴール、またはロジック部分によって割り込みが処理されます。
---------------------------------------------------------
function satuki830000Battle_Interupt(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);			--敵ターゲットとの距離を取得

local fate = ai:GetRandam_Int(1,100)					--確率判定用
local fate2 = ai:GetRandam_Int(1,100)					--確率判定用
local fate3 = ai:GetRandam_Int(1,100)					--確率判定用
local fate4 = ai:GetRandam_Int(1,100)					--確率判定用

local NormalR_Dist = 2.0			--右手攻撃の適正間合い

	--空振りしたら攻撃
	if ai:IsInterupt( INTERUPT_MissSwing ) then
local MissSwingDist = 4.0			--空振り追撃する距離
local MissSwingAttPer = 50			--空振り追撃する確率	
		if targetDist <= MissSwingDist then
			if fate <= MissSwingAttPer then
				goal:ClearSubGoal();
				goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 3.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, -1 );
				goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_LargeR, TARGET_ENE_0, DIST_Near, 0);
				satuki830000Battle_Kougeki_Noato(ai, goal)
				return true;
			end
		end	
	end

	--至近距離でダメージ受けたらコンボとみなして後退
	if ai:IsInterupt( INTERUPT_Damaged ) then
local combRunDist = 1.0				--コンボ逃れする距離
local combRunPer = 60				--コンボ逃れする確率
		if targetDist < combRunDist then
			if fate <= combRunPer then
				goal:ClearSubGoal();
				--逃れる
				if fate2 <= 20 then
					goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepB, TARGET_ENE_0, DIST_None, 0);
				elseif fate2 <= 60 then
					goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepL, TARGET_ENE_0, DIST_None, 0);
				else
					goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepR, TARGET_ENE_0, DIST_None, 0);
				end	
				return true;
			end
		end
	end	
	
	--至近距離で攻撃されそうになったら超反応ステップ
	if ai:IsInterupt( INTERUPT_FindAttack ) then
local superStepDist = 2.0			--超反応する距離
local superStepPer = 20				--超反応する確率	
		if targetDist <= superStepDist then
			if fate <= superStepPer then
			--逃れる
				if fate2 <= 20 then
					goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepB, TARGET_ENE_0, DIST_None, 0);
				elseif fate2 <= 60 then
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
local guardBreakConutPer = 60			--ガード崩壊で攻撃する確率
		if targetDist <= guardBreakConutDist then
			if fate <= guardBreakConutPer then
				goal:ClearSubGoal();
				goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 3.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, -1 );
				goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_LargeR, TARGET_ENE_0, DIST_Near, 0);
				satuki830000Battle_Kougeki_Noato(ai, goal)
				return true;
			end
		end
	end
	
	--飛び道具を撃ってきたら最適行動
	if ai:IsInterupt( INTERUPT_Shoot ) then
local shootIntPer = 60					--飛び道具使用時に最適行動を取る確率
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
local itemUseIntPer = 40			--アイテム使用時に最適行動を取る確率
		if fate <= itemUseIntPer then
				goal:ClearSubGoal();
				goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 3.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, -1 );
				goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_LargeR, TARGET_ENE_0, DIST_Near, 0);
				satuki830000Battle_Kougeki_Noato(ai, goal)
			return true
		end
	end
	
	--敵がガード終了したら攻撃
	if ai:IsInterupt( INTERUPT_GuardFinish ) then
local GuardFinishAttackPer = 30			--ガード終了後に攻撃をする確率
		if fate <= GuardFinishAttackPer then
			goal:ClearSubGoal();
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, -1 );
			satuki830000Battle_NormalR_Comb(ai, goal)
			satuki830000Battle_Kougeki_Noato(ai, goal)
			return true
		end
	end

	--敵のガードで武器がはじかれたら左右ステップをする（右優先）
	if ai:IsInterupt( INTERUPT_ReboundByOpponentGuard ) then
local GuardReboundMovePer = 30			--はじかれた時に移動をする確率
		if fate <= GuardReboundMovePer then
			goal:ClearSubGoal();
			if fate2 <= 80 then
				goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepR, TARGET_ENE_0, DIST_None, 0);
			else
				goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepL, TARGET_ENE_0, DIST_None, 0);
			end
			return true;
		end
	end
	
return false;
end


