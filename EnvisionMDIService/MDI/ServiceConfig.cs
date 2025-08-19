using EnvisionIE.Entity.Global;
using EnvisionIE.Operational;
using EnvisionIE.Operational.Miracle;
using EnvisionIEService.Api;
using MDI.Entity;
using System;
using System.IO;

namespace MDI
{
    public class ServiceConfig
    {
        private static ModalityConfig modality_config = null;
        public static ModalityConfig ModalityConfig
        {
            get
            {
                if (modality_config == null)
                {
                    bool is_applicatoin_file = true;

                    string user_file_path = $"{Environment.GetFolderPath(Environment.SpecialFolder.UserProfile)}\\MDI\\ModalityConfig.json";
                    string applicatoin_file_path = "";

                    if (File.Exists(user_file_path))
                    {
                        applicatoin_file_path = user_file_path;
                        is_applicatoin_file = false;
                    }
                    else
                    {
                        string file_name = IeServiceConfig.Open(key: $"{IeServiceConfig.ServiceName}.ModalityConfigFileName");

                        if (string.IsNullOrEmpty((file_name ?? "").Trim()))
                            return new ModalityConfig();

                        applicatoin_file_path = AppDomain.CurrentDomain.BaseDirectory + file_name;

                        if (!File.Exists(applicatoin_file_path))
                            return new ModalityConfig();
                    }

                    string config_message = Utilities.OpenTextFile(applicatoin_file_path).Trim();

                    if (string.IsNullOrEmpty(config_message))
                        return new ModalityConfig();

                    modality_config = new MiJsonObjectList(config_message).To<ModalityConfig>();

                    IeServiceConfig.UrlEnvisionIeService = modality_config.UrlConnection.Trim().TrimEnd(new char[] { '/' }) + "/EnvisionIEService/";

                    if (is_applicatoin_file)
                        Utilities.SaveTextFile(user_file_path, new MiJsonObjectList(modality_config).ToJsonString(), DefaultValue.Encoding, false);
                }

                return modality_config;
            }
            set
            {
                if (value == null)
                    modality_config = null;
                else
                {
                    string file_name = IeServiceConfig.Open(key: $"{IeServiceConfig.ServiceName}.ModalityConfigFileName");

                    if (string.IsNullOrEmpty((file_name ?? "").Trim()))
                        return;

                    string applicatoin_file_path = AppDomain.CurrentDomain.BaseDirectory + file_name;

                    if (Utilities.SaveTextFile(applicatoin_file_path, new MiJsonObjectList(value).ToJsonString(), DefaultValue.Encoding, false))
                    {
                        modality_config = value;

                        Utilities.SaveTextFile($"{Environment.GetFolderPath(Environment.SpecialFolder.UserProfile)}\\MDI\\ModalityConfig.json", new MiJsonObjectList(modality_config).ToJsonString(), DefaultValue.Encoding, false);
                    }
                }
            }
        }
    }
}