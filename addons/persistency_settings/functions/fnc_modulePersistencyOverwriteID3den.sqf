#include "script_component.hpp"

private _logic = _this select 0;

INFO("running modulePersistencyOverwriteID3den");

private _overwriteID = parseNumber (_logic getVariable ["ID", "-1"]);

if(_overwriteID == -1) exitWith{"ERROR: ID of persistency overwrite cannot be -1" remoteExec ["systemChat", 0]; false};

private _objects = synchronizedObjects _logic;

if ((count _objects) == 1) then {
  private _object = _objects select 0;
  TRACE_2("overwriting ID of object", _object, _overwriteID);

  if(_object isKindOf "ReammoBox_F") then {
    _object setVariable [QGVAR(crateID), _overwriteID, true];
    true
  };

  if(_object isKindOf "Plane" || _object isKindOf "Helicopter" || _object isKindOf "Ship" || _object isKindOf "Car" || _object isKindOf "Tank") then {
    _object setVariable [QGVAR(vehicleID), _overwriteID, true];
    true
  };

  true
} else {
  "ERROR: synchronize Persistency overwrite module to exactly 1 object" remoteExec ["systemChat", 0];
  false
};
