#include <a_samp>

#define FILTERSCRIPT


new
	pDrunkLevelLast[MAX_PLAYERS],
	PlayerText3D:playertextid,
	pFPS[MAX_PLAYERS]
;

forward Atualizar(playerid);

public OnPlayerUpdate(playerid)
{
	new drunknew = GetPlayerDrunkLevel(playerid);
    if(drunknew < 100) return SetPlayerDrunkLevel(playerid, 2000);
	else
	{
        if (pDrunkLevelLast[playerid] != drunknew)
		{
            new wfps = pDrunkLevelLast[playerid] - drunknew;
            if ((wfps > 0) && (wfps < 200)) pFPS[playerid] = wfps;
            pDrunkLevelLast[playerid] = drunknew;
        }
	}
	SetTimerEx("Atualizar", 101, 1, "i", playerid);
	return 1;
}

public Atualizar(playerid)
{
	for(new i; i < sizeof(playertextid); i++) DeletePlayer3DTextLabel(playerid, playertextid);
	new
		Float:P[3],
		sStr[100]
	;
	GetPlayerPos(playerid, P[0], P[1], P[2]);
    format(sStr, sizeof(sStr), "{8080ff}Ping: {d9d9d9}%i\n{8080ff}FPS: {d9d9d9}%i", GetPlayerPing(playerid), pFPS[playerid]);
    playertextid = CreatePlayer3DTextLabel(playerid, sStr, 0xF09C00AA, P[0], P[1], P[2]+1.0, -5.0);
	UpdatePlayer3DTextLabelText(playerid, playertextid, 0xF09C00AA, sStr);
	return 1;
}

public OnPlayerConnect(playerid)
{
    pDrunkLevelLast[playerid] = 0;
    pFPS[playerid] = 0;
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
    pDrunkLevelLast[playerid] = 0;
    pFPS[playerid] = 0;
	return 1;
}