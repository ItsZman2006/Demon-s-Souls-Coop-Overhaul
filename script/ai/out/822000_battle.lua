-----------------------------------------------------------------------------------------------
--	ドラン用戦闘
--	説明：
--
--	パラメータ0  なし
--	パラメータ1  なし
--	パラメータ2  なし
--	パラメータ3　なし
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_Doran_822000_Battle, "doran_822000Battle");

-- Updateでなにもやっていないので、呼ばないようにする
REGISTER_GOAL_NO_UPDATE( GOAL_Doran_822000_Battle, 1 );


---------------------------------------------------------
--  ゴール起動
---------------------------------------------------------
function doran_822000Battle_Activate(ai, goal)
-------------------------------------------------------------------------------

	--イベントリクエストが-1
	--霊廟の鍵を奪った状態なら
	if (-1==ai:GetEventRequest()) then
		
		--行動・手加減なし
		doran_822000Battle_Normal(ai, goal)
	
	--イベントリクエストが-1以外
	--霊廟の鍵を貰った状態なら
	else
		
		--行動・手加減あり
		doran_822000Battle_Allowance(ai, goal)
		
	end

end

---------------------------------------------------------
--  行動・手加減あり
---------------------------------------------------------
function doran_822000Battle_Allowance(ai, goal)

local hprate = ai:GetHpRate( TARGET_SELF )		--自分のHP割合を取得

	--自分のHPが残り8割以上
	--ドランが剣を明け渡すまで
	if hprate >= 0.8 then

		--行動・手加減
		doran_822000Battle_Allowance_Action(ai, goal)
		
	else
	
		--行動・瀕死時
		doran_822000Battle_Dying_Action(ai, goal)	
	
	end

end

---------------------------------------------------------
--  行動・手加減
---------------------------------------------------------
function doran_822000Battle_Allowance_Action(ai, goal)

local fate = ai:GetRandam_Int(1,100)	--確率判定用

	--20% 歩いて近づいて攻撃
	if fate <= 20 then
		goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, true, -1 );
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
		doran_822000Battle_Kougeki_Noato(ai, goal)

	--80% 旋回して様子見
	else
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, ai:GetRandam_Int(1,3), TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(25,45), true, true ,-1 );
	end
	
end

---------------------------------------------------------
--  行動・手加減なし
---------------------------------------------------------
function doran_822000Battle_Normal(ai, goal)

local hprate = ai:GetHpRate( TARGET_SELF )				--自分のHP割合を取得

	--自分のHPが残り8割以上
	if hprate >= 0.8 then
	
		--行動・非瀕死時
		doran_822000Battle_Normal_Action(ai, goal)
		
	--自分の残りHPが8割以下
	else
		
		--行動・瀕死時
		doran_822000Battle_Dying_Action(ai, goal)
	
	end	
end


---------------------------------------------------------
--  行動・非瀕死時
---------------------------------------------------------
function doran_822000Battle_Normal_Action(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);	--敵ターゲットとの距離を取得
local farDist = 15.0							--遠いと判断する距離
local nearDist = 4.0							--近いと判断する距離
local NormalR_Dist = 2.5						--右手攻撃の適正間合い


	--遠いなら
	if targetDist >= farDist then

		doran_822000Battle_Far_Dist_Action(ai, goal)
	
	--遠くもないが、近くもないなら
	elseif targetDist >= nearDist then
		
		doran_822000Battle_Near_Dist_Action(ai, goal)
	
	--近いなら
	elseif targetDist >= NormalR_Dist then
	
		doran_822000Battle_NormalR_Dist_Action(ai, goal)

	--極端に近いなら
	else
	
		doran_822000Battle_TooNear_Dist_Action(ai, goal)
	
	end
end

---------------------------------------------------------
--  行動・瀕死時
---------------------------------------------------------
function doran_822000Battle_Dying_Action(ai, goal)

local NormalR_Dist = 2.5			--右手攻撃の適正間合い

	goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, -1 );
	doran_822000Battle_NormalR_Comb2(ai, goal)
	doran_822000Battle_Kougeki_Noato2(ai, goal)

end


---------------------------------------------------------
--  行動・非瀕死時・遠距離
---------------------------------------------------------
function doran_822000Battle_Far_Dist_Action(ai, goal)

local NormalR_Dist = 2.5			--右手攻撃の適正間合い

	--100％　走って近づく
	goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, -1 );
	doran_822000Battle_NormalR_Comb(ai, goal)
	doran_822000Battle_Kougeki_Noato(ai, goal)

end


---------------------------------------------------------
--  行動・非瀕死時・中距離
---------------------------------------------------------
function doran_822000Battle_Near_Dist_Action(ai, goal)

local fate = ai:GetRandam_Int(1,100)		--確率判定で使用する運命の数字
local NormalR_Dist = 2.5			--右手攻撃の適正間合い


	--60％　歩いて近づいて攻撃
	--40％　横移動で様子見
	if fate <= 60 then
		goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, true, -1 );
		doran_822000Battle_NormalR_Comb(ai, goal)
		doran_822000Battle_Kougeki_Noato(ai, goal)
	else
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, ai:GetRandam_Int(1,3), TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(25,45), true, true ,-1 );
	end

end

---------------------------------------------------------
--  行動・非瀕死時・近距離
---------------------------------------------------------
function doran_822000Battle_NormalR_Dist_Action(ai, goal)

local fate = ai:GetRandam_Int(1,100)		--確率判定で使用する運命の数字
local NormalR_Dist = 2.5			--右手攻撃の適正間合い


	--40％　歩いて近づいて攻撃	
	--60％　旋回し様子を窺う
	if fate <= 40 then
		goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 3.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, true, -1 );
		doran_822000Battle_NormalR_Comb(ai, goal)
		doran_822000Battle_Kougeki_Noato(ai, goal)
	else
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, ai:GetRandam_Int(1,3), TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(25,55), true, true ,-1 );
	end

end

---------------------------------------------------------
--  行動・非瀕死時・至近距離
---------------------------------------------------------
function doran_822000Battle_TooNear_Dist_Action(ai, goal)

local fate = ai:GetRandam_Int(1,100)		--確率判定で使用する運命の数字
local fate2 = ai:GetRandam_Int(1,100)		--確率判定で使用する運命の数字　その２

	--30％　攻撃
	--70％　移動
	if fate <= 30 then
		doran_822000Battle_NormalR_Comb(ai, goal)
		doran_822000Battle_Kougeki_Noato(ai, goal)
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
function doran_822000Battle_NormalR_Comb(ai, goal)

local NR_fate = ai:GetRandam_Int(1,100)			--確率判定用
local NR_fate2 = ai:GetRandam_Int(1,100)		--確率判定用
local NR_fate3 = ai:GetRandam_Int(1,100)		--確率判定用
local NR_fate4 = ai:GetRandam_Int(1,100)		--確率判定用

	--右手攻撃２回
	--10% パンチからの連携
	--5% 前転攻撃
	--85% 右手攻撃
	if NR_fate <= 10 then
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalL, TARGET_ENE_0, DIST_Near, 0);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_LargeR, TARGET_ENE_0, DIST_Near, 0);
	elseif NR_fate <= 15 then
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_StepF, TARGET_ENE_0, DIST_None, 0);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_NONE, DIST_Near, 0);
	else
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
	end
	
	--10% 追加攻撃 右手通常
	if NR_fate2 <= 10 then
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
	end
	
	--10% 追加攻撃 右手強
	if NR_fate3 <= 10 then
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_LargeR, TARGET_ENE_0, DIST_Near, 0);
	end	

end
	
---------------------------------------------------------
--  右手コンボ2・猛攻撃
---------------------------------------------------------
function doran_822000Battle_NormalR_Comb2(ai, goal)

local NR_fate = ai:GetRandam_Int(1,100)			--確率判定用
local NR_fate2 = ai:GetRandam_Int(1,100)		--確率判定用

	--両手攻撃２回
	--20% 前転攻撃から強攻撃コンボ
	--40% 弱弱強コンボ
	--20% 弱強弱コンボ
	--20% 弱弱弱強コンボ

	--両手持ちに切り替える
	CommonNPC_SwitchBothHandMode(ai, goal)
	
	if NR_fate <= 20 then
		
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_StepF, TARGET_ENE_0, DIST_None, 0);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_NONE, DIST_Near, 0);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_LargeR, TARGET_ENE_0, DIST_Near, 0);
		
	elseif NR_fate <= 60 then
		
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_LargeR, TARGET_ENE_0, DIST_Near, 0);
	
	elseif NR_fate <= 80 then
		
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_LargeR, TARGET_ENE_0, DIST_Near, 0);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);

	else
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_Near, 0);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, NPC_ATK_LargeR, TARGET_ENE_0, DIST_Near, 0);
	end
		
end


	
---------------------------------------------------------
--  攻撃後の行動
---------------------------------------------------------
function doran_822000Battle_Kougeki_Noato(ai, goal)

local KN_fate = ai:GetRandam_Int(1,100)			--確率判定用
local KN_fate2 = ai:GetRandam_Int(1,100)		--確率判定用
local BackDist = 2.5							--後退する距離

	--70％　何もしない
	--30％　横に移動
	--15％　後ろに移動
	--40％　ステップで後退
	if KN_fate <= 40 then
		goal:AddSubGoal( GOAL_COMMON_Wait, 2.0, TARGET_NONE, 0, 0, 0 );	
	elseif KN_fate <= 70 then
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, 10.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(25,45), true, true ,-1 );
	elseif KN_fate <= 85 then
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 10.0, TARGET_ENE_0, BackDist, TARGET_ENE_0, true, -1 );				
	else
		if KN_fate2 <= 90 then
			goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepB, TARGET_ENE_0, DIST_None, 0);
		else
			goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepB, TARGET_ENE_0, DIST_None, 0);
			goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_None, 0);
		end			
	end
end

---------------------------------------------------------
--  攻撃後の行動・瀕死時
---------------------------------------------------------
function doran_822000Battle_Kougeki_Noato2(ai, goal)

local KN_fate = ai:GetRandam_Int(1,100)			--確率判定用
local KN_fate2 = ai:GetRandam_Int(1,100)		--確率判定用
local BackDist = 2.5							--後退する距離

	--70％　ガードしながら後退
	--30％　横に移動
	--15％　後ろに移動
	--40％　ステップで後退
	if KN_fate <= 50 then
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 10.0, TARGET_ENE_0, BackDist, TARGET_ENE_0, true, 4 );	
	elseif KN_fate <= 60 then
		goal:AddSubGoal(GOAL_COMMON_Guard, 10.0, 4, TARGET_ENE_0, false, 0);
	elseif KN_fate <= 70 then
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, 10.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(25,45), false, true ,4 );
	elseif KN_fate <= 85 then
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 10.0, TARGET_ENE_0, BackDist, TARGET_ENE_0, false, -1 );				
	else
		if KN_fate2 <= 90 then
			goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepB, TARGET_ENE_0, DIST_None, 0);
		else
			goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepB, TARGET_ENE_0, DIST_None, 0);
			goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_NormalR, TARGET_ENE_0, DIST_None, 0);
		end			
	end
end


---------------------------------------------------------
--  ゴール更新
---------------------------------------------------------
function doran_822000Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  ゴール終了
---------------------------------------------------------
function doran_822000Battle_Terminate(ai, goal)
end



---------------------------------------------------------
--  割り込み
--	割り込んだ場合にはtrueを返してください。
--	ここで割り込み用のサブゴールを追加してください。
--	割り込まなかった場合には、1つ上の層のゴール、またはロジック部分によって割り込みが処理されます。
---------------------------------------------------------
function doran_822000Battle_Interupt(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);			--敵ターゲットとの距離を取得

local fate = ai:GetRandam_Int(1,100)					--確率判定用
local fate2 = ai:GetRandam_Int(1,100)					--確率判定用
local fate3 = ai:GetRandam_Int(1,100)					--確率判定用
local fate4 = ai:GetRandam_Int(1,100)					--確率判定用

local NormalR_Dist = 2.5			--右手攻撃の適正間合い
local hprate = ai:GetHpRate( TARGET_SELF )	--自分のHPの割合を取得


	--空振りしたら攻撃
	if ai:IsInterupt( INTERUPT_MissSwing ) then
local MissSwingDist = 2.0			--空振り追撃する距離
local MissSwingAttPer = 40			--空振り追撃する確率	
		if targetDist <= MissSwingDist then
			if fate <= MissSwingAttPer then
				goal:ClearSubGoal();
				doran_822000Battle_NormalR_Comb(ai, goal)
				doran_822000Battle_Kougeki_Noato(ai, goal)
				return true;
			end
		end	
	end

	--至近距離でダメージ受けたらコンボとみなして後退orガード・反撃
	if ai:IsInterupt( INTERUPT_Damaged ) then
local combRunDist = 2.0				--コンボ逃れする距離
local combRunPer = 60				--コンボ逃れする確率
local combRunCountPer = 30			--コンボ逃れの後に攻撃する確率
local combGuardPer = 60				--コンボをガードする確率	
		if targetDist < combRunDist then
			if fate <= combRunPer then
				goal:ClearSubGoal();
				--逃れる
					if hprate <= 0.8 then
						if fate2 <= combGuardPer then
							goal:AddSubGoal(GOAL_COMMON_Guard, 10.0, 4, TARGET_ENE_0, false, 0);
						else
							goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepB, TARGET_ENE_0, DIST_None, 0);
						end
					else
						goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepB, TARGET_ENE_0, DIST_None, 0);
					end
				return true;
			end
		end
	end	
	
	--至近距離で攻撃されそうになったら超反応ステップorガード
	if ai:IsInterupt( INTERUPT_FindAttack ) then
local superStepDist = 2.0			--超反応する距離
local superStepPer = 40				--超反応する確率
local superGuardPer = 50			--ステップの代わりにガードする確率
		if targetDist <= superStepDist then
			if fate <= superStepPer then
				goal:ClearSubGoal();
				if hprate <= 0.8 then
					if fate2 <= superGuardPer then
						goal:AddSubGoal(GOAL_COMMON_Guard, 10.0, 4, TARGET_ENE_0, false, 0);
					else
						goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepB, TARGET_ENE_0, DIST_None, 0);
					end
				else
					goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepB, TARGET_ENE_0, DIST_None, 0);
				end
				return true;
			end
		end
	end
	
	--ガード崩壊したら攻撃
	if ai:IsInterupt( INTERUPT_GuardBreak ) then
local guardBreakConutDist = 4.0			--ガード崩壊で攻撃する距離
local guardBreakConutPer = 50			--ガード崩壊で攻撃する確率
		if targetDist <= guardBreakConutDist then
			if fate <= guardBreakConutPer then
				goal:ClearSubGoal();
				goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_LargeR, TARGET_ENE_0, DIST_Near, 0);
				doran_822000Battle_Kougeki_Noato(ai, goal)
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
				goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepL, TARGET_ENE_0, DIST_None, 0);
			else
				goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_StepR, TARGET_ENE_0, DIST_None, 0);
			end
			return true;
		end
	end
	
	--アイテムを使ったら最適行動
	if ai:IsInterupt( INTERUPT_UseItem ) then
local itemUseIntPer = 100				--アイテム使用時に最適行動を取る確率
		if fate <= itemUseIntPer then
			goal:ClearSubGoal();

			--自分のHPが6割以上だったら
			if hprate >= 0.6 then
			 	goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, -1 );
				goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_LargeR, TARGET_ENE_0, DIST_Near, 0);
				doran_822000Battle_Kougeki_Noato(ai, goal)

			--自分のHPが6割以下だったら
			else

				--一回だけアイテムを使う
				if ( 0 == ai:GetNumber(0) ) then
					goal:AddSubGoal( GOAL_COMMON_UseItem, 10.0, 0 );
					ai:SetNumber(0,1) 

				--一回終わっていれば
				else
					goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, NormalR_Dist, TARGET_ENE_0, false, -1 );
					goal:AddSubGoal( GOAL_COMMON_Attack, 10.0, NPC_ATK_LargeR, TARGET_ENE_0, DIST_Near, 0);
					doran_822000Battle_Kougeki_Noato(ai, goal)
				end
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
			return true;
		end
	end
	
	--敵のガードで武器がはじかれたら左右ステップをする（右優先）
	if ai:IsInterupt( INTERUPT_ReboundByOpponentGuard ) then
local GuardReboundMovePer = 50			--はじかれた時に移動をする確率
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



