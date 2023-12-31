--[[*******************************************************************************************
	パッチ（坑道）
	説明：

	パラメータ0  なし
	パラメータ1  なし
	パラメータ2  なし
	パラメータ3　なし
*********************************************************************************************]]
REGISTER_LOGIC_FUNC(LOGIC_ID_Patch809000, "Patch809000_Logic", "Patch809000_Interupt");

--[[*******************************************************
	ロジック。
*********************************************************]]
function Patch809000_Logic(ai)

	--イベントリクエスト０番が、デフォルトで無い場合、
	--宝箱の位置まで移動。
	if ( -1==ai:GetEventRequest()) then
	
		--デフォルト動作。
		COMMON_EasySetup3(ai);
		
	else
		
		--宝箱の位置まで移動。
		ai:AddTopGoal(GOAL_pachi809000_MoveToTreasure, -1);
	
	end
	
end

--[[*******************************************************
	割り込み。
*********************************************************]]
function Patch809000_Interupt(ai, goal)
end


