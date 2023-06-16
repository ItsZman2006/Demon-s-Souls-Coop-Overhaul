-----------------------------------------------------------------------------------------------
--	ユルト用戦闘
--	説明：
--
--	パラメータ0  なし
--	パラメータ1  なし
--	パラメータ2  なし
--	パラメータ3　なし
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_Yuruto_818000_Battle, "yuruto_818000Battle");

-- Updateでなにもやっていないので、呼ばないようにする
REGISTER_GOAL_NO_UPDATE( GOAL_Yuruto_818000_Battle, 1 );


---------------------------------------------------------
--  ゴール起動
---------------------------------------------------------
function yuruto_818000Battle_Activate(ai, goal)
-------------------------------------------------------------------------------

local hprate = ai:GetHpRate( TARGET_SELF )				--自分のHP割合を取得

	--自分のHPが残り2割以上
	if hprate >= 0.2 then
	
		--行動・非瀕死時
		yuruto_818000Battle_Normal_Action(ai, goal)
		
	--自分の残りHPが2割以下
	else
		
		--行動・瀕死時
		yuruto_818000Battle_Dying_Action(ai, goal)
	
	end	
end


---------------------------------------------------------
--  行動・非瀕死時
---------------------------------------------------------
function yuruto_818000Battle_Normal_Action(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);	--敵ターゲットとの距離を取得
local farDist = 15.0							--遠いと判断する距離
local nearDist = 4.0							--近いと判断する距離
local NormalR_Dist = 2.0						--右手攻撃の適正間合い

local fate = ai:GetRandam_Int(1,100)		--確率判定で使用する運命の数字

	--遠いなら
	if targetDist >= farDist then

		yuruto_818000Battle_Far_Dist_Action(ai, goal)
	
	--遠くもないが、近くもないなら
	elseif targetDist >= nearDist then
		
		yuruto_818000Battle_Near_Dist_Action(ai, goal)
	
	--近いなら
	elseif targetDist >= NormalR_Dist then
	
		yuruto_818000Battle_NormalR_Dist_Action(ai, goal)

	--極端に近いなら
	else
	
		if fate <= 70 then
			yuruto_818000Battle_TooNear_Dist_Action(ai, goal)
		
		else
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalL, TARGET_ENE_0, DIST_Near, 0);
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
			yuruto_818000Battle_Kougeki_Noato(ai, goal)
		end
	end
end

---------------------------------------------------------
--  行動・瀕死時
---------------------------------------------------------
function yuruto_818000Battle_Dying_Action(ai, goal)

local fate = ai:GetRandam_Int(1,100)		--確率判定で使用する運命の数字
local NormalR_Dist = 2.0			--右手攻撃の適正間合い


	if fate <= 30 then
		goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, -1 );
		yuruto_818000Battle_NormalR_Comb2(ai, goal)
		yuruto_818000Battle_Kougeki_Noato(ai, goal)
	else
		goal:AddSubGoal(GOAL_COMMON_SpinStep, 5.0, NPC_ATK_StepF, TARGET_SELF, 0, AI_DIR_TYPE_F, 4.5);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_NONE, DIST_Near, 0);
		yuruto_818000Battle_Kougeki_Noato(ai, goal)
	end

end


---------------------------------------------------------
--  行動・非瀕死時・遠距離
---------------------------------------------------------
function yuruto_818000Battle_Far_Dist_Action(ai, goal)

local NormalR_Dist = 2.0			--右手攻撃の適正間合い

	--100％　走って近づく
	goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, -1 );
	yuruto_818000Battle_NormalR_Comb(ai, goal)
	yuruto_818000Battle_Kougeki_Noato(ai, goal)

end


---------------------------------------------------------
--  行動・非瀕死時・中距離
---------------------------------------------------------
function yuruto_818000Battle_Near_Dist_Action(ai, goal)

local fate = ai:GetRandam_Int(1,100)		--確率判定で使用する運命の数字
local NormalR_Dist = 2.0			--右手攻撃の適正間合い


	--60％　歩いて近づいて攻撃
	--30％　横移動で様子見
	--10％　飛び込み切り
	if fate <= 60 then
		goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, true, -1 );
		yuruto_818000Battle_NormalR_Comb(ai, goal)
		yuruto_818000Battle_Kougeki_Noato(ai, goal)
	elseif fate <= 90 then
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, ai:GetRandam_Int(1,3), TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(25,45), true, true ,-1 );
	else
		goal:AddSubGoal(GOAL_COMMON_SpinStep, 5.0, NPC_ATK_StepF, TARGET_SELF, 0, AI_DIR_TYPE_F, 4.5);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_NONE, DIST_Near, 0);
	end

end

---------------------------------------------------------
--  行動・非瀕死時・近距離
---------------------------------------------------------
function yuruto_818000Battle_NormalR_Dist_Action(ai, goal)

local fate = ai:GetRandam_Int(1,100)		--確率判定で使用する運命の数字
local NormalR_Dist = 2.0			--右手攻撃の適正間合い


	--50％　歩いて近づいて攻撃	
	--50％　旋回し様子を窺う
	if fate <= 50 then
		goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 3.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, true, -1 );
		yuruto_818000Battle_NormalR_Comb(ai, goal)
		yuruto_818000Battle_Kougeki_Noato(ai, goal)
	else
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, ai:GetRandam_Int(1,3), TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(25,55), true, true ,-1 );
	end

end

---------------------------------------------------------
--  行動・非瀕死時・至近距離
---------------------------------------------------------
function yuruto_818000Battle_TooNear_Dist_Action(ai, goal)

local fate = ai:GetRandam_Int(1,100)		--確率判定で使用する運命の数字
local fate2 = ai:GetRandam_Int(1,100)		--確率判定で使用する運命の数字　その２

	--30％　攻撃
	--70％　移動
	if fate <= 30 then
		yuruto_818000Battle_NormalR_Comb(ai, goal)
		yuruto_818000Battle_Kougeki_Noato(ai, goal)
	else
		if fate2 <= 50 then
			goal:AddSubGoal( GOAL_COMMON_LeaveTarget, ai:GetRandam_Int(1,3), TARGET_ENE_0, ai:GetRandam_Int(2,4), TARGET_ENE_0, true, -1 );
		else
			goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 2.0, TARGET_ENE_0, ai:GetRandam_Int(2,4), TARGET_ENE_0, true, -1 );
			goal:AddSubGoal( GOAL_COMMON_SidewayMove, ai:GetRandam_Int(2,4), TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(30,55), true, true ,-1 );
		end
	end
end


---------------------------------------------------------
--  右手コンボ
---------------------------------------------------------
function yuruto_818000Battle_NormalR_Comb(ai, goal)

local NR_fate = ai:GetRandam_Int(1,100)			--確率判定用
local NR_fate2 = ai:GetRandam_Int(1,100)		--確率判定用
local NR_fate3 = ai:GetRandam_Int(1,100)		--確率判定用
local NR_fate4 = ai:GetRandam_Int(1,100)		--確率判定用

	--右手攻撃２回
	--75% 右手攻撃
	--50% 右手攻撃
	--25% 右手攻撃
	--50% 右手大攻撃
	if NR_fate <= 10 then
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalL, TARGET_ENE_0, DIST_Near, 0);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
	elseif NR_fate <= 20 then
		goal:AddSubGoal(GOAL_COMMON_SpinStep, 5.0, NPC_ATK_StepF, TARGET_SELF, 0, AI_DIR_TYPE_F, 4.5);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_NONE, DIST_Near, 0);
	else
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalL, TARGET_ENE_0, DIST_Near, 0);
	end
	
	if NR_fate2 <= 10 then
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
	end
	
	if NR_fate3 <= 10 then
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_LargeR, TARGET_ENE_0, DIST_Near, 0);
	end	

end
	
---------------------------------------------------------
--  右手コンボ2・猛攻撃
---------------------------------------------------------
function yuruto_818000Battle_NormalR_Comb2(ai, goal)

local NR_fate = ai:GetRandam_Int(1,100)			--確率判定用
local NR_fate2 = ai:GetRandam_Int(1,100)		--確率判定用

	--両手に持ち替える
	CommonNPC_SwitchBothHandMode(ai, goal)

	--両手攻撃２回
	--100% 右手大攻撃１
	-- 90% 右手大攻撃２

	goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
	goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);

	if NR_fate2 <= 40 then
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_LargeR, TARGET_ENE_0, DIST_Near, 0);
	end
end



---------------------------------------------------------
--  攻撃後の行動
---------------------------------------------------------
function yuruto_818000Battle_Kougeki_Noato(ai, goal)

local KN_fate = ai:GetRandam_Int(1,100)			--確率判定用
local KN_fate2 = ai:GetRandam_Int(1,100)		--確率判定用
local BackDist = 2.0							--後退する距離

	--70％　なにもしない
	--30％　横に移動
	--15％　後ろに移動
	--40％　ステップで後退
	if KN_fate <= 70 then
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, ai:GetRandam_Int(2,4), TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(25,45), true, true ,-1 );
	elseif KN_fate <= 85 then
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, ai:GetRandam_Int(2,4), TARGET_ENE_0, BackDist, TARGET_ENE_0, true, -1 );				
	else
		if KN_fate2 <= 90 then
			goal:AddSubGoal(GOAL_COMMON_SpinStep, 5.0, NPC_ATK_StepB, TARGET_SELF, 0, AI_DIR_TYPE_B, 4.5);
		else
			goal:AddSubGoal(GOAL_COMMON_SpinStep, 5.0, NPC_ATK_StepB, TARGET_SELF, 0, AI_DIR_TYPE_B, 4.5);
			goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_None, 0);
		end			
	end
end


---------------------------------------------------------
--  ゴール更新
---------------------------------------------------------
function yuruto_818000Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  ゴール終了
---------------------------------------------------------
function yuruto_818000Battle_Terminate(ai, goal)
end



---------------------------------------------------------
--  割り込み
--	割り込んだ場合にはtrueを返してください。
--	ここで割り込み用のサブゴールを追加してください。
--	割り込まなかった場合には、1つ上の層のゴール、またはロジック部分によって割り込みが処理されます。
---------------------------------------------------------
function yuruto_818000Battle_Interupt(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);			--敵ターゲットとの距離を取得

local fate = ai:GetRandam_Int(1,100)					--確率判定用
local fate2 = ai:GetRandam_Int(1,100)					--確率判定用
local fate3 = ai:GetRandam_Int(1,100)					--確率判定用
local fate4 = ai:GetRandam_Int(1,100)					--確率判定用

local NormalR_Dist = 2.0			--右手攻撃の適正間合い

	--至近距離でダメージ受けたらコンボとみなして反撃・後退
	if ai:IsInterupt( INTERUPT_Damaged ) then
local combRunDist = 1.0				--コンボ逃れする距離
local combRunPer = 40				--コンボ逃れする確率
local combRunCountPer = 15			--コンボ逃れの後に攻撃する確率	
		if targetDist < combRunDist then
			if fate <= combRunPer then
				goal:ClearSubGoal();
				--逃れる
				goal:AddSubGoal(GOAL_COMMON_SpinStep, 5.0, NPC_ATK_StepB, TARGET_SELF, 0, AI_DIR_TYPE_B, 4.5);
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
			goal:AddSubGoal(GOAL_COMMON_SpinStep, 5.0, NPC_ATK_StepB, TARGET_SELF, 0, AI_DIR_TYPE_B, 4.5);
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
				goal:AddSubGoal(GOAL_COMMON_SpinStep, 5.0, NPC_ATK_StepL, TARGET_SELF, 0, AI_DIR_TYPE_L, 4.5);
			else
				goal:AddSubGoal(GOAL_COMMON_SpinStep, 5.0, NPC_ATK_StepR, TARGET_SELF, 0, AI_DIR_TYPE_R, 4.5);
			end
			return true;
		end
	end
	
	--アイテムを使ったら最適行動
	if ai:IsInterupt( INTERUPT_UseItem ) then
local itemUseIntPer = 40				--アイテム使用時に最適行動を取る確率
		if fate <= itemUseIntPer then
			goal:ClearSubGoal();
				if fate2 <= 80 then
				 	goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, -1 );
					goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
					yuruto_818000Battle_Kougeki_Noato(ai, goal)
				else
					goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, -1 );
					goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_LargeR, TARGET_ENE_0, DIST_Near, 0);
					yuruto_818000Battle_Kougeki_Noato(ai, goal)
				end
			return true
		end
	end
	
	
	--敵のガードで武器がはじかれたら左右ステップをする（右優先）
	if ai:IsInterupt( INTERUPT_ReboundByOpponentGuard ) then
local GuardReboundMovePer = 50			--はじかれた時に移動をする確率
		if fate <= GuardReboundMovePer then
			goal:ClearSubGoal();
			if fate2 <= 80 then
				goal:AddSubGoal(GOAL_COMMON_SpinStep, 5.0, NPC_ATK_StepR, TARGET_SELF, 0, AI_DIR_TYPE_R, 4.5);
			else
				goal:AddSubGoal(GOAL_COMMON_SpinStep, 5.0, NPC_ATK_StepL, TARGET_SELF, 0, AI_DIR_TYPE_L, 4.5);
			end
			return true;
		end
	end
	
return false;
end

