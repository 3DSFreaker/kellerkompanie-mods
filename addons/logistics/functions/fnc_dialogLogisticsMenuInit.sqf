#include "script_component.hpp"

disableSerialization;

private _display = _this select 0;
private _listBox = _display displayCtrl 1500;

lbClear _listBox;

private _crates = [];

if(GVAR(customLogistics) == 2) then {
	_crates = [["Kisten", GVAR(customCrates)]];
}
else {
	_crates = getArray (configFile >> "kekoFaction" >> EGVAR(loadout,loadFaction) >> "crates");
};

TRACE_1("logisticsMenuInit", _crates);

private _i = 0;
{
	private _section_title = _x select 0;
	lbAdd [1500, format ["------ %1 ------", _section_title]];
	lbSetData [1500, _i, ""];
	_i = _i + 1;

	private _section_crates = _x select 1;

	{
		private _crate_name = "";
		if(GVAR(customLogistics) == 2) then {
			_crate_name = _x select 0;
			lbAdd [1500, _crate_name];
			private _escapedString = [_crate_name, " ", "%20"] call EFUNC(common,replaceString);
			lbSetData [1500, _i, format ["%1", _escapedString]];
		}
		else {
			_crate_name = getText (configFile >> "kekoFaction" >> EGVAR(loadout,loadoutFaction) >> _x >> "name");
			lbAdd [1500, _crate_name];
			lbSetData [1500, _i, format ["%1 %2", EGVAR(loadout,loadoutFaction), _x]];
		};

		_i = _i + 1;
	} forEach _section_crates;
} forEach _crates;
