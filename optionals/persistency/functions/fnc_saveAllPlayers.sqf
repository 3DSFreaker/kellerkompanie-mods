#include "script_component.hpp"

if !(EGVAR(persistency_settings,playersEnabled)) exitWith{WARNING("saveAllPlayers: persistency for players is disabled, exiting!"); false};

private _allHCs = entities "HeadlessClient_F";
private _allHPs = allPlayers - _allHCs;

{
	_x call FUNC(savePlayerLoadout);
} forEach _allHPs;

true
