STUI_NT_Cache_LastCheckedUnit = objNull;
STUI_NT_Cache_LastValidCheckTime = 0;
STUI_NT_DrawData = [];

STUI_NT_FadeOutTime = 0.5;
STUI_NT_MaxDrawRangeName = 40;
STUI_NT_MaxDrawRangeNameDead = 3.5;
STUI_NT_MaxDrawRangeGroup = 20;

STUI_NT_Main   = [1.00, 1.00, 1.00, 1.00];
STUI_NT_Red    = [1.00, 0.20, 0.00, 1.00];
STUI_NT_Green  = [0.00, 1.00, 0.00, 1.00];
STUI_NT_Blue   = [0.00, 0.60, 1.00, 1.00];
STUI_NT_Yellow = [0.85, 0.85, 0.00, 1.00];

STUI_NT_NoTeam = [0.20, 1.00, 0.00, 1.00];

STUI_NT_OwnGroup   = STUI_NT_Main;
STUI_NT_OtherName  = [0.20, 1.00, 0.00, 1.0];
STUI_NT_OtherGroup = [0.60, 0.85, 0.60, 1.0];
STUI_NT_DeadName = [1, 1, 1, 1.0];

STUI_NT_Colours =
[
     STUI_NT_Main
    ,STUI_NT_Red
    ,STUI_NT_Green
    ,STUI_NT_Blue
    ,STUI_NT_Yellow
];

if (isNil "STUI_RemoveDeadViaProximity") then {STUI_RemoveDeadViaProximity = true};

STNT_Update =
{
    if (!(call STUI_Canvas_ShownHUD)) exitWith {};

    params ["_canvas"];

    private _nameFade = 1;
    private _groupFade = 1;
    private _toFade = true;
    private _targetUnit = effectiveCommander(cursorTarget);

    // Never show the player
    if (_targetUnit == player) then
    {
        _targetUnit = objNull;
    };

    if (alive(_targetUnit) && {side(group(_targetUnit)) == playerSide} && {alive(vehicle(_targetUnit))}) then
    {
        private ["_pos", "_angleSize", "_inAngle", "_rangeModifier", "_darknessPenalty"];

        _pos = cursorTarget modelToWorld [0,0,1.4];
        _angleSize = 5;

        private "_vehicle";
        _vehicle = vehicle(player);

        private ["_distance", "_minDist", "_maxAngle"];
        _distance = player distance cursorTarget;
        if (cursorTarget isKindOf "CAManBase") then
        {
            if (_vehicle == player) then
            {
                _minDist = 5;
                _maxAngle = 30;
            }
            else
            {
                _minDist = 10;
                _maxAngle = 45;
            };
        }
        else
        {
            _minDist = 20;
            _maxAngle = 60;
        };
        if (_distance <= _minDist) then
        {
            _angleSize = linearConversion [0, _minDist, _distance, _maxAngle, 5, true];
        };

        private "_aimDir";
        if (_vehicle == player) then
        {
            _aimDir = getDirVisual(player);
        }
        else
        {
            private "_role";
            _role = assignedVehicleRole player;
            if ((_role select 0) != "Driver") then
            {
                private "_weapons";
                _weapons = _vehicle weaponsTurret (_role select 1);

                if (count(_weapons) > 0) then
                {
                    _weapDir = _vehicle weaponDirection(_weapons select 0);
                    _aimDir = (_weapDir select 0) atan2 (_weapDir select 1);
                };
            };
        };

        if (isNil "_aimDir") then
        {
            _inAngle = false;
        }
        else
        {
            _inAngle = [getPosATLVisual(_vehicle), _aimDir, _angleSize, _pos] call bis_fnc_inAngleSector;
        };

        _vis = 1;

        if (_inAngle && STUI_Occlusion) then
        {
            _vis = [(vehicle cursorTarget), "VIEW"] checkVisibility [eyePos player,  AGLToASL (cursorTarget modelToWorldVisual (cursorTarget selectionPosition "Spine3"))];
        };

        if (_inAngle && _vis >= .9) then
        {
            _toFade = false;
            private ["_colour","_colourGroup"];

            // If in normal vision, ranges reduce from darkness. Nightvision helps to counter this, but not perfectly.
            if (currentVisionMode player isEqualTo 0) then
            {
                _darknessPenalty = linearConversion [0, 1, sunOrMoon, 0.25, 0.0, true];
                _rangeModifier   = linearConversion [0, 1, sunOrMoon, 0.50, 1.0, true];
            }
            else
            {
                _darknessPenalty = 0.0;
                _rangeModifier   = linearConversion [0, 1, sunOrMoon, 0.75, 1.0, true];
            };

            _nameFade  = (linearConversion [0, (STUI_NT_MaxDrawRangeName * _rangeModifier), _distance, 1, 0, true]) - _darknessPenalty;
            _groupFade = (linearConversion [0, (STUI_NT_MaxDrawRangeGroup * _rangeModifier), _distance, 0.7, 0, true]) - _darknessPenalty;

            STUI_NT_Cache_LastFade = _nameFade;
            STUI_NT_Cache_LastFadeGroup = _groupFade;

            private ["_in_group", "_stgi_colour", "_isUsingTeams"];
            _in_group = _targetUnit in (units group player);
            if (_in_group) then
            {
                _stgi_colour = _targetUnit call STUI_assignedTeamIndex;
                _isUsingTeams = call STUI_UsingTeams;
            }
            else
            {
                _stgi_colour = "";
                _isUsingTeams = false;
            };

            private "_refreshLabel";
            _refreshLabel = (count(STUI_NT_DrawData) isEqualTo 0) || {STUI_NT_Cache_LastCheckedUnit != _targetUnit};
            if (!_refreshLabel) then
            {
                if (!([_in_group, _stgi_colour, _isUsingTeams] isEqualTo STUI_NT_Cache_LabelState)) then
                {
                    _refreshLabel = true;
                };
            };

            if (_refreshLabel) then
            {
                if (_in_group) then
                {
                    if (_isUsingTeams) then
                    {
                        _colour = STUI_NT_Colours select _stgi_colour;
                    }
                    else
                    {
                        _colour = STUI_NT_NoTeam;
                    };

                    _colourGroup = STUI_NT_OwnGroup;
                }
                else
                {
                    _colour = STUI_NT_OtherName;
                    _colourGroup = STUI_NT_OtherGroup;
                };

                private ["_nameText", "_groupText"];
                STUI_NT_Cache_LastCheckedUnit = _targetUnit;
                STUI_NT_Cache_LabelState = [_in_group, _stgi_colour, _isUsingTeams];
                STUI_NT_DrawData = [
                    [
                         "#(argb,8,8,3)color(0,0,0,0)"
                        ,[_colour select 0, _colour select 1, _colour select 2, _nameFade]
                        ,_canvas ctrlMapScreenToWorld [0.5, 0.535]
                        ,0, 0, 0
                        ,name(_targetUnit)
                        ,2, 0.035, "PuristaSemiBold", "center"
                    ],
                    [
                        "#(argb,8,8,3)color(0,0,0,0)"
                        ,[_colourGroup select 0, _colourGroup select 1, _colourGroup select 2, _groupFade]
                        ,_canvas ctrlMapScreenToWorld [0.5, 0.565]
                        ,0, 0, 0
                        ,groupID(group(_targetUnit))
                        ,0, 0.030, "PuristaMedium", "center"
                    ]
                ];
            }
            else
            {
                ((STUI_NT_DrawData select 0) select 1) set [3, _nameFade];
                ((STUI_NT_DrawData select 1) select 1) set [3, _groupFade];
            };

            STUI_NT_Cache_LastValidCheckTime = time;
        };
    }
    else // Displaying dead unit names if they're on the same side as you
    {
        _targetUnit = cursorTarget; // effectiveCommander returns null when the unit is dead > 15 seconds or so

        if (!alive(_targetUnit) && (_targetUnit isKindOf "MAN")) then
        {

            private _deadSide = _targetUnit getVariable ["STMF_Side",toLower(str playerSide)];
            private _deadName = _targetUnit getVariable ["STMF_Name","Unknown"];

            // This is all duplicated right now for speed's sake; if someone wants to overhaul it to be nicer and integrate it into the above check, feel free.
            if (toLower _deadSide == toLower str(playerSide)) then // If they were on the same side, then show their name
            {
                private ["_pos", "_angleSize", "_inAngle", "_rangeModifier", "_darknessPenalty"];

                _pos = cursorTarget modelToWorld [0,0,1.4];
                _angleSize = 5;

                private _vehicle = vehicle(player);

                private ["_distance", "_minDist", "_maxAngle"];
                _distance = player distance cursorTarget;
                if (cursorTarget isKindOf "CAManBase") then
                {
                    if (_vehicle == player) then
                    {
                        _minDist = 5;
                        _maxAngle = 30;
                    }
                    else
                    {
                        _minDist = 10;
                        _maxAngle = 45;
                    };
                }
                else
                {
                    _minDist = 20;
                    _maxAngle = 60;
                };
                if (_distance <= _minDist) then
                {
                    _angleSize = linearConversion [0, _minDist, _distance, _maxAngle, 5, true];
                };

                private "_aimDir";
                if (_vehicle == player) then
                {
                    _aimDir = getDirVisual(player);
                }
                else
                {
                    private _role = assignedVehicleRole player;
                    if ((_role select 0) != "Driver") then
                    {
                        private _weapons = _vehicle weaponsTurret (_role select 1);

                        if (count(_weapons) > 0) then
                        {
                            _weapDir = _vehicle weaponDirection(_weapons select 0);
                            _aimDir = (_weapDir select 0) atan2 (_weapDir select 1);
                        };
                    };
                };

                if (isNil "_aimDir") then
                {
                    _inAngle = false;
                }
                else
                {
                    _inAngle = [getPosATLVisual(_vehicle), _aimDir, _angleSize, _pos] call bis_fnc_inAngleSector;
                };

                if (_inAngle) then
                {
                    _toFade = false;
                    private ["_colour","_colourGroup"];

                    // If in normal vision, ranges reduce from darkness. Nightvision helps to counter this, but not perfectly.
                    if (currentVisionMode player isEqualTo 0) then
                    {
                        _darknessPenalty = linearConversion [0, 1, sunOrMoon, 0.25, 0.0, true];
                        _rangeModifier   = linearConversion [0, 1, sunOrMoon, 0.50, 1.0, true];
                    }
                    else
                    {
                        _darknessPenalty = 0.0;
                        _rangeModifier   = linearConversion [0, 1, sunOrMoon, 0.75, 1.0, true];
                    };

                    _nameFade  = (linearConversion [0, (STUI_NT_MaxDrawRangeNameDead * _rangeModifier), _distance, 1, 0, true]) - _darknessPenalty;
                    _groupFade = (linearConversion [0, (STUI_NT_MaxDrawRangeGroup * _rangeModifier), _distance, 0.7, 0, true]) - _darknessPenalty;

                    STUI_NT_Cache_LastFade = _nameFade;
                    STUI_NT_Cache_LastFadeGroup = _groupFade;

                    private ["_in_group", "_stgi_colour", "_isUsingTeams"];

                    _stgi_colour = "";
                    _isUsingTeams = false;

                    private _refreshLabel = (count(STUI_NT_DrawData) isEqualTo 0) || {STUI_NT_Cache_LastCheckedUnit != _targetUnit};
                    if (!_refreshLabel) then
                    {
                        if (!([_in_group, _stgi_colour, _isUsingTeams] isEqualTo STUI_NT_Cache_LabelState)) then
                        {
                            _refreshLabel = true;
                        };
                    };

                    if (_refreshLabel) then
                    {
                        _colour = STUI_NT_DeadName;
                        _colourGroup = STUI_NT_OtherGroup;

                        private ["_nameText", "_groupText"];
                        STUI_NT_Cache_LastCheckedUnit = _targetUnit;
                        STUI_NT_Cache_LabelState = [_in_group, _stgi_colour, _isUsingTeams];
                        STUI_NT_DrawData = [
                            [
                                 "#(argb,8,8,3)color(0,0,0,0)"
                                ,[_colour select 0, _colour select 1, _colour select 2, _nameFade]
                                ,_canvas ctrlMapScreenToWorld [0.5, 0.535]
                                ,0, 0, 0
                                ,_deadName
                                ,2, 0.035, "PuristaSemiBold", "center"
                            ],
                            [
                                "#(argb,8,8,3)color(0,0,0,0)"
                                ,[_colourGroup select 0, _colourGroup select 1, _colourGroup select 2, _groupFade]
                                ,_canvas ctrlMapScreenToWorld [0.5, 0.565]
                                ,0, 0, 0
                                ,""
                                ,0, 0.030, "PuristaMedium", "center"
                            ]
                        ];
                    }
                    else
                    {
                        ((STUI_NT_DrawData select 0) select 1) set [3, _nameFade];
                        ((STUI_NT_DrawData select 1) select 1) set [3, _groupFade];
                    };

                    //checking if the dead target is within range and if they are in your group
                    if (_distance <= STUI_NT_MaxDrawRangeNameDead && {_targetUnit in units player}) then
                    {
                        private _visToDeadTarget = [vehicle _targetUnit, "VIEW"] checkVisibility [eyePos player,  AGLToASL (_targetUnit modelToWorldVisual (_targetUnit selectionPosition "Spine3"))];
                        //allowing a little bit of obstruction between player and target since it can be affected by smoke, clutter, etc
                        if (_visToDeadTarget >= 0.5 && STUI_RemoveDeadViaProximity) then
                        {
                            [_targetUnit] joinSilent grpNull;
                        };
                    };

                    STUI_NT_Cache_LastValidCheckTime = time;
                };
            };
        };
    };

    if (count(STUI_NT_DrawData) isEqualTo 0) exitWith {};

    if (_toFade) then
    {
        _fadeTime = time - STUI_NT_Cache_LastValidCheckTime;
        if (_fadeTime < STUI_NT_FadeOutTime) then
        {
            _nameFade  = linearConversion [0, STUI_NT_FadeOutTime, _fadeTime, STUI_NT_Cache_LastFade, 0, true];
            _groupFade = linearConversion [0, STUI_NT_FadeOutTime, _fadeTime, STUI_NT_Cache_LastFadeGroup, 0, true];
            ((STUI_NT_DrawData select 0) select 1) set [3, _nameFade];
            ((STUI_NT_DrawData select 1) select 1) set [3, _groupFade];
        }
        else
        {
            STUI_NT_DrawData = [];
        };
    };

    {_canvas drawIcon _x} forEach STUI_NT_DrawData;
};

"STNT_Update" call STUI_Canvas_Add;

// Compatability for people not using STMF
private _stmf = isClass (configfile >> 'CfgPatches' >> 'STMF');
if (!_stmf && hasInterface) then {
    [] spawn {
        waitUntil {!isNull player};
        waitUntil {time>1};
        STMF_PlayerSide = playerSide;
        STMF_PlayerName = name(player);
        player setVariable ["STMF_Name", STMF_PlayerName, true];
        player setVariable ["STMF_Side", str STMF_PlayerSide, true];
    };
};
