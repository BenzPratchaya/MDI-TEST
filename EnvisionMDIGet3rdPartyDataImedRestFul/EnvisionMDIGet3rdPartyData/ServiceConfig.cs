using EnvisionIE.Operational;
using EnvisionIEService.Api;
using System.Collections.Generic;
using System.Text;

namespace EnvisionMDIGet3rdPartyData
{
    public class ServiceConfig
    {
        public static List<string> AllowHosts => IeServiceConfig.Split(IeServiceConfig.Open(key: $"{IeServiceConfig.ServiceName}.AllowHosts"), new string[] { ";" });
        public static List<string> BlockHosts => IeServiceConfig.Split(IeServiceConfig.Open(key: $"{IeServiceConfig.ServiceName}.BlockHosts"), new string[] { ";" });

        public static bool EnableTraceInbound => Utilities.ToBoolean(IeServiceConfig.Open(key: $"{IeServiceConfig.ServiceName}.EnableTraceInbound"));

        public static bool MdiDbEnableTrace => Utilities.ToBoolean(IeServiceConfig.Open(key: $"{IeServiceConfig.ServiceName}.MdiDbEnableTrace"));
        public static string MdiDbConnectionString => IeServiceConfig.Open(key: $"{IeServiceConfig.ServiceName}.MdiDbConnectionString", encryption: true);
        public static int MdiDefaultOrganizationId => Utilities.ToInt(IeServiceConfig.Open(key: $"{IeServiceConfig.ServiceName}.MdiDefaultOrganizationId"));
        public static int MdiDefaultEmpIdOfModify => Utilities.ToInt(IeServiceConfig.Open(key: $"{IeServiceConfig.ServiceName}.MdiDefaultEmpIdOfModify"));

        public static bool HisHttpEnableTrace => Utilities.ToBoolean(IeServiceConfig.Open(key: $"{IeServiceConfig.ServiceName}.HisHttpEnableTrace"));
        public static Encoding HisHttpEncoding => Utilities.ToEncoding(IeServiceConfig.Open(key: $"{IeServiceConfig.ServiceName}.HisHttpEncoding"));
        public static string HisUrlPatient => IeServiceConfig.Open(key: $"{IeServiceConfig.ServiceName}.HisUrlPatient");
        public static string HisUrlResult => IeServiceConfig.Open(key: $"{IeServiceConfig.ServiceName}.HisUrlResult");
        public static string HisEmpUidOfConfirmedResult => IeServiceConfig.Open(key: $"{IeServiceConfig.ServiceName}.HisEmpUidOfConfirmedResult");
    }
}