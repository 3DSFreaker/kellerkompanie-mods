if (!isServer) exitWith {};

params [
	["_unitName", "", [""]],
	["_mode", 3, [0]]
];

{
	_unit = _x;
	diag_log text format["[KEKO] (common) trying to assign zeus to player %1", str _unit];

	if ( isNull (getAssignedCuratorLogic _unit) && str _unit == _unitName ) exitWith {
		_grp = createGroup sideLogic;
		_curator = _grp createUnit ["ModuleCurator_F",[0,0,0],[],0,"NONE"];
		_curator setVariable ["Addons",_mode,true];
		
		_curator addCuratorEditableObjects [vehicles,true];
		_curator addCuratorEditableObjects [(allMissionObjects "Man"), false];
		_curator addCuratorEditableObjects [(allMissionObjects "Air"), true];
		_curator addCuratorEditableObjects [(allMissionObjects "Ammo"), false];
		_curator setVariable ["birdType",""];
		_curator setVariable ["showNotification",false];
		[_curator, [-1, -2, 2]] call bis_fnc_setCuratorVisionModes;
		
		_curator addEventHandler ["CuratorPinged", {
			_curator = _this select 0;
			_zeus = getAssignedCuratorUnit _curator;
			if (isNull _zeus) then {
				unassignCurator _curator;
				deleteVehicle _curator;
			};
		}];
						
		_unit assignCurator _curator;
	};
	nil;
} count allPlayers;

true;