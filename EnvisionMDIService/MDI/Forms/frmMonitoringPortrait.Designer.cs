namespace MDI.Forms
{
    partial class frmMonitoringPortrait
    {
        /// <summary>
        /// Required designer variable.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Clean up any resources being used.
        /// </summary>
        /// <param name="disposing">true if managed resources should be disposed; otherwise, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form Designer generated code

        /// <summary>
        /// Required method for Designer support - do not modify
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(frmMonitoringPortrait));
            this.lblHn = new System.Windows.Forms.Label();
            this.pnlData = new System.Windows.Forms.Panel();
            this.lblVersion = new System.Windows.Forms.Label();
            this.obsBloodGlucose = new MDI.Forms.ctrlObservation();
            this.obsPulseRate = new MDI.Forms.ctrlObservation();
            this.obsRespirationRate = new MDI.Forms.ctrlObservation();
            this.obsPainScale = new MDI.Forms.ctrlObservation();
            this.pnlPatient = new System.Windows.Forms.Panel();
            this.txtHn = new System.Windows.Forms.Label();
            this.lblPatientInfo = new System.Windows.Forms.Label();
            this.obsTemperature = new MDI.Forms.ctrlObservation();
            this.obsSpO2 = new MDI.Forms.ctrlObservation();
            this.obsBloodPressureDiastolic = new MDI.Forms.ctrlObservation();
            this.obsBloodPressureMean = new MDI.Forms.ctrlObservation();
            this.obsBloodPressureSystolic = new MDI.Forms.ctrlObservation();
            this.obsBmi = new MDI.Forms.ctrlObservation();
            this.obsHeight = new MDI.Forms.ctrlObservation();
            this.obsWeight = new MDI.Forms.ctrlObservation();
            this.btnSave = new System.Windows.Forms.Button();
            this.btnClearOrStopAutoSave = new System.Windows.Forms.Button();
            this.lblNotifySave = new System.Windows.Forms.Label();
            this.pnlOption = new System.Windows.Forms.Panel();
            this.flowHistory = new System.Windows.Forms.FlowLayoutPanel();
            this.btnSerialPort1Command = new System.Windows.Forms.Button();
            this.lblDatetime = new System.Windows.Forms.Label();
            this.btnSerialPort2Command = new System.Windows.Forms.Button();
            this.btnSetting = new System.Windows.Forms.Button();
            this.btnClose = new System.Windows.Forms.Button();
            this.lblDeviceInfo = new System.Windows.Forms.Label();
            this.lblWaiting = new System.Windows.Forms.Label();
            this.pnlWaiting = new System.Windows.Forms.Panel();
            this.pnlMain = new System.Windows.Forms.Panel();
            this.pnlForm = new System.Windows.Forms.Panel();
            this.pnlData.SuspendLayout();
            this.pnlPatient.SuspendLayout();
            this.pnlOption.SuspendLayout();
            this.pnlWaiting.SuspendLayout();
            this.pnlMain.SuspendLayout();
            this.pnlForm.SuspendLayout();
            this.SuspendLayout();
            // 
            // lblHn
            // 
            this.lblHn.AutoSize = true;
            this.lblHn.Font = new System.Drawing.Font("Microsoft Sans Serif", 24F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(0)));
            this.lblHn.ForeColor = System.Drawing.Color.Black;
            this.lblHn.Location = new System.Drawing.Point(3, 3);
            this.lblHn.Name = "lblHn";
            this.lblHn.Size = new System.Drawing.Size(66, 37);
            this.lblHn.TabIndex = 0;
            this.lblHn.Text = "HN";
            // 
            // pnlData
            // 
            this.pnlData.BackColor = System.Drawing.Color.White;
            this.pnlData.Controls.Add(this.lblVersion);
            this.pnlData.Controls.Add(this.obsBloodGlucose);
            this.pnlData.Controls.Add(this.obsPulseRate);
            this.pnlData.Controls.Add(this.obsRespirationRate);
            this.pnlData.Controls.Add(this.obsPainScale);
            this.pnlData.Controls.Add(this.pnlPatient);
            this.pnlData.Controls.Add(this.obsTemperature);
            this.pnlData.Controls.Add(this.obsSpO2);
            this.pnlData.Controls.Add(this.obsBloodPressureDiastolic);
            this.pnlData.Controls.Add(this.obsBloodPressureMean);
            this.pnlData.Controls.Add(this.obsBloodPressureSystolic);
            this.pnlData.Controls.Add(this.obsBmi);
            this.pnlData.Controls.Add(this.obsHeight);
            this.pnlData.Controls.Add(this.obsWeight);
            this.pnlData.Location = new System.Drawing.Point(6, 3);
            this.pnlData.Name = "pnlData";
            this.pnlData.Size = new System.Drawing.Size(711, 576);
            this.pnlData.TabIndex = 0;
            this.pnlData.DoubleClick += new System.EventHandler(this.ShowDialogHnPad);
            // 
            // lblVersion
            // 
            this.lblVersion.AutoSize = true;
            this.lblVersion.Font = new System.Drawing.Font("Microsoft Sans Serif", 9F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(222)));
            this.lblVersion.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(255)))), ((int)(((byte)(128)))), ((int)(((byte)(0)))));
            this.lblVersion.Location = new System.Drawing.Point(615, 555);
            this.lblVersion.Name = "lblVersion";
            this.lblVersion.Size = new System.Drawing.Size(90, 15);
            this.lblVersion.TabIndex = 13;
            this.lblVersion.Text = "v. 888888-88";
            this.lblVersion.TextAlign = System.Drawing.ContentAlignment.TopRight;
            // 
            // obsBloodGlucose
            // 
            this.obsBloodGlucose.BackColor = System.Drawing.Color.DodgerBlue;
            this.obsBloodGlucose.EditorMode = MDI.Forms.ObservationEditorMode.Numpad;
            this.obsBloodGlucose.Identifier = "Blood Glucose";
            this.obsBloodGlucose.Location = new System.Drawing.Point(429, 462);
            this.obsBloodGlucose.MinimumSize = new System.Drawing.Size(96, 96);
            this.obsBloodGlucose.Name = "obsBloodGlucose";
            this.obsBloodGlucose.ObservationFormat = "0";
            this.obsBloodGlucose.ObservationText = "0";
            this.obsBloodGlucose.ObservationType = "int";
            this.obsBloodGlucose.Size = new System.Drawing.Size(135, 108);
            this.obsBloodGlucose.TabIndex = 10;
            this.obsBloodGlucose.Unit = "mg/dL";
            this.obsBloodGlucose.Visible = false;
            this.obsBloodGlucose.ValueChanged += new MDI.Forms.ctrlObservation.EventValueChanged(this.obsBloodGlucose_ValueChanged);
            // 
            // obsPulseRate
            // 
            this.obsPulseRate.BackColor = System.Drawing.Color.DodgerBlue;
            this.obsPulseRate.EditorMode = MDI.Forms.ObservationEditorMode.Numpad;
            this.obsPulseRate.Identifier = "Pulse Rate";
            this.obsPulseRate.Location = new System.Drawing.Point(570, 348);
            this.obsPulseRate.MinimumSize = new System.Drawing.Size(96, 96);
            this.obsPulseRate.Name = "obsPulseRate";
            this.obsPulseRate.NormalMax = new decimal(new int[] {
            99,
            0,
            0,
            0});
            this.obsPulseRate.NormalMin = new decimal(new int[] {
            1,
            0,
            0,
            0});
            this.obsPulseRate.ObservationFormat = "0";
            this.obsPulseRate.ObservationText = "0";
            this.obsPulseRate.ObservationType = "int";
            this.obsPulseRate.Size = new System.Drawing.Size(135, 108);
            this.obsPulseRate.TabIndex = 8;
            this.obsPulseRate.Unit = "";
            this.obsPulseRate.ValueChanged += new MDI.Forms.ctrlObservation.EventValueChanged(this.obsPulseRate_ValueChanged);
            // 
            // obsRespirationRate
            // 
            this.obsRespirationRate.BackColor = System.Drawing.Color.DodgerBlue;
            this.obsRespirationRate.EditorMode = MDI.Forms.ObservationEditorMode.Numpad;
            this.obsRespirationRate.Identifier = "Respirations";
            this.obsRespirationRate.Location = new System.Drawing.Point(147, 462);
            this.obsRespirationRate.MinimumSize = new System.Drawing.Size(96, 96);
            this.obsRespirationRate.Name = "obsRespirationRate";
            this.obsRespirationRate.ObservationFormat = "0";
            this.obsRespirationRate.ObservationText = "0";
            this.obsRespirationRate.ObservationType = "int";
            this.obsRespirationRate.Size = new System.Drawing.Size(135, 108);
            this.obsRespirationRate.TabIndex = 11;
            this.obsRespirationRate.Unit = "";
            this.obsRespirationRate.ValueChanged += new MDI.Forms.ctrlObservation.EventValueChanged(this.obsRespirationRate_ValueChanged);
            // 
            // obsPainScale
            // 
            this.obsPainScale.BackColor = System.Drawing.Color.DodgerBlue;
            this.obsPainScale.EditorMode = MDI.Forms.ObservationEditorMode.Numpad;
            this.obsPainScale.Identifier = "Pain Scale";
            this.obsPainScale.Location = new System.Drawing.Point(288, 462);
            this.obsPainScale.MinimumSize = new System.Drawing.Size(96, 96);
            this.obsPainScale.Name = "obsPainScale";
            this.obsPainScale.NormalMax = new decimal(new int[] {
            4,
            0,
            0,
            0});
            this.obsPainScale.NormalMin = new decimal(new int[] {
            1,
            0,
            0,
            0});
            this.obsPainScale.ObservationFormat = "0";
            this.obsPainScale.ObservationText = "0";
            this.obsPainScale.ObservationType = "int";
            this.obsPainScale.Size = new System.Drawing.Size(135, 108);
            this.obsPainScale.TabIndex = 12;
            this.obsPainScale.Unit = "";
            this.obsPainScale.ValueChanged += new MDI.Forms.ctrlObservation.EventValueChanged(this.obsPainScale_ValueChanged);
            // 
            // pnlPatient
            // 
            this.pnlPatient.BackColor = System.Drawing.Color.DodgerBlue;
            this.pnlPatient.Controls.Add(this.txtHn);
            this.pnlPatient.Controls.Add(this.lblPatientInfo);
            this.pnlPatient.Controls.Add(this.lblHn);
            this.pnlPatient.Location = new System.Drawing.Point(6, 6);
            this.pnlPatient.Name = "pnlPatient";
            this.pnlPatient.Size = new System.Drawing.Size(417, 336);
            this.pnlPatient.TabIndex = 0;
            // 
            // txtHn
            // 
            this.txtHn.BackColor = System.Drawing.Color.White;
            this.txtHn.Font = new System.Drawing.Font("Microsoft Sans Serif", 26.25F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(222)));
            this.txtHn.ForeColor = System.Drawing.Color.Black;
            this.txtHn.Location = new System.Drawing.Point(75, 3);
            this.txtHn.Name = "txtHn";
            this.txtHn.Size = new System.Drawing.Size(339, 39);
            this.txtHn.TabIndex = 4;
            this.txtHn.Click += new System.EventHandler(this.ShowDialogHnPad);
            // 
            // lblPatientInfo
            // 
            this.lblPatientInfo.Font = new System.Drawing.Font("Microsoft Sans Serif", 24F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(222)));
            this.lblPatientInfo.ForeColor = System.Drawing.Color.Black;
            this.lblPatientInfo.Location = new System.Drawing.Point(3, 53);
            this.lblPatientInfo.Name = "lblPatientInfo";
            this.lblPatientInfo.Size = new System.Drawing.Size(411, 283);
            this.lblPatientInfo.TabIndex = 3;
            this.lblPatientInfo.Text = "PATIENT INFORMATION XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
            this.lblPatientInfo.DoubleClick += new System.EventHandler(this.ShowDialogHnPad);
            // 
            // obsTemperature
            // 
            this.obsTemperature.BackColor = System.Drawing.Color.DodgerBlue;
            this.obsTemperature.EditorMode = MDI.Forms.ObservationEditorMode.Numpad;
            this.obsTemperature.Identifier = "Temperature";
            this.obsTemperature.Location = new System.Drawing.Point(429, 348);
            this.obsTemperature.MinimumSize = new System.Drawing.Size(96, 96);
            this.obsTemperature.Name = "obsTemperature";
            this.obsTemperature.NormalMax = new decimal(new int[] {
            3849,
            0,
            0,
            131072});
            this.obsTemperature.NormalMin = new decimal(new int[] {
            3601,
            0,
            0,
            131072});
            this.obsTemperature.ObservationFormat = "0.00";
            this.obsTemperature.ObservationText = "0.00";
            this.obsTemperature.ObservationType = "decimal";
            this.obsTemperature.Size = new System.Drawing.Size(135, 108);
            this.obsTemperature.TabIndex = 7;
            this.obsTemperature.Unit = "°C";
            this.obsTemperature.ValueChanged += new MDI.Forms.ctrlObservation.EventValueChanged(this.obsTemperature_ValueChanged);
            // 
            // obsSpO2
            // 
            this.obsSpO2.BackColor = System.Drawing.Color.DodgerBlue;
            this.obsSpO2.EditorMode = MDI.Forms.ObservationEditorMode.Numpad;
            this.obsSpO2.Identifier = "SpO2";
            this.obsSpO2.Location = new System.Drawing.Point(6, 462);
            this.obsSpO2.MinimumSize = new System.Drawing.Size(96, 96);
            this.obsSpO2.Name = "obsSpO2";
            this.obsSpO2.NormalMax = new decimal(new int[] {
            100,
            0,
            0,
            0});
            this.obsSpO2.NormalMin = new decimal(new int[] {
            95,
            0,
            0,
            0});
            this.obsSpO2.ObservationFormat = "0.00";
            this.obsSpO2.ObservationText = "0.00";
            this.obsSpO2.ObservationType = "decimal";
            this.obsSpO2.Size = new System.Drawing.Size(135, 108);
            this.obsSpO2.TabIndex = 9;
            this.obsSpO2.Unit = "%";
            this.obsSpO2.ValueChanged += new MDI.Forms.ctrlObservation.EventValueChanged(this.obsSpO2_ValueChanged);
            // 
            // obsBloodPressureDiastolic
            // 
            this.obsBloodPressureDiastolic.BackColor = System.Drawing.Color.DodgerBlue;
            this.obsBloodPressureDiastolic.EditorMode = MDI.Forms.ObservationEditorMode.Numpad;
            this.obsBloodPressureDiastolic.Identifier = "Blood Pressure Diastolic";
            this.obsBloodPressureDiastolic.Location = new System.Drawing.Point(429, 234);
            this.obsBloodPressureDiastolic.MinimumSize = new System.Drawing.Size(96, 96);
            this.obsBloodPressureDiastolic.Name = "obsBloodPressureDiastolic";
            this.obsBloodPressureDiastolic.NormalMax = new decimal(new int[] {
            89,
            0,
            0,
            0});
            this.obsBloodPressureDiastolic.NormalMin = new decimal(new int[] {
            61,
            0,
            0,
            0});
            this.obsBloodPressureDiastolic.ObservationFormat = "0";
            this.obsBloodPressureDiastolic.ObservationText = "0";
            this.obsBloodPressureDiastolic.ObservationType = "int";
            this.obsBloodPressureDiastolic.Size = new System.Drawing.Size(276, 108);
            this.obsBloodPressureDiastolic.TabIndex = 3;
            this.obsBloodPressureDiastolic.Unit = "mmHg";
            this.obsBloodPressureDiastolic.ValueChanged += new MDI.Forms.ctrlObservation.EventValueChanged(this.obsBloodPressureDiastolic_ValueChanged);
            // 
            // obsBloodPressureMean
            // 
            this.obsBloodPressureMean.BackColor = System.Drawing.Color.DodgerBlue;
            this.obsBloodPressureMean.EditorMode = MDI.Forms.ObservationEditorMode.Numpad;
            this.obsBloodPressureMean.Identifier = "Blood Pressure Mean";
            this.obsBloodPressureMean.Location = new System.Drawing.Point(429, 120);
            this.obsBloodPressureMean.MinimumSize = new System.Drawing.Size(96, 96);
            this.obsBloodPressureMean.Name = "obsBloodPressureMean";
            this.obsBloodPressureMean.ObservationFormat = "0";
            this.obsBloodPressureMean.ObservationText = "0";
            this.obsBloodPressureMean.ObservationType = "int";
            this.obsBloodPressureMean.Size = new System.Drawing.Size(276, 108);
            this.obsBloodPressureMean.TabIndex = 2;
            this.obsBloodPressureMean.Unit = "mmHg";
            this.obsBloodPressureMean.ValueChanged += new MDI.Forms.ctrlObservation.EventValueChanged(this.obsBloodPressureMean_ValueChanged);
            // 
            // obsBloodPressureSystolic
            // 
            this.obsBloodPressureSystolic.BackColor = System.Drawing.Color.DodgerBlue;
            this.obsBloodPressureSystolic.EditorMode = MDI.Forms.ObservationEditorMode.Numpad;
            this.obsBloodPressureSystolic.Identifier = "Blood Pressure Systolic";
            this.obsBloodPressureSystolic.Location = new System.Drawing.Point(429, 6);
            this.obsBloodPressureSystolic.MinimumSize = new System.Drawing.Size(96, 96);
            this.obsBloodPressureSystolic.Name = "obsBloodPressureSystolic";
            this.obsBloodPressureSystolic.NormalMax = new decimal(new int[] {
            139,
            0,
            0,
            0});
            this.obsBloodPressureSystolic.NormalMin = new decimal(new int[] {
            91,
            0,
            0,
            0});
            this.obsBloodPressureSystolic.ObservationFormat = "0";
            this.obsBloodPressureSystolic.ObservationText = "0";
            this.obsBloodPressureSystolic.ObservationType = "int";
            this.obsBloodPressureSystolic.Size = new System.Drawing.Size(276, 108);
            this.obsBloodPressureSystolic.TabIndex = 1;
            this.obsBloodPressureSystolic.Unit = "mmHg";
            this.obsBloodPressureSystolic.ValueChanged += new MDI.Forms.ctrlObservation.EventValueChanged(this.obsBloodPressureSystolic_ValueChanged);
            // 
            // obsBmi
            // 
            this.obsBmi.BackColor = System.Drawing.Color.DodgerBlue;
            this.obsBmi.EditorMode = MDI.Forms.ObservationEditorMode.Numpad;
            this.obsBmi.Identifier = "BMI";
            this.obsBmi.Location = new System.Drawing.Point(288, 348);
            this.obsBmi.MinimumSize = new System.Drawing.Size(96, 96);
            this.obsBmi.Name = "obsBmi";
            this.obsBmi.ObservationFormat = "0.00";
            this.obsBmi.ObservationText = "0.00";
            this.obsBmi.ObservationType = "decimal";
            this.obsBmi.Size = new System.Drawing.Size(135, 108);
            this.obsBmi.TabIndex = 6;
            this.obsBmi.Unit = "Kg./m2";
            this.obsBmi.ValueChanged += new MDI.Forms.ctrlObservation.EventValueChanged(this.obsBmi_ValueChanged);
            // 
            // obsHeight
            // 
            this.obsHeight.BackColor = System.Drawing.Color.DodgerBlue;
            this.obsHeight.EditorMode = MDI.Forms.ObservationEditorMode.Numpad;
            this.obsHeight.Identifier = "Height";
            this.obsHeight.Location = new System.Drawing.Point(147, 348);
            this.obsHeight.MinimumSize = new System.Drawing.Size(96, 96);
            this.obsHeight.Name = "obsHeight";
            this.obsHeight.ObservationFormat = "0.00";
            this.obsHeight.ObservationText = "0.00";
            this.obsHeight.ObservationType = "decimal";
            this.obsHeight.Size = new System.Drawing.Size(135, 108);
            this.obsHeight.TabIndex = 5;
            this.obsHeight.Unit = "cm.";
            this.obsHeight.ValueChanged += new MDI.Forms.ctrlObservation.EventValueChanged(this.obsHeight_ValueChanged);
            // 
            // obsWeight
            // 
            this.obsWeight.BackColor = System.Drawing.Color.DodgerBlue;
            this.obsWeight.EditorMode = MDI.Forms.ObservationEditorMode.Numpad;
            this.obsWeight.Identifier = "Weight";
            this.obsWeight.Location = new System.Drawing.Point(6, 348);
            this.obsWeight.MinimumSize = new System.Drawing.Size(96, 96);
            this.obsWeight.Name = "obsWeight";
            this.obsWeight.ObservationFormat = "0.00";
            this.obsWeight.ObservationText = "0.00";
            this.obsWeight.ObservationType = "decimal";
            this.obsWeight.Size = new System.Drawing.Size(135, 108);
            this.obsWeight.TabIndex = 4;
            this.obsWeight.Unit = "Kg.";
            this.obsWeight.ValueChanged += new MDI.Forms.ctrlObservation.EventValueChanged(this.obsWeight_ValueChanged);
            // 
            // btnSave
            // 
            this.btnSave.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(192)))), ((int)(((byte)(255)))), ((int)(((byte)(192)))));
            this.btnSave.BackgroundImage = global::MDI.Properties.Resources.save_128;
            this.btnSave.BackgroundImageLayout = System.Windows.Forms.ImageLayout.Center;
            this.btnSave.FlatStyle = System.Windows.Forms.FlatStyle.Popup;
            this.btnSave.Font = new System.Drawing.Font("Microsoft Sans Serif", 12F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(222)));
            this.btnSave.ForeColor = System.Drawing.Color.Black;
            this.btnSave.Location = new System.Drawing.Point(3, 613);
            this.btnSave.Name = "btnSave";
            this.btnSave.Size = new System.Drawing.Size(577, 100);
            this.btnSave.TabIndex = 13;
            this.btnSave.Text = "SAVE";
            this.btnSave.TextAlign = System.Drawing.ContentAlignment.BottomCenter;
            this.btnSave.UseVisualStyleBackColor = false;
            this.btnSave.Click += new System.EventHandler(this.btnSave_Click);
            // 
            // btnClearOrStopAutoSave
            // 
            this.btnClearOrStopAutoSave.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(255)))), ((int)(((byte)(192)))), ((int)(((byte)(192)))));
            this.btnClearOrStopAutoSave.FlatStyle = System.Windows.Forms.FlatStyle.Popup;
            this.btnClearOrStopAutoSave.Font = new System.Drawing.Font("Microsoft Sans Serif", 21.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(222)));
            this.btnClearOrStopAutoSave.ForeColor = System.Drawing.Color.Black;
            this.btnClearOrStopAutoSave.ImageAlign = System.Drawing.ContentAlignment.TopCenter;
            this.btnClearOrStopAutoSave.Location = new System.Drawing.Point(586, 613);
            this.btnClearOrStopAutoSave.Name = "btnClearOrStopAutoSave";
            this.btnClearOrStopAutoSave.Size = new System.Drawing.Size(135, 100);
            this.btnClearOrStopAutoSave.TabIndex = 14;
            this.btnClearOrStopAutoSave.Text = "CLEAR";
            this.btnClearOrStopAutoSave.UseVisualStyleBackColor = false;
            this.btnClearOrStopAutoSave.Click += new System.EventHandler(this.btnClearOrStopAutoSave_Click);
            // 
            // lblNotifySave
            // 
            this.lblNotifySave.Font = new System.Drawing.Font("Microsoft Sans Serif", 15.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(222)));
            this.lblNotifySave.ForeColor = System.Drawing.Color.FromArgb(((int)(((byte)(255)))), ((int)(((byte)(128)))), ((int)(((byte)(0)))));
            this.lblNotifySave.Location = new System.Drawing.Point(471, 585);
            this.lblNotifySave.Name = "lblNotifySave";
            this.lblNotifySave.Size = new System.Drawing.Size(250, 25);
            this.lblNotifySave.TabIndex = 7;
            this.lblNotifySave.Text = "Auto save in 10 sec.";
            this.lblNotifySave.TextAlign = System.Drawing.ContentAlignment.MiddleCenter;
            // 
            // pnlOption
            // 
            this.pnlOption.Anchor = System.Windows.Forms.AnchorStyles.None;
            this.pnlOption.AutoSize = true;
            this.pnlOption.BackColor = System.Drawing.Color.DeepSkyBlue;
            this.pnlOption.Controls.Add(this.flowHistory);
            this.pnlOption.Controls.Add(this.btnSerialPort1Command);
            this.pnlOption.Controls.Add(this.lblDatetime);
            this.pnlOption.Controls.Add(this.btnSerialPort2Command);
            this.pnlOption.Controls.Add(this.btnSetting);
            this.pnlOption.Controls.Add(this.btnClose);
            this.pnlOption.Location = new System.Drawing.Point(3, 722);
            this.pnlOption.Name = "pnlOption";
            this.pnlOption.Size = new System.Drawing.Size(728, 550);
            this.pnlOption.TabIndex = 0;
            // 
            // flowHistory
            // 
            this.flowHistory.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.flowHistory.AutoScroll = true;
            this.flowHistory.BackColor = System.Drawing.Color.DodgerBlue;
            this.flowHistory.FlowDirection = System.Windows.Forms.FlowDirection.TopDown;
            this.flowHistory.Location = new System.Drawing.Point(3, 43);
            this.flowHistory.Name = "flowHistory";
            this.flowHistory.Size = new System.Drawing.Size(722, 402);
            this.flowHistory.TabIndex = 5;
            this.flowHistory.WrapContents = false;
            // 
            // btnSerialPort1Command
            // 
            this.btnSerialPort1Command.BackgroundImage = global::MDI.Properties.Resources.service_start_64;
            this.btnSerialPort1Command.BackgroundImageLayout = System.Windows.Forms.ImageLayout.Center;
            this.btnSerialPort1Command.FlatStyle = System.Windows.Forms.FlatStyle.Popup;
            this.btnSerialPort1Command.Font = new System.Drawing.Font("Microsoft Sans Serif", 9F, System.Drawing.FontStyle.Bold);
            this.btnSerialPort1Command.ForeColor = System.Drawing.Color.Black;
            this.btnSerialPort1Command.Image = global::MDI.Properties.Resources.circle_red_16;
            this.btnSerialPort1Command.ImageAlign = System.Drawing.ContentAlignment.TopRight;
            this.btnSerialPort1Command.Location = new System.Drawing.Point(105, 451);
            this.btnSerialPort1Command.Name = "btnSerialPort1Command";
            this.btnSerialPort1Command.Size = new System.Drawing.Size(254, 96);
            this.btnSerialPort1Command.TabIndex = 2;
            this.btnSerialPort1Command.Text = "STOPED";
            this.btnSerialPort1Command.TextAlign = System.Drawing.ContentAlignment.TopCenter;
            this.btnSerialPort1Command.Click += new System.EventHandler(this.btnSerialPort1Command_Click);
            // 
            // lblDatetime
            // 
            this.lblDatetime.Font = new System.Drawing.Font("Microsoft Sans Serif", 24F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(222)));
            this.lblDatetime.Location = new System.Drawing.Point(3, 3);
            this.lblDatetime.Name = "lblDatetime";
            this.lblDatetime.Size = new System.Drawing.Size(718, 37);
            this.lblDatetime.TabIndex = 1;
            this.lblDatetime.Text = "8888-88-88 88:88";
            this.lblDatetime.TextAlign = System.Drawing.ContentAlignment.TopRight;
            // 
            // btnSerialPort2Command
            // 
            this.btnSerialPort2Command.BackgroundImage = global::MDI.Properties.Resources.service_start_64;
            this.btnSerialPort2Command.BackgroundImageLayout = System.Windows.Forms.ImageLayout.Center;
            this.btnSerialPort2Command.FlatStyle = System.Windows.Forms.FlatStyle.Popup;
            this.btnSerialPort2Command.Font = new System.Drawing.Font("Microsoft Sans Serif", 9F, System.Drawing.FontStyle.Bold);
            this.btnSerialPort2Command.ForeColor = System.Drawing.Color.Black;
            this.btnSerialPort2Command.Image = global::MDI.Properties.Resources.circle_red_16;
            this.btnSerialPort2Command.ImageAlign = System.Drawing.ContentAlignment.TopRight;
            this.btnSerialPort2Command.Location = new System.Drawing.Point(365, 451);
            this.btnSerialPort2Command.Name = "btnSerialPort2Command";
            this.btnSerialPort2Command.Size = new System.Drawing.Size(254, 96);
            this.btnSerialPort2Command.TabIndex = 3;
            this.btnSerialPort2Command.Text = "STOPED";
            this.btnSerialPort2Command.TextAlign = System.Drawing.ContentAlignment.TopCenter;
            this.btnSerialPort2Command.Click += new System.EventHandler(this.btnSerialPort2Command_Click);
            // 
            // btnSetting
            // 
            this.btnSetting.BackgroundImage = global::MDI.Properties.Resources.settings_64;
            this.btnSetting.BackgroundImageLayout = System.Windows.Forms.ImageLayout.Center;
            this.btnSetting.FlatStyle = System.Windows.Forms.FlatStyle.Popup;
            this.btnSetting.Font = new System.Drawing.Font("Microsoft Sans Serif", 9F, System.Drawing.FontStyle.Bold);
            this.btnSetting.ForeColor = System.Drawing.Color.Black;
            this.btnSetting.Location = new System.Drawing.Point(3, 451);
            this.btnSetting.Name = "btnSetting";
            this.btnSetting.Size = new System.Drawing.Size(96, 96);
            this.btnSetting.TabIndex = 11;
            this.btnSetting.Text = "SETTINGS";
            this.btnSetting.TextAlign = System.Drawing.ContentAlignment.BottomCenter;
            this.btnSetting.Click += new System.EventHandler(this.btnSetting_Click);
            // 
            // btnClose
            // 
            this.btnClose.BackgroundImage = global::MDI.Properties.Resources.close_64;
            this.btnClose.BackgroundImageLayout = System.Windows.Forms.ImageLayout.Center;
            this.btnClose.FlatStyle = System.Windows.Forms.FlatStyle.Popup;
            this.btnClose.Font = new System.Drawing.Font("Microsoft Sans Serif", 9F, System.Drawing.FontStyle.Bold);
            this.btnClose.ForeColor = System.Drawing.Color.Black;
            this.btnClose.Location = new System.Drawing.Point(625, 451);
            this.btnClose.Name = "btnClose";
            this.btnClose.Size = new System.Drawing.Size(96, 96);
            this.btnClose.TabIndex = 10;
            this.btnClose.Text = "CLOSE";
            this.btnClose.TextAlign = System.Drawing.ContentAlignment.BottomCenter;
            this.btnClose.UseVisualStyleBackColor = false;
            this.btnClose.Click += new System.EventHandler(this.btnClose_Click);
            // 
            // lblDeviceInfo
            // 
            this.lblDeviceInfo.Font = new System.Drawing.Font("Microsoft Sans Serif", 20.25F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(222)));
            this.lblDeviceInfo.Location = new System.Drawing.Point(3, 582);
            this.lblDeviceInfo.Name = "lblDeviceInfo";
            this.lblDeviceInfo.Size = new System.Drawing.Size(462, 32);
            this.lblDeviceInfo.TabIndex = 6;
            this.lblDeviceInfo.Text = "888.888.888.888";
            // 
            // lblWaiting
            // 
            this.lblWaiting.BackColor = System.Drawing.Color.FromArgb(((int)(((byte)(128)))), ((int)(((byte)(128)))), ((int)(((byte)(255)))));
            this.lblWaiting.Font = new System.Drawing.Font("Microsoft Sans Serif", 24F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(222)));
            this.lblWaiting.Location = new System.Drawing.Point(5, 5);
            this.lblWaiting.Name = "lblWaiting";
            this.lblWaiting.Size = new System.Drawing.Size(290, 140);
            this.lblWaiting.TabIndex = 14;
            this.lblWaiting.Text = "Waiting";
            this.lblWaiting.TextAlign = System.Drawing.ContentAlignment.MiddleCenter;
            // 
            // pnlWaiting
            // 
            this.pnlWaiting.Anchor = System.Windows.Forms.AnchorStyles.None;
            this.pnlWaiting.BackColor = System.Drawing.Color.White;
            this.pnlWaiting.Controls.Add(this.lblWaiting);
            this.pnlWaiting.Location = new System.Drawing.Point(220, 475);
            this.pnlWaiting.MaximumSize = new System.Drawing.Size(300, 150);
            this.pnlWaiting.MinimumSize = new System.Drawing.Size(300, 150);
            this.pnlWaiting.Name = "pnlWaiting";
            this.pnlWaiting.Size = new System.Drawing.Size(300, 150);
            this.pnlWaiting.TabIndex = 15;
            // 
            // pnlMain
            // 
            this.pnlMain.Controls.Add(this.pnlData);
            this.pnlMain.Controls.Add(this.lblNotifySave);
            this.pnlMain.Controls.Add(this.btnClearOrStopAutoSave);
            this.pnlMain.Controls.Add(this.btnSave);
            this.pnlMain.Controls.Add(this.lblDeviceInfo);
            this.pnlMain.Location = new System.Drawing.Point(3, 3);
            this.pnlMain.Name = "pnlMain";
            this.pnlMain.Size = new System.Drawing.Size(724, 716);
            this.pnlMain.TabIndex = 15;
            // 
            // pnlForm
            // 
            this.pnlForm.Anchor = System.Windows.Forms.AnchorStyles.None;
            this.pnlForm.BackColor = System.Drawing.Color.DeepSkyBlue;
            this.pnlForm.Controls.Add(this.pnlOption);
            this.pnlForm.Controls.Add(this.pnlMain);
            this.pnlForm.Location = new System.Drawing.Point(5, -87);
            this.pnlForm.Name = "pnlForm";
            this.pnlForm.Size = new System.Drawing.Size(730, 1275);
            this.pnlForm.TabIndex = 17;
            // 
            // frmMonitoringPortrait
            // 
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.None;
            this.BackColor = System.Drawing.Color.Black;
            this.ClientSize = new System.Drawing.Size(740, 1100);
            this.Controls.Add(this.pnlWaiting);
            this.Controls.Add(this.pnlForm);
            this.ForeColor = System.Drawing.Color.White;
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.None;
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.Name = "frmMonitoringPortrait";
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "Envision MDI - Main";
            this.WindowState = System.Windows.Forms.FormWindowState.Maximized;
            this.FormClosed += new System.Windows.Forms.FormClosedEventHandler(this.frmMain_FormClosed);
            this.Load += new System.EventHandler(this.frmMain_Load);
            this.Shown += new System.EventHandler(this.frmMain_Shown);
            this.pnlData.ResumeLayout(false);
            this.pnlData.PerformLayout();
            this.pnlPatient.ResumeLayout(false);
            this.pnlPatient.PerformLayout();
            this.pnlOption.ResumeLayout(false);
            this.pnlWaiting.ResumeLayout(false);
            this.pnlMain.ResumeLayout(false);
            this.pnlForm.ResumeLayout(false);
            this.pnlForm.PerformLayout();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.Button btnClose;
        private System.Windows.Forms.Button btnSetting;
        private System.Windows.Forms.Label lblHn;
        private System.Windows.Forms.Button btnSave;
        private System.Windows.Forms.Panel pnlData;
        private System.Windows.Forms.Button btnSerialPort2Command;
        private System.Windows.Forms.Panel pnlOption;
        private System.Windows.Forms.Label lblDeviceInfo;
        private System.Windows.Forms.Label lblDatetime;
        private System.Windows.Forms.Label lblNotifySave;
        private System.Windows.Forms.Button btnClearOrStopAutoSave;
        private System.Windows.Forms.FlowLayoutPanel flowHistory;
        private ctrlObservation obsWeight;
        private ctrlObservation obsSpO2;
        private ctrlObservation obsBloodPressureDiastolic;
        private ctrlObservation obsBloodPressureMean;
        private ctrlObservation obsBloodPressureSystolic;
        private ctrlObservation obsBmi;
        private ctrlObservation obsHeight;
        private ctrlObservation obsTemperature;
        private System.Windows.Forms.Panel pnlPatient;
        private System.Windows.Forms.Button btnSerialPort1Command;
        private ctrlObservation obsPainScale;
        private ctrlObservation obsRespirationRate;
        private ctrlObservation obsPulseRate;
        private ctrlObservation obsBloodGlucose;
        private System.Windows.Forms.Label lblVersion;
        private System.Windows.Forms.Label txtHn;
        private System.Windows.Forms.Label lblPatientInfo;
        private System.Windows.Forms.Label lblWaiting;
        private System.Windows.Forms.Panel pnlWaiting;
        private System.Windows.Forms.Panel pnlMain;
        private System.Windows.Forms.Panel pnlForm;
    }
}