params ["_object"];

//_object addAction [("<t color='#A6A600' size='2' align='center'>" + ("Fast-Travel") + "</t>"), {createDialog "keko_teleport_mainDialog";}];
[_object, [("<t color='#008800' size='2' align='center'>" + ("Loadout") + "</t>"), {createDialog "keko_loadout_menuDialog";}, _object]] remoteExec ["addAction", 0, true];