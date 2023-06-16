-----------------------------------------------------------------------------------------------
--	白ガイコツ＿弓　戦闘
--	説明：
--
--	パラメータ0  なし
--	パラメータ1  なし
--	パラメータ2  なし
--	パラメータ3　なし
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_honeBOU402101_Battle, "honeBOU402101Battle");


-- Updateでなにもやっていないので、呼ばないようにする
REGISTER_GOAL_NO_UPDATE( GOAL_honeBOU402101_Battle, 1 );


---------------------------------------------------------
--  ゴール起動
---------------------------------------------------------
function honeBOU402101Battle_Activate(ai, goal)
-------------------------------------------------------------------------------

local targetDist = ai:GetDist(TARGET_ENE_0);		--敵ターゲットとの距離を取得
local fate = ai:GetRandam_Int(1,100)				--確率判定で使用する運命の数字
local fate2 = ai:GetRandam_Int(1,100)				--確率判定で使用する運命の数字　その２
local fate3 = ai:GetRandam_Int(1,100)				--確率判定で使用する運命の数字　その３

local myThinkId = ai:GetNpcThinkParamID()		--思考IDを取得
	
	--近ければ、撃ってから逃げる
	if targetDist <= 4.0 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 5.0, 3000, TARGET_ENE_0, DIST_None, 0);
		if fate <= 35 then
			goal:AddSubGoal(GOAL_COMMON_SpinStep, 5.0, ai:GetRandam_Int(702,703), TARGET_NONE, 0, 0);
		end
		goal:AddSubGoal(GOAL_COMMON_Wait, ai:GetRandam_Float (1.0,2.0) ,0,0,0,0)
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 5.0, TARGET_ENE_0, 10.0, TARGET_SELF, false, -1 );
		
	--やや近ければ、撃ってから少し後退する
	elseif targetDist <= 8.0 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 5.0, 3000, TARGET_ENE_0, DIST_None, 0);
		if fate <= 20 then
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 5.0, 3000, TARGET_ENE_0, DIST_None, 0);
		end
		
		if fate2 <= 75 and myThinkId == 402101 then
			goal:AddSubGoal(GOAL_COMMON_Wait, ai:GetRandam_Float (2.0,4.0) ,0,0,0,0)
			goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 2.0, TARGET_ENE_0, 12.0, TARGET_ENE_0, true, -1 );
		else
			goal:AddSubGoal(GOAL_COMMON_Wait, ai:GetRandam_Float (2.0,4.0) ,0,0,0,0)
		end
		
	--適度な距離ならば、撃つ
	else
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 5.0, 3000, TARGET_ENE_0, DIST_None, 0);
		if fate <= 20 then
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 5.0, 3000, TARGET_ENE_0, DIST_None, 0);
		end
		
		goal:AddSubGoal(GOAL_COMMON_Wait, ai:GetRandam_Float (3.0,6.0) ,0,0,0,0)
		
	end
	
end
	



---------------------------------------------------------
--  ゴール更新
---------------------------------------------------------
function honeBOU402101Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  ゴール終了
---------------------------------------------------------
function honeBOU402101Battle_Terminate(ai, goal)
end


---------------------------------------------------------
--  割り込み
--	割り込んだ場合にはtrueを返してください。
--	ここで割り込み用のサブゴールを追加してください。
--	割り込まなかった場合には、1つ上の層のゴール、またはロジック部分によって割り込みが処理されます。
---------------------------------------------------------
function honeBOU402101Battle_Interupt(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);			--敵ターゲットとの距離を取得

local fate = ai:GetRandam_Int(1,100)					--確率判定用
local fate2 = ai:GetRandam_Int(1,100)					--確率判定用

	--コンボ逃れ　■共通関数
local combRunDist = 1.5				--コンボ逃れする距離
local combRunPer = 30				--コンボ逃れする確率
	if Damaged_Act(ai, goal, combRunDist, combRunPer ) then
		goal:ClearSubGoal();
		
		--左右にステップ
		if fate <= 50 then
			goal:AddSubGoal( GOAL_COMMON_Step, 10.0, 702, 0, 0, 0);
		else
			goal:AddSubGoal( GOAL_COMMON_Step, 10.0, 703, 0, 0, 0);
		end
		return true;
	end	


	return false;
end
