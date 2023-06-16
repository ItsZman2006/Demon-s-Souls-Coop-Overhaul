-----------------------------------------------------------------------------------------------
--	Namekuji307000ê—pí“¬
--	à–¾F
--
--	ƒpƒ‰ƒ[ƒ^0  ‚È‚µ
--	ƒpƒ‰ƒ[ƒ^1  ‚È‚µ
--	ƒpƒ‰ƒ[ƒ^2  ‚È‚µ
--	ƒpƒ‰ƒ[ƒ^3@‚È‚µ
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_Namekuji307000_Battle, "Namekuji307000Battle");


-- Update‚Å‚È‚É‚à‚â‚Á‚Ä‚¢‚È‚¢‚Ì‚ÅAŒÄ‚Î‚È‚¢‚æ‚¤‚É‚·‚é
REGISTER_GOAL_NO_UPDATE( GOAL_Namekuji307000_Battle, 1 );


---------------------------------------------------------
--  ƒS[ƒ‹‹N“®
---------------------------------------------------------
function Namekuji307000Battle_Activate(ai, goal)
-------------------------------------------------------------------------------

local targetDist = ai:GetDist(TARGET_ENE_0);	--“Gƒ^[ƒQƒbƒg‚Æ‚Ì‹——£
local fate = ai:GetRandam_Int(1,100)					--Šm—¦”»’è‚Åg—p‚·‚é‰^–½‚Ì”š
local fate2 = ai:GetRandam_Int(1,100)					--Šm—¦”»’è‚Åg—p‚·‚é‰^–½‚Ì”š@‚»‚Ì‚Q
local maai = ai:GetRandam_Float(0.75, 1.5)				--ŠÔ‡‚¢’²®‚·‚é‹——£

local farDist = 10.0		--‰“‚¢‚Æ”»’f‚·‚é‹——£
local nearDist = 3.0		--‹ß‚¢‚Æ”»’f‚·‚é‹——£
local maaiDist = 1.8		--UŒ‚‚Ì‚½‚ß‚É‹ß‚Ã‚­‹——£@š”Ä—p‰»‚Ìˆ×AUŒ‚‚²‚Æ‚É•ª‚¯‚¸š

	-- Å‰‚É‚¿‚å‚Á‚Æ‚¾‚¯‘Ò‚Â
	if ai:IsFinishTimer(0) == true then
		local firstTime = ai:GetRandam_Float(0.0, 2.0)			--Å‰‚Ì“®‚«o‚µ‚Ü‚Å‚ÌŠÔ
		goal:AddSubGoal(GOAL_COMMON_Wait, firstTime, TARGET_ENE_0, 0, 0, 0 );
		ai:SetTimer( 0, 9999.0 );
	end

	--‹ß‚­‚È‚¢‚È‚ç
	if targetDist >= nearDist then
		--75“@•à‚«Ú‹ß
		--25“@‘Ò‹@
		if fate < 75 then
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, maaiDist, TARGET_ENE_0, true, -1 );
		else
			goal:AddSubGoal(GOAL_COMMON_Wait,2.0,TARGET_ENE_0, 0, 0, 0 );
		end
		
	--‹ß‚¢‚È‚ç
	elseif targetDist >= maaiDist then
		--60“@•à‚«Ú‹ß¨ÄÚ‹ß@@40“@‚³‚ç‚ÉÚ‹ß¨UŒ‚
		if fate < 60 then
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, maaiDist, TARGET_ENE_0, true, -1 );
			if fate2 < 50 then
				goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, maaiDist, TARGET_ENE_0, true, -1 );
			end
		else
			goal:AddSubGoal( GOAL_COMMON_KeepDist, 10.0, TARGET_ENE_0, 0.3, 0.8, TARGET_ENE_0, true, -1 );

			if fate2 < 60 then
				goal:AddSubGoal(GOAL_COMMON_Attack, 5.0, 3000, TARGET_ENE_0, DIST_Near, 0);

			elseif fate2 < 80 then
				goal:AddSubGoal(GOAL_COMMON_Attack, 5.0, 3001, TARGET_ENE_0, DIST_Near, 0);
				
			else
				goal:AddSubGoal(GOAL_COMMON_Attack, 5.0, 3002, TARGET_ENE_0, DIST_Near, 0);
				
			end
			
		end
		
	else
	--ŠÔ‡‚¢ˆÈ“à‚È‚ç
		--UŒ‚‚·‚é
		--UŒ‚Œãs“®
		Namekuji307000Battle_Kougeki(ai, goal)
		Namekuji307000Battle_Kougeki_Noato(ai, goal)
	end
end

---------------------------------------------------------
--  UŒ‚
---------------------------------------------------------
function Namekuji307000Battle_Kougeki(ai, goal)

local K_fate = ai:GetRandam_Int(1,100)			--Šm—¦”»’è‚Åg—p‚·‚é‰^–½‚Ì”š

	--60% 3000@Šš‚İ•t‚«
	--20% 3001@“Å–¶
	--20% 3002@”ò‚Ñ‚©‚©‚è
	if K_fate < 60 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Near, 0);

	elseif K_fate < 80 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Near, 0);
		
	else
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3002, TARGET_ENE_0, DIST_Near, 0);

	end
end
	
	
---------------------------------------------------------
--  UŒ‚Œã‚Ìs“®
---------------------------------------------------------
function Namekuji307000Battle_Kougeki_Noato(ai, goal)

local KN_fate = ai:GetRandam_Int(1,100)			--Šm—¦”»’è‚Åg—p‚·‚é‰^–½‚Ì”š
local SideTime = 0.5							--‰¡‚É“®‚­ŠÔ
local BackDist = ai:GetRandam_Float(0.75, 1.5)	--Œã‘Ş‚·‚é‹——£
local BackTime = 0.5							--Œã‘Ş‚·‚éŠÔ


local bRight = ai:GetRandam_Int(0,1);							--¶‰EˆÚ“®‚Ì•ûŒü
local friendNum = ai:GetTeamRecordCount(COORDINATE_TYPE_SideWalk_L+bRight, TARGET_ENE_0, 2.0);		-- “¯‚¶•ûŒü‚É¶‰EˆÚ“®‚µ‚Ä‚¢‚é’‡ŠÔ‚Ì”



--Œã‚ë‚É‰º‚ª‚Á‚½Œã‚É‚Æ‚«‚Ç‚«‰¡ˆÚ“®‚³‚¹‚é‚Æ—Ç‚¢‚©‚à
--‚ ‚Ü‚è‚É‹ß‚·‚¬‚é‰¡ˆÚ“®‚æ‚è‚àA‚·‚±‚µ‰º‚ª‚Á‚Ä‚©‚ç‰¡ˆÚ“®‚³‚¹‚é‚Æ—Ç‚¢‚©‚à

	--70% ‚È‚É‚à‚µ‚È‚¢i‚¿‚å‚Á‚Æ‚¾‚¯‰¡ˆÚ“®j
	--20% “K“–‚É‰¡‚ÉˆÚ“®
	--10% Œã‚ë‚ÉˆÚ“®
	if KN_fate < 70  and friendNum < 1 then
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, 2.5, TARGET_ENE_0, ai:GetRandam_Int(0,1), 10, true, true ,-1 );
	elseif KN_fate < 90  and friendNum < 1 then
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, SideTime, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(15,30), true, true ,-1 );
	else
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, BackTime, TARGET_ENE_0, BackDist, TARGET_ENE_0, true, -1 );				
	end
end



---------------------------------------------------------
--  ƒS[ƒ‹XV
---------------------------------------------------------
function Namekuji307000Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  ƒS[ƒ‹I—¹
---------------------------------------------------------
function Namekuji307000Battle_Terminate(ai, goal)
end


---------------------------------------------------------
--  Š„‚è‚İ
--	Š„‚è‚ñ‚¾ê‡‚É‚Ítrue‚ğ•Ô‚µ‚Ä‚­‚¾‚³‚¢B
--	‚±‚±‚ÅŠ„‚è‚İ—p‚ÌƒTƒuƒS[ƒ‹‚ğ’Ç‰Á‚µ‚Ä‚­‚¾‚³‚¢B
--	Š„‚è‚Ü‚È‚©‚Á‚½ê‡‚É‚ÍA1‚Âã‚Ì‘w‚ÌƒS[ƒ‹A‚Ü‚½‚ÍƒƒWƒbƒN•”•ª‚É‚æ‚Á‚ÄŠ„‚è‚İ‚ªˆ—‚³‚ê‚Ü‚·B
---------------------------------------------------------
function Namekuji307000Battle_Interupt(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);		--“Gƒ^[ƒQƒbƒg‚Æ‚Ì‹——£‚ğæ“¾
local fate = ai:GetRandam_Int(1,100)						--Šm—¦”»’è‚Åg—p‚·‚é‰^–½‚Ì”š
local maaiDist = 1.0										--UŒ‚‚Ì‚½‚ß‚É‹ß‚Ã‚­‹——£@š”Ä—p‰»‚Ìˆ×AUŒ‚‚²‚Æ‚É•ª‚¯‚¸š

	--‹óU‚è’Ç‚¢“¢‚¿
	--25“@‹ß‚­‚Ìƒ^[ƒQƒbƒg‚ª‹óU‚è‚µ‚½‚çUŒ‚
	if ai:IsInterupt( INTERUPT_MissSwing ) then
		if targetDist < maaiDist then
			if fate <= 25 then
				goal:ClearSubGoal();
				Namekuji307000Battle_Kougeki(ai, goal)
				Namekuji307000Battle_Kougeki_Noato(ai, goal)
				return true;
			end	
		end
	end

return false;

end
