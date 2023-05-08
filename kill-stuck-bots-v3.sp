#include <sourcemod>
#include <tf2>


public Plugin myinfo =
{
	name = "Kill stuck bots",
	author = "Gnomesenpai",
	description = "probably broken",
	version = "1.0",
	url = "http://www.sourcemod.net/"
};

// Time limit in seconds
const int STUCK_TIME_LIMIT = 60;

public void OnPluginStart()
{
    RegConsoleCmd("killstuckbots", "Kill stuck MvM bots", "KillStuckBots", FCVAR_CLIENTCMD_CAN_EXECUTE);
}

public Action KillStuckBots(int client, int args)
{
    for (int i = 1; i <= MaxClients; i++) {
        if (IsFakeClient(i) && GetClientTeam(i) == TEAM_SPECTATOR) {
            int activity = GetClientActivity(i);
            if (activity == ACT_INVALID || activity == ACT_RESET) {
                float lastActivity = GetClientLastActivity(i);
                if (lastActivity != 0 && GetGameTime() - lastActivity > STUCK_TIME_LIMIT) {
                    ClientPrint(i, print_console, "Killing stuck bot\n");
                    ForcePlayerSuicide(i);
                }
            }
        }
    }
    return Plugin_Handled;
}