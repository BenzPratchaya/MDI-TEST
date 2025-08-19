using EnvisionIE.Connection.Engine;
using EnvisionIE.Operational;
using EnvisionIE.Operational.Miracle;
using EnvisionIEService.Api;
using System;
using System.Collections.Generic;
using System.Text;

namespace EnvisionMDIService
{
    public class ServiceConfig
    {
        public static List<string> AllowHosts => IeServiceConfig.Split(IeServiceConfig.Open(key: $"{IeServiceConfig.ServiceName}.AllowHosts"), new string[] { ";" });
        public static List<string> BlockHosts => IeServiceConfig.Split(IeServiceConfig.Open(key: $"{IeServiceConfig.ServiceName}.BlockHosts"), new string[] { ";" });

        public static bool EnableTraceInbound => Utilities.ToBoolean(IeServiceConfig.Open(key: $"{IeServiceConfig.ServiceName}.EnableTraceInbound"));

        public static bool MdiDbEnableTrace => Utilities.ToBoolean(IeServiceConfig.Open(key: $"{IeServiceConfig.ServiceName}.MdiDbEnableTrace"));
        public static string MdiDbConnectionString => IeServiceConfig.Open(key: $"{IeServiceConfig.ServiceName}.MdiDbConnectionString", encryption: true);
        public static int MdiEmpIdOfModify => Utilities.ToInt(IeServiceConfig.Open(key: $"{IeServiceConfig.ServiceName}.MdiEmpIdOfModify"));

        private static List<DbScript> db_scripts;
        public static IDbScript GetSqlScript(string scriptName)
        {
            if (!Utilities.HasData(db_scripts))
            {
                string key = $"{IeServiceConfig.ServiceName}.MdiDbScriptFolderName";
                string s = IeServiceConfig.Open(key);

                MiJsonObjectMultiList json_objs = IeServiceConfig.OpenFolder(s, "*.sql");

                if (json_objs == null)
                    return null;

                db_scripts = new List<DbScript>();

                json_objs.Values.ForEach(json_obj =>
                {
                    db_scripts.Add(new DbScript(json_obj["FileName"].ToString().Replace(".sql", ""), json_obj["Value"].ToString()));
                });
            }

            return db_scripts.Find(x => x.Name.Equals(scriptName, StringComparison.OrdinalIgnoreCase));
        }
    }
}