--[[*******************************************************************************************
	結晶トカゲ用の思考ロジック
	説明：
		
	修正履歴：
		・hasem 08/7/23
		イベントリクエストが０の時は、どんなにリプランニングされようが目標まで、ポイント移動。
		目標位置まで移動できたら、イベントにリクエストを-1(０以外)にしてもらい、通常動作。
*********************************************************************************************]]
REGISTER_LOGIC_FUNC(LOGIC_ID_tokage311000, "tokage311000_Logic", "tokage311000_Interupt");




--[[************************************************************
	影人用の思考ロジック
	この中で現在の状況を判別し、使用するトップゴールをひとつ決定します。
**************************************************************]]
function	tokage311000_Logic(ai)
	
	if ( 0==ai:GetEventRequest() ) then
		--目標の領域まで移動する。
		ai:AddTopGoal( GOAL_COMMON_MoveToSomewhere, -1, POINT_MOVE_POINT, AI_DIR_TYPE_CENTER, 3, TARGET_SELF, false);
	else
		--デフォルトの動作。
		COMMON_EasySetup3(ai);
	end
	
end

--[[************************************************************
	影人用の割り込みロジック
	現在の状態でわりこめるのであればtrueを、
	そのまま無視するのであればfalseを返してください。
**************************************************************]]
function	tokage311000_Interupt(ai, goal)
	--何もしない。
	return false;
end


