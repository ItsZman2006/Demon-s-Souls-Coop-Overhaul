--[[*******************************************************************************************
	影女用戦闘
	説明：

	パラメータ0  なし
	パラメータ1  なし
	パラメータ2  なし
	パラメータ3　なし

	●ai:SetNumber()の使用状況。
		０：
		１：
		２：
		３：コッソリ移動終了したか？　０以外で終了とする。
*********************************************************************************************]]
REGISTER_GOAL(GOAL_kageonna213000_Battle, "kageonna213000_Battle");

-- Updateでなにもやっていないので、呼ばないようにする
REGISTER_GOAL_NO_UPDATE( GOAL_kageonna213000_Battle, true);

--[[*****************************************************
	ゴール起動
*******************************************************]]
function kageonna213000_Battle_Activate(ai, goal)
-------------------------------------------------------------------------------

--[[■調整項目■]]

	local BACKPOS__ANGLE_RANGE	= 10;		--割り込みが掛かる角度
	local BACKPOS__DIST_RANGE	= 5;		--割り込みが掛かる距離

--[[■調整項目■]]

	--相手の背後に回りこんだかチェック。
	ai:AddObserveArea( 0, TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_B, BACKPOS__ANGLE_RANGE, BACKPOS__DIST_RANGE);

-------------------------------------------------------------------------------

local targetDist = ai:GetDist(TARGET_ENE_0);		--敵ターゲットとの距離を取得
local fate = ai:GetRandam_Int(1,100)				--確率判定で使用する運命の数字
local fate2 = ai:GetRandam_Int(1,100)				--確率判定で使用する運命の数字　その２
local fate3 = ai:GetRandam_Int(1,100)				--確率判定で使用する運命の数字　その３
 
local Att3000_Dist_min = 0.0					--3000番の適正間合い（最小）
local Att3000_Dist_max = 1.1					--3000番の適正間合い（最大）
local Att3001_Dist_min = 0.0					--3001番の適正間合い（最小）
local Att3001_Dist_max = 0.9					--3001番の適正間合い（最大）
local Att3002_Dist_min = 0.0					--3002番の適正間合い（最小）
local Att3002_Dist_max = 1.1					--3002番の適正間合い（最大）
local Att3004_Dist_min = 0.0					--3004番の適正間合い（最小）
local Att3004_Dist_max = 3.0					--3004番の適正間合い（最大）

local Act01Per = 0		--速歩き＆近接コンボ
local Act02Per = 0		--歩行回り込み＆背面刺し
local Act03Per = 0		--ステップ＋歩行回り込み＆背面刺し	
local Act04Per = 0		--歩行接近＆近接コンボ
 
	--とても遠いなら
	if targetDist >= 10.0 then
		Act01Per = 100		--速歩き＆近接コンボ
		Act02Per = 0		--歩行回り込み＆背面刺し
		Act03Per = 0		--ステップ＋歩行回り込み＆背面刺し	
		Act04Per = 0		--歩行接近＆近接コンボ
		
	--背面を狙えそうもないくらいに遠いなら
	elseif targetDist >= 6.0 then
		Act01Per = 25		--速歩き＆近接コンボ
		Act02Per = 0		--歩行回り込み＆背面刺し
		Act03Per = 0		--ステップ＋歩行回り込み＆背面刺し	
		Act04Per = 75		--歩行接近＆近接コンボ
		
	--ある程度近くて、とても後が取れそうなら
	elseif targetDist >= 3.0 then
		if ai:IsInsideTargetEx( TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_B, 45.0, 6) then
			Act01Per = 0		--速歩き＆近接コンボ
			Act02Per = 100		--歩行回り込み＆背面刺し
			Act03Per = 0		--ステップ＋歩行回り込み＆背面刺し	
			Act04Per = 0		--歩行接近＆近接コンボ
		end
		
	--ある程度近くて、やや後が取れそうなら
	elseif targetDist >= 3.0 then
		if ai:IsInsideTargetEx( TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_B, 90.0, 6) then 
			Act01Per = 0		--速歩き＆近接コンボ
			Act02Per = 0		--歩行回り込み＆背面刺し
			Act03Per = 100		--ステップ＋歩行回り込み＆背面刺し	
			Act04Per = 0		--歩行接近＆近接コンボ
		end
		
	--うんと近くて、とても後が取れそうなら	
	elseif ai:IsInsideTargetEx( TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_B, 30.0, 3) then
		Act01Per = 0		--速歩き＆近接コンボ
		Act02Per = 100		--歩行回り込み＆背面刺し
		Act03Per = 0		--ステップ＋歩行回り込み＆背面刺し	
		Act04Per = 0		--歩行接近＆近接コンボ		
		
	--それ以外（＝近めだけど後は狙いにくい）
	else
		Act01Per = 0		--速歩き＆近接コンボ
		Act02Per = 0		--歩行回り込み＆背面刺し
		Act03Per = 0		--ステップ＋歩行回り込み＆背面刺し	
		Act04Per = 100		--歩行接近＆近接コンボ
		
	end

	
	--行動01　速歩き＆近接コンボ
	if fate2 <= Act01Per then
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 5.0, TARGET_ENE_0, Att3000_Dist_max, TARGET_ENE_0, false, -1 );
		kageonna213000_Battle_Kougeki(ai, goal)
		
	--行動02　歩行回り込み＆背面刺し
	elseif fate2 <= (Act01Per + Act02Per) then
		goal:AddSubGoal(GOAL_COMMON_TurnAround, 5.0, TARGET_ENE_0, AI_DIR_TYPE_B, 30, true, false, -1);	
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 5.0, TARGET_ENE_0, Att3004_Dist_max, TARGET_ENE_0, true, -1 );
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 5.0, 3004, TARGET_ENE_0, DIST_Middle, 0);
		
	--行動03　ステップ＋歩行回り込み＆背面刺し
	elseif fate2 <= (Act01Per + Act02Per + Act03Per) then
		--左側にいれば右ステップ
		if ai:IsInsideTargetEx( TARGET_ENE_0, TARGET_SELF, AI_DIR_TYPE_L, 180, 100) then
			goal:AddSubGoal(GOAL_COMMON_SpinStep, 5.0, 703, TARGET_ENE_0, -1, AI_DIR_TYPE_R, 4.0);
		--逆なら左ステップ	
		else
			goal:AddSubGoal(GOAL_COMMON_SpinStep, 5.0, 702, TARGET_ENE_0, -1, AI_DIR_TYPE_L, 4.0);
		end
		goal:AddSubGoal(GOAL_COMMON_TurnAround, 5.0, TARGET_ENE_0, AI_DIR_TYPE_B, 30, true, false, -1);	
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 5.0, TARGET_ENE_0, Att3004_Dist_max, TARGET_ENE_0, true, -1 );
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 5.0, 3004, TARGET_ENE_0, DIST_Middle, 0);
		
	--行動04　歩行接近＆近接コンボ
	else
		goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 5.0, TARGET_ENE_0, Att3000_Dist_max, TARGET_ENE_0, true, -1 );
		kageonna213000_Battle_Kougeki(ai, goal)
		
	end
	kageonna213000_Battle_Kougeki_Noato(ai, goal)
	
end	
	

---------------------------------------------------------
--  攻撃
---------------------------------------------------------
function kageonna213000_Battle_Kougeki(ai, goal)

local K_fate = ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字

	--10% 3000
	--50% 3000-3001
	--40% 3000-3001-3002
	
	if K_fate <= 10 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
		
	elseif K_fate <= 60 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);
		
	else
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Middle, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3002, TARGET_ENE_0, DIST_Middle, 0);
		
	end
end

	
	
---------------------------------------------------------
--  攻撃後の行動
---------------------------------------------------------
function kageonna213000_Battle_Kougeki_Noato(ai, goal)

local KN_fate = ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字

local KNAct01Per	= 20	--何もしない
local KNAct02Per	= 20	--右ステップ（セーフティ）
local KNAct03Per	= 20	--左ステップ（セーフティ）
local KNAct04Per	= 30	--横移動
local KNAct05Per	= 10	--バックステップ（セーフティ）

	--行動01　何もしない
	if  KN_fate <= KNAct01Per then
   		goal:AddSubGoal(GOAL_COMMON_Wait, ai:GetRandam_Float (0.5,1.0) ,0,0,0,0)
		
	--行動02　右ステップ
	elseif  KN_fate <= (KNAct01Per + KNAct02Per) then
		goal:AddSubGoal(GOAL_COMMON_SpinStep, 5.0, 703, TARGET_ENE_0, 0, AI_DIR_TYPE_R, 4.0);
		
	--行動03　左ステップ
	elseif  KN_fate <= (KNAct01Per + KNAct02Per + KNAct03Per) then
		goal:AddSubGoal(GOAL_COMMON_SpinStep, 5.0, 702, TARGET_ENE_0, 0, AI_DIR_TYPE_L, 4.0);
		
	--行動04　少し横移動
	elseif  KN_fate <= (KNAct01Per + KNAct02Per + KNAct03Per + KNAct04Per) then
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, 5.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(30,45), true, true ,-1 );
		
	--行動05　バックステップ
	else
		goal:AddSubGoal(GOAL_COMMON_SpinStep, 5.0, 701, TARGET_ENE_0, 0, AI_DIR_TYPE_B, 4.0);
		
	end
end


--[[*****************************************************
	更新・終了なし。
*******************************************************]]
function kageonna213000_Battle_Update(ai, goal) return GOAL_RESULT_Continue; end
function kageonna213000_Battle_Terminate(ai, goal)end

--[[*****************************************************
	割り込み。
*******************************************************]]
function kageonna213000_Battle_Interupt(ai, goal)

local Att3000_Dist_min = 0.0					--3000番の適正間合い（最小）
local Att3000_Dist_max = 1.1					--3000番の適正間合い（最大）
local Att3001_Dist_min = 0.0					--3001番の適正間合い（最小）
local Att3001_Dist_max = 0.9					--3001番の適正間合い（最大）
local Att3002_Dist_min = 0.0					--3002番の適正間合い（最小）
local Att3002_Dist_max = 1.1					--3002番の適正間合い（最大）
local Att3004_Dist_min = 0.0					--3004番の適正間合い（最小）
local Att3004_Dist_max = 3.0					--3004番の適正間合い（最大）

--	local FRONT_CHECK__ANGLE_RANGE	= 10;		

	--監視領域に侵入したなら
	if ( ai:IsInterupt(INTERUPT_Inside_ObserveArea) ) then
		--監視領域０番なら
		if ( ai:IsInsideObserveArea(0) ) then
--			--自分が相手の方向を向いていたら
			--背中刺し攻撃
--			if (ai:IsInsideTarget(TARGET_ENE_0, AI_DIR_TYPE_F, FRONT_CHECK__ANGLE_RANGE)) then
				goal:ClearSubGoal();
				goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 5.0, TARGET_ENE_0, Att3004_Dist_max, TARGET_ENE_0, true, -1 );
				goal:AddSubGoal(GOAL_COMMON_ComboAttack, 5.0, 3004, TARGET_ENE_0, DIST_Middle, 0);
				
				return true;
--			end
		end
	end

	return false;
end





--[[*******************************************************************************************
	影女用こっそり背後攻撃戦闘
	説明：

	パラメータ0  なし
	パラメータ1  なし
	パラメータ2  なし
	パラメータ3　なし
*********************************************************************************************]]
REGISTER_GOAL(GOAL_kageonna213000_SneakAttack, "kageonna213000_SneakAttack");

-- Updateでなにもやっていないので、呼ばないようにする
REGISTER_GOAL_NO_UPDATE( GOAL_kageonna213000_SneakAttack, true);

--[[*****************************************************
	ゴール起動
*******************************************************]]
function kageonna213000_SneakAttack_Activate(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);		--敵ターゲットとの距離を取得
local fate = ai:GetRandam_Int(1,100)				--確率判定で使用する運命の数字
local fate2 = ai:GetRandam_Int(1,100)				--確率判定で使用する運命の数字　その２
local fate3 = ai:GetRandam_Int(1,100)				--確率判定で使用する運命の数字　その３
 
local Att3000_Dist_min = 0.0					--3000番の適正間合い（最小）
local Att3000_Dist_max = 1.1					--3000番の適正間合い（最大）
local Att3001_Dist_min = 0.0					--3001番の適正間合い（最小）
local Att3001_Dist_max = 0.9					--3001番の適正間合い（最大）
local Att3002_Dist_min = 0.0					--3002番の適正間合い（最小）
local Att3002_Dist_max = 1.1					--3002番の適正間合い（最大）
local Att3004_Dist_min = 0.0					--3004番の適正間合い（最小）
local Att3004_Dist_max = 3.0					--3004番の適正間合い（最大）

	--ジグザグ接近して背面刺し
	goal:AddSubGoal(GOAL_COMMON_TurnAround, 2.0, TARGET_ENE_0, AI_DIR_TYPE_B, 30, true, true, 9910);	
	goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 5.0, TARGET_ENE_0, 10.0, TARGET_ENE_0, true, 9910 );
	goal:AddSubGoal(GOAL_COMMON_TurnAround, 2.0, TARGET_ENE_0, AI_DIR_TYPE_B, 30, true, true, 9910);	
	goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 5.0, TARGET_ENE_0, 8.0, TARGET_ENE_0, true, 9910 );
	goal:AddSubGoal(GOAL_COMMON_TurnAround, 2.0, TARGET_ENE_0, AI_DIR_TYPE_B, 30, true, true, 9910);	
	goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 5.0, TARGET_ENE_0, 6.0, TARGET_ENE_0, true, 9910 );
	goal:AddSubGoal(GOAL_COMMON_TurnAround, 2.0, TARGET_ENE_0, AI_DIR_TYPE_B, 30, true, true, 9910);	
	goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 5.0, TARGET_ENE_0, 4.0, TARGET_ENE_0, true, 9910 );
	goal:AddSubGoal(GOAL_COMMON_TurnAround, 2.0, TARGET_ENE_0, AI_DIR_TYPE_B, 30, true, true, 9910);	
	goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 5.0, TARGET_ENE_0, 2.0, TARGET_ENE_0, true, -1 );
	goal:AddSubGoal(GOAL_kageonna213000_SA_Attack, 5.0, 3004, TARGET_ENE_0, DIST_Middle, 0);

end

--[[*****************************************************
	ゴール更新・終了。
*******************************************************]]
function kageonna213000_SneakAttack_Update(ai, goal) return GOAL_RESULT_Continue; end
function kageonna213000_SneakAttack_Terminate(ai, goal) end

--[[*****************************************************
	ゴール割り込み。
*******************************************************]]
function kageonna213000_SneakAttack_Interupt(ai, goal)
	return false;
end








--[[*******************************************************************************************
	影女用非戦闘
	説明：

	パラメータ0  なし
	パラメータ1  なし
	パラメータ2  なし
	パラメータ3　なし
*********************************************************************************************]]
REGISTER_GOAL(GOAL_kageonna213000_NonBattle, "kageonna213000_NonBattle");

-- Updateでなにもやっていないので、呼ばないようにする
REGISTER_GOAL_NO_UPDATE(GOAL_kageonna213000_NonBattle, true);

--[[*****************************************************
	ゴール起動
*******************************************************]]
function kageonna213000_NonBattle_Activate(ai, goal)

	local distToInitPos = ai:GetDist(POINT_INITIAL);

	if ( distToInitPos<2 ) then
		--初期位置近辺に居るので、居座る。
		goal:AddSubGoal(GOAL_COMMON_Guard, 10, 9910, TARGET_ENE_0, true);
	else
		--初期位置に移動。
		goal:AddSubGoal(GOAL_COMMON_MoveToSomewhere, 10, POINT_INITIAL, AI_DIR_TYPE_CENTER, 0.5, TARGET_SELF, 9910);
	end

	
	--非戦闘状態に。
	ai:SetNumber(3, 0);

end

--[[*****************************************************
	ゴール更新・終了。
*******************************************************]]
function kageonna213000_NonBattle_Update(ai, goal) return GOAL_RESULT_Continue; end
function kageonna213000_NonBattle_Terminate(ai, goal) end

--[[*****************************************************
	ゴール割り込み。
*******************************************************]]
function kageonna213000_NonBattle_Interupt(ai, goal)
	return false;
end



	



--[[*******************************************************************************************
	影女用こっそり戦闘時攻撃サブゴール
	説明：
		単に、こっそり攻撃ゴールの終端を攻撃のterminateが呼ばれたタイミングにしたいだけ。
*********************************************************************************************]]
REGISTER_GOAL(GOAL_kageonna213000_SA_Attack, "kageonna213000_SA_Attack");
REGISTER_GOAL_NO_UPDATE(GOAL_kageonna213000_SA_Attack, true);
REGISTER_GOAL_NO_INTERUPT(GOAL_kageonna213000_SA_Attack, true);

--[[*****************************************************
	ゴール起動
*******************************************************]]
function kageonna213000_SA_Attack_Activate(ai, goal)

	local life			= goal:GetLife();
	local ezStateNo		= goal:GetParam(0);
	local target		= goal:GetParam(1);
	local distType		= goal:GetParam(2);

	goal:AddSubGoal(GOAL_COMMON_ComboAttack, life, ezStateNo, target, distType);
end

--[[*****************************************************
	ゴール更新。
*******************************************************]]
function kageonna213000_SA_Attack_Update(ai, goal) return GOAL_RESULT_Continue; end

--[[*****************************************************
	ゴール終了。
*******************************************************]]
function kageonna213000_SA_Attack_Terminate(ai, goal) 
	--コッソリ行動終了。
	ai:SetNumber(3, 1);
end

--[[*****************************************************
	ゴール割り込みなし。
*******************************************************]]
function kageonna213000_SA_Attack_Interupt(ai, goal)
	return false;
end



	