using EnvisionIE.Entity.Global;
using EnvisionIE.Operational;
using EnvisionIE.Operational.Miracle;
using EnvisionIEService.Api;
using EnvisionIEService.Entity;
using MDI.Connection;
using MDI.Connection.Engine;
using MDI.Entity;
using System;
using System.Collections.Generic;
using System.Data.SqlTypes;
using System.Drawing;
using System.Linq;
using System.Net;
using System.Net.Sockets;
using System.Text;
using System.Windows.Forms;

namespace MDI.Forms
{
    public partial class frmMonitoring : Form
    {
        private const string format_datetime = "yyyy-MM-dd HH:mm";
        private const string format_observation_int = "0";
        private const string format_observation_decimal = "0.00";

        delegate void WaitControlCallback();

        private void WaitDataControl()
        {
            if (InvokeRequired)
                Invoke(new WaitControlCallback(WaitDataControl));
            else
                SetDataToControl();
        }
        private void SetDataToControl()
        {
            obsWeight.ObservationText = Utilities.ToDecimal(device_data.Weight).ToString(format_observation_decimal);
            obsHeight.ObservationText = Utilities.ToDecimal(device_data.Height).ToString(format_observation_decimal);
            obsBmi.ObservationText = Utilities.ToDecimal(device_data.Bmi).ToString(format_observation_decimal);
            obsPainScale.ObservationText = Utilities.ToInt(device_data.PainScale).ToString(format_observation_int);

            obsPulseRate.ObservationText = Utilities.ToInt(device_data.PulseRate).ToString(format_observation_int);
            obsBloodPressureSystolic.ObservationText = Utilities.ToInt(device_data.BloodPressureSystolic).ToString(format_observation_int);
            obsBloodPressureDiastolic.ObservationText = Utilities.ToInt(device_data.BloodPressureDiastolic).ToString(format_observation_int);
            obsBloodPressureMean.ObservationText = Utilities.ToInt(device_data.BloodPressureMean).ToString(format_observation_int);
            obsSpO2.ObservationText = Utilities.ToDecimal(device_data.SpO2).ToString(format_observation_decimal);
            obsTemperature.ObservationText = Utilities.ToDecimal(device_data.Temperature).ToString(format_observation_decimal);
            obsBloodGlucose.ObservationText = Utilities.ToInt(device_data.BloodGlucose).ToString(format_observation_int);
            obsRespirationRate.ObservationText = Utilities.ToInt(device_data.RespirationRate).ToString(format_observation_int);
        }

        //delegate void SetTextCallback(DeviceData deviceData);

        //private void SetText(DeviceData deviceData)
        //{
        //    if (obsWeight.InvokeRequired)
        //        Invoke(new SetTextCallback(SetText), new object[] { deviceData });
        //    else
        //        obsWeight.ObservationText = Utilities.ToDecimal(deviceData.PatientWeight).ToString(format_observation_decimal);

        //    if (obsHeight.InvokeRequired)
        //        Invoke(new SetTextCallback(SetText), new object[] { deviceData });
        //    else
        //        obsHeight.ObservationText = Utilities.ToDecimal(deviceData.PatientHeight).ToString(format_observation_decimal);

        //    if (obsBmi.InvokeRequired)
        //        Invoke(new SetTextCallback(SetText), new object[] { deviceData });
        //    else
        //        obsBmi.ObservationText = Utilities.ToDecimal(deviceData.PatientBmi).ToString(format_observation_decimal);
        //}

        private MdiHttpConnection mdi_http;
        private MdiSocketConnection mdi_socket = new MdiSocketConnection();

        private SerialPortEngine serial_port_1 = new SerialPortEngine();
        private SerialPortEngine serial_port_2 = new SerialPortEngine();
        private List<DeviceData> device_data_log = new List<DeviceData>();
        private DeviceData device_data = new DeviceData();

        private Timer timerAutoSave;
        private Timer timerClock;

        private int countdown_auto_save;
        private bool allow_auto_shutdown = false;

        public frmMonitoring() { InitializeComponent(); }

        private void frmMain_Load(object sender, EventArgs e)
        {
            initClass();
            WaitStart();
        }
        private void frmMain_Shown(object sender, EventArgs e)
        {
            initForm();
            initSetting();
            WaitEnd();
        }
        private void frmMain_FormClosed(object sender, FormClosedEventArgs e)
        {
            serial_port_1.Command(false);
            serial_port_2.Command(false);
        }

        private void initClass()
        {
            lblVersion.Text = Env.MdiVersion;
            lblDatetime.Text = DateTime.Now.ToString(format_datetime);

            timerAutoSave = new Timer();
            timerAutoSave.Interval = 1000;
            timerAutoSave.Tick += timerAutoSave_Tick;

            timerClock = new Timer();
            timerClock.Interval = 10000;
            timerClock.Tick += timerClock_Tick;
            timerClock.Start();

            Clear();
        }
        private void initForm()
        {
            btnSave.Enabled = true;
            btnClearOrStopAutoSave.Text = "CLEAR";

            serial_port_1.StatusChanged += SerialPort1_StatusChanged;
            serial_port_1.MessageReceived += SerialPort1_MessageReceived;

            serial_port_2.StatusChanged += SerialPort2_StatusChanged;
            serial_port_2.MessageReceived += SerialPort2_MessageReceived;

            if (string.IsNullOrEmpty(ServiceConfig.ModalityConfig.ModalityUid))
            {
                using (frmSetting frm = new frmSetting(ServiceConfig.ModalityConfig))
                    frm.ShowDialog();
            }
        }

        private void initSetting()
        {
            WaitStart();

            serial_port_1.PortName = ServiceConfig.ModalityConfig.Device1.IsActive ? ServiceConfig.ModalityConfig.Device1.PortName : "";
            serial_port_1.BaudRate = ServiceConfig.ModalityConfig.Device1.BaudRate;
            serial_port_1.DataBits = ServiceConfig.ModalityConfig.Device1.DataBits;
            serial_port_1.Parity = ServiceConfig.ModalityConfig.Device1.Parity;
            serial_port_1.StopBits = ServiceConfig.ModalityConfig.Device1.StopBits;
            serial_port_1.Delay = ServiceConfig.ModalityConfig.Device1.DelayMilliseconds;
            serial_port_1.Command(true);

            btnSerialPort1Command.Visible = serial_port_1.PortName != "";

            serial_port_2.PortName = ServiceConfig.ModalityConfig.Device2.IsActive ? ServiceConfig.ModalityConfig.Device2.PortName : "";
            serial_port_2.BaudRate = ServiceConfig.ModalityConfig.Device2.BaudRate;
            serial_port_2.DataBits = ServiceConfig.ModalityConfig.Device2.DataBits;
            serial_port_2.Parity = ServiceConfig.ModalityConfig.Device2.Parity;
            serial_port_2.StopBits = ServiceConfig.ModalityConfig.Device2.StopBits;
            serial_port_2.Delay = ServiceConfig.ModalityConfig.Device2.DelayMilliseconds;
            serial_port_2.Command(true);

            btnSerialPort2Command.Visible = serial_port_2.PortName != "";

            mdi_http = new MdiHttpConnection(ServiceConfig.ModalityConfig.UrlConnection, ServiceConfig.ModalityConfig.MdiHttpEncoding, ServiceConfig.ModalityConfig.MdiHttpEnableTrace);
            //mdi_http.Patient_SelectByHn("", ServiceConfig.ModalityConfig.ModalityUid);

            lblDeviceInfo.Text = ServiceConfig.ModalityConfig.ModalityUid;

            try
            {
                List<string> ip_address_list = new List<string>();

                IPHostEntry entry = Dns.GetHostEntry(Dns.GetHostName());
                foreach (IPAddress ip in entry.AddressList)
                {
                    if (ip.AddressFamily == AddressFamily.InterNetwork)
                        ip_address_list.Add(ip.ToString());
                }

                lblDeviceInfo.Text += " [" + string.Join(", ", ip_address_list.ToArray()) + "]";
            }
            catch { }

            lblDeviceInfo.Text = lblDeviceInfo.Text.Trim();

            WaitEnd();
        }

        private void SetDataToHistory()
        {
            while (flowHistory.Controls.Count > 0)
                flowHistory.Controls.RemoveAt(0);

            for (int i = 0; i < device_data_log.Count; i++)
            {
                Button button = new Button();
                button.Margin = new Padding(0, 1, 0, 1);
                button.FlatStyle = FlatStyle.Popup;
                button.Font = new Font("Microsoft Sans Serif", 10F, FontStyle.Bold, GraphicsUnit.Point, ((byte)(222)));
                button.Image = device_data_log[i].AcknowledgementCode == "AA" ? Properties.Resources.circle_green_16 : Properties.Resources.circle_red_16;
                button.ImageAlign = ContentAlignment.TopRight;
                button.Name = $"btnHistory_{device_data_log[i].MessageControlId}";
                button.Text = $@"Created Date-Time : {device_data_log[i].CreatedOn.ToString(format_datetime)} HN : {device_data_log[i].Hn} VN : {device_data_log[i].VisitNo}
ACK : {device_data_log[i].TextMessage}
W : {device_data_log[i].Weight} H : {device_data_log[i].Height}
NIBP : {device_data_log[i].BloodPressureSystolic}/{device_data_log[i].BloodPressureDiastolic}({device_data_log[i].BloodPressureMean}), SpO2 : {device_data_log[i].SpO2}";
                button.TextAlign = ContentAlignment.TopLeft;
                button.Size = new Size(flowHistory.Width - 20, 96);
                button.Click += flowHistoryButton_Click;

                flowHistory.Controls.Add(button);
            }
        }

        private void Clear()
        {
            timerAutoSave.Stop();

            device_data = new DeviceData();

            txtHn.Text = "";

            lblPatientInfo.Text = "";
            lblNotifySave.Text = "";

            SetDataToControl();
            CheckValidData(false);
        }

        private void CheckValidData(bool autoSave)
        {
            TimeAutoSaveStop();

            if (serial_port_1.IsConnected || serial_port_2.IsConnected)
            {
                bool flag = true;

                if (serial_port_1.IsConnected)
                {
                    if (!device_data.IsActiveDevice1)
                        flag = false;
                }

                if (serial_port_2.IsConnected)
                {
                    if (!device_data.IsActiveDevice2)
                        flag = false;
                }

                if (flag && device_data.IsActivePatient)
                {
                    if (autoSave)
                        TimeAutoSaveStart();
                }
            }
        }

        private void SelectPatientByHn()
        {
            WaitStart();

            string hn = txtHn.Text.Trim();

            txtHn.Text = hn;

            if (string.IsNullOrEmpty(hn))
            {
                device_data.IsActivePatient = false;
                device_data.Hn = "";
                device_data.VisitNo = "";

                lblPatientInfo.Text = "";
            }
            else
            {
                device_data.IsActivePatient = true;

                try
                {
                    MiJsonObjectList json_obj_request = new MiJsonObjectList(mdi_http.Patient_SelectByHn(hn, ServiceConfig.ModalityConfig.ModalityUid));
                    MiJsonObjectMultiList json_objs_patient = new MiJsonObjectMultiList(json_obj_request["Patient_1"]);
                    MiJsonObjectList json_obj_patient = json_objs_patient[0];

                    if (mdi_http.Ack.AcknowledgementCode != "AA")
                    {
                        device_data.Hn = hn;
                        device_data.VisitNo = "";

                        lblPatientInfo.Text = mdi_http.Ack.TextMessage;
                    }
                    else if (json_objs_patient.Count == 0)
                    {
                        device_data.Hn = hn;
                        device_data.VisitNo = "";

                        lblPatientInfo.Text = $"Hn '{hn}' not found";
                    }
                    else
                    {
                        device_data.Hn = json_obj_patient["Hn"].ToString();
                        device_data.VisitNo = json_obj_patient["VisitNo"].ToString();

                        string age_text = "";
                        DateTime patient_dob = Utilities.ToDateTime(json_obj_patient["PatientDob"]);
                        if (patient_dob != DateTime.MinValue)
                        {
                            object[] age = Utilities.CalculateAge(patient_dob);
                            if (age[0] != null) age_text = $"{age[0]}Y";
                            else if (age[1] != null) age_text = $"{age[1]}M";
                            else if (age[2] != null) age_text = $"{age[2]}D";
                        }

                        lblPatientInfo.Text = $@"Visit No : {device_data.VisitNo}
Patient Name : {string.Join(" ", json_obj_patient["PatientTitle"].ToString(), json_obj_patient["PatientFName"].ToString(), json_obj_patient["PatientMName"].ToString(), json_obj_patient["PatientLName"].ToString())}
Age : {age_text}".Trim();
                    }
                }
                catch (Exception ex)
                {
                    device_data.Hn = hn;
                    device_data.VisitNo = "";

                    lblPatientInfo.Text = ex.Message;
                }
            }

            WaitEnd();
            CheckValidData(true);
        }
        private void SaveData()
        {
            if (!device_data.IsActivePatient)
                return;

            WaitStart();

            Ack ack = null;

            if (string.IsNullOrEmpty(ServiceConfig.ModalityConfig.MdiSocketIp))
            {
                mdi_http.Service_GetMessage(device_data);

                ack = mdi_http.Ack;
            }
            else
            {
                mdi_socket.Send(device_data);

                ack = mdi_socket.Ack;
            }

            device_data.AcknowledgementCode = ack.AcknowledgementCode;
            device_data.TextMessage = ack.TextMessage;

            device_data_log.RemoveAll(x => x.MessageControlId == device_data.MessageControlId);
            device_data_log.Add(device_data);

            device_data_log.OrderByDescending(x => x.CreatedOn);

            for (int i = 10; i < device_data_log.Count; i++)
                device_data_log.RemoveAt(i);

            SetDataToHistory();
            Clear();
            WaitEnd();
        }

        private void WaitStart()
        {
            Enabled = false;
            pnlWaiting.Visible = true;

            Application.DoEvents();
        }
        private void WaitEnd()
        {
            Enabled = true;
            pnlWaiting.Visible = false;
        }
        private void TimeAutoSaveStart()
        {
            if (timerAutoSave.Enabled)
                return;

            if (ServiceConfig.ModalityConfig.AutoSaveSeconds < 1)
                return;

            countdown_auto_save = ServiceConfig.ModalityConfig.AutoSaveSeconds + 1;

            lblNotifySave.Text = "";

            btnClearOrStopAutoSave.Text = "STOP";

            timerAutoSave.Start();
        }
        private void TimeAutoSaveStop()
        {
            lblNotifySave.Text = "";

            btnClearOrStopAutoSave.Text = "CLEAR";

            timerAutoSave.Stop();
        }

        private void timerAutoSave_Tick(object sender, EventArgs e)
        {
            countdown_auto_save = countdown_auto_save - 1;

            lblNotifySave.Text = $"Auto save in {countdown_auto_save} sec.";

            Application.DoEvents();

            if (countdown_auto_save == 0)
            {
                TimeAutoSaveStop();

                SaveData();
            }
        }
        private void timerClock_Tick(object sender, EventArgs e)
        {
            lblDatetime.Text = DateTime.Now.ToString(format_datetime);

            if (ServiceConfig.ModalityConfig.ShutdownTime == TimeSpan.MinValue)
                return;

            long tick_shutdown = ServiceConfig.ModalityConfig.ShutdownTime.Ticks;

            if (tick_shutdown > DateTime.Now.TimeOfDay.Ticks && tick_shutdown < DateTime.Now.AddMinutes(3).TimeOfDay.Ticks)
            {
                if (allow_auto_shutdown)
                {
                    allow_auto_shutdown = false;

                    WindowsCommands.Shutdown();
                }
            }
            else
                allow_auto_shutdown = true;
        }

        private void btnSearch_Click(object sender, EventArgs e) => SelectPatientByHn();

        private void btnSave_Click(object sender, EventArgs e) => SaveData();
        private void btnClearOrStopAutoSave_Click(object sender, EventArgs e)
        {
            switch (btnClearOrStopAutoSave.Text.ToLower())
            {
                case "stop": TimeAutoSaveStop(); break;
                default: Clear(); break;
            }
        }

        private void flowHistoryButton_Click(object sender, EventArgs e)
        {
            Button button = (Button)sender;

            Clear();

            device_data = device_data_log.FirstOrDefault(x => x.MessageControlId == button.Name.Replace("btnHistory_", ""));

            if (device_data == null)
                return;

            txtHn.Text = device_data.Hn;

            SelectPatientByHn();
            WaitDataControl();

            //obsWeight.ObservationText = Utilities.ToDecimal(device_data.Weight).ToString(format_observation_decimal);
            //obsHeight.ObservationText = Utilities.ToDecimal(device_data.Height).ToString(format_observation_decimal);
            //obsBmi.ObservationText = Utilities.ToDecimal(device_data.Bmi).ToString(format_observation_decimal);
            //obsPainScale.ObservationText = Utilities.ToInt(device_data.PainScale).ToString(format_observation_int);

            //obsPulseRate.ObservationText = Utilities.ToInt(device_data.PulseRate).ToString(format_observation_int);
            //obsBloodPressureSystolic.ObservationText = Utilities.ToInt(device_data.BloodPressureSystolic).ToString(format_observation_int);
            //obsBloodPressureDiastolic.ObservationText = Utilities.ToInt(device_data.BloodPressureDiastolic).ToString(format_observation_int);
            //obsBloodPressureMean.ObservationText = Utilities.ToInt(device_data.BloodPressureMean).ToString(format_observation_int);
            //obsSpO2.ObservationText = Utilities.ToDecimal(device_data.SpO2).ToString(format_observation_decimal);
            //obsTemperature.ObservationText = Utilities.ToDecimal(device_data.Temperature).ToString(format_observation_decimal);
            //obsBloodGlucose.ObservationText = Utilities.ToInt(device_data.BloodGlucose).ToString(format_observation_int);
            //obsRespirationRate.ObservationText = Utilities.ToInt(device_data.RespirationRate).ToString(format_observation_int);

            CheckValidData(false);
        }

        private void btnClose_Click(object sender, EventArgs e) => Application.Exit();
        private void btnSetting_Click(object sender, EventArgs e)
        {
            using (frmSetting frm = new frmSetting(ServiceConfig.ModalityConfig))
            {
                if (frm.ShowDialog() == DialogResult.OK)
                    initSetting();
            }
        }

        private void ShowDialogHnPad(object sender, EventArgs e)
        {
            using (diagHnPad diag = new diagHnPad())
            {
                diag.Hn = txtHn.Text;

                if (diag.ShowDialog() == DialogResult.OK)
                {
                    txtHn.Text = diag.Hn;

                    SelectPatientByHn();
                }
            }
        }

        #region SerialPort
        /*
        private void SerialPort1Command(bool doStart)
        {
            if (serial_port_1.IsConnected)
                serial_port_1.Disconnect();

            if (doStart)
            {
                List<string> port_names = new List<string>(SerialPort.GetPortNames());

                if (port_names.Count == 0)
                    return;

                serial_port_1_name = port_names.FirstOrDefault<string>(x => x == ServiceConfig.SerialPort1Name);

                if (string.IsNullOrEmpty(serial_port_1_name))
                    return;

                serial_port_1.SetPort(
                    serial_port_1_name,
                    ServiceConfig.SerialPort1BaudRate,
                    (StopBits)Enum.Parse(typeof(StopBits), ServiceConfig.SerialPort1StopBits, true),
                    (Parity)Enum.Parse(typeof(Parity), ServiceConfig.SerialPort1Parity, true),
                    (DataBits)Enum.Parse(typeof(DataBits), ServiceConfig.SerialPort1DataBits, true));
                serial_port_1.Connect();
            }
        }
        private void SerialPort2Command(bool doStart)
        {
            if (serial_port_2.IsConnected)
                serial_port_2.Disconnect();

            if (doStart)
            {
                List<string> port_names = new List<string>(SerialPort.GetPortNames());

                if (port_names.Count == 0)
                    return;

                serial_port_2_name = port_names.FirstOrDefault<string>(x => x == ServiceConfig.SerialPort2Name);

                if (string.IsNullOrEmpty(serial_port_2_name))
                    return;

                serial_port_2.SetPort(
                    serial_port_2_name,
                    ServiceConfig.SerialPort2BaudRate,
                    (StopBits)Enum.Parse(typeof(StopBits), ServiceConfig.SerialPort2StopBits, true),
                    (Parity)Enum.Parse(typeof(Parity), ServiceConfig.SerialPort2Parity, true),
                    (DataBits)Enum.Parse(typeof(DataBits), ServiceConfig.SerialPort2DataBits, true));
                serial_port_2.Connect();
            }
        }
        */

        private void btnSerialPort1Command_Click(object sender, EventArgs e) => serial_port_1.Command(btnSerialPort1Command.Text.ToUpper().EndsWith(" STOPED"));
        private void btnSerialPort2Command_Click(object sender, EventArgs e) => serial_port_2.Command(btnSerialPort2Command.Text.ToUpper().EndsWith(" STOPED"));

        /*
        private void SerialPort1_ConnectionStatusChanged(object sender, ConnectionStatusChangedEventArgs args)
        {
            if (args.Connected)
            {
                btnSerialPort1Command.BackgroundImage = Properties.Resources.service_stop_64;
                btnSerialPort1Command.Image = Properties.Resources.circle_green_16;
                btnSerialPort1Command.Text = $"{serial_port_1_name} STARTED".Trim();
            }
            else
            {
                btnSerialPort1Command.BackgroundImage = Properties.Resources.service_start_64;
                btnSerialPort1Command.Image = Properties.Resources.circle_red_16;
                btnSerialPort1Command.Text = $"{serial_port_1_name} STOPED".Trim();
            }
        }
        private void SerialPort1_MessageReceived(object sender, MessageReceivedEventArgs args)
        {
            if (ServiceConfig.SerialPort1ThreadSleepMilliseconds > 0)
                System.Threading.Thread.Sleep(ServiceConfig.SerialPort1ThreadSleepMilliseconds);

            string message = Utilities.ToUseCrLf(ServiceConfig.SerialPort1Encoding.GetString(args.Data));

            if (string.IsNullOrEmpty(message))
                return;

            if (ServiceConfig.SerialPort1EnableTrace)
            {
                IeServiceLog.Save(new IeLog()
                {
                    OwnerName = $"{IeServiceConfig.ServiceName}_{ServiceConfig.ModalityUid}",
                    ThirdPartyName = "SerialPort",

                    Connection = $"{ServiceConfig.SerialPort1Name}",

                    EventName = "MessageReceived",
                    EventData = message
                });
            }

            switch (ServiceConfig.SerialPort1DeviceType.ToLower())
            {
                case "gtech_gl150":
                    serial_port_1_keep_message += message;

                    if (serial_port_1_keep_message.Contains('\u0002') && serial_port_1_keep_message.Contains('\u0003'))
                    {
                        using (MiStringArray mi_values = new MiStringArray(serial_port_1_keep_message.Replace('\u0002', ' ').Replace('\u0003', ' ').Trim().Split(',')))
                        {
                            device_data.IsActiveDevice1 = true;
                            device_data.Height = Utilities.ToDecimal(mi_values[1]);
                            device_data.HeightUnit = "cm";
                            device_data.Weight = Utilities.ToDecimal(mi_values[2]);
                            device_data.WeightUnit = "kg";
                            device_data.Bmi = Utilities.ToDecimal(mi_values[3]);
                        }

                        serial_port_1_keep_message = "";
                    }
                    else
                        return;
                    break;
                case "gtech_gl310":
                    serial_port_1_keep_message += message;

                    if (serial_port_1_keep_message.Contains('\u0002') && serial_port_1_keep_message.Contains('\u0003'))
                    {
                        using (MiStringArray mi_values = new MiStringArray(serial_port_1_keep_message.Replace('\u0002', ' ').Replace('\u0003', ' ').Trim().Split(',')))
                        {
                            device_data.IsActiveDevice1 = true;
                            device_data.Height = Utilities.ToDecimal(mi_values[0]);
                            device_data.HeightUnit = "cm";
                            device_data.Weight = Utilities.ToDecimal(mi_values[1]);
                            device_data.WeightUnit = "kg";
                            device_data.Bmi = Utilities.ToDecimal(mi_values[4]);
                        }

                        serial_port_1_keep_message = "";
                    }
                    else
                        return;
                    break;
                case "omron_hbp9030":
                    serial_port_1_keep_message += message;

                    if (serial_port_1_keep_message.Contains('\u0013') && serial_port_1_keep_message.Contains('\u0010'))
                    {
                        using (MiStringArray mi_values = new MiStringArray(serial_port_1_keep_message.Replace('\u0013', ' ').Replace('\u0010', ' ').Trim().Split(',')))
                        {
                            device_data.IsActiveDevice2 = true;
                            device_data.BloodPressureSystolic = Utilities.ToInt(mi_values[7]);
                            device_data.BloodPressureDiastolic = Utilities.ToInt(mi_values[8]);
                            device_data.BloodPressureMean = (device_data.BloodPressureSystolic + (2 * device_data.BloodPressureDiastolic)) / 3;
                            device_data.BloodPressureUnit = "mmHg";
                            device_data.PulseRate = Utilities.ToInt(mi_values[9]);
                        }

                        serial_port_1_keep_message = "";
                    }
                    else
                        return;
                    break;
                default:
                    return;
            }

            WaitControl();
        }

        private void SerialPort2_ConnectionStatusChanged(object sender, ConnectionStatusChangedEventArgs args)
        {
            if (args.Connected)
            {
                btnSerialPort2Command.BackgroundImage = Properties.Resources.service_stop_64;
                btnSerialPort2Command.Image = Properties.Resources.circle_green_16;
                btnSerialPort2Command.Text = $"{serial_port_2_name} STARTED".Trim();
            }
            else
            {
                btnSerialPort2Command.BackgroundImage = Properties.Resources.service_start_64;
                btnSerialPort2Command.Image = Properties.Resources.circle_red_16;
                btnSerialPort2Command.Text = $"{serial_port_2_name} STOPED".Trim();
            }
        }
        private void SerialPort2_MessageReceived(object sender, MessageReceivedEventArgs args)
        {
            if (ServiceConfig.SerialPort2ThreadSleepMilliseconds > 0)
                System.Threading.Thread.Sleep(ServiceConfig.SerialPort2ThreadSleepMilliseconds);

            string message = Utilities.ToUseCrLf(ServiceConfig.SerialPort2Encoding.GetString(args.Data));

            if (string.IsNullOrEmpty(message))
                return;

            if (ServiceConfig.SerialPort2EnableTrace)
            {
                IeServiceLog.Save(new IeLog()
                {
                    OwnerName = $"{IeServiceConfig.ServiceName}_{ServiceConfig.ModalityUid}",
                    ThirdPartyName = "SerialPort",

                    Connection = $"{ServiceConfig.SerialPort2Name}",

                    EventName = "MessageReceived",
                    EventData = message
                });
            }

            switch (ServiceConfig.SerialPort2DeviceType.ToLower())
            {
                case "gtech_gl150":
                    serial_port_2_keep_message += message;

                    if (serial_port_2_keep_message.Contains('\u0002') && serial_port_2_keep_message.Contains('\u0003'))
                    {
                        using (MiStringArray mi_values = new MiStringArray(serial_port_2_keep_message.Replace('\u0002', ' ').Replace('\u0003', ' ').Trim().Split(',')))
                        {
                            device_data.IsActiveDevice2 = true;
                            device_data.Height = Utilities.ToDecimal(mi_values[1]);
                            device_data.HeightUnit = "cm";
                            device_data.Weight = Utilities.ToDecimal(mi_values[2]);
                            device_data.WeightUnit = "kg";
                            device_data.Bmi = Utilities.ToDecimal(mi_values[3]);
                        }

                        serial_port_2_keep_message = "";
                    }
                    else
                        return;
                    break;
                case "gtech_gl310":
                    serial_port_2_keep_message += message;

                    if (serial_port_2_keep_message.Contains('\u0002') && serial_port_2_keep_message.Contains('\u0003'))
                    {
                        using (MiStringArray mi_values = new MiStringArray(serial_port_2_keep_message.Replace('\u0002', ' ').Replace('\u0003', ' ').Trim().Split(',')))
                        {
                            device_data.IsActiveDevice2 = true;
                            device_data.Height = Utilities.ToDecimal(mi_values[0]);
                            device_data.HeightUnit = "cm";
                            device_data.Weight = Utilities.ToDecimal(mi_values[1]);
                            device_data.WeightUnit = "kg";
                            device_data.Bmi = Utilities.ToDecimal(mi_values[4]);
                        }

                        serial_port_2_keep_message = "";
                    }
                    else
                        return;
                    break;
                case "omron_hbp9030":
                    serial_port_2_keep_message += message;

                    if (serial_port_2_keep_message.Contains('\u0013') && serial_port_2_keep_message.Contains('\u0010'))
                    {
                        using (MiStringArray mi_values = new MiStringArray(serial_port_2_keep_message.Replace('\u0013', ' ').Replace('\u0010', ' ').Trim().Split(',')))
                        {
                            device_data.IsActiveDevice2 = true;
                            device_data.BloodPressureSystolic = Utilities.ToInt(mi_values[7]);
                            device_data.BloodPressureDiastolic = Utilities.ToInt(mi_values[8]);
                            device_data.BloodPressureMean = (device_data.BloodPressureSystolic + (2 * device_data.BloodPressureDiastolic)) / 3;
                            device_data.BloodPressureUnit = "mmHg";
                            device_data.PulseRate = Utilities.ToInt(mi_values[9]);
                        }

                        serial_port_2_keep_message = "";
                    }
                    else
                        return;
                    break;
                default:
                    return;
            }

            WaitControl();
        }
        */

        private void SerialPort1_StatusChanged()
        {
            if (serial_port_1.IsConnected)
            {
                btnSerialPort1Command.BackgroundImage = Properties.Resources.service_stop_64;
                btnSerialPort1Command.Image = Properties.Resources.circle_green_16;
                btnSerialPort1Command.Text = $"{serial_port_1.PortName} STARTED".Trim();
            }
            else
            {
                btnSerialPort1Command.BackgroundImage = Properties.Resources.service_start_64;
                btnSerialPort1Command.Image = Properties.Resources.circle_red_16;
                btnSerialPort1Command.Text = $"{serial_port_1.PortName} STOPED".Trim();
            }
        }
        private void SerialPort1_MessageReceived()
        {
            if (SerialPortMessageReceived(ServiceConfig.ModalityConfig.Device1, serial_port_1.Data))
            {
                device_data.IsActiveDevice1 = true;

                serial_port_1.Data = "";

                CheckValidData(true);
            }
            /*
            if (string.IsNullOrEmpty(serial_port_1.Data))
                return;

            if (ServiceConfig.ModalityConfig.Device1.EnableTrace)
            {
                IeServiceLog.Save(new IeLog()
                {
                    OwnerName = $"{IeServiceConfig.ServiceName}_{ServiceConfig.ModalityConfig.ModalityUid}",
                    ThirdPartyName = "SerialPort",

                    Connection = $"{ServiceConfig.ModalityConfig.Device1.PortName}",

                    EventName = "MessageReceived",
                    EventData = serial_port_1.Data
                });
            }

            switch (ServiceConfig.ModalityConfig.Device1.DeviceName.ToLower())
            {
                case "gtech_gl150":
                    if (serial_port_1.Data.Contains('\u0002') && serial_port_1.Data.Contains('\u0003'))
                    {
                        using (MiStringArray mi_values = new MiStringArray(serial_port_1.Data.Replace('\u0002', ' ').Replace('\u0003', ' ').Trim().Split(',')))
                        {
                            device_data.IsActiveDevice1 = true;
                            device_data.Height = Utilities.ToDecimal(mi_values[1]);
                            device_data.HeightUnit = "cm";
                            device_data.Weight = Utilities.ToDecimal(mi_values[2]);
                            device_data.WeightUnit = "kg";
                            device_data.Bmi = Utilities.ToDecimal(mi_values[3]);
                        }

                        serial_port_1.Data = "";
                    }
                    else
                        return;
                    break;
                case "gtech_gl310":
                    if (serial_port_1.Data.Contains('\u0002') && serial_port_1.Data.Contains('\u0003'))
                    {
                        using (MiStringArray mi_values = new MiStringArray(serial_port_1.Data.Replace('\u0002', ' ').Replace('\u0003', ' ').Trim().Split(',')))
                        {
                            device_data.IsActiveDevice1 = true;
                            device_data.Height = Utilities.ToDecimal(mi_values[0]);
                            device_data.HeightUnit = "cm";
                            device_data.Weight = Utilities.ToDecimal(mi_values[1]);
                            device_data.WeightUnit = "kg";
                            device_data.Bmi = Utilities.ToDecimal(mi_values[4]);
                        }

                        serial_port_1.Data = "";
                    }
                    else
                        return;
                    break;
                case "omron_hbp9030":
                    if (serial_port_1.Data.Contains('\u0013') && serial_port_1.Data.Contains('\u0010'))
                    {
                        using (MiStringArray mi_values = new MiStringArray(serial_port_1.Data.Replace('\u0013', ' ').Replace('\u0010', ' ').Trim().Split(',')))
                        {
                            device_data.IsActiveDevice2 = true;
                            device_data.BloodPressureSystolic = Utilities.ToInt(mi_values[7]);
                            device_data.BloodPressureDiastolic = Utilities.ToInt(mi_values[8]);
                            device_data.BloodPressureMean = (device_data.BloodPressureSystolic + (2 * device_data.BloodPressureDiastolic)) / 3;
                            device_data.BloodPressureUnit = "mmHg";
                            device_data.PulseRate = Utilities.ToInt(mi_values[9]);
                        }

                        serial_port_1.Data = "";
                    }
                    else
                        return;
                    break;
                default:
                    serial_port_1.Data = "";
                    return;
            }

            WaitControl();
            */
        }
        private void SerialPort2_StatusChanged()
        {
            if (serial_port_2.IsConnected)
            {
                btnSerialPort2Command.BackgroundImage = Properties.Resources.service_stop_64;
                btnSerialPort2Command.Image = Properties.Resources.circle_green_16;
                btnSerialPort2Command.Text = $"{serial_port_2.PortName} STARTED".Trim();
            }
            else
            {
                btnSerialPort2Command.BackgroundImage = Properties.Resources.service_start_64;
                btnSerialPort2Command.Image = Properties.Resources.circle_red_16;
                btnSerialPort2Command.Text = $"{serial_port_2.PortName} STOPED".Trim();
            }
        }
        private void SerialPort2_MessageReceived()
        {
            if (SerialPortMessageReceived(ServiceConfig.ModalityConfig.Device2, serial_port_2.Data))
            {
                device_data.IsActiveDevice2 = true;

                serial_port_2.Data = "";

                CheckValidData(true);
            }
            /*
            if (string.IsNullOrEmpty(serial_port_2.Data))
                return;

            if (ServiceConfig.ModalityConfig.Device2.EnableTrace)
            {
                IeServiceLog.Save(new IeLog()
                {
                    OwnerName = $"{IeServiceConfig.ServiceName}_{ServiceConfig.ModalityConfig.ModalityUid}",
                    ThirdPartyName = "SerialPort",

                    Connection = $"{ServiceConfig.ModalityConfig.Device2.PortName}",

                    EventName = "MessageReceived",
                    EventData = serial_port_2.Data
                });
            }

            switch (ServiceConfig.ModalityConfig.Device2.DeviceName.ToLower())
            {
                case "gtech_gl150":
                    if (serial_port_2.Data.Contains('\u0002') && serial_port_2.Data.Contains('\u0003'))
                    {
                        using (MiStringArray mi_values = new MiStringArray(serial_port_2.Data.Replace('\u0002', ' ').Replace('\u0003', ' ').Trim().Split(',')))
                        {
                            device_data.IsActiveDevice2 = true;
                            device_data.Height = Utilities.ToDecimal(mi_values[1]);
                            device_data.HeightUnit = "cm";
                            device_data.Weight = Utilities.ToDecimal(mi_values[2]);
                            device_data.WeightUnit = "kg";
                            device_data.Bmi = Utilities.ToDecimal(mi_values[3]);
                        }

                        serial_port_2.Data = "";
                    }
                    else
                        return;
                    break;
                case "gtech_gl310":
                    if (serial_port_2.Data.Contains('\u0002') && serial_port_2.Data.Contains('\u0003'))
                    {
                        using (MiStringArray mi_values = new MiStringArray(serial_port_2.Data.Replace('\u0002', ' ').Replace('\u0003', ' ').Trim().Split(',')))
                        {
                            device_data.IsActiveDevice2 = true;
                            device_data.Height = Utilities.ToDecimal(mi_values[0]);
                            device_data.HeightUnit = "cm";
                            device_data.Weight = Utilities.ToDecimal(mi_values[1]);
                            device_data.WeightUnit = "kg";
                            device_data.Bmi = Utilities.ToDecimal(mi_values[4]);
                        }

                        serial_port_2.Data = "";
                    }
                    else
                        return;
                    break;
                case "omron_hbp9030":
                    if (serial_port_2.Data.Contains('\u0013') && serial_port_2.Data.Contains('\u0010'))
                    {
                        using (MiStringArray mi_values = new MiStringArray(serial_port_2.Data.Replace('\u0013', ' ').Replace('\u0010', ' ').Trim().Split(',')))
                        {
                            device_data.IsActiveDevice2 = true;
                            device_data.BloodPressureSystolic = Utilities.ToInt(mi_values[7]);
                            device_data.BloodPressureDiastolic = Utilities.ToInt(mi_values[8]);
                            device_data.BloodPressureMean = (device_data.BloodPressureSystolic + (2 * device_data.BloodPressureDiastolic)) / 3;
                            device_data.BloodPressureUnit = "mmHg";
                            device_data.PulseRate = Utilities.ToInt(mi_values[9]);
                        }

                        serial_port_2.Data = "";
                    }
                    else
                        return;
                    break;
                default:
                    serial_port_2.Data = "";
                    return;
            }

            WaitControl();
            */
        }

        private bool SerialPortMessageReceived(ModalityDeviceConfig modalityDevice, string data)
        {
            if (string.IsNullOrEmpty(data))
                return false;

            if (modalityDevice.EnableTrace)
            {
                //MessageBox.Show(data);

                IeServiceLog.Save(new IeLog()
                {
                    OwnerName = $"{IeServiceConfig.ServiceName}_{ServiceConfig.ModalityConfig.ModalityUid}".TrimEnd(new char[] { '_' }),
                    ThirdPartyName = "SerialPort",

                    Connection = $"{modalityDevice.PortName}",

                    EventName = "MessageReceived",
                    EventData = data + "\r\n\r\n" + Utilities.ConvertAsciiOctetsToString(Encoding.ASCII.GetBytes(data))
                });
            }

            switch (modalityDevice.DeviceName.ToLower())
            {
                case "and_tm2657p":
                    if (data.Contains('\u0002') && data.Contains('\u0003'))
                    {
                        using (MiStringArray mi_values = new MiStringArray(data.Split('\u001e')))
                        {
                            if (modalityDevice.AcceptBloodPressure)
                            {
                                device_data.BloodPressureSystolic = Utilities.ToInt(Utilities.ToCleanString(mi_values[5].TrimStart(new char[] { 'S' })));
                                device_data.BloodPressureDiastolic = Utilities.ToInt(Utilities.ToCleanString(mi_values[7].TrimStart(new char[] { 'D' })));
                                device_data.BloodPressureMean = (device_data.BloodPressureSystolic + (2 * device_data.BloodPressureDiastolic)) / 3;
                                device_data.BloodPressureUnit = "mmHg";
                            }
                            if (modalityDevice.AcceptPulseRate)
                                device_data.PulseRate = Utilities.ToInt(Utilities.ToCleanString(mi_values[8].TrimStart(new char[] { 'P' })));
                        }
                    }
                    else
                        return false;
                    break;
                case "gtech_gl150":
                case "gtech_gl310":
                    if (data.Contains('\u0002') && data.Contains('\u0003'))
                    {
                        using (MiStringArray mi_values = new MiStringArray(data.Replace('\u0002', ' ').Replace('\u0003', ' ').Trim().Split(',')))
                        {
                            if (modalityDevice.AcceptHeight)
                            {
                                device_data.Height = Utilities.ToDecimal(mi_values[0]);
                                device_data.HeightUnit = "cm";
                            }
                            if (modalityDevice.AcceptWeight)
                            {
                                device_data.Weight = Utilities.ToDecimal(mi_values[1]);
                                device_data.WeightUnit = "kg";
                            }
                            if (modalityDevice.AcceptBmi)
                                device_data.Bmi = Utilities.ToDecimal(mi_values[4]);
                        }
                    }
                    else
                        return false;
                    break;
                case "gtech_gl310_f4=1":
                    //\0\r\nGENDER   ---- FEMALE\r\nWEIGHT   ---- 90.05 kg\r\nSTANDARD ---- 74.69 kg\r\nHEIGHT   ---- 188.6 cm\r\nB  M  I  ----  25.3   \r\nFATNESS  ---- 120.5 % \r\nMARKS    ---- FATTY\r\n\u001bT\0
                    if (data.Contains("\u001bT\0"))
                    {
                        string[] parameters = data.Split(new string[] { "\r\n" }, StringSplitOptions.RemoveEmptyEntries);

                        foreach (string parameter in parameters)
                        {
                            using (MiStringArray mi_values = new MiStringArray(parameter.Trim().Split(new string[] { "----" }, StringSplitOptions.None)))
                            {
                                switch (Utilities.ToCleanString(mi_values[0]).Replace(" ", "").ToUpper())
                                {
                                    case "WEIGHT":
                                        if (modalityDevice.AcceptWeight)
                                        {
                                            device_data.Weight = Utilities.ToDecimal(mi_values[1].Replace("kg", ""));
                                            device_data.WeightUnit = "kg";
                                        }
                                        break;
                                    case "HEIGHT":
                                        if (modalityDevice.AcceptHeight)
                                        {
                                            device_data.Height = Utilities.ToDecimal(mi_values[1].Replace("cm", ""));
                                            device_data.HeightUnit = "cm";
                                        }
                                        break;
                                    case "BMI":
                                        if (modalityDevice.AcceptBmi)
                                            device_data.Bmi = Utilities.ToDecimal(mi_values[1]);
                                        break;
                                }

                            }
                        }
                    }
                    else
                        return false;
                    break;
                case "omron_hbp9030":
                    if (data.Contains("\r\n"))
                    {
                        using (MiStringArray mi_values = new MiStringArray(data.Replace("\r\n", "").Trim().Split(',')))
                        {
                            if (modalityDevice.AcceptBloodPressure)
                            {
                                device_data.BloodPressureSystolic = Utilities.ToInt(mi_values[7]);
                                device_data.BloodPressureDiastolic = Utilities.ToInt(mi_values[8]);
                                device_data.BloodPressureMean = (device_data.BloodPressureSystolic + (2 * device_data.BloodPressureDiastolic)) / 3;
                                device_data.BloodPressureUnit = "mmHg";
                            }
                            if (modalityDevice.AcceptPulseRate)
                                device_data.PulseRate = Utilities.ToInt(mi_values[9]);
                        }
                    }
                    else
                        return false;
                    break;
                case "omron_hbp9020_mode5_f3":
                    //bp,99999999999999999999,2023/04/27,15:06,140,098,077,068,3\r\n
                    if (data.Contains("\r\n"))
                    {
                        using (MiStringArray mi_values = new MiStringArray(data.Replace("\r\n", "").Trim().Split(',')))
                        {
                            if (modalityDevice.AcceptBloodPressure)
                            {
                                device_data.BloodPressureSystolic = Utilities.ToInt(mi_values[4]);
                                device_data.BloodPressureDiastolic = Utilities.ToInt(mi_values[6]);
                                device_data.BloodPressureMean = (device_data.BloodPressureSystolic + (2 * device_data.BloodPressureDiastolic)) / 3;
                                device_data.BloodPressureUnit = "mmHg";
                            }
                            if (modalityDevice.AcceptPulseRate)
                                device_data.PulseRate = Utilities.ToInt(mi_values[7]);
                        }
                    }
                    else
                        return false;
                    break;
                case "terumo_bp500":
                    if (data.Contains('\u0002') && data.Contains('\u0003'))
                    {
                        //"\u0002R1,000000000,210427,153000,128,097,082,084,0000,0000,00000,000\u0003?"
                        using (MiStringArray mi_values = new MiStringArray(data.Replace('\u0002', ' ').Replace('\u0003', ' ').Trim().Split(',')))
                        {
                            if (modalityDevice.AcceptBloodPressure)
                            {
                                device_data.BloodPressureSystolic = Utilities.ToInt(mi_values[4]);
                                device_data.BloodPressureDiastolic = Utilities.ToInt(mi_values[6]);
                                device_data.BloodPressureMean = (device_data.BloodPressureSystolic + (2 * device_data.BloodPressureDiastolic)) / 3;
                                device_data.BloodPressureUnit = "mmHg";
                            }
                            if (modalityDevice.AcceptPulseRate)
                                device_data.PulseRate = Utilities.ToInt(mi_values[7]);
                        }
                    }
                    else
                        return false;
                    break;
                default:
                    return false;
            }

            WaitDataControl();
            CheckValidData(true);

            return true;
        }

        /*
                    if (message.Contains("----"))
                    {
                        using (MiStringArray mi_values = new MiStringArray(message.Split(new string[] { "\r\n", "\r", "\n" }, StringSplitOptions.None)))
                        {
                            for (int i = 0; i<mi_values.Count; i++)
                            {
                                if (mi_values[i].ToLower().Contains("weight"))
                                {
                                    string[] temp = mi_values[i].Split(new string[] { "----" }, StringSplitOptions.None);

    device_data.IsActiveDevice1 = true;
                                    device_data.Weight = Utilities.ToDecimal(temp[1].Split(' ')[0]);
                                    device_data.WeightUnit = temp[1].Split(' ')[1];
                                }
                                else if (mi_values[i].ToLower().Contains("height"))
{
    string[] temp = mi_values[i].Split(new string[] { "----" }, StringSplitOptions.None);

    device_data.IsActiveDevice1 = true;
    device_data.Height = Utilities.ToDecimal(temp[1].Split(' ')[0]);
    device_data.HeightUnit = temp[1].Split(' ')[1];
}
else if (mi_values[i].ToLower().Contains("b  m  i"))
{
    string[] temp = mi_values[i].Split(new string[] { "----" }, StringSplitOptions.None);

    device_data.IsActiveDevice1 = true;
    device_data.Bmi = Utilities.ToDecimal(temp[1].Split(' ')[0]);
}
                            }
                        }
                    }
                    else if (message.Contains("ZK"))
{
    using (MiStringArray mi_values = new MiStringArray(message.Split(new string[] { "\u001b", "ZK" }, StringSplitOptions.None)))
    {
        device_data.IsActiveDevice1 = true;
        device_data.Height = Utilities.ToDecimal(mi_values[1]) / 10;
        device_data.HeightUnit = "cm";
        device_data.Weight = Utilities.ToDecimal(mi_values[2]) / 10;
        device_data.WeightUnit = "kg";
        device_data.Bmi = Utilities.ToDecimal(mi_values[3]) / 10;
    }
}
else if (message.Contains("{0,") || message.Contains("WB-3000"))
{
    using (MiStringArray mi_values = new MiStringArray(message.Split(new string[] { "," }, StringSplitOptions.None)))
    {
        for (int i = 0; i < mi_values.Count; i++)
        {
            switch (mi_values[i].ToLower())
            {
                case "hm":
                    device_data.IsActiveDevice1 = true;
                    device_data.Height = Utilities.ToDecimal(mi_values[i + 1]);
                    device_data.HeightUnit = "cm";
                    break;
                case "hf":
                    device_data.IsActiveDevice1 = true;
                    device_data.Height = Utilities.ToDecimal(mi_values[i + 1]);
                    device_data.HeightUnit = "F";
                    break;
                case "wk":
                    device_data.IsActiveDevice1 = true;
                    device_data.Weight = Utilities.ToDecimal(mi_values[i + 1]);
                    device_data.WeightUnit = "kg";
                    break;
                case "wp":
                    device_data.IsActiveDevice1 = true;
                    device_data.Weight = Utilities.ToDecimal(mi_values[i + 1]);
                    device_data.WeightUnit = "P";
                    break;
                case "mi":
                    device_data.IsActiveDevice1 = true;
                    device_data.Bmi = Utilities.ToDecimal(mi_values[i + 1]);
                    break;
            }
        }
    }
}
else return;
                    */
        #endregion

        #region Observation
        private void obsWeight_ValueChanged() => device_data.Weight = Utilities.ToDecimal(obsWeight.ObservationText);
        private void obsHeight_ValueChanged() => device_data.Height = Utilities.ToDecimal(obsHeight.ObservationText);
        private void obsBmi_ValueChanged() => device_data.Bmi = Utilities.ToDecimal(obsBmi.ObservationText);
        private void obsPainScale_ValueChanged() => device_data.PainScale = Utilities.ToInt(obsPainScale.ObservationText);
        private void obsPulseRate_ValueChanged() => device_data.PulseRate = Utilities.ToInt(obsPulseRate.ObservationText);
        private void obsBloodPressureSystolic_ValueChanged() => device_data.BloodPressureSystolic = Utilities.ToInt(obsBloodPressureSystolic.ObservationText);
        private void obsBloodPressureDiastolic_ValueChanged() => device_data.BloodPressureDiastolic = Utilities.ToInt(obsBloodPressureDiastolic.ObservationText);
        private void obsBloodPressureMean_ValueChanged() => device_data.BloodPressureMean = Utilities.ToInt(obsBloodPressureMean.ObservationText);
        private void obsSpO2_ValueChanged() => device_data.SpO2 = Utilities.ToDecimal(obsSpO2.ObservationText);
        private void obsTemperature_ValueChanged() => device_data.Temperature = Utilities.ToDecimal(obsTemperature.ObservationText);
        private void obsBloodGlucose_ValueChanged() => device_data.BloodGlucose = Utilities.ToInt(obsBloodGlucose.ObservationText);
        private void obsRespirationRate_ValueChanged() => device_data.RespirationRate = Utilities.ToInt(obsRespirationRate.ObservationText);
        #endregion
    }
}