once = 1;
everytime = 0;

function Initialize_m99_99_99_99(proxy)
	print("Initialize m99_99_99_99 begin");


--	誰が無視　プレイアだけ
--	EventID, Who(無視), RegionID, handler, bOnce	
	proxy:OnRegionJustIn( 0, 0, 0, "OnJustIn0Region", everytime);
	
	proxy:OnRegionJustOut(1, 0, 0, "OnJustOut0Region", everytime);

	print("Initialize m99_99_99_99 end");
end



function OnJustIn0Region(proxy, param)
	print("OnJustIn0Region m99_99_99_99 begin");

--	proxy:SetDrawEnable(0, 0);
	proxy:ChangeModel(0, 1);
	proxy:SetBrokenPiece(0);
	
	proxy:ChangeModel(2, 1);
	proxy:SetBrokenPiece(2);
	
	proxy:ChangeModel(4, 1);
	proxy:SetBrokenPiece(4);

	print("OnJustIn0Region m99_99_99_99 End");
end

function OnJustOut0Region(proxy, param)
	print("OnJustOut0Region m99_99_99_99 begin");

--	proxy:SetDrawEnable(0, 1);
	proxy:ChangeModel(0, 0);
	proxy:SetBrokenPiece(0);
	
	proxy:ChangeModel(2, 0);
	proxy:SetBrokenPiece(2);
	
	proxy:ChangeModel(4, 0);
	proxy:SetBrokenPiece(4);
	
	print("OnJustOut0Region m99_99_99_99 End");
end


