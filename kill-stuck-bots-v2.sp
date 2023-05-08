#include <sourcemod>

public Plugin myinfo =
{
	name = "Kill stuck bots",
	author = "Gnomesenpai",
	description = "probably broken",
	version = "1.0",
	url = "http://www.sourcemod.net/"
};

public Action KillStuckBots(int client, int args)
{
    const int STUCK_TIME_LIMIT = 60; // 60 seconds
    for (int i = 1; i <= MaxClients; i++) {
        if (IsFakeClient(i) && GetClientTeam(i) == TEAM_SPECTATOR) {
            int activity = GetClientActivity(i);
            if (activity == ACT_INVALID || activity == ACT_RESET) {
                int timeStuck = GetFakeClientTime(i);
                if (timeStuck >= STUCK_TIME_LIMIT) {
                    ClientPrint(i, print_console, "Killing stuck bot\n");
                    ForcePlayerSuicide(i);
                }
            }
        }
    }
    return Plugin_Handled;
}