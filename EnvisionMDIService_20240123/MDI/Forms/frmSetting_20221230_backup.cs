using EnvisionIE.Operational;
using EnvisionIEService.Api;
using SerialPortLib;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.IO.Ports;
using System.Windows.Forms;

namespace MDIWH.Forms
{
    public partial class frmSetting : Form
    {
        public frmSetting()
        {
            InitializeComponent();

            initClass();
        }

        private void frmSetting_Load(object sender, EventArgs e) { }
        private void frmSetting_Shown(object sender, EventArgs e) { initForm(); }

        private void initClass()
        {
            cmbSerialPort1Name.Items.Clear();

            List<ComboBoxItem> port_names = new List<ComboBoxItem>();
            port_names.Add(new ComboBoxItem() { Text = "---", Value = "" });
            foreach (string port_name in SerialPort.GetPortNames())
            {
                ComboBoxItem item = new ComboBoxItem();
                item.Text = port_name;

                string[] temp = port_name.Split('/');
                item.Value = temp.Length > 0
                    ? temp[temp.Length - 1]
                    : port_name;

                port_names.Add(item);
            }

            cmbSerialPort1Name.DisplayMember = "Text";
            cmbSerialPort1Name.ValueMember = "Value";
            cmbSerialPort1Name.DataSource = port_names.ToArray();

            cmbSerialPort2Name.DisplayMember = "Text";
            cmbSerialPort2Name.ValueMember = "Value";
            cmbSerialPort2Name.DataSource = port_names.ToArray();

            List<ComboBoxItem> device_type = new List<ComboBoxItem>();
            device_type.Add(new ComboBoxItem() { Text = "Undefined", Value = "None" });
            device_type.Add(new ComboBoxItem() { Text = "G-Tech GL-150", Value = "GTech_GL150" });
            device_type.Add(new ComboBoxItem() { Text = "G-Tech GL-310", Value = "GTech_GL310" });
            device_type.Add(new ComboBoxItem() { Text = "Omron HBP-9030", Value = "Omron_HBP9030" });

            cmbSerialPort1DeviceType.Items.Clear();
            cmbSerialPort1DeviceType.DisplayMember = "Text";
            cmbSerialPort1DeviceType.ValueMember = "Value";
            cmbSerialPort1DeviceType.DataSource = device_type.ToArray();

            cmbSerialPort2DeviceType.Items.Clear();
            cmbSerialPort2DeviceType.DisplayMember = "Text";
            cmbSerialPort2DeviceType.ValueMember = "Value";
            cmbSerialPort2DeviceType.DataSource = device_type.ToArray();

            List<ComboBoxItem> baud_rate = new List<ComboBoxItem>();
            baud_rate.Add(new ComboBoxItem() { Text = "1200", Value = "1200" });
            baud_rate.Add(new ComboBoxItem() { Text = "2400", Value = "2400" });
            baud_rate.Add(new ComboBoxItem() { Text = "4800", Value = "4800" });
            baud_rate.Add(new ComboBoxItem() { Text = "7200", Value = "7200" });
            baud_rate.Add(new ComboBoxItem() { Text = "9600", Value = "9600" });
            baud_rate.Add(new ComboBoxItem() { Text = "14400", Value = "14400" });
            baud_rate.Add(new ComboBoxItem() { Text = "19200", Value = "19200" });
            baud_rate.Add(new ComboBoxItem() { Text = "38400", Value = "38400" });
            baud_rate.Add(new ComboBoxItem() { Text = "56000", Value = "56000" });
            baud_rate.Add(new ComboBoxItem() { Text = "57600", Value = "57600" });
            baud_rate.Add(new ComboBoxItem() { Text = "115200", Value = "115200" });
            baud_rate.Add(new ComboBoxItem() { Text = "128000", Value = "128000" });
            baud_rate.Add(new ComboBoxItem() { Text = "256000", Value = "256000" });

            cmbSerialPort1BaudRate.Items.Clear();
            cmbSerialPort1BaudRate.DisplayMember = "Text";
            cmbSerialPort1BaudRate.ValueMember = "Value";
            cmbSerialPort1BaudRate.DataSource = baud_rate.ToArray();

            cmbSerialPort2BaudRate.Items.Clear();
            cmbSerialPort2BaudRate.DisplayMember = "Text";
            cmbSerialPort2BaudRate.ValueMember = "Value";
            cmbSerialPort2BaudRate.DataSource = baud_rate.ToArray();

            List<ComboBoxItem> parity = new List<ComboBoxItem>();
            parity.Add(new ComboBoxItem() { Text = "None", Value = "None" });
            parity.Add(new ComboBoxItem() { Text = "Odd", Value = "Odd" });
            parity.Add(new ComboBoxItem() { Text = "Even", Value = "Even" });
            parity.Add(new ComboBoxItem() { Text = "Mark", Value = "Mark" });
            parity.Add(new ComboBoxItem() { Text = "Space", Value = "Space" });

            cmbSerialPort1Parity.Items.Clear();
            cmbSerialPort1Parity.DisplayMember = "Text";
            cmbSerialPort1Parity.ValueMember = "Value";
            cmbSerialPort1Parity.DataSource = parity.ToArray();

            cmbSerialPort2Parity.Items.Clear();
            cmbSerialPort2Parity.DisplayMember = "Text";
            cmbSerialPort2Parity.ValueMember = "Value";
            cmbSerialPort2Parity.DataSource = parity.ToArray();

            List<ComboBoxItem> data_bits = new List<ComboBoxItem>();
            data_bits.Add(new ComboBoxItem() { Text = "5", Value = "Five" });
            data_bits.Add(new ComboBoxItem() { Text = "6", Value = "Six" });
            data_bits.Add(new ComboBoxItem() { Text = "7", Value = "Seven" });
            data_bits.Add(new ComboBoxItem() { Text = "8", Value = "Eight" });

            cmbSerialPort1DataBits.Items.Clear();
            cmbSerialPort1DataBits.DisplayMember = "Text";
            cmbSerialPort1DataBits.ValueMember = "Value";
            cmbSerialPort1DataBits.DataSource = data_bits.ToArray();

            cmbSerialPort2DataBits.Items.Clear();
            cmbSerialPort2DataBits.DisplayMember = "Text";
            cmbSerialPort2DataBits.ValueMember = "Value";
            cmbSerialPort2DataBits.DataSource = data_bits.ToArray();

            List<ComboBoxItem> stop_bits = new List<ComboBoxItem>();
            stop_bits.Add(new ComboBoxItem() { Text = "0", Value = "None" });
            stop_bits.Add(new ComboBoxItem() { Text = "1", Value = "One" });
            stop_bits.Add(new ComboBoxItem() { Text = "1.5", Value = "OnePointFive" });
            stop_bits.Add(new ComboBoxItem() { Text = "2", Value = "Two" });

            cmbSerialPort1StopBits.Items.Clear();
            cmbSerialPort1StopBits.DisplayMember = "Text";
            cmbSerialPort1StopBits.ValueMember = "Value";
            cmbSerialPort1StopBits.DataSource = stop_bits.ToArray();

            cmbSerialPort2StopBits.Items.Clear();
            cmbSerialPort2StopBits.DisplayMember = "Text";
            cmbSerialPort2StopBits.ValueMember = "Value";
            cmbSerialPort2StopBits.DataSource = stop_bits.ToArray();
        }
        private void initForm()
        {
            int milliseconds = 0;

            txtUrlConnection.Text = ServiceConfig.UrlConnection;
            txtCountdownAutoSave.Value = ServiceConfig.AutoSaveCountdownSeconds;

            cmbSerialPort1Name.SelectedValue = ServiceConfig.SerialPort1Name;
            cmbSerialPort1BaudRate.SelectedValue = ServiceConfig.SerialPort1BaudRate;
            cmbSerialPort1Parity.SelectedValue = ServiceConfig.SerialPort1Parity;
            cmbSerialPort1DataBits.SelectedValue = ServiceConfig.SerialPort1DataBits;
            cmbSerialPort1StopBits.SelectedValue = ServiceConfig.SerialPort1StopBits;
            cmbSerialPort1DeviceType.SelectedValue = ServiceConfig.SerialPort1DeviceType;
            txtSerialPort1ThreadSleep.Value = 0;

            milliseconds = ServiceConfig.SerialPort1ThreadSleepMilliseconds;

            if (milliseconds > 0)
                txtSerialPort1ThreadSleep.Value = (decimal)milliseconds / 1000;


            cmbSerialPort2Name.SelectedValue = ServiceConfig.SerialPort2Name;
            cmbSerialPort2BaudRate.SelectedValue = ServiceConfig.SerialPort2BaudRate;
            cmbSerialPort2Parity.SelectedValue = ServiceConfig.SerialPort2Parity;
            cmbSerialPort2DataBits.SelectedValue = ServiceConfig.SerialPort2DataBits;
            cmbSerialPort2StopBits.SelectedValue = ServiceConfig.SerialPort2StopBits;
            cmbSerialPort2DeviceType.SelectedValue = ServiceConfig.SerialPort2DeviceType;
            txtSerialPort2ThreadSleep.Value = 0;

            milliseconds = ServiceConfig.SerialPort2ThreadSleepMilliseconds;

            if (milliseconds > 0)
                txtSerialPort2ThreadSleep.Value = (decimal)milliseconds / 1000;
        }

        private void btnPageBack_Click(object sender, EventArgs e) => DialogResult = DialogResult.Cancel;
        private void btnWinOnScreenKeyboard_Click(object sender, EventArgs e) => WindowsCommands.OnScreenKeyboard();
        private void btnNetworkConnections_Click(object sender, EventArgs e) => WindowsCommands.NetworkConnections();

        private void txtUrlConnection_Click(object sender, EventArgs e)
        {
            int index_click = txtUrlConnection.SelectionStart;
            string url = txtUrlConnection.Text;

            if (string.IsNullOrEmpty(url))
                return;

            int index_start = url.IndexOf("//");

            if (index_start < 0)
                return;

            int index_length = url.IndexOf("/", index_start += 2);

            if (index_length < 0)
                return;

            if (index_click >= index_start && index_click <= index_length)
                txtUrlConnection.Select(index_start, index_length - index_start);
        }
        private void btnCountdownAutoSaveSetZero_Click(object sender, EventArgs e) { txtCountdownAutoSave.Value = 0; }
        private void btnCountdownAutoSavePlusFive_Click(object sender, EventArgs e)
        {
            try { txtCountdownAutoSave.Value += new decimal(5); }
            catch { txtCountdownAutoSave.Value = txtCountdownAutoSave.Maximum; }
        }
        private void btnCountdownAutoSavePlusTen_Click(object sender, EventArgs e)
        {
            try { txtCountdownAutoSave.Value += new decimal(10); }
            catch { txtCountdownAutoSave.Value = txtCountdownAutoSave.Maximum; }
        }

        private void cmbSerialPort1Name_SelectedIndexChanged(object sender, EventArgs e) { }
        private void cmbSerialPort1DeviceType_SelectedIndexChanged(object sender, EventArgs e)
        {
            switch ((cmbSerialPort1DeviceType.SelectedValue ?? "").ToString().ToLower())
            {
                default: break;
                case "gtech_gl150":
                case "gtech_gl310":
                    cmbSerialPort1BaudRate.SelectedValue = "9600";
                    cmbSerialPort1Parity.SelectedValue = "None";
                    cmbSerialPort1DataBits.SelectedValue = "Eight";
                    cmbSerialPort1StopBits.SelectedValue = "One";
                    txtSerialPort1ThreadSleep.Value = 0.5M;
                    break;
            }
        }
        private void cmbSerialPort1Parity_Validating(object sender, CancelEventArgs e)
        {
            try { Enum.Parse(typeof(Parity), cmbSerialPort1Parity.Text, true); }
            catch { cmbSerialPort1Parity.Text = ServiceConfig.SerialPort1Parity; }
        }
        private void cmbSerialPort1DataBits_Validating(object sender, CancelEventArgs e)
        {
            try { Enum.Parse(typeof(DataBits), cmbSerialPort1DataBits.SelectedValue.ToString(), true); }
            catch { cmbSerialPort1DataBits.SelectedValue = ServiceConfig.SerialPort1DataBits; }
        }
        private void cmbSerialPort1StopBits_Validating(object sender, CancelEventArgs e)
        {
            try { Enum.Parse(typeof(StopBits), cmbSerialPort1StopBits.Text, true); }
            catch { cmbSerialPort1StopBits.Text = ServiceConfig.SerialPort1StopBits; }
        }

        private void btnSerialPort1ThreadSleepSetZero_Click(object sender, EventArgs e) { txtSerialPort1ThreadSleep.Value = 0; }
        private void btnSerialPort1ThreadSleepPlusZeroPointFive_Click(object sender, EventArgs e)
        {
            try { txtSerialPort1ThreadSleep.Value += new decimal(0.5); }
            catch { txtSerialPort1ThreadSleep.Value = txtSerialPort1ThreadSleep.Maximum; }
        }
        private void btnSerialPort1ThreadSleepPlusOne_Click(object sender, EventArgs e)
        {
            try { txtSerialPort1ThreadSleep.Value += new decimal(1); }
            catch { txtSerialPort1ThreadSleep.Value = txtSerialPort1ThreadSleep.Maximum; }
        }

        private void cmbSerialPort2Name_SelectedIndexChanged(object sender, EventArgs e) { }
        private void cmbSerialPort2DeviceType_SelectedIndexChanged(object sender, EventArgs e)
        {
            switch ((cmbSerialPort2DeviceType.SelectedValue ?? "").ToString().ToLower())
            {
                default: break;
                case "gtech_gl150":
                case "gtech_gl310":
                    cmbSerialPort2BaudRate.SelectedValue = "9600";
                    cmbSerialPort2Parity.SelectedValue = "None";
                    cmbSerialPort2DataBits.SelectedValue = "Eight";
                    cmbSerialPort2StopBits.SelectedValue = "One";
                    txtSerialPort2ThreadSleep.Value = 0.5M;
                    break;
            }
        }
        private void cmbSerialPort2Parity_Validating(object sender, CancelEventArgs e)
        {
            try { Enum.Parse(typeof(Parity), cmbSerialPort2Parity.Text, true); }
            catch { cmbSerialPort2Parity.Text = ServiceConfig.SerialPort2Parity; }
        }
        private void cmbSerialPort2DataBits_Validating(object sender, CancelEventArgs e)
        {
            try { Enum.Parse(typeof(DataBits), cmbSerialPort2DataBits.SelectedValue.ToString(), true); }
            catch { cmbSerialPort2DataBits.SelectedValue = ServiceConfig.SerialPort2DataBits; }
        }
        private void cmbSerialPort2StopBits_Validating(object sender, CancelEventArgs e)
        {
            try { Enum.Parse(typeof(StopBits), cmbSerialPort2StopBits.Text, true); }
            catch { cmbSerialPort2StopBits.Text = ServiceConfig.SerialPort2StopBits; }
        }

        private void btnSerialPort2ThreadSleepSetZero_Click(object sender, EventArgs e) { txtSerialPort2ThreadSleep.Value = 0; }
        private void btnSerialPort2ThreadSleepPlusZeroPointFive_Click(object sender, EventArgs e)
        {
            try { txtSerialPort2ThreadSleep.Value += new decimal(0.5); }
            catch { txtSerialPort2ThreadSleep.Value = txtSerialPort2ThreadSleep.Maximum; }
        }
        private void btnSerialPort2ThreadSleepPlusOne_Click(object sender, EventArgs e)
        {
            try { txtSerialPort2ThreadSleep.Value += new decimal(1); }
            catch { txtSerialPort2ThreadSleep.Value = txtSerialPort2ThreadSleep.Maximum; }
        }

        private void btnSaveConfig_Click(object sender, EventArgs e)
        {
            IeServiceConfig.UrlEnvisionIeService = txtUrlConnection.Text.Trim().TrimEnd(new char[] { '/' }) + "/EnvisionIEService/";

            ServiceConfig.UrlConnection = txtUrlConnection.Text.Trim().TrimEnd(new char[] { '/' });
            ServiceConfig.AutoSaveCountdownSeconds = Utilities.ToInt(txtCountdownAutoSave.Value);

            ServiceConfig.SerialPort1Name = (cmbSerialPort1Name.SelectedValue ?? "").ToString();
            ServiceConfig.SerialPort1DeviceType = (cmbSerialPort1DeviceType.SelectedValue ?? "").ToString();
            ServiceConfig.SerialPort1BaudRate = Utilities.ToInt(cmbSerialPort1BaudRate.SelectedValue);
            ServiceConfig.SerialPort1Parity = (cmbSerialPort1Parity.SelectedValue ?? "").ToString();
            ServiceConfig.SerialPort1DataBits = (cmbSerialPort1DataBits.SelectedValue ?? "").ToString();
            ServiceConfig.SerialPort1StopBits = (cmbSerialPort1StopBits.SelectedValue ?? "").ToString();
            ServiceConfig.SerialPort1ThreadSleepMilliseconds = Utilities.ToInt(txtSerialPort1ThreadSleep.Value * 1000);

            ServiceConfig.SerialPort2Name = (cmbSerialPort2Name.SelectedValue ?? "").ToString();
            ServiceConfig.SerialPort2DeviceType = (cmbSerialPort2DeviceType.SelectedValue ?? "").ToString();
            ServiceConfig.SerialPort2BaudRate = Utilities.ToInt(cmbSerialPort2BaudRate.SelectedValue);
            ServiceConfig.SerialPort2Parity = (cmbSerialPort2Parity.SelectedValue ?? "").ToString();
            ServiceConfig.SerialPort2DataBits = (cmbSerialPort2DataBits.SelectedValue ?? "").ToString();
            ServiceConfig.SerialPort2StopBits = (cmbSerialPort2StopBits.SelectedValue ?? "").ToString();
            ServiceConfig.SerialPort2ThreadSleepMilliseconds = Utilities.ToInt(txtSerialPort2ThreadSleep.Value * 1000);

            DialogResult = DialogResult.OK;
        }
    }

    public class ComboBoxItem
    {
        public string Text { get; set; }
        public object Value { get; set; }

        public override string ToString()
        {
            return Text;
        }
    }
}