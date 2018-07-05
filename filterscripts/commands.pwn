#include <a_samp>
#include <mysql>
#include <sscanf2>
#include <zcmd>
#include <string>

#define FILTERSCRIPT

//komendy zcmd

CMD:skin(playerid, params[])
{
	new skinid;
	if(sscanf(params, "d", skinid))
	{
		SendClientMessage(playerid, -1, "U¿ycie komendy: /skin [id skina]");
		return 1;
	}

	if(skinid > 311 || skinid <= 0)
	{
		SendClientMessage(playerid, -1, "Skin zabroniony b¹dŸ niedostêpny");
		return 1;
	}

	SetPlayerSkin(playerid, skinid);
	SendClientMessage(playerid, -1, "Skin zosta³ zmieniony.");

	return 1;
}

CMD:v(playerid, params[])
{
	new carid, Float:PosX, Float:PosY, Float:PosZ, message[50];
	if(sscanf(params, "d", carid))
	{
		SendClientMessage(playerid, -1, "U¿ycie komendy: /v [id pojazdu]");
		return 1;
	}

	if(carid > 600)
	{
		SendClientMessage(playerid, -1, "Pojazd o podanym ID nie istnieje.");
		return 1;
	}

	GetPlayerPos(playerid, PosX, PosY, PosZ);
	PosX += 3.0;
	CreateVehicle(carid, PosX, PosY, PosZ, 90.0, 0, 0, -1, 0);
	format(message, sizeof(message), "Pojazd o ID %d zosta³ stworzony pomyœlnie.", carid);
	SendClientMessage(playerid, -1, message);
	return 1;
}

CMD:kill(playerid)
{
	SetPlayerHealth(playerid, 0.0);
	SendClientMessage(playerid, -1, "Zabi³eœ siê!");
	return 1;
}

CMD:stats(playerid)
{
    new stats[400+1];
    GetPlayerNetworkStats(playerid, stats, sizeof(stats)); // get your own networkstats
    ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "My NetworkStats", stats, "Okay", "");
    return 1;
}

CMD:pm(playerid, params[])
{
	new receiverid, chat[64], message[156], sNick[MAX_PLAYER_NAME], rNick[MAX_PLAYER_NAME];
	GetPlayerName(playerid, sNick, sizeof(sNick));
	if(sscanf(params, "ds[48]", receiverid, chat))
	{
		SendClientMessage(playerid, -1, "{00cc44}(L) U¿ycie komendy: {f2f2f2}/pm [id] [wiadomoœæ]");
		return 1;
	}
	if(!IsPlayerConnected(receiverid))
	{
		SendClientMessage(playerid, -1, "{00cc44}(L) Taki gracz nie istnieje.");
		return 1;
	}
	GetPlayerName(receiverid, rNick, sizeof(rNick));
	format(message, sizeof(message), "{ff8080}(PM) {e699ff}%s[%d] >> %s[%d]:{ff8080} %s", sNick, playerid, rNick, receiverid, chat);
	SendClientMessage(playerid, -1, message);
	format(message, sizeof(message), "{ff8080}(PM) {d966ff}%s[%d] >> %s[%d]:{ff8080} %s", sNick, playerid, rNick, receiverid, chat);
	SendClientMessage(receiverid, -1, message);
	return 1;
}


CMD:debug(playerid)
{
	return 1;
}

/*CMD:papierkamiennozyce(playerid, params[])
{
	new receiverid;
	if(sscanf(params, "d", receiverid))
	{
		SendClientMessage(playerid, -1, "UÂ¿ycie komendy: /papierkamiennozyce [playerid]");
		return 1;
	}

	if(receiverid == INVALID_PLAYER_ID)
	{
		SendClientMessage(playerid, -1, "")
	}
}*/