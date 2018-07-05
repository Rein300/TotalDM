#include <a_samp>
#include <mysql>
#include <sscanf2>

#define FILTERSCRIPT
#define CHANGE_ZONE_INTERVAL 320000

new varZoneID, tempCount = 0;

public OnGameModeInit() //zone names
{
	/*ZONE NAMES:
	ZONE 0 = GANTON
	ZONE 1 = WATTS
	ZONE 2 = GRAPE CHURCH
	ZONE 3 = PIGPEN / MASON ST.
	*/
	UsePlayerPedAnims();
	startZoneChanging();
	return 1;
}

startZoneChanging() //initial zone changing, timer start
{
	varZoneID = 0;
	SetTimer("changeZone", CHANGE_ZONE_INTERVAL, 0);
	return 1;
}

public OnPlayerConnect(playerid) //set color
{
	SetPlayerColor(playerid, 0xFFFFFFFF);
	return 1;
}

public OnPlayerSpawn(playerid)
{
	setPlayerSpawnSkills(playerid);
	endSpawn(playerid, varZoneID);
	return 1;
}

setPlayerSpawnSkills(playerid) //spawn info for player (weapon skills + color)
{
	SetPlayerSkillLevel(playerid, WEAPONSKILL_DESERT_EAGLE, 1000);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_SHOTGUN, 1000);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_MP5, 1000);
	SetPlayerSkillLevel(playerid, WEAPONSKILL_SNIPERRIFLE, 1000);
	SetPlayerColor(playerid, 0xFFFFFFFF);
	return 1;
}

forward changeZone(); //zone++ after CHANGE_ZONE_INTERVAL
public changeZone()
{
	varZoneID++;
	SendClientMessageToAll(-1, "Strefa spawnu zosta³a zmieniona!");
	if(varZoneID == 4) varZoneID = 0;
	SetTimer("changeZone", CHANGE_ZONE_INTERVAL, 0);
	connectedPlayersIDs();
	return 1;
}


forward endSpawn(playerid, zoneid); //forward to selectrandomspawnbyzone
public endSpawn(playerid, zoneid)
{
	selectRandomSpawnByZone(varZoneID, playerid);
	return 1;
}

selectRandomSpawnByZone(zoneid, playerid) { //setplayerspawn pos after random 
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

connectedPlayersIDs() //loop checking for connected players
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

stock insertZoneToDB(Float:posX, Float:posY, Float:posZ) //CREATE NEW ZONES WITH ONE COMMAND (IN INIT)
{
	new query[256];
	format(query, sizeof(query), "INSERT INTO spawnzones (id, zoneid, posX, posY, posZ) VALUES ('%d', '3', '%f', '%f', '%f')", tempCount, posX, posY, posZ);
	mysql_query(query);
	return 1;
}
