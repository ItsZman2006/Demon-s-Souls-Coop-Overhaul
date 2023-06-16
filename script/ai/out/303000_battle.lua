--[[*******************************************************************************************
	【鷹】用戦闘
	説明：

	●主な変更履歴
		鷹の攻撃が不要になったので、攻撃周りを削除。 08/8/3 hasem
	
	パラメータ0  なし
	パラメータ1  なし
	パラメータ2  なし
	パラメータ3　なし
*********************************************************************************************]]
REGISTER_GOAL(GOAL_Taka303000_Battle, "taka303000Battle");


-- Updateでなにもやっていないので、呼ばないようにする
REGISTER_GOAL_NO_UPDATE( GOAL_Taka303000_Battle, true);
REGISTER_GOAL_NO_INTERUPT( GOAL_Taka303000_Battle, true);


--[[*****************************************************
	ゴール起動
*******************************************************]]
function taka303000Battle_Activate(ai, goal)

	local fate 			= ai:GetRandam_Int(1,100)		--確率判定で使用する運命の数字
	local fate2 		= ai:GetRandam_Int(1,100)		--確率判定で使用する運命の数字　その２
	local fate3 		= ai:GetRandam_Int(1,100)		--確率判定で使用する運命の数字　その３
	
	--次のポイントに移動
	taka303000Battle_MoveToNext(goal);

	--10％　次のポイントに移動
	if (fate  <= 10) then	taka303000Battle_MoveToNext(goal);	end
	if (fate2 <= 10) then	taka303000Battle_MoveToNext(goal);	end
	if (fate3 <= 10) then	taka303000Battle_MoveToNext(goal);	end

end

---------------------------------------------------------
--  次の位置。
---------------------------------------------------------
function taka303000Battle_MoveToNext(goal)
	goal:AddSubGoal(GOAL_COMMON_MoveToSomewhere, 20.0, POINT_MOVE_POINT, AI_DIR_TYPE_CENTER, 7.0, TARGET_SELF, true);
end

--[[*****************************************************
	ゴール更新・終了
*******************************************************]]
function taka303000Battle_Update(ai, goal) return GOAL_RESULT_Continue; end
function taka303000Battle_Terminate(ai, goal) end
function taka303000Battle_Interupt(ai, goal) return false; end

