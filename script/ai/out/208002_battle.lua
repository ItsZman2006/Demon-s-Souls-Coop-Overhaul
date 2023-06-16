--[[*******************************************************************************************
	y–—™z—pí“¬
	à–¾F

	•ÏX—š—ğF
	@E08/7/24 hasem	ƒ`[ƒ€–½—ß‚ğo‚³‚È‚¢•“®‚©‚È‚¢•˜AË–‚–@‚ğg‚¤B
	@E08/7/26 hasem	‹ß/’†/‰“‹——£‚ÅUŒ‚‚ğ•ª‚¯‚éB
	@E
	
	ƒpƒ‰ƒ[ƒ^0  ‚È‚µ
	ƒpƒ‰ƒ[ƒ^1  ‚È‚µ
	ƒpƒ‰ƒ[ƒ^2  ‚È‚µ
	ƒpƒ‰ƒ[ƒ^3@‚È‚µ
*********************************************************************************************]]
REGISTER_GOAL(GOAL_Gokuri208002_Battle, "Gokuri208002Battle");

-- Update‚Å‚È‚É‚à‚â‚Á‚Ä‚¢‚È‚¢‚Ì‚ÅAŒÄ‚Î‚È‚¢‚æ‚¤‚É‚·‚é
REGISTER_GOAL_NO_UPDATE( GOAL_Gokuri208002_Battle, true);
--~ REGISTER_GOAL_NO_INTERUPT( GOAL_Gokuri208002_Battle, true);


--[[*****************************************************
	ƒS[ƒ‹‹N“®
*******************************************************]]
function Gokuri208002Battle_Activate(ai, goal)

	--[[¡Šé‰æ‚³‚ñ’²®€–Ú¡]]
	
		--Še‹——£‚Ì‚µ‚«‚¢’l‚ÍAƒGƒNƒZƒ‹‘¤iNPCvlƒpƒ‰ƒ[ƒ^‚É‚ ‚è‚Ü‚·B
	
	--[[¡Šé‰æ‚³‚ñ’²®€–Ú¡]]

	local targetDist 	= ai:GetDist(TARGET_ENE_0);		--“Gƒ^[ƒQƒbƒg‚Æ‚Ì‹——£‚ğæ“¾
	local NEAR_DIST		= ai:GetDistParam(DIST_Near);	--‹ß‹——£‚µ‚«‚¢’lB
	local MIDDLE_DIST	= ai:GetDistParam(DIST_Middle);	--’†‹——£‚µ‚«‚¢’lB
	local FAR_DIST		= ai:GetDistParam(DIST_Far);	--‰“‹——£‚µ‚«‚¢’lB
	local fate			= ai:GetRandam_Int(1,100)		--Šm—¦”»’è‚Åg—p‚·‚é‰^–½‚Ì”š

	
	if 		( targetDist<NEAR_DIST ) then
		if fate < 30 then
		goal:AddSubGoal(GOAL_COMMON_SidewayMove, 3.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(15,30), true, true, -1);
		else
			Gokuri208002Battle_NearAttack( ai, goal);
		end
		
	elseif 	( targetDist<MIDDLE_DIST ) then
		if fate < 20 then
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 3.0, TARGET_ENE_0, NEAR_DIST, TARGET_ENE_0, false, -1 );
		elseif fate < 30 then
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 3.0, TARGET_ENE_0, NEAR_DIST, TARGET_ENE_0, true, -1 );		
		elseif fate < 40 then
			goal:AddSubGoal(GOAL_COMMON_SidewayMove, 3.0, TARGET_ENE_0, ai:GetRandam_Int(0,1), ai:GetRandam_Int(15,30), true, true, -1);
		else
			Gokuri208002Battle_MiddleAttack( ai, goal);
		end
	else
		Gokuri208002Battle_FarAttack( ai, goal);
	end
	
end


---------------------------------------------------------
--  ‰“‹——£–CŒ‚B
---------------------------------------------------------
function Gokuri208002Battle_FarAttack(ai, goal)

	--[[¡Šé‰æ‚³‚ñ’²®€–Ú¡]]
	
	local fate = ai:GetRandam_Int(1,100)		--Šm—¦”»’è‚Åg—p‚·‚é‰^–½‚Ì”š
	local idMotion_Long			= 3304;		--’·‚ß‚Ì–‚–@”­“®“®ìB
	local idMotion_Short		= 3301;		--’Z‚ß‚Ì–‚–@”­“®“®ìB
	local RANDOM_LONG_SELECT	= 35;		--’·‚ß‚Ì–‚–@‚ğ‘I‚ÔŠ„‡B(100–¢–‚É‚·‚é–B)
	
	local rand_val = ai:GetRandam_Int( 0, 100);
	
	if ( Gokuri208002Battle_IsEnableFarAttack(ai, goal) ) then
	
		if ( rand_val < RANDOM_LONG_SELECT ) then
			Gokuri208002Battle_AddAttackGoal( ai, goal, 10.0, idMotion_Long, TARGET_ENE_0, DIST_None);
		else
			if fate <= 50 then
				goal:AddSubGoal( GOAL_COMMON_Wait, 2.0, TARGET_ENE_NONE, 0, 0, 0 );
				Gokuri208002Battle_AddAttackGoal( ai, goal, 10.0, idMotion_Short, TARGET_ENE_0, DIST_None);
			else
				Gokuri208002Battle_AddAttackGoal( ai, goal, 10.0, idMotion_Short, TARGET_ENE_0, DIST_None);
			end
		end

	else
		goal:AddSubGoal(GOAL_COMMON_Wait, 0.1, target);
	end
	
end
	
	
---------------------------------------------------------
--  ’†‹——£–CŒ‚B
---------------------------------------------------------
function Gokuri208002Battle_MiddleAttack(ai, goal)
	
	--ƒˆƒKƒtƒŒƒCƒ€I¨‹——£‚ª’Z‚¢UŒ‚‚¾‚Á‚½‚Ì‚ÅAcƒ€ƒ`‚É•ÏX
	Gokuri208002Battle_AddGuardbreakGoal( ai, goal, 10.0, 3001, TARGET_ENE_0, DIST_None);
end
	
	
---------------------------------------------------------
--  ‹ß‚¢‹——£UŒ‚B
---------------------------------------------------------
function Gokuri208002Battle_NearAttack(ai, goal)

	--[[¡Šé‰æ‚³‚ñ’²®€–Ú¡]]
	
	local idMotion_YOKO			= 3000;		--‰¡ƒ€ƒ`BƒKƒ`B
	local idMotion_TATE			= 3303;		--cƒ€ƒ`B¨”­‰Î–‚–@‚É•ÏX
	local idMotion_FIRE			= 3301;		--ƒtƒFƒCƒ“ƒg—pƒtƒ@ƒCƒ„[ƒ{ƒ‹ƒgB
	local RANDOM_YOKO_SELECT	= 30;		--‰¡ƒ€ƒ`‚ğ‘I‚ÔŠ„‡B(100–¢–‚É‚·‚é–B)
	local RANDOM_FIRE_SELECT	= (RANDOM_YOKO_SELECT+10);		--”­‰Î‚ğ‘I‚ÔŠ„‡(”š‚¾‚¯•Ï‚¦‚é)B
	
	--[[¡Šé‰æ‚³‚ñ’²®€–Ú¡]]

	local rate = ai:GetRandam_Int(1,100);

	--‹ß‹——£UŒ‚B
	--	”¼•ª‚ÌŠ„‡‚ÅAo‚µ•ª‚¯‚é‚¾‚¯B
	if ( rate<RANDOM_YOKO_SELECT ) then
		Gokuri208002Battle_AddGuardbreakGoal( ai, goal, 10.0, idMotion_YOKO, TARGET_ENE_0, DIST_None);
	elseif ( rate<RANDOM_FIRE_SELECT) then
		Gokuri208002Battle_AddAttackGoal( ai, goal, 10.0, idMotion_FIRE, TARGET_ENE_0, DIST_None);
	else
		Gokuri208002Battle_AddAttackGoal( ai, goal, 10.0, idMotion_TATE, TARGET_ENE_0, DIST_None);
	end

end

---------------------------------------------------------
--  ‰“‹——£–CŒ‚‚µ‚Ä‚¢‚¢‚©H
---------------------------------------------------------
function Gokuri208002Battle_IsEnableFarAttack(ai, goal)
	local idParam = ai:GetNpcThinkParamID();
	if 		(idParam==208003) then	CheckRegionID = 2165;
	elseif 	(idParam==208004) then	CheckRegionID = 2166;
	elseif 	(idParam==208005) then	CheckRegionID = 2167;
	else	CheckRegionID = -1
	end
	
	if ( false==ai:IsFinishTimer(0))	then return true; end
	if ( CheckRegionID==-1)				then return true; end
	
	return ai:IsInsideTargetRegion( TARGET_ENE_0, CheckRegionID);
end


--[[*****************************************************
	ƒS[ƒ‹XVEI—¹‚ÍA‚È‚µB
*******************************************************]]
function Gokuri208002Battle_Update(ai, goal)return GOAL_RESULT_Continue;end
function Gokuri208002Battle_Terminate(ai, goal)end


--[[*****************************************************
	Š„‚è‚İB
*******************************************************]]
function Gokuri208002Battle_Interupt(ai, goal)

	--ƒ_ƒ[ƒW‚ğó‚¯‚½‚çAˆê’èŠÔAËŒ‚§ŒÀ—Ìˆæ‚ğ–³‹‚·‚éB
	if ( ai:IsInterupt(INTERUPT_Damaged) or ai:IsInterupt(INTERUPT_Damaged_Stranger) ) then
		ai:SetTimer(0, 20);
	end

	return false; 
end


--[[*****************************************************
	UŒ‚ƒS[ƒ‹’Ç‰ÁB
*******************************************************]]
function Gokuri208002Battle_AddAttackGoal(ai, goal, life, EzStateID, target, typeDist)
	
	if ( ai:IsVisibleTarget(target) ) then
		--Œ©‚¦‚Ä‚¢‚ê‚Î•’Ê‚ÉUŒ‚B
		goal:AddSubGoal(GOAL_COMMON_ComboAttack, life, EzStateID, target, typeDist, 0);
	else
		--Œ©‚¦‚Ä‚¢‚È‚¯‚ê‚ÎA‚¿‚å‚Á‚Æ‘Ò‚Â‚ğ“ü‚ê‚éB
		goal:AddSubGoal(GOAL_COMMON_Wait, 0.1, target);
	end
	
end

--[[*****************************************************
	ƒK[ƒhƒuƒŒƒCƒNUŒ‚ƒS[ƒ‹’Ç‰ÁB
*******************************************************]]
function Gokuri208002Battle_AddGuardbreakGoal(ai, goal, life, EzStateID, target, typeDist)

	local fate = ai:GetRandam_Int(1,100)		--Šm—¦”»’è‚Åg—p‚·‚é‰^–½‚Ì”š
	
	if ( ai:IsVisibleTarget(target) ) then
		--Œ©‚¦‚Ä‚¢‚ê‚Î•’Ê‚ÉUŒ‚B
		goal:AddSubGoal(GOAL_COMMON_GuardBreakAttack, life, EzStateID, target, typeDist, 0);
        if fate <= 40 then
            goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3303, TARGET_ENE_0, DIST_Middle, 0);
        else
            goal:AddSubGoal(GOAL_COMMON_ComboAttack, 10.0, 3301, TARGET_ENE_0, DIST_Middle, 0);
        end 
	else
		--Œ©‚¦‚Ä‚¢‚È‚¯‚ê‚ÎA‚¿‚å‚Á‚Æ‘Ò‚Â‚ğ“ü‚ê‚éB
		goal:AddSubGoal(GOAL_COMMON_Wait, 0.1, target);
	end
	
end



	