-----------------------------------------------------------------------------------------------
--	Huhai210000ê—pí“¬
--	à–¾F
--
--	ƒpƒ‰ƒ[ƒ^0  ‚È‚µ
--	ƒpƒ‰ƒ[ƒ^1  ‚È‚µ
--	ƒpƒ‰ƒ[ƒ^2  ‚È‚µ
--	ƒpƒ‰ƒ[ƒ^3@‚È‚µ
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_Huhai210000_Battle, "Huhai210000Battle");


-- Update‚Å‚È‚É‚à‚â‚Á‚Ä‚¢‚È‚¢‚Ì‚ÅAŒÄ‚Î‚È‚¢‚æ‚¤‚É‚·‚é
REGISTER_GOAL_NO_UPDATE( GOAL_Huhai210000_Battle, 1 );


---------------------------------------------------------
--  ƒS[ƒ‹‹N“®
---------------------------------------------------------
function Huhai210000Battle_Activate(ai, goal)
-------------------------------------------------------------------------------

local targetDist = ai:GetDist(TARGET_ENE_0);	--“Gƒ^[ƒQƒbƒg‚Æ‚Ì‹——£
local fate = ai:GetRandam_Int(1,100)					--Šm—¦”»’è‚Åg—p‚·‚é‰^–½‚Ì”š
local fate2 = ai:GetRandam_Int(1,100)					--Šm—¦”»’è‚Åg—p‚·‚é‰^–½‚Ì”š@‚»‚Ì‚Q
local fate3 = ai:GetRandam_Int(1,100)					--Šm—¦”»’è‚Åg—p‚·‚é‰^–½‚Ì”š@‚»‚Ì‚R
local sekkin = ai:GetRandam_Float(0.75, 1.5)			--Ú‹ß‚·‚é‹——£
local maai = ai:GetRandam_Float(0.75, 1.5)				--ŠÔ‡‚¢’²®‚·‚é‹——£
local rate = ai:GetHpRate( TARGET_SELF )				--©•ª‚ÌHP
local idParam = ai:GetNpcThinkParamID();				--NPC‚ÌID‚ğæ“¾

local farDist = 10.0		--‰“‚¢‚Æ”»’f‚·‚é‹——£
local nearDist = 5.0		--‹ß‚¢‚Æ”»’f‚·‚é‹——£
local maaiDist = 3.0		--UŒ‚‚Ì‚½‚ß‚É‹ß‚Ã‚­‹——£@š”Ä—p‰»‚Ìˆ×AUŒ‚‚²‚Æ‚É•ª‚¯‚¸š

	-- Å‰‚É‚¿‚å‚Á‚Æ‚¾‚¯‘Ò‚Â
	if ai:IsFinishTimer(0) == true then
		local firstTime = ai:GetRandam_Float(0.0, 2.0)			--Å‰‚Ì“®‚«o‚µ‚Ü‚Å‚ÌŠÔ
		goal:AddSubGoal(GOAL_COMMON_Wait, firstTime, TARGET_ENE_0, 0, 0, 0 );
		ai:SetTimer( 0, 9999.0 );
	end

	--‰“‚¢‚È‚ç
	if targetDist >= nearDist then
		--10“@•à‚«Ú‹ß
		--35“@•à‚«‚©‚ç‘–‚èÚ‹ß
		--55“@‘–‚èÚ‹ß
		if fate < 10 then
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, maaiDist, TARGET_ENE_0, true, -1 );
		elseif fate < 45 then
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 3.0, TARGET_ENE_0, (targetDist - 3.0), TARGET_ENE_0, true, -1 );
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, maaiDist, TARGET_ENE_0, false, -1 );			
		else
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, maaiDist, TARGET_ENE_0, false, -1 );
		end
		
	--‹ß‚¢‚È‚ç
	elseif targetDist >= maaiDist then
		--60“@•à‚«Ú‹ß¨‰ñ‚è‚İ•ÄÚ‹ß@@40“@‹——£•Û‚Â¨70%“Ëi‘Ì“–‚½‚è30%UŒ‚i’†j
		if fate < 60 then
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, maaiDist, TARGET_ENE_0, true, -1 );
			if fate2 < 20 then
				goal:AddSubGoal(GOAL_COMMON_SidewayMove, 2.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(10,20), true, true ,-1 );
				goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 10.0, TARGET_ENE_0, maaiDist, TARGET_ENE_0, true, -1 );
			end
		else
			goal:AddSubGoal( GOAL_COMMON_KeepDist, 3.0, TARGET_ENE_0, 3.0, 5.0, TARGET_ENE_0, false, -1 );
			if fate2 < 70 then
				if 		(idParam==210004) then		
					goal:AddSubGoal(GOAL_COMMON_Attack, 5.0, 3000, TARGET_ENE_0, DIST_Near, 0);
				else
					goal:AddSubGoal(GOAL_COMMON_Attack, 5.0, 3004, TARGET_ENE_0, DIST_Near, 0);
				end
			else
				goal:AddSubGoal(GOAL_COMMON_Attack, 5.0, 3000, TARGET_ENE_0, DIST_Near, 0);
			end
		end
		
	else
	--ŠÔ‡‚¢ˆÈ“à‚È‚ç
		--UŒ‚‚·‚é
		--UŒ‚Œãs“®
		Huhai210000Battle_Kougeki(ai, goal)
		Huhai210000Battle_Kougeki_Noato(ai, goal)
	end
end

---------------------------------------------------------
--  UŒ‚
---------------------------------------------------------
function Huhai210000Battle_Kougeki(ai, goal)

local K_fate = ai:GetRandam_Int(1,100)			--Šm—¦”»’è‚Åg—p‚·‚é‰^–½‚Ì”š
local rate = ai:GetHpRate( TARGET_SELF )
local idParam = ai:GetNpcThinkParamID();				--NPC‚ÌID‚ğæ“¾

	--20% 3000@UŒ‚i¬jiHP‚ª50%ˆÈ‰º‚È‚ç“Ëi‘Ì“–‚½‚èj
	--10% 3003@“Ë‚«—‚Æ‚·
	--15% 3004@“Ëi‘Ì“–‚½‚è
	--20% 3000-3001@UŒ‚i¬j•UŒ‚i’†j
	--15% 3002@–\‚ê‚é
	--20% 3300@—¼èUŒ‚
	if K_fate < 20 then
		if rate < 0.5 then
			if 		(idParam==210004) then
				goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Near, 0);
			else
				goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3004, TARGET_ENE_0, DIST_Near, 0);
			end
		else
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Near, 0);
		end
	elseif K_fate < 30 then
		if 		(idParam==210004) then
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Near, 0);
		else
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3003, TARGET_ENE_0, DIST_Near, 0);
		end
	elseif K_fate < 45 then
		if 		(idParam==210004) then
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3002, TARGET_ENE_0, DIST_Near, 0);
		else
			goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3004, TARGET_ENE_0, DIST_Near, 0);
		end
	elseif K_fate < 65 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3000, TARGET_ENE_0, DIST_Near, 0);
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3001, TARGET_ENE_0, DIST_Near, 0);
	elseif K_fate < 80 then
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3002, TARGET_ENE_0, DIST_Near, 0);
	else
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3300, TARGET_ENE_0, DIST_Near, 0);
	end
end
	
	
---------------------------------------------------------
--  UŒ‚Œã‚Ìs“®
---------------------------------------------------------
function Huhai210000Battle_Kougeki_Noato(ai, goal)

local KN_fate = ai:GetRandam_Int(1,100)			--Šm—¦”»’è‚Åg—p‚·‚é‰^–½‚Ì”š
local SideTime = 0.5							--‰¡‚É“®‚­ŠÔ
local BackDist = ai:GetRandam_Float(0.25, 1.0)	--Œã‘Ş‚·‚é‹——£
local BackTime = 0.5							--Œã‘Ş‚·‚éŠÔ


local bRight = ai:GetRandam_Int(0,1);							--¶‰EˆÚ“®‚Ì•ûŒü
local friendNum = ai:GetTeamRecordCount(COORDINATE_TYPE_SideWalk_L+bRight, TARGET_ENE_0, 2.0);		-- “¯‚¶•ûŒü‚É¶‰EˆÚ“®‚µ‚Ä‚¢‚é’‡ŠÔ‚Ì”



--Œã‚ë‚É‰º‚ª‚Á‚½Œã‚É‚Æ‚«‚Ç‚«‰¡ˆÚ“®‚³‚¹‚é‚Æ—Ç‚¢‚©‚à
--‚ ‚Ü‚è‚É‹ß‚·‚¬‚é‰¡ˆÚ“®‚æ‚è‚àA‚·‚±‚µ‰º‚ª‚Á‚Ä‚©‚ç‰¡ˆÚ“®‚³‚¹‚é‚Æ—Ç‚¢‚©‚à

	--25% ‚È‚É‚à‚µ‚È‚¢i‚¿‚å‚Á‚Æ‚¾‚¯‰¡ˆÚ“®j
	--50% “K“–‚É‰¡‚ÉˆÚ“®
	--25% Œã‚ë‚ÉˆÚ“®
	if KN_fate < 25  and friendNum < 1 then
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, 0.5, TARGET_ENE_0, ai:GetRandam_Int(0,1), 10, true, true ,-1 );
	elseif KN_fate < 75  and friendNum < 1 then
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, SideTime, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(15,30), true, true ,-1 );
	else
		goal:AddSubGoal( GOAL_COMMON_LeaveTarget, BackTime, TARGET_ENE_0, BackDist, TARGET_ENE_0, true, -1 );				
	end
end



---------------------------------------------------------
--  ƒS[ƒ‹XV
---------------------------------------------------------
function Huhai210000Battle_Update(ai, goal)
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  ƒS[ƒ‹I—¹
---------------------------------------------------------
function Huhai210000Battle_Terminate(ai, goal)
end


---------------------------------------------------------
--  Š„‚è‚İ
--	Š„‚è‚ñ‚¾ê‡‚É‚Ítrue‚ğ•Ô‚µ‚Ä‚­‚¾‚³‚¢B
--	‚±‚±‚ÅŠ„‚è‚İ—p‚ÌƒTƒuƒS[ƒ‹‚ğ’Ç‰Á‚µ‚Ä‚­‚¾‚³‚¢B
--	Š„‚è‚Ü‚È‚©‚Á‚½ê‡‚É‚ÍA1‚Âã‚Ì‘w‚ÌƒS[ƒ‹A‚Ü‚½‚ÍƒƒWƒbƒN•”•ª‚É‚æ‚Á‚ÄŠ„‚è‚İ‚ªˆ—‚³‚ê‚Ü‚·B
---------------------------------------------------------
function Huhai210000Battle_Interupt(ai, goal)

local targetDist = ai:GetDist(TARGET_ENE_0);		--“Gƒ^[ƒQƒbƒg‚Æ‚Ì‹——£‚ğæ“¾
local fate = ai:GetRandam_Int(1,100)						--Šm—¦”»’è‚Åg—p‚·‚é‰^–½‚Ì”š
local maaiDist = 1.0										--UŒ‚‚Ì‚½‚ß‚É‹ß‚Ã‚­‹——£@š”Ä—p‰»‚Ìˆ×AUŒ‚‚²‚Æ‚É•ª‚¯‚¸š

	--‹óU‚è’Ç‚¢“¢‚¿
	--25“@‹ß‚­‚Ìƒ^[ƒQƒbƒg‚ª‹óU‚è‚µ‚½‚çUŒ‚
	if ai:IsInterupt( INTERUPT_MissSwing ) then
		if targetDist < maaiDist then
			if fate <= 25 then
				goal:ClearSubGoal();
				Huhai210000Battle_Kougeki(ai, goal)
				Huhai210000Battle_Kougeki_Noato(ai, goal)
				return true;
			end	
		end
	end

return false;

end










--[[************************************************************************************************************]]
--[[**************************************** •…”slƒTƒuƒS[ƒ‹ **************************************************]]
--[[************************************************************************************************************]]



--[[*******************************************************************************************
	•…”sl—p‘Ò‚¿ƒS[ƒ‹B
	à–¾F
		•…”sl—p‚Ì‘Ò‹@‚És‚¤ƒAƒNƒVƒ‡ƒ“‚ğ‘‚­B
		‘Ò‚¿’†‚Ìƒ‰ƒ“ƒ_ƒ€«‚Í‚±‚±‚ÅB
		
	ƒpƒ‰ƒ[ƒ^0  ‚È‚µB
*********************************************************************************************]]
REGISTER_GOAL(GOAL_Huhai_COMMON_Wait, "HUHAIWait");
REGISTER_GOAL_NO_UPDATE( GOAL_Huhai_COMMON_Wait, true);
REGISTER_GOAL_NO_INTERUPT( GOAL_Huhai_COMMON_Wait, true);

--[[*****************************************************
	ƒS[ƒ‹‹N“®
*******************************************************]]
function HUHAIWait_Activate(ai, goal)

	--ƒpƒ‰ƒ[ƒ^ID‚ÅA•Ï‰»‚ğ‰Á‚¦‚é;
	local idParam 	= ai:GetNpcThinkParamID();
	local ezStateNo	= 0;

	
	if 		(idParam==211000) then		ezStateNo	= 3300; --ƒsƒbƒPƒ‹
	elseif 	(idParam==211001) then		ezStateNo	= 3301;	--‘Ü
	elseif 	(idParam==211002) then		ezStateNo	= 3302;	--¬Œ•
	elseif 	(idParam==211003) then		ezStateNo	= 3302;	--‘åŒ•
	elseif 	(idParam==211004) then		ezStateNo	= 0;	--ƒSƒNƒŠè‰º
	end


	--ƒAƒNƒVƒ‡ƒ“‘OAŠÔB
	local wait_time = ai:GetRandam_Float( 0.5, 2.5);
	goal:AddSubGoal( GOAL_COMMON_Wait, wait_time, TARGET_NONE);
	
	--‚Ü‚¿ƒAƒNƒVƒ‡ƒ“B
	if ( 0<ezStateNo) then
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 100, ezStateNo, TARGET_NONE, DIST_None);
	end
	
end

--[[*****************************************************
	ƒS[ƒ‹XVEI—¹EŠ„‚è‚İ‚ğs‚í‚È‚¢B
*******************************************************]]
function HUHAIWait_Update(ai, goal) return GOAL_RESULT_Continue; end
function HUHAIWait_Terminate(ai, goal) end
function HUHAIWait_Interupt(ai, goal) return false; end





			


