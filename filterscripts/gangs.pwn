#include <a_samp>
#include <mysql>
#include <sscanf2>
#include <zcmd>

#define FILTERSCRIPT

#define DIALOG_GANG_MAIN 3
#define DIALOG_GANG_CREATE 4

enum E_GANG
{
	uid,
	name[16],
	leader[24],
	score,
	color
}

enum E_PLAYER
{
	userid,
	username[24],
	pass[24],
	skin,
	score,
	cash,
	gang
}

new PlayerCache[MAX_PLAYERS][E_PLAYER];

new query[256];
new GangCache[E_GANG];

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(dialogid == DIALOG_GANG_MAIN)
	{
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					ShowPlayerDialog(playerid, DIALOG_GANG_CREATE, DIALOG_STYLE_INPUT, "Zak³adanie gangu", "Wpisz pe³n¹ nazwê gangu poni¿ej:", "OK", "Anuluj");
				}
				case 1:	SendClientMessage(playerid, -1, "Pedal");
				case 2:	SendClientMessage(playerid, -1, "Cpunek");
			}
		}
		else
		{
			SendClientMessageToAll(-1, "Blad pizdy");
		}
	}

	if(dialogid == DIALOG_GANG_CREATE)
	{
		if(response)
		{
			format(query, sizeof(query), "SELECT * FROM gangs WHERE name = '%s'", inputtext);
			mysql_query(query);
			mysql_store_result();
			new data[256];
			SendClientMessageToAll(-1, "MySQL debug 1.");
			if(mysql_fetch_row(data, "|"))
			{
				sscanf(data, "p<|>s[16]", GangCache[name]);
				SendClientMessage(playerid, -1, "Gang o podanej nazwie ju¿ istnieje.");
				mysql_free_result();
			}
			else
			{
				if(strlen(inputtext) > 3 && strlen(inputtext) <= 16)
				{
					new nickname[MAX_PLAYER_NAME];
					GetPlayerName(playerid, nickname, sizeof(nickname));
					format(query, sizeof(query), "SELECT * FROM users WHERE username = '%s'", nickname);
					mysql_query(query);
					mysql_store_result();
					SendClientMessageToAll(-1, "MySQL debug 2.");
					if(mysql_fetch_row(data, "|"))
					{
						sscanf(data, "p<|>ds[24]s[24]dddd", 
							PlayerCache[playerid][userid],
							PlayerCache[playerid][username],
							PlayerCache[playerid][pass],
							PlayerCache[playerid][skin],
							PlayerCache[playerid][score],
							PlayerCache[playerid][cash],
							PlayerCache[playerid][gang]);
						//mysql_free_result();
						if(PlayerCache[playerid][gang] != 0)
						{
							SendClientMessage(playerid, -1, "Masz ju¿ swój gang.");
							SendClientMessageToAll(-1, "MySQL debug 3.");
							mysql_free_result();
							return 1;
						}
						else
						{
							format(query, sizeof(query), "SELECT * FROM gangs WHERE leader = '%s'", PlayerCache[playerid][username]);
							mysql_query(query);
							mysql_store_result();
							SendClientMessageToAll(-1, "MySQL debug 4.");
							if(mysql_fetch_row(data, "|"))
							{
								SendClientMessageToAll(-1, "Entered mysql_fetch_row");
								sscanf(data, "p<|>ds[16]s[24]dd", 
								GangCache[uid],
								GangCache[name],
								GangCache[leader],
								GangCache[score],
								GangCache[color]);
								SendClientMessageToAll(-1, GangCache[uid]);
								SendClientMessageToAll(-1, GangCache[name]);
								SendClientMessageToAll(-1, GangCache[leader]);								
								SendClientMessageToAll(-1, GangCache[score]);
								SendClientMessageToAll(-1, GangCache[color]);
								format(query, sizeof(query), "UPDATE users SET gang = '%d' WHERE username = '%s'", GangCache[uid], PlayerCache[playerid][username]);
								mysql_query(query);
								//mysql_free_result();
								SendClientMessage(playerid, -1, "Nie znaleziono gangu w bazie danych, tworzenie.");
								format(query, sizeof(query), "INSERT INTO gangs (name, leader) VALUES ('%s', '%s')", inputtext, nickname);
								mysql_query(query);
								//mysql_free_result();
							}
						}
					}
				}
				else SendClientMessage(playerid, -1, "Minimum 4 znaki -> Maksimum 16 znaków.");
			}
		}
		SendClientMessageToAll(-1, "MySQL debug 6.");
		mysql_free_result();
	}
	return 0;
}
