// class Stamina
// displayname = "On"; value = 1; function = "player enableStamina true"; multiplayer = 0;
// displayname = "Off"; value = 2; function = "player enableStamina false"; multiplayer = 0;
["babe_core_setting_stamina", "LIST", ["Enable Stamina", "Enable/Disable Stamina"], "Enhanced Movement", [[1,2], ["Enabled","Disabled"], 0]] call cba_settings_fnc_init;

// class walkonstuff
// displayname = "On";
// value = 1;
// function = "['EH_em_walkonstuff', {true}, [], babe_em_fnc_walkonstuff, [], false, {}, [], -1] call babe_core_fnc_addEH;";
// multiplayer = 0;
// displayname = "Off";
// value = 2;
// function = "['EH_em_walkonstuff'] call babe_core_fnc_removeEH;";
// multiplayer = 0;
["babe_core_setting_walkonstuff", "LIST", ["Forced Walkable Surface", "Forced Walkable Surface"], "Enhanced Movement", [[1,2], ["Enabled","Disabled"], 0]] call cba_settings_fnc_init;


// class SelfInteraction
// displayname = "On";
// value = 1;
// displayname = "Off";
// value = 2;
["babe_core_setting_selfinteraction", "LIST", ["Self Interaction", "Self Interaction"], "Enhanced Movement", [[1,2], ["Enabled","Disabled"], 0]] call cba_settings_fnc_init;


// class VehicleInteraction
// displayname = "Menu";
// value = 1;,
// displayname = "Fast";
// value = 2;
// displayname = "Off";
// value = 3;
["babe_core_setting_vehicleinteraction", "LIST", ["Vehicle Interaction", "Vehicle Interaction"], "Enhanced Movement", [[1,2,3], ["Menu","Fast","Off"], 0]] call cba_settings_fnc_init;