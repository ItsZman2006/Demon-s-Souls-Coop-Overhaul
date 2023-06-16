
--------------------------------------------------------------------------------------
--ƒ}ƒbƒv“Η‚έ‚έ‚Ι“Η‚ά‚κ‚ι‰ϊ‰»—΅
--------------------------------------------------------------------------------------
function Initialize_m07_01_00_00(proxy)
print("Initialize_m07_01_00_00 begin");

--΅1΅•‚‚©‚Ργ‚ª‚ι‘«κA΅
	if proxy:IsCompleteEvent(1) ==false then
	--¥OBJ(1000)‚ª”j‰σ‚³‚κ‚½¥--
		proxy:OnObjectDestroy( 1, 1000, "OnEvent_1", once );
	else
		proxy:ReconstructBreak( 1000 , 1 );
	end
	
		
--΅11΅•‚‚©‚Ργ‚ª‚ι‘«κB΅
	if proxy:IsCompleteEvent(11) ==false then
	--¥OBJ(1001)‚ª”j‰σ‚³‚κ‚½¥--
		proxy:OnObjectDestroy( 11, 1001, "OnEvent_11", once );
		--proxy:OnPlayerDistanceInTarget( 11, 10000, 1006, "OnEvent_11", 3.0, once );
	else
		proxy:ReconstructBreak( 1001 , 1 );
	end


--΅12΅•‚‚©‚Ργ‚ª‚ι‘«κC΅
	if proxy:IsCompleteEvent(12) ==false then
	--¥ƒ‹ƒA[ƒR[ƒ‹¥--
		proxy:NotNetMessage_begin();
			proxy:LuaCall( 12, 1, "OnEvent_12", once );
		proxy:NotNetMessage_end();
	end
	
--[[ ƒIƒuƒWƒF(”ΰ)‚ª‚ά‚Ύ‚Θ‚Ά‚Μ‚ΕAƒRƒƒ“ƒgƒAƒEƒg

--΅120΅’†ƒ{ƒX•”‰®‚Φ‚Μ”ΰ‚ªJ‚­΅
	if proxy:IsCompleteEvent( 120 ) == false then
		proxy:OnDistanceActionPlus( 120, 10000, 1120, "OnEvent_120", DoorDist_A, HELPID_OPEN, 90, DoorAngle_A, -0.3, 0.0, 2.0, once );
	else
		proxy:EndAnimation( 1120, 1 );--”ΰ‚ªJ‚­ƒAƒjƒ‚πI—Ή
	end
]]	
	

--΅6656΅’†ƒ{ƒX€–S‚Ε‰½‚©‚ª‹N‚±‚ι΅
	--¥OBJ(812)‚ª€‚ΙA€–SƒAƒjƒ[ƒVƒ‡ƒ“‚ΰΔ¶‚µI‚ν‚Α‚½¥--
	if proxy:IsCompleteEvent(6656) ==false then
		proxy:OnCharacterDead( 6656, 812, "OnEvent_6656", once );
	else
		proxy:EndAnimation( 1004, 1 );--ƒ_ƒ~[ƒƒo[ƒAƒjƒ
	end

	
--•σ€‘Μ‚ΝƒCƒxƒ“ƒg”­“®‚Ι”zM‚µ‚Θ‚ΆBƒAƒjƒ‚Μ‚έ•Κ‚Ε“―ϊ‚³‚Ή‚ιB
proxy:NotNetMessage_begin();

--΅13568΅•σ€‘ΜA΅
	--¥PC‚ªƒ|ƒCƒ“ƒg(1005)‚Ι‘Ξ‚µ‚Δ”½‰p“x(ItemBoxAngle_A)A‹——£(ItemBoxDist_A)‚ΕƒAƒNƒVƒ‡ƒ“ƒ{ƒ^ƒ“‚π‰‚·¥--
	if proxy:IsCompleteEvent(13568) ==false then
		proxy:OnDistanceAction( 13568, 10000, 1005, "OnEvent_13568", ItemBoxDist_A, HELPID_CHECK_GLOWING_CORPS, 0, ItemBoxAngle_A, once );		
		proxy:TreasureDispModeChange( 1005, true );
	end
	
--΅13569΅•σ€‘ΜB΅
	--¥PC‚ªƒ|ƒCƒ“ƒg(1006)‚Ι‘Ξ‚µ‚Δ”½‰p“x(ItemBoxAngle_A)A‹——£(ItemBoxDist_A)‚ΕƒAƒNƒVƒ‡ƒ“ƒ{ƒ^ƒ“‚π‰‚·¥--
	if proxy:IsCompleteEvent(13569) ==false then
		proxy:OnDistanceAction( 13569, 10000, 1006, "OnEvent_13569", ItemBoxDist_A, HELPID_CHECK_GLOWING_CORPS, 0, ItemBoxAngle_A, once );		
		proxy:TreasureDispModeChange( 1006, true );
	end

proxy:NotNetMessage_end();
	
--΅20-32΅ƒm[ƒ}ƒ‹“•‘δ”j‰σ‚Εκ•”‚Μ“G‚ª©‚¦‚ι‚ζ‚¤‚Ι‚Θ‚ι΅
	
	first_action_id = 20;
	first_event_id  = 1007;
	dai_num         = 13;
	
	now_action_id   = first_action_id;
	now_event_id    = first_event_id;
	
	for i=1, dai_num, 1 do
		print( "add action_id " .. now_action_id );
		if proxy:IsCompleteEvent( now_action_id ) ==false then
			proxy:OnObjectDestroy( now_action_id, now_event_id, "OnEvent_"..now_action_id, once );
		else
			proxy:ReconstructBreak( now_event_id , 1 );
		end
		now_action_id = now_action_id + 1;
		now_event_id  = now_event_id  + 1;
	end
	
--΅40-104΅G‹›“I‚Μ€–SΔ‹΅

	enemy_num_of_dai        = 3;
	enemy_num_offset_of_dai = 2; 	--—\”υ
	dai_num                 = 13;
	enemy_num               = enemy_num_of_dai * dai_num;
	
	first_event_id          = 40;
	first_enemy_id          = 720;
	now_event_id            = first_event_id;
	now_enemy_id            = first_enemy_id;
	
	for i=1, dai_num, 1 do --ε†‘δ‚Μ”‚Ύ‚―J‚θ•Τ‚·
		for j=1, enemy_num_of_dai, 1 do --ε†‘δκ‚Β‚Ι‘Ξ‰‚·‚ι“G‚Μ”‚Ύ‚―J‚θ•Τ‚·
			print("add enemy_id is " .. now_enemy_id );
			
			--“Gκ•C•ª‚Μ€–SΔ‹ƒCƒxƒ“ƒg
			if proxy:IsCompleteEvent( now_event_id ) ==false then 
				proxy:OnCharacterDead( now_event_id, now_enemy_id, "OnEvent_"..now_event_id, once ); 
			end
			now_event_id = now_event_id + 1;
			now_enemy_id = now_enemy_id + 1;
		end
		now_event_id = now_event_id + enemy_num_offset_of_dai;
		now_enemy_id = now_enemy_id + enemy_num_offset_of_dai;
	end
	
	
--΅110΅Ξ’‚Ιƒ[ƒv΅
	proxy:OnDistanceAction( 110, 10000, 1982, "OnEvent_110", WarpGimmickDist_A, HELPID_GO_TO_SEKITYUU, 0, 180, everytime );
	
	
--΅??΅pjƒf[ƒ‚ƒ“‚Μ“oκ΅ƒnƒ“ƒhƒ‰“o^
	proxy:NotNetMessage_begin();
		--ƒvƒƒCƒ„[‚ªƒ\ƒ‚Ε€–S‚µ‚½‚ΙƒLƒbƒN‚³‚κ‚ά‚·B
		proxy:LuaCall( 4000, 100, "PlayerDeath_m07_01_00_00", everytime );
		--ƒvƒƒCƒ„[‚ª•‚µ‚½‚ΙƒLƒbƒN‚³‚κ‚ά‚·B
		proxy:LuaCall( 4032, 100, "PlayerRevive_m07_01_00_00", everytime );
	proxy:NotNetMessage_end();		

	
--΅‰ϊ‰»ƒ^ƒCƒ~ƒ“ƒO΅
	proxy:NotNetMessage_begin();
		--¥0•bγ¥--
		proxy:OnKeyTime2( 999991, "Second_Initialize_m07_01_00_00", 0.0, 0, 0, once );
	proxy:NotNetMessage_end();
	
print("Initialize_m07_01_00_00 end");
end


--------------------------------------------------------------------------------------
--ƒ}ƒ‹ƒ`‚Ι‚Θ‚Α‚½‚ΙƒzƒXƒg‚¶‚α–³‚©‚Α‚½‚η΅–³‚µ
--------------------------------------------------------------------------------------
function ConnectPartyEvent(proxy)
	print("ConnectPartyEvent begin");
	print("ConnectPartyEvent end");
end

--•`‰ζ‚Ζ“–‚½‚θ‚π“―‚ΙΨ‚θ‘Φ‚¦—p
function SetColiAndDraw( proxy, event_id, enable )
	print("SetColiAndDraw");
	proxy:SetColiEnable( event_id, enable );
	proxy:SetDrawEnable( event_id, enable );
end


--΅‰ϊ‰»ƒ^ƒCƒ~ƒ“ƒO΅
function Second_Initialize_m07_01_00_00(proxy, param)
	print( "Second_Initialize_m07_01_00_00 begin" );
	
	--¥ε†‘δ”j‰σ‚Ε•‚‚©‚Ργ‚ª‚ι‘«κA
	if proxy:IsCompleteEvent( 1 ) == false then
		SetColiAndDraw( proxy, 1002, false ); --‘«κA”ρ•\¦
	else
		SetColiAndDraw( proxy, 1002, true  ); --‘«κA•\¦
	--	proxy:ReconstructBreak( 1000 , 1 );
	end
	
	--¥ε†‘δ”j‰σ‚Ε•‚‚©‚Ργ‚ª‚ι‘«κB
	if proxy:IsCompleteEvent( 11 ) == false then
		SetColiAndDraw( proxy, 1003, false ); --‘«κB”ρ•\¦
	else
		SetColiAndDraw( proxy, 1003, true  ); --‘«κB•\¦
	--	proxy:ReconstructBreak( 1001 , 1 );	
	end
	
	--¥ε†‘δA‚Ζε†‘δB‚π”j‰σ‚Ε•‚‚©‚Ργ‚ª‚ι‘«κC
	if proxy:IsCompleteEvent( 12 ) == false then
		SetColiAndDraw( proxy, 1033, false ); --‘«κC”ρ•\¦
	else
		SetColiAndDraw( proxy, 1033, true  ); --‘«κC•\¦
	end
	
	
	--¥ƒm[ƒ}ƒ‹ε†‘δ”j‰σ‚Εκ•”‚Μ“G‚ª©‚¦‚ι‚ζ‚¤‚Ι‚Θ‚ιA`M
	local first_id_enemy  = 720;
	local first_id_shadow = first_id_enemy + 2300;
	local draw_num 		  = 3;
	local draw_num_offset = 2;--•\¦”‚Μ—\”υ
	local end_id_enemy    = first_id_enemy  + draw_num;
	local end_id_shadow   = first_id_shadow + draw_num;
	
	local first_id_dai    = 1007;
	local now_id_dai      = first_id_dai;
	local first_event_id  = 20;
	local dai_num         = 13;
--	local end_id_dai      = first_id_dai + dai_num;
	local end_event_id    = first_event_id + dai_num;
	
	--“G‚Ζ‰e‚Μ•\¦‚π‰ϊ‰»
	for k=first_event_id, end_event_id, 1 do		
	
		if proxy:IsCompleteEvent( k ) == false then
			for i=first_id_enemy , end_id_enemy -1, 1 do proxy:SetDrawEnable( i, false ); end --“G‚π”ρ•\¦
			for j=first_id_shadow, end_id_shadow-1, 1 do proxy:SetDrawEnable( j, true  ); end --‰e‚π•\¦
		else 
			for i=first_id_enemy , end_id_enemy -1, 1 do proxy:SetDrawEnable( i, true  ); end --“G‚π•\¦
			for j=first_id_shadow, end_id_shadow-1, 1 do proxy:SetDrawEnable( j, false ); end --‰e‚π”ρ•\¦
			
		--	proxy:ReconstructBreak( now_id_dai , 1 );
		end
		
		first_id_enemy  = first_id_enemy  + draw_num + draw_num_offset;
		first_id_shadow = first_id_shadow + draw_num + draw_num_offset;
		end_id_enemy    = first_id_enemy  + draw_num;
		end_id_shadow   = first_id_shadow + draw_num;
		
		now_id_dai = now_id_dai + 1;
	end

	--ε†‘δ‚Μ‰e‚Μ“―ϊ
	
	local first_event_id = 40;
	local end_event_id   = ( draw_num + draw_num_offset ) * dai_num + first_event_id;
		
	local first_id_shadow = 3020;
	local now_id_shadow   = first_id_shadow;
	
	for i=first_event_id, end_event_id-1, 1 do
		
		--‘Ξ‰‚·‚ι“G‚ª€‚ρ‚Ύ‚η‰e‚πΑ‚·B
		if proxy:IsCompleteEvent( i ) == true then
			proxy:SetDrawEnable( now_id_shadow , false );
		end
		
		now_id_shadow = now_id_shadow + 1;
	end
	
	
--[[
	--΅pjƒf[ƒ‚ƒ“—p (ƒtƒ‰ƒO‚Ν‰ΌAw’θ‚ª‚ ‚κ‚Ξ•Ο‚¦‚ι)
	if proxy:IsCompleteEvent( 20 ) == true then
		LuaFunc_VisibleTheWanderingDemon  (proxy, param, demon_id_list_m07_01_00_00);
	else
		LuaFunc_InvisibleTheWanderingDemon(proxy, param, demon_id_list_m07_01_00_00);
	end
]]	
	
	
	print( "Second_Initialize_m07_01_00_00 end" );
end


--------------------------------------------------------------------------------------
--•‚‚©‚Ργ‚ª‚ι‘«κA΅1
--------------------------------------------------------------------------------------
--΅1΅•‚‚©‚Ργ‚ª‚ι‘«κA΅
function OnEvent_1(proxy, param)
print("OnEvent_1 begin");

	SetColiAndDraw( proxy, 1002, true );

	--‚ΰ‚¤•Π•ϋ‚Με†‘δ‚ª‰σ‚κ‚Δ‚Ά‚½‚ηA—Ό•ϋ‰σ‚κ‚½‚Μ‚Ε‘«κCƒCƒxƒ“ƒg”­“®
	if proxy:IsCompleteEvent(11) ==true then
		proxy:LuaCallStart( 12, 1 );
	end
	
	proxy:SetEventFlag( 1, 1 );
	
	if param:IsNetMessage()==true  then
		--©•ª‚Μ‰ζ–Κ‚Ε”j‰σ‚³‚κ‚Δ‚Ά‚Δ‚ΰA•K‚Έ‘Ό‚ΜƒvƒƒCƒ„[‚Μ‰ζ–Κ‚Ε‰σ‚κ‚Δ‚Ά‚ι‚Ζ‚Νΐ‚η‚Θ‚ΆΧA‚±‚±‚Ε‰ό‚ί‚Δ”j‰σ‚·‚ι
		proxy:ChangeModel( 1000, 1 );
		proxy:SetBrokenPiece(1000);
	end
	
print("OnEvent_1 end");
end


--------------------------------------------------------------------------------------
--•‚‚©‚Ργ‚ª‚ι‘«κB΅11
--------------------------------------------------------------------------------------
--΅11΅•‚‚©‚Ργ‚ª‚ι‘«κB΅
function OnEvent_11(proxy, param)
	print("OnEvent_11 begin");

	SetColiAndDraw( proxy, 1003, true );
	
	--‚ΰ‚¤•Π•ϋ‚Με†‘δ‚ª‰σ‚κ‚Δ‚Ά‚½‚ηA—Ό•ϋ‰σ‚κ‚½‚Μ‚Ε‘«κCƒCƒxƒ“ƒg”­“®
	if proxy:IsCompleteEvent(1) ==true then
		proxy:LuaCallStart( 12, 1 );
	end
	
	proxy:SetEventFlag( 11, 1 );
	
	if param:IsNetMessage()==true  then
		--©•ª‚Μ‰ζ–Κ‚Ε”j‰σ‚³‚κ‚Δ‚Ά‚Δ‚ΰA•K‚Έ‘Ό‚ΜƒvƒƒCƒ„[‚Μ‰ζ–Κ‚Ε‰σ‚κ‚Δ‚Ά‚ι‚Ζ‚Νΐ‚η‚Θ‚ΆΧA‚±‚±‚Ε‰ό‚ί‚Δ”j‰σ‚·‚ι
		--proxy:ObjectDestroy(1001);
		proxy:ChangeModel( 1001, 1 );
		proxy:SetBrokenPiece(1001);
	end
	
	print("OnEvent_11 end");
end


--------------------------------------------------------------------------------------
--•‚‚©‚Ργ‚ª‚ι‘«κC΅12
--------------------------------------------------------------------------------------
--΅12΅•‚‚©‚Ργ‚ª‚ι‘«κC΅
function OnEvent_12(proxy, param)
	print("OnEvent_12 begin");
	
	SetColiAndDraw( proxy, 1033, true );
	proxy:SetEventFlag( 12, 1 );
	
	print("OnEvent_12 end");
end



--------------------------------------------------------------------------------------
--΅120΅’†ƒ{ƒX•”‰®‚Φ‚Μ”ΰ‚ªJ‚­΅
--------------------------------------------------------------------------------------
--΅120΅’†ƒ{ƒX•”‰®‚Φ‚Μ”ΰ‚ªJ‚­΅
function OnEvent_120(proxy, param)
	print("OnEvent_120 begin")
	
	proxy:PlayAnimation( 1120, 1 );
	
	proxy:NotNetMessage_begin();
		--¥120_2¥***π’Η‰Α***”ΰƒAƒjƒI—Ή¥
		proxy:OnCharacterAnimEnd( 120, 1120, 1, "OnEvent_120_2", once );
	proxy:NotNetMessage_end();
	
	--ƒvƒƒCƒ„[‚Μ“―ϊƒAƒjƒ[ƒVƒ‡ƒ“(true:ƒp[ƒeƒB[ƒvƒƒCƒ„[‚ªƒAƒjƒ[ƒVƒ‡ƒ“‚µ‚½)
	if Luafunc_PlaySynchroAnimation( proxy, param, ANIMEID_OPEN ) == true then 
		return;
	end
--[[	
	proxy:NotNetMessage_begin();
		--¥120_1¥***π’Η‰Α***ƒvƒƒCƒ„[ƒAƒjƒI—Ή¥
		proxy:OnChrAnimEnd( 120, 10000, ANIMEID_OPEN, "OnEvent_120_1", once );
	proxy:NotNetMessage_end();
]]		
--	proxy:Warp( 10000 , 2013 );		--ƒvƒƒCƒ„[‚π’θΚ’u‚Ιƒ[ƒv
--	proxy:DisableMove( 10000, 1 );	--ƒvƒƒCƒ„[‚π‘€μ•s”\‚Ι
	
	print("OnEvent_120 end")
end

--[[
--£120_1£ƒvƒƒCƒ„[ƒAƒjƒI—Ή£
function OnEvent_120_1(proxy, param)
	print("OnEvent_120_1 begin")
		
	proxy:DisableMove( 10000, 0 );	--ƒvƒƒCƒ„[‚π‘€μ‰Β”\‚Ι
	
	print("OnEvent_120_1 end")
end
]]

--£120_2£”ΰƒAƒjƒI—Ή£
function OnEvent_120_2(proxy, param)
	print("OnEvent_120_2 begin")
	
	--‚±‚±‚ΕAƒ|ƒ€Δ¶—\’θ
	
	proxy:SetEventFlag( 120 , 1 );
	
	print("OnEvent_120_2 end")
end


--------------------------------------------------------------------------------------
--’†ƒ{ƒX€–S‚Ε‰½‚©‚ª‹N‚±‚ι΅6656
--------------------------------------------------------------------------------------
--΅6656΅’†ƒ{ƒX€–S‚Ε‰½‚©‚ª‹N‚±‚ι΅
function OnEvent_6656(proxy, param)
	print("OnEvent_6656 begin");
	
	proxy:NotNetMessage_begin();
		--¥6656_1¥***π’Η‰Α***1•bγ¥
		proxy:OnKeyTime2( 6656, "OnEvent_6656_1", 1.0, 0, 0, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_6656 end");
end

--£6656_1£1•bγ£
function OnEvent_6656_1(proxy, param)
	print("OnEvent_6656_1 begin");
	
	proxy:SetEventFlag( 6656, 1);
	--ƒ_ƒ~[‚Εƒƒo[(ID:1004)‚ΜƒAƒjƒ(ID:1)‚πΔ¶
	proxy:PlayAnimation( 1004, 1 );
	
	print("OnEvent_6656_1 end");
end


--------------------------------------------------------------------------------------
--•σ€‘ΜA΅13568
--------------------------------------------------------------------------------------
--΅13568΅•σ€‘ΜA΅
function OnEvent_13568(proxy, param)
	print("OnEvent_13568 begin");
	
	--“―ϊƒAƒjƒ[ƒVƒ‡ƒ“—p‚ΜƒCƒxƒ“ƒg
	proxy:LuaCallStart( 4010 , 1 );
	
	proxy:NotNetMessage_begin();
		--¥13568_1¥***π’Η‰Α***•σ€‘ΜAƒAƒCƒeƒ€ζ“Ύ¥
		proxy:OnKeyTime2( 13568, "OnEvent_13568_1", 0.0, 0, 0, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_13568 end");
end

--£13568_1£•σ€‘ΜAƒAƒCƒeƒ€ζ“Ύ£
function OnEvent_13568_1(proxy, param)
	print("OnEvent_13568_1 begin");
	
	proxy:GetItem(10000, TYPE_WEAPON);			--ƒAƒCƒeƒ€“όθ
	proxy:SetEventFlag( 13568, 1 );				--ƒtƒ‰ƒO‚π—§‚Δ‚ι
	proxy:TreasureDispModeChange( 1005, false );--υ‚Α‚Δ‚ι‚Μ‚πΑ‚·
	
	print("OnEvent_13568_1 end");
end


--------------------------------------------------------------------------------------
--•σ€‘ΜB΅13569
--------------------------------------------------------------------------------------
--΅13569΅•σ€‘ΜB΅
function OnEvent_13569(proxy, param)
	print("OnEvent_13569 begin");
	
	--“―ϊƒAƒjƒ[ƒVƒ‡ƒ“—p‚ΜƒCƒxƒ“ƒg
	proxy:LuaCallStart( 4010 , 1 );
	
	proxy:NotNetMessage_begin();
		--¥13569_1¥***π’Η‰Α***•σ€‘ΜBƒAƒCƒeƒ€ζ“Ύ¥
		proxy:OnKeyTime2( 13569, "OnEvent_13569_1", 0.0, 0, 0, once );
	proxy:NotNetMessage_end();
	
	print("OnEvent_13569 end");
end

--£13569_1£•σ€‘ΜBƒAƒCƒeƒ€ζ“Ύ£
function OnEvent_13569_1(proxy, param)
	print("OnEvent_13569_1 begin");
	
	proxy:GetItem(10000, TYPE_WEAPON);			--ƒAƒCƒeƒ€“όθ
	proxy:SetEventFlag( 13569, 1 );				--ƒtƒ‰ƒO‚π—§‚Δ‚ι
	proxy:TreasureDispModeChange( 1006, false );--υ‚Α‚Δ‚ι‚Μ‚πΑ‚·
	
	print("OnEvent_13569_1 end");
end


--------------------------------------------------------------------------------------
--ƒm[ƒ}ƒ‹C‘δ”j‰σ‚Εκ•”‚Μ“G‚ª©‚¦‚ι‚ζ‚¤‚Ι‚Θ‚ιA΅20
--------------------------------------------------------------------------------------
--΅20΅ƒm[ƒ}ƒ‹C‘δ”j‰σ‚Εκ•”‚Μ“G‚ª©‚¦‚ι‚ζ‚¤‚Ι‚Θ‚ι΅
function OnEvent_20(proxy, param)
	print("OnEvent_20 begin");
	
	--¥•\¦‚ΜΨ‚θ‘Φ‚¦
	
	--“G‚π•\¦
	proxy:SetDrawEnable( 720 , true );
	proxy:SetDrawEnable( 721 , true );
	proxy:SetDrawEnable( 722 , true );
	
	--‰e‚π”ρ•\¦
	proxy:SetDrawEnable( 3020 , false );
	proxy:SetDrawEnable( 3021 , false );
	proxy:SetDrawEnable( 3022 , false );
	
	--ID‚Μƒ‹[ƒ‹‚ª–Ά’θ‚Θ‚Μ‚Ε‰Ό‘Ξ‰B΅‚Ν‘‚β‚³‚Θ‚Ά‚Ε‚­‚Ύ‚³‚ΆB
	--proxy:InvalidSfx(5);
	--proxy:InvalidSfx(1007);
	
	if param:IsNetMessage()==true  then
		--©•ª‚Μ‰ζ–Κ‚Ε”j‰σ‚³‚κ‚Δ‚Ά‚Δ‚ΰA•K‚Έ‘Ό‚ΜƒvƒƒCƒ„[‚Μ‰ζ–Κ‚Ε‰σ‚κ‚Δ‚Ά‚ι‚Ζ‚Νΐ‚η‚Θ‚ΆΧA‚±‚±‚Ε‰ό‚ί‚Δ”j‰σ‚·‚ι
		proxy:ChangeModel( 1007, 1 );
		proxy:SetBrokenPiece(1007);
	end
	
	proxy:SetEventFlag( 20, 1 );
	
	print("OnEvent_20 end");
end


--------------------------------------------------------------------------------------
--ƒm[ƒ}ƒ‹C‘δ”j‰σ‚Εκ•”‚Μ“G‚ª©‚¦‚ι‚ζ‚¤‚Ι‚Θ‚ιB΅21
--------------------------------------------------------------------------------------
--΅21΅ƒm[ƒ}ƒ‹C‘δ”j‰σ‚Εκ•”‚Μ“G‚ª©‚¦‚ι‚ζ‚¤‚Ι‚Θ‚ι΅
function OnEvent_21(proxy, param)
	print("OnEvent_21 begin");
	
	--¥•\¦‚ΜΨ‚θ‘Φ‚¦
	
	--“G‚π•\¦
	proxy:SetDrawEnable( 725 , true );
	proxy:SetDrawEnable( 726 , true );
	proxy:SetDrawEnable( 727 , true );
	
	--‰e‚π”ρ•\¦
	proxy:SetDrawEnable( 3025 , false );
	proxy:SetDrawEnable( 3026 , false );
	proxy:SetDrawEnable( 3027 , false );
	
	--ID‚Μƒ‹[ƒ‹‚ª–Ά’θ‚Θ‚Μ‚Ε‰Ό‘Ξ‰B΅‚Ν‘‚β‚³‚Θ‚Ά‚Ε‚­‚Ύ‚³‚ΆB
	--proxy:InvalidSfx(12);
	--proxy:InvalidSfx(1008);
	
	if param:IsNetMessage()==true  then
		--©•ª‚Μ‰ζ–Κ‚Ε”j‰σ‚³‚κ‚Δ‚Ά‚Δ‚ΰA•K‚Έ‘Ό‚ΜƒvƒƒCƒ„[‚Μ‰ζ–Κ‚Ε‰σ‚κ‚Δ‚Ά‚ι‚Ζ‚Νΐ‚η‚Θ‚ΆΧA‚±‚±‚Ε‰ό‚ί‚Δ”j‰σ‚·‚ι
		proxy:ChangeModel( 1008, 1 );
		proxy:SetBrokenPiece(1008);
	end
	
	proxy:SetEventFlag( 21, 1 );
	
	print("OnEvent_21 end");
end


--------------------------------------------------------------------------------------
--ƒm[ƒ}ƒ‹C‘δ”j‰σ‚Εκ•”‚Μ“G‚ª©‚¦‚ι‚ζ‚¤‚Ι‚Θ‚ιC΅22
--------------------------------------------------------------------------------------
--΅22΅ƒm[ƒ}ƒ‹C‘δ”j‰σ‚Εκ•”‚Μ“G‚ª©‚¦‚ι‚ζ‚¤‚Ι‚Θ‚ι΅
function OnEvent_22(proxy, param)
	print("OnEvent_22 begin");
	
	--¥•\¦‚ΜΨ‚θ‘Φ‚¦
	
	--“G‚π•\¦
	proxy:SetDrawEnable( 730 , true );
	proxy:SetDrawEnable( 731 , true );
	proxy:SetDrawEnable( 732 , true );
	
	--‰e‚π”ρ•\¦
	proxy:SetDrawEnable( 3030 , false );
	proxy:SetDrawEnable( 3031 , false );
	proxy:SetDrawEnable( 3032 , false );
	
	if param:IsNetMessage()==true  then
		--©•ª‚Μ‰ζ–Κ‚Ε”j‰σ‚³‚κ‚Δ‚Ά‚Δ‚ΰA•K‚Έ‘Ό‚ΜƒvƒƒCƒ„[‚Μ‰ζ–Κ‚Ε‰σ‚κ‚Δ‚Ά‚ι‚Ζ‚Νΐ‚η‚Θ‚ΆΧA‚±‚±‚Ε‰ό‚ί‚Δ”j‰σ‚·‚ι
		proxy:ChangeModel( 1009, 1 );
		proxy:SetBrokenPiece( 1009 );
	end
	
	proxy:SetEventFlag( 22, 1 );
	
	print("OnEvent_22 end");
end


--------------------------------------------------------------------------------------
--ƒm[ƒ}ƒ‹C‘δ”j‰σ‚Εκ•”‚Μ“G‚ª©‚¦‚ι‚ζ‚¤‚Ι‚Θ‚ιD΅23
--------------------------------------------------------------------------------------
--΅23΅ƒm[ƒ}ƒ‹C‘δ”j‰σ‚Εκ•”‚Μ“G‚ª©‚¦‚ι‚ζ‚¤‚Ι‚Θ‚ι΅
function OnEvent_23(proxy, param)
	print("OnEvent_23 begin");
	
	--¥•\¦‚ΜΨ‚θ‘Φ‚¦
	
	--“G‚π•\¦
	proxy:SetDrawEnable( 735 , true );
	proxy:SetDrawEnable( 736 , true );
	proxy:SetDrawEnable( 737 , true );
	
	--‰e‚π”ρ•\¦
	proxy:SetDrawEnable( 3035 , false );
	proxy:SetDrawEnable( 3036 , false );
	proxy:SetDrawEnable( 3037 , false );
	
	if param:IsNetMessage()==true  then
		--©•ª‚Μ‰ζ–Κ‚Ε”j‰σ‚³‚κ‚Δ‚Ά‚Δ‚ΰA•K‚Έ‘Ό‚ΜƒvƒƒCƒ„[‚Μ‰ζ–Κ‚Ε‰σ‚κ‚Δ‚Ά‚ι‚Ζ‚Νΐ‚η‚Θ‚ΆΧA‚±‚±‚Ε‰ό‚ί‚Δ”j‰σ‚·‚ι
		proxy:ChangeModel( 1010, 1 );
		proxy:SetBrokenPiece( 1010 );
	end
	
	proxy:SetEventFlag( 23, 1 );
	
	print("OnEvent_23 end");
end


--------------------------------------------------------------------------------------
--ƒm[ƒ}ƒ‹C‘δ”j‰σ‚Εκ•”‚Μ“G‚ª©‚¦‚ι‚ζ‚¤‚Ι‚Θ‚ιE΅24
--------------------------------------------------------------------------------------
--΅24΅ƒm[ƒ}ƒ‹C‘δ”j‰σ‚Εκ•”‚Μ“G‚ª©‚¦‚ι‚ζ‚¤‚Ι‚Θ‚ι΅
function OnEvent_24(proxy, param)
	print("OnEvent_24 begin");
	
	--¥•\¦‚ΜΨ‚θ‘Φ‚¦
	
	--“G‚π•\¦
	proxy:SetDrawEnable( 740 , true );
	proxy:SetDrawEnable( 741 , true );
	proxy:SetDrawEnable( 742 , true );
	
	--‰e‚π”ρ•\¦
	proxy:SetDrawEnable( 3040 , false );
	proxy:SetDrawEnable( 3041 , false );
	proxy:SetDrawEnable( 3042 , false );
	
	if param:IsNetMessage()==true  then
		--©•ª‚Μ‰ζ–Κ‚Ε”j‰σ‚³‚κ‚Δ‚Ά‚Δ‚ΰA•K‚Έ‘Ό‚ΜƒvƒƒCƒ„[‚Μ‰ζ–Κ‚Ε‰σ‚κ‚Δ‚Ά‚ι‚Ζ‚Νΐ‚η‚Θ‚ΆΧA‚±‚±‚Ε‰ό‚ί‚Δ”j‰σ‚·‚ι
		proxy:ChangeModel( 1011, 1 );
		proxy:SetBrokenPiece(1011);
	end
	
	proxy:SetEventFlag( 24, 1 );
	
	print("OnEvent_24 end");
end


--------------------------------------------------------------------------------------
--ƒm[ƒ}ƒ‹C‘δ”j‰σ‚Εκ•”‚Μ“G‚ª©‚¦‚ι‚ζ‚¤‚Ι‚Θ‚ιF΅25
--------------------------------------------------------------------------------------
--΅25΅ƒm[ƒ}ƒ‹C‘δ”j‰σ‚Εκ•”‚Μ“G‚ª©‚¦‚ι‚ζ‚¤‚Ι‚Θ‚ι΅
function OnEvent_25(proxy, param)
	print("OnEvent_25 begin");
	
	--¥•\¦‚ΜΨ‚θ‘Φ‚¦
	
	--“G‚π•\¦
	proxy:SetDrawEnable( 745 , true );
	proxy:SetDrawEnable( 746 , true );
	proxy:SetDrawEnable( 747 , true );
	
	--‰e‚π”ρ•\¦
	proxy:SetDrawEnable( 3045 , false );
	proxy:SetDrawEnable( 3046 , false );
	proxy:SetDrawEnable( 3047 , false );
	
	if param:IsNetMessage()==true  then
		--©•ª‚Μ‰ζ–Κ‚Ε”j‰σ‚³‚κ‚Δ‚Ά‚Δ‚ΰA•K‚Έ‘Ό‚ΜƒvƒƒCƒ„[‚Μ‰ζ–Κ‚Ε‰σ‚κ‚Δ‚Ά‚ι‚Ζ‚Νΐ‚η‚Θ‚ΆΧA‚±‚±‚Ε‰ό‚ί‚Δ”j‰σ‚·‚ι
		proxy:ChangeModel( 1012, 1 );
		proxy:SetBrokenPiece(1012);
	end
	
	proxy:SetEventFlag( 25, 1 );
	
	print("OnEvent_25 end");
end


--------------------------------------------------------------------------------------
--ƒm[ƒ}ƒ‹C‘δ”j‰σ‚Εκ•”‚Μ“G‚ª©‚¦‚ι‚ζ‚¤‚Ι‚Θ‚ιG΅26
--------------------------------------------------------------------------------------
--΅26΅ƒm[ƒ}ƒ‹C‘δ”j‰σ‚Εκ•”‚Μ“G‚ª©‚¦‚ι‚ζ‚¤‚Ι‚Θ‚ι΅
function OnEvent_26(proxy, param)
	print("OnEvent_26 begin");
	
	--¥•\¦‚ΜΨ‚θ‘Φ‚¦
	
	--“G‚π•\¦
	proxy:SetDrawEnable( 750 , true );
	proxy:SetDrawEnable( 751 , true );
	proxy:SetDrawEnable( 752 , true );
	
	--‰e‚π”ρ•\¦
	proxy:SetDrawEnable( 3050 , false );
	proxy:SetDrawEnable( 3051 , false );
	proxy:SetDrawEnable( 3052 , false );
	
	if param:IsNetMessage()==true  then
		--©•ª‚Μ‰ζ–Κ‚Ε”j‰σ‚³‚κ‚Δ‚Ά‚Δ‚ΰA•K‚Έ‘Ό‚ΜƒvƒƒCƒ„[‚Μ‰ζ–Κ‚Ε‰σ‚κ‚Δ‚Ά‚ι‚Ζ‚Νΐ‚η‚Θ‚ΆΧA‚±‚±‚Ε‰ό‚ί‚Δ”j‰σ‚·‚ι
		proxy:ChangeModel( 1013, 1 );
		proxy:SetBrokenPiece(1013);
	end
	
	proxy:SetEventFlag( 26, 1 );
	
	print("OnEvent_26 end");
end


--------------------------------------------------------------------------------------
--ƒm[ƒ}ƒ‹C‘δ”j‰σ‚Εκ•”‚Μ“G‚ª©‚¦‚ι‚ζ‚¤‚Ι‚Θ‚ιH΅27
--------------------------------------------------------------------------------------
--΅27΅ƒm[ƒ}ƒ‹C‘δ”j‰σ‚Εκ•”‚Μ“G‚ª©‚¦‚ι‚ζ‚¤‚Ι‚Θ‚ι΅
function OnEvent_27(proxy, param)
	print("OnEvent_27 begin");
	
	--¥•\¦‚ΜΨ‚θ‘Φ‚¦
	
	--“G‚π•\¦
	proxy:SetDrawEnable( 755 , true );
	proxy:SetDrawEnable( 756 , true );
	proxy:SetDrawEnable( 757 , true );
	
	--‰e‚π”ρ•\¦
	proxy:SetDrawEnable( 3055 , false );
	proxy:SetDrawEnable( 3056 , false );
	proxy:SetDrawEnable( 3057 , false );
	
	if param:IsNetMessage()==true  then
		--©•ª‚Μ‰ζ–Κ‚Ε”j‰σ‚³‚κ‚Δ‚Ά‚Δ‚ΰA•K‚Έ‘Ό‚ΜƒvƒƒCƒ„[‚Μ‰ζ–Κ‚Ε‰σ‚κ‚Δ‚Ά‚ι‚Ζ‚Νΐ‚η‚Θ‚ΆΧA‚±‚±‚Ε‰ό‚ί‚Δ”j‰σ‚·‚ι
		proxy:ChangeModel( 1014, 1 );
		proxy:SetBrokenPiece(1014);
	end
	
	proxy:SetEventFlag( 27, 1 );
	
	print("OnEvent_27 end");
end


--------------------------------------------------------------------------------------
--ƒm[ƒ}ƒ‹C‘δ”j‰σ‚Εκ•”‚Μ“G‚ª©‚¦‚ι‚ζ‚¤‚Ι‚Θ‚ιI΅28
--------------------------------------------------------------------------------------
--΅28΅ƒm[ƒ}ƒ‹C‘δ”j‰σ‚Εκ•”‚Μ“G‚ª©‚¦‚ι‚ζ‚¤‚Ι‚Θ‚ι΅
function OnEvent_28(proxy, param)
	print("OnEvent_28 begin");
	
	--¥•\¦‚ΜΨ‚θ‘Φ‚¦
	
	--“G‚π•\¦
	proxy:SetDrawEnable( 760 , true );
	proxy:SetDrawEnable( 761 , true );
	proxy:SetDrawEnable( 762 , true );
	
	--‰e‚π”ρ•\¦
	proxy:SetDrawEnable( 3060 , false );
	proxy:SetDrawEnable( 3061 , false );
	proxy:SetDrawEnable( 3062 , false );
	
	if param:IsNetMessage()==true  then
		--©•ª‚Μ‰ζ–Κ‚Ε”j‰σ‚³‚κ‚Δ‚Ά‚Δ‚ΰA•K‚Έ‘Ό‚ΜƒvƒƒCƒ„[‚Μ‰ζ–Κ‚Ε‰σ‚κ‚Δ‚Ά‚ι‚Ζ‚Νΐ‚η‚Θ‚ΆΧA‚±‚±‚Ε‰ό‚ί‚Δ”j‰σ‚·‚ι
		proxy:ChangeModel( 1015, 1 );
		proxy:SetBrokenPiece(1015);
	end
	
	proxy:SetEventFlag( 28, 1 );
	
	print("OnEvent_28 end");
end


--------------------------------------------------------------------------------------
--ƒm[ƒ}ƒ‹C‘δ”j‰σ‚Εκ•”‚Μ“G‚ª©‚¦‚ι‚ζ‚¤‚Ι‚Θ‚ιJ΅29
--------------------------------------------------------------------------------------
--΅29΅ƒm[ƒ}ƒ‹C‘δ”j‰σ‚Εκ•”‚Μ“G‚ª©‚¦‚ι‚ζ‚¤‚Ι‚Θ‚ι΅
function OnEvent_29(proxy, param)
	print("OnEvent_29 begin");
	
	--¥•\¦‚ΜΨ‚θ‘Φ‚¦
	
	--“G‚π•\¦
	proxy:SetDrawEnable( 765 , true );
	proxy:SetDrawEnable( 766 , true );
	proxy:SetDrawEnable( 767 , true );
	
	--‰e‚π”ρ•\¦
	proxy:SetDrawEnable( 3065 , false );
	proxy:SetDrawEnable( 3066 , false );
	proxy:SetDrawEnable( 3067 , false );
	
	if param:IsNetMessage()==true  then
		--©•ª‚Μ‰ζ–Κ‚Ε”j‰σ‚³‚κ‚Δ‚Ά‚Δ‚ΰA•K‚Έ‘Ό‚ΜƒvƒƒCƒ„[‚Μ‰ζ–Κ‚Ε‰σ‚κ‚Δ‚Ά‚ι‚Ζ‚Νΐ‚η‚Θ‚ΆΧA‚±‚±‚Ε‰ό‚ί‚Δ”j‰σ‚·‚ι
		proxy:ChangeModel( 1016, 1 );
		proxy:SetBrokenPiece(1016);
	end
	
	proxy:SetEventFlag( 29, 1 );
	
	print("OnEvent_29 end");
end


--------------------------------------------------------------------------------------
--ƒm[ƒ}ƒ‹C‘δ”j‰σ‚Εκ•”‚Μ“G‚ª©‚¦‚ι‚ζ‚¤‚Ι‚Θ‚ιK΅30
--------------------------------------------------------------------------------------
--΅30΅ƒm[ƒ}ƒ‹C‘δ”j‰σ‚Εκ•”‚Μ“G‚ª©‚¦‚ι‚ζ‚¤‚Ι‚Θ‚ι΅
function OnEvent_30(proxy, param)
	print("OnEvent_30 begin");
	
	--¥•\¦‚ΜΨ‚θ‘Φ‚¦
	
	--“G‚π•\¦
	proxy:SetDrawEnable( 770 , true );
	proxy:SetDrawEnable( 771 , true );
	proxy:SetDrawEnable( 772 , true );
	
	--‰e‚π”ρ•\¦
	proxy:SetDrawEnable( 3070 , false );
	proxy:SetDrawEnable( 3071 , false );
	proxy:SetDrawEnable( 3072 , false );
	
	if param:IsNetMessage()==true  then
		--©•ª‚Μ‰ζ–Κ‚Ε”j‰σ‚³‚κ‚Δ‚Ά‚Δ‚ΰA•K‚Έ‘Ό‚ΜƒvƒƒCƒ„[‚Μ‰ζ–Κ‚Ε‰σ‚κ‚Δ‚Ά‚ι‚Ζ‚Νΐ‚η‚Θ‚ΆΧA‚±‚±‚Ε‰ό‚ί‚Δ”j‰σ‚·‚ι
		proxy:ChangeModel( 1017, 1 );
		proxy:SetBrokenPiece(1017);
	end
	
	proxy:SetEventFlag( 30, 1 );
	
	print("OnEvent_30 end");
end


--------------------------------------------------------------------------------------
--ƒm[ƒ}ƒ‹C‘δ”j‰σ‚Εκ•”‚Μ“G‚ª©‚¦‚ι‚ζ‚¤‚Ι‚Θ‚ιL΅31
--------------------------------------------------------------------------------------
--΅31΅ƒm[ƒ}ƒ‹C‘δ”j‰σ‚Εκ•”‚Μ“G‚ª©‚¦‚ι‚ζ‚¤‚Ι‚Θ‚ι΅
function OnEvent_31(proxy, param)
	print("OnEvent_31 begin");
	
	--¥•\¦‚ΜΨ‚θ‘Φ‚¦
	
	--“G‚π•\¦
	proxy:SetDrawEnable( 775 , true );
	proxy:SetDrawEnable( 776 , true );
	proxy:SetDrawEnable( 777 , true );
	
	--‰e‚π”ρ•\¦
	proxy:SetDrawEnable( 3075 , false );
	proxy:SetDrawEnable( 3076 , false );
	proxy:SetDrawEnable( 3077 , false );
	
	if param:IsNetMessage()==true  then
		--©•ª‚Μ‰ζ–Κ‚Ε”j‰σ‚³‚κ‚Δ‚Ά‚Δ‚ΰA•K‚Έ‘Ό‚ΜƒvƒƒCƒ„[‚Μ‰ζ–Κ‚Ε‰σ‚κ‚Δ‚Ά‚ι‚Ζ‚Νΐ‚η‚Θ‚ΆΧA‚±‚±‚Ε‰ό‚ί‚Δ”j‰σ‚·‚ι
		proxy:ChangeModel( 1018, 1 );
		proxy:SetBrokenPiece(1018);
	end
	
	proxy:SetEventFlag( 31, 1 );
	
	print("OnEvent_31 end");
end


--------------------------------------------------------------------------------------
--ƒm[ƒ}ƒ‹C‘δ”j‰σ‚Εκ•”‚Μ“G‚ª©‚¦‚ι‚ζ‚¤‚Ι‚Θ‚ιM΅32
--------------------------------------------------------------------------------------
--΅32΅ƒm[ƒ}ƒ‹C‘δ”j‰σ‚Εκ•”‚Μ“G‚ª©‚¦‚ι‚ζ‚¤‚Ι‚Θ‚ι΅
function OnEvent_32(proxy, param)
	print("OnEvent_32 begin");
	
	--¥•\¦‚ΜΨ‚θ‘Φ‚¦
	
	--“G‚π•\¦
	proxy:SetDrawEnable( 780 , true );
	proxy:SetDrawEnable( 781 , true );
	proxy:SetDrawEnable( 782 , true );
	
	--‰e‚π”ρ•\¦
	proxy:SetDrawEnable( 3080 , false );
	proxy:SetDrawEnable( 3081 , false );
	proxy:SetDrawEnable( 3082 , false );
	
	if param:IsNetMessage()==true  then
		--©•ª‚Μ‰ζ–Κ‚Ε”j‰σ‚³‚κ‚Δ‚Ά‚Δ‚ΰA•K‚Έ‘Ό‚ΜƒvƒƒCƒ„[‚Μ‰ζ–Κ‚Ε‰σ‚κ‚Δ‚Ά‚ι‚Ζ‚Νΐ‚η‚Θ‚ΆΧA‚±‚±‚Ε‰ό‚ί‚Δ”j‰σ‚·‚ι
		proxy:ChangeModel( 1019, 1 );
		proxy:SetBrokenPiece(1019);
	end
	
	proxy:SetEventFlag( 32, 1 );
	
	print("OnEvent_32 end");
end

--------------------------------------------------------------------------------------
--ƒUƒR“G‚Μ€–SΔ‹΅40
--------------------------------------------------------------------------------------
--΅40΅ƒUƒR“G‚Μ€–SΔ‹΅
function OnEvent_40(proxy, param)
	print("OnEvent_40 begin");
	
	proxy:SetDrawEnable( 3020 , false );
	proxy:SetEventFlag( 40, 1 );
	
	print("OnEvent_40 end");
end

--------------------------------------------------------------------------------------
--ƒUƒR“G‚Μ€–SΔ‹΅41
--------------------------------------------------------------------------------------
--΅41΅ƒUƒR“G‚Μ€–SΔ‹΅
function OnEvent_41(proxy, param)
	print("OnEvent_41 begin");
	
	proxy:SetDrawEnable( 3021 , false );
	proxy:SetEventFlag( 41, 1 );
	
	print("OnEvent_41 end");
end

--------------------------------------------------------------------------------------
--ƒUƒR“G‚Μ€–SΔ‹΅42
--------------------------------------------------------------------------------------
--΅42΅ƒUƒR“G‚Μ€–SΔ‹΅
function OnEvent_42(proxy, param)
	print("OnEvent_42 begin");
	
	proxy:SetDrawEnable( 3022 , false );
	proxy:SetEventFlag( 42, 1 );
	
	print("OnEvent_42 end");
end

--------------------------------------------------------------------------------------
--ƒUƒR“G‚Μ€–SΔ‹΅43
--------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------
--ƒUƒR“G‚Μ€–SΔ‹΅44
--------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------
--ƒUƒR“G‚Μ€–SΔ‹΅45
--------------------------------------------------------------------------------------
--΅45΅ƒUƒR“G‚Μ€–SΔ‹΅
function OnEvent_45(proxy, param)
	print("OnEvent_45 begin");
	
	proxy:SetDrawEnable( 3025 , false );
	proxy:SetEventFlag( 45, 1 );
	
	print("OnEvent_45 end");
end

--------------------------------------------------------------------------------------
--ƒUƒR“G‚Μ€–SΔ‹΅46
--------------------------------------------------------------------------------------
--΅46΅ƒUƒR“G‚Μ€–SΔ‹΅
function OnEvent_46(proxy, param)
	print("OnEvent_46 begin");
	
	proxy:SetDrawEnable( 3026 , false );
	proxy:SetEventFlag( 46, 1 );
	
	print("OnEvent_46 end");
end

--------------------------------------------------------------------------------------
--ƒUƒR“G‚Μ€–SΔ‹΅47
--------------------------------------------------------------------------------------
--΅47΅ƒUƒR“G‚Μ€–SΔ‹΅
function OnEvent_47(proxy, param)
	print("OnEvent_47 begin");
	
	proxy:SetDrawEnable( 3027 , false );
	proxy:SetEventFlag( 47, 1 );
	
	print("OnEvent_47 end");
end

--------------------------------------------------------------------------------------
--ƒUƒR“G‚Μ€–SΔ‹΅48
--------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------
--ƒUƒR“G‚Μ€–SΔ‹΅49
--------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------
--ƒUƒR“G‚Μ€–SΔ‹΅50
--------------------------------------------------------------------------------------
--΅50΅ƒUƒR“G‚Μ€–SΔ‹΅
function OnEvent_50(proxy, param)
	print("OnEvent_50 begin");
	
	proxy:SetDrawEnable( 3030 , false );
	proxy:SetEventFlag( 50, 1 );
	
	print("OnEvent_50 end");
end

--------------------------------------------------------------------------------------
--ƒUƒR“G‚Μ€–SΔ‹΅51
--------------------------------------------------------------------------------------
--΅51΅ƒUƒR“G‚Μ€–SΔ‹΅
function OnEvent_51(proxy, param)
	print("OnEvent_51 begin");
	
	proxy:SetDrawEnable( 3031 , false );
	proxy:SetEventFlag( 51, 1 );
	
	print("OnEvent_51 end");
end

--------------------------------------------------------------------------------------
--ƒUƒR“G‚Μ€–SΔ‹΅52
--------------------------------------------------------------------------------------
--΅52΅ƒUƒR“G‚Μ€–SΔ‹΅
function OnEvent_52(proxy, param)
	print("OnEvent_52 begin");
	
	proxy:SetDrawEnable( 3032 , false );
	proxy:SetEventFlag( 52, 1 );
	
	print("OnEvent_52 end");
end

--------------------------------------------------------------------------------------
--ƒUƒR“G‚Μ€–SΔ‹΅53
--------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------
--ƒUƒR“G‚Μ€–SΔ‹΅54
--------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------
--ƒUƒR“G‚Μ€–SΔ‹΅55
--------------------------------------------------------------------------------------
--΅55΅ƒUƒR“G‚Μ€–SΔ‹΅
function OnEvent_55(proxy, param)
	print("OnEvent_55 begin");
	
	proxy:SetDrawEnable( 3035 , false );
	proxy:SetEventFlag( 55, 1 );
	
	print("OnEvent_55 end");
end

--------------------------------------------------------------------------------------
--ƒUƒR“G‚Μ€–SΔ‹΅56
--------------------------------------------------------------------------------------
--΅56΅ƒUƒR“G‚Μ€–SΔ‹΅
function OnEvent_56(proxy, param)
	print("OnEvent_56 begin");
	
	proxy:SetDrawEnable( 3036 , false );
	proxy:SetEventFlag( 56, 1 );
	
	print("OnEvent_56 end");
end

--------------------------------------------------------------------------------------
--ƒUƒR“G‚Μ€–SΔ‹΅57
--------------------------------------------------------------------------------------
--΅57΅ƒUƒR“G‚Μ€–SΔ‹΅
function OnEvent_57(proxy, param)
	print("OnEvent_57 begin");
	
	proxy:SetDrawEnable( 3037 , false );
	proxy:SetEventFlag( 57, 1 );
	
	print("OnEvent_57 end");
end

--------------------------------------------------------------------------------------
--ƒUƒR“G‚Μ€–SΔ‹΅58
--------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------
--ƒUƒR“G‚Μ€–SΔ‹΅59
--------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------
--ƒUƒR“G‚Μ€–SΔ‹΅60
--------------------------------------------------------------------------------------
--΅60΅ƒUƒR“G‚Μ€–SΔ‹΅
function OnEvent_60(proxy, param)
	print("OnEvent_60 begin");
	
	proxy:SetDrawEnable( 3040 , false );
	proxy:SetEventFlag( 60, 1 );
	
	print("OnEvent_60 end");
end

--------------------------------------------------------------------------------------
--ƒUƒR“G‚Μ€–SΔ‹΅61
--------------------------------------------------------------------------------------
--΅61΅ƒUƒR“G‚Μ€–SΔ‹΅
function OnEvent_61(proxy, param)
	print("OnEvent_61 begin");
	
	proxy:SetDrawEnable( 3041 , false );
	proxy:SetEventFlag( 61, 1 );
	
	print("OnEvent_61 end");
end

--------------------------------------------------------------------------------------
--ƒUƒR“G‚Μ€–SΔ‹΅62
--------------------------------------------------------------------------------------
--΅62΅ƒUƒR“G‚Μ€–SΔ‹΅
function OnEvent_62(proxy, param)
	print("OnEvent_62 begin");
	
	proxy:SetDrawEnable( 3042 , false );
	proxy:SetEventFlag( 62, 1 );
	
	print("OnEvent_62 end");
end

--------------------------------------------------------------------------------------
--ƒUƒR“G‚Μ€–SΔ‹΅63
--------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------
--ƒUƒR“G‚Μ€–SΔ‹΅64
--------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------
--ƒUƒR“G‚Μ€–SΔ‹΅65
--------------------------------------------------------------------------------------
--΅65΅ƒUƒR“G‚Μ€–SΔ‹΅
function OnEvent_65(proxy, param)
	print("OnEvent_65 begin");
	
	proxy:SetDrawEnable( 3045 , false );
	proxy:SetEventFlag( 65, 1 );
	
	print("OnEvent_65 end");
end

--------------------------------------------------------------------------------------
--ƒUƒR“G‚Μ€–SΔ‹΅66
--------------------------------------------------------------------------------------
--΅66΅ƒUƒR“G‚Μ€–SΔ‹΅
function OnEvent_66(proxy, param)
	print("OnEvent_66 begin");
	
	proxy:SetDrawEnable( 3046 , false );
	proxy:SetEventFlag( 66, 1 );
	
	print("OnEvent_66 end");
end

--------------------------------------------------------------------------------------
--ƒUƒR“G‚Μ€–SΔ‹΅67
--------------------------------------------------------------------------------------
--΅67΅ƒUƒR“G‚Μ€–SΔ‹΅
function OnEvent_67(proxy, param)
	print("OnEvent_67 begin");
	
	proxy:SetDrawEnable( 3047 , false );
	proxy:SetEventFlag( 67, 1 );
	
	print("OnEvent_67 end");
end

--------------------------------------------------------------------------------------
--ƒUƒR“G‚Μ€–SΔ‹΅68
--------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------
--ƒUƒR“G‚Μ€–SΔ‹΅69
--------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------
--ƒUƒR“G‚Μ€–SΔ‹΅70
--------------------------------------------------------------------------------------
--΅70΅ƒUƒR“G‚Μ€–SΔ‹΅
function OnEvent_70(proxy, param)
	print("OnEvent_70 begin");
	
	proxy:SetDrawEnable( 3050 , false );
	proxy:SetEventFlag( 70, 1 );
	
	print("OnEvent_70 end");
end

--------------------------------------------------------------------------------------
--ƒUƒR“G‚Μ€–SΔ‹΅71
--------------------------------------------------------------------------------------
--΅71΅ƒUƒR“G‚Μ€–SΔ‹΅
function OnEvent_71(proxy, param)
	print("OnEvent_71 begin");
	
	proxy:SetDrawEnable( 3051 , false );
	proxy:SetEventFlag( 71, 1 );
	
	print("OnEvent_71 end");
end

--------------------------------------------------------------------------------------
--ƒUƒR“G‚Μ€–SΔ‹΅72
--------------------------------------------------------------------------------------
--΅72΅ƒUƒR“G‚Μ€–SΔ‹΅
function OnEvent_72(proxy, param)
	print("OnEvent_72 begin");
	
	proxy:SetDrawEnable( 3052 , false );
	proxy:SetEventFlag( 72, 1 );
	
	print("OnEvent_72 end");
end

--------------------------------------------------------------------------------------
--ƒUƒR“G‚Μ€–SΔ‹΅73
--------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------
--ƒUƒR“G‚Μ€–SΔ‹΅74
--------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------
--ƒUƒR“G‚Μ€–SΔ‹΅75
--------------------------------------------------------------------------------------
--΅75΅ƒUƒR“G‚Μ€–SΔ‹΅
function OnEvent_75(proxy, param)
	print("OnEvent_75 begin");
	
	proxy:SetDrawEnable( 3055 , false );
	proxy:SetEventFlag( 75, 1 );
	
	print("OnEvent_75 end");
end

--------------------------------------------------------------------------------------
--ƒUƒR“G‚Μ€–SΔ‹΅76
--------------------------------------------------------------------------------------
--΅76΅ƒUƒR“G‚Μ€–SΔ‹΅
function OnEvent_76(proxy, param)
	print("OnEvent_76 begin");
	
	proxy:SetDrawEnable( 3056 , false );
	proxy:SetEventFlag( 76, 1 );
	
	print("OnEvent_76 end");
end

--------------------------------------------------------------------------------------
--ƒUƒR“G‚Μ€–SΔ‹΅77
--------------------------------------------------------------------------------------
--΅77΅ƒUƒR“G‚Μ€–SΔ‹΅
function OnEvent_77(proxy, param)
	print("OnEvent_77 begin");
	
	proxy:SetDrawEnable( 3057 , false );
	proxy:SetEventFlag( 77, 1 );
	
	print("OnEvent_77 end");
end

--------------------------------------------------------------------------------------
--ƒUƒR“G‚Μ€–SΔ‹΅78
--------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------
--ƒUƒR“G‚Μ€–SΔ‹΅79
--------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------
--ƒUƒR“G‚Μ€–SΔ‹΅80
--------------------------------------------------------------------------------------
--΅80΅ƒUƒR“G‚Μ€–SΔ‹΅
function OnEvent_80(proxy, param)
	print("OnEvent_80 begin");
	
	proxy:SetDrawEnable( 3060 , false );
	proxy:SetEventFlag( 80, 1 );
	
	print("OnEvent_80 end");
end

--------------------------------------------------------------------------------------
--ƒUƒR“G‚Μ€–SΔ‹΅81
--------------------------------------------------------------------------------------
--΅81΅ƒUƒR“G‚Μ€–SΔ‹΅
function OnEvent_81(proxy, param)
	print("OnEvent_81 begin");
	
	proxy:SetDrawEnable( 3061 , false );
	proxy:SetEventFlag( 81, 1 );
	
	print("OnEvent_81 end");
end

--------------------------------------------------------------------------------------
--ƒUƒR“G‚Μ€–SΔ‹΅82
--------------------------------------------------------------------------------------
--΅82΅ƒUƒR“G‚Μ€–SΔ‹΅
function OnEvent_82(proxy, param)
	print("OnEvent_82 begin");
	
	proxy:SetDrawEnable( 3062 , false );
	proxy:SetEventFlag( 82, 1 );
	
	print("OnEvent_82 end");
end

--------------------------------------------------------------------------------------
--ƒUƒR“G‚Μ€–SΔ‹΅83
--------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------
--ƒUƒR“G‚Μ€–SΔ‹΅84
--------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------
--ƒUƒR“G‚Μ€–SΔ‹΅85
--------------------------------------------------------------------------------------
--΅85΅ƒUƒR“G‚Μ€–SΔ‹΅
function OnEvent_85(proxy, param)
	print("OnEvent_85 begin");
	
	proxy:SetDrawEnable( 3065 , false );
	proxy:SetEventFlag( 85, 1 );
	
	print("OnEvent_85 end");
end

--------------------------------------------------------------------------------------
--ƒUƒR“G‚Μ€–SΔ‹΅86
--------------------------------------------------------------------------------------
--΅86΅ƒUƒR“G‚Μ€–SΔ‹΅
function OnEvent_86(proxy, param)
	print("OnEvent_86 begin");
	
	proxy:SetDrawEnable( 3066 , false );
	proxy:SetEventFlag( 86, 1 );
	
	print("OnEvent_86 end");
end

--------------------------------------------------------------------------------------
--ƒUƒR“G‚Μ€–SΔ‹΅87
--------------------------------------------------------------------------------------
--΅87΅ƒUƒR“G‚Μ€–SΔ‹΅
function OnEvent_87(proxy, param)
	print("OnEvent_87 begin");
	
	proxy:SetDrawEnable( 3067 , false );
	proxy:SetEventFlag( 87, 1 );
	
	print("OnEvent_87 end");
end

--------------------------------------------------------------------------------------
--ƒUƒR“G‚Μ€–SΔ‹΅88
--------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------
--ƒUƒR“G‚Μ€–SΔ‹΅89
--------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------
--ƒUƒR“G‚Μ€–SΔ‹΅90
--------------------------------------------------------------------------------------
--΅90΅ƒUƒR“G‚Μ€–SΔ‹΅
function OnEvent_90(proxy, param)
	print("OnEvent_90 begin");
	
	proxy:SetDrawEnable( 3070 , false );
	proxy:SetEventFlag( 90, 1 );
	
	print("OnEvent_90 end");
end

--------------------------------------------------------------------------------------
--ƒUƒR“G‚Μ€–SΔ‹΅91
--------------------------------------------------------------------------------------
--΅91΅ƒUƒR“G‚Μ€–SΔ‹΅
function OnEvent_91(proxy, param)
	print("OnEvent_91 begin");
	
	proxy:SetDrawEnable( 3071 , false );
	proxy:SetEventFlag( 91, 1 );
	
	print("OnEvent_91 end");
end

--------------------------------------------------------------------------------------
--ƒUƒR“G‚Μ€–SΔ‹΅92
--------------------------------------------------------------------------------------
--΅92΅ƒUƒR“G‚Μ€–SΔ‹΅
function OnEvent_92(proxy, param)
	print("OnEvent_92 begin");
	
	proxy:SetDrawEnable( 3072 , false );
	proxy:SetEventFlag( 92, 1 );
	
	print("OnEvent_92 end");
end

--------------------------------------------------------------------------------------
--ƒUƒR“G‚Μ€–SΔ‹΅93
--------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------
--ƒUƒR“G‚Μ€–SΔ‹΅94
--------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------
--ƒUƒR“G‚Μ€–SΔ‹΅95
--------------------------------------------------------------------------------------
--΅95΅ƒUƒR“G‚Μ€–SΔ‹΅
function OnEvent_95(proxy, param)
	print("OnEvent_95 begin");
	
	proxy:SetDrawEnable( 3075 , false );
	proxy:SetEventFlag( 95, 1 );
	
	print("OnEvent_95 end");
end

--------------------------------------------------------------------------------------
--ƒUƒR“G‚Μ€–SΔ‹΅96
--------------------------------------------------------------------------------------
--΅96΅ƒUƒR“G‚Μ€–SΔ‹΅
function OnEvent_96(proxy, param)
	print("OnEvent_96 begin");
	
	proxy:SetDrawEnable( 3076 , false );
	proxy:SetEventFlag( 96, 1 );
	
	print("OnEvent_96 end");
end

--------------------------------------------------------------------------------------
--ƒUƒR“G‚Μ€–SΔ‹΅97
--------------------------------------------------------------------------------------
--΅97΅ƒUƒR“G‚Μ€–SΔ‹΅
function OnEvent_97(proxy, param)
	print("OnEvent_97 begin");
	
	proxy:SetDrawEnable( 3077 , false );
	proxy:SetEventFlag( 97, 1 );
	
	print("OnEvent_97 end");
end

--------------------------------------------------------------------------------------
--ƒUƒR“G‚Μ€–SΔ‹΅98
--------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------
--ƒUƒR“G‚Μ€–SΔ‹΅99
--------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------
--ƒUƒR“G‚Μ€–SΔ‹΅100
--------------------------------------------------------------------------------------
--΅100΅ƒUƒR“G‚Μ€–SΔ‹΅
function OnEvent_100(proxy, param)
	print("OnEvent_100 begin");
	
	proxy:SetDrawEnable( 3080 , false );
	proxy:SetEventFlag( 100, 1 );
	
	print("OnEvent_100 end");
end

--------------------------------------------------------------------------------------
--ƒUƒR“G‚Μ€–SΔ‹΅101
--------------------------------------------------------------------------------------
--΅101΅ƒUƒR“G‚Μ€–SΔ‹΅
function OnEvent_101(proxy, param)
	print("OnEvent_101 begin");
	
	proxy:SetDrawEnable( 3081 , false );
	proxy:SetEventFlag( 101, 1 );
	
	print("OnEvent_101 end");
end

--------------------------------------------------------------------------------------
--ƒUƒR“G‚Μ€–SΔ‹΅102
--------------------------------------------------------------------------------------
--΅102΅ƒUƒR“G‚Μ€–SΔ‹΅
function OnEvent_102(proxy, param)
	print("OnEvent_102 begin");
	
	proxy:SetDrawEnable( 3082 , false );
	proxy:SetEventFlag( 102, 1 );
	
	print("OnEvent_102 end");
end

--------------------------------------------------------------------------------------
--ƒUƒR“G‚Μ€–SΔ‹΅103
--------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------
--ƒUƒR“G‚Μ€–SΔ‹΅104
--------------------------------------------------------------------------------------



--------------------------------------------------------------------------------------
--Ξ’‚Ιƒ[ƒv΅110
--------------------------------------------------------------------------------------
--΅110΅Ξ’‚Ιƒ[ƒv΅
function OnEvent_110(proxy,param)	
	print("OnEvent_110 begin");
	
	proxy:WarpNextStage( 1, 0, 0, 0, 1011 );
	
	print("OnEvent_110 end");
end



--------------------------------------------------------------------------------------
--pjƒf[ƒ‚ƒ“‚Μ“oκ΅??
--------------------------------------------------------------------------------------

--¥ƒOƒ[ƒoƒ‹‚Μ€–SΔ‹‚©‚ηΔ‚Ξ‚κ‚ι(ƒ\ƒ)
function PlayerDeath_m07_01_00_00(proxy, param)
	print("PlayerDeath_m07_01_00_00");
	
--	LuaFunc_VisibleTheWanderingDemon(proxy, param, demon_id_list_m07_01_00_00);
--	proxy:SetEventFlag( 20 , 1 );--ƒtƒ‰ƒO‚Ν‰ΌAw’θ‚ª‚ ‚κ‚Ξ•Ο‚¦‚ιB
	
	print("PlayerDeath_m07_01_00_00");
end

--¥ƒOƒ[ƒoƒ‹‚Μ•¶•‚©‚ηΔ‚Ξ‚κ‚ι(ƒ\ƒ)
function PlayerRevive_m07_01_00_00(proxy,param)
	print("PlayerRevive_m07_01_00_00");
	
--	LuaFunc_InvisibleTheWanderingDemon(proxy, param, demon_id_list_m07_01_00_00);
--	proxy:SetEventFlag( 20 , 0 );--ƒtƒ‰ƒO‚Ν‰ΌAw’θ‚ª‚ ‚κ‚Ξ•Ο‚¦‚ιB
	
	print("PlayerRevive_m07_01_00_00");
end

