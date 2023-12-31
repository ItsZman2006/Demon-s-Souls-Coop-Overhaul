--[[*******************************************************************************************
	影女ロジック。
	説明：
	
	●ai:SetNumber()の使用状況。
		０：
		１：
		２：起動OKか？�					０以外で起動。
		３：コッソリ移動終了したか？　	０以外で終了とする。
		
	●ai:AddObserveRegion()の使用状況。
		０：
		１：
		２：
		３：ターゲットが入ったら起動する領域。
*********************************************************************************************]]
REGISTER_LOGIC_FUNC(LOGIC_ID_KageOnna213000, "KageOnna213000_Logic", "KageOnna213000_Interupt");

--[[*********************************************************
	ロジック。
***********************************************************]]
function KageOnna213000_Logic(ai)

	local BOOTUP_REGION	= -1;
	local param_id		= ai:GetNpcThinkParamID();
	if 		(param_id==213000) then		BOOTUP_REGION = 2460;
	elseif	(param_id==213001) then		BOOTUP_REGION = 2461;
	end

	--監視領域追加。
	ai:AddObserveRegion( 3, TARGET_ENE_0, BOOTUP_REGION);
	--ガード開始。
	ai:StartGuard(9910);

	--見失っていたら、戦闘状態解除。
	if ( not(ai:IsSearchTarget(TARGET_ENE_0)) ) then
		ai:SetNumber(2, 0);
	end
	
	---------------------------------------------
	if ( not(0==ai:GetNumber(2)) ) then
	
		--戦闘状態。
		--	まずは、コッソリ攻撃。
		if (0==ai:GetNumber(3)) then
			--コッソリ。
			ai:AddTopGoal(GOAL_kageonna213000_SneakAttack, -1);
		else
			--通常戦闘時は、継続ガードしない。
			ai:EndGuard();
		
			--通常戦闘。
			ai:AddTopGoal(GOAL_kageonna213000_Battle, -1);
		end
	
	else
	
		--非戦闘行動。
		ai:AddTopGoal(GOAL_kageonna213000_NonBattle, -1);
	
		--起動フラグを下げる。
		ai:SetNumber(2, 0);
	end
end

--[[*********************************************************
	割り込み。
***********************************************************]]
function KageOnna213000_Interupt(ai, goal)

	--起動領域に差し掛かったら、起動。
	if ( ai:IsInterupt(INTERUPT_Inside_ObserveArea) ) then
		if ( ai:IsInsideObserveRegion(3) ) then
			
			--起動フラグが立っていなかったら.
			if ( 0==ai:GetNumber(2) ) then
				--起動フラグを立てる。
				ai:SetNumber(2, 1);
				--現在のゴールを消して、直ぐリプランニング。
				goal:ClearSubGoal();
			end
			
		end
	end

	--ターゲットを忘れたら、起動フラグを下げる。
	if ( ai:IsInterupt(INTERUPT_ForgetTarget) ) then
		ai:SetNumber(2, 0);
	end
	
end


