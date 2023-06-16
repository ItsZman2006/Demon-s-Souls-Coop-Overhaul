--[[*******************************************************************************************
	�B���R����ʒu�p�̉H�N�}���V�p�̎v�l���W�b�N
	�����F
		
	�쐬�Fhasem 08/7/26
*********************************************************************************************]]
REGISTER_LOGIC_FUNC(LOGIC_ID_HaneKuma313006, "SpHaneKuma313006_Logic", "SpHaneKuma313006_Interupt");

--[[**********************************************************************
	���W�b�N�B
************************************************************************]]
function SpHaneKuma313006_Logic(ai)

	--�܂��́A���n���Ă�����A�󒆂ɏオ�낤�B
	if ( ai:IsLanding()) then
		ai:AddTopGoal( GOAL_COMMON_Attack, 10, 9520, TARGET_NONE, DIST_None);
	end
	

	--�^�[�Q�b�g���w��̈���ɂ��Ȃ��ꍇ�A�������ʒu�ɋA��B
	if ( ai:IsInsideTargetRegion(TARGET_ENE_0, 2290) ) then
		
		--�ʏ탍�W�b�N�B
		COMMON_EasySetup3(ai);
	
	else
	
		--�ⓚ���p�ŏ����ʒu�ɖ߂�B
		ai:AddTopGoal( GOAL_kuma_ApproachXZAndFall, 10);
		
	end
	
end

--[[**********************************************************************
	���荞�݁B
************************************************************************]]
function SpHaneKuma313006_Interupt(ai, goal)
	return false;
end





--[[******************************************************************************************************]]
--[[************************************** �H�N�}���V�p�T�u�S�[�� ****************************************]]
--[[******************************************************************************************************]]


--[[*******************************************************************************************
	�����ʒu�ɖ߂�B
*********************************************************************************************]]
REGISTER_GOAL(GOAL_kuma_ApproachXZAndFall, "ApproachXZAndFall");
REGISTER_GOAL_NO_UPDATE( GOAL_kuma_ApproachXZAndFall, true);
REGISTER_GOAL_NO_INTERUPT( GOAL_kuma_ApproachXZAndFall, true);
function ApproachXZAndFall_Activate( ai, goal )

	-- �܂��́A�����ʒu�Ɍ������B
	goal:AddSubGoal( GOAL_kuma_ApproachIniXZ, 3);
	
	-- �~�܂�B
	goal:AddSubGoal( GOAL_COMMON_Fall, 3, POINT_INITIAL, 9510, 9520, -10);
	
end
function ApproachXZAndFall_Update( ai, goal ) return GOAL_RESULT_Continue; end
function ApproachXZAndFall_Terminate( ai, goal ) end
function ApproachXZAndFall_Interupt( ai, goal )	return false; end




--[[*******************************************************************************************
	XZ���ʏ�ňړ�����B
	�P�ɏI���������AXZ���ʋ����Ƃ��������B
*********************************************************************************************]]
REGISTER_GOAL(GOAL_kuma_ApproachIniXZ, "ApproachIniXZ");
REGISTER_GOAL_NO_INTERUPT( GOAL_kuma_ApproachIniXZ, true);
function ApproachIniXZ_Activate( ai, goal )
	goal:AddSubGoal( GOAL_COMMON_MoveToSomewhere, 3, POINT_INITIAL, AI_DIR_TYPE_CENTER, 1, TARGET_SELF, false);
end
function ApproachIniXZ_Update( ai, goal )

--[[��悳�񒲐�����]]

	--XZ���ʂŁA������ڋ߂�����A���̃S�[�����I������B
	local NEAR_RANGE 	= 2;

--[[��悳�񒲐�����]]



	local distXZ 		= ai:GetDistXZ(POINT_INITIAL);
	if ( distXZ < NEAR_RANGE ) then
		return GOAL_RESULT_Success;
	end
	
	return GOAL_RESULT_Continue; 
end
function ApproachIniXZ_Terminate( ai, goal )end
function ApproachIniXZ_Interupt( ai, goal )	return false; end




