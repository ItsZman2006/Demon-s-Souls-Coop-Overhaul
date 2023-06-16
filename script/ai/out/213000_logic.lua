--[[*******************************************************************************************
	‰e—ƒƒWƒbƒNB
	à–¾F
	
	œai:SetNumber()‚Ìg—pó‹µB
		‚OF
		‚PF
		‚QF‹N“®OK‚©H					‚OˆÈŠO‚Å‹N“®B
		‚RFƒRƒbƒ\ƒŠˆÚ“®I—¹‚µ‚½‚©H@	‚OˆÈŠO‚ÅI—¹‚Æ‚·‚éB
		
	œai:AddObserveRegion()‚Ìg—pó‹µB
		‚OF
		‚PF
		‚QF
		‚RFƒ^[ƒQƒbƒg‚ª“ü‚Á‚½‚ç‹N“®‚·‚é—ÌˆæB
*********************************************************************************************]]
REGISTER_LOGIC_FUNC(LOGIC_ID_KageOnna213000, "KageOnna213000_Logic", "KageOnna213000_Interupt");

--[[*********************************************************
	ƒƒWƒbƒNB
***********************************************************]]
function KageOnna213000_Logic(ai)

	local BOOTUP_REGION	= -1;
	local param_id		= ai:GetNpcThinkParamID();
	if 		(param_id==213000) then		BOOTUP_REGION = 2460;
	elseif	(param_id==213001) then		BOOTUP_REGION = 2461;
	end

	--ŠÄ‹—Ìˆæ’Ç‰ÁB
	ai:AddObserveRegion( 3, TARGET_ENE_0, BOOTUP_REGION);
	--ƒK[ƒhŠJnB
	ai:StartGuard(9910);

	--Œ©¸‚Á‚Ä‚¢‚½‚çAí“¬ó‘Ô‰ğœB
	if ( not(ai:IsSearchTarget(TARGET_ENE_0)) ) then
		ai:SetNumber(2, 0);
	end
	
	---------------------------------------------
	if ( not(0==ai:GetNumber(2)) ) then
	
		--í“¬ó‘ÔB
		--	‚Ü‚¸‚ÍAƒRƒbƒ\ƒŠUŒ‚B
		if (0==ai:GetNumber(3)) then
			--ƒRƒbƒ\ƒŠB
			ai:AddTopGoal(GOAL_kageonna213000_SneakAttack, -1);
		else
			--’Êíí“¬‚ÍAŒp‘±ƒK[ƒh‚µ‚È‚¢B
			ai:EndGuard();
		
			--’Êíí“¬B
			ai:AddTopGoal(GOAL_kageonna213000_Battle, -1);
		end
	
	else
	
		--”ñí“¬s“®B
		ai:AddTopGoal(GOAL_kageonna213000_NonBattle, -1);
	
		--‹N“®ƒtƒ‰ƒO‚ğ‰º‚°‚éB
		ai:SetNumber(2, 0);
	end
end

--[[*********************************************************
	Š„‚è‚İB
***********************************************************]]
function KageOnna213000_Interupt(ai, goal)

	--‹N“®—Ìˆæ‚É·‚µŠ|‚©‚Á‚½‚çA‹N“®B
	if ( ai:IsInterupt(INTERUPT_Inside_ObserveArea) ) then
		if ( ai:IsInsideObserveRegion(3) ) then
			
			--‹N“®ƒtƒ‰ƒO‚ª—§‚Á‚Ä‚¢‚È‚©‚Á‚½‚ç.
			if ( 0==ai:GetNumber(2) ) then
				--‹N“®ƒtƒ‰ƒO‚ğ—§‚Ä‚éB
				ai:SetNumber(2, 1);
				--Œ»İ‚ÌƒS[ƒ‹‚ğÁ‚µ‚ÄA’¼‚®ƒŠƒvƒ‰ƒ“ƒjƒ“ƒOB
				goal:ClearSubGoal();
			end
			
		end
	end

	--ƒ^[ƒQƒbƒg‚ğ–Y‚ê‚½‚çA‹N“®ƒtƒ‰ƒO‚ğ‰º‚°‚éB
	if ( ai:IsInterupt(INTERUPT_ForgetTarget) ) then
		ai:SetNumber(2, 0);
	end
	
end


