function Initialize_m99_99_98_00(proxy)
	print("Initialize m99_99_98_00");

	--��0�b�づ--
	proxy:OnKeyTime2( 999990, "Second_Initialize_m99_99_98_00", 0.3, 0, 0, once );	
	
	print("Initialize m99_99_98_00 end");
end


function Second_Initialize_m99_99_98_00(proxy, param)
	print("Second_Initialize_m99_99_98_00 begin");
	OnEvent_1(proxy);
	print("Second_Initialize_m99_99_98_00 end");
end

function OnEvent_1(proxy)
    proxy:OnKeyTime2( 999991,"OnEvent_2",3.0,0,0,once);
    OnEvent_3(proxy);
end

function OnEvent_2(proxy)
    proxy:OnKeyTime2( 999992,"OnEvent_1",3.0,0,0,once);
    OnEvent_3(proxy);
end


--��1250_2���_���[�W�����ł�̂�x�点��(�R�����{�l�ɓ�����Ȃ��悤��)��
function OnEvent_3(proxy)
	print("OnEvent_3 begin");

	--�΂̘m����_���[�W��
	local paramid = 10010; --�Α����_���[�W
	local rad     = 1.5;--���a
	local time    = 3.0; --�ЂƂ܂��A�j���Đ��I���Ń_���[�W�������̂ŁA�A�j����蒷�����Ԃ��w�肵�Ă���
	
	proxy:OnObjectDamageHit_NoCall( 1250, 1, 1, paramid, EV_HIT_CHR , rad, time, everytime );	
	
	print("OnEvent_3 end");
end