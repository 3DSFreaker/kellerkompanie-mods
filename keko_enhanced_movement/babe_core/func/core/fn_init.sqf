if (isDedicated) exitWith {};

#include "\a3\editor_f\Data\Scripts\dikCodes.h"

["Enhanced Movement","babe_core_jump_climb_key", "Jump/Climb", {[player, false] call babe_em_fnc_detect}, "", [0, [true, false, false]]] call CBA_fnc_addKeybind;
["Enhanced Movement","babe_core_use_key", "Use", {_this call babe_int_fnc_use}, "", [0, [true, false, false]]] call CBA_fnc_addKeybind;
["Enhanced Movement","babe_core_self_interaction_key", "Self Interaction", {_this call babe_int_fnc_self}, "", [0, [true, false, false]]] call CBA_fnc_addKeybind;
["Enhanced Movement","babe_core_jump_only_key", "Jump only", {_this call babe_em_fnc_jump_only}, "", [0, [true, false, false]]] call CBA_fnc_addKeybind;
["Enhanced Movement","babe_core_climb_only_key", "Climb only", {[player, true] call babe_em_fnc_detect_cl_only}, "", [0, [true, false, false]]] call CBA_fnc_addKeybind;



babe_core_keysdown = [];
babe_core_keysbusy = [];

babe_core_busy = false;

babe_core_EHs = [];
	
["babe_mainloop", "onEachFrame", babe_core_fnc_handleEHs] call BIS_fnc_addStackedEventHandler;	

babe_core_init = true;

call babe_core_fnc_cachemoddata;