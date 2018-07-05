//********************* [ Credits ] ******************************************//
/*

				Gang Script by Cameltoe
				        Version 1.1
				        
		I do not demand to keep the credits but it is appreciated.

*/
//******************** [ Includes ] ******************************************//
#include <a_samp>
#include <mysql>
#include <sscanf2>
#include <zcmd>

//******************** [ Forwards ] ******************************************//


//******************** [ Defines ] ******************************************//

// Script
#define GANG_VERSION "1.1"

// Colors
#define COLOR_RED			0xFF000000
#define COLOR_GREEN 		0x00FF0000
#define COLOR_BLUE 			0x0000FF00
#define COLOR_YELLOW 		0xFFFF0000



// Mysql
#define DB_HOST   "localhost"
#define DB_USER   "root"
#define DB_DB   "gang"
#define DB_PASS   "asieknick7"

#define CREATE_DB_USERS \
	"CREATE TABLE IF NOT EXISTS users (id INT(5) NOT NULL AUTO_INCREMENT PRIMARY KEY,\
	username VARCHAR(25) NOT NULL, gang INT(5) NOT NULL) ENGINE = MyISAM;"
	
#define CREATE_DB_GANGS \
	"CREATE TABLE IF NOT EXISTS gangs (id INT(5) NOT NULL AUTO_INCREMENT PRIMARY KEY,\
	 name VARCHAR(100) NOT NULL, owner VARCHAR(25) NOT NULL) ENGINE = MyISAM;"
	 
// Dialogs
#define DIALOG_GANG_INFO 1

//******************** [ Enums ] *********************************************//
enum pInfo
{
	Id,
	Username[25],
	Gang,
}

//******************** [ Symbols ] *******************************************//
new
	PlayerInfo[MAX_PLAYERS][pInfo];

new 
	Invite[MAX_PLAYERS];

//******************** [ Callbakcs ] *****************************************//

#if defined filsterscript

public OnFilterScriptInit()
{
	InitMysqlConnection();
    
	printf("_____________________________________");
	printf("|                                   |");
	printf("|           Gang FS v%s            |", GANG_VERSION);
	printf("|               By                  |");
	printf("|            Cameltoe               |");
	printf("_____________________________________");
	return 1;


#else

main()
{
	InitMysqlConnection();

	printf("_____________________________________");
	printf("|                                   |");
	printf("|           Gang FS v%s            |", GANG_VERSION);
	printf("|               By                  |");
	printf("|            Cameltoe               |");
	printf("_____________________________________");
	return 1;
}

#endif

public OnPlayerConnect(playerid)
{
	new Query[128];
    ResetPlayerInfo(playerid);
    
    if(CheckUser(playerid))
    {
        LoadPlayerInfo(playerid);
    }
    else
    {
    	format(Query, sizeof(Query), "INSERT INTO users (id, username, gang) VALUES (NULL, '%s', 0);", GetPlayerNameEx(playerid));
        mysql_query(Query);
    }
	return 1;
}

public OnPlayerText(playerid, text[])
{
	new string[128];
	if(PlayerInfo[playerid][Gang]) format(string, sizeof(string), "[ %s ] %s ( %d ) : %s", GetGangName(PlayerInfo[playerid][Gang]), GetPlayerNameEx(playerid), playerid, text);
	else format(string, sizeof(string), "%s ( %d ) : %s",  GetPlayerNameEx(playerid), playerid, text);
	return SendClientMessageToAll(GetPlayerColor(playerid), string);
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	return 0;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid)
	{
	    case DIALOG_GANG_INFO:
	    {
            ShowGangInfoForPlayer(listitem + 1, playerid);
		}
	}
	return 1;
}

//******************** [ Functions ] *****************************************//

//******************** [ Stocks ] ********************************************//

stock CheckUser(playerid)
{
	new Query[100]; format(Query, sizeof(Query), "SELECT * FROM users WHERE username = '%s';", GetPlayerNameEx(playerid));
	mysql_query(Query);
	mysql_store_result();
	if(mysql_num_rows()) return 1;
	return 0;
}

stock LoadPlayerInfo(playerid)
{
	new Query[100]; format(Query, sizeof(Query), "SELECT * FROM users WHERE username = '%s';", GetPlayerNameEx(playerid));
	mysql_query(Query);
	mysql_store_result();
	mysql_fetch_row(Query, "|");
	sscanf(Query, "p<|>e<is[25]i>", PlayerInfo[playerid]);
}

stock CheckGangByName(Name[])
{
	new Query[100]; format(Query, sizeof(Query), "SELECT * FROM gangs WHERE name = '%s';", Name);
	mysql_query(Query);
	mysql_store_result();
	if(mysql_num_rows()) return 1;
	return 0;
}

stock CheckGangById(GangID)
{
	new Query[100]; format(Query, sizeof(Query), "SELECT * FROM gangs WHERE id = %d;", GangID;
	mysql_query(Query);
	mysql_store_result();
	if(mysql_num_rows()) return 1;
	return 0;
}

stock ResetPlayerInfo(playerid)
{
	Invite[playerid] = 0;
	PlayerInfo[playerid][Gang] = 0;
}

stock InitMysqlConnection()
{
    mysql_init();
    mysql_connect(DB_HOST, DB_USER, DB_PASS, DB_DB);
    mysql_query(CREATE_DB_USERS);
    mysql_query(CREATE_DB_GANGS);
}

stock IsPlayerGangLeader(playerid)
{
	new Query[100]; format(Query, sizeof(Query), "SELECT * FROM gangs WHERE id = %d AND owner = '%s';", PlayerInfo[playerid][Gang], GetPlayerNameEx(playerid));
	mysql_query(Query);
	mysql_store_result();
	if(mysql_num_rows()) return 1;
	return 0;
}

stock IsMySelf(pID, oID)
{
	if(pID == oID) return 1;
	return 0;
}

stock GetGangName(GangID)
{
	new gName[100], Query[150]; format(Query, sizeof(Query), "SELECT name FROM gangs WHERE id = %d;", GangID);
	mysql_query(Query);
	mysql_store_result();
	mysql_fetch_string(gName);
	return gName;
}

stock GetGangMemberCount(gID)
{
    new Query[150]; format(Query, sizeof(Query), "SELECT * FROM users WHERE gang = %d;", gID);
    mysql_query(Query);
	mysql_store_result();
	return mysql_num_rows();
}

stock GetGangCount()
{
    new Query[150]; format(Query, sizeof(Query), "SELECT * FROM gangs;");
    mysql_query(Query);
	mysql_store_result();
	return mysql_num_rows();
}

stock ShowGangInfoForPlayer(GangID, pID)
{
    new tGid, tGname[100], tGOwner[25], Query[150], string[200];
    format(Query, sizeof(Query), "SELECT * FROM gangs WHERE id = %d;", GangID);
    mysql_query(Query);
	mysql_store_result();
	if(!mysql_num_rows()) return 0;
	mysql_fetch_row(Query, "|");
	sscanf(Query, "p<|>is[100]s[25]", tGid, tGname, tGOwner);
	format(string, sizeof(string), "Id: %d - Name: %s - Owner: %s - Members: %d", tGid, tGname, tGOwner, GetGangMemberCount(GangID));
	return ShowPlayerDialog(pID, DIALOG_GANG_INFO, DIALOG_STYLE_MSGBOX, "Cameltoe's Gang FS", string, "Cancel", "");
}

stock GetPlayerNameEx(playerid)
{
	new pName[25];
	GetPlayerName(playerid, pName, 25);
	return pName;
}

stock strmatch(const String1[], const String2[])
{
	if ((strcmp(String1, String2, true, strlen(String2)) == 0) && (strlen(String2) == strlen(String1))) return true;
	else return false;
}

//******************** [ Commands ] ******************************************//

command(g, playerid, params[])
{
	new string[128];
	if(!PlayerInfo[playerid][Gang]) return SendClientMessage(playerid, COLOR_YELLOW, "You have to be member of an gang to use this command.");
	format(string, sizeof(string), "Gang : %s ( %d ) : %s", GetPlayerNameEx(playerid), playerid, params);
	for(new pID; pID < MAX_PLAYERS; pID++)
	{
	    if(IsPlayerConnected(pID)) {
			SendClientMessage(pID, GetPlayerColor(playerid), string);
		}
	}
	return 1;
}

command(gangs, playerid, params[])
{
	new gID, tGid, tGname[100], tGOwner[25], Query[200], string[1000]; // Change this depending on how many gangs you have.
	if(sscanf(params, "u", gID))
	{
	    format(Query, sizeof(Query), "SELECT * FROM gangs");
	    mysql_query(Query);
		mysql_store_result();
		while(mysql_fetch_row(Query, "|"))
		{
	    	if(!mysql_num_rows()) continue;
	    	sscanf(Query, "p<|>is[100]s[25]", tGid, tGname, tGOwner);
	    	format(string, sizeof(string), "%sId: %d - Name: %s - Owner: %s\r\n", string, tGid, tGname, tGOwner);
	    }
		ShowPlayerDialog(playerid, DIALOG_GANG_INFO, DIALOG_STYLE_LIST, "Cameltoe's Gang FS", string, "Info", "Cancel");
	}
	else
	{
	    if(!ShowGangInfoForPlayer(gID, playerid)) SendClientMessage(playerid, COLOR_YELLOW, "Invalid gang id.");
	}
	return 1;
}

command(ganginfo, playerid, params[])
{
	new gID;
	if(sscanf(params, "i", gID)) return SendClientMessage(playerid, COLOR_YELLOW, "Usage: /ganginfo [ gangID ]");
 	if(!ShowGangInfoForPlayer(gID, playerid)) SendClientMessage(playerid, COLOR_YELLOW, "Invalid gang id.");
	return 1;
}

command(retreat, playerid, params[])
{
	new Query[100], string[128];
	if(Invite[playerid] == 0 && PlayerInfo[playerid][Gang] == 0) return SendClientMessage(playerid, COLOR_YELLOW, "You are not an member of any gang.");
    format(string, sizeof(string), "You now left %s.", GetGangName(PlayerInfo[playerid][Gang]));
    SendClientMessage(playerid, COLOR_GREEN, string);
    format(string, sizeof(string), "%s [ %d ] left %s.", GetPlayerNameEx(playerid), playerid, GetGangName(PlayerInfo[playerid][Gang]));
    SendClientMessageToAll(COLOR_GREEN, string);
	if(IsPlayerGangLeader(playerid))
	{
	    format(Query, sizeof(Query), "DELETE FROM gangs WHERE owner = '%s';", GetPlayerNameEx(playerid));
        mysql_query(Query);
        format(Query, sizeof(Query), "UPDATE users SET gang = 0 WHERE gang = %d;", PlayerInfo[playerid][Gang]);
        mysql_query(Query);
	}
	format(Query, sizeof(Query), "UPDATE users SET gang = 0 WHERE username = '%s';", GetPlayerNameEx(playerid));
	PlayerInfo[playerid][Gang] = 0;
	mysql_query(Query);
	return 1;
}


command(deny, playerid, params[])
{
	new string[128];
	if(PlayerInfo[playerid][Gang] != 0)  return SendClientMessage(playerid, COLOR_YELLOW, "You are already in an gang.");
	if(Invite[playerid] == 0) return SendClientMessage(playerid, COLOR_YELLOW, "You have not received any gang invite.");
	format(string, sizeof(string), "You denyed the gang invite.");
	SendClientMessage(playerid, COLOR_GREEN, string);
	Invite[playerid] = 0;
	return 1;
}

command(accept, playerid, params[])
{
	new Query[100], string[128];
	if(PlayerInfo[playerid][Gang] != 0)  return SendClientMessage(playerid, COLOR_YELLOW, "You are already in an gang.");
	if(Invite[playerid] == 0) return SendClientMessage(playerid, COLOR_YELLOW, "You have not received any gang invite.");
	format(Query, sizeof(Query), "UPDATE users SET gang = %d WHERE username = '%s';", Invite[playerid], GetPlayerNameEx(playerid));
	format(string, sizeof(string), "You are now an member of %s, type /retreat to leave the gang.", GetGangName(Invite[playerid]));
	SendClientMessage(playerid, COLOR_GREEN, string);
	format(string, sizeof(string), "%s [ %d ] is now an member of %s!", GetPlayerNameEx(playerid), playerid, GetGangName(Invite[playerid]));
	SendClientMessageToAll(COLOR_GREEN, string);
	PlayerInfo[playerid][Gang] = Invite[playerid];
	Invite[playerid] = 0;
	mysql_query(Query);
	return 1;
}

command(invite, playerid, params[])
{
	new pID, string[128];
	if(!IsPlayerGangLeader(playerid)) return SendClientMessage(playerid, COLOR_YELLOW, "You have to be gang leader to use this comamnd.");
	if(sscanf(params, "u", pID)) return SendClientMessage(playerid, COLOR_YELLOW, "Usage: /invite [ Playerid / Name ]");
	if(!IsPlayerConnected(pID)) return SendClientMessage(playerid, COLOR_YELLOW, "This player isn't connected.");
    if(IsMySelf(playerid, pID))  return SendClientMessage(playerid, COLOR_YELLOW, "You cannot invite yourself.");
	if(PlayerInfo[pID][Gang] != 0)  return SendClientMessage(playerid, COLOR_YELLOW, "This player is already in an gang.");
	if(Invite[pID] != 0 && Invite[pID] != PlayerInfo[playerid][Gang])  return SendClientMessage(playerid, COLOR_YELLOW, "This player is already invited by an other gang, please wait for the player to reject the invitation");
	if(Invite[pID] == PlayerInfo[playerid][Gang])  return SendClientMessage(playerid, COLOR_YELLOW, "You have already invited this player please stand by for input.");
	format(string, sizeof(string), "You were invited to join %s, type /accept or /deny .. W/e you feel like.", GetGangName(PlayerInfo[playerid][Gang]));
	SendClientMessage(pID, COLOR_GREEN, string);
	format(string, sizeof(string), "You invited %s to join your gang, please wait for the player to accept the invite.", GetPlayerNameEx(pID));
	SendClientMessage(playerid, COLOR_GREEN, string);
	Invite[pID] = PlayerInfo[playerid][Gang];
	return 1;
}

command(kick, playerid, params[])
{
	new pID, string[128], Query[100];
	if(!IsPlayerGangLeader(playerid)) return SendClientMessage(playerid, COLOR_YELLOW, "You have to be gang leader to use this comamnd.");
	if(sscanf(params, "u", pID)) return SendClientMessage(playerid, COLOR_YELLOW, "Usage: /kick [ Playerid / Name ]");
	if(!IsPlayerConnected(pID)) return SendClientMessage(playerid, COLOR_YELLOW, "This player isn't connected.");
	if(IsMySelf(playerid, pID))  return SendClientMessage(playerid, COLOR_YELLOW, "You cannot kick yourself.");
	if(PlayerInfo[pID][Gang] != PlayerInfo[playerid][Gang])  return SendClientMessage(playerid, COLOR_YELLOW, "This player isn't an member of your gang.");
	format(Query, sizeof(Query), "UPDATE users SET gang = 0 WHERE username = '%s';", GetPlayerNameEx(pID));
	format(string, sizeof(string), "You were kicked out of the gang.");
	SendClientMessage(pID, COLOR_GREEN, string);
	format(string, sizeof(string), "%s [ %d ] were kicked out of %s.", GetPlayerNameEx(pID), pID, GetGangName(PlayerInfo[playerid][Gang]));
	SendClientMessageToAll(COLOR_GREEN, string);
	format(string, sizeof(string), "You kicked %s [ %d ] from your gang, if this was an mistake please reinvite the player with /invite.",  GetPlayerNameEx(pID), pID);
	SendClientMessage(playerid, COLOR_GREEN, string);
	PlayerInfo[pID][Gang] = 0;
	mysql_query(Query);
	return 1;
}

command(creategang, playerid, params[])
{
	new string[128], gName[100], Query[200];
	if(PlayerInfo[playerid][Gang] != 0) return SendClientMessage(playerid, COLOR_YELLOW, "You are already an member of an gang, please quit that gang before creating a new one.");
	if(sscanf(params, "s[100]", gName)) return SendClientMessage(playerid, COLOR_YELLOW, "Usage: /creategang [ Gang-name ].");
	if(CheckGangByName(gName)) return SendClientMessage(playerid, COLOR_YELLOW, "An gang with this name already exists.");
	format(Query, sizeof(Query), "INSERT INTO gangs (id, name, owner) VALUES (NULL, '%s', '%s');", gName, GetPlayerNameEx(playerid));
	format(string, sizeof(string), "You created an gang with name : %s, you were sat as owner of the gang.", gName);
	SendClientMessage(playerid, COLOR_GREEN, string);
	mysql_query(Query);
	PlayerInfo[playerid][Gang] = mysql_insert_id();
	format(Query, sizeof(Query), "UPDATE users SET gang = %d WHERE username = '%s';", PlayerInfo[playerid][Gang], GetPlayerNameEx(playerid));
    mysql_query(Query);
	return 1;
}
