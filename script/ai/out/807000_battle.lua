-----------------------------------------------------------------------------------------------
--	レンドル王子用戦闘
--	説明：
--
--	パラメータ0  なし
--	パラメータ1  なし
--	パラメータ2  なし
--	パラメータ3　なし 
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_Ouji_807000_Battle, "ouji_807000Battle");

-- Updateでなにもやっていないので、呼ばないようにする
REGISTER_GOAL_NO_UPDATE( GOAL_Ouji_807000_Battle, 1 );


---------------------------------------------------------
--  ゴール起動
---------------------------------------------------------
function ouji_807000Battle_Activate(ai, goal)
-------------------------------------------------------------------------------

local hprate = ai:GetHpRate( TARGET_SELF )				--自分のHP割合を取得
local NormalR_Dist = 2.0						--攻撃の適性間合い

	--自分のHPが1割以上なら
	if hprate >= 0.1 then
	
		--通常行動
		ouji_807000Battle_Kyori(ai, goal)
	
	--自分のHPが2割以下なら
	else
	
		--瀕死行動（猛攻撃）
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, -1 )
		ouji_807000Battle_Dying_Attack(ai, goal)
		ouji_807000Battle_Kougeki_Noato(ai, goal)
	
	end
	
end

---------------------------------------------------------
--  行動（距離判別）
---------------------------------------------------------
function ouji_807000Battle_Kyori(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);	--敵ターゲットとの距離を取得
local NormalR_Dist = 2.0						--攻撃の適性間合い
local Middle_Dist = 6.0 						--走って近づく距離

	--走って近づく距離なら
	if targetDist >= Middle_Dist then
	
		--行動（中距離）
		ouji_807000Battle_Middle_Action(ai, goal)

	--攻撃が届かない距離なら
	elseif targetDist >= NormalR_Dist then

		--行動（近距離）
		ouji_807000Battle_Near_Action(ai, goal)

	--攻撃が届く距離なら
	else
	
		--行動（至近距離）
		ouji_807000Battle_TooNear_Action(ai, goal)
	
	end
end

---------------------------------------------------------
--  行動（中距離）
---------------------------------------------------------
function ouji_807000Battle_Middle_Action(ai, goal)

local fate = ai:GetRandam_Int(1,100)		--確率判定で使用する運命の数字
local NormalR_Dist = 2.0					--攻撃の適性間合い

	--80% ガードしない
	if fate <= 80 then
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, -1 )
		
	--20% ガードする
	else
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, 4 )
	end
	
end


---------------------------------------------------------
--  行動（近距離）
---------------------------------------------------------
function ouji_807000Battle_Near_Action(ai, goal)

local fate = ai:GetRandam_Int(1,100)		--確率判定で使用する運命の数字
local fate2 = ai:GetRandam_Int(1,100)		--確率判定で使用する運命の数字　その２
local fate3 = ai:GetRandam_Int(1,100)		--確率判定で使用する運命の数字　その３

local NormalR_Dist = 2.0					--攻撃の適性間合い

	--70% 走って近づく
	if fate <= 70 then
		
		--70% ガードしない
		if fate2 <= 70 then
			goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, -1 )
		
		--30% ガードする
		else
			goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, 4 )
		end
		
	--30% 歩いて近づく
	else
	
		--40% ガードしない
		if fate3 <= 40 then
			goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, true, -1 )
		
		--70% ガードする
		else
			goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, true, 4 )
		end
	end
	
	ouji_807000Battle_Attack(ai, goal)
	ouji_807000Battle_Kougeki_Noato(ai, goal)

end

---------------------------------------------------------
--  行動（至近距離）
---------------------------------------------------------
function ouji_807000Battle_TooNear_Action(ai, goal)

local fate = ai:GetRandam_Int(1,100)		--確率判定で使用する運命の数字

	--70% 攻撃
	if fate <= 70 then
		ouji_807000Battle_Attack(ai, goal)
	end

	ouji_807000Battle_Kougeki_Noato(ai, goal)

end



---------------------------------------------------------
--  攻撃パターン・通常時
---------------------------------------------------------
function ouji_807000Battle_Attack(ai, goal)

	--右手コンボ・片手
	ouji_807000Battle_NormalR_OneHand_Comb(ai, goal)

end
 
---------------------------------------------------------
--  攻撃パターン・瀕死時
---------------------------------------------------------
function ouji_807000Battle_Dying_Attack(ai, goal)

local fate = ai:GetRandam_Int(1,100)		--確率判定で使用する運命の数字


	--80% 片手攻撃
	if fate <= 80 then
		--右手コンボ・片手
		ouji_807000Battle_NormalR_OneHand_Comb(ai, goal)
		
	--20% 両手攻撃
	else
		--右手コンボ・両手
		ouji_807000Battle_NormalR_BothHand_Comb(ai, goal)
	
	end
end


---------------------------------------------------------
--  右手コンボ・片手
---------------------------------------------------------
function ouji_807000Battle_NormalR_OneHand_Comb(ai, goal)

local NR_fate = ai:GetRandam_Int(1,100)			--確率判定用

	--片手切り替え
	CommonNPC_SwitchOneHandMode(ai, goal)

	--10% 前転攻撃
	if NR_fate <= 10 then
		goal:AddSubGoal(GOAL_COMMON_SpinStep, 5.0, NPC_ATK_StepF, TARGET_SELF, 0, AI_DIR_TYPE_F, 4.0);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_NONE, DIST_Middle, 0);
	
	--70% 攻撃2回
	elseif NR_fate <= 80 then
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Middle, 0);
	
	--20% 強攻撃1回
	else
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_LargeR, TARGET_ENE_0, DIST_Middle, 0);
	
	end
end


---------------------------------------------------------
--  右手コンボ・両手
---------------------------------------------------------
function ouji_807000Battle_NormalR_BothHand_Comb(ai, goal)

local NR_fate = ai:GetRandam_Int(1,100)			--確率判定用
local NR_fate2 = ai:GetRandam_Int(1,100)		--確率判定用
local NR_fate3 = ai:GetRandam_Int(1,100)		--確率判定用

	--両手切り替え
	CommonNPC_SwitchBothHandMode(ai, goal)
	
	--5% 前転攻撃
	if NR_fate <= 5 then
		goal:AddSubGoal(GOAL_COMMON_SpinStep, 5.0, NPC_ATK_StepF, TARGET_SELF, 0, AI_DIR_TYPE_F, 4.0);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_NONE, DIST_Middle, 0);
	
	--90% 攻撃1回強攻撃1回
	elseif NR_fate <= 95 then
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Middle, 0);
		
		--80% 攻撃2回
		if NR_fate2 <= 80 then
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Middle, 0);
		
		--15% 強攻撃1回
		elseif NR_fate2 <= 95 then
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_LargeR, TARGET_ENE_0, DIST_Middle, 0);
			
		--5% 強攻撃2回
		else
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_LargeR, TARGET_ENE_0, DIST_Middle, 0);
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_LargeR, TARGET_ENE_0, DIST_Middle, 0);
		
		end
		
	--5% 強攻撃1回攻撃1回
	else	
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_LargeR, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Middle, 0);
		
		--80% 攻撃1回
		if NR_fate3 <= 80 then
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Middle, 0);
			
		--20% 攻撃1回強攻撃1回
		else
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Middle, 0);
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_LargeR, TARGET_ENE_0, DIST_Middle, 0);
		end
	end

end
	
---------------------------------------------------------
--  攻撃後の行動
---------------------------------------------------------
function ouji_807000Battle_Kougeki_Noato(ai, goal)

local KN_fate = ai:GetRandam_Int(1,100)			--確率判定用
local KN_fate2 = ai:GetRandam_Int(1,100)		--確率判定用
local KN_fate3 = ai:GetRandam_Int(1,100)		--確率判定用

local BackDist = ai:GetRandam_Int(3,6)			--後退する距離

	--50% 盾を構えて後退・旋回
	--50% ステップ移動（落ちないやつ）

	if KN_fate <= 50 then
	
		if KN_fate2 <= 50 then
			goal:AddSubGoal(GOAL_COMMON_SidewayMove, ai:GetRandam_Int(3,5), TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(25,45), ai:GetRandam_Int(0,1), true , 4 );
		else
			goal:AddSubGoal( GOAL_COMMON_LeaveTarget, ai:GetRandam_Int(3,5), TARGET_ENE_0, BackDist, TARGET_ENE_0, ai:GetRandam_Int(0,1), 4 );
		end
		
	else
	
		if KN_fate3 <= 40 then
			goal:AddSubGoal(GOAL_COMMON_SpinStep, 5.0, NPC_ATK_StepB, TARGET_SELF, 0, AI_DIR_TYPE_B, 4.0);
		elseif KN_fate3	<= 70 then
			goal:AddSubGoal(GOAL_COMMON_SpinStep, 5.0, NPC_ATK_StepL, TARGET_SELF, 0, AI_DIR_TYPE_L, 4.0);
		else
			goal:AddSubGoal(GOAL_COMMON_SpinStep, 5.0, NPC_ATK_StepR, TARGET_SELF, 0, AI_DIR_TYPE_R, 4.0);
		end			
	end
end




---------------------------------------------------------
--  ゴール更新
---------------------------------------------------------
function ouji_807000Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  ゴール終了
---------------------------------------------------------
function ouji_807000Battle_Terminate(ai, goal)
end



---------------------------------------------------------
--  割り込み
--	割り込んだ場合にはtrueを返してください。
--	ここで割り込み用のサブゴールを追加してください。
--	割り込まなかった場合には、1つ上の層のゴール、またはロジック部分によって割り込みが処理されます。
---------------------------------------------------------
function ouji_807000Battle_Interupt(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);			--敵ターゲットとの距離を取得

local fate = ai:GetRandam_Int(1,100)					--確率判定用
local fate2 = ai:GetRandam_Int(1,100)					--確率判定用
local fate3 = ai:GetRandam_Int(1,100)					--確率判定用
local fate4 = ai:GetRandam_Int(1,100)					--確率判定用

local NormalR_Dist = 2.5			--右手攻撃の適正間合い


	--至近距離でダメージ受けたらコンボとみなして後退
	if ai:IsInterupt( INTERUPT_Damaged ) then
local combRunDist = 1.0				--コンボ逃れする距離
local combRunPer = 40				--コンボ逃れする確率
		if targetDist < combRunDist then
			if fate <= combRunPer then
				goal:ClearSubGoal();
				--逃れる
				if fate2 <= 40 then
					goal:AddSubGoal(GOAL_COMMON_SpinStep, 5.0, NPC_ATK_StepB, TARGET_SELF, 0, AI_DIR_TYPE_B, 4.0);
				elseif fate2 <= 70 then
					goal:AddSubGoal(GOAL_COMMON_SpinStep, 5.0, NPC_ATK_StepL, TARGET_SELF, 0, AI_DIR_TYPE_L, 4.0);
				else
					goal:AddSubGoal(GOAL_COMMON_SpinStep, 5.0, NPC_ATK_StepR, TARGET_SELF, 0, AI_DIR_TYPE_R, 4.0);
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
				if fate2 <= 40 then
					goal:AddSubGoal(GOAL_COMMON_SpinStep, 5.0, NPC_ATK_StepB, TARGET_SELF, 0, AI_DIR_TYPE_B, 4.0);
				elseif fate2 <= 70 then
					goal:AddSubGoal(GOAL_COMMON_SpinStep, 5.0, NPC_ATK_StepL, TARGET_SELF, 0, AI_DIR_TYPE_L, 4.0);
				else
					goal:AddSubGoal(GOAL_COMMON_SpinStep, 5.0, NPC_ATK_StepR, TARGET_SELF, 0, AI_DIR_TYPE_R, 4.0);
				end		
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
				goal:AddSubGoal(GOAL_COMMON_SpinStep, 5.0, NPC_ATK_StepL, TARGET_SELF, 0, AI_DIR_TYPE_L, 4.0);
			else
				goal:AddSubGoal(GOAL_COMMON_SpinStep, 5.0, NPC_ATK_StepR, TARGET_SELF, 0, AI_DIR_TYPE_R, 4.0);
			end	
			return true
		end
	end
	
	
return false;
end

