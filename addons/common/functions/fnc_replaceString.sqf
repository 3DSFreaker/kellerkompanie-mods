#include "script_component.hpp"

params ["_str", "_toFind", "_subsitution", ["_numLimit",10,[1]], ["_limit",true,[true]]];
if (typeName _toFind != typeName []) then {_toFind = [_toFind]};
{
    private _char = count _x;
    private _no = _str find _x;
    private _loop = 0;
    while {-1 != _str find _x && _loop < _numLimit} do {
        _no = _str find _x;
        private _splitStr = _str splitString "";
        _splitStr deleteRange [(_no +1), _char -1];
        _splitStr set [_no, _subsitution];
        _str = _splitStr joinString "";
        if (_limit) then {_loop = _loop +1;};
    };
} forEach (_toFind);
_str
