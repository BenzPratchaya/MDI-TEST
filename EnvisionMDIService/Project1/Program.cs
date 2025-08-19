using EnvisionIE.Operational;
using System;
using System.IO.Ports;
using System.Text;
using static System.Net.Mime.MediaTypeNames;

namespace Project1
{
    static class Program
    {
        static SerialPort serial_port = new SerialPort("COM3", 19200, Parity.None, 8, StopBits.One);
        [STAThread]
        static void Main()
        {
            string d= Utilities.Decrypt("t8fHrQDdgI6BNzmH1X4wTC6NRUqX34fYQ0Pb3TYARldNmjuT1Mk4AsidQR8od4jDQn6rmHxO2+OT36YnjAReTv0TtCRF+gcjtsXabLNtXi4=");
            string w = Utilities.Encrypt("Server=10.10.10.124; Port=3306; Database=mdi_pyt; Uid=root; Pwd=mira001;");
            string q = Utilities.Decrypt("Pc/MM7iwHOsaJ5O5SwnCCND6snxnKuMmOR5FrxTnRGRG/os89mo3LO3PgbBBVgy2xtbMBKLVZj8DaMkxeK8PwcIkNaUNcna43xZvlzYpJh4=");
            //int d=     Encoding.ASCII.CodePage;

            //     Encoding dd = Encoding.GetEncoding("ASCII");
            //     Encoding dd2 = Encoding.GetEncoding(1252);
            //     serial_port.Handshake = Handshake.None;
            //     serial_port.RtsEnable = true;
            //     serial_port.DtrEnable = true;
            //     serial_port.DataReceived += Serial_port_DataReceived;
            //     serial_port.Open();


            Console.Read();
        }

        private static void Serial_port_DataReceived(object sender, SerialDataReceivedEventArgs e)
        {
            string message = serial_port.ReadExisting();
        }
    }
}