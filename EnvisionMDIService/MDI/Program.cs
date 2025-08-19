using EnvisionIE.Operational;
using EnvisionIE.Operational.Miracle;
using EnvisionIEService.Api;
using EnvisionIEService.Entity;
using IWshRuntimeLibrary;
using MDI.Forms;
using System;
using System.Collections;
using System.Collections.Generic;
using System.Reflection;
using System.ServiceModel;
using System.Text;
using System.Threading;
using System.Windows.Forms;
using static System.Windows.Forms.VisualStyles.VisualStyleElement.ProgressBar;

namespace MDI
{
    public class SerailMessage
    {
        public string StartOfText { get; set; } = "\u0002";
        public string EndOfText { get; set; } = "\u0003";
        public string Superate { get; set; } = "\u0003";
        public string BlockCheckCharacter { get; set; } = "";

        public MiStringArray Items { get; set; } = new MiStringArray();

        public SerailMessage() { }

        public string CalculateBlockCheckCharacter()
        {
            string message = string.Join(Superate, Items.Values);

            byte[] buffer = Encoding.ASCII.GetBytes(message);
            uint bcc = 0;
            uint xor = 0;

            for (var i = 0; i < buffer.Length; i++)
            {
                char c = (char)buffer[i];

                uint hex = (uint)c;

                if (i == 0) { xor = hex; }
                else
                {
                    bcc = xor ^ hex;
                    xor = bcc;
                }
            }

            return string.Format("\\u{0:X4}", (ushort)bcc);
        }
    }
    static class Program
    {
        [STAThread]
        static void Main()
        {
            //string message = "\u0002R1,000000000,210427,153000,128,097,082,084,0000,0000,00000,000\u0003?";


            Application.ThreadException += new ThreadExceptionEventHandler(Application_ThreadException);
            AppDomain.CurrentDomain.UnhandledException += new UnhandledExceptionEventHandler(CurrentDomain_UnhandledException);

            SetStartup();

            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault(false);

            if (Screen.PrimaryScreen.Bounds.Width > Screen.PrimaryScreen.Bounds.Height)
                Application.Run(new frmMonitoring());
            else
                Application.Run(new frmMonitoringPortrait());
        }

        private static void Application_ThreadException(object sender, ThreadExceptionEventArgs e) { save_log(e.Exception); }
        private static void CurrentDomain_UnhandledException(object sender, UnhandledExceptionEventArgs e) { save_log(e.ExceptionObject); }

        private static void save_log(object obj)
        {
            List<string> message_list = new List<string>();
            string message = "";

            try
            {
                Exception ex = null;

                if (obj is OutOfMemoryException)
                    ex = (obj as OutOfMemoryException).GetBaseException();
                else
                    ex = obj as Exception;

                message_list.Add(string.Format("Message : {0}", ex.Message.Trim()));
                message_list.Add("");
                message_list.Add(string.Format("Source : {0}", ex.Source.Trim()));
                message_list.Add("");
                message_list.Add(string.Format("Target Site : {0}", ex.TargetSite.ToString().Trim()));
                message_list.Add("");
                message_list.Add(string.Format("Stack Trace : {0}", ex.StackTrace.Trim()));
                message_list.Add("");

                if (ex.Data.Count > 0)
                {
                    foreach (DictionaryEntry data in ex.Data)
                    {
                        message_list.Add(string.Format("{0} : {1}", data.Key, data.Value));
                        message_list.Add("");
                    }
                }

                message = ex.Message.Trim();
            }
            catch { message = obj.ToString(); }

            IeServiceLog.Save(new IeLog()
            {
                OwnerName = ServiceConfig.ModalityConfig.ModalityUid,

                EventName = "Application_Exception",
                EventData = message,

                AcknowledgementCode = "AE",
                TextMessage = ""
            });

            MessageBox.Show(message);
        }

        private static void SetStartup()
        {
            string application_name = Assembly.GetExecutingAssembly().GetName().Name;

            IWshShortcut link = (IWshShortcut)new WshShell().CreateShortcut($"{Environment.GetFolderPath(Environment.SpecialFolder.Startup)}\\{application_name}.lnk");
            link.TargetPath = $"{Environment.CurrentDirectory}\\{application_name}.exe";
            link.Save();
        }
    }
}