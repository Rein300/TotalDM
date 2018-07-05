#include <a_samp>
#include <mysql>
#include <sscanf2>

#define FILTERSCRIPT
#define CHANGE_ZONE_INTERVAL 60000

new varZoneID;

public OnGameModeInit()
{
	UsePlayerPedAnims();
	varZoneID = 0;
	SetTimer("ChangeZone", CHANGE_ZONE_INTERVAL, 0);
	return 1;
}

public OnPlayerConnect(playerid)
{
	SetPlayerColor(playerid, 0xFFFFFFFF);
	return 1;
}

public OnPlayerSpawn(playerid)
{
	SetPlayerSkillLevel(playerid, WEAPONSKILL_DESERT_EAGLE, 1000);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_SHOTGUN, 1000);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_MP5, 1000);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_SNIPERRIFLE, 1000);
	SetPlayerColor(playerid, 0xFFFFFFFF);
	EndSpawn(playerid, varZoneID);
	return 1;
}

forward ChangeZone();
public ChangeZone()
{
	varZoneID++;
	SendClientMessageToAll(-1, "Strefa spawnu została zmieniona!");
	if(varZoneID == 4) varZoneID = 0;
	SetTimer("ChangeZone", CHANGE_ZONE_INTERVAL, 0);
	connectedPlayersIDs();
	return 1;
}


forward EndSpawn(playerid, zoneid);
public EndSpawn(playerid, zoneid)
{
	selectRandomSpawnByZone(varZoneID, playerid);
	/*if(zoneid == 0) //ganton
	{
		switch(spawn_place)
		{
			case 0:
			SetPlayerPos(playerid, 2527.5732,-1667.1857,15.1685);
					
			case 1:
			SetPlayerPos(playerid, 2512.8657,-1700.3359,13.4201);

			case 2:
			SetPlayerPos(playerid, 2523.0115,-1655.7559,15.4935);

			case 3:
			SetPlayerPos(playerid, 2496.4976,-1644.2438,13.7826);

			case 4:
			SetPlayerPos(playerid, 2473.8335,-1691.5458,13.5144);

			case 5:
			SetPlayerPos(playerid, 2420.1790,-1681.3297,13.7503);

			case 6:
			SetPlayerPos(playerid, 2442.5691,-1643.8492,13.4662);

			case 7:
			SetPlayerPos(playerid, 2397.7664,-1672.4351,13.5705);

			case 8:
			SetPlayerPos(playerid, 2385.3047,-1692.2565,14.5179);

			case 9:
			SetPlayerPos(playerid, 2380.2437,-1695.2969,13.5251);

			case 10:
			SetPlayerPos(playerid, 2349.2205,-1723.9052,13.5390);

			case 11:
			SetPlayerPos(playerid, 2334.1335,-1667.6530,13.6224);

			case 12:
			SetPlayerPos(playerid, 2335.8936,-1637.3120,15.7127);

			case 13:
			SetPlayerPos(playerid, 2305.0554,-1640.8867,14.4859);
			
			case 14:
			SetPlayerPos(playerid, 2297.6028,-1671.8436,14.6436);
		}
	}
	else if(zoneid == 1) //watts
	{
		switch(spawn_place)
		{
			case 0:
			SetPlayerPos(playerid, 2349.7415,-1532.4429,24.0084);
					
			case 1:
			SetPlayerPos(playerid, 2353.1091,-1513.9141,24.0000);

			case 2:
			SetPlayerPos(playerid, 2385.0308,-1515.0317,23.9922);

			case 3:
			SetPlayerPos(playerid, 2388.4055,-1535.8125,24.0000);

			case 4:
			SetPlayerPos(playerid, 2431.0535,-1552.8420,23.8343);

			case 5:
			SetPlayerPos(playerid, 2440.2190,-1511.6272,23.9902);

			case 6:
			SetPlayerPos(playerid, 2423.3428,-1475.1500,23.8478);

			case 7:
			SetPlayerPos(playerid, 2402.0505,-1473.0208,23.8671);

			case 8:
			SetPlayerPos(playerid, 2385.4014,-1456.0516,24.0050);

			case 9:
			SetPlayerPos(playerid, 2354.4109,-1474.6566,23.8418);

			case 10:
			SetPlayerPos(playerid, 2333.1663,-1475.6040,23.9995);

			case 11:
			SetPlayerPos(playerid, 2299.9131,-1526.2025,26.8750);

			case 12:
			SetPlayerPos(playerid, 2311.2688,-1509.0420,26.8430);

			case 13:
			SetPlayerPos(playerid, 2321.2698,-1491.9580,23.7536);
			
			case 14:
			SetPlayerPos(playerid, 2318.1355,-1558.3850,21.5926);
		}
	}

	else if(zoneid == 2) //kosciol
	{
		switch(spawn_place)
		{
			case 0:
			SetPlayerPos(playerid, 2176.3445,-1308.6555,23.9844);
					
			case 1:
			SetPlayerPos(playerid, 2140.6504,-1316.5585,24.6153);

			case 2:
			SetPlayerPos(playerid, 2137.1689,-1285.3427,24.6013);

			case 3:
			SetPlayerPos(playerid, 2158.4641,-1261.8600,23.9899);

			case 4:
			SetPlayerPos(playerid, 2167.4138,-1229.4015,23.9766);

			case 5:
			SetPlayerPos(playerid, 2166.1157,-1210.9739,23.9688);

			case 6:
			SetPlayerPos(playerid, 2079.9473,-1228.4694,23.9766);

			case 7:
			SetPlayerPos(playerid, 2079.5869,-1292.5273,23.9794);

			case 8:
			SetPlayerPos(playerid, 2092.2571,-1342.9003,23.9844);

			case 9:
			SetPlayerPos(playerid, 2156.8960,-1342.8955,23.9899);

			case 10:
			SetPlayerPos(playerid, 2158.4780,-1377.6315,23.9844);

			case 11:
			SetPlayerPos(playerid, 2215.1584,-1377.7318,24.0000);

			case 12:
			SetPlayerPos(playerid, 2200.4919,-1410.7926,25.2749);

			case 13:
			SetPlayerPos(playerid, 2247.3357,-1435.4847,25.3832);
			
			case 14:
			SetPlayerPos(playerid, 2277.4719,-1393.3558,24.0339);
		}
	}

	else if(zoneid == 3) //pigpen
	{
		switch(spawn_place)
        {
            case 0:
            SetPlayerPos(playerid, 2393.2703,-1223.8125,26.3505);

            case 1:
            SetPlayerPos(playerid, 2387.7188,-1257.2021,23.8277);

            case 2:
            SetPlayerPos(playerid, 2410.5793,-1288.2769,24.2453);

            case 3:
            SetPlayerPos(playerid, 2444.4827,-1289.8036,24.0000);

            case 4:
            SetPlayerPos(playerid, 2477.3252,-1287.1964,29.9547);

            case 5:
            SetPlayerPos(playerid, 2362.6782,-1300.7303,23.8269);

            case 6:
            SetPlayerPos(playerid, 2472.8926,-1220.0033,31.4006);

            case 7:
            SetPlayerPos(playerid, 2485.2434,-1257.3348,30.4087);

            case 8:
            SetPlayerPos(playerid, 2447.5522,-1212.9146,32.2152);

            case 9:
            SetPlayerPos(playerid, 2393.6140,-1205.6709,27.7756);

            case 10:
            SetPlayerPos(playerid, 2377.6741,-1211.8463,27.4297);

            case 11:
            SetPlayerPos(playerid, 2350.4143,-1227.8745,27.9766);

            case 12:
            SetPlayerPos(playerid, 2331.5505,-1255.0272,27.9766);

            case 13:
            SetPlayerPos(playerid, 2318.1130,-1270.1700,27.9747);

            case 14:
            SetPlayerPos(playerid, 2338.9089,-1289.4241,27.9766);
        }
	}
	*/
	return 1;
}

selectRandomSpawnByZone(zoneid, playerid) {
	new query[256], data[300];
	new rand = random(15);
	format(query, sizeof(query), "SELECT posX, posY, posZ FROM spawnzones WHERE id = '%d' AND zoneid = '%d'", rand, zoneid);
	mysql_query(query);
	mysql_store_result();
	mysql_fetch_row(data, "|");
	new Float:posX, Float:posY, Float:posZ;
	sscanf(data, "p<|>fff", posX, posY, posZ);
	SetPlayerPos(playerid, posX, posY, posZ);
	mysql_free_result();
	return 1;
}

connectedPlayersIDs()
{
	new PlayerID[MAX_PLAYERS];

	for(new i = 0; i < MAX_PLAYERS; i++)
	{
	    if(IsPlayerConnected(i))
	    {
	        PlayerID[i] = i;
	        SpawnPlayer(i);
	    }
	}
	return 1;
}

stock updateZone(nothing, Float:posX, Float:posY, Float:posZ)
{
	format(query, sizeof(query), "INSERT INTO spawnzones (zoneid, posX, posY, posZ) VALUES ('0', '%f', '%f', '%f')", posX, posY, posZ);
	mysql_query(query);
	/*case 0:
	SetPlayerPos(playerid, 2527.5732,-1667.1857,15.1685);
					
	case 1:
	SetPlayerPos(playerid, 2512.8657,-1700.3359,13.4201);

	case 2:
	SetPlayerPos(playerid, 2523.0115,-1655.7559,15.4935);

	case 3:
	SetPlayerPos(playerid, 2496.4976,-1644.2438,13.7826);

	case 4:
	SetPlayerPos(playerid, 2473.8335,-1691.5458,13.5144);

	case 5:
	SetPlayerPos(playerid, 2420.1790,-1681.3297,13.7503);

	case 6:
	SetPlayerPos(playerid, 2442.5691,-1643.8492,13.4662);

	case 7:
	SetPlayerPos(playerid, 2397.7664,-1672.4351,13.5705);

	case 8:
	SetPlayerPos(playerid, 2385.3047,-1692.2565,14.5179);

	case 9:
	SetPlayerPos(playerid, 2380.2437,-1695.2969,13.5251);

	case 10:
	SetPlayerPos(playerid, 2349.2205,-1723.9052,13.5390);

	case 11:
	SetPlayerPos(playerid, 2334.1335,-1667.6530,13.6224);

	case 12:
	SetPlayerPos(playerid, 2335.8936,-1637.3120,15.7127);

	case 13:
	SetPlayerPos(playerid, 2305.0554,-1640.8867,14.4859);
	
	case 14:
	SetPlayerPos(playerid, 2297.6028,-1671.8436,14.6436);*/
	return 1;
}
