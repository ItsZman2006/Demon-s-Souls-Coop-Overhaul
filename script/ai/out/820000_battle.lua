------------------------------------------------------------------------------------------------
--	姫騎士セレン専用戦闘
--	説明：
--
--	パラメータ0  なし
--	パラメータ1  なし
--	パラメータ2  なし
--	パラメータ3　なし
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_Selen_820000_Battle, "Selen_820000Battle");

-- Updateでなにもやっていないので、呼ばないようにする
REGISTER_GOAL_NO_UPDATE( GOAL_Selen_820000_Battle, 1 );

---------------------------------------------------------
--  ゴール起動
---------------------------------------------------------
function Selen_820000Battle_Activate(ai, goal)
-------------------------------------------------------------------------------

local hprate = ai:GetHpRate( TARGET_SELF )				--自分のHP割合を取得

	--自分のHP残りが30%以上なら
	if hprate >= 0.3 then

		--通常行動
		Selen_820000Battle_Normal_Attack(ai, goal)			

	--自分のHP残りが30%以下なら
	else

		--瀕死行動		
		Selen_820000Battle_Dying_Attack(ai, goal)

	end
	
end

---------------------------------------------------------
--  通常行動
---------------------------------------------------------
function Selen_820000Battle_Normal_Attack(ai, goal)	

	--自分が状態異常である(出血、疫病、毒）
	if ( 	ai:HasSpecialEffectAttribute(TARGET_SELF, SP_EFFECT_TYPE_BLOOD)
		or	ai:HasSpecialEffectAttribute(TARGET_SELF, SP_EFFECT_TYPE_ILLNESS)
		or	ai:HasSpecialEffectAttribute(TARGET_SELF, SP_EFFECT_TYPE_POIZON)) then
		
		--魔法（状態異常回復）
		Selen_820000Battle_Magic_Cure(ai, goal)
			
	--自分が状態異常でない
	else
	
		--敵が魔法を持っていなければ
		if ( -1 == ai:GetCurrEquipMagicID(TARGET_ENE_0) ) then

			--武器で攻撃
			Selen_820000Battle_Sword(ai, goal)
			Selen_820000Battle_Kougeki_Noato(ai, goal)
	
		--相手が魔法を持っていれば
		else
		
			--アンチマジックを使って1分タイマーセット
			if ( ai:IsFinishTimer(0) ) then
				Selen_820000Battle_Magic_AntiMagic(ai, goal)
				ai:SetTimer(0,60);
			
			--アンチマジックを使ってから1分経っていない
			else
				--武器で攻撃
				Selen_820000Battle_Sword(ai, goal)
				Selen_820000Battle_Kougeki_Noato(ai, goal)
			
			end
		end
	end
end


---------------------------------------------------------
--  瀕死行動
---------------------------------------------------------
function Selen_820000Battle_Dying_Attack(ai, goal)	

local selfmp = ai:GetMp(TARGET_SELF)			--自分の残りMPを取得

	--魔法１が使える
	if selfmp >= 60 then

		--敵から距離をとる
		goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepB, TARGET_ENE_0, DIST_None, 0);
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 4.0, TARGET_ENE_0, 5.0, TARGET_ENE_0, false, -1 );

		--大回復に切り替えてHP回復
		CommonNPC_SwitchOneHandMode(ai, goal)
		ai:ChangeEquipMagic(0);
		goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_Magic, TARGET_SELF, DIST_None, 0 );
		Selen_820000Battle_Kougeki_Noato(ai, goal)
		
	--魔法１が使えない
	else

		--100% 通常攻撃
		Selen_820000Battle_Sword(ai, goal)
		Selen_820000Battle_Kougeki_Noato(ai, goal)
		
	end
		
end

	
---------------------------------------------------------
--  攻撃：武器
---------------------------------------------------------
function Selen_820000Battle_Sword(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);	--敵ターゲットとの距離を取得
local NormalR_Dist = 1.5						--右手攻撃の適正間合い	

local fate = ai:GetRandam_Int(1,100)			--確率判定用
local fate2 = ai:GetRandam_Int(1,100)			--確率判定用

	--攻撃距離内にいないなら
	if targetDist >= NormalR_Dist then
	
		--60% 走って近づいて攻撃
		if fate <= 60 then
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 4.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, -1 );
			Selen_820000Battle_NormalR_Comb(ai, goal)
			Selen_820000Battle_Kougeki_Noato(ai, goal)

		--30% 旋回して様子見してから走って近づいて攻撃
		elseif fate <= 90 then
			goal:AddSubGoal(GOAL_COMMON_SidewayMove, 2.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(25,50), false, true , -1 );
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 4.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, -1 );
			Selen_820000Battle_NormalR_Comb(ai, goal)
			Selen_820000Battle_Kougeki_Noato(ai, goal)

		--10% 距離を取る
		else 
			goal:AddSubGoal( GOAL_COMMON_LeaveTarget, ai:GetRandam_Int(2,4), TARGET_ENE_0, ai:GetRandam_Int(2,4), TARGET_ENE_0, false, -1 );
		end
	
	--攻撃距離内にいるなら
	else

		--40% 攻撃
		if fate2 <= 40 then
			Selen_820000Battle_NormalR_Comb(ai, goal)
			Selen_820000Battle_Kougeki_Noato(ai, goal)

		--40% 旋回して攻撃
		elseif fate2 <= 80 then
			goal:AddSubGoal(GOAL_COMMON_SidewayMove, 2.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(25,50), false, true , -1 );
			Selen_820000Battle_NormalR_Comb(ai, goal)
			Selen_820000Battle_Kougeki_Noato(ai, goal)

		--20% 距離を取る
		else 
			goal:AddSubGoal( GOAL_COMMON_LeaveTarget, ai:GetRandam_Int(2,4), TARGET_ENE_0, ai:GetRandam_Int(2,4), TARGET_ENE_0, false, -1 );
		end

	end
end

---------------------------------------------------------
--  攻撃：魔法（アンチマジック）
---------------------------------------------------------
function Selen_820000Battle_Magic_AntiMagic(ai, goal)

local selfmp = ai:GetMp(TARGET_SELF)			--自分の残りMPを取得 
local targetDist = ai:GetDist(TARGET_ENE_0);	--敵ターゲットとの距離を取得
local BackDist = 5.0							--後退する距離

	--魔法２が使える
	if selfmp >= 10 then

		--魔法２に切り替える
		CommonNPC_SwitchOneHandMode(ai, goal)
		ai:ChangeEquipMagic(1);
		
		--5M以上離れていたらその場で魔法
		if targetDist >= BackDist then
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_Magic, TARGET_ENE_0, DIST_None, 0);
			Selen_820000Battle_Kougeki_Noato(ai, goal)

		--5M以内にいたら走って離れて魔法
		else
			goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 10.0, TARGET_ENE_0, BackDist, TARGET_ENE_0, false, -1 );
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_Magic, TARGET_ENE_0, DIST_None, 0);
			Selen_820000Battle_Kougeki_Noato(ai, goal)
			
		end
	
	--魔法２が使えない
	else
	
		--100% 通常攻撃
		Selen_820000Battle_Sword(ai, goal)
		Selen_820000Battle_Kougeki_Noato(ai, goal)
		
	end
end

---------------------------------------------------------
--  攻撃：魔法（状態異常回復）
---------------------------------------------------------
function Selen_820000Battle_Magic_Cure(ai, goal)

local selfmp = ai:GetMp(TARGET_SELF)			--自分の残りMPを取得 

	--魔法３を使える
	if selfmp >= 30 then
	
		--魔法３に切り替える
		CommonNPC_SwitchOneHandMode(ai, goal)
		ai:ChangeEquipMagic(2);
		
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_Magic, TARGET_ENE_0, DIST_None, 0);
		Selen_820000Battle_Kougeki_Noato(ai, goal)
	
	--魔法３が使えない
	else
		--武器で攻撃
		Selen_820000Battle_Sword(ai, goal)
		Selen_820000Battle_Kougeki_Noato(ai, goal)
	end	

end

---------------------------------------------------------
--  右手コンボ
---------------------------------------------------------
function Selen_820000Battle_NormalR_Comb(ai, goal)

local NR_fate = ai:GetRandam_Int(1,100)			--確率判定用
local NR_fate2 = ai:GetRandam_Int(1,100)		--確率判定用
local NR_fate3 = ai:GetRandam_Int(1,100)		--確率判定用


	--50% 片手攻撃2回
		--30% 片手攻撃4回
	--50% 両手攻撃2回
		--10% 両手攻撃4回
	
	
	if NR_fate <= 50 then
		CommonNPC_SwitchOneHandMode(ai, goal)
	
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);

			if NR_fate2 <= 30 then
				goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
				goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_LargeR, TARGET_ENE_0, DIST_Near, 0);
			end
	
	else
		CommonNPC_SwitchBothHandMode(ai, goal)
		
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_LargeR, TARGET_ENE_0, DIST_Near, 0);
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_LargeR, TARGET_ENE_0, DIST_Near, 0);
			
			if NR_fate3 <= 10 then
				goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
				goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
			end	
	end
end
	

---------------------------------------------------------
--  攻撃後の行動
---------------------------------------------------------
function Selen_820000Battle_Kougeki_Noato(ai, goal)

local KN_fate = ai:GetRandam_Int(1,100)			--確率判定用
local BackDist = 2.5							--後退する距離

	--30% 何もしない
	--40% 横に移動
	--30% 後ろに移動してから横移動
	
	if KN_fate <= 30 then
		goal:AddSubGoal( GOAL_COMMON_Wait, 3.0, TARGET_NONE, 0, 0, 0 );
	elseif KN_fate <= 70 then
		goal:AddSubGoal( GOAL_COMMON_SidewayMove, ai:GetRandam_Int(2,4), TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(25,45), true, true , -1 );
	else
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, ai:GetRandam_Int(1,3), TARGET_ENE_0, BackDist, TARGET_ENE_0, true, -1 );				
		goal:AddSubGoal( GOAL_COMMON_SidewayMove, ai:GetRandam_Int(2,4), TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(25,50), true, true , -1 );
	end
end



---------------------------------------------------------
--  ゴール更新
---------------------------------------------------------
function Selen_820000Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  ゴール終了
---------------------------------------------------------
function Selen_820000Battle_Terminate(ai, goal)
end


---------------------------------------------------------
--  割り込み
--	割り込んだ場合にはtrueを返してください。
--	ここで割り込み用のサブゴールを追加してください。
--	割り込まなかった場合には、1つ上の層のゴール、またはロジック部分によって割り込みが処理されます。
---------------------------------------------------------
function Selen_820000Battle_Interupt(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);			--敵ターゲットとの距離を取得

local fate = ai:GetRandam_Int(1,100)					--確率判定用
local fate2 = ai:GetRandam_Int(1,100)					--確率判定用
local fate3 = ai:GetRandam_Int(1,100)					--確率判定用
local fate4 = ai:GetRandam_Int(1,100)					--確率判定用

	--近くで空振りしたら行動する
	if ai:IsInterupt( INTERUPT_MissSwing ) then
local MissSwingDist = 2.0			--空振り行動する距離
local MissSwingAttPer = 50			--空振り行動する確率	
		if targetDist <= MissSwingDist then
			if fate <= MissSwingAttPer then
				goal:ClearSubGoal();
				--50% 走って後退
				if fate2 <= 50 then
					goal:AddSubGoal(GOAL_COMMON_LeaveTarget, 2.0, TARGET_ENE_0, ai:GetRandam_Int(2,4), TARGET_ENE_0, false, -1 );

				--50% 通常行動
				else
					Selen_820000Battle_Normal_Attack(ai, goal)
					Selen_820000Battle_Kougeki_Noato(ai, goal)
				end
				return true;
			end
		end	
	end


	--至近距離でダメージ受けたらコンボとみなして後退
	if ai:IsInterupt( INTERUPT_Damaged ) then
local combRunDist = 2.0				--コンボ逃れする距離
local combRunPer = 40				--コンボ逃れする確率
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
	

	return false;
end

