-----------------------------------------------------------------------------------------------
--	一般兵士（ボウガン）　戦闘
--	説明：
--
--	パラメータ0  なし
--	パラメータ1  なし
--	パラメータ2  なし
--	パラメータ3　なし
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_IppanBOU201003_Battle, "ippanBOU201003Battle");


-- Updateでなにもやっていないので、呼ばないようにする
REGISTER_GOAL_NO_UPDATE( GOAL_IppanBOU201003_Battle, 1 );


---------------------------------------------------------
--  ゴール起動
---------------------------------------------------------
function ippanBOU201003Battle_Activate(ai, goal)
-------------------------------------------------------------------------------

local targetDist = ai:GetDist(TARGET_ENE_0);				--敵ターゲットとの距離を取得
local hprate = ai:GetHpRate( TARGET_SELF )					--自分のHP割合を取得

local fate = ai:GetRandam_Int(1,100)						--確率判定で使用する運命の数字
local fate2 = ai:GetRandam_Int(1,100)						--確率判定で使用する運命の数字　その２
local fate3 = ai:GetRandam_Int(1,100)						--確率判定で使用する運命の数字　その３
local fate4 = ai:GetRandam_Int(1,100)						--確率判定で使用する運命の数字　その４

local myThinkId = ai:GetNpcThinkParamID()		--思考IDを取得
local myBlockId = ai:GetMyBlockID();			--自分のいるブロック

	--最初だけちょっと待つ
	if ai:IsFinishTimer(0) == true then
		local firstTime = ai:GetRandam_Float(0.0,2.0)					--最初の動き出しまでの時間
		goal:AddSubGoal(GOAL_COMMON_Wait, firstTime, TARGET_ENE_0, 0, 0, 0 );
		ai:SetTimer( 0, 9999.0 );
	end
	
	--敵ターゲットが３ｍ以内のとき、撃ってから一目散に逃げる
	if targetDist <= 3.0 then
		if myThinkId == 201012 then
			goal:AddSubGoal(GOAL_COMMON_Attack, 5.0, 3000, TARGET_ENE_0, DIST_None, 0);
		else
			if fate <= 60 then
				goal:AddSubGoal(GOAL_COMMON_Attack, 5.0, 3000, TARGET_ENE_0, DIST_None, 0);
			else
				goal:AddSubGoal(GOAL_COMMON_Attack, 5.0, 3001, TARGET_ENE_0, DIST_None, 0);
			end
		end
		
		if myThinkId == 602 or myThinkId == 200011 or myThinkId == 201003 then		
			goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 5.0, TARGET_ENE_0, 10.0, TARGET_SELF, false, -1 );
		else
			goal:AddSubGoal(GOAL_COMMON_Wait, ai:GetRandam_Float (1.0,2.0) ,0,0,0,0)		
			
		end
		
	--敵ターゲットが１２ｍ以内のとき、撃ってから少し下がる
	elseif targetDist <= 12.0 then
		if myThinkId == 201012 then
			goal:AddSubGoal(GOAL_COMMON_Attack, 5.0, 3000, TARGET_ENE_0, DIST_None, 0);
		else
			if fate <= 60 then
				goal:AddSubGoal(GOAL_COMMON_Attack, 5.0, 3000, TARGET_ENE_0, DIST_None, 0);
			else
				goal:AddSubGoal(GOAL_COMMON_Attack, 5.0, 3001, TARGET_ENE_0, DIST_None, 0);
			end
		end
		
		if myThinkId == 602 or myThinkId == 200011 or myThinkId == 201003 then
			goal:AddSubGoal(GOAL_COMMON_Wait, ai:GetRandam_Float (2.0,4.0) ,0,0,0,0)		
			goal:AddSubGoal( GOAL_COMMON_LeaveTarget, 2.0, TARGET_ENE_0, 20.0, TARGET_ENE_0, true, -1 );
		else
			goal:AddSubGoal(GOAL_COMMON_Wait, ai:GetRandam_Float (2.0,4.0) ,0,0,0,0)		
			
		end
		
	--もっと離れているとき
	else
		if myThinkId == 201012 then
			goal:AddSubGoal(GOAL_COMMON_Attack, 5.0, 3000, TARGET_ENE_0, DIST_None, 0);
			if fate2 <= 20 then
				goal:AddSubGoal(GOAL_COMMON_Attack, 5.0, 3000, TARGET_ENE_0, DIST_None, 0);
			end
			
		else
			if fate <= 60 then
				goal:AddSubGoal(GOAL_COMMON_Attack, 5.0, 3000, TARGET_ENE_0, DIST_None, 0);
				if fate2 <= 20 then
					goal:AddSubGoal(GOAL_COMMON_Attack, 5.0, 3000, TARGET_ENE_0, DIST_None, 0);
				end
				
			else
				goal:AddSubGoal(GOAL_COMMON_Attack, 5.0, 3001, TARGET_ENE_0, DIST_None, 0);
			end
		end
		goal:AddSubGoal(GOAL_COMMON_Wait, ai:GetRandam_Float (3.0,6.0) ,0,0,0,0)
		
	end

	--ＨＰが減っていたら、一定確率で回復薬を使う
	if (hprate <= 0.4) and (fate <= 50) and (myBlockId == 1 or myBlockId == 2 or myBlockId == 3) then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 6200, TARGET_ENE_0, DIST_Far, 0);
	end	
	
end
	



---------------------------------------------------------
--  ゴール更新
---------------------------------------------------------
function ippanBOU201003Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  ゴール終了
---------------------------------------------------------
function ippanBOU201003Battle_Terminate(ai, goal)
end


---------------------------------------------------------
--  割り込み
--	割り込んだ場合にはtrueを返してください。
--	ここで割り込み用のサブゴールを追加してください。
--	割り込まなかった場合には、1つ上の層のゴール、またはロジック部分によって割り込みが処理されます。
---------------------------------------------------------
function ippanBOU201003Battle_Interupt(ai, goal)

	return false;
end
