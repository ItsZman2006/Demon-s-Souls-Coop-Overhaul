DAMAGE_REGION_ID__LEFT = 100;
DAMAGE_REGION_ID__RIGHT = 101;
EVENT_ID__DRAGON_DEAMON = 10;


ACTION_PATTERN__NONE				= 0; --�������Ȃ�
ACTION_PATTERN__ATTACK_SWORD		= 1; --���ōU��
ACTION_PATTERN__DEFENCE_SHIELD		= 2; --�c�Ŗh��
ACTION_PATTERN__ATTACK_BOW			= 3; --�|�ōU��
ACTION_PATTERN__RUSH				= 4; --�ːi
ACTION_PATTERN__ATTACK_BITE			= 5; --���ݕt��
ACTION_PATTERN__THREAT				= 6; --�Њd
ACTION_PATTERN__SHOUT				= 7; --�Y������
ACTION_PATTERN__ATTACK_ROLLING_AXE	= 8; --��]��
ACTION_PATTERN__DRAGON_R			= 9; --�h���S���E
ACTION_PATTERN__DRAGON_L			= 10 --�h���S����
ACTION_PATTERN__DRAGON_FIRE			= 11; --�h���S���t�@�C���[

once = 1;
everytime = 0;


function Initialize_m99_99_99_50(proxy)
	print("�e�X�g�}�b�v������");
	proxy:OnRegionJustIn( 0, 0, DAMAGE_REGION_ID__LEFT, "OnDamageLeftArm", once );
	proxy:OnRegionJustIn( 0, 0, DAMAGE_REGION_ID__RIGHT, "OnDamageRightArm", once);
end

function OnDamageLeftArm(proxy, param)
	print("������j��");
	proxy:EnableAction( EVENT_ID__DRAGON_DEAMON, ACTION_PATTERN__DRAGON_L, false);
	
	--local boss = proxy:GetBoss( EVENT_ID__DRAGON_DEAMON);
	--boss:Damage_LeftArm();
end

function OnDamageRightArm(proxy, param)
	print("���E��j��");
	proxy:EnableAction( EVENT_ID__DRAGON_DEAMON, ACTION_PATTERN__DRAGON_R, false);
	
	--local boss = proxy:GetBoss( EVENT_ID__DRAGON_DEAMON);
	--boss:Damage_RightArm();
end


