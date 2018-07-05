#include <a_samp>

#define dcmd(%1,%2,%3) if (!strcmp((%3)[1], #%1, true, (%2)) && ((((%3)[(%2) + 1] == '\0') && (dcmd_%1(playerid, ""))) || (((%3)[(%2) + 1] == ' ') && (dcmd_%1(playerid, (%3)[(%2) + 2]))))) return 1  // Credits go to DracoBlue

// Message Colors
#define COLOR_ERROR 			0xFB0000FF
#define COLOR_MSG               0xFFFFFF00

// GangZone Colors
#define BLACK                  	0x000000C7
#define WHITE                  	0xFFFFFFBE
#define ORANGE                  0xFF8000B8
#define RED                     0xFF0000C7
#define BLUE                    0x0000FFC5
#define VIOLET                  0x8000FFC9
#define GREEN                   0x00FF00D0
#define YELLOW                  0xFFFF00CC
#define PINK                    0xFF80FFC7
#define SEABLUE                 0x5BB9E6CA
#define BROWN                   0x562C2CD2

// Max Zones You Can Create
#define MAX_ZONES               100

new
	bool: GangZone[MAX_PLAYERS],
	bool: Spawned[MAX_PLAYERS],
	bool: GetPos[MAX_PLAYERS],
	CreatedZone[MAX_ZONES],
	gColor,
	Float: pMaxX = 0.0,
	Float: pMaxY = 0.0,
	Float: pMinX = 0.0,
	Float: pMinY = 0.0,
	Float: pZ = 0.0,
	gCount;

public OnFilterScriptInit()
{
	print("---------------------------------------");
	print(" GangZone Creator by RyDeR - Loaded - ");
	print("---------------------------------------");
	return 1;
}

public OnFilterScriptExit()
{
	new i;
	while(i != MAX_PLAYERS)
	{
	    Spawned[i] = false;
	    GangZone[i] = false;
		++i;
	}
	new g;
	while(g != MAX_ZONES)
	{
	    --CreatedZone[g];
	    --g;
	}
	return 1;
}

dcmd_gzone(playerid, params[])
{
	#pragma unused params
	if(!IsPlayerAdmin(playerid)) return SendClientMessage(playerid, COLOR_ERROR, ">> Only the server owner can make gangzones!");
	if(GangZone[playerid] == true) return SendClientMessage(playerid, COLOR_ERROR, ">> You are already creating a gangzone!");
	if(IsPlayerInAnyVehicle(playerid)) RemovePlayerFromVehicle(playerid);
	ShowDefaultDialog(playerid);
	return 1;
}

ShowDefaultDialog(playerid)
{
	return ShowPlayerDialog(playerid, 9540, DIALOG_STYLE_LIST, "GangZone Creator by RyDeR", "Create Gangzone", "Select", "Exit");
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	switch(dialogid)
	{
		case 9540:
    	{
    	    if(response == 0) return 1;
    	    switch(listitem)
    	    {
    	        case 0:
    	        {
       				ShowPlayerDialog(playerid, 9541, DIALOG_STYLE_LIST, "Choose the color of the gangzone", "Black\nWhite\nOrange\nRed\nBlue\nViolet\nGreen\nYellow\nPink\nSeablue\nBrown", "Select", "Back");
				}
			}
       	}
	   	case 9541:
    	{
     		if(response == 0) return ShowDefaultDialog(playerid);
     		switch(listitem)
       		{
       		    case 0:  gColor = BLACK;
       		    case 1:  gColor = WHITE;
       		    case 2:  gColor = ORANGE;
       		    case 3:  gColor = RED;
       		    case 4:  gColor = BLUE;
       		    case 5:  gColor = VIOLET;
       		    case 6:  gColor = GREEN;
       		    case 7:  gColor = YELLOW;
       		    case 8:  gColor = PINK;
       		    case 9:  gColor = SEABLUE;
       		    case 10: gColor = BROWN;
       		}
            ShowPlayerDialog(playerid, 9542, DIALOG_STYLE_MSGBOX, "Gangzone Info", "GangZone Created! Use arrow keys to make the zone bigger or less\nUsing Fire Key + Arrow keys you minus the height or width.\nPress enter when you are done!", "Agree", "Back");
   		}
		case 9542:
		{
		    if(response == 0) return ShowPlayerDialog(playerid, 9541, DIALOG_STYLE_LIST, "Choose the color of the gangzone", "Black\nWhite\nOrange\nRed\nBlue\nViolet\nGreen\nYellow\nPink\nSeablue\nBrown", "Select", "Back");
			GangZone[playerid] = true;
   			GetPos[playerid] = false;
		}
		case 9545:
		{
		    if(response == 0)
			{
				GangZoneDestroy(GangZone[gCount]);
				return 1;
			}
			new
			    string[128],
			    string2[256],
				File:SaveIt;

			if(!strlen(inputtext)) return ShowPlayerDialog(playerid, 9546, DIALOG_STYLE_MSGBOX, "Error", "You have to give a name to save it.", "Try again", "Don't Save");
			format(string, 128, "%s.rZone", inputtext);
			format(string2, sizeof(string2), "//At The Top Of The Script:\r\nnew %s;\r\n\r\n//Under OnGameModeInit\r\n%s = GangZoneCreate(%f, %f, %f, %f);\r\n\r\n//Under OnPlayerSpawn:\r\nGangZoneShowForPlayer(playerid, %s, %d);", inputtext, inputtext, pMinX, pMinY, pMaxX, pMaxY, inputtext, gColor);
			SaveIt = fopen(string, io_write);
      		fwrite(SaveIt, string2);
		    fclose(SaveIt); 
            ShowPlayerDialog(playerid, 9547, DIALOG_STYLE_MSGBOX, "Progess Complete!", "Your gangzone has been saved. Check the scriptfiles directory!", "Another", "Exit");
			new
			    g;
			    
			while(g <sizeof(gCount))
			{
			    ++CreatedZone[g];
			    ++g;
			}
		}
		case 9546:
		{
		    if(response == 0)
			{
				GangZoneDestroy(GangZone[gCount]);
				return 1;
			}
			ShowPlayerDialog(playerid, 9545, DIALOG_STYLE_INPUT, "Save or delete zone", "To save this give the name for it.\nIf you want to delete this click on 'exit'", "Save", "Delete");
		}
		case 9547:
		{
		    if(response == 0) return 1;
			ShowDefaultDialog(playerid);
		}
	}
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	dcmd(gzone, 5, cmdtext);
	return 0;
}

public OnPlayerUpdate(playerid)
{
	if(IsPlayerConnected(playerid))
	{
	    if(GangZone[playerid] == true)
	    {
	        new
	            Keys,
	            UpDown,
	            LeftRight;
				
       		if(GetPos[playerid] == false) GetPlayerPos(playerid, pMaxX, pMaxY, pZ), GetPlayerPos(playerid, pMinX, pMinY, pZ), GetPos[playerid] = true;
	        GetPlayerKeys(playerid, Keys, UpDown, LeftRight);
	        TogglePlayerControllable(playerid, false);
	        
	        if(LeftRight == KEY_LEFT)
	        {
	            pMinX -= 8.0;
	         	GangZoneDestroy(CreatedZone[gCount]);
	       		CreatedZone[gCount] = GangZoneCreate(pMinX, pMinY, pMaxX, pMaxY);
	         	GangZoneShowForPlayer(playerid, CreatedZone[gCount], gColor);
	        }
	        else if(LeftRight & KEY_LEFT && Keys & KEY_FIRE)
	        {
         		pMinX += 8.0;
	         	GangZoneDestroy(CreatedZone[gCount]);
	       		CreatedZone[gCount] = GangZoneCreate(pMinX, pMinY, pMaxX, pMaxY);
	         	GangZoneShowForPlayer(playerid, CreatedZone[gCount], gColor);
	        }
	        else if(LeftRight == KEY_RIGHT)
	        {
	        	pMaxX += 8.0;
	         	GangZoneDestroy(CreatedZone[gCount]);
	       		CreatedZone[gCount] = GangZoneCreate(pMinX, pMinY, pMaxX, pMaxY);
	         	GangZoneShowForPlayer(playerid, CreatedZone[gCount], gColor);
			}
	        else if(LeftRight & KEY_RIGHT && Keys & KEY_FIRE)
	        {
	        	pMaxX -= 8.0;
	         	GangZoneDestroy(CreatedZone[gCount]);
	       		CreatedZone[gCount] = GangZoneCreate(pMinX, pMinY, pMaxX, pMaxY);
	         	GangZoneShowForPlayer(playerid, CreatedZone[gCount], gColor);
			}
			else if(UpDown == KEY_UP)
			{
			    pMaxY += 8.0;
	         	GangZoneDestroy(CreatedZone[gCount]);
	       		CreatedZone[gCount] = GangZoneCreate(pMinX, pMinY, pMaxX, pMaxY);
	         	GangZoneShowForPlayer(playerid, CreatedZone[gCount], gColor);
			}
			else if(UpDown & KEY_UP && Keys & KEY_FIRE)
			{
			    pMaxY -= 8.0;
	         	GangZoneDestroy(CreatedZone[gCount]);
	       		CreatedZone[gCount] = GangZoneCreate(pMinX, pMinY, pMaxX, pMaxY);
	         	GangZoneShowForPlayer(playerid, CreatedZone[gCount], gColor);
			}
			else if(UpDown == KEY_DOWN)
			{
			    pMinY -= 8.0;
	         	GangZoneDestroy(CreatedZone[gCount]);
	       		CreatedZone[gCount] = GangZoneCreate(pMinX, pMinY, pMaxX, pMaxY);
	         	GangZoneShowForPlayer(playerid, CreatedZone[gCount], gColor);
			}
			else if(UpDown & KEY_DOWN && Keys & KEY_FIRE)
			{
			    pMinY += 8.0;
	         	GangZoneDestroy(CreatedZone[gCount]);
	       		CreatedZone[gCount] = GangZoneCreate(pMinX, pMinY, pMaxX, pMaxY);
	         	GangZoneShowForPlayer(playerid, CreatedZone[gCount], gColor);
			}
			else if(Keys & KEY_SECONDARY_ATTACK)
			{
				TogglePlayerControllable(playerid, true);
				GangZone[playerid] = false;
				GetPos[playerid] = false;
				ShowPlayerDialog(playerid, 9545, DIALOG_STYLE_INPUT, "Save or delete zone", "To save this give the name for it.\nIf you want to delete this click on 'exit'", "Save", "Delete");
			}
	    }
	}
	return 1;
}

public OnPlayerConnect(playerid)
{
	GangZone[playerid] = false;
	Spawned[playerid] = false;
	GetPos[playerid] = false;
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	GangZone[playerid] = false;
	Spawned[playerid] = false;
	GetPos[playerid] = false;
	GangZoneDestroy(GangZone[gCount]);
	return 1;
}

public OnPlayerSpawn(playerid)
{
	Spawned[playerid] = true;
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
    Spawned[playerid] = false;
	return 1;
}
