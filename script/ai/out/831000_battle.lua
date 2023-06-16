-----------------------------------------------------------------------------------------------
--	メフィストフェレス用戦闘
--	説明：
--
--	パラメータ0  なし
--	パラメータ1  なし
--	パラメータ2  なし
--	パラメータ3　なし
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_Mefist_831000_Battle, "mefist_831000Battle");

-- Updateでなにもやっていないので、呼ばないようにする
REGISTER_GOAL_NO_UPDATE( GOAL_Mefist_831000_Battle, 1 );


---------------------------------------------------------
--  ゴール起動
---------------------------------------------------------
function mefist_831000Battle_Activate(ai, goal)
-------------------------------------------------------------------------------

local hprate = ai:GetHpRate( TARGET_SELF );				--自分のHP割合を取得

	--自分のHP残りが1割以上
	if hprate >= 0.1 then
	
		--通常行動
		mefist_831000Battle_Normal_Attack(ai, goal)
	
	--自分のHP残りが1割以下
	else
	
		--瀕死行動
		mefist_831000Battle_Normal_Attack(ai, goal)
	end
end


---------------------------------------------------------
--  通常行動
---------------------------------------------------------
function mefist_831000Battle_Normal_Attack(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);			--敵ターゲットとの距離を取得
local fate = ai:GetRandam_Int(1,100)		--確率判定で使用する運命の数字
local fate2 = ai:GetRandam_Int(1,100)		--確率判定で使用する運命の数字　その２

local NormalR_Dist = 2.0			--右手攻撃の適正間合い

	--近いなら
	if targetDist >= NormalR_Dist then

		--50％　走って近づき攻撃
		if fate <= 50 then
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, -1 );
			mefist_831000Battle_NormalR_Comb(ai, goal)
			mefist_831000Battle_Kougeki_Noato(ai, goal)
		
		--30% 魔法で攻撃
		elseif fate <= 30 then
			mefist_831000Battle_Magic(ai, goal)
			
		--20% 走って旋回して様子見
		else
			goal:AddSubGoal(GOAL_COMMON_SidewayMove, ai:GetRandam_Int(2,4), TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(25,55), false, true ,-1 );
		end
		
	--極端に近いなら
	else
		--15％　攻撃
		if fate2 <= 15 then
			mefist_831000Battle_NormalR_Comb(ai, goal)
			
		--55％　ステップで後退
		elseif fate2 <= 70 then
			mefist_831000Battle_Kougeki_Noato(ai, goal)
		
		--30% 魔法攻撃
		else
			mefist_831000Battle_Magic(ai, goal)
		
		end
	end
end


---------------------------------------------------------
--  瀕死行動
---------------------------------------------------------
function mefist_831000Battle_Dying_Attack(ai, goal)

local fate = ai:GetRandam_Int(1,100)		--確率判定用
local NormalR_Dist = 2.0					--武器の有効範囲

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

---------------------------------------------------------
--  右手コンボ（通常）
---------------------------------------------------------
function mefist_831000Battle_NormalR_Comb(ai, goal)

local NR_fate = ai:GetRandam_Int(1,100)			--確率判定用
local NR_fate2 = ai:GetRandam_Int(1,100)		--確率判定用
local NR_fate3 = ai:GetRandam_Int(1,100)		--確率判定用


local NormalATKPer	= 80		--通常攻撃の割合

	--武器を持っていなければ持ち替える
	CommonNPC_ChangeWepR1(ai, goal)

	if NR_fate <= NormalATKPer then

		--30% 前転攻撃
		if NR_fate2 <= 30 then
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_StepF, TARGET_ENE_0, DIST_None, 0 )
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_NONE, DIST_Middle, 0);

		--40% 左右右
		elseif NR_fate2 <= 70 then
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalL, TARGET_ENE_0, DIST_Middle, 0);
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Middle, 0);
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Middle, 0);
		
		--30% 右手攻撃3回
		else
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Middle, 0);
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Middle, 0);
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Middle, 0);
	
		end
	
		if NR_fate3 <= 60 then
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalL, TARGET_ENE_0, DIST_Middle, 0);
		end
		
	else
		--右手強攻撃１回
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_LargeR, TARGET_ENE_0, DIST_Middle, 0);

	end
end	


---------------------------------------------------------
--  攻撃・魔法
---------------------------------------------------------
function mefist_831000Battle_Magic(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0)		--敵ターゲットとの距離を取得
local MagicDist = 0.7								--魔法の攻撃範囲
local NormalR_Dist = 2.0							--物理攻撃の間合い
local selfmp = ai:GetMp(TARGET_SELF)			--自分の残りMPを取得
local fate = ai:GetRandam_Int(1,100)			--確率判定用
local fate2 = ai:GetRandam_Int(1,100)			--確率判定用

local		keinsei			= 30			--けん制攻撃の割合
local		mawarikomi 		= 50			--回り込む確率

	--自分のMPが100以上なら
	if selfmp >= 100 then
	
		--武器を触媒に持ち替える
		CommonNPC_ChangeWepR2(ai, goal)
		
		--魔法の届く距離にいなければ
		if targetDist >= MagicDist then
		
			--走って近づいて魔法
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, MagicDist, TARGET_ENE_0, false, -1 );
			
			if fate <= keinsei then
				goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalL, TARGET_ENE_0, DIST_Middle, 0);
			end

			if fate2 <= mawarikomi then
				goal:AddSubGoal(GOAL_COMMON_SidewayMove, 4.0 , TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(90,120), false, true ,-1 );
			end
			
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_MagicR, TARGET_ENE_0, DIST_None, 0);
			mefist_831000Battle_Kougeki_Noato(ai, goal)
		
		--魔法の届く距離にいれば
		else
		
			--回り込んでその場で魔法
			goal:AddSubGoal(GOAL_COMMON_SidewayMove, 4.0 , TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(90,120), false, true ,-1 );
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_MagicR, TARGET_ENE_0, DIST_None, 0);
			mefist_831000Battle_Kougeki_Noato(ai, goal)

		end
	
	--自分のMPが100以下なら
	else
	
		--通常攻撃
		goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, -1 );
		mefist_831000Battle_NormalR_Comb(ai, goal)
		mefist_831000Battle_Kougeki_Noato(ai, goal)
	end
	
end

---------------------------------------------------------
--  攻撃後の行動
---------------------------------------------------------
function mefist_831000Battle_Kougeki_Noato(ai, goal)

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
function mefist_831000Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  ゴール終了
---------------------------------------------------------
function mefist_831000Battle_Terminate(ai, goal)
end



---------------------------------------------------------
--  割り込み
--	割り込んだ場合にはtrueを返してください。
--	ここで割り込み用のサブゴールを追加してください。
--	割り込まなかった場合には、1つ上の層のゴール、またはロジック部分によって割り込みが処理されます。
---------------------------------------------------------
function mefist_831000Battle_Interupt(ai, goal)

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
				mefist_831000Battle_Kougeki_Noato(ai, goal)
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
			goal:ClearSubGoal();
			--逃れる
			mefist_831000Battle_Kougeki_Noato(ai, goal)
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
			mefist_831000Battle_Magic(ai, goal)
			return true
		end
	end
	
return false;
end

