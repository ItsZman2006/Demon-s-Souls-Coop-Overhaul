once = 1;
everytime = 0;




function Initialize_m99_99_12_00(proxy)
print("Initialize m99_99_12_00 begin");


--	�N�������@�v���C�A����
--	EventID, Who(����), RegionID, handler, bOnce	


--��201���h���S���f�[�����o�ꁡ
--�EPC���A�C�x���g�G���A�i1�j�ɓ��B�����Ƃ�
	proxy:OnRegionJustIn( 201, 10000, 1, "OnEvent_201", once);


--��202���h���S���f�[�����퓬��ԂɈڍs��
--�EPC���A�C�x���g�G���A�i2�j�ɓ��B�����Ƃ�
	proxy:OnRegionJustIn( 202, 10000, 2, "OnEvent_202", once);

--[[ �`���[�g���A���p�ɃR�����g�A�E�g

--��210���o���X�^����0��
--�EPC���A�C�x���g�G���A(210)�̒��ɋ��āA
--�@����̊p�x�������Ă��āA
--�@�A�N�V�����{�^�����������Ƃ�
	proxy:OnPlayerActionInRegionAngle( 210, 210, "OnEvent_210", 30,1, once);
--��211���o���X�^����0��
--�EPC���A�C�x���g�G���A(210)�̒��ɋ��āA
--�@����̊p�x�������Ă��āA
--�@�A�N�V�����{�^�����������Ƃ�
	proxy:OnPlayerActionInRegionAngle( 211, 210, "OnEvent_211", 30,1, once);


--��220���o���X�^����1��
--�EPC���A�C�x���g�G���A(220)�̒��ɋ��āA
--�@����̊p�x�������Ă��āA
--�@�A�N�V�����{�^�����������Ƃ�
	proxy:OnPlayerActionInRegionAngle( 220, 220, "OnEvent_220", 30,1, once);
--��221���o���X�^����1��
--�EPC���A�C�x���g�G���A(220)�̒��ɋ��āA
--�@����̊p�x�������Ă��āA
--�@�A�N�V�����{�^�����������Ƃ�
	proxy:OnPlayerActionInRegionAngle( 221, 220, "OnEvent_221", 30,1, once);
]]

--��275���}�b�v�ړ��i���ԁj��
--�E�o�b���A�C�x���g�G���A�i75�j�ɓ��B�����Ƃ�
	proxy:OnRegionJustIn( 275, 10000, 75, "OnEvent_275", everytime);



--��299���{�X���S��
--�E�{�X(200)���S
	proxy:OnCharacterDead( 299, 200, "OnEvent_299", once);
	
--��7000���}�b�v�������灡
	proxy:OnKeyTime2(7000,"OnEvent_7000",0.0,0,0,once);
	
--��7010���̈�͂������灡
	proxy:OnRegionIn(7010,10000,2200,"OnEvent_7010",once);

	

--��??���p�j�f�[�����̓o�ꁡ�n���h���o�^
	proxy:NotNetMessage_begin();
		--�v���C���[���\���Ŏ��S�������ɃL�b�N����܂��B
		proxy:LuaCall( 4000, 100, "PlayerDeath_m99_99_12_00", everytime );
		--�v���C���[�������������ɃL�b�N����܂��B
		proxy:LuaCall( 4032, 100, "PlayerRevive_m99_99_12_00", everytime );
	proxy:NotNetMessage_end();
	
	
--��999912���t���[���x��̏����������C�x���g�𔭍s��
	proxy:NotNetMessage_begin();
		--��0�b�づ--
		proxy:OnKeyTime2( 999912, "Second_Initialize_m99_99_12_00", 0.1, 0, 0, once );	
	proxy:NotNetMessage_end();	

print("Initialize m99_99_12_00 end");
end


--------------------------------------------------------------------------------------
--�}���`�ɂȂ������Ƀz�X�g���ᖳ�������灡����
--------------------------------------------------------------------------------------
function ConnectPartyEvent(proxy)
	print("ConnectPartyEvent begin");
	print("ConnectPartyEvent end");
end



--------------------------------------------------------------------------------------
--Initialize����Ă΂��A1�t���[���x��̏�����������999999
--------------------------------------------------------------------------------------
--��999912����������
function Second_Initialize_m99_99_12_00(proxy, param)
	print("Second_Initialize_m99_99_12_00 begin");
	
--[[
	--���p�j�f�[�����p (�t���O�͉��A�w�肪����Ες���)
	if proxy:IsCompleteEvent( 20 ) == true then
		LuaFunc_VisibleTheWanderingDemon  (proxy, param, demon_id_list_m99_99_12_00);
	else
		LuaFunc_InvisibleTheWanderingDemon(proxy, param, demon_id_list_m99_99_12_00);
	end
]]
	
	print("Second_Initialize_m99_99_12_00 end");
end



--��201���h���S���f�[�����o�ꁡ
function OnEvent_201(proxy, param)
print("OnEvent_201 begin");
	if param:IsNetMessage()==true  then
		return;         
	end
	
--�E�h���S���f�[����(c1020/200)�̓o��A�j���[�V����(99_0000�j���Đ�
	proxy:PlayAnimation(200, 990000);

print("OnEvent_201 end");
end







--��202���h���S���f�[�����퓬��ԂɈڍs��
function OnEvent_202(proxy, param)
print("OnEvent_202 begin");

--�E�h���S���f�[����(c1020/200)��퓬���W�b�N�ɐ؂�ւ���H
--�˃h���S���f�[�����̐퓬���C�x���g���L�������H
	proxy:EnableLogic(200, true);

print("OnEvent_202 end");
end







--��210���o���X�^����0��
function OnEvent_210(proxy, param)
print("OnEvent_210 begin");
	print( "212 destroyed? %d", proxy:IsDestroyed(212) );
	
	if param:IsNetMessage()==true  then
		return;         
	end

--	�o���X�^�j�󂳂ꂽ�牽�����Ȃ�
	if proxy:IsDestroyed(212) == false then 
--      {
--�EPC���C�x���g�G���A(215)�Ɉړ�
	proxy:Warp(10000, 215);
--�EPC�̃��o�[����A�j���[�V����(ID 4000)�Đ�
	proxy:PlayAnimation(10000, 8000);

--�E�����Ƀh���S���f�[�����̃o���X�^1�_���[�W���[�V����(990040)�Đ�
    --local boss = proxy:GetBoss(200);
    --boss:Damage_LeftArm();

--�E���[�V������o���X�^�̖�͏����Ă�������
--  	}
	end

print("OnEvent_210 end");
end


--��211���o���X�^����0��
function OnEvent_211(proxy, param)
print("OnEvent_211 begin");
--	�o���X�^�j�󂳂ꂽ�牽�����Ȃ�
	if proxy:IsDestroyed(212) == false then 
--      {
--�E�o���X�^0�p���o�[�io0210_00/210�j�̃A�j���[�V����(ID 1)�Đ�
	proxy:PlayAnimation(210, 1);

--�E�o���X�^�̖�io0001_00/211)�̔��˃A�j���[�V����(ID 1)�Đ�
	proxy:PlayAnimation(211, 1);

--�E�o���X�^0OBJ�io0000/212)�̔��˃A�j���[�V�����iID 1�j�Đ�
	proxy:PlayAnimation(212, 1);

--�E���[�V������o���X�^�̖�͏����Ă�������
--  	}
	end


print("OnEvent_211 end");
end







--��220���o���X�^����1��
function OnEvent_220(proxy, param)
print("OnEvent_220 begin");
	if param:IsNetMessage()==true  then
		return;         
	end
	
--	�o���X�^�j�󂳂ꂽ�牽�����Ȃ�
	if proxy:IsDestroyed(222) == false then 
--      {
--�EPC���C�x���g�G���A(216)�Ɉړ�
	proxy:Warp(10000, 216);
--�EPC�̃��o�[����A�j���[�V����(ID 4000)�Đ�
	proxy:PlayAnimation(10000, 8000);

--�E�����Ƀh���S���f�[�����̃o���X�^1�_���[�W���[�V����(990041)�Đ�
    --local boss = proxy:GetBoss(200);
    --boss:Damage_RightArm();

--�E���[�V������o���X�^�̖�͏����Ă�������
--  	}
	end

print("OnEvent_220 end");
end


--��221���o���X�^����1��
function OnEvent_221(proxy, param)
print("OnEvent_221 begin");
--	�o���X�^�j�󂳂ꂽ�牽�����Ȃ�
	if proxy:IsDestroyed(222) == false then 
--      {
--�E�o���X�^1�p���o�[�io0210_01/220�j�̃A�j���[�V����(ID 1)�̃A�j���[�V�����Đ�
	proxy:PlayAnimation(220, 1);

--�E�o���X�^�̖�io0001_01/221)�̔��˃A�j���[�V����(ID 1)�Đ�
	proxy:PlayAnimation(221, 1);

--�E�o���X�^1OBJ�io0000/222)�̔��˃A�j���[�V�����iID 1�j�Đ�
	proxy:PlayAnimation(222, 1);

--�E���[�V������o���X�^�̖�͏����Ă�������
--  	}
	end

print("OnEvent_221 end");
end







--��275���}�b�v�ړ��i���ԁj��
function OnEvent_275(proxy, param)
print("OnEvent_275 begin");
	if param:IsNetMessage()==true  then
		return;         
	end
--�}���`�v���C�̎��̃G���A�ړ����~�߂�
	if proxy:IsInParty() == true then
		return;
	end 
	
--�E���ǂ蒅�����o�b�̂݁A�n��L�ꂩ��ԁim99_99_11_00�j�̎w��ʒu�Ɉړ�
--�E�ړ���im99_99_11_00�j�̑Ή��L�����C�x���gID
--�@�o�b�i0�j���L�����i30�j
--�@�o�b�i1�j���L�����i31�j
--�@�o�b�i2�j���L�����i32�j
--�@�o�b�i3�j���L�����i33�j
	playerId = proxy:GetLocalPlayerId();
	if playerId ==0 then proxy:WarpNextStage(99,99,11,00, 30); end
	if playerId ==1 then proxy:WarpNextStage(99,99,11,00, 31); end
	if playerId ==2 then proxy:WarpNextStage(99,99,11,00, 32); end
	if playerId ==3 then proxy:WarpNextStage(99,99,11,00, 33); end

--���ړ�����L�����N�^�[�́A�ړ����Ƀp�b�Ə����Ă��܂��܂�

print("OnEvent_275 end");
end







--��299���{�X���S��
function OnEvent_299(proxy, param)
print("OnEvent_299 begin");

--�Ƃ肠�������j���[��
	--proxy:WarpNextStage(0,0,0,-1, -1);
--��L�̏������g���Ȃ��Ȃ��Ă���l�Ȃ̂ł�����Ɉڍs
	proxy:ReturnMapSelect();
print("OnEvent_299 end");
end









--------------------------------------------------------------------------------------
--�}�b�v�ɓ������灡7000
--------------------------------------------------------------------------------------
function OnEvent_7000(proxy,param)
	print("OnEvent_7000 begin");
	if proxy:IsCompleteEvent(7000) == false then 
		proxy:SetChrType(10000,8);
		proxy:SetEventFlag(7000,true);
	end
	print("OnEvent_7000 end");
end


--------------------------------------------------------------------------------------
--2200�̈�ɓ������灡7010
--------------------------------------------------------------------------------------
function OnEvent_7010(proxy,param)
	print("OnEvent_7010 begin");
	if proxy:IsCompleteEvent(7010) == false then
		proxy:SetEventFlag(7010,true);
		proxy:OnKeyTime2(7010,"OnEvent_7010_1",9.0,0,0,once);
	end
	print("OnEvent_7010 end");
end


--------------------------------------------------------------------------------------
--���b�ち7010 �}�b�v�����܂�
--------------------------------------------------------------------------------------
function OnEvent_7010_1(proxy,param)
	print("OnEvent_7010_1 begin");
	proxy:ReturnMapSelect();
	print("OnEvent_7010_1 end");
end



--------------------------------------------------------------------------------------
--�p�j�f�[�����̓o�ꁡ??
--------------------------------------------------------------------------------------

--���O���[�o���̎��S�Ď�����Ă΂��(�\��)
function PlayerDeath_m99_99_12_00(proxy, param)
	print("PlayerDeath_m99_99_12_00");
	
--	LuaFunc_VisibleTheWanderingDemon(proxy, param, demon_id_list_m99_99_12_00);
--	proxy:SetEventFlag( 20 , 1 );--�t���O�͉��A�w�肪����Ες���B
	
	print("PlayerDeath_m99_99_12_00");
end

--���O���[�o���̌�������������Ă΂��(�\��)
function PlayerRevive_m99_99_12_00(proxy,param)
	print("PlayerRevive_m99_99_12_00");
	
--	LuaFunc_InvisibleTheWanderingDemon(proxy, param, demon_id_list_m99_99_12_00);
--	proxy:SetEventFlag( 20 , 0 );--�t���O�͉��A�w�肪����Ες���B
	
	print("PlayerRevive_m99_99_12_00");
end



