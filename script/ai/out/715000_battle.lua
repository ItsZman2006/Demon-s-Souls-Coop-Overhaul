-----------------------------------------------------------------------------------------------
--	ヒロイン戦闘
--	説明：
--
--	パラメータ0  なし
--	パラメータ1  なし
--	パラメータ2  なし
--	パラメータ3　なし
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_Heroine_715000_Battle, "heroine_715000Battle");

--local c801000_NormalR_Dist = 2.5			--右手攻撃の適正間合い
--local c801000_farDist = 15.0				--遠いと判断する距離
--local c801000_nearDist = 4.0				--近いと判断する距離

-- Updateでなにもやっていないので、呼ばないようにする
REGISTER_GOAL_NO_UPDATE( GOAL_Heroine_715000_Battle, 1 );


---------------------------------------------------------
--  ゴール起動
---------------------------------------------------------
function heroine_715000Battle_Activate(ai, goal)
-------------------------------------------------------------------------------

local playerDist = ai:GetDist(TARGET_LOCALPLAYER);		--ローカルプレイヤーとの距離を取得
local targetDist = ai:GetDist(TARGET_ENE_0);			--敵ターゲットとの距離を取得
local fate = ai:GetRandam_Int(1,100)		--確率判定で使用する運命の数字
local fate2 = ai:GetRandam_Int(1,100)		--確率判定で使用する運命の数字　その２

local NormalR_Dist = 2.5					--右手攻撃の適正間合い
local eventNo = ai:GetEventRequest();		--イベントリクエスト取得　スロット0

	--イベントリクエスト（スロット0に10番）が来ていたら
	if eventNo == 10 then
		--プレイヤーが遠かったら、プレイヤーに近づく
		if playerDist >= 2.5 then
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 5.0, TARGET_LOCALPLAYER, 2.0, TARGET_SELF, true, -1 );
			
		else
			goal:AddSubGoal( GOAL_COMMON_Wait, 5.0,0,0,0,0)
		end
		
	--イベントリクエストが来ていなかったら、ゆっくり敵に向かう
	else
		goal:AddSubGoal( GOAL_COMMON_Wait, 5.0,0,0,0,0)
	end
end


---------------------------------------------------------
--  ゴール更新
---------------------------------------------------------
function heroine_715000Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  ゴール終了
---------------------------------------------------------
function heroine_715000Battle_Terminate(ai, goal)
end



---------------------------------------------------------
--  割り込み
--	割り込んだ場合にはtrueを返してください。
--	ここで割り込み用のサブゴールを追加してください。
--	割り込まなかった場合には、1つ上の層のゴール、またはロジック部分によって割り込みが処理されます。
---------------------------------------------------------
function heroine_715000Battle_Interupt(ai, goal)

return false;
end
