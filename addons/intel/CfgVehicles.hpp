class CfgVehicles {
    class Logic;
    class Module_F: Logic {
        class EventHandlers;
        class ModuleDescription;

        class AttributesBase
		{
			class Default;
			class Edit;
			class Combo;
			class Checkbox;
			class CheckboxNumber;
			class ModuleDescription;
			class Units;
		};
    };
    class GVAR(moduleAddIntel3den): Module_F {
        scope              = 2;
        scopeCurator       = 1;
        displayName        = "Add Intel";
        category           = QGVAR(Intel);
        function           = QFUNC(moduleAddIntel3den);
        functionPriority   = 1;
        isGlobal           = 1;
        isTriggerActivated = 1;
        isDisposable       = 0;
        icon = QPATHTOF(ui\icon_intel.paa);

		class Attributes: AttributesBase {
            class Action: Edit {
                property = QGVAR(Action);
                displayName = "Action";
                typeName = "STRING";
                defaultValue = "'Dokument aufheben'";
            };
			class Title: Edit {
				property = QGVAR(Title);
				displayName = "Title";
				typeName = "STRING";
				defaultValue = "'Gefundene Dokumente'";
			};
			class Content: Edit {
				property = QGVAR(Content);
                displayName = "Content";
                typeName = "STRING";
                defaultValue = "'In den Dokumenten steht etwas.'";
            };
            class Remove: Checkbox {
                property = QGVAR(Remove);
                displayName = "Remove after";
                typeName = "BOOL";
                defaultValue = false;
            };
		};
    };
	class keko_ModuleAddIntel3den: GVAR(moduleAddIntel3den) {
		displayName        = "(DEPRECATED - DO NOT USE) Add Intel";
		category           = QEGVAR(common,Deprecated);
	};
    class GVAR(moduleAddIntel): Module_F {
        displayName        = "Add Intel";
        icon               = QPATHTOF(ui\icon_intel.paa);
        category           = QGVAR(Intel);
        function           = QFUNC(moduleAddIntel);
        functionPriority   = 1;
        isGlobal           = 1;
        isTriggerActivated = 0;
        scope              = 1;
        scopeCurator       = 2;
        curatorCanAttach   = 1;
    };
};
