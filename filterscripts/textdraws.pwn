#include <a_samp>
#include <sscanf2>
#include <tde_tdinfo>

#define FILTERSCRIPT

new Text:TDEditor_TD[1];
new Text:TDEditor_MOST[7];
new gtat_killstreak[MAX_PLAYERS];

new killstreak[MAX_PLAYERS];

public OnGameModeInit()
{
	TDEditor_TD[0] = TextDrawCreate(544.000000, 9.555496, "TOTAL DM");
	TextDrawLetterSize(TDEditor_TD[0], 0.510999, 1.780444);
	TextDrawAlignment(TDEditor_TD[0], 1);
	TextDrawColor(TDEditor_TD[0], 255);
	TextDrawSetShadow(TDEditor_TD[0], 1);
	TextDrawSetOutline(TDEditor_TD[0], 0);
	TextDrawBackgroundColor(TDEditor_TD[0], -2147483393);
	TextDrawFont(TDEditor_TD[0], 3);
	TextDrawSetProportional(TDEditor_TD[0], 1);
	TextDrawSetShadow(TDEditor_TD[0], 1);

	TDEditor_MOST[0] = TextDrawCreate(196.000000, 124.044555, "legend");
	TextDrawLetterSize(TDEditor_MOST[0], 0.855000, 3.609779);
	TextDrawAlignment(TDEditor_MOST[0], 1);
	TextDrawColor(TDEditor_MOST[0], 0xffb733ff);
	TextDrawSetShadow(TDEditor_MOST[0], 0);
	TextDrawSetOutline(TDEditor_MOST[0], 2);
	TextDrawBackgroundColor(TDEditor_MOST[0], 255);
	TextDrawFont(TDEditor_MOST[0], 3);
	TextDrawSetProportional(TDEditor_MOST[0], 1);
	TextDrawSetShadow(TDEditor_MOST[0], 0);

	TDEditor_MOST[1] = TextDrawCreate(196.000000, 124.044555, "playa");
	TextDrawLetterSize(TDEditor_MOST[1], 0.855000, 3.609779);
	TextDrawAlignment(TDEditor_MOST[1], 1);
	TextDrawColor(TDEditor_MOST[1], 0xffb733ff);
	TextDrawSetShadow(TDEditor_MOST[1], 0);
	TextDrawSetOutline(TDEditor_MOST[1], 2);
	TextDrawBackgroundColor(TDEditor_MOST[1], 255);
	TextDrawFont(TDEditor_MOST[1], 3);
	TextDrawSetProportional(TDEditor_MOST[1], 1);
	TextDrawSetShadow(TDEditor_MOST[1], 0);

	TDEditor_MOST[2] = TextDrawCreate(196.000000, 124.044555, "gangsta");
	TextDrawLetterSize(TDEditor_MOST[2], 0.855000, 3.609779);
	TextDrawAlignment(TDEditor_MOST[2], 1);
	TextDrawColor(TDEditor_MOST[2], 0xffb733ff);
	TextDrawSetShadow(TDEditor_MOST[2], 0);
	TextDrawSetOutline(TDEditor_MOST[2], 2);
	TextDrawBackgroundColor(TDEditor_MOST[2], 255);
	TextDrawFont(TDEditor_MOST[2], 3);
	TextDrawSetProportional(TDEditor_MOST[2], 1);
	TextDrawSetShadow(TDEditor_MOST[2], 0);

	TDEditor_MOST[3] = TextDrawCreate(196.000000, 124.044555, "hitman");
	TextDrawLetterSize(TDEditor_MOST[3], 0.855000, 3.609779);
	TextDrawAlignment(TDEditor_MOST[3], 1);
	TextDrawColor(TDEditor_MOST[3], 0xffb733ff);
	TextDrawSetShadow(TDEditor_MOST[3], 0);
	TextDrawSetOutline(TDEditor_MOST[3], 2);
	TextDrawBackgroundColor(TDEditor_MOST[3], 255);
	TextDrawFont(TDEditor_MOST[3], 3);
	TextDrawSetProportional(TDEditor_MOST[3], 1);
	TextDrawSetShadow(TDEditor_MOST[3], 0);

	TDEditor_MOST[4] = TextDrawCreate(196.000000, 124.044555, "rampage");
	TextDrawLetterSize(TDEditor_MOST[4], 0.855000, 3.609779);
	TextDrawAlignment(TDEditor_MOST[4], 1);
	TextDrawColor(TDEditor_MOST[4], 0xffb733ff);
	TextDrawSetShadow(TDEditor_MOST[4], 0);
	TextDrawSetOutline(TDEditor_MOST[4], 2);
	TextDrawBackgroundColor(TDEditor_MOST[4], 255);
	TextDrawFont(TDEditor_MOST[4], 3);
	TextDrawSetProportional(TDEditor_MOST[4], 1);
	TextDrawSetShadow(TDEditor_MOST[4], 0);

	TDEditor_MOST[5] = TextDrawCreate(196.000000, 124.044555, "godfather");
	TextDrawLetterSize(TDEditor_MOST[5], 0.855000, 3.609779);
	TextDrawAlignment(TDEditor_MOST[5], 1);
	TextDrawColor(TDEditor_MOST[5], 0xffb733ff);
	TextDrawSetShadow(TDEditor_MOST[5], 0);
	TextDrawSetOutline(TDEditor_MOST[5], 2);
	TextDrawBackgroundColor(TDEditor_MOST[5], 255);
	TextDrawFont(TDEditor_MOST[5], 3);
	TextDrawSetProportional(TDEditor_MOST[5], 1);
	TextDrawSetShadow(TDEditor_MOST[5], 0);

	TDEditor_MOST[6] = TextDrawCreate(196.000000, 124.044555, "most_respected");
	TextDrawLetterSize(TDEditor_MOST[6], 0.855000, 3.609779);
	TextDrawAlignment(TDEditor_MOST[6], 1);
	TextDrawColor(TDEditor_MOST[6], 0xffb733ff);
	TextDrawSetShadow(TDEditor_MOST[6], 0);
	TextDrawSetOutline(TDEditor_MOST[6], 2);
	TextDrawBackgroundColor(TDEditor_MOST[6], 255);
	TextDrawFont(TDEditor_MOST[6], 3);
	TextDrawSetProportional(TDEditor_MOST[6], 1);
	TextDrawSetShadow(TDEditor_MOST[6], 0);
	return 1;
}

public OnPlayerConnect(playerid)
{
	TextDrawShowForPlayer(playerid, TDEditor_TD[0]);
	gtat_killstreak[playerid] = 0;
	killstreak[playerid] = 0;
	return 1;
}

public OnPlayerSpawn(playerid)
{
	TextDrawHideForPlayer(playerid, TDEditor_MOST[0]);
	TextDrawHideForPlayer(playerid, TDEditor_MOST[1]);
	TextDrawHideForPlayer(playerid, TDEditor_MOST[2]);
	TextDrawHideForPlayer(playerid, TDEditor_MOST[3]);
	TextDrawHideForPlayer(playerid, TDEditor_MOST[4]);
	TextDrawHideForPlayer(playerid, TDEditor_MOST[5]);
	TextDrawHideForPlayer(playerid, TDEditor_MOST[6]);
}

public OnPlayerDeath(playerid, killerid, reason)
{
	new nickname[MAX_PLAYER_NAME];
	GetPlayerName(killerid, nickname, MAX_PLAYER_NAME);
	killstreak[killerid] += 1;
	
	if(gtat_killstreak[playerid] == 0)
	{
		killstreak[playerid] = 0;
	}

	if(killstreak[killerid] == 1 && gtat_killstreak[killerid] == 0)
	{
		gtat_killstreak[killerid] = 1;
		SetTimerEx("ThreeMinutes", 180000, 0, "d", killerid);
		SendClientMessage(killerid, -1, "{00cc44}(L) {D9D9D9}Masz 3 minuty na wykrêcenie najlepszego killstreaka!");
	}

	if(killstreak[killerid] == 3)
	{
		new message[128];
		TextDrawShowForPlayer(killerid, TDEditor_MOST[1]);
		format(message, sizeof(message), "{ff8000}(L) {f2f2f2}%s - {ff8000}jesteœ teraz PLAYA! Dokona³eœ 3 zabójstw w ci¹gu 3 minut.", nickname);
		SendClientMessage(killerid, -1, message);
		SetTimerEx("KillTimerz", 4000, 0, "d", killerid);
	}
	if(killstreak[killerid] == 6)
	{
		new message[128];
		TextDrawShowForPlayer(killerid, TDEditor_MOST[2]);
		format(message, sizeof(message), "{ff8000}(L) {f2f2f2}%s - {ff8000}jesteœ teraz GANGSTA! Dokona³eœ 6 zabójstw w ci¹gu 3 minut.", nickname);
		SendClientMessage(killerid, -1, message);
		SetTimerEx("KillTimerz", 4000, 0, "d", killerid);
	}
	if(killstreak[killerid] == 9)
	{
		new message[128];
		TextDrawShowForPlayer(killerid, TDEditor_MOST[3]);
		format(message, sizeof(message), "{ff8000}(L) {f2f2f2}%s - {ff8000}jesteœ teraz HITMAN! Dokona³eœ 9 zabójstw w ci¹gu 3 minut.", nickname);
		SendClientMessage(killerid, -1, message);
		SetTimerEx("KillTimerz", 4000, 0, "d", killerid);
	}
	if(killstreak[killerid] == 12)
	{
		new message[128];
		TextDrawShowForPlayer(killerid, TDEditor_MOST[4]);
		format(message, sizeof(message), "{ff8000}(L) {f2f2f2}%s - {ff8000}jesteœ teraz RAMPAGE! Dokona³eœ 12 zabójstw w ci¹gu 3 minut.", nickname);
		SendClientMessage(killerid, -1, message);
		SetTimerEx("KillTimerz", 4000, 0, "d", killerid);
	}
	if(killstreak[killerid] == 15)
	{
		new message[128];
		TextDrawShowForPlayer(killerid, TDEditor_MOST[5]);
		format(message, sizeof(message), "{ff8000}(L) {f2f2f2}%s - {ff8000}jesteœ teraz GODFATHER! Dokona³eœ 15 zabójstw w ci¹gu 3 minut.", nickname);
		SendClientMessage(killerid, -1, message);
		SetTimerEx("KillTimerz", 4000, 0, "d", killerid);
	}
	if(killstreak[killerid] == 18)
	{
		new message[128];
		TextDrawShowForPlayer(killerid, TDEditor_MOST[6]);
		format(message, sizeof(message), "{ff8000}(L) {f2f2f2}%s - {ff8000}jesteœ teraz MOST RESPECTED! Dokona³eœ 18 zabójstw w ci¹gu 3 minut.", nickname);
		SendClientMessage(killerid, -1, message);
		SetTimerEx("KillTimerz", 4000, 0, "d", killerid);
	}
	if(killstreak[killerid] == 21)
	{
		new message[128];
		TextDrawShowForPlayer(killerid, TDEditor_MOST[0]);
		format(message, sizeof(message), "{ff9933}(G) {f2f2f2}%s - {ff9933}jesteœ teraz LEGEND¥! Dokona³eœ 21 zabójstw w ci¹gu 3 minut.", nickname);
		SendClientMessageToAll(-1, message);
		SetTimerEx("KillTimerz", 4000, 0, "d", killerid);
	}
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	killstreak[playerid] = 0;
	return 1;
}

public OnFilterScriptExit()
{
	TextDrawDestroy(TDEditor_TD[0]);
	TextDrawDestroy(TDEditor_MOST[0]);
	return 1;
}

forward KillTimerz(killerid, textdr_id);
public KillTimerz(killerid, textdr_id)
{
	TextDrawHideForPlayer(killerid, TDEditor_MOST[0]);
	TextDrawHideForPlayer(killerid, TDEditor_MOST[1]);
	TextDrawHideForPlayer(killerid, TDEditor_MOST[2]);
	TextDrawHideForPlayer(killerid, TDEditor_MOST[3]);
	TextDrawHideForPlayer(killerid, TDEditor_MOST[4]);
	TextDrawHideForPlayer(killerid, TDEditor_MOST[5]);
	TextDrawHideForPlayer(killerid, TDEditor_MOST[6]);
	return 1;
}

forward ThreeMinutes(killerid);
public ThreeMinutes(killerid)
{
	new message[128], nickname[MAX_PLAYER_NAME];
	GetPlayerName(killerid, nickname, sizeof(nickname));
	format(message, sizeof(message), "{6699ff}(G) Gracz %s skoñczy³ respect spree z wynikiem %d zabójstw w ci¹gu 3 minut.", nickname, killstreak[killerid]);
	SendClientMessageToAll(-1, message);
	gtat_killstreak[killerid] = 0;
	killstreak[killerid] = 0;
	return 1;
}