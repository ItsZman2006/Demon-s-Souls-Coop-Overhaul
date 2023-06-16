--[[****************************************************************************************
	�ėp�̎v�l���W�b�N
	�����F
*******************************************************************************************]]
REGISTER_LOGIC_FUNC(LOGIC_ID_Dorei200000, "Dorei200000_Logic", "Dorei200000_Interupt");

--[[*****************************************************
	�z�ꕺ�m�p
*****************************************************]]
function	Dorei200000_Logic(ai)

	local eventNo = ai:GetEventRequest();					--�C�x���g����̃��N�G�X�g�ԍ����擾

	if (eventNo == AI_EVENT_DOREI_IKAKU) then
	
		local fate = ai:GetRandam_Int(1,100)			--�m������Ŏg�p����^���̐���
		
		--�����h�����q�i����P�j�̎��̃��W�b�N�B
		--80���E���E��
		--100���Њd
		if fate <= 80 then
			ai:AddTopGoal(GOAL_COMMON_SidewayMove, 5.0, TARGET_EVENT, ai:GetRandam_Int(0,1), ai:GetRandam_Int(15,30), true, true ,-1 );
		end
		
		ai:AddTopGoal(GOAL_COMMON_NonspinningAttack, 10.0, 7000, TARGET_EVENT, DIST_None, 0);
	else
		--�ʏ퓮��
		COMMON_EasySetup3(ai);
	end
end

--[[*****************************************************
	���荞�݁B
*****************************************************]]
function	Dorei200000_Interupt(ai, goal)
end


