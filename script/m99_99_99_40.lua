once = 1;
everytime = 0;





function Initialize_m99_99_99_40(proxy)
print("Initialize m99_99_99_40 begin");
--��191����������䁡
--�o�b���A�C�x���g�G���A(91)�̒��ɋ��āA
--����̊p�x�������Ă��āA
--�A�N�V�����{�^�����������Ƃ�
	proxy:OnPlayerActionInRegionAngle( 191, 91, "OnEvent_191", 90,1, once);
--	proxy:OnRegionJustIn( 191, 10000, 91, "OnEvent_191", once);

--��192���ʘH���䁡
--�E�o�b���A�C�x���g�G���A(92)�ɓ��B�����Ƃ�
--	proxy:OnRegionJustIn( 192, 10000, 92, "OnEvent_192", once);
--��193����������P��
--�E�o�b���A�C�x���g�G���A�i93�j�ɓ��B�����Ƃ�
	proxy:OnRegionJustIn( 193, 10000, 93, "OnEvent_193", once);

--��194����������R��
--�E�o�b���A�C�x���g�G���A(94)�ɓ��B�����Ƃ�
--	proxy:OnRegionJustIn( 194, 10000, 94, "OnEvent_194", once);
--	proxy:OnPlayerDistanceAngleInTarget(194,10000,94,"OnEvent_194",1.0,once);
--��195����������Q��
--�o�b���A�C�x���g�G���A(95)�̒��ɋ��āA
--�A�N�V�����{�^�����������Ƃ�
	proxy:OnPlayerActionInRegion( 195, 95, "OnEvent_195",1, once);
	
--��196���~�̈�i�T�[�N���j�e�X�g��
--�o�b���A�C�x���g�G���A(30)�̒��ɋ��āA
--�A�N�V�����{�^�����������Ƃ�
	proxy:OnPlayerActionInRegion( 196, 30, "OnEvent_196",1, once);
	
--��197�����̈�i�X�t�B�A�j�e�X�g��
--�o�b���A�C�x���g�G���A(31)�̒��ɋ��āA
--�A�N�V�����{�^�����������Ƃ�
	proxy:OnPlayerActionInRegion( 197, 31, "OnEvent_197",1, once);
	
--��198����`�i���N�g�j�̈�e�X�g��
--�o�b���A�C�x���g�G���A(32)�̒��ɋ��āA
--�A�N�V�����{�^�����������Ƃ�
	proxy:OnPlayerActionInRegion( 198, 32, "OnEvent_198",1, once);

--��192���ʘH���䁡
--�E�o�b���A�C�x���g�G���A(92)�ɓ��B�����Ƃ�
	proxy:OnPlayerActionInRegionAngle( 196, 92, "OnEvent_196",90,1, once);

--��199����b�e�X�g��
--PC���C�x���gID94����1.5�̋����ɓ����Ă��āA�A�N�V�����{�^�����������Ƃ�
	proxy:OnDistanceAction(199,10000,94,"OnEvent_199",3,1,0,90,everytime );

--��200����b�e�X�g��
--PC���C�x���gID94����1.5�̋����ɓ����Ă��鎞
	proxy:OnPlayerDistanceInTarget(200,10000,94,"OnEvent_200",3,everytime );

--��201����b�e�X�g��
--PC���C�x���gID94����1.5�̋����ɓ�������o���Ƃ�
	proxy:OnPlayerDistanceOut(201,10000,94,"OnEvent_201",3,everytime );

--��202����b�e�X�g��
--PC���C�x���gID94��HP��0�ɂ����Ƃ�
	proxy:OnCharacterHP(202,94,"OnEvent_202_1",0.0,once);

--�C�x���gID94�����S�Ɏ��񂾂Ƃ�
	proxy:OnCharacterDead(202,94,"OnEvent_202_2",once);

print("Initialize m99_99_99_40 end");
end



--��191����������䁡
function OnEvent_191(proxy, param)
print("OnEvent_191 begin");
--�E�C�x���g�t���O�𗧂Ă�
	proxy:SetEventFlag( 191, 1 );

--�EPC���C�x���g�G���A(193)�Ɉړ�
	proxy:Warp(10000, 193);

print("OnEvent_191 end");
end



--��192���ʘH���䁡
function OnEvent_192(proxy, param)
print("OnEvent_192 begin");

--�E�C�x���g�t���O�𗧂Ă�
	proxy:SetEventFlag( 192, 1 );
--�EPC�̃��o�[����A�j���[�V����(ID 4000)�Đ�
	proxy:PlayAnimation(10000, 4000);

print("OnEvent_192 end");
end



--��193����������P��
function OnEvent_193(proxy, param)
print("OnEvent_193 begin");

--�E�C�x���g�t���O�𗧂Ă�
	proxy:SetEventFlag( 193, 1 );
--�E��b(ID 0)���Đ�
	proxy:PlayTalk(0);

print("OnEvent_193 end");
end



--��194����������R��
function OnEvent_194(proxy, param)
print("OnEvent_194 begin");

--�E�C�x���g�t���O�𗧂Ă�
	proxy:SetEventFlag( 194, 1 );
--�E�A�C�e��(ID 0)���擾
	proxy:GetItem(0);
	proxy:PlayAnimation(10000, 4000);
print("OnEvent_194 end");
end


--��195����������Q��
function OnEvent_195(proxy, param)
print("OnEvent_195 begin");

--�E�C�x���g�t���O�𗧂Ă�
	proxy:SetEventFlag( 195, 1 );
--�EPC�̃��o�[����A�j���[�V����(ID 4000)�Đ�
	proxy:PlayAnimation(10000, 4000);

print("OnEvent_195 end");
end

--��196���~�̈�i�T�[�N���j�e�X�g��
function OnEvent_196(proxy, param)
print("OnEvent_196 begin");

--�E�C�x���g�t���O�𗧂Ă�
	proxy:SetEventFlag( 196, 1 );
--�EPC�̃��o�[����A�j���[�V����(ID 4000)�Đ�
	proxy:PlayAnimation(10000, 4000);

print("OnEvent_196 end");
end

--��197�����̈�i�X�t�B�A�j�e�X�g��
function OnEvent_197(proxy, param)
print("OnEvent_197 begin");

--�E�C�x���g�t���O�𗧂Ă�
	proxy:SetEventFlag( 197, 1 );
--�EPC�̃��o�[����A�j���[�V����(ID 4000)�Đ�
	proxy:PlayAnimation(10000, 4000);

print("OnEvent_197 end");
end

--��198����`�i���N�g�j�̈�e�X�g��
function OnEvent_198(proxy, param)
print("OnEvent_198 begin");

--�E�C�x���g�t���O�𗧂Ă�
	proxy:SetEventFlag( 198, 1 );
--�EPC�̃��o�[����A�j���[�V����(ID 4000)�Đ�
	proxy:PlayAnimation(10000, 4000);

print("OnEvent_198 end");
end

--��192���ʘH���䁡
function OnEvent_196(proxy, param)
print("OnEvent_196 begin");

--�E�C�x���g�t���O�𗧂Ă�
	proxy:SetEventFlag( 196, 1 );
--�EPC�̃��o�[����A�j���[�V����(ID 4000)�Đ�
	proxy:PlayAnimation(10000, 4000);

print("OnEvent_196 end");
end


--��199��������t�ߓG��
function OnEvent_199(proxy, param)
print("OnEvent_199 begin");
	FlagValue = proxy:IsCompleteEventValue(199);

	if FlagValue ==0 then proxy:SetEventFlag( 199, 1 ); end

	if FlagValue ==1 then proxy:SetEventFlag( 199, 2 ); end
	if FlagValue ==2 then proxy:SetEventFlag( 199, 3 ); end
	if FlagValue ==3 then 
		proxy:SetEventFlag( 199, 0 );		
	 end

print("OnEvent_199 end");
end


--��200��������t�ߓG�F��b��
function OnEvent_200(proxy, param)
print("OnEvent_200 begin");
--199�C�x���g�̃t���O���擾����
	FlagValue = proxy:IsCompleteEventValue(199);
	if FlagValue ==0 then return; end

	if FlagValue ==1 then proxy:StartTalk(90000000,1);	 end
	if FlagValue ==2 then proxy:StartTalk(90000001,1);	 end
	if FlagValue ==3 then proxy:StartTalk(90000002,0);	 end
	if FlagValue ==4 then proxy:StartTalk(90000700,0);	 end

print("OnEvent_200 end");
end

--��201��������t�ߓG�F��b��
function OnEvent_201(proxy, param)
print("OnEvent_201 begin");
--199�C�x���g�̃t���O���擾����
	FlagValue = proxy:IsCompleteEventValue(199);
	if FlagValue ==4 then return; end
	if FlagValue ==5 then return; end

	if FlagValue >=1 then proxy:SetEventFlag( 199, 0 );	 end

print("OnEvent_201 end");
end

--��202_1��������t�ߓG�F��b��
function OnEvent_202_1(proxy, param)
print("OnEvent_202_1 begin");
--199�C�x���g�̃t���O���擾����
	proxy:SetEventFlag(199,4);

print("OnEvent_202_1 end");
end

--��202_2��������t�ߓG�F��b��
function OnEvent_202_2(proxy, param)
print("OnEvent_202_2 begin");
--199�C�x���g�̃t���O���擾����
	proxy:SetEventFlag(199,5);

print("OnEvent_202_2 end");
end

