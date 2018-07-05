#include <a_samp>
#include <zcmd>

#define FILTERSCRIPT
#define DIALOG_GUNMENU 100

new bool:gunmenu[MAX_PLAYERS], gunlimit[MAX_PLAYERS], guns[MAX_PLAYERS][5];

public OnPlayerConnect(playerid)
{
	resetGlobalVariables(playerid);
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	resetGlobalVariables(playerid);
	return 1;
}

resetGlobalVariables(playerid)
{
	gunmenu[playerid] = false;
	gunlimit[playerid] = 0;
	guns[playerid][0] = 0;
	guns[playerid][1] = 0;
	guns[playerid][2] = 0;
	guns[playerid][3] = 0;
	guns[playerid][4] = 0;
	return 1;
}

public OnPlayerSpawn(playerid)
{
	checkSpawnGunMenu(playerid);
	return 1;
}

checkSpawnGunMenu(playerid) {
	if(gunlimit[playerid] == 4) gunmenu[playerid] = true;
	if(gunmenu[playerid] == false && gunlimit[playerid] <= 3)
	{
		gunList(playerid);
	}
	else
	{
		if(GetPlayerInterior(playerid) != 3)
		{
		GivePlayerWeapon(playerid, guns[playerid][0], 999);
		GivePlayerWeapon(playerid, guns[playerid][1], 999);
		GivePlayerWeapon(playerid, guns[playerid][2], 999);
		GivePlayerWeapon(playerid, guns[playerid][3], 999);
		GivePlayerWeapon(playerid, guns[playerid][4], 999);
		}
		else
		{
			SetPlayerArmour(playerid, 0.0);
			SetPlayerHealth(playerid, 10.0);
		}
	}
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(dialogid == DIALOG_GUNMENU)
	{
		dialogGunMenu(playerid, response, listitem);
		return 1;
	}
	return 0;
}

dialogGunMenu(playerid, response, listitem) { //never open this shit
	if(gunlimit[playerid] <= 3)
		{
			if(response)
			{
				switch(listitem)
				{
					case 0: 
					{
						GivePlayerWeapon(playerid, WEAPON_DEAGLE, 999);
						guns[playerid][0] = 24;
					}
					case 1: 
					{
						GivePlayerWeapon(playerid, WEAPON_SHOTGUN, 999);
						guns[playerid][1] = 25;
					}
					case 2:
					{
						GivePlayerWeapon(playerid, WEAPON_MP5, 999);
						guns[playerid][2] = 29;
					}
					case 3: 
					{
						GivePlayerWeapon(playerid, WEAPON_SNIPER, 999);
						guns[playerid][3] = 34;
					}
					case 4:
					{
						GivePlayerWeapon(playerid, WEAPON_SHOTGSPA, 999);
						guns[playerid][1] = 27;
					}
					case 5: 
					{
						GivePlayerWeapon(playerid, WEAPON_SAWEDOFF, 999);
						guns[playerid][1] = 26;
					}
					case 6: 
					{
						GivePlayerWeapon(playerid, WEAPON_M4, 999);
						guns[playerid][4] = 31;
					}
					case 7: 
					{
						GivePlayerWeapon(playerid, WEAPON_RIFLE, 999);
						guns[playerid][3] = 33;
					}
				}

				gunlimit[playerid] += 1;
				ShowPlayerDialog(playerid, DIALOG_GUNMENU, DIALOG_STYLE_TABLIST_HEADERS, "Wybierz uzbrojenie!",
				"Bron\tDamage\n\
				Deagle\t30\n\
				Shotgun\t15\n\
				MP5\t8\n\
				Sniper Rifle\t35\n\
				Spaz\t15\n\
				Sawn-Off\t10\n\
				M4\t20\n\
				Country Rifle\t40", "Wybierz", "Zamknij");
			}
			else
			{
				SendClientMessage(playerid, -1, "Nie wybrales broni.");
				gunmenu[playerid] = true;
			}
		}
		else
		{
			SendClientMessage(playerid, -1, "Masz juz wszystkie bronie.");
		}
	return 1;
}

CMD:gunmenu(playerid)
{
	gunmenu[playerid] = false;
	gunlimit[playerid] = 0;
	SetPlayerAmmo(playerid, WEAPON_DEAGLE, 0);
	SetPlayerAmmo(playerid, WEAPON_SHOTGUN, 0);
	SetPlayerAmmo(playerid, WEAPON_MP5, 0);
	SetPlayerAmmo(playerid, WEAPON_SNIPER, 0);
	SetPlayerAmmo(playerid, WEAPON_SHOTGSPA, 0);
	SetPlayerAmmo(playerid, WEAPON_SAWEDOFF, 0);
	SetPlayerAmmo(playerid, WEAPON_M4, 0);
	SetPlayerAmmo(playerid, WEAPON_RIFLE, 0);
	guns[playerid][0] = 0;
	guns[playerid][1] = 0;
	guns[playerid][2] = 0;
	guns[playerid][3] = 0;
	guns[playerid][4] = 0;
	if(gunmenu[playerid] == false)
	{
		gunList(playerid);
	}
	return 1;
}

gunList(playerid) {
	ShowPlayerDialog(playerid, DIALOG_GUNMENU, DIALOG_STYLE_TABLIST_HEADERS, "Wybierz uzbrojenie!",
		"Bron\tDamage\n\
		Deagle\t30\n\
		Shotgun\t15\n\
		MP5\t8\n\
		Sniper Rifle\t35\n\
		Spaz\t15\n\
		Sawn-Off\t10\n\
		M4\t14\n\
		Country Rifle\t35", "Wybierz", "Zamknij");
	return 1;//main gun list
}