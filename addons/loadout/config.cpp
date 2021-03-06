#include "script_component.hpp"

class CfgPatches {
	class ADDON {
        name = COMPONENT_NAME;
		units[] = {
            QGVAR(moduleAddLoadoutMenu),
            QGVAR(moduleAddLoadoutMenu3den),
            QGVAR(moduleCustomLoadouts3den),
			"keko_ModuleAddLoadoutMenu3den",
			"keko_ModuleCustomLoadouts3den"
        };
        weapons[] = {};
		requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {
			"ace_main",
			"ace_modules",
			"keko_faction_generic"};
        author = ECSTRING(common,KEKOTeam);
        authors[] = {"Schwaggot"};
        url = ECSTRING(main,URL);
        VERSION_CONFIG;
	};
};

#include "CfgEventHandlers.hpp"
#include "CfgFactionClasses.hpp"
#include "CfgVehicles.hpp"
#include "defines.hpp"

#include "ui\dialog_loadoutMenu.hpp"

#include "factions\kekoFaction.hpp"
