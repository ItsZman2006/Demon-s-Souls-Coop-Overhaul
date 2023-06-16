--[[*******************************************************************************************
	ガーゴイル剣
	説明：
	
	●ai:SetNumber()の使用状況。
		０：起動領域に入ったか？	入ってたら０以外。
		１：地上移行タイマ、設定済みか？　０以外で、設定済み。
		２：地上移行モードになったか？
		３：起動時地上移動モードになったか？
		
	●ai:AddObserveRegion()の使用状況。
		０：ガーゴイル起動領域
		１：
		２：
		３：
		
	●ai:SetTimer()の使用状況。
		０：地上へ移行タイマ。
		１：
		２：
		３：
		
*********************************************************************************************]]
REGISTER_LOGIC_FUNC(LOGIC_ID_Gagoiru305000, "Gagoiru305000_Logic", "Gagoiru305000_Interupt");

--[[********************************************************
	ロジック。
**********************************************************]]
function	Gagoiru305000_Logic(ai)

--[[■調整項目■]]
	--起動領域のイベントID。
	local BOOTUP_REGION	= -1;
	
	local idThinkParam = ai:GetNpcThinkParamID();
	if 		(idThinkParam==305099) then		BOOTUP_REGION	= 2260;		--	←配置毎にここを増やす。
	elseif	(idThinkParam==305098) then		BOOTUP_REGION	= 2261;
	elseif	(idThinkParam==305097) then		BOOTUP_REGION	= 2262;
	elseif	(idThinkParam==305096) then		BOOTUP_REGION	= 2263;
	elseif	(idThinkParam==305095) then		BOOTUP_REGION	= 2264;
	elseif	(idThinkParam==305094) then		BOOTUP_REGION	= 2265;
	else									BOOTUP_REGION	= -1;
	end
--[[■調整項目■]]


	--起動領域監視。
	ai:AddObserveRegion(0, TARGET_ENE_0, BOOTUP_REGION);

	--ゴール選択。
	--	起動領域内に入っていない場合は、何にもしない。⇒隣の石像と勘違いさせる。
	if ( 0==ai:GetNumber(0) ) then
		ai:AddTopGoal(GOAL_COMMON_Wait, -1, TARGET_NONE);
	else
	
		--地面に乗っていなかったら、まずは落下する。
		if ( not(ai:IsLanding()) and (0==ai:GetNumber(3))) then
			ai:AddTopGoal( GOAL_Gagoiru305000_LandingOnGround, 10);
			ai:SetNumber(3, 1);
		end
		
		--通常どおり。
		COMMON_EasySetup3(ai);
	end

end

--[[********************************************************
	割り込み。
**********************************************************]]
function	Gagoiru305000_Interupt(ai, goal)

	--領域割り込み。
	if ( ai:IsInterupt(INTERUPT_Inside_ObserveArea) ) then
		--起動用領域に入ったか？
		if ( ai:IsInsideObserveRegion (0) ) then
			ai:SetNumber(0, 1);
		end
	end

	--ダメージを食らったら、起動。
	if ( ai:IsInterupt(INTERUPT_Damaged) ) then
		ai:SetNumber(0, 1);
	end
	
end


