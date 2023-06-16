-----------------------------------------------------------------------------------------------
--	FaranHONTAI500100専用戦闘
--	説明：
--
--	パラメータ0  なし
--	パラメータ1  なし
--	パラメータ2  なし
--	パラメータ3　なし
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_FaranHONTAI500100_Battle, "FaranHONTAI500100Battle");


-- Updateでなにもやっていないので、呼ばないようにする
REGISTER_GOAL_NO_UPDATE( GOAL_FaranHONTAI500100_Battle, 1 );



---------------------------------------------------------
--  ゴール起動
---------------------------------------------------------
function FaranHONTAI500100Battle_Activate(ai, goal)
-------------------------------------------------------------------------------

local targetDist = ai:GetDist(TARGET_ENE_0);		--敵ターゲットとの距離
local fate = ai:GetRandam_Int(1,100)				--確率判定で使用する運命の数字
local fate2 = ai:GetRandam_Int(1,100)				--確率判定で使用する運命の数字 その２
local jrGattaiCounts = ai:GetEventRequest(1);		--張り付いているチビの人数をイベントから取得

	--張り付いているチビが１５以下だったら初期位置あたりでウロウロ
--	if jrGattaiCounts <= 15 then
--		goal:AddSubGoal( GOAL_COMMON_MoveToSomewhere, 7.5, POINT_INITIAL, AI_DIR_TYPE_CENTER, 0.0, TARGET_NONE, true );
--		goal:AddSubGoal( GOAL_COMMON_MoveToSomewhere, 10.0, TARGET_ENE_0, AI_DIR_TYPE_CENTER, 15.0, TARGET_NONE, false )
--		goal:AddSubGoal( GOAL_COMMON_MoveToSomewhere, 7.5, TARGET_SELF, ai:GetRandam_Int(0, 3), ai:GetRandam_Float(5.0, 10.0), TARGET_NONE, true );
--		goal:AddSubGoal( GOAL_COMMON_MoveToSomewhere, 7.5, TARGET_SELF, ai:GetRandam_Int(0, 3), ai:GetRandam_Float(5.0, 10.0), TARGET_NONE, true );
				
	--初回用行動
	--タイマー０番が終了していれば、接近してから突進をする
--	if ai:IsFinishTimer(0) == true then
		--ここでタイマー０番をセット 9999秒
--		ai:SetTimer( 0, 9999.0 );
--		goal:AddSubGoal(GOAL_COMMON_Wait, 0.1, TARGET_ENE_0, 0, 0, 0 );
--		goal:AddSubGoal(GOAL_COMMON_MoveToSomewhere, 10.0, TARGET_ENE_0, AI_DIR_TYPE_CENTER, 15.0, TARGET_NONE, false )
--		goal:AddSubGoal(GOAL_COMMON_ContinueAttack, ai:GetRandam_Float(15.0, 25.0) , 3020, TARGET_ENE_0, 100, false);
		--ここでタイマー１番をセット 60秒
--		ai:SetTimer( 1, 60.0 );		
		
	--タイマー０番が終了していないときはこっちに分岐する
--	else
		--タイマー１番が終了していたら、突進する
--		if ai:IsFinishTimer(1) == true then
			--ここでタイマー１番をセット 60秒
--			ai:SetTimer( 1, 60.0 );
--			goal:AddSubGoal(GOAL_COMMON_ContinueAttack, ai:GetRandam_Float(15.0, 25.0) , 3020, TARGET_ENE_0, 100, false);
		--まだタイマー１番が終了してしていなかったら寄ってくる
--		else
--		end

		--15匹以上チビが張り付いていれば、近づいてくる
		if jrGattaiCounts >= 15 then
			if fate <= 90 then
				goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, 4.5, TARGET_ENE_0, true, -1 );
				goal:AddSubGoal( GOAL_COMMON_Wait, ai:GetRandam_Float(1.0, 4.0), TARGET_NONE, 0, 0, 0 );
			else
				goal:AddSubGoal( GOAL_COMMON_KeepDist, 10.0, TARGET_ENE_0, 6.5, 8.5, TARGET_ENE_0, true, -1 );
				goal:AddSubGoal( GOAL_COMMON_Wait, ai:GetRandam_Float(1.0, 4.0), TARGET_NONE, 0, 0, 0 );
			end
			
		--14匹以下なら、ちょっと間を空ける		
		else
			if fate <= 10 then
				goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, 4.5, TARGET_ENE_0, true, -1 );
				goal:AddSubGoal( GOAL_COMMON_Wait, ai:GetRandam_Float(1.0, 4.0), TARGET_NONE, 0, 0, 0 );
			else
				goal:AddSubGoal( GOAL_COMMON_KeepDist, 10.0, TARGET_ENE_0, 6.5, 8.5, TARGET_ENE_0, true, -1 );
				goal:AddSubGoal( GOAL_COMMON_Wait, ai:GetRandam_Float(1.0, 4.0), TARGET_NONE, 0, 0, 0 );
			end
		end	
--	end
end


---------------------------------------------------------
--  ゴール更新
---------------------------------------------------------
function FaranHONTAI500100Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  ゴール終了
---------------------------------------------------------
function FaranHONTAI500100Battle_Terminate(ai, goal)
end


---------------------------------------------------------
--  割り込み
--	割り込んだ場合にはtrueを返してください。
--	ここで割り込み用のサブゴールを追加してください。
--	割り込まなかった場合には、1つ上の層のゴール、またはロジック部分によって割り込みが処理されます。
---------------------------------------------------------
function FaranHONTAI500100Battle_Interupt(ai, goal)

return false;

end
