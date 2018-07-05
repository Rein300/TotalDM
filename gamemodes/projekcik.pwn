#include <a_samp>
#include <mysql>
#include <sscanf2>
#include <zcmd>
#include <AutoAFK>

#define SQL_HOST "localhost"
#define SQL_USER "root"
#define SQL_PASS "asieknick7"
#define SQL_DB "samp"

#define DIALOG_REGISTER 1
#define DIALOG_LOGIN 2
#define DIALOG_GANG_MAIN 3
#define DIALOG_GANG_CREATE 4
#define DIALOG_GANG_JOIN 5

main()
{
}

enum E_PLAYER
{
	userid,
	username[24],
	pass[24],
	skin,
	score,
	cash,
	gang,
	rank
}

enum E_GANG
{
	uid,
	name[16],
	leader[24],
	score,
	color
}

new playerCache[MAX_PLAYERS][E_PLAYER], gangCache[E_GANG];
new _killstreak[MAX_PLAYERS], scoreStats[MAX_PLAYERS];
new query[500];
new _advertise;

public OnGameModeInit()
{
	mysql_init(LOG_ONLY_ERRORS);
	mysql_connect(SQL_HOST, SQL_USER, SQL_PASS, SQL_DB);
	SetTimer("Advertise", 60000, 1);

	SetGameModeText("VIXAPOL");
	for(new i; i < 300; i++)
	{
		AddPlayerClass(i, 2316.1248,-1541.5276,25.3438,333.7706, 0, 0, 0, 0, 0, 0);
	}

	return 1;
}

public OnGameModeExit()
{
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	SetPlayerPos(playerid, 2316.0012,-1539.2905,25.3438);
	SetPlayerFacingAngle(playerid, 328.0399);
	SetPlayerCameraPos(playerid, 2320.2661,-1534.2156,26.6367);
	SetPlayerCameraLookAt(playerid, 2316.0012,-1539.2905,25.3438);
	//SetSpawnInfo(playerid, 0, playerCache[playerid][skin], 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
	return 1;
}

public OnPlayerConnect(playerid)
{
	new gName[MAX_PLAYER_NAME];
	new data[256];
	
	GetPlayerName(playerid, gName, sizeof(gName));
	format(query, sizeof(query), "SELECT * FROM users WHERE username = '%s'", gName);

	mysql_query(query);

	mysql_store_result();
	if(mysql_fetch_row(data, "|"))
	{
		sscanf(data, "p<|>ds[24]s[24]ddddd", 
			playerCache[playerid][userid],
			playerCache[playerid][username],
			playerCache[playerid][pass],
			playerCache[playerid][skin],
			playerCache[playerid][score],
			playerCache[playerid][cash],
			playerCache[playerid][gang],
			playerCache[playerid][rank]);
	}
	else
	{
		SendClientMessage(playerid, -1, "Nie znaleziono Ciebie w bazie danych, zarejestruj siê.");
		registerDialog(playerid);
		return 1;
	}
	
	loginDialog(playerid);

	mysql_free_result();
	
	PlayAudioStreamForPlayer(playerid, "http://k003.kiwi6.com/hotlink/hk3govy9su/wejdziemy_na_top.mp3", 0, 0, 0, 0, 0);

	Welcome(playerid);
	GivePlayerMoney(playerid, playerCache[playerid][cash]);
	scoreStats[playerid] = playerCache[playerid][cash];
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	Bye(playerid);
	playerCache[playerid][skin] = GetPlayerSkin(playerid);
	format(query, sizeof(query), "UPDATE users SET skin='%d', cash='%d' WHERE userid='%d'", playerCache[playerid][skin], scoreStats[playerid], playerCache[playerid][userid]);
	mysql_query(query);
	scoreStats[playerid] = 0;
	return 1;
}

public OnPlayerSpawn(playerid)
{
	StopAudioStreamForPlayer(playerid);
	if(!playerCache[playerid][skin]) playerCache[playerid][skin] = GetPlayerSkin(playerid);
	SetPlayerSkin(playerid, playerCache[playerid][skin]);
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	saveDeathStats(playerid);
	SendDeathMessage(killerid, playerid, reason);
	return 1;
}

saveDeathStats(playerid) {
	_killstreak[playerid] = 0;
	playerCache[playerid][skin] = GetPlayerSkin(playerid);
	return 1;
}

public OnVehicleSpawn(vehicleid)
{
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
	return 1;
}

public OnPlayerText(playerid, text[])
{
	new message[128], nickname[MAX_PLAYER_NAME];
	GetPlayerName(playerid, nickname, sizeof(nickname));
	format(message, sizeof(message), "%s[%d]: %s", nickname, playerid, text);
	SendClientMessageToAll(-1, message);
	return 0;
}

/*public OnPlayerCommandText(playerid, cmdtext[])
{
	return 1;
}
*/

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveCheckpoint(playerid)
{
	return 1;
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveRaceCheckpoint(playerid)
{
	return 1;
}

public OnRconCommand(cmd[])
{
	return 1;
}

public OnPlayerRequestSpawn(playerid)
{
	return 1;
}

public OnObjectMoved(objectid)
{
	return 1;
}

public OnPlayerObjectMoved(playerid, objectid)
{
	return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
	return 1;
}

public OnVehicleMod(playerid, vehicleid, componentid)
{
	return 1;
}

public OnVehiclePaintjob(playerid, vehicleid, paintjobid)
{
	return 1;
}

public OnVehicleRespray(playerid, vehicleid, color1, color2)
{
	return 1;
}

public OnPlayerSelectedMenuRow(playerid, row)
{
	return 1;
}

public OnPlayerExitedMenu(playerid)
{
	return 1;
}

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	return 1;
}

public OnRconLoginAttempt(ip[], password[], success)
{
	return 1;
}

public OnPlayerUpdate(playerid)
{
	return 1;
}

public OnPlayerStreamIn(playerid, forplayerid)
{
	return 1;
}

public OnPlayerStreamOut(playerid, forplayerid)
{
	return 1;
}

public OnVehicleStreamIn(vehicleid, forplayerid)
{
	return 1;
}

public OnVehicleStreamOut(vehicleid, forplayerid)
{
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(dialogid == DIALOG_REGISTER)
	{
		registerFunc(playerid, inputtext);
	}
	if(dialogid == DIALOG_LOGIN)
	{
		loginFunc(playerid, inputtext);
	}

	if(dialogid == DIALOG_GANG_MAIN)
	{
		gangDialog(playerid, response, listitem);
	}

	if(dialogid == DIALOG_GANG_CREATE)
	{
		if(response)
		{
			DialogGangCreate(inputtext, playerid, playerCache[playerid][gang], gangCache[uid], gangCache[name]);
		}
		mysql_free_result();
	}

	return 0;
}

registerFunc(playerid, inputtext[]) {
	if(strlen(inputtext) > 0)
	{
		new gName[MAX_PLAYER_NAME];
		GetPlayerName(playerid, gName, sizeof(gName));
		format(query, sizeof(query), "INSERT INTO users (username, pass) VALUES ('%s', '%s')", gName, inputtext);
		mysql_query(query);
	}
	else
	{
		registerDialog(playerid);
	}
	return 1;
}

loginFunc(playerid, inputtext[]) {
	if(strlen(inputtext) > 0)
	{
		if(!strcmp(playerCache[playerid][pass], inputtext, false))
		{
			SpawnPlayer(playerid);
		}
		else
		{
			loginDialog(playerid);
		}
	}
	else
	{
		loginDialog(playerid);
	}
	return 1;
}

loginDialog(playerid) {
	ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_INPUT, "Logowanie", "Wbijaj mordunio na najlepszy serwer SAMP na œwiecie!\n- Polecam, Robert Mak³owicz.", "EBE EBE", "Spierdalam");
	return 1;
}

registerDialog(playerid) {
	ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_INPUT, "Rejestracja", "Aby rozpocz¹æ grê na naszym serwerze musisz siê zarejestrowaæ, wpisz nowe has³o w okienku.", "Wbita", "Spierdalam");
	return 1;
}

gangDialog(playerid, response, listitem) {
	if(response)
	{
		DialogGangMain(playerid, listitem, DIALOG_GANG_CREATE, DIALOG_STYLE_INPUT);
	}
	else
	{
		SendClientMessage(playerid, -1, "Blad pizdy");
	}
	return 1;
}

public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	return 1;
}

public OnPlayerGiveDamage(playerid, damagedid, Float:amount, weaponid, bodypart)
{
	if(!IsPlayerPaused(damagedid))
	{
		if(weaponid == WEAPON_MP5) damageScoreCounter(playerid, damagedid, 2, 0);
		else if(weaponid == WEAPON_SHOTGUN) damageScoreCounter(playerid, damagedid, 4, 1);
		else if(weaponid == WEAPON_DEAGLE) damageScoreCounter(playerid, damagedid, 8, 2);
		else if(weaponid == WEAPON_SNIPER) damageScoreCounter(playerid, damagedid, 8, 3);
		else if(weaponid == WEAPON_SHOTGSPA) damageScoreCounter(playerid, damagedid, 3, 1);
		else if(weaponid == WEAPON_SAWEDOFF) damageScoreCounter(playerid, damagedid, 1, 0);
		else if(weaponid == WEAPON_RIFLE) damageScoreCounter(playerid, damagedid, 10, 3);
		else if(weaponid == WEAPON_M4) damageScoreCounter(playerid, damagedid, 2, 1);
	}
	checkPlayerKillstreakColor(playerid);

	return 1;
}

damageScoreCounter(playerid, damagedid, addScore, decreaseScore) { //hit score constructor
	_killstreak[playerid] += addScore;
	_killstreak[damagedid] -= decreaseScore;
	playerCache[playerid][score] += addScore;
	scoreStats[playerid] += addScore;
	SetPlayerScore(playerid, _killstreak[playerid]);
	SetPlayerScore(damagedid, _killstreak[damagedid]);
	return 1;
}

checkPlayerKillstreakColor(playerid) { //checks if script should change player color
	if(_killstreak[playerid] >= 100 && _killstreak[playerid] <= 111)	
	{
		SetPlayerColor(playerid, 0x00FA00FF);
	}
	else if(_killstreak[playerid] >= 300 && _killstreak[playerid] <= 311) 
	{
		SetPlayerColor(playerid, 0xFAF600FF); 
	}
	else if(_killstreak[playerid] >= 500 && _killstreak[playerid] <= 511)	
	{	
		SetPlayerColor(playerid, 0xFA0000FF);
	}
	else if(_killstreak[playerid] >= 1000 && _killstreak[playerid] <= 1011)
	{ 
		SetPlayerColor(playerid, 0x000000FF);
	}
	return 1;
}

public OnPlayerResume(playerid)
{
	return 1;
}

Welcome(playerid)
{
	new hour, minute, second, welcome[64];
	gettime(hour, minute, second);
	format(welcome, sizeof(welcome), "{00cc44}(L) Witamy na serwerku, {f2f2f2}%s.", playerCache[playerid][username]);
	SendClientMessage(playerid, -1, welcome);
	SendClientMessage(playerid, -1, "{00cc44}(L) Ostatnia aktualizacja: {f2f2f2}05/07/2018");
	new nick [MAX_PLAYER_NAME];
	new hello [128];
	new ip [32];
	GetPlayerName(playerid, nick, sizeof(nick));
	GetPlayerIp(playerid, ip, sizeof(ip));
	printf("Gracz %s polaczyl sie z serwerem, jego IP to: %s, godzina: %02d:%02d:%02d", nick, ip, hour, minute, second);
	format(hello, sizeof(hello), "{ff9933}(G){f2f2f2} Gracz {ff9933}%s {f2f2f2}wszed³ na serwer.", nick);
	SendClientMessageToAll(-1, hello);
	return 1;
}

Bye(playerid)
{
	new hour, minute, second;
	gettime(hour, minute, second);
	new nick [MAX_PLAYER_NAME];
	new hello [128];
	new ip [32];
	GetPlayerName(playerid, nick, sizeof(nick));
	GetPlayerIp(playerid, ip, sizeof(ip));
	printf("Gracz %s opuscil serwer, jego IP to: %s, godzina: %02d:%02d:%02d", nick, ip, hour, minute, second);
	format(hello, sizeof(hello), "{ff9933}(G) Gracz {f2f2f2}%s {ff9933}opuœci³ serwer.", nick);
	SendClientMessageToAll(-1, hello);
	return 1;
}

// GANG DIALOG START
DialogGangCreate(inputtext[], playerid, playerGang, gangUid, gangName[]) {
	getAllGangs(inputtext);
	new data[256];
	if(mysql_fetch_row(data, "|"))
	{
		gangExists(data, playerid, gangName);
	}
	else
	{
		createNewGang(inputtext, playerid, playerGang, gangUid, data);
	}
	return 1;
}

DialogGangMain(playerid, listitem, dialogId, dialogStyleInput) {
	switch(listitem)
	{
		case 0:	ShowPlayerDialog(playerid, dialogId, dialogStyleInput, "Zak³adanie gangu", "Wpisz pe³n¹ nazwê gangu poni¿ej:", "OK", "Anuluj");
		case 1:	ShowPlayerDialog(playerid, dialogId, dialogStyleInput, "Do³¹czanie do gangu", "Wybierz zainteresowany gang z listy:", "OK", "Anuluj");
		case 2:	SendClientMessage(playerid, -1, "Cpunek");
	}
	return 1;
}
// GANG DIALOG END

// GANG HANDLING START
getAllGangs(inputtext[]) {
	format(query, sizeof(query), "SELECT * FROM gangs WHERE name = '%s'", inputtext);
	mysql_query(query);
	mysql_store_result();
}

createNewGang(inputtext[], playerid, playerGang, gangUid, data[]) {
	if(strlen(inputtext) > 3 && strlen(inputtext) <= 16)
		{
			new nickname[MAX_PLAYER_NAME];
			GetPlayerName(playerid, nickname, sizeof(nickname));
			if(playerGang != 0)
			{
				handleExistingGang(playerid);
				return 1;
			}
			else
			{
				createGang(playerid, inputtext, nickname);
				selectGang(nickname);
				if(mysql_fetch_row(data, "|"))
				{
					addUserToGang(data, gangUid, nickname);
				}
			}
		}
		else SendClientMessage(playerid, -1, "Minimum 4 znaki -> Maksimum 16 znaków.");
	return 1;
}

handleExistingGang(playerid) {
	SendClientMessage(playerid, -1, "Masz ju¿ swój gang.");
	mysql_free_result();
	return 1;
}

createGang(playerid, inputtext[], nickname[]) {
	SendClientMessage(playerid, -1, "Nie znaleziono gangu w bazie danych, tworzenie.");
	format(query, sizeof(query), "INSERT INTO gangs (name, leader) VALUES ('%s', '%s')", inputtext, nickname);
	mysql_query(query);
	return 1;
}

selectGang(nickname[]) {
	format(query, sizeof(query), "SELECT uid FROM gangs WHERE leader = '%s'", nickname);
	mysql_query(query);
	mysql_store_result();
	return 1;
}

addUserToGang(data[], gangUid, nickname[]) {
	sscanf(data, "d", gangUid);
	format(query, sizeof(query), "UPDATE users SET gang = '%d' WHERE username = '%s'", gangUid, nickname);
	mysql_query(query);
	mysql_free_result();
	return 1;
}

gangExists(data[], playerid, gangName[]) {
	sscanf(data, "p<|>s[16]", gangName);
	SendClientMessage(playerid, -1, "Gang o podanej nazwie ju¿ istnieje.");
	mysql_free_result();
	return 1;
}
// GANG HANDLING END


forward Advertise();
public Advertise()
{
	if(_advertise == 4) _advertise = 0;
	switch(_advertise)
	{
		case 0: SendClientMessageToAll(-1, "Reklaa 1");
		case 1: SendClientMessageToAll(-1, "Reklaa 2");
		case 2: SendClientMessageToAll(-1, "Reklaa 3");
		case 4: SendClientMessageToAll(-1, "Reklaa 1");
	}

	_advertise++;
	return 1; 
}

CMD:gang(playerid)
{
   ShowPlayerDialog(playerid, DIALOG_GANG_MAIN, DIALOG_STYLE_LIST, "Gangi", "1. Stwórz gang.\n\
   																			2. Do³¹cz do gangu.\n\
   																			3. Lista gangów.", "OK", "Anuluj");
   return 1;
}

CMD:kick(playerid, params[])
{
	new receiverid, receivername[MAX_PLAYER_NAME], reason[16], message[64];
	if(sscanf(params, "ds[16]", receiverid, reason))
	{
		SendClientMessage(playerid, -1, "U¿ycie komendy: /kick [id] [powód]");
	}
	if(playerCache[playerid][rank] <= 2)
	{
		SendClientMessage(playerid, -1, "Nie jesteœ adminem.");
	}
	if(!IsPlayerConnected(receiverid))
	{
		SendClientMessage(playerid, -1, "Gracz nie jest po³¹czony.");
	}
	if(playerid == receiverid)
	{
		SendClientMessage(playerid, -1, "Nie mo¿esz sam siê wyrzuciæ z serwera.");
	}
	if(strlen(reason) == 0)
	{
		SendClientMessage(playerid, -1, "Nie poda³eœ powodu wyrzucenia.");
	}

	GetPlayerName(receiverid, receivername, sizeof(receivername));
	Kick(receiverid);
	format(message, sizeof(message), "%s zosta³ wyrzucony z serwera! Powód: %s", receivername, reason);
	SendClientMessageToAll(-1, message);
	
	return 1;
}