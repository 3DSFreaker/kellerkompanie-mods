_logic = _this select 0;
_units = _this select 1;
_activated = _this select 2;

if !(_activated && local _logic) exitWith {};

//if (_activated && local _logic && !isnull curatorcamera) then {
    _unit = objnull;
    _mouseOver = missionnamespace getvariable ["bis_fnc_curatorObjectPlaced_mouseOver",[""]];
    if ((_mouseOver select 0) == typename objnull) then {
        _unit = _mouseOver select 1;
    };
    if(isnull _unit) then {
        [objnull, "Error - Module was not placed on any object"] call bis_fnc_showCuratorFeedbackMessage;
        deletevehicle _logic;
    };

    if(isNull _unit) exitWith{};

    _unitName = name _unit;
    //hint format ["Placed module on unit %1", _unitName];
    [_unit] call keko_fnc_initLoadoutObject;
    [_unit] call keko_fnc_initPersistentLoadoutObject;

    deletevehicle _logic;
//};