using EnvisionIE.Operational;
using MDI.Entity;
using System;
using System.Collections.Generic;
using System.IO.Ports;
using System.Windows.Forms;

namespace MDI.Forms
{
    public partial class ctrlSettingDevice : UserControl
    {
        public ModalityDeviceConfig ModalityDeviceConfig { get; set; }

        public ctrlSettingDevice()
        {
            InitializeComponent();

            initClass();
        }

        private void initClass()
        {
            ModalityDeviceConfig = new ModalityDeviceConfig();

            cmbPortName.Items.Clear();

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

            cmbPortName.DisplayMember = "Text";
            cmbPortName.ValueMember = "Value";
            cmbPortName.DataSource = port_names;

            List<ComboBoxItem> device_type = new List<ComboBoxItem>();
            device_type.Add(new ComboBoxItem() { Text = "Undefined", Value = "None" });
            device_type.Add(new ComboBoxItem() { Text = "And TM-2657P", Value = "And_TM2657P" });
            device_type.Add(new ComboBoxItem() { Text = "G-Tech GL-150", Value = "GTech_GL150" });
            device_type.Add(new ComboBoxItem() { Text = "G-Tech GL-310", Value = "GTech_GL310" });
            device_type.Add(new ComboBoxItem() { Text = "G-Tech GL-310 (F4=1)", Value = "GTech_GL310_F4=1" });
            device_type.Add(new ComboBoxItem() { Text = "G-Tech GL-310B", Value = "GTech_GL310B" });
            device_type.Add(new ComboBoxItem() { Text = "Omron HBP-9030", Value = "Omron_HBP9030" });
            device_type.Add(new ComboBoxItem() { Text = "Omron HBP-9020 (Mode 5, F3)", Value = "Omron_HBP9020_Mode5_F3" });
            device_type.Add(new ComboBoxItem() { Text = "Terumo BP-500", Value = "Terumo_BP500" });

            cmbDeviceName.Items.Clear();
            cmbDeviceName.DisplayMember = "Text";
            cmbDeviceName.ValueMember = "Value";
            cmbDeviceName.DataSource = device_type.ToArray();

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

            cmbBaudRate.Items.Clear();
            cmbBaudRate.DisplayMember = "Text";
            cmbBaudRate.ValueMember = "Value";
            cmbBaudRate.DataSource = baud_rate.ToArray();

            List<ComboBoxItem> parity = new List<ComboBoxItem>();
            parity.Add(new ComboBoxItem() { Text = "None", Value = "None" });
            parity.Add(new ComboBoxItem() { Text = "Odd", Value = "Odd" });
            parity.Add(new ComboBoxItem() { Text = "Even", Value = "Even" });
            parity.Add(new ComboBoxItem() { Text = "Mark", Value = "Mark" });
            parity.Add(new ComboBoxItem() { Text = "Space", Value = "Space" });

            cmbParity.Items.Clear();
            cmbParity.DisplayMember = "Text";
            cmbParity.ValueMember = "Value";
            cmbParity.DataSource = parity.ToArray();

            List<ComboBoxItem> data_bits = new List<ComboBoxItem>();
            data_bits.Add(new ComboBoxItem() { Text = "5", Value = "Five" });
            data_bits.Add(new ComboBoxItem() { Text = "6", Value = "Six" });
            data_bits.Add(new ComboBoxItem() { Text = "7", Value = "Seven" });
            data_bits.Add(new ComboBoxItem() { Text = "8", Value = "Eight" });

            cmbDataBits.Items.Clear();
            cmbDataBits.DisplayMember = "Text";
            cmbDataBits.ValueMember = "Value";
            cmbDataBits.DataSource = data_bits.ToArray();

            List<ComboBoxItem> stop_bits = new List<ComboBoxItem>();
            stop_bits.Add(new ComboBoxItem() { Text = "0", Value = "None" });
            stop_bits.Add(new ComboBoxItem() { Text = "1", Value = "One" });
            stop_bits.Add(new ComboBoxItem() { Text = "1.5", Value = "OnePointFive" });
            stop_bits.Add(new ComboBoxItem() { Text = "2", Value = "Two" });

            cmbStopBits.Items.Clear();
            cmbStopBits.DisplayMember = "Text";
            cmbStopBits.ValueMember = "Value";
            cmbStopBits.DataSource = stop_bits.ToArray();
        }

        public void SetValue()
        {
            cmbPortName.SelectedValue = ModalityDeviceConfig.PortName;
            chkIsActive.Checked = ModalityDeviceConfig.IsActive;

            cmbDeviceName.SelectedValue = ModalityDeviceConfig.DeviceName;
            cmbBaudRate.SelectedValue = ModalityDeviceConfig.BaudRate.ToString();
            cmbDataBits.SelectedValue = ModalityDeviceConfig.DataBits;
            cmbParity.SelectedValue = ModalityDeviceConfig.Parity;
            cmbStopBits.SelectedValue = ModalityDeviceConfig.StopBits;
            txtDelay.Value = Utilities.ToDecimal(ModalityDeviceConfig.DelayMilliseconds) / 1000;
            chkEnableTrace.Checked = ModalityDeviceConfig.EnableTrace;

            chkWeight.Checked = ModalityDeviceConfig.AcceptWeight;
            chkHeight.Checked = ModalityDeviceConfig.AcceptHeight;
            chkBmi.Checked = ModalityDeviceConfig.AcceptBmi;
            chkPulseRate.Checked = ModalityDeviceConfig.AcceptPulseRate;
            chkBloodPressure.Checked = ModalityDeviceConfig.AcceptBloodPressure;
            chkSpO2.Checked = ModalityDeviceConfig.AcceptSpO2;
            chkTemperature.Checked = ModalityDeviceConfig.AcceptTemperature;
            chkBloodGlucose.Checked = ModalityDeviceConfig.AcceptBloodGlucose;
            chkRespirationRate.Checked = ModalityDeviceConfig.AcceptRespirationRate;
            chkPainScale.Checked = ModalityDeviceConfig.AcceptPainScale;
        }
        public void GetValue()
        {
            ModalityDeviceConfig.PortName = (cmbPortName.SelectedValue ?? "").ToString();
            ModalityDeviceConfig.IsActive = chkIsActive.Checked;

            ModalityDeviceConfig.DeviceName = (cmbDeviceName.SelectedValue ?? "").ToString();
            ModalityDeviceConfig.BaudRate = Utilities.ToInt(cmbBaudRate.SelectedValue);
            ModalityDeviceConfig.DataBits = (cmbDataBits.SelectedValue ?? "").ToString();
            ModalityDeviceConfig.Parity = (cmbParity.SelectedValue ?? "").ToString();
            ModalityDeviceConfig.StopBits = (cmbStopBits.SelectedValue ?? "").ToString();
            ModalityDeviceConfig.DelayMilliseconds = Utilities.ToInt(txtDelay.Value * 1000);
            ModalityDeviceConfig.EnableTrace = chkEnableTrace.Checked;

            ModalityDeviceConfig.AcceptWeight = chkWeight.Checked;
            ModalityDeviceConfig.AcceptHeight = chkHeight.Checked;
            ModalityDeviceConfig.AcceptBmi = chkBmi.Checked;
            ModalityDeviceConfig.AcceptPulseRate = chkPulseRate.Checked;
            ModalityDeviceConfig.AcceptBloodPressure = chkBloodPressure.Checked;
            ModalityDeviceConfig.AcceptSpO2 = chkSpO2.Checked;
            ModalityDeviceConfig.AcceptTemperature = chkTemperature.Checked;
            ModalityDeviceConfig.AcceptBloodGlucose = chkBloodGlucose.Checked;
            ModalityDeviceConfig.AcceptRespirationRate = chkRespirationRate.Checked;
            ModalityDeviceConfig.AcceptPainScale = chkPainScale.Checked;
        }

        private void cmbPortName_SelectedIndexChanged(object sender, EventArgs e) { }// => ModalityDeviceConfig.PortName = (cmbPortName.SelectedValue ?? "").ToString();
        private void chkIsActive_CheckedChanged() { }// => ModalityDeviceConfig.IsActive = chkIsActive.Checked;
        private void cmbDeviceName_SelectedIndexChanged(object sender, EventArgs e)
        {
            //ModalityDeviceConfig.DeviceName = (cmbDeviceName.SelectedValue ?? "").ToString();

            cmbBaudRate.SelectedValue = "9600";
            cmbDataBits.SelectedValue = "Eight";
            cmbParity.SelectedValue = "None";
            cmbStopBits.SelectedValue = "One";
            txtDelay.Value = 0M;

            switch ((cmbDeviceName.SelectedValue ?? "").ToString().ToLower())
            {
                default: break;
                case "and_tm2657p":
                    cmbBaudRate.SelectedValue = "2400";
                    break;
                case "gtech_gl150":
                case "gtech_gl310":
                    txtDelay.Value = 0.5M;
                    break;
                case "omron_hbp9020_mode5_f3":
                    cmbBaudRate.SelectedValue = "2400";
                    break;
            }
        }
        private void cmbBaudRate_SelectedIndexChanged(object sender, EventArgs e) { }// => ModalityDeviceConfig.BaudRate = Utilities.ToInt(cmbBaudRate.SelectedValue);
        private void cmbDataBits_SelectedIndexChanged(object sender, EventArgs e) { }// => ModalityDeviceConfig.DataBits = (cmbDataBits.SelectedValue ?? "").ToString();
        private void cmbParity_SelectedIndexChanged(object sender, EventArgs e) { }// => ModalityDeviceConfig.Parity = (cmbParity.SelectedValue ?? "").ToString();
        private void cmbStopBits_SelectedIndexChanged(object sender, EventArgs e) { }// => ModalityDeviceConfig.StopBits = (cmbStopBits.SelectedValue ?? "").ToString();
        private void txtDelay_ValueChanged(object sender, EventArgs e) { }// => ModalityDeviceConfig.DelayMilliseconds = Utilities.ToInt(txtDelay.Value * 1000);
        private void btnDelaySetZero_Click(object sender, EventArgs e) => txtDelay.Value = 0;
        private void btnDelayPlusZeroPointFive_Click(object sender, EventArgs e)
        {
            try { txtDelay.Value += 0.5M; }
            catch { txtDelay.Value = txtDelay.Maximum; }
        }
        private void btnDelayPlusOne_Click(object sender, EventArgs e)
        {
            try { txtDelay.Value += 1M; }
            catch { txtDelay.Value = txtDelay.Maximum; }
        }
        private void chkEnableTrace_CheckedChanged() { }// => ModalityDeviceConfig.EnableTrace = chkEnableTrace.Checked;

        private void chkWeight_CheckedChanged() { }// => ModalityDeviceConfig.AcceptWeight = chkWeight.Checked;
        private void chkHeight_CheckedChanged() { }// => ModalityDeviceConfig.AcceptHeight = chkHeight.Checked;
        private void chkBmi_CheckedChanged() { }// => ModalityDeviceConfig.AcceptBmi = chkBmi.Checked;
        private void chkPulseRate_CheckedChanged() { }// => ModalityDeviceConfig.AcceptPulseRate = chkPulseRate.Checked;
        private void chkBloodPressureSystolic_CheckedChanged() { }// => ModalityDeviceConfig.AcceptBloodPressure = chkBloodPressure.Checked;
        private void chkSpO2_CheckedChanged() { }// => ModalityDeviceConfig.AcceptSpO2 = chkSpO2.Checked;
        private void chkTemperature_CheckedChanged() { }// => ModalityDeviceConfig.AcceptTemperature = chkTemperature.Checked;
        private void chkBloodGlucose_CheckedChanged() { }// => ModalityDeviceConfig.AcceptBloodGlucose = chkBloodGlucose.Checked;
        private void chkRespirationRate_CheckedChanged() { }// => ModalityDeviceConfig.AcceptRespirationRate = chkRespirationRate.Checked;
        private void chkPainScale_CheckedChanged() { }// => ModalityDeviceConfig.AcceptPainScale = chkPainScale.Checked;
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
