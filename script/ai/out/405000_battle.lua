-----------------------------------------------------------------------------------------------
--	Honokaijin405000��p�퓬
--	�����F
--
--	�p�����[�^0  �Ȃ�
--	�p�����[�^1  �Ȃ�
--	�p�����[�^2  �Ȃ�
--	�p�����[�^3�@�Ȃ�
-----------------------------------------------------------------------------------------------
REGISTER_GOAL(GOAL_Honokaijin405000_Battle, "Honokaijin405000Battle");


-- Update�łȂɂ�����Ă��Ȃ��̂ŁA�Ă΂Ȃ��悤�ɂ���
REGISTER_GOAL_NO_UPDATE( GOAL_Honokaijin405000_Battle, 1 );

---------------------------------------------------------
--  �S�[���N��
---------------------------------------------------------
function Honokaijin405000Battle_Activate(ai, goal)
-------------------------------------------------------------------------------

-- ��{���
local hpRate 		= ai:GetHpRate( TARGET_SELF )		--������HP�������擾
local targetHpRate 	= ai:GetHpRate( TARGET_ENE_0)	--�G�^�[�Q�b�g��HP�������擾
local targetDist 	= ai:GetDist(TARGET_ENE_0);		--�G�^�[�Q�b�g�Ƃ̋������擾

-- �����_�����
local fate 	= ai:GetRandam_Int(1,100)				--�m������Ŏg�p����^���̐���
local fate2 = ai:GetRandam_Int(1,100)				--�m������Ŏg�p����^���̐����@���̂Q
local fate3	= ai:GetRandam_Int(1,100)				--�m������Ŏg�p����^���̐����@���̂R
local fate4	= ai:GetRandam_Int(1,100)				--�m������Ŏg�p����^���̐����@���̂S
local fate5	= ai:GetRandam_Int(1,100)				--�m������Ŏg�p����^���̐����@����5

-- �U�����s����Ńx�X�g�ȋ���
local nearAtkDist	= ai:GetRandam_Float( 1.0, 1.2 );	-- �ߋ����̃x�X�g�U���͈�
local middleAtkDist	= ai:GetRandam_Float( 5.1, 5.5 );	-- �������̃x�X�g�U���͈�
local farAtkDist	= ai:GetRandam_Float( 7.0, 8.1 );	-- �������̃x�X�g�U���͈�

-- �A���U���p���
local isGuard = ai:IsTargetGuard( TARGET_ENE_0 );
 
local nearMaai = ai:GetRandam_Float(3.0, 6.0)
	--�ߋ����ԍ����i���j
local middleSekkin = ai:GetDistParam(DIST_Middle) - 1.0
	--�������ڋߗp�i���j
local maaiTime = ai:GetRandam_Float(2.0, 4.0)
	--�ԍ��������s���̎����isec�j

local approachDist = ai:GetRandam_Float( 4.5, 5.1 );
	

local	lv = 1;	-- �U�����x��
	--------------------------------------------------------------
	-- �����̂g�o����U���k����ݒ肷��
	--------------------------------------------------------------
	-- �k���R
	if( hpRate <= 0.3 ) then
		lv = 3
	-- �k���Q
	elseif( hpRate <= 0.6 ) then
		lv = 2
	-- �k���P
	else
		lv = 1
	end
	
	
	
	--------------------------------------------------------------
	-- �C�x���g���疽�߂��󂯂Đg�k�����A�N�V����
	--------------------------------------------------------------
	
	if( eventNo == AI_EVENT_REACTION )then 	
		goal:AddSubGoal( GOAL_COMMON_Turn, 2, TARGET_ENE_0 );
		goal:AddSubGoal(GOAL_COMMON_Step, 5, 701, 0, 0, 0);
		goal:AddSubGoal( GOAL_COMMON_ComboAttack, 5.0, 9920, TARGET_ENE_0, DIST_None, 0);
		--return;
	end
	--------------------------------------------------------------
	-- ���Ƀ^�[�Q�b�g����������U������U��
	--------------------------------------------------------------
	
	if ( ai:IsInsideTargetEx( TARGET_SELF, TARGET_ENE_0, AI_DIR_TYPE_B, 30, 10)) then
	--�����̌���R�O�x�E�P�O���ȓ��ɂ�����
    
	goal:AddSubGoal( GOAL_COMMON_NonspinningAttack, 3.0, 3060, TARGET_ENE_0, DIST_None, 0);
	--�U������U��
    
    end

	--------------------------------------------------------------
	-- �����F�G�^�[�Q�b�g�������͈͂ɂ���ꍇ
	-- Desc�F�ߐڍU��
	--------------------------------------------------------------
	if targetDist <= nearAtkDist then
		
		-- ���x���P
		if( lv <= 1 ) then
			
			-- �ߐڍU��
			Honokaijin405000Battle_kinsetsu_1(ai, goal, lv)
            Honokaijin405000Battle_kougekigo(ai, goal, lv )
			
		-- ���x���Q
		elseif( lv <= 2 ) then
			
			-- �ߐڍU��
			Honokaijin405000Battle_kinsetsu_2(ai, goal, lv)
			Honokaijin405000Battle_kougekigo(ai, goal, lv )    
			
		-- ���x���R
		elseif( lv <= 3 ) then
		
			-- �ߐڍU��
			Honokaijin405000Battle_kinsetsu_3(ai, goal, lv)
			Honokaijin405000Battle_kougekigo(ai, goal, lv )
		end
	--------------------------------------------------------------
	-- �����F�G�^�[�Q�b�g���߂��ɂ���ꍇ
	-- Desc�F�߂Â��čU���ߐڍU��
	--------------------------------------------------------------
	elseif targetDist <= middleAtkDist then
		
		-- ���x���P
		if( lv <= 1 ) then
			
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 5.0, TARGET_ENE_0, 3, TARGET_ENE_0, false, -1 );			
			-- �ߐڍU��
			Honokaijin405000Battle_kinsetsu_1(ai, goal, lv)
            Honokaijin405000Battle_kougekigo(ai, goal, lv )
			
		-- ���x���Q
		elseif( lv <= 2 ) then
			
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 5.0, TARGET_ENE_0, 3, TARGET_ENE_0, false, -1 );			
			-- �ߐڍU��
			Honokaijin405000Battle_kinsetsu_2(ai, goal, lv)
			Honokaijin405000Battle_kougekigo(ai, goal, lv )    
			
		-- ���x���R
		elseif( lv <= 3 ) then
		
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 5.0, TARGET_ENE_0, 3, TARGET_ENE_0, false, -1 );			
			-- �ߐڍU��
			Honokaijin405000Battle_kinsetsu_3(ai, goal, lv)
			Honokaijin405000Battle_kougekigo(ai, goal, lv )
		end
    ----------------------------------------------------
	-- �����F�G�^�[�Q�b�g��������������Ă���
	-- Desc�F���ލ��ݍU��
	--------------------------------------------------------------
	elseif targetDist <= farAtkDist then
		
		-- ���x���P
		if( lv <= 1 ) then
		
			--�������U��
			Honokaijin405000Battle_enkyori_1(ai, goal, lv )
			Honokaijin405000Battle_kougekigo(ai, goal, lv )
			
        -- ���x���Q
		elseif( lv <= 2 ) then
			
			--�������U��
			Honokaijin405000Battle_enkyori_2(ai, goal, lv )
			Honokaijin405000Battle_kougekigo(ai, goal, lv )
			
		-- ���x���R
		elseif( lv <= 3 ) then
		
			--�������U��
			Honokaijin405000Battle_enkyori_3(ai, goal, lv )
			Honokaijin405000Battle_kougekigo(ai, goal, lv )
				
		end

	--------------------------------------------------------------
	-- �����F�G�^�[�Q�b�g���������ɂ���ꍇ
	-- Desc�F�߂Â��čU��
	--------------------------------------------------------------
	else
		-- ���x���P
		if( lv <= 1 ) then
		
		    goal:AddSubGoal(GOAL_COMMON_SidewayMove, maaiTime, TARGET_ENE_0, true, 15.0, true, true, -1);   
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 5.0, TARGET_ENE_0, 4, TARGET_ENE_0, false, -1 );
			
			-- �ߐڍU��
			Honokaijin405000Battle_kinsetsu_1(ai, goal, lv)
			Honokaijin405000Battle_kougekigo(ai, goal, lv )		
            
			
		-- ���x���Q
		elseif( lv <= 2 ) then
			
			goal:AddSubGoal( GOAL_COMMON_Step, 8, 702, 0, 0, 0 )
			goal:AddSubGoal( GOAL_COMMON_Step, 8, 703, 0, 0, 0 )
			
			--��SEQ1903  	�B��2�@�{�X�@���̉��l���T�C�h�X�e�b�v����������
			--		�����p�̕ϐ����A�S�[���̎����ɓ����Ă���B�B�B�������قڑS�Ă�ApproachTarget�ɓ����Ă��܂��B
			--		���̃o�O�́A�X�e�b�v��ɋ���������Ă���ƁA���̃X�e�b�v���J��Ԃ��Ă��܂��̂ŁA
			--		������������x���΂��Ă�鎖�ŉ������܂��B
			--		���A���ݓI�Ȗ��͕����Ă��܂��B�������܂����i�k��j
--			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, nearAtkDist, TARGET_ENE_0, 5, TARGET_ENE_0, false, -1 );
			goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 5, TARGET_ENE_0, 5, TARGET_ENE_0, false, -1 );
				
				-- �ߐڍU��
				Honokaijin405000Battle_kinsetsu_2(ai, goal,lv)
			    Honokaijin405000Battle_kougekigo(ai, goal, lv )
			
		-- ���x���R
		elseif( lv <= 3 ) then
		
				-- �U���x�X�g�͈͂ֈړ�
				goal:AddSubGoal( GOAL_COMMON_ApproachTarget, 5.0, TARGET_ENE_0, 4, TARGET_ENE_0, false, -1 );
								
				-- �ߐڍU��
				Honokaijin405000Battle_kinsetsu_3(ai, goal,lv)
				Honokaijin405000Battle_kougekigo(ai, goal, lv )	
		end

	end
	
end
---------------------------------------------------------
--  �A���U��_1 �y�ߐځz
---------------------------------------------------------
function Honokaijin405000Battle_kinsetsu_1(ai, goal, lv )

	-- �����_�����
	local fate1 = ai:GetRandam_Int(1,100)
	local fate2 = ai:GetRandam_Int(1,100)
	local fate3 = ai:GetRandam_Int(1,100)
	
	-- �U���h�c�ꗗ(default:Lv1)
	local rightSmash 	= 3000	-- �E����
	local leftSmash		= 3001	-- ������
    local top           = 3002	-- �ォ�牣��
	local dashFight		= 3050	-- ���ݍ��݊i��
	local tackle		= 3005	-- �ːi
	
	-- �k���Q�̏ꍇ�͍U���h�c��ύX����
	if( lv >= 2 ) then
		rightSmash		= 3007
		leftSmash		= 3008
		top     		= 3009
		
	end
	
	if fate1 < 30 then
	-- �ߐڃp�^�[��1
    goal:AddSubGoal( GOAL_COMMON_ComboAttack, 3.0, leftSmash, TARGET_ENE_0, DIST_Far, 0);
    goal:AddSubGoal( GOAL_COMMON_ComboAttack, 5.0, top, TARGET_ENE_0, DIST_Far, 0);
		
	elseif fate1 < 70 then
    -- �ߐڃp�^�[��2
	goal:AddSubGoal( GOAL_COMMON_ComboAttack, 3.0, 3020 , TARGET_ENE_0, DIST_Far, 0);
	goal:AddSubGoal( GOAL_COMMON_ComboAttack, 5.0, rightSmash, TARGET_ENE_0, DIST_Far, 0);
		
	else
	-- �ߐڃp�^�[��3
	goal:AddSubGoal( GOAL_COMMON_ComboAttack, 5.0, 3040, TARGET_ENE_0, DIST_Far, 0);
	
	end
end	
---------------------------------------------------------
--  �A���U��_2 �y�ߐځz
---------------------------------------------------------
function Honokaijin405000Battle_kinsetsu_2(ai, goal, lv )

	-- �����_�����
	local fate1 = ai:GetRandam_Int(1,100)
	local fate2 = ai:GetRandam_Int(1,100)
	local fate3 = ai:GetRandam_Int(1,100)
	
	-- �U���h�c�ꗗ(default:Lv1)
	local rightSmash 	= 3000	-- �E����
	local leftSmash		= 3001	-- ������
    local top           = 3002	-- �ォ�牣��
	local dashFight		= 3050	-- ���ݍ��݊i��
	local tackle		= 3005	-- �ːi
	
	-- �k���Q�̏ꍇ�͍U���h�c��ύX����
	if( lv >= 2 ) then
		rightSmash		= 3007
		leftSmash		= 3008
		top     		= 3009
		
	end
	
	if fate1 < 30 then
	-- �ߐڃp�^�[��1
    goal:AddSubGoal( GOAL_COMMON_ComboAttack, 3.0, leftSmash, TARGET_ENE_0, DIST_Middle, 0);
    goal:AddSubGoal( GOAL_COMMON_ComboAttack, 3.0, top, TARGET_ENE_0, DIST_Middle, 0);
		
	elseif fate1 < 60 then
    -- �ߐڃp�^�[��2
	goal:AddSubGoal( GOAL_COMMON_ComboAttack, 3.0, rightSmash, TARGET_ENE_0, DIST_Middle, 0);
	goal:AddSubGoal( GOAL_COMMON_ComboAttack, 3.0, 3020, TARGET_ENE_0, DIST_Middle, 0);
	goal:AddSubGoal( GOAL_COMMON_ComboAttack, 3.0, 3030, TARGET_ENE_0, DIST_Middle, 0);
		
	else
	-- �ߐڃp�^�[��3
	goal:AddSubGoal( GOAL_COMMON_ComboAttack, 3.0, rightSmash, TARGET_ENE_0, DIST_Middle, 0);
	goal:AddSubGoal( GOAL_COMMON_ComboAttack, 3.0, 3030, TARGET_ENE_0, DIST_Middle, 0);
	goal:AddSubGoal( GOAL_COMMON_ComboAttack, 3.0, 3040, TARGET_ENE_0, DIST_Middle, 0);
	
	end
end	

---------------------------------------------------------
--  �A���U��_3 �y�ߐځz
---------------------------------------------------------
function Honokaijin405000Battle_kinsetsu_3(ai, goal, lv )

	-- �����_�����
	local fate1 = ai:GetRandam_Int(1,100)
	local fate2 = ai:GetRandam_Int(1,100)
	local fate3 = ai:GetRandam_Int(1,100)
	
	-- �U���h�c�ꗗ(default:Lv1)
	local rightSmash 	= 3000	-- �E����
	local leftSmash		= 3001	-- ������
    local top           = 3002	-- �ォ�牣��
	local dashFight		= 3050	-- ���ݍ��݊i��
	local tackle		= 3005	-- �ːi
	
	-- �k���Q�̏ꍇ�͍U���h�c��ύX����
	if( lv >= 2 ) then
		rightSmash		= 3007
		leftSmash		= 3008
		top     		= 3009
		
	end
	
	if fate1 < 30 then
	-- �ߐڃp�^�[��1
    goal:AddSubGoal( GOAL_COMMON_ComboAttack, 3.0, top, TARGET_ENE_0, DIST_Middle, 0);
    goal:AddSubGoal( GOAL_COMMON_ComboAttack, 3.0, 3020, TARGET_ENE_0, DIST_Middle, 0);
		
	elseif fate1 < 60 then
    -- �ߐڃp�^�[��2
	goal:AddSubGoal( GOAL_COMMON_ComboAttack, 3.0, 3020, TARGET_ENE_0, DIST_Middle, 0);
	goal:AddSubGoal( GOAL_COMMON_ComboAttack, 3.0, rightSmash, TARGET_ENE_0, DIST_Middle, 0);
	goal:AddSubGoal( GOAL_COMMON_ComboAttack, 3.0, 3030, TARGET_ENE_0, DIST_Middle, 0);
	
	else
	-- �ߐڃp�^�[��3
	goal:AddSubGoal( GOAL_COMMON_ComboAttack, 3.0, 3020, TARGET_ENE_0, DIST_Middle, 0);
	goal:AddSubGoal( GOAL_COMMON_ComboAttack, 3.0, top, TARGET_ENE_0, DIST_Middle, 0);
	goal:AddSubGoal( GOAL_COMMON_ComboAttack, 3.0, 3040, TARGET_ENE_0, DIST_Middle, 0);
	
	end
end	
---------------------------------------------------------
--  �A���U��_1 �y�������z
---------------------------------------------------------
function Honokaijin405000Battle_enkyori_1(ai, goal, lv )

	-- �����_�����
	local fate1 = ai:GetRandam_Int(1,100)
	local fate2 = ai:GetRandam_Int(1,100)
	local fate3 = ai:GetRandam_Int(1,100)
	
	-- �U���h�c�ꗗ(default:Lv1)
	local rightSmash 	= 3000	-- �E����
	local leftSmash		= 3001	-- ������
    local top           = 3002	-- �ォ�牣��
    local dashFight     = 3050	-- ���ݍ��݊i��
	local tackle		= 3005	-- �ːi
			
	if fate1 < 30 then
	-- �������p�^�[��1
    goal:AddSubGoal( GOAL_COMMON_ComboAttack, 3.0, 700, TARGET_ENE_0, DIST_None, 0);
	goal:AddSubGoal( GOAL_COMMON_ComboAttack, 3.0, top, TARGET_ENE_0, DIST_None, 0);
		
	elseif fate1 < 60 then
    -- �������p�^�[��2
	goal:AddSubGoal( GOAL_COMMON_ComboAttack, 3.0, 700, TARGET_ENE_0, DIST_None, 0);
	goal:AddSubGoal( GOAL_COMMON_ComboAttack, 3.0, 3020, TARGET_ENE_0, DIST_None, 0);
		
	else
	-- �������p�^�[��3
	goal:AddSubGoal( GOAL_COMMON_ComboAttack, 3.0, dashFight, TARGET_ENE_0, DIST_None, 0);
		
	end
end	

---------------------------------------------------------
--  �A���U��_2 �y�������z
---------------------------------------------------------
function Honokaijin405000Battle_enkyori_2(ai, goal, lv )

	-- �����_�����
	local fate1 = ai:GetRandam_Int(1,100)
	local fate2 = ai:GetRandam_Int(1,100)
	local fate3 = ai:GetRandam_Int(1,100)
	
	-- �U���h�c�ꗗ(default:Lv1)
	local rightSmash 	= 3000	-- �E����
	local leftSmash		= 3001	-- ������
    local top           = 3002	-- �ォ�牣��
    local dashFight     = 3050	-- ���ݍ��݊i��
	local tackle		= 3005	-- �ːi
	
	-- �k���Q�̏ꍇ�͍U���h�c��ύX����
	if( lv >= 2 ) then
		rightSmash		= 3007
		leftSmash		= 3008
		top     		= 3009
		dashFight		= 3010
	end
	
	if fate1 < 30 then
	-- �������p�^�[��1
    goal:AddSubGoal( GOAL_COMMON_ComboAttack, 3.0, dashFight, TARGET_ENE_0, DIST_Middle, 0);
    goal:AddSubGoal( GOAL_COMMON_ComboAttack, 3.0, top, TARGET_ENE_0, DIST_Middle, 0);
		
	elseif fate1 < 60 then
    -- �������p�^�[��2
	goal:AddSubGoal( GOAL_COMMON_ComboAttack, 3.0, dashFight, TARGET_ENE_0, DIST_Middle, 0);
	goal:AddSubGoal( GOAL_COMMON_ComboAttack, 3.0, leftSmash, TARGET_ENE_0, DIST_Middle, 0);
		
	else
	-- �������p�^�[��3
	goal:AddSubGoal( GOAL_COMMON_ComboAttack, 3.0, dashFight, TARGET_ENE_0, DIST_Middle, 0);
	goal:AddSubGoal( GOAL_COMMON_ComboAttack, 3.0, leftSmash, TARGET_ENE_0, DIST_Middle, 0);
	goal:AddSubGoal( GOAL_COMMON_ComboAttack, 3.0, 3040, TARGET_ENE_0, DIST_Middle, 0);
	
	end
end	
---------------------------------------------------------
--  �A���U��_3 �y�������z
---------------------------------------------------------
function Honokaijin405000Battle_enkyori_3(ai, goal, lv )

	-- �����_�����
	local fate1 = ai:GetRandam_Int(1,100)
	local fate2 = ai:GetRandam_Int(1,100)
	local fate3 = ai:GetRandam_Int(1,100)
	
	-- �U���h�c�ꗗ(default:Lv1)
	local rightSmash 	= 3000	-- �E����
	local leftSmash		= 3001	-- ������
    local top           = 3002	-- �ォ�牣��
    local dashFight     = 3050	-- ���ݍ��݊i��
	local tackle		= 3005	-- �ːi
	
	-- �k���Q�̏ꍇ�͍U���h�c��ύX����
	if( lv >= 2 ) then
		rightSmash		= 3007
		leftSmash		= 3008
		top     		= 3009
		dashFight		= 3010
	end
	
	if fate1 < 30 then
	-- �������p�^�[��1
    goal:AddSubGoal( GOAL_COMMON_ComboAttack, 3.0, dashFight, TARGET_ENE_0, DIST_None, 0);
    goal:AddSubGoal( GOAL_COMMON_ComboAttack, 3.0, top, TARGET_ENE_0, DIST_None, 0);
	goal:AddSubGoal( GOAL_COMMON_ComboAttack, 3.0, 3020, TARGET_ENE_0, DIST_None, 0);
	
	elseif fate1 < 60 then
    -- �������p�^�[��2
	goal:AddSubGoal( GOAL_COMMON_ComboAttack, 3.0, dashFight, TARGET_ENE_0, DIST_None, 0);
	goal:AddSubGoal( GOAL_COMMON_ComboAttack, 3.0, 3030, TARGET_ENE_0, DIST_None, 0);
		
	else
	-- �������p�^�[��3
	goal:AddSubGoal( GOAL_COMMON_ComboAttack, 3.0, dashFight, TARGET_ENE_0, DIST_None, 0);
	goal:AddSubGoal( GOAL_COMMON_ComboAttack, 3.0, 3020, TARGET_ENE_0, DIST_None, 0);
	goal:AddSubGoal( GOAL_COMMON_ComboAttack, 3.0, 3040, TARGET_ENE_0, DIST_None, 0);
	
	end
end
---------------------------------------------------------
--  �U����s��
---------------------------------------------------------
function Honokaijin405000Battle_kougekigo(ai, goal, lv )

	-- �����_�����
	local fate1 = ai:GetRandam_Int(1,100)
	local fate2 = ai:GetRandam_Int(1,100)
	local fate3 = ai:GetRandam_Int(1,100)
	
	if fate1 < 60 then
	-- �����҂��Ă����U����
		goal:AddSubGoal( GOAL_COMMON_Wait, 1.0, TARGET_NONE, 0, 0, 0 );
	
	else
	-- �o�b�N�X�X�e�b�v�Ŏd�؂�Ȃ���
	
		goal:AddSubGoal(GOAL_COMMON_Step, 5, 701, 0, 0, 0);	
	    goal:AddSubGoal(GOAL_COMMON_Step, 5, 701, 0, 0, 0);	
	end
end

---------------------------------------------------------
--  �S�[���X�V
---------------------------------------------------------
function Honokaijin405000Battle_Update(ai, goal)
	targetDist 	= ai:GetDist(TARGET_ENE_0);
	return GOAL_RESULT_Continue;
end


---------------------------------------------------------
--  �S�[���I��
---------------------------------------------------------
function Honokaijin405000Battle_Terminate(ai, goal)
end



---------------------------------------------------------
--  ���荞��
--	���荞�񂾏ꍇ�ɂ�true��Ԃ��Ă��������B
--	�����Ŋ��荞�ݗp�̃T�u�S�[����ǉ����Ă��������B
--	���荞�܂Ȃ������ꍇ�ɂ́A1��̑w�̃S�[���A�܂��̓��W�b�N�����ɂ���Ċ��荞�݂���������܂��B
---------------------------------------------------------
function Honokaijin405000Battle_Interupt(ai, goal)
local targetDist = ai:GetDist(TARGET_ENE_0);			--�G�^�[�Q�b�g�Ƃ̋������擾

local fate = ai:GetRandam_Int(1,100)					--�m������p
local fate2 = ai:GetRandam_Int(1,100)					--�m������p
local fate3 = ai:GetRandam_Int(1,100)					--�m������p
local fate4 = ai:GetRandam_Int(1,100)					--�m������p


	--���ߋ����Ń_���[�W�󂯂���R���{�Ƃ݂Ȃ��Č��
	if ai:IsInterupt( INTERUPT_Damaged ) then
local combRunDist = 1.0				--�R���{���ꂷ�鋗��
local combRunPer = 30				--�R���{���ꂷ��m��
local combRunCountPer = 35			--�R���{����̌�ɍU������m��	
		if targetDist < combRunDist then
			if fate <= combRunPer then
				goal:ClearSubGoal();
				--�����
				if fate2 <= 40 then
					goal:AddSubGoal( GOAL_COMMON_Step, 7, 702, 0, 0, 0 )
				elseif fate2 <= 80 then
					goal:AddSubGoal( GOAL_COMMON_Step, 7, 703, 0, 0, 0 )
				else
					goal:AddSubGoal( GOAL_COMMON_Step, 7, 701, 0, 0, 0 )
				end	
					if fate3 <= combRunCountPer then
						goal:AddSubGoal( GOAL_COMMON_ComboAttack, 10.0, 3030, TARGET_ENE_0, DIST_Middle, 0);
					end
				return true;
			end
		end
	end	
	
	--���ߋ����ōU�����ꂻ���ɂȂ����璴�����X�e�b�v
	if ai:IsInterupt( INTERUPT_FindAttack ) then
local superStepDist = 1.0			--���������鋗��
local superStepPer = 5				--����������m��	
		if targetDist <= superStepDist then
			if fate <= superStepPer then
			--�����
				if fate2 <= 60 then
					goal:AddSubGoal( GOAL_COMMON_Step, 7, 702, 0, 0, 0 )
				elseif fate2 <= 80 then
					goal:AddSubGoal( GOAL_COMMON_Step, 7, 703, 0, 0, 0 )
				else
					goal:AddSubGoal( GOAL_COMMON_Step, 7, 701, 0, 0, 0 )
				end
				return true;
			end
		end
	end
	
	--��ѓ���������Ă�����œK�s��
	if ai:IsInterupt( INTERUPT_Shoot ) then
local shootIntPer = 20					--��ѓ���g�p���ɍœK�s�������m��
		if fate <= shootIntPer then
			goal:ClearSubGoal();
			if fate2 <= 50 then
				goal:AddSubGoal( GOAL_COMMON_Step, 7, 702, 0, 0, 0 )
			else
				goal:AddSubGoal( GOAL_COMMON_Step, 7, 703, 0, 0, 0 )
			end
			   	return true
		end
	end
	

	
return false;
end




