--[[*******************************************************************************************
	タコ男用の思考ロジック
	説明：
*********************************************************************************************]]
REGISTER_LOGIC_FUNC(LOGIC_ID_Tako403000, "Tako403000_Logic", "Tako403000_Interupt");

--[[************************************************************
	タコ男用の思考ロジック
	この中で現在の状況を判別し、使用するトップゴールをひとつ決定します。
**************************************************************]]
function	Tako403000_Logic(ai)


	--非戦闘時：走る。
	--警戒時：エクセル設定。
	--発見時：立ち止まる。

	COMMON_EasySetup3_SetRunNonBattle(ai, true);

end

--[[************************************************************
	タコ男用の割り込みロジック
	現在の状態でわりこめるのであればtrueを、
	そのまま無視するのであればfalseを返してください。
	※ 4/24不要と言われたが、とりあえず現状維持。
**************************************************************]]
function	Tako403000_Interupt(ai, goal)
		
	if ai:IsInterupt( INTERUPT_ForgetTarget) then
		--見失ったのでキョロキョロ。
		goal:ClearSubGoal();
		goal:AddSubGoal( GOAL_COMMON_Attack, 5, 3301, TARGET_NONE, DIST_None);
		Tako403000_Logic(ai);
		return true;
	end

	return false;
end



