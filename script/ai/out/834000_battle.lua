-----------------------------------------------------------------------------------------------
--	坑道２ブラックゴースト用戦闘
--	説明：
--
--	パラメータ0  なし
--	パラメータ1  なし
--	パラメータ2  なし
--	パラメータ3　なし
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_KoudouBG_834000_Battle, "KoudouBG_834000Battle");

-- Updateでなにもやっていないので、呼ばないようにする
REGISTER_GOAL_NO_UPDATE( GOAL_KoudouBG_834000_Battle, 1 );


---------------------------------------------------------
--  ゴール起動
---------------------------------------------------------
function KoudouBG_834000Battle_Activate(ai, goal)
-------------------------------------------------------------------------------

local targetDist = ai:GetDist(TARGET_ENE_0);			--敵ターゲットとの距離を取得
local fate = ai:GetRandam_Int(1,100);		--確率判定で使用する運命の数字
local fate2 = ai:GetRandam_Int(1,100);		--確率判定で使用する運命の数字　その２
local fate3 = ai:GetRandam_Int(1,100);		--確率判定で使用する運命の数字　その3
local fate4 = ai:GetRandam_Int(1,100);		--確率判定で使用する運命の数字　その4

local farDist = 15.0						--遠いと判断する距離
local nearDist = 4.0						--近いと判断する距離
local NormalR_Dist = 2.5			--右手攻撃の適正間合い

	--遠いなら
	if targetDist >= farDist then
		goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, -1 );
		goal:AddSubGoal( GOAL_COMMON_ContinueAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0 );
		
	--遠くもないが、近くもないなら
	elseif targetDist >= nearDist then
		--20％　歩いて近づいて攻撃
		--75％　横移動で様子見
		--5％　飛び込み切り
		if fate <= 20 then
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, ai:GetRandam_Int(0,1), -1 );
			KoudouBG_834000Battle_NormalR_Comb(ai, goal);
			KoudouBG_834000Battle_Kougeki_Noato(ai, goal);
		elseif fate <= 95 then
			goal:AddSubGoal(GOAL_COMMON_SidewayMove, ai:GetRandam_Int(2,4), TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(30,55), true, true ,4 );
		else
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_StepF, TARGET_ENE_0, DIST_None, 0);
			goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_NONE, DIST_Near, 0);
		end
	
	--近いなら
	elseif targetDist >= NormalR_Dist then
		--30％　歩いて近づいて攻撃	
		--80％　旋回し様子を窺う
		if fate2 <= 30 then
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 3.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, true, -1 );
			KoudouBG_834000Battle_NormalR_Comb(ai, goal);
			KoudouBG_834000Battle_Kougeki_Noato(ai, goal);
		else
			goal:AddSubGoal(GOAL_COMMON_SidewayMove, ai:GetRandam_Int(2,4), TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(30,55), true, true , 4 );
		end
	--極端に近いなら
	else
		--20％　攻撃
		--80％　移動
		if fate3 <= 20 then
			KoudouBG_834000Battle_NormalR_Comb(ai, goal);
			KoudouBG_834000Battle_Kougeki_Noato(ai, goal);
		else
			if fate4 <= 50 then
				goal:AddSubGoal( GOAL_COMMON_LeaveTarget, ai:GetRandam_Int(1,2.5), TARGET_ENE_0, ai:GetRandam_Int(2,5), TARGET_ENE_0, true, -1 );
			else
				goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 2.0, TARGET_ENE_0, ai:GetRandam_Int(1,3), TARGET_ENE_0, true, 4 );
				goal:AddSubGoal( GOAL_COMMON_SidewayMove, ai:GetRandam_Int(2,4), TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(20,45), true, true , 4 );
			end
		end
	end
		
end

---------------------------------------------------------
--  右手コンボ
---------------------------------------------------------
function KoudouBG_834000Battle_NormalR_Comb(ai, goal)

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
		goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_SwitchWep, TARGET_ENE_0, DIST_Near, 0 );
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);

		if NR_fate2 <= 10 then
			goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_LargeR, TARGET_ENE_0, DIST_Near, 0);
		end

	elseif NR_fate <= 50 then
		goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_LargeR, TARGET_ENE_0, DIST_Near, 0);

	elseif NR_fate <= 80 then
		goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);

	else
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_StepF, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_NONE, DIST_Middle, 0);
	end
end
	

	
---------------------------------------------------------
--  攻撃後の行動
---------------------------------------------------------
function KoudouBG_834000Battle_Kougeki_Noato(ai, goal)

local KN_fate = ai:GetRandam_Int(1,100);			--確率判定用

	if KN_fate <= 40 then
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, ai:GetRandam_Int(2,4), TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(30,55), true, true , 4 );
	else
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, ai:GetRandam_Int(2,4), TARGET_ENE_0, ai:GetRandam_Int(2,5), TARGET_ENE_0, true, 4 );				
	end
end




---------------------------------------------------------
--  ゴール更新
---------------------------------------------------------
function KoudouBG_834000Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  ゴール終了
---------------------------------------------------------
function KoudouBG_834000Battle_Terminate(ai, goal)
end



---------------------------------------------------------
--  割り込み
--	割り込んだ場合にはtrueを返してください。
--	ここで割り込み用のサブゴールを追加してください。
--	割り込まなかった場合には、1つ上の層のゴール、またはロジック部分によって割り込みが処理されます。
---------------------------------------------------------
function KoudouBG_834000Battle_Interupt(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);			--敵ターゲットとの距離を取得

local fate = ai:GetRandam_Int(1,100)					--確率判定用
local fate2 = ai:GetRandam_Int(1,100)					--確率判定用
local fate3 = ai:GetRandam_Int(1,100)					--確率判定用
local fate4 = ai:GetRandam_Int(1,100)					--確率判定用

local NormalR_Dist = 2.5			--右手攻撃の適正間合い

	
	--飛び道具を撃ってきたら最適行動
	if ai:IsInterupt( INTERUPT_Shoot ) then
local shootIntPer = 10					--飛び道具使用時に最適行動を取る確率
		if fate <= shootIntPer then
			goal:ClearSubGoal();
			goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 3.0, TARGET_ENE_0, ai:GetRandam_Int(2,5), TARGET_ENE_0, true, 4 );
			return true;
		end
	end
	
	--アイテムを使ったら最適行動
	if ai:IsInterupt( INTERUPT_UseItem ) then
local itemUseIntPer = 10				--アイテム使用時に最適行動を取る確率
		if fate <= itemUseIntPer then
			goal:ClearSubGoal();
				if fate2 <= 80 then
				 	goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, -1 );
					goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
					KoudouBG_834000Battle_Kougeki_Noato(ai, goal);
				else
					goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, -1 );
					goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_LargeR, TARGET_ENE_0, DIST_Near, 0);
					KoudouBG_834000Battle_Kougeki_Noato(ai, goal);
				end
			return true
		end
	end


return false;
end

