using EnvisionIE.Operational;
using SerialPortLib;
using System;
using System.IO.Ports;
using System.Linq;
using System.Text;
using System.Threading;

namespace MDI.Connection.Engine
{
    public delegate void SerialPortStatusChanged();
    public delegate void SerialPortMessageReceived();

    public class SerialPortEngine : IDisposable
    {
        private bool disposed = false;

        public event SerialPortStatusChanged StatusChanged;
        protected virtual void OnStatusChanged() { StatusChanged?.Invoke(); }

        public event SerialPortMessageReceived MessageReceived;
        protected virtual void OnMessageReceived() { MessageReceived?.Invoke(); }

        private SerialPortInput serial_port;

        public string PortName { get; set; } = "";
        public int BaudRate { get; set; } = 9600;
        public string DataBits { get; set; } = "Eight";
        public string Parity { get; set; } = "None";
        public string StopBits { get; set; } = "One";

        public int Delay { get; set; } = 0;
        public Encoding Encoding { get; set; } = Encoding.ASCII;

        public bool IsConnected { get => (serial_port == null) ? false : serial_port.IsConnected; }
        public string Data { get; set; } = "";

        public SerialPortEngine()
        {
            serial_port = new SerialPortInput();
            serial_port.ConnectionStatusChanged += SerialPort_ConnectionStatusChanged;
            serial_port.MessageReceived += SerialPort_MessageReceived;
        }
        ~SerialPortEngine() { Dispose(); }

        public void Dispose()
        {
            if (disposed)
                return;

            Command(false);

            serial_port = null;

            disposed = true;
        }

        public void Command(bool doStart)
        {
            if (serial_port.IsConnected)
            {
                try { serial_port.Disconnect(); }
                catch { }
            }

            if (doStart && !string.IsNullOrEmpty(PortName) && SerialPort.GetPortNames().Contains(PortName))
            {
                serial_port.SetPort(
                    PortName,
                    BaudRate,
                    (StopBits)Enum.Parse(typeof(StopBits), StopBits, true),
                    (Parity)Enum.Parse(typeof(Parity), Parity, true),
                    (DataBits)Enum.Parse(typeof(DataBits), DataBits, true));
                serial_port.Connect();
            }
        }
        private void SerialPort_ConnectionStatusChanged(object sender, ConnectionStatusChangedEventArgs args) => OnStatusChanged();
        private void SerialPort_MessageReceived(object sender, MessageReceivedEventArgs args)
        {
            if (Delay > 0)
                Thread.Sleep(Delay);

            Data += Utilities.ToUseCrLf(Encoding.GetString(args.Data));

            OnMessageReceived();
        }
    }
}