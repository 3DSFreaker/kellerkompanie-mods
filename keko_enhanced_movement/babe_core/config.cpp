class CfgPatches
{
	class babe_core
	{
		units[] = {};
		weapons[] = {};
		requiredVersion = 0.1;
		requiredAddons[] = {	
			"cba_main",
        	"cba_keybinding",
        	"cba_settings"
        };
	};
};

class Extended_PreInit_EventHandlers {
	babe_core_xeh = call compile preprocessFileLineNumbers "\babe_core\XEH_preInit.sqf";
};