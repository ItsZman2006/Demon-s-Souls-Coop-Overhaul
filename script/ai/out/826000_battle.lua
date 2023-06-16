-----------------------------------------------------------------------------------------------
--	神の信徒３用戦闘
--	説明：
--
--	パラメータ0  なし
--	パラメータ1  なし
--	パラメータ2  なし
--	パラメータ3　なし
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_Sinto3_826000_Battle, "sinto3_826000Battle");

-- Updateでなにもやっていないので、呼ばないようにする
REGISTER_GOAL_NO_UPDATE( GOAL_Sinto3_826000_Battle, 1 );


---------------------------------------------------------
--  ゴール起動
---------------------------------------------------------
function sinto3_826000Battle_Activate(ai, goal)
-------------------------------------------------------------------------------

local hprate = ai:GetHpRate( TARGET_SELF )		--自分のHPの割合を取得

	--HPが3割以上なら
	if hprate >= 0.3 then
		
		--通常行動
		sinto3_826000Battle_Nomal(ai, goal)
	
	--HPが3割以下なら	
	else
		
		--瀕死行動
		sinto3_826000Battle_Dying(ai, goal)

	end
end

---------------------------------------------------------
--  通常行動
---------------------------------------------------------
function sinto3_826000Battle_Nomal(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);			--敵ターゲットとの距離を取得
local fate = ai:GetRandam_Int(1,100)		--確率判定で使用する運命の数字
local fate2 = ai:GetRandam_Int(1,100)		--確率判定で使用する運命の数字　その２

local NormalR_Dist = 0.5					--右手攻撃の適正間合い

	--武器を持っていなければ持ち替える
	CommonNPC_ChangeWepR2(ai, goal)

	--30%　旋回して様子見
	if fate <= 30 then
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, 2.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(15,25), true, true , -1 );

	--20%　距離を取る
	elseif fate <= 50 then 
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 2.0, TARGET_ENE_0, ai:GetRandam_Int(3,5), TARGET_ENE_0, true, -1 );
	
	--50%　接近して攻撃
	else
		goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, -1);
		sinto3_826000Battle_Attack(ai, goal)
		sinto3_826000Battle_Kougeki_Noato(ai, goal)
	end
end

---------------------------------------------------------
--  瀕死行動
---------------------------------------------------------
function sinto3_826000Battle_Dying(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);	--敵ターゲットとの距離を取得
local farDist = 8.0								--遠いと判断する距離

local selfmp = ai:GetMp(TARGET_SELF)			--自分の残りMPを取得

	--MPが30より多ければ
	if selfmp >= 30 then
	
		--敵から距離をとる
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 4.0, TARGET_ENE_0, 5.0, TARGET_ENE_0, false, -1 );
		
		--タリスマンを持っていなければタリスマンに切り替え
		CommonNPC_ChangeWepR1(ai, goal)
		
		--奇跡を使ってHP回復
		goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_MagicR, TARGET_SELF, DIST_None, 0 );
		sinto3_826000Battle_Kougeki_Noato(ai, goal)
		
	--MPが30より少なければ
	else

		--100% 通常攻撃
		sinto3_826000Battle_Nomal(ai, goal)
		sinto3_826000Battle_Kougeki_Noato(ai, goal)
		
	end

end


---------------------------------------------------------
--  攻撃行動
---------------------------------------------------------
function sinto3_826000Battle_Attack(ai, goal)

local fate = ai:GetRandam_Int(1,100)		--確率判定用

	if fate <= 40 then
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
		
	elseif fate <= 80 then
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
		
	else
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_LargeR, TARGET_ENE_0, DIST_Near, 0);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_LargeR, TARGET_ENE_0, DIST_Near, 0);
	end
end
	
---------------------------------------------------------
--  攻撃後の行動
---------------------------------------------------------
function sinto3_826000Battle_Kougeki_Noato(ai, goal)

local KN_fate = ai:GetRandam_Int(1,100)			--確率判定用
local KN_fate2 = ai:GetRandam_Int(1,100)		--確率判定用
local BackDist = 3.0							--後退する距離

	--10％　少し待つ
	--40％　横に移動
	--30％　後ろに移動
	--20％　ステップで後退
	if KN_fate <= 20 then
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 3.0, TARGET_ENE_0, BackDist, TARGET_ENE_0, false, -1 );
		goal:AddSubGoal( GOAL_COMMON_Wait, 2.0, TARGET_NONE, 0, 0, 0 );
	elseif KN_fate <= 50 then
		goal:AddSubGoal( GOAL_COMMON_SidewayMove, ai:GetRandam_Int(2,4), TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(25,45), true, true , -1 );
	else
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, ai:GetRandam_Int(1,3), TARGET_ENE_0, BackDist, TARGET_ENE_0, true, -1 );				
		goal:AddSubGoal( GOAL_COMMON_SidewayMove, ai:GetRandam_Int(2,4), TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(25,50), true, true , -1 );
	end
end


---------------------------------------------------------
--  ゴール更新
---------------------------------------------------------
function sinto3_826000Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  ゴール終了
---------------------------------------------------------
function sinto3_826000Battle_Terminate(ai, goal)
end



---------------------------------------------------------
--  割り込み
--	割り込んだ場合にはtrueを返してください。
--	ここで割り込み用のサブゴールを追加してください。
--	割り込まなかった場合には、1つ上の層のゴール、またはロジック部分によって割り込みが処理されます。
---------------------------------------------------------
function sinto3_826000Battle_Interupt(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);			--敵ターゲットとの距離を取得

local fate = ai:GetRandam_Int(1,100)					--確率判定用
local fate2 = ai:GetRandam_Int(1,100)					--確率判定用
local fate3 = ai:GetRandam_Int(1,100)					--確率判定用
local fate4 = ai:GetRandam_Int(1,100)					--確率判定用

local NormalR_Dist = 0.5			--右手攻撃の適正間合い


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
					goal:AddSubGoal( GOAL_COMMON_LeaveTarget, ai:GetRandam_Int(3,5), TARGET_ENE_0, ai:GetRandam_Int(2,7), TARGET_ENE_0, false, -1 );
				else
					goal:AddSubGoal(GOAL_COMMON_SidewayMove, ai:GetRandam_Int(1,3), TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(25,45), ai:GetRandam_Int(0,1), true ,-1 );
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


