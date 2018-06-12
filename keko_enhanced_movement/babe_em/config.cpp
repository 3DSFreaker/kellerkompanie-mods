class CfgPatches
{
	class babe_em
	{
		units[] = {"babe_helper"};
		weapons[] = {};
		requiredVersion = 0.1;
		requiredAddons[] = {"babe_core","A3_characters_F"};
	};
};
class CfgVehicles
{
	class All{};
	class Static: All{};
	class Building: Static{};
	class NonStrategic: Building{};
	class TargetTraining: NonStrategic{};
	class TargetGrenade: TargetTraining{};
	class babe_helper: TargetGrenade
	{
		model = "\babe_em\models\helper.p3d";
		armor = 20000;
		scope = 2;
		displayName = "helper";
		icon = "iconObject";
		mapSize = 0.7;
		accuracy = 0.2;
		hiddenSelections[] = {"camo"};
	};
};
