--[[*******************************************************************************************
	虜囚用の思考ロジック
	説明：
	
	変更履歴
	　・
*********************************************************************************************]]
REGISTER_LOGIC_FUNC(LOGIC_ID_Ryosyu207000, "Ryosyu207000_Logic", "Ryosyu207000_Interupt");


--[[*******************************************************************************************
	虜囚用の思考ロジック
	この中で現在の状況を判別し、使用するトップゴールをひとつ決定します。
*********************************************************************************************]]
function	Ryosyu207000_Logic(ai)

	UROKO_EasySetup( ai, GOAL_Ryosyu_COMMON_Wait);
end

--[[*******************************************************************************************
	虜囚用の割り込みロジック
	現在の状態でわりこめるのであればtrueを、
	そのまま無視するのであればfalseを返してください。
*********************************************************************************************]]
function	Ryosyu207000_Interupt(ai, goal)
end


