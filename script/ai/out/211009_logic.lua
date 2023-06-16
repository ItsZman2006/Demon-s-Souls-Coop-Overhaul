--[[*******************************************************************************************
	岩投げウロコ鉱夫の思考ロジック
	説明：
	
	ai:SetNumber()の用途。
		０：
		１：
		２：一回目の投擲かどうか。０なら、１回目の投擲。
		３：援護のためのリプランニングかどうか。
	
*********************************************************************************************]]
REGISTER_LOGIC_FUNC(LOGIC_ID_uroko211009, "uroko211009_Logic", "uroko211009_Interupt");

-----------------------------------------------------------------------------------------------
--	ウロコ鉱夫用の思考ロジック
--	この中で現在の状況を判別し、使用するトップゴールをひとつ決定します。
-----------------------------------------------------------------------------------------------
function	uroko211009_Logic(ai)

	--
--~ 	UROKO_EasySetup2( ai, GOAL_uroko_COMMON_Wait, function () uroko211009_AddCautionAndFindGoal(ai) end);
	UROKO_EasySetup2( ai, GOAL_COMMON_Wait, function () uroko211009_AddCautionAndFindGoal(ai) end);
	
end


-----------------------------------------------------------------------------------------------
--	ウロコ鉱夫用の割り込みロジック
--	現在の状態でわりこめるのであればtrueを、
--	そのまま無視するのであればfalseを返してください。
-----------------------------------------------------------------------------------------------
function	uroko211009_Interupt(ai, goal)
end

--[[********************************************************************************
	警戒・発見時のゴール設定関数。
**********************************************************************************]]
function uroko211009_AddCautionAndFindGoal( ai)
	
--[[■企画さん調整項目■]]

	local CheckRegionID = -1;--このイベントIDの領域に入っていたら、岩投げ。
	local idParam = ai:GetNpcThinkParamID();
	if 		(idParam==211009) then	CheckRegionID = 2160;	--スタート直後その１
	elseif 	(idParam==211010) then	CheckRegionID = 2161;	--道中その１
	elseif 	(idParam==211011) then	CheckRegionID = 2160;	--スタート直後その２
	elseif 	(idParam==211012) then	CheckRegionID = 2161;	--道中その２
	end

	--スタート直後の岩投げディレイ。
	local start_partner_delay	= 1;
	local eventNo = ai:GetEventRequest();	--イベントからのリクエスト番号を取得

	
--[[■企画さん調整項目■]]

	if ( ai:IsInsideTargetRegion( TARGET_ENE_0, CheckRegionID) ) then
		
		--スタート直後のディレイを入れる。
		if ( (idParam==211011) and (0==ai:GetNumber(2))) then
			ai:AddTopGoal( GOAL_COMMON_Wait, start_partner_delay, TARGET_NONE);
			ai:SetNumber(0, 2);
		end

		if eventNo == -1 then
			ai:AddTopGoal( GOAL_uroko_ThrowRock, 100);
		else
			ai:AddTopGoal( GOAL_COMMON_Wait, start_partner_delay, TARGET_NONE);
		end
	
	else
		-- デフォルトの警戒・発見。
		--ある程度レスポンスを上げるため、待機ゴールを２秒で終わるように。
		_COMMON_AddCautionAndFindGoal(ai, 2);
	end
end






