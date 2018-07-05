#include <a_samp>

#define FILTERSCRIPT

//CUSTOM DAMAGE

public OnPlayerSpawn(playerid)
{
	SetPlayerHealth(playerid, 100.0);
    SetPlayerArmour(playerid, 100.0);
    return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
    return 1;
}

public OnPlayerTakeDamage(playerid, issuerid, Float: amount, weaponid)
{
    if(weaponid == 27) //COMBAT C-FIX
    {   
        new Float:FullHealth, Float: Health, Float:Armor;
        FullHealth = Health + Armor;
        if(FullHealth <= 130.0)
        {
            SetPlayerArmour(playerid, Armor);
            SetPlayerHealth(playerid, Health);
        }
    }

    switch(weaponid) {
        case 24: customDamage(playerid, amount, 30.0);
        case 25: customDamage(playerid, amount, 15.0);
        case 26: customDamage(playerid, amount, 10.0);
        case 29: customDamage(playerid, amount, 8.0);
        case 31: customDamage(playerid, amount, 14.0);
        case 33: customDamage(playerid, amount, 35.0);
        case 34: customDamage(playerid, amount, 35.0);
    }

    /*if(weaponid == 24)
    {   
        damage = 30.0;
        FullHealth = Health + Armor;
        if(FullHealth >= 130.0)
        {
            SetPlayerArmour(playerid, Armor+amount);
            SetPlayerArmour(playerid, Armor-damage);
        }
        else if(FullHealth >= 100.1 && FullHealth <= 129.0)
        {
            Armor2 = damage - Armor;
            SetPlayerArmour(playerid, 0.0);
            FullHealth = FullHealth - Armor2;
            SetPlayerHealth(playerid, FullHealth);
        }
        else if(FullHealth <= 100.0)
        {
            SetPlayerHealth(playerid, FullHealth + amount);
            SetPlayerHealth(playerid, FullHealth - damage);
        }
    }

    if(weaponid == 25)
    {   
        damage = 15.0;
        FullHealth = Health + Armor;
        if(FullHealth >= 115.0)
        {
            SetPlayerArmour(playerid, Armor+amount);
            SetPlayerArmour(playerid, Armor-damage);
        }
        else if(FullHealth >= 100.1 && FullHealth <= 114.9)
        {
            Armor2 = damage - Armor;
            SetPlayerArmour(playerid, 0.0);
            FullHealth = FullHealth - Armor2;
            SetPlayerHealth(playerid, FullHealth);
        }
        else if(FullHealth <= 100.0)
        {
            SetPlayerHealth(playerid, FullHealth + amount);
            SetPlayerHealth(playerid, FullHealth - damage);
        }
    }

    if(weaponid == 29)
    {   
        damage = 8.0;
        FullHealth = Health + Armor;
        if(FullHealth >= 108.0)
        {
            SetPlayerArmour(playerid, Armor+amount);
            SetPlayerArmour(playerid, Armor-damage);
        }
        else if(FullHealth >= 100.1 && FullHealth <= 107.9)
        {
            Armor2 = damage - Armor;
            SetPlayerArmour(playerid, 0.0);
            FullHealth = FullHealth - Armor2;
            SetPlayerHealth(playerid, FullHealth);
        }
        else if(FullHealth <= 100.0)
        {
            SetPlayerHealth(playerid, FullHealth + amount);
            SetPlayerHealth(playerid, FullHealth - damage);
        }
    }

    if(weaponid == 34)
    {   
        damage = 35.0;
        FullHealth = Health + Armor;
        if(FullHealth >= 135.0)
        {
            SetPlayerArmour(playerid, Armor+amount);
            SetPlayerArmour(playerid, Armor-damage);
        }
        else if(FullHealth >= 100.1 && FullHealth <= 134.9)
        {
            Armor2 = damage - Armor;
            SetPlayerArmour(playerid, 0.0);
            FullHealth = FullHealth - Armor2;
            SetPlayerHealth(playerid, FullHealth);
        }
        else if(FullHealth <= 100.0)
        {
            SetPlayerHealth(playerid, FullHealth + amount);
            SetPlayerHealth(playerid, FullHealth - damage);
        }
    }

    if(weaponid == 26)
    {   
        damage = 10.0;
        FullHealth = Health + Armor;
        if(FullHealth >= 110.0)
        {
            SetPlayerArmour(playerid, Armor+amount);
            SetPlayerArmour(playerid, Armor-damage);
        }
        else if(FullHealth >= 100.1 && FullHealth <= 109.9)
        {
            Armor2 = damage - Armor;
            SetPlayerArmour(playerid, 0.0);
            FullHealth = FullHealth - Armor2;
            SetPlayerHealth(playerid, FullHealth);
        }
        else if(FullHealth <= 100.0)
        {
            SetPlayerHealth(playerid, FullHealth + amount);
            SetPlayerHealth(playerid, FullHealth - damage);
        }
    }

    if(weaponid == 31)
    {   
        damage = 14.0;
        FullHealth = Health + Armor;
        if(FullHealth >= 114.0)
        {
            SetPlayerArmour(playerid, Armor+amount);
            SetPlayerArmour(playerid, Armor-damage);
        }
        else if(FullHealth >= 100.1 && FullHealth <= 113.9)
        {
            Armor2 = damage - Armor;
            SetPlayerArmour(playerid, 0.0);
            FullHealth = FullHealth - Armor2;
            SetPlayerHealth(playerid, FullHealth);
        }
        else if(FullHealth <= 100.0)
        {
            SetPlayerHealth(playerid, FullHealth + amount);
            SetPlayerHealth(playerid, FullHealth - damage);
        }
    }

    if(weaponid == 33)
    {   
        damage = 40.0;
        FullHealth = Health + Armor;
        if(FullHealth >= 140.0)
        {
            SetPlayerArmour(playerid, Armor+amount);
            SetPlayerArmour(playerid, Armor-damage);
        }
        else if(FullHealth >= 100.1 && FullHealth <= 139.9)
        {
            Armor2 = damage - Armor;
            SetPlayerArmour(playerid, 0.0);
            FullHealth = FullHealth - Armor2;
            SetPlayerHealth(playerid, FullHealth);
        }
        else if(FullHealth <= 100.0)
        {
            SetPlayerHealth(playerid, FullHealth + amount);
            SetPlayerHealth(playerid, FullHealth - damage);
        }
    }*/
    
   /* GetPlayerHealth(playerid, Health);
    GetPlayerArmour(playerid, Armor);
    if(weaponid == 24) SetPlayerHealth(playerid, Health-30);//DesertEagle
    if(weaponid == 25) SetPlayerHealth(playerid, Health-25);//Shotgun
    if(weaponid == 29) SetPlayerHealth(playerid, Health-12);//MP5
    if(weaponid == 34) SetPlayerHealth(playerid, Health-35);//Sniper */
    //SOUND
    if(issuerid != INVALID_PLAYER_ID) PlayerPlaySound(issuerid,17802,0.0,0.0,0.0);
    return 1;
}


customDamage(playerid, Float:amount, Float:damage)
{
    new Float:Health, Float:Armor, Float:Armor2, Float:FullHealth;
    GetPlayerArmour(playerid, Armor);
    FullHealth = Health + Armor;
    if(FullHealth >= FullHealth+damage) {
        SetPlayerArmour(playerid, Armor+amount);
        SetPlayerArmour(playerid, Armor-damage);
    }
    else if(FullHealth >= 100.1 && FullHealth+damage-0.1) {
        Armor2 = damage - Armor;
        SetPlayerArmour(playerid, 0.0);
        FullHealth = FullHealth - Armor2;
        SetPlayerHealth(playerid, FullHealth);
    }
    else if(FullHealth <= 100.0) {
        SetPlayerHealth(playerid, FullHealth + amount);
        SetPlayerHealth(playerid, FullHealth - damage);
    }

    return 1;
}