#include "script_component.hpp"

params ["_buildingOld", "_buildingNew", "_isRuin"];

if (_isRuin) then {
    private _buildingPos = getPos _buildingOld;
    private _radius = sizeOf typeOf _buildingOld / 2;
    private _aiInBuilding = _buildingPos nearEntities ["Man", _radius];
    private _objectsInBuilding = nearestObjects [_buildingPos, ["NonStrategic","Strategic","Thing"], _radius];

    _objectsInBuilding deleteAt (_objectsInBuilding find _buildingNew);

    {
        if (!isPlayer _x) then {
            _x setDamage [1, false];
        };
    } forEach _aiInBuilding;

    {deleteVehicle _x} forEach _objectsInBuilding;

    INFO("Killed AI and removed objects from a ruin");
};
