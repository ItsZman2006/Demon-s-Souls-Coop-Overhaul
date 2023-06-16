DAMAGE_REGION_ID__LEFT = 100;
DAMAGE_REGION_ID__RIGHT = 101;
EVENT_ID__DRAGON_DEAMON = 10;


ACTION_PATTERN__NONE				= 0; --何もしない
ACTION_PATTERN__ATTACK_SWORD		= 1; --剣で攻撃
ACTION_PATTERN__DEFENCE_SHIELD		= 2; --縦で防御
ACTION_PATTERN__ATTACK_BOW			= 3; --弓で攻撃
ACTION_PATTERN__RUSH				= 4; --突進
ACTION_PATTERN__ATTACK_BITE			= 5; --噛み付き
ACTION_PATTERN__THREAT				= 6; --威嚇
ACTION_PATTERN__SHOUT				= 7; --雄たけび
ACTION_PATTERN__ATTACK_ROLLING_AXE	= 8; --回転斧
ACTION_PATTERN__DRAGON_R			= 9; --ドラゴン右
ACTION_PATTERN__DRAGON_L			= 10 --ドラゴン左
ACTION_PATTERN__DRAGON_FIRE			= 11; --ドラゴンファイヤー

once = 1;
everytime = 0;


function Initialize_m99_99_99_50(proxy)
	print("テストマップ初期化");
	proxy:OnRegionJustIn( 0, 0, DAMAGE_REGION_ID__LEFT, "OnDamageLeftArm", once );
	proxy:OnRegionJustIn( 0, 0, DAMAGE_REGION_ID__RIGHT, "OnDamageRightArm", once);
end

function OnDamageLeftArm(proxy, param)
	print("■左手破壊");
	proxy:EnableAction( EVENT_ID__DRAGON_DEAMON, ACTION_PATTERN__DRAGON_L, false);
	
	--local boss = proxy:GetBoss( EVENT_ID__DRAGON_DEAMON);
	--boss:Damage_LeftArm();
end

function OnDamageRightArm(proxy, param)
	print("■右手破壊");
	proxy:EnableAction( EVENT_ID__DRAGON_DEAMON, ACTION_PATTERN__DRAGON_R, false);
	
	--local boss = proxy:GetBoss( EVENT_ID__DRAGON_DEAMON);
	--boss:Damage_RightArm();
end


