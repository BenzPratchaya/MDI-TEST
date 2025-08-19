using System;
using System.Diagnostics;

namespace MDI
{
    public class WindowsCommands
    {
        public static void Shutdown()
        {
            Process.Start(new ProcessStartInfo("cmd", "/c shutdown /s /f /t 5")
            {
                CreateNoWindow = true,
                UseShellExecute = false
            });
        }
        public static void Restart()
        {
            Process.Start(new ProcessStartInfo("cmd", "/c shutdown /r /f /t 5")
            {
                CreateNoWindow = true,
                UseShellExecute = false
            });
        }
        public static void OnScreenKeyboard()
        {
            Process.Start(new ProcessStartInfo(string.Format("{0}\\{1}", Environment.GetEnvironmentVariable("windir"), "sysnative\\cmd.exe"), "/c osk.exe")
            {
                CreateNoWindow = true,
                UseShellExecute = false
            });
        }
        public static void NetworkConnections()
        {
            Process.Start(new ProcessStartInfo(string.Format("{0}\\{1}", Environment.GetEnvironmentVariable("windir"), "sysnative\\cmd.exe"), "/c ncpa.cpl")
            {
                CreateNoWindow = true,
                UseShellExecute = false
            });
        }
    }
}