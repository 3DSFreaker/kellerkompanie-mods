class CfgPatches
{
	class babe_core_fnc
	{
		units[] = {};
		weapons[] = {};
		requiredVersion = 0.1;
		requiredAddons[] = {"A3_BaseConfig_F"};
	};
};
class CfgFunctions
{
	class babe_core
	{
		tag = "babe_core";
		class core
		{
			file = "\babe_core\func\core";
			class init
			{
				postInit = 1;
			};
			class addEH{};
			class removeEH{};
			class initFH{};
			class handleEHs{};
			class cachemoddata{};
		};
		class misc
		{
			file = "\babe_core\func\misc";
			class inbbr{};
			class inbbr_pl{};
		};
	};
};
