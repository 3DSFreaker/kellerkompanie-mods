#include "kekoWeapons.hpp"

class kekoFaction
{
	class kekoFactionBase {
		name = objNull;
		roles[] = {};
		weaponCfg = objNull;
		crates[] = {};
	};	

	#include "kekoFactionNATO.hpp"
	#include "kekoFactionAAF.hpp"
	#include "kekoFactionCSAT.hpp"
	#include "kekoFactionCTRG.hpp"
	#include "kekoFactionUSMarines.hpp"
	#include "kekoFactionNATOtropic.hpp"
	#include "kekoFactionMarines_Desert.hpp"
	#include "kekoFactionMarines_Woodland.hpp"
	#include "kekoFactionBundeswehrFleck.hpp"
	#include "kekoFactionBundeswehrTropen.hpp"
	#include "kekoFactionWehrmacht.hpp"
};

