// Vehicle Service Point by Axe Cop
//Edit by F507DMT, GoldKey http://vk.com/goldkey_dz

private ["_folder","_servicePointClasses","_maxDistance","_actionTitleFormat","_actionCostsFormat","_costsFree","_message","_messageShown","_refuel_enable","_refuel_costs","_refuel_beer_costs","_refuel_updateInterval","_refuel_amount","_repair_enable","_repair_costs","_repair_repairTime","_rearm_enable","_rearm_costs","_rearm_magazineCount","_lastVehicle","_lastRole","_fnc_removeActions","_fnc_getCosts","_fnc_actionTitle","_fnc_isArmed","_fnc_getWeapons"];

// ---------------- CONFIG START ----------------

// general settings
_folder = "service_point\"; // folder where the service point scripts are saved, relative to the mission file
_servicePointClasses = dayz_fuelpumparray; // service point classes (can be house, vehicle and unit classes)
_maxDistance = 15; // maximum distance from a service point for the options to be shown
_actionTitleFormat = "%1 (%2)"; // text of the vehicle menu, %1 = action name (Refuel, Repair, Rearm), %2 = costs (see format below)
_actionCostsFormat = "%2 %1"; // %1 = item name, %2 = item count
_costsFree = "Бесплатно"; // text for no costs
_message = "Заправить, починить, зарядить патроны? Подъезжай, не дорого!"; // message to be shown when in range of a service point (set to "" to disable)

// refuel settings
_refuel_enable = true; // enable or disable the refuel option

_refuel_costs = [

["GNT_C185T",["ItemGoldBar",2]], 
["GNT_C185C",["ItemGoldBar",2]], 
["GNT_C185R",["ItemGoldBar",2]], 
["GNT_C185",["ItemGoldBar",2]], 
["GNT_C185U",["ItemGoldBar",2]], 

["An2_2_TK_CIV_EP1",["ItemGoldBar",2]],
["An2_1_TK_CIV_EP1",["ItemGoldBar",2]],
["AN2_DZ",["ItemGoldBar",2]], 

["AH6X_DZ",["ItemGoldBar",2]], 
["MH6J_DZ",["ItemGoldBar",2]], 

["pook_H13_civ",["ItemGoldBar",2]],
["pook_H13_civ_ru_yellow",["ItemGoldBar",2]],
["pook_H13_civ_ru_black",["ItemGoldBar",2]],
["pook_H13_medevac_CIV_RU",["ItemGoldBar",2]],

["CSJ_GyroP",["ItemGoldBar",2]],
["CSJ_GyroCover",["ItemGoldBar",2]],
["CSJ_GyroC",["ItemGoldBar",2]],
["Air",["ItemGoldBar10oz",1]], 

["Wheeled_APC",["ItemGoldBar",5]], 
["Truck",["ItemGoldBar",5]],
["Motorcycle",["ItemGoldBar",1]],
["Car",["ItemGoldBar",2]],
["Tank",["ItemGoldBar10oz",1]],
["M113_TK_EP1",["ItemGoldBar",5]],
["M113Ambul_TK_EP1_DZ",["ItemGoldBar",3]],
["Ship",["ItemGoldBar",2]],

["AllVehicles",["ItemGoldBar",5]]

];

_refuel_beer_costs = [

["GNT_C185T",["ItemSodaRabbit",1]], 
["GNT_C185C",["ItemSodaRabbit",1]], 
["GNT_C185R",["ItemSodaRabbit",1]], 
["GNT_C185",["ItemSodaRabbit",1]], 
["GNT_C185U",["ItemSodaRabbit",1]], 

["An2_2_TK_CIV_EP1",["ItemSodaRabbit",1]],
["An2_1_TK_CIV_EP1",["ItemSodaRabbit",1]],
["AN2_DZ",["ItemSodaRabbit",1]], 

["AH6X_DZ",["ItemSodaRabbit",1]], 
["MH6J_DZ",["ItemSodaRabbit",1]], 

["pook_H13_civ",["ItemSodaRabbit",1]],
["pook_H13_civ_ru_yellow",["ItemSodaRabbit",1]],
["pook_H13_civ_ru_black",["ItemSodaRabbit",1]],
["pook_H13_medevac_CIV_RU",["ItemSodaRabbit",1]],

["CSJ_GyroP",["ItemSodaRabbit",1]],
["CSJ_GyroCover",["ItemSodaRabbit",1]],
["CSJ_GyroC",["ItemSodaRabbit",1]],
["Air",["ItemSodaRabbit",7]], 

["Wheeled_APC",["ItemSodaRabbit",7]],
["Truck",["ItemSodaRabbit",3]],
["Motorcycle",["ItemSodaRabbit",1]],
["Car",["ItemSodaRabbit",1]],
["Tank",["ItemSodaRabbit",5]],
["M113_TK_EP1",["ItemSodaRabbit",5]],
["M113Ambul_TK_EP1_DZ",["ItemSodaRabbit",5]],
["Ship",["ItemSodaRabbit",1]],

["AllVehicles",["ItemSodaRabbit",3]]

]; 

_refuel_updateInterval = 0.01; // update interval (in seconds)
_refuel_amount = 0.001; // amount of fuel to add with every update (in percent)

// repair settings
_repair_enable = true; // enable or disable the repair option
_repair_costs = [

["GNT_C185T",["ItemGoldBar",2]], 
["GNT_C185C",["ItemGoldBar",2]], 
["GNT_C185R",["ItemGoldBar",2]], 
["GNT_C185",["ItemGoldBar",2]], 
["GNT_C185U",["ItemGoldBar",2]], 

["An2_2_TK_CIV_EP1",["ItemGoldBar",2]],
["An2_1_TK_CIV_EP1",["ItemGoldBar",2]],
["AN2_DZ",["ItemGoldBar",2]], 

["CH_47F_BAF",["ItemGoldBar10oz",2]], 
["BAF_Merlin_HC3_D",["ItemGoldBar10oz",2]], 
["BAF_Merlin_DZE",["ItemGoldBar10oz",2]],  
["CH_47F_EP1_DZE",["ItemGoldBar10oz",2]],  

["pook_H13_civ",["ItemGoldBar",5]],
["pook_H13_civ_ru_yellow",["ItemGoldBar",5]],
["pook_H13_civ_ru_black",["ItemGoldBar",5]],
["pook_H13_medevac_CIV_RU",["ItemGoldBar",5]],

["CSJ_GyroP",["ItemGoldBar",5]],
["CSJ_GyroCover",["ItemGoldBar",5]],
["CSJ_GyroC",["ItemGoldBar",5]],
["Air",["ItemGoldBar10oz",1]], 

["Wheeled_APC",["ItemGoldBar10oz",2]], 
["BRDM2_HQ_Gue",["ItemGoldBar10oz",1]], 
["BRDM2_TK_EP1",["ItemGoldBar10oz",1]], 
["BRDM2_CDF",["ItemGoldBar10oz",1]], 
["BRDM2_INS",["ItemGoldBar10oz",1]], 
["BRDM2_GUE",["ItemGoldBar10oz",1]],
["BTR40_MG_TK_GUE_EP1",["ItemGoldBar10oz",1]],
["BAF_Jackal2_L2A1_W",["ItemGoldBar10oz",1]],
["GAZ_Vodnik_HMG",["ItemGoldBar10oz",1]],
["GAZ_Vodnik",["ItemGoldBar10oz",1]],
["GAZ_Vodnik_MedEvac",["ItemGoldBar10oz",1]],

["Truck",["ItemGoldBar10oz",1]],
["Motorcycle",["ItemSodaRabbit",1]],

["Car",["ItemGoldBar10oz",1]],
["Tank",["ItemGoldBar10oz",2]],

["M113_TK_EP1",["ItemGoldBar10oz",1]],
["M113Ambul_TK_EP1_DZ",["ItemGoldBar10oz",1]],

["Ship",["ItemGoldBar",2]], 

["AllVehicles",["ItemGoldBar",5]]

];
_repair_repairTime = 0.000001; // time needed to repair each damaged part (in seconds)

// rearm settings
_rearm_enable = true; // enable or disable the rearm option
_rearm_costs = [
["Tank",["ItemGoldBar10oz",2]],

["BTR90_DZ",["ItemGoldBar10oz",7]],
["M1A1_US_DES_EP1",["ItemGoldBar10oz",3]],
["M1Abrams",["ItemGoldBar10oz",3]],
["T90",["ItemGoldBar10oz",3]],
["BRDM2_HQ_Gue",["ItemGoldBar",4]],

["BRDM2_HQ_Gue",["ItemGoldBar",5]], 
["BRDM2_TK_EP1",["ItemGoldBar",5]], 
["BRDM2_CDF",["ItemGoldBar",5]], 
["BRDM2_INS",["ItemGoldBar",5]], 
["BRDM2_GUE",["ItemGoldBar",5]],

["GAZ_Vodnik_HMG",["ItemGoldBar10oz",1]],
["GAZ_Vodnik",["ItemGoldBar",5]],

["M113_TK_EP1",["ItemGoldBar",5]],
["Air",["ItemGoldBar10oz",2]], 
["Car",["ItemGoldBar10oz",1]],
["AllVehicles",["ItemGoldBar",5]] 

];
_rearm_magazineCount = 3; // amount of magazines to be added to the vehicle weapon

// ----------------- CONFIG END -----------------

call compile preprocessFileLineNumbers (_folder + "ac_functions.sqf");

_lastVehicle = objNull;
_lastRole = [];

SP_refuel_action = -1;
SP_refuel_beer_action = -1;
SP_repair_action = -1;
SP_rearm_actions = [];

_messageShown = false;

_fnc_removeActions = {
	if (isNull _lastVehicle) exitWith {};
	_lastVehicle removeAction SP_refuel_action;
	_lastVehicle removeAction SP_refuel_beer_action;
	SP_refuel_action = -1;
	SP_refuel_beer_action = -1;
	_lastVehicle removeAction SP_repair_action;
	SP_repair_action = -1;
	{
		_lastVehicle removeAction _x;
	} forEach SP_rearm_actions;
	SP_rearm_actions = [];
	_lastVehicle = objNull;
	_lastRole = [];
};

_fnc_getCosts = {
	private ["_vehicle","_costs","_cost"];
	_vehicle = _this select 0;
	_costs = _this select 1;
	_cost = [];
	{
		private "_typeName";
		_typeName = _x select 0;
		if (_vehicle isKindOf _typeName) exitWith {
			_cost = _x select 1;
		};
	} forEach _costs;
	_cost
};

_fnc_actionTitle = {
	private ["_actionName","_costs","_costsText","_actionTitle"];
	_actionName = _this select 0;
	_costs = _this select 1;
	_costsText = _costsFree;
	if (count _costs == 2) then {
		private ["_itemName","_itemCount","_displayName"];
		_itemName = _costs select 0;
		_itemCount = _costs select 1;
		_displayName = getText (configFile >> "CfgMagazines" >> _itemName >> "displayName");
		_costsText = format [_actionCostsFormat, _displayName, _itemCount];
	};
	_actionTitle = format [_actionTitleFormat, _actionName, _costsText];
	_actionTitle
};

_fnc_isArmed = {
	private ["_role","_armed"];
	_role = _this;
	_armed = count _role > 1;
	_armed
};

_fnc_getWeapons = {
	private ["_vehicle","_role","_weapons"];
	_vehicle = _this select 0;
	_role = _this select 1;
	_weapons = [];
	if (count _role > 1) then {
		private ["_turret","_weaponsTurret"];
		_turret = _role select 1;
		_weaponsTurret = _vehicle weaponsTurret _turret;
		{
			private "_weaponName";
			_weaponName = getText (configFile >> "CfgWeapons" >> _x >> "displayName");
			_weapons set [count _weapons, [_x, _weaponName, _turret]];
		} forEach _weaponsTurret;
	};
	_weapons
};

while {true} do {
	private ["_vehicle","_inVehicle"];
	_vehicle = vehicle player;
	_inVehicle = _vehicle != player;
	if (local _vehicle && _inVehicle) then {
		private ["_pos","_servicePoints","_inRange"];
		_pos = getPosATL _vehicle;
		_servicePoints = (nearestObjects [_pos, _servicePointClasses, _maxDistance]) - [_vehicle];
		_inRange = count _servicePoints > 0;
		if (_inRange) then {
			private ["_servicePoint","_role","_actionCondition","_costs","_actionTitle"];
			_servicePoint = _servicePoints select 0;
			_role = assignedVehicleRole player;
			if (((str _role) != (str _lastRole)) || (_vehicle != _lastVehicle)) then {
				// vehicle or seat changed
				call _fnc_removeActions;
			};
			_lastVehicle = _vehicle;
			_lastRole = _role;
			_actionCondition = "vehicle _this == _target && local _target";
			
			
			if (SP_refuel_action < 0 && _refuel_enable) then {
				_costs = [_vehicle, _refuel_costs] call _fnc_getCosts;
				_actionTitle = ["Заправить технику", _costs] call _fnc_actionTitle;
				SP_refuel_action = _vehicle addAction [_actionTitle, _folder + "service_point_refuel.sqf", [_servicePoint, _costs, _refuel_updateInterval], -1, false, true, "", _actionCondition];
			};
			
			if (SP_refuel_beer_action < 0 && _refuel_enable) then {
				_costs = [_vehicle, _refuel_beer_costs] call _fnc_getCosts;
				_actionTitle = ["Заправить технику", _costs] call _fnc_actionTitle;
				SP_refuel_beer_action = _vehicle addAction [_actionTitle, _folder + "service_point_refuel_beer.sqf", [_servicePoint, _costs, _refuel_updateInterval], -1, false, true, "", _actionCondition];
			};
			
			
			if (SP_repair_action < 0 && _repair_enable) then {
				_costs = [_vehicle, _repair_costs] call _fnc_getCosts;
				_actionTitle = ["Починить технику", _costs] call _fnc_actionTitle;
				SP_repair_action = _vehicle addAction [_actionTitle, _folder + "service_point_repair.sqf", [_servicePoint, _costs, _repair_repairTime], -1, false, true, "", _actionCondition];
			};
			
			if ((_role call _fnc_isArmed) && (count SP_rearm_actions == 0) && _rearm_enable) then {
				private ["_weapons"];
				_costs = [_vehicle, _rearm_costs] call _fnc_getCosts;
				_weapons = [_vehicle, _role] call _fnc_getWeapons;
				{
					private "_weaponName";
					_weaponName = _x select 1;
					_actionTitle = [format["Перезарядить %1", _weaponName], _costs] call _fnc_actionTitle;
					SP_rearm_action = _vehicle addAction [_actionTitle, _folder + "service_point_rearm.sqf", [_servicePoint, _costs, _rearm_magazineCount, _x], -1, false, true, "", _actionCondition];
					SP_rearm_actions set [count SP_rearm_actions, SP_rearm_action];
				} forEach _weapons;
			};
			if (!_messageShown && _message != "") then {
				_messageShown = true;
				_vehicle vehicleChat _message;
			};
		} else {
			call _fnc_removeActions;
			_messageShown = false;
		};
	} else {
		call _fnc_removeActions;
		_messageShown = false;
	};
	sleep 2;
};
