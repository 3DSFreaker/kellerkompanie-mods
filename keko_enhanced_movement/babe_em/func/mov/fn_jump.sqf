private _anm = "";
		
if (isTouchingGround player && load player < _wlj) then
{
	switch (true) do
	{
		case (currentWeapon player == ""):
		{
			_anm = "babe_em_jump_ua";
		};
		case (currentWeapon player == primaryWeapon player):
		{
			_anm = "babe_em_jump_rfl";
		};
		case (currentWeapon player == handgunWeapon player):
		{
			_anm = "babe_em_jump_pst";
		};
	};
	player playActionNow _anm;

	_vel = velocity player; 
	_ppos = getposASL player;
	player setposASL [_ppos select 0, _ppos select 1, (_ppos select 2)+0.1];


	_jh = (3-(loadabs player)*0.001) max 0;

	player setvelocity [(_vel select 0), (_vel select 1), _jh];
	player setStamina (getstamina player)-8;

} else
{
	_babe_em_vars = player getvariable "babe_em_vars";
	_babe_em_vars set [1, false];
	player setVariable ["babe_em_vars", _babe_em_vars];
};



