--[[****************************************************************************************
	汎用の思考ロジック
	説明：
*******************************************************************************************]]
REGISTER_LOGIC_FUNC(LOGIC_ID_Dorei200000, "Dorei200000_Logic", "Dorei200000_Interupt");

--[[*****************************************************
	奴隷兵士用
*****************************************************]]
function	Dorei200000_Logic(ai)

	local eventNo = ai:GetEventRequest();					--イベントからのリクエスト番号を取得

	if (eventNo == AI_EVENT_DOREI_IKAKU) then
	
		local fate = ai:GetRandam_Int(1,100)			--確率判定で使用する運命の数字
		
		--レンドル王子（王城１）の時のロジック。
		--80％ウロウロ
		--100％威嚇
		if fate <= 80 then
			ai:AddTopGoal(GOAL_COMMON_SidewayMove, 5.0, TARGET_EVENT, ai:GetRandam_Int(0,1), ai:GetRandam_Int(15,30), true, true ,-1 );
		end
		
		ai:AddTopGoal(GOAL_COMMON_NonspinningAttack, 10.0, 7000, TARGET_EVENT, DIST_None, 0);
	else
		--通常動作
		COMMON_EasySetup3(ai);
	end
end

--[[*****************************************************
	割り込み。
*****************************************************]]
function	Dorei200000_Interupt(ai, goal)
end


