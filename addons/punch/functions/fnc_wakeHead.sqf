#include "script_component.hpp"

if (!GVAR(enabled)) exitWith {WARNING("punching disabled, exiting"); false};

[_this select 0, _this select 1] spawn {
	private _player = _this select 0;
	private _target = _this select 1;

	_player playActionNow "PutDown";

	sleep 0.5;

	[_target, QGVAR(InhaleSound)] remoteExec ["say3D", 0, false];

	sleep 4;

	[_target, false, 7, true] call ace_medical_fnc_setUnconscious;
};
