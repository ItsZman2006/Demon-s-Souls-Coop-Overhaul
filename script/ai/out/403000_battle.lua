--[[*******************************************************************************************
	Tako403000専用戦闘
	説明：

	●主な修正履歴：
		整理　08/8/6 hasem
	
	●パラメータ
		パラメータ0  なし
		パラメータ1  なし
		パラメータ2  なし
		パラメータ3　なし
		
	●ai:AddObserveArea()の使用状況。
		０：中距離に入ってきた時をハンドリング。
		１：
		２：
		３：
*********************************************************************************************]]
REGISTER_GOAL(GOAL_Tako403000_Battle, "Tako403000Battle");

-- Updateでなにもやっていないので、呼ばないようにする
REGISTER_GOAL_NO_UPDATE( GOAL_Tako403000_Battle, true);
--~ REGISTER_GOAL_NO_INTERUPT( GOAL_Tako403000_Battle, true);


--[[*****************************************************
	ゴール起動
*******************************************************]]
function Tako403000Battle_Activate(ai, goal)

	local targetDist 	= ai:GetDist(TARGET_ENE_0);			--敵ターゲットとの距離
	local NEAR_RANGE	= ai:GetDistParam(DIST_Near);		--エクセルパラメータ（近距離）
	local MIDDLE_RANGE	= ai:GetDistParam(DIST_Middle);		--エクセルパラメータ（中距離）
	local FAR_RANGE		= ai:GetDistParam(DIST_Far);		--エクセルパラメータ（遠距離）
	local OUT_OF_RANGE	= ai:GetDistParam(DIST_Out);		--エクセルパラメータ（範囲外）
	
	--中距離以遠で引っ掛けておいた監視領域を削除。
	ai:DeleteObserveArea(0);
	
	--行動選択。
	if 		( targetDist < NEAR_RANGE ) 	then	Tako403000Battle_Attack_Near(ai, goal);
	elseif	( targetDist < MIDDLE_RANGE ) 	then	Tako403000Battle_Attack_Middle(ai, goal);
	elseif	( targetDist < FAR_RANGE ) 		then	Tako403000Battle_Attack_Far(ai, goal);
	else											Tako403000Battle_Attack_OutOfRange(ai, goal);
	end
end

---------------------------------------------------------
--  攻撃（近距離）
---------------------------------------------------------
function Tako403000Battle_Attack_Near(ai, goal)

	--100% 自分中心爆発。
	goal:AddSubGoal(GOAL_COMMON_Attack, 5.0, 3001, TARGET_ENE_0, DIST_None, 0);
end

---------------------------------------------------------
--  攻撃（中距離）
---------------------------------------------------------
function Tako403000Battle_Attack_Middle(ai, goal)
	--攻撃する
	--攻撃後行動
	Tako403000Battle_Throw(ai, goal)
	Tako403000Battle_Throw_Noato(ai, goal)
end

---------------------------------------------------------
--  攻撃（遠距離）
---------------------------------------------------------
function Tako403000Battle_Attack_Far(ai, goal)
	local fate 			= ai:GetRandam_Int(1,100)					--確率判定で使用する運命の数字
	--60％　遠距離魔法 待機　　40％　距離キープ
	if fate < 60 then
		Tako403000Battle_MagicArrow(ai, goal);
	else
		goal:AddSubGoal(GOAL_COMMON_KeepDist, 2.0, TARGET_ENE_0, 4.0, 10.0, TARGET_ENE_0, true, -1 );
	end
	
	--中間距離侵入監視。
	Tako403000Battle_ObserveMiddleRange(ai);
end

---------------------------------------------------------
--  攻撃（範囲外）
---------------------------------------------------------
function Tako403000Battle_Attack_OutOfRange(ai, goal)

	local fate 			= ai:GetRandam_Int(1,100);
	local fate2			= ai:GetRandam_Int(1,100);
	local MIDDLE_RANGE	= ai:GetDistParam(DIST_Middle);		--エクセルパラメータ（中距離）
	
	--70％　遠距離魔法＆待機
	--20％　距離キープ→70％　遠距離魔法＆待機
	--10％　走り接近
	if (fate < 70) then
	
		Tako403000Battle_MagicArrow(ai, goal);
		
	elseif (fate < 90) then
	
		goal:AddSubGoal( GOAL_COMMON_KeepDist, 2.0, TARGET_ENE_0, 8.0, 12.0, TARGET_ENE_0, false, -1 );
		
		if (fate2 < 70) then
			Tako403000Battle_MagicArrow(ai, goal);
		end
		
	else
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 5.0, TARGET_ENE_0, MIDDLE_RANGE, TARGET_ENE_0, false, -1 );
	end
	
	--中間距離侵入監視。
	Tako403000Battle_ObserveMiddleRange(ai);
end

---------------------------------------------------------
--  マジックアロー攻撃。
---------------------------------------------------------
function Tako403000Battle_MagicArrow(ai, goal)
	goal:AddSubGoal(GOAL_COMMON_ComboAttack, 5.0, 3003, TARGET_ENE_0, DIST_None, 0);
	goal:AddSubGoal(GOAL_COMMON_Wait, 0.5, TARGET_ENE_0);
end

---------------------------------------------------------
--  金縛り⇒投げコンボ
---------------------------------------------------------
function Tako403000Battle_Throw(ai, goal)

--[[■調整項目■]]

	--投げ間合い[m]
	local THROW_RANGE	= 0.5;
	
	--前ステップ安全距離
	local STEP_F_SAFTYRANGE	= 1;

--[[■調整項目■]]

	--金縛り⇒投げコンボ
	goal:AddSubGoal(GOAL_COMMON_Attack, 		5.0, 3000, TARGET_ENE_0, DIST_None, 0);
	goal:AddSubGoal(GOAL_Tako403000_ThrowComboApproach, 	8.0, THROW_RANGE);
	goal:AddSubGoal(GOAL_Tako403000_Throw, 		5.0);
end
	
	
---------------------------------------------------------
--  攻撃後の行動
---------------------------------------------------------
function Tako403000Battle_Throw_Noato(ai, goal)

local KN_fate = ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字
local BackDist = ai:GetRandam_Float(2.0, 3.0)	--後退する距離
local BackTime = 6.0							--後退する時間
local SideTime = 6.0							--横に動く時間

	--60% 後ろに移動
	--20% なにもしない（ちょっとだけ横移動）
	--20% 適当に横に移動
	if KN_fate < 60 then
		goal:AddSubGoal(GOAL_COMMON_LeaveTarget, BackTime, TARGET_ENE_0, BackDist, TARGET_ENE_0, true, -1 );				
	elseif KN_fate < 80 then
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, 6.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), 10, true, true ,-1 );
	else
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, SideTime, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(15,30), true, true ,-1 );
	end
end


---------------------------------------------------------
--  中間距離監視
---------------------------------------------------------
function Tako403000Battle_ObserveMiddleRange(ai)
	local MIDDLE_RANGE	= ai:GetDistParam(DIST_Middle);		--エクセルパラメータ（中距離）
	
	--中間距離に入った事を監視して、割り込ませる。
	ai:AddObserveArea( 0, TARGET_SELF, TARGET_ENE_0, AI_DIR_TYPE_CENTER, 360, MIDDLE_RANGE);
end


--[[*****************************************************
	更新・終了なし。
*******************************************************]]
function Tako403000Battle_Update(ai, goal) return GOAL_RESULT_Continue; end
function Tako403000Battle_Terminate(ai, goal) end


--[[*****************************************************
	割り込み
*******************************************************]]
function Tako403000Battle_Interupt(ai, goal)

--[[■調整項目■]]

	--ターゲット空振り時攻撃する割合。
	local ATTACK_RATE	= 25;

--[[■調整項目■]]

	local targetDist 	= ai:GetDist(TARGET_ENE_0);			--敵ターゲットとの距離を取得
	local MIDDLE_RANGE	= ai:GetDistParam(DIST_Middle);		--エクセルパラメータ（中距離）
	local fate 			= ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字

	--空振り追い討ち
	--25％　近くのターゲットが空振りしたら攻撃
	if (ai:IsInterupt( INTERUPT_MissSwing)) then
		if (targetDist < MIDDLE_RANGE) then
			if (fate <= ATTACK_RATE) then
				goal:ClearSubGoal();
				Tako403000Battle_Attack_Middle(ai, goal);
				return true;
			end	
		end
	end

	--中距離に入ってきたとき。
	if ( ai:IsInterupt(INTERUPT_Inside_ObserveArea) ) then
		if ( ai:IsInsideObserveArea(0) ) then
			--監視領域を削除。
			ai:DeleteObserveArea(0);
			--中距離攻撃を出す。
			goal:ClearSubGoal();
			Tako403000Battle_Attack_Middle(ai, goal);
			return true;
		end
	end
	
	return false;

end





--[[****************************************************************************************************************]]
--[[************************************************ サブゴール ****************************************************]]
--[[****************************************************************************************************************]]


--[[*******************************************************************************************
	痺れコンボ時接近
*********************************************************************************************]]
REGISTER_GOAL(GOAL_Tako403000_ThrowComboApproach, "Tako403000TCA");
REGISTER_GOAL_NO_UPDATE( GOAL_Tako403000_ThrowComboApproach, true);
REGISTER_GOAL_NO_INTERUPT( GOAL_Tako403000_ThrowComboApproach, true);

function Tako403000TCA_Activate(ai, goal)
	local THROW_RANGE	= goal:GetParam(0);
	goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 8.0, TARGET_ENE_0, THROW_RANGE, TARGET_ENE_0, false, -1 );
	
	--アニメ切り替え。
	ai:ChangeMoveAnimParam(1);
end

function Tako403000TCA_Terminate(ai, goal) 
	--アニメ切り替え。
	ai:ChangeMoveAnimParam(0);
end

function Tako403000TCA_Update(ai, goal) return GOAL_RESULT_Continue; end
function Tako403000TCA_Interupt(ai, goal) return false; end


--[[*******************************************************************************************
	痺れコンボ時投げ
*********************************************************************************************]]
REGISTER_GOAL(GOAL_Tako403000_Throw, "Tako403000Throw");
REGISTER_GOAL_NO_UPDATE(GOAL_Tako403000_Throw, true);
REGISTER_GOAL_NO_INTERUPT(GOAL_Tako403000_Throw, true);

function Tako403000Throw_Activate(ai, goal)

	--しびれていたら、投げ
	--しびれていなければ、リプランニング。
	if ( ai:HasParalysis(TARGET_ENE_0) ) then
		goal:AddSubGoal(GOAL_COMMON_Attack, 5.0, 3002, TARGET_ENE_0, DIST_None, 0);
	else
		ai:Replaning();
	end

end

function Tako403000Throw_Terminate(ai, goal) end
function Tako403000Throw_Update(ai, goal) return GOAL_RESULT_Continue; end
function Tako403000Throw_Interupt(ai, goal) return false; end






