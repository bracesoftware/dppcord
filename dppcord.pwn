/*
*
* D++ Scripting Language
*     Made for a SA:MP server
*
* Library: DPPcord
*
* 
* - by: DEntisT, (c) 2022
*
*/

#include <open.mp>

/*
*
*
*
*   MACROS
*
*
*/

new
    dpp_error_str[1024];
#define dpp_isinrange(%0,%1,%2) (((%0)-((%1)+cellmin))<((%2)-((%1)+cellmin))) 
// creds Y_Less
#define __line,) __line)
#define dpp_argcharsize 256
#define dppcord_error%0(%1,%2) format(dpp_error_str,sizeof dpp_error_str,">> DPPcord | ERROR (dppcord.amx @ %s:%i): "%1,__file,__line,%2)&& \
    print(dpp_error_str)

new dppcord_isused = 0;

// Used by DPPcord itself
#define DCC_INVALID_CHANNEL DCC_Channel:0
native DCC_Channel:DCC_FindChannelById(const channel_id[]);

/*
*
*
*
*   Functions
*
*
*/

// Implemented in d++
native DCC_SendChannelMessage(DCC_Channel:channel, const message[], const callback[] = "", const format[] = "", {Float, _}:...);

/*
*
*
*
*   UTILS
*
*
*/

stock bool:dpp_isnumeric(const str[]) // creds Y_Less
{
    new
        i = -1;
    if (ispacked(str))
    {
        if (str{0} == '-') ++i;
        while (dpp_isinrange(str{++i}, '0', '9' + 1)) {}
        return !str{i};
    }
    else
    {
        if (str[0] == '-') ++i;
        while (dpp_isinrange(str[++i], '0', '9' + 1)) {}
        return !str[i];
    }
}


public OnFilterScriptInit()
{
    if(dppcord_isused == 0)
    {
        return 1;
    }

    CallRemoteFunction("dpp_callform", "s", "discord_init");

    return 1;
}

/*
*
*
*
*   DPPcord
*
*
*/

forward dppcord_codeprocess(funcgroup[][],args[][],args_const[][]);
public dppcord_codeprocess(funcgroup[][],args[][],args_const[][])
{
    if(!strcmp(funcgroup[0], "using"))
    {
        if(!strcmp(funcgroup[1], "dppcord"))
        {
            dppcord_isused = 1;
            return 1;
        }
    }
    return 1;
}

forward dppcord_process(funcgroup[][],args[][],args_const[][]);
public dppcord_process(funcgroup[][],args[][],args_const[][])
{
    if(!strcmp(funcgroup[0], "discord"))
    {
        if(dppcord_isused == 0)
        {
            dppcord_error("API \"dppcord\" is not imported.",);
            return 1;
        }
        if(!strcmp(funcgroup[1], "discord_bot_send_message"))
        {
            if(!dpp_isnumeric(args[0]))
            {
                dppcord_error("Argument error; [argid - 0] \"%s\"", args[0]);
                return 1;
            }

            new mul, str[dpp_argcharsize];
            strmid(str, args[1], 0, dpp_argcharsize);
            for(new i; i < strlen(args[1]); i++)
            {
                if(args[1][i] == '\"') mul++, strdel(args[1], i, i+1);
            }
            if(mul == 0)
            {
                dppcord_error("You need to use '\"' to start a string.",);
                return 1;
            }
            if(mul != 2)
            {
                dppcord_error("Argument error; [%i] \"%s\"", mul, args[1]);
                return 1;
            }

            new DCC_Channel:channel = DCC_FindChannelById(args[0]);

            if(channel == DCC_INVALID_CHANNEL)
            {
                dppcord_error("Unknown channel.",);
                return 1;
            }

            //native DCC_SendChannelMessage(DCC_Channel:channel, const message[], const callback[] = "", const format[] = "", {Float, _}:...);
            DCC_SendChannelMessage(channel,args[1]);
            return 1;
        }

        else
        {
            dppcord_error("Unknown form in the API \"dppcord\".",);
            return 1;
        }
    }
    return 0;
}