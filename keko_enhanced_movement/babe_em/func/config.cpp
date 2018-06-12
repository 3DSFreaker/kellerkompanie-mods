class DefaultEventhandlers;
class CfgPatches
{
	class babe_em_fnc
	{
		units[] = {};
		weapons[] = {};
		requiredVersion = 0.1;
		requiredAddons[] = {"A3_BaseConfig_F","babe_core_fnc"};
	};
};
class CfgFunctions
{
	class babe_em
	{
		tag = "babe_em";
		class core
		{
			file = "\babe_em\func\core";
			class init{};
		};
		class EH
		{
			file = "\babe_em\func\EH";
			class handledamage_nofd{};
			class animdone{};
		};
		class move
		{
			file = "\babe_em\func\mov";
			class em{};
			class exec_em{};
			class finish_em{};
			class exec_drop{};
			class finish_drop{};
			class jump{};
			class jump_only{};
			class detect{};
			class detect_cl_only{};
			class walkonstuff{};
		};
	};
};
