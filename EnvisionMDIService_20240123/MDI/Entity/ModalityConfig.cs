using EnvisionIE.Entity.Global;
using System;
using System.Text;

namespace MDI.Entity
{
    public class ModalityConfig : IDisposable
    {
        private bool disposed = false;

        public ModalityConfig() { }
        ~ModalityConfig() { Dispose(); }

        public virtual void Dispose()
        {
            if (disposed)
                return;

            disposed = true;
        }
        public ModalityConfig Clone() => (ModalityConfig)MemberwiseClone();

        public const string MdiVersion = "v. 202309-02";

        public string OrganizationUid { get; set; } = "";
        public string ModalityUid { get; set; } = "";
        public string UrlConnection { get; set; } = "";
        public int AutoSaveSeconds { get; set; } = 0;

        public bool MdiHttpEnableTrace { get; set; } = false;
        public Encoding MdiHttpEncoding { get; set; } = DefaultValue.Encoding;

        public bool MdiSocketEnableTrace { get; set; } = false;
        public Encoding MdiSocketEncoding { get; set; } = DefaultValue.Encoding;
        public string MdiSocketIp { get; set; } = "";
        public int MdiSocketPort { get; set; } = 0;

        public TimeSpan ShutdownTime { get; set; } = TimeSpan.MinValue;

        public ModalityHnPadConfig HnPad { get; set; } = new ModalityHnPadConfig();
        public ModalityDeviceConfig Device1 { get; set; } = new ModalityDeviceConfig();
        public ModalityDeviceConfig Device2 { get; set; } = new ModalityDeviceConfig();
    }
    public class ModalityHnPadConfig : IDisposable
    {
        private bool disposed = false;

        public ModalityHnPadConfig() { }
        ~ModalityHnPadConfig() { Dispose(); }

        public virtual void Dispose()
        {
            if (disposed)
                return;


            disposed = true;
        }
        public ModalityHnPadConfig Clone() => (ModalityHnPadConfig)MemberwiseClone();

        public string CustomCharacter00 { get; set; } = "";
        public string CustomCharacter01 { get; set; } = "";
        public string CustomCharacter02 { get; set; } = "";
        public string CustomCharacter03 { get; set; } = "";
        public string CustomCharacter04 { get; set; } = "";
        public string CustomCharacter05 { get; set; } = "";
        public string CustomCharacter06 { get; set; } = "";
        public string CustomCharacter07 { get; set; } = "";
        public string CustomCharacter08 { get; set; } = "";
    }
    public class ModalityDeviceConfig : IDisposable
    {
        private bool disposed = false;

        public ModalityDeviceConfig() { }
        ~ModalityDeviceConfig() { Dispose(); }

        public virtual void Dispose()
        {
            if (disposed)
                return;

            disposed = true;
        }

        public string PortName { get; set; } = "";
        public bool IsActive { get; set; } = false;
        public string DeviceName { get; set; } = "";
        public int BaudRate { get; set; } = 9600;
        public string DataBits { get; set; } = "Eight";
        public string Parity { get; set; } = "None";
        public string StopBits { get; set; } = "One";
        public int DelayMilliseconds { get; set; } = 0;
        public bool EnableTrace { get; set; } = false;

        public bool AcceptWeight { get; set; } = true;
        public bool AcceptHeight { get; set; } = true;
        public bool AcceptBmi { get; set; } = true;
        public bool AcceptPulseRate { get; set; } = true;
        public bool AcceptBloodPressure { get; set; } = true;
        public bool AcceptSpO2 { get; set; } = true;
        public bool AcceptTemperature { get; set; } = true;
        public bool AcceptBloodGlucose { get; set; } = true;
        public bool AcceptRespirationRate { get; set; } = true;
        public bool AcceptPainScale { get; set; } = true;
    }
}