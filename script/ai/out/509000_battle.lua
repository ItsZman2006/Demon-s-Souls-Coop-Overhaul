-----------------------------------------------------------------------------------------------
--	Hiru509000ê—pí“¬
--	à–¾FFX‚®‚¿‚á‚®‚¿‚á‚¾‚¯‚ÇA‚Æ‚è‚ ‚¦‚¸UŒ‚‘Î‰‚Í‚µ‚Ä‚¨‚­
--@@@@‰“‹——£UŒ‚‚Ì‘Î‰‚Æ‚©
--
--	ƒpƒ‰ƒ[ƒ^0  ‚È‚µ
--	ƒpƒ‰ƒ[ƒ^1  ‚È‚µ
--	ƒpƒ‰ƒ[ƒ^2  ‚È‚µ
--	ƒpƒ‰ƒ[ƒ^3@‚È‚µ
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_Hiru509000_Battle, "Hiru509000Battle");


-- Update‚Å‚È‚É‚à‚â‚Á‚Ä‚¢‚È‚¢‚Ì‚ÅAŒÄ‚Î‚È‚¢‚æ‚¤‚É‚·‚é
REGISTER_GOAL_NO_UPDATE( GOAL_Hiru509000_Battle, 1 );


---------------------------------------------------------
--  ƒS[ƒ‹‹N“®
---------------------------------------------------------
function Hiru509000Battle_Activate(ai, goal)
-------------------------------------------------------------------------------
local targetDist = ai:GetDist(TARGET_ENE_0);			--“Gƒ^[ƒQƒbƒg‚Æ‚Ì‹——£
local fate = ai:GetRandam_Int(1,100)					--Šm—¦”»’è‚Åg—p‚·‚é‰^–½‚Ì”š
local fate2 = ai:GetRandam_Int(1,100)					--Šm—¦”»’è‚Åg—p‚·‚é‰^–½‚Ì”š@‚»‚Ì‚Q
local fate3 = ai:GetRandam_Int(1,100)					--Šm—¦”»’è‚Åg—p‚·‚é‰^–½‚Ì”š@‚»‚Ì‚R
local sekkin = ai:GetRandam_Float(0.75, 1.5)			--Ú‹ß‚·‚é‹——£
local maai = ai:GetRandam_Float(0.75, 1.5)				--ŠÔ‡‚¢’²®‚·‚é‹——£
local hprate = ai:GetHpRate( TARGET_SELF )			--©•ª‚ÌHP‚Ìc—Ê‚ğæ“¾

local farDist = 20.0		--‰“‚¢‚Æ”»’f‚·‚é‹——£
local nearDist = 14.0		--‹ß‚¢‚Æ”»’f‚·‚é‹——£
local maaiDist = 5.0		--UŒ‚‚Ì‚½‚ß‚É‹ß‚Ã‚­‹——£@š”Ä—p‰»‚Ìˆ×AUŒ‚‚²‚Æ‚É•ª‚¯‚¸š

	-- Å‰‚É‚¿‚å‚Á‚Æ‚¾‚¯‘Ò‚Â
	if ai:IsFinishTimer(0) == true then
		local firstTime = ai:GetRandam_Float(0.0, 3.0)			--Å‰‚Ì“®‚«o‚µ‚Ü‚Å‚ÌŠÔ
		goal:AddSubGoal(GOAL_COMMON_Wait, firstTime, TARGET_ENE_0, 0, 0, 0 );
		ai:SetTimer( 0, 9999.0 );
	end

--[[“Á’è—Ìˆæ‚É‹‚é‚Æ‚«‚É‹­§“I‚Éƒqƒ‹•œŠˆ‚ğ‚·‚é]]

local		Wait_time	=	2.0				--‰ñ•œ‚Ì‘Ò‚¿ŠÔ

	if	ai:IsInsideTargetRegion( TARGET_ENE_0, 2020 ) 
		or ai:IsInsideTargetRegion( TARGET_ENE_0, 2021 ) 
		or ai:IsInsideTargetRegion( TARGET_ENE_0, 2022 )
		or ai:IsInsideTargetRegion( TARGET_ENE_0, 2023 ) then
		goal:AddSubGoal( GOAL_COMMON_Wait, Wait_time, TARGET_ENE_0);
		goal:AddSubGoal(GOAL_COMMON_Attack, 10.0, 9010, TARGET_ENE_0, DIST_None, 0);
	else

	--‹ß‚­‚È‚¢‚È‚ç
	if targetDist >= nearDist then
--~ 		--100% ‘Ò‹@
--~ 		goal:AddSubGoal( GOAL_COMMON_Wait, 0.1, TARGET_ENE_0);
		
		if hprate < 0.95 then
			goal:AddSubGoal(GOAL_COMMON_Attack, 10.0, 9010, TARGET_ENE_0, DIST_None, 0);
			
		else
			if fate2 < 90 then
				goal:AddSubGoal( GOAL_COMMON_Wait, 2.0, TARGET_ENE_0);
			else
				goal:AddSubGoal(GOAL_COMMON_Attack, 10.0, 3020, TARGET_ENE_0, DIST_None, 0);
				
			end
		end
		
--~ 		--75“@•à‚«Ú‹ß¨10“@‰ñ‚è‚İ•ÄÚ‹ß
--~ 		--25“@•à‚«Ú‹ß¨–\‚ê‚é¨UŒ‚Œãs“®
--~ 		if fate < 75 then
--~ 			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, maaiDist, TARGET_ENE_0, true, -1 );
--~ 			if fate2 < 10 then
--~ 				goal:AddSubGoal(GOAL_COMMON_SidewayMove, 5.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(30,45), true, true ,-1 );
--~ 				goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, maaiDist, TARGET_ENE_0, true, -1 );
--~ 			end
--~ 			
--~ 		else
--~ 			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, 1.50, TARGET_ENE_0, true, -1 );
--~ 			goal:AddSubGoal(GOAL_COMMON_Attack, 5.0, 3020, TARGET_ENE_0, DIST_Near, 0);
--~ 			Hiru509000Battle_Kougeki_Noato(ai, goal)
--~ 		end
		
	--‹ß‚¢‚È‚ç
	elseif targetDist >= maaiDist then
		--30% ‘Ò‹@
		--70% ‰“‹——£i•g‹ÊjUŒ‚
		
		if fate < 30 then
			goal:AddSubGoal( GOAL_COMMON_Wait, 3.0, TARGET_ENE_0);
		
		else
			goal:AddSubGoal(GOAL_COMMON_Attack, 5.0, 3040, TARGET_ENE_0, DIST_None, 0);
			goal:AddSubGoal( GOAL_COMMON_Wait, 1.0, TARGET_ENE_0);
		
		end
		
--~ 		--60“@•à‚«Ú‹ß¨‰ñ‚è‚İ•ÄÚ‹ß@@40“@‚³‚ç‚ÉÚ‹ß¨50%–\‚ê‚é50%‰E˜r‚Å‰£‚é
--~ 		if fate < 60 then
--~ 			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, maaiDist, TARGET_ENE_0, true, -1 );
--~ 			if fate2 < 50 then
--~ 				goal:AddSubGoal(GOAL_COMMON_SidewayMove, 5.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(30,45), true, true ,-1 );
--~ 				goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, maaiDist, TARGET_ENE_0, true, -1 );
--~ 			end
--~ 		else
--~ 			goal:AddSubGoal( GOAL_COMMON_KeepDist, 10.0, TARGET_ENE_0, 0.3, 0.8, TARGET_ENE_0, true, -1 );
--~ 			if fate2 < 50 then
--~ 				goal:AddSubGoal(GOAL_COMMON_Attack, 5.0, 3020, TARGET_ENE_0, DIST_Near, 0);
--~ 			else
--~ 				goal:AddSubGoal(GOAL_COMMON_Attack, 5.0, 3000, TARGET_ENE_0, DIST_Near, 0);
--~ 		end
		
	else
	--ŠÔ‡‚¢ˆÈ“à‚È‚ç
		--UŒ‚‚·‚é
		--UŒ‚Œãs“®
		Hiru509000Battle_Kougeki(ai, goal)
		Hiru509000Battle_Kougeki_Noato(ai, goal)
	end
	end
end

---------------------------------------------------------
--  UŒ‚
---------------------------------------------------------
function Hiru509000Battle_Kougeki(ai, goal)

local K_fate = ai:GetRandam_Int(1,100)			--Šm—¦”»’è‚Åg—p‚·‚é‰^–½‚Ì”š

	--20% 3000@ƒrƒ“ƒ^
	--10% 3030@•g‚Ü‚İ‚êUŒ‚
	--30% 3000-3010@ƒrƒ“ƒ^•˜r‚ğU‚è‰ñ‚·
	--30% 3020@Œƒ‚µ‚­–\‚ê‚é
	--10% 3040@•g‹Ê

		--ƒCƒxƒ“ƒg‚©‚çğŒ‚ğE‚Á‚Ä‚«‚ÄAƒqƒ‹•œŠˆ
	if (ai:GetEventRequest( 0 ) == AI_EVENT_LEECH_REGENERATE) then

		--ƒqƒ‹•œŠˆ
		Hiru509000Battle_Hukkatsu(ai, goal)
		Hiru509000Battle_Kougeki_Pettern(ai, goal)
--		goal:AddSubGoal(GOAL_COMMON_Attack, 10.0, 9010, TARGET_ENE_0, DIST_None, 0);

	else
	
		--’ÊíUŒ‚
		Hiru509000Battle_Kougeki_Pettern(ai, goal)
	
--		if K_fate < 20 then
--			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Near, 0);

--		elseif K_fate < 30 then
--			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3030, TARGET_ENE_0, DIST_Near, 0);
			
--		elseif K_fate < 60 then
--			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Near, 0);
--			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3010, TARGET_ENE_0, DIST_Near, 0);
			
--		elseif K_fate < 90 then
--			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3020, TARGET_ENE_0, DIST_Near, 0);
			
--		else
--			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3040, TARGET_ENE_0, DIST_None, 0);
			
--		end
		
	end
end

---------------------------------------------------------
--  ’ÊíUŒ‚
---------------------------------------------------------
function Hiru509000Battle_Kougeki_Pettern(ai, goal)

local K_fate = ai:GetRandam_Int(1,100)			--Šm—¦”»’è‚Åg—p‚·‚é‰^–½‚Ì”š

	if K_fate < 20 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Near, 0);

	elseif K_fate < 30 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3030, TARGET_ENE_0, DIST_Near, 0);
			
	elseif K_fate < 60 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Near, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3010, TARGET_ENE_0, DIST_Near, 0);
			
	elseif K_fate < 90 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3020, TARGET_ENE_0, DIST_Near, 0);
		
	else
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3040, TARGET_ENE_0, DIST_None, 0);
	
	end

end


---------------------------------------------------------
--  ƒqƒ‹•œŠˆ
---------------------------------------------------------
function Hiru509000Battle_Hukkatsu(ai, goal)

local hprate = ai:GetHpRate( TARGET_SELF )	--©•ª‚ÌHPŠ„‡‚ğæ“¾
local fate = ai:GetRandam_Int(1,100)		--Šm—¦”»’è—p
local fate2 = ai:GetRandam_Int(1,100)		--Šm—¦”»’è—p2
local fate3 = ai:GetRandam_Int(1,100)		--Šm—¦”»’è—p3
local fate4 = ai:GetRandam_Int(1,100)		--Šm—¦”»’è—p4


--[[HP‚Ìc‚èŠ„‡‚ğŒ©‚Äƒqƒ‹•œŠˆ‚Ì•p“x‚ğ•Ï‚¦‚é]]

local		HPLevel1 = 0.85					--HP‚Ìc—ÊƒŒƒxƒ‹‚P@85%ˆÈã
local		HPLevel2 = 0.60					--HP‚Ìc—ÊƒŒƒxƒ‹‚Q	60%ˆÈã		
local		HPLevel3 = 0.35					--HP‚Ìc—ÊƒŒƒxƒ‹‚R	35%ˆÈã
local		HPLevel4 = 0.0					--HP‚Ìc—ÊƒŒƒxƒ‹‚S	0%ˆÈã

local		RecoveryPer1 = 25				--HPc—ÊƒŒƒxƒ‹‚P‚Ì‚Æ‚«‚Ìƒqƒ‹•œŠˆŠm—¦
local		RecoveryPer2 = 40				--HPc—ÊƒŒƒxƒ‹‚Q‚Ì‚Æ‚«‚Ìƒqƒ‹•œŠˆŠm—¦
local		RecoveryPer3 = 55				--HPc—ÊƒŒƒxƒ‹‚R‚Ì‚Æ‚«‚Ìƒqƒ‹•œŠˆŠm—¦
local		RecoveryPer4 = 80				--HPc—ÊƒŒƒxƒ‹‚S‚Ì‚Æ‚«‚Ìƒqƒ‹•œŠˆŠm—¦


	if hprate >= HPLevel1 then
		
		if (fate <= RecoveryPer1) then
			goal:AddSubGoal(GOAL_COMMON_Attack, 10.0, 9010, TARGET_ENE_0, DIST_None, 0);
		else
			Hiru509000Battle_Kougeki_Pettern(ai, goal)
		end
	
	elseif hprate >= HPLevel2 then
	
		if (fate2 <= RecoveryPer2) then
			goal:AddSubGoal(GOAL_COMMON_Attack, 10.0, 9010, TARGET_ENE_0, DIST_None, 0);
		else
			Hiru509000Battle_Kougeki_Pettern(ai, goal)
		end
	
	elseif hprate >= HPLevel3 then
	
		if (fate3 <= RecoveryPer3) then
			goal:AddSubGoal(GOAL_COMMON_Attack, 10.0, 9010, TARGET_ENE_0, DIST_None, 0);
		else
			Hiru509000Battle_Kougeki_Pettern(ai, goal)
		end	
	
	else
		
		if (fate4 <= RecoveryPer4) then
			goal:AddSubGoal(GOAL_COMMON_Attack, 10.0, 9010, TARGET_ENE_0, DIST_None, 0);
		else
			Hiru509000Battle_Kougeki_Pettern(ai, goal)
		end

	end

end
	
---------------------------------------------------------
--  UŒ‚Œã‚Ìs“®
---------------------------------------------------------
function Hiru509000Battle_Kougeki_Noato(ai, goal)

local KN_fate = ai:GetRandam_Int(1,100)			--Šm—¦”»’è‚Åg—p‚·‚é‰^–½‚Ì”š
local SideTime = 0.5							--‰¡‚É“®‚­ŠÔ
local BackDist = ai:GetRandam_Float(0.75, 1.5)	--Œã‘Ş‚·‚é‹——£
local BackTime = 0.5							--Œã‘Ş‚·‚éŠÔ


local bRight = ai:GetRandam_Int(0,1);							--¶‰EˆÚ“®‚Ì•ûŒü
local friendNum = ai:GetTeamRecordCount(COORDINATE_TYPE_SideWalk_L+bRight, TARGET_ENE_0, 2.0);		-- “¯‚¶•ûŒü‚É¶‰EˆÚ“®‚µ‚Ä‚¢‚é’‡ŠÔ‚Ì”



--Œã‚ë‚É‰º‚ª‚Á‚½Œã‚É‚Æ‚«‚Ç‚«‰¡ˆÚ“®‚³‚¹‚é‚Æ—Ç‚¢‚©‚à
--‚ ‚Ü‚è‚É‹ß‚·‚¬‚é‰¡ˆÚ“®‚æ‚è‚àA‚·‚±‚µ‰º‚ª‚Á‚Ä‚©‚ç‰¡ˆÚ“®‚³‚¹‚é‚Æ—Ç‚¢‚©‚à

	--100% ‚È‚É‚à‚µ‚È‚¢
	--0% “K“–‚É‰¡‚ÉˆÚ“®
	--0% Œã‚ë‚ÉˆÚ“®
	if KN_fate < 100  and friendNum < 1 then
		goal:AddSubGoal( GOAL_COMMON_Wait, 3.0, TARGET_ENE_0);
--~ 		goal:AddSubGoal(GOAL_COMMON_SidewayMove, 2.5, TARGET_ENE_0, ai:GetRandam_Int(0,1), 10, true, true ,-1 );
	elseif KN_fate < 100  and friendNum < 1 then
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, SideTime, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(15,30), true, true ,-1 );
	else
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, BackTime, TARGET_ENE_0, BackDist, TARGET_ENE_0, true, -1 );				
	end
end



---------------------------------------------------------
--  ƒS[ƒ‹XV
---------------------------------------------------------
function Hiru509000Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  ƒS[ƒ‹I—¹
---------------------------------------------------------
function Hiru509000Battle_Terminate(ai, goal)
end


---------------------------------------------------------
--  Š„‚è‚İ
--	Š„‚è‚ñ‚¾ê‡‚É‚Ítrue‚ğ•Ô‚µ‚Ä‚­‚¾‚³‚¢B
--	‚±‚±‚ÅŠ„‚è‚İ—p‚ÌƒTƒuƒS[ƒ‹‚ğ’Ç‰Á‚µ‚Ä‚­‚¾‚³‚¢B
--	Š„‚è‚Ü‚È‚©‚Á‚½ê‡‚É‚ÍA1‚Âã‚Ì‘w‚ÌƒS[ƒ‹A‚Ü‚½‚ÍƒƒWƒbƒN•”•ª‚É‚æ‚Á‚ÄŠ„‚è‚İ‚ªˆ—‚³‚ê‚Ü‚·B
---------------------------------------------------------
function Hiru509000Battle_Interupt(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);		--“Gƒ^[ƒQƒbƒg‚Æ‚Ì‹——£‚ğæ“¾
local fate = ai:GetRandam_Int(1,100)						--Šm—¦”»’è‚Åg—p‚·‚é‰^–½‚Ì”š
local maaiDist = 1.0										--UŒ‚‚Ì‚½‚ß‚É‹ß‚Ã‚­‹——£@š”Ä—p‰»‚Ìˆ×AUŒ‚‚²‚Æ‚É•ª‚¯‚¸š

	--‹óU‚è’Ç‚¢“¢‚¿
	--25“@‹ß‚­‚Ìƒ^[ƒQƒbƒg‚ª‹óU‚è‚µ‚½‚çUŒ‚
	if ai:IsInterupt( INTERUPT_MissSwing ) then
		if targetDist < maaiDist then
			if fate <= 25 then
				goal:ClearSubGoal();
				Hiru509000Battle_Kougeki(ai, goal)
				Hiru509000Battle_Kougeki_Noato(ai, goal)
				return true;
			end	
		end
	end
	
	
--~ 	--”ò‚Ñ“¹‹ï‚ğŒ‚‚Á‚Ä‚«‚½‚çÅ“Ks“®
--~ 	if ai:IsInterupt( INTERUPT_Shoot ) then
--~ local shootIntPer = 100						--”ò‚Ñ“¹‹ïg—p‚ÉÅ“Ks“®‚ğæ‚éŠm—¦
--~ local hprate = ai:GetHpRate( TARGET_SELF )	--©•ª‚ÌHP‚Ìc—Ê‚ğæ“¾
--~ 		if fate <= shootIntPer then
--~ 			if targetDist >= 14.0 then
--~ 				if hprate <= 0.95 then
--~ 				goal:ClearSubGoal();
--~ 				goal:AddSubGoal(GOAL_COMMON_Attack, 10.0, 9010, TARGET_ENE_0, DIST_None, 0);
--~ 				end
--~ 			end
--~ 			return true;
--~ 		end
--~ 	end

return false;

end
