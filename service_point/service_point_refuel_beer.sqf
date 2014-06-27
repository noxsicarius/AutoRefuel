//Edit by F507DMT, GoldKey http://vk.com/goldkey_dz

private ["_vehicle","_args","_servicePoint","_costs","_updateInterval","_amount","_type","_name"];

_vehicle = _this select 0;
_amount = 0.0013;
if (_vehicle isKindOf "Air") then {_amount = 0.00152;};
if (_vehicle isKindOf "LandVehicle") then {_amount = 0.00132;};
if (_vehicle isKindOf "Truck") then {_amount = 0.00132;};

if (!local _vehicle) exitWith { diag_log format["Error: called service_point_refuel.sqf with non-local vehicle: %1", _vehicle] };

_args = _this select 3;
_servicePoint = _args select 0;
_costs = _args select 1;
_updateInterval = _args select 2;
//_amount = _args select 3;

if !([_costs] call AC_fnc_checkAndRemoveRequirements) exitWith {};

_type = typeOf _vehicle;
_name = getText(configFile >> "cfgVehicles" >> _type >> "displayName");

if (isNil "SP_refueling") then {
	SP_refueling = true;
	
	_vehicle engineOn false;
	titleText [format["О! от души, уже заправляю твой %1 ...", _name], "PLAIN DOWN"];
	[_vehicle,"refuel",0,false] call dayz_zombieSpeak;
	
	while {(vehicle player == _vehicle) && (local _vehicle)} do {
		private ["_fuel","_rNumber"];
		_rNumber = random 0.2;
		if ([0,0,0] distance (velocity _vehicle) > 1) exitWith {
			titleText [format["эээй ты куда поехал?! не дозаправил, же! ну все, плати по новой!", _name], "PLAIN DOWN"];
		};
		_fuel = (fuel _vehicle) + _amount;
		if (_fuel > 0.95) exitWith {
			_vehicle setFuel 1- _rNumber;
			titleText [format["мда.. ага.. полный бак! а я пошел дальше дегустировать!...", _name], "PLAIN DOWN"];
		};
		_vehicle setFuel _fuel;
		sleep _updateInterval;
	};
	
	SP_refueling = nil;
};
