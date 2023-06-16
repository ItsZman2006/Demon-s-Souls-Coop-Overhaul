-----------------------------------------------------------------------------------------------
--	Haetakari508000ê—pí“¬
--	à–¾F
--
--	ƒpƒ‰ƒ[ƒ^0  ‚È‚µ
--	ƒpƒ‰ƒ[ƒ^1  ‚È‚µ
--	ƒpƒ‰ƒ[ƒ^2  ‚È‚µ
--	ƒpƒ‰ƒ[ƒ^3@‚È‚µ
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_Haetakari508000_Battle, "Haetakari508000Battle");


-- Update‚Å‚È‚É‚à‚â‚Á‚Ä‚¢‚È‚¢‚Ì‚ÅAŒÄ‚Î‚È‚¢‚æ‚¤‚É‚·‚é
REGISTER_GOAL_NO_UPDATE( GOAL_Haetakari508000_Battle, 1 );


---------------------------------------------------------
--  ƒS[ƒ‹‹N“®
---------------------------------------------------------
function Haetakari508000Battle_Activate(ai, goal)
-------------------------------------------------------------------------------

local targetDist = ai:GetDist(TARGET_ENE_0);			--“Gƒ^[ƒQƒbƒg‚Æ‚Ì‹——£
local fate = ai:GetRandam_Int(1,100)					--Šm—¦”»’è‚Åg—p‚·‚é‰^–½‚Ì”š
local fate2 = ai:GetRandam_Int(1,100)					--Šm—¦”»’è‚Åg—p‚·‚é‰^–½‚Ì”š@‚»‚Ì‚Q
local fate3 = ai:GetRandam_Int(1,100)					--Šm—¦”»’è‚Åg—p‚·‚é‰^–½‚Ì”š@‚»‚Ì‚R
local sekkin = ai:GetRandam_Float(0.75, 1.5)			--Ú‹ß‚·‚é‹——£
local maai = ai:GetRandam_Float(0.75, 1.5)				--ŠÔ‡‚¢’²®‚·‚é‹——£
local rate = ai:GetHpRate( TARGET_SELF )				--©•ª‚ÌHP

local farDist = 15.0		--‰“‚¢‚Æ”»’f‚·‚é‹——£
local masiDist = 10.0		--”ˆƒ}ƒVƒ“ƒKƒ“‚ğ•ú‚Â‹——£
local nearDist = 5.5		--‹ß‚¢‚Æ”»’f‚·‚é‹——£
local maaiDist = 2.0		--UŒ‚‚Ì‚½‚ß‚É‹ß‚Ã‚­‹——£@š”Ä—p‰»‚Ìˆ×AUŒ‚‚²‚Æ‚É•ª‚¯‚¸š

local SideTime = 5.0		--‰¡‚É“®‚­ŠÔ

	-- Å‰‚É‚¿‚å‚Á‚Æ‚¾‚¯‘Ò‚Â
	if ai:IsFinishTimer(0) == true then
		local firstTime = ai:GetRandam_Float(0.0, 1.0)			--Å‰‚Ì“®‚«o‚µ‚Ü‚Å‚ÌŠÔ
		goal:AddSubGoal(GOAL_COMMON_Wait, firstTime, TARGET_ENE_0, 0, 0, 0 );
		ai:SetTimer( 0, 9999.0 );
	end

	if ai:IsInsideTargetRegion( TARGET_SELF, 2235) then
	
		--‹ß‚­‚È‚¢‚È‚ç
		if targetDist >= nearDist then
			--30“@•à‚«Ú‹ß¨50“@‰E˜rU‚è‰º‚ë‚µ 80% HP‚ª2Š„ˆÈ‰º‚Å©•ª‚É”ˆ‚ğ“Z‚í‚¹‚é
			--80“@”ˆ‚ğ”ò‚Î‚·i‰“‹——£UŒ‚j¨Ú‹ß
			if fate < 30 then
				if fate3 < 40 then
					goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 2.0, TARGET_ENE_0, nearDist, TARGET_ENE_0, true, -1 );
				else
					goal:AddSubGoal(GOAL_COMMON_SidewayMove, SideTime, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(15,30), true, true ,-1 );
				end
					if fate2 < 50 then
						goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3010, TARGET_ENE_0, DIST_None, 0);
					elseif fate2 < 80 then
						if rate < 0.2 then
							goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3040, TARGET_ENE_0, DIST_None, 0);
						else
							if targetDist < masiDist then
								goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3030, TARGET_ENE_0, DIST_None, 0);
							else
								goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3060, TARGET_ENE_0, DIST_None, 0);
							end
						end
					end
				
			else
				if targetDist < masiDist then
					goal:AddSubGoal(GOAL_COMMON_Attack, 5.0, 3030, TARGET_ENE_0, DIST_None, 0);
				else
					goal:AddSubGoal(GOAL_COMMON_Attack, 5.0, 3060, TARGET_ENE_0, DIST_None, 0);
				end
				if fate3 < 40 then
					goal:AddSubGoal(GOAL_COMMON_ApproachTarget, 2.0, TARGET_ENE_0, nearDist, TARGET_ENE_0, true, -1 );
				else
					goal:AddSubGoal(GOAL_COMMON_SidewayMove, SideTime, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(15,30), true, true ,-1 );
				end
			end
			
			
	--~ 	--‹ß‚¢‚È‚ç
	--~ 	elseif targetDist >= maaiDist then
	--~ 		--60“@•à‚«Ú‹ß¨‰ñ‚è‚İ•ÄÚ‹ß
	--~ 		--40“@‚³‚ç‚ÉÚ‹ß¨50%–\‚ê‚é50%‰E˜r‚Å‰£‚é
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
	--~ 			end
	--~ 		end
			

		--Š‹ß‹——£‚È‚ç
		elseif targetDist < maaiDist then
			--50% ”ˆ”š”­
			--10% –\‚ê‚é
			--40% ‰E˜r‚Å‰£‚é
			if fate < 50 then
				goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3050, TARGET_ENE_0, DIST_Near, 0);
				
			elseif fate < 60 then
				goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3020, TARGET_ENE_0, DIST_Near, 0);
			
			else
				goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Near, 0);
				
			end

		else
		--ŠÔ‡‚¢ˆÈ“à‚È‚ç (maaiDist < x <= nearDist)
			--UŒ‚‚·‚é
			--UŒ‚Œãs“®
			Haetakari508000Battle_Kougeki(ai, goal)
			Haetakari508000Battle_Kougeki_Noato(ai, goal)
		end

	else
		--‰“‚©‚Á‚½‚ç”ò‚Ñ“¹‹ïA‹ß‚©‚Á‚½‚ç‰£‚é
 		if targetDist > nearDist then
 			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3030, TARGET_ENE_0, DIST_None, 0);
 		else
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_None, 0);
 		end
		--—Ìˆæ‚©‚ç–ß‚é
		goal:AddSubGoal(GOAL_COMMON_BackToHome, 4.0, -1, 0, 0, 0 );
	end
	
end

---------------------------------------------------------
--  UŒ‚
---------------------------------------------------------
function Haetakari508000Battle_Kougeki(ai, goal)

local K_fate = ai:GetRandam_Int(1,100)			--Šm—¦”»’è‚Åg—p‚·‚é‰^–½‚Ì”š
local rate = ai:GetHpRate( TARGET_SELF )				--©•ª‚ÌHP

	--45% 3000@‰E˜r‚Å‰£‚é
	--20% 3000-3010@‰E˜r‚Å‰£‚é•‰E˜rU‚è‰º‚ë‚µ
	--30% 3020@–\‚ê‚é
	--05% 3040@©•ª‚É”ˆ‚ğ“Z‚í‚¹‚é

	if K_fate < 45 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Near, 0);
	elseif K_fate < 65 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Near, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3010, TARGET_ENE_0, DIST_Near, 0);
	elseif K_fate < 95 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3020, TARGET_ENE_0, DIST_Near, 0);
	else
		if rate < 0.2 then
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3040, TARGET_ENE_0, DIST_Near, 0);

		else
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3020, TARGET_ENE_0, DIST_Near, 0);

		end
	end
end
	
	
---------------------------------------------------------
--  UŒ‚Œã‚Ìs“®
---------------------------------------------------------
function Haetakari508000Battle_Kougeki_Noato(ai, goal)

local KN_fate = ai:GetRandam_Int(1,100)			--Šm—¦”»’è‚Åg—p‚·‚é‰^–½‚Ì”š
local SideTime = 0.5							--‰¡‚É“®‚­ŠÔ
local BackDist = ai:GetRandam_Float(0.75, 1.5)	--Œã‘Ş‚·‚é‹——£
local BackTime = 0.5							--Œã‘Ş‚·‚éŠÔ


local bRight = ai:GetRandam_Int(0,1);							--¶‰EˆÚ“®‚Ì•ûŒü
local friendNum = ai:GetTeamRecordCount(COORDINATE_TYPE_SideWalk_L+bRight, TARGET_ENE_0, 2.0);		-- “¯‚¶•ûŒü‚É¶‰EˆÚ“®‚µ‚Ä‚¢‚é’‡ŠÔ‚Ì”



--Œã‚ë‚É‰º‚ª‚Á‚½Œã‚É‚Æ‚«‚Ç‚«‰¡ˆÚ“®‚³‚¹‚é‚Æ—Ç‚¢‚©‚à
--‚ ‚Ü‚è‚É‹ß‚·‚¬‚é‰¡ˆÚ“®‚æ‚è‚àA‚·‚±‚µ‰º‚ª‚Á‚Ä‚©‚ç‰¡ˆÚ“®‚³‚¹‚é‚Æ—Ç‚¢‚©‚à

	--25% ‚È‚É‚à‚µ‚È‚¢i‚¿‚å‚Á‚Æ‚¾‚¯‰¡ˆÚ“®j
	--50% “K“–‚É‰¡‚ÉˆÚ“®
	--25% Œã‚ë‚ÉˆÚ“®
	if KN_fate < 25  and friendNum < 1 then
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, 2.5, TARGET_ENE_0, ai:GetRandam_Int(0,1), 10, true, true ,-1 );
	elseif KN_fate < 75  and friendNum < 1 then
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, SideTime, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(15,30), true, true ,-1 );
	else
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, BackTime, TARGET_ENE_0, BackDist, TARGET_ENE_0, true, -1 );				
	end
end



---------------------------------------------------------
--  ƒS[ƒ‹XV
---------------------------------------------------------
function Haetakari508000Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  ƒS[ƒ‹I—¹
---------------------------------------------------------
function Haetakari508000Battle_Terminate(ai, goal)
end


---------------------------------------------------------
--  Š„‚è‚İ
--	Š„‚è‚ñ‚¾ê‡‚É‚Ítrue‚ğ•Ô‚µ‚Ä‚­‚¾‚³‚¢B
--	‚±‚±‚ÅŠ„‚è‚İ—p‚ÌƒTƒuƒS[ƒ‹‚ğ’Ç‰Á‚µ‚Ä‚­‚¾‚³‚¢B
--	Š„‚è‚Ü‚È‚©‚Á‚½ê‡‚É‚ÍA1‚Âã‚Ì‘w‚ÌƒS[ƒ‹A‚Ü‚½‚ÍƒƒWƒbƒN•”•ª‚É‚æ‚Á‚ÄŠ„‚è‚İ‚ªˆ—‚³‚ê‚Ü‚·B
---------------------------------------------------------
function Haetakari508000Battle_Interupt(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);		--“Gƒ^[ƒQƒbƒg‚Æ‚Ì‹——£‚ğæ“¾
local fate = ai:GetRandam_Int(1,100)						--Šm—¦”»’è‚Åg—p‚·‚é‰^–½‚Ì”š
local maaiDist = 1.0										--UŒ‚‚Ì‚½‚ß‚É‹ß‚Ã‚­‹——£@š”Ä—p‰»‚Ìˆ×AUŒ‚‚²‚Æ‚É•ª‚¯‚¸š

	--‹óU‚è’Ç‚¢“¢‚¿
	--25“@‹ß‚­‚Ìƒ^[ƒQƒbƒg‚ª‹óU‚è‚µ‚½‚çUŒ‚
	if ai:IsInterupt( INTERUPT_MissSwing ) then
		if targetDist < maaiDist then
			if fate <= 25 then
				goal:ClearSubGoal();
				Haetakari508000Battle_Kougeki(ai, goal)
				Haetakari508000Battle_Kougeki_Noato(ai, goal)
				return true;
			end	
		end
	end

return false;

end
