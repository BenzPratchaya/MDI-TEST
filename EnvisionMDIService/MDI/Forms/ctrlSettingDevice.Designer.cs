namespace MDI.Forms
{
    partial class ctrlSettingDevice
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

        #region Component Designer generated code

        /// <summary> 
        /// Required method for Designer support - do not modify 
        /// the contents of this method with the code editor.
        /// </summary>
        private void InitializeComponent()
        {
            this.lblPortName = new System.Windows.Forms.Label();
            this.lblBaudRate = new System.Windows.Forms.Label();
            this.lblDataBits = new System.Windows.Forms.Label();
            this.lblParity = new System.Windows.Forms.Label();
            this.lblStopBits = new System.Windows.Forms.Label();
            this.cmbPortName = new System.Windows.Forms.ComboBox();
            this.cmbBaudRate = new System.Windows.Forms.ComboBox();
            this.cmbParity = new System.Windows.Forms.ComboBox();
            this.cmbDataBits = new System.Windows.Forms.ComboBox();
            this.cmbStopBits = new System.Windows.Forms.ComboBox();
            this.cmbDeviceName = new System.Windows.Forms.ComboBox();
            this.lblDeviceName = new System.Windows.Forms.Label();
            this.btnDelaySetZero = new System.Windows.Forms.Button();
            this.lblDelay = new System.Windows.Forms.Label();
            this.btnDelayPlusZeroPointFive = new System.Windows.Forms.Button();
            this.txtDelay = new System.Windows.Forms.NumericUpDown();
            this.btnDelayPlusOne = new System.Windows.Forms.Button();
            this.lblIsActived = new System.Windows.Forms.Label();
            this.lblEnableTrace = new System.Windows.Forms.Label();
            this.chkEnableTrace = new MDI.Forms.ctrlCheckbox();
            this.chkIsActive = new MDI.Forms.ctrlCheckbox();
            this.chkWeight = new MDI.Forms.ctrlCheckbox();
            this.chkHeight = new MDI.Forms.ctrlCheckbox();
            this.chkPulseRate = new MDI.Forms.ctrlCheckbox();
            this.chkBmi = new MDI.Forms.ctrlCheckbox();
            this.chkBloodPressure = new MDI.Forms.ctrlCheckbox();
            this.chkSpO2 = new MDI.Forms.ctrlCheckbox();
            this.chkBloodGlucose = new MDI.Forms.ctrlCheckbox();
            this.chkTemperature = new MDI.Forms.ctrlCheckbox();
            this.chkPainScale = new MDI.Forms.ctrlCheckbox();
            this.chkRespirationRate = new MDI.Forms.ctrlCheckbox();
            this.pnlDeviceSetting = new System.Windows.Forms.Panel();
            this.pnlDeviceAcceptData = new System.Windows.Forms.Panel();
            this.flowLayoutPanel = new System.Windows.Forms.FlowLayoutPanel();
            ((System.ComponentModel.ISupportInitialize)(this.txtDelay)).BeginInit();
            this.pnlDeviceSetting.SuspendLayout();
            this.pnlDeviceAcceptData.SuspendLayout();
            this.flowLayoutPanel.SuspendLayout();
            this.SuspendLayout();
            // 
            // lblPortName
            // 
            this.lblPortName.Font = new System.Drawing.Font("Microsoft Sans Serif", 21.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(222)));
            this.lblPortName.ForeColor = System.Drawing.Color.White;
            this.lblPortName.Location = new System.Drawing.Point(3, 4);
            this.lblPortName.Name = "lblPortName";
            this.lblPortName.Size = new System.Drawing.Size(202, 33);
            this.lblPortName.TabIndex = 31;
            this.lblPortName.Text = "Port Name";
            this.lblPortName.TextAlign = System.Drawing.ContentAlignment.TopRight;
            // 
            // lblBaudRate
            // 
            this.lblBaudRate.Font = new System.Drawing.Font("Microsoft Sans Serif", 21.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(222)));
            this.lblBaudRate.ForeColor = System.Drawing.Color.White;
            this.lblBaudRate.Location = new System.Drawing.Point(3, 133);
            this.lblBaudRate.Name = "lblBaudRate";
            this.lblBaudRate.Size = new System.Drawing.Size(202, 33);
            this.lblBaudRate.TabIndex = 33;
            this.lblBaudRate.Text = "Baud Rate";
            this.lblBaudRate.TextAlign = System.Drawing.ContentAlignment.TopRight;
            // 
            // lblDataBits
            // 
            this.lblDataBits.Font = new System.Drawing.Font("Microsoft Sans Serif", 21.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(222)));
            this.lblDataBits.ForeColor = System.Drawing.Color.White;
            this.lblDataBits.Location = new System.Drawing.Point(3, 176);
            this.lblDataBits.Name = "lblDataBits";
            this.lblDataBits.Size = new System.Drawing.Size(202, 33);
            this.lblDataBits.TabIndex = 39;
            this.lblDataBits.Text = "Data Bits";
            this.lblDataBits.TextAlign = System.Drawing.ContentAlignment.TopRight;
            // 
            // lblParity
            // 
            this.lblParity.Font = new System.Drawing.Font("Microsoft Sans Serif", 21.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(222)));
            this.lblParity.ForeColor = System.Drawing.Color.White;
            this.lblParity.Location = new System.Drawing.Point(3, 219);
            this.lblParity.Name = "lblParity";
            this.lblParity.Size = new System.Drawing.Size(202, 33);
            this.lblParity.TabIndex = 37;
            this.lblParity.Text = "Parity";
            this.lblParity.TextAlign = System.Drawing.ContentAlignment.TopRight;
            // 
            // lblStopBits
            // 
            this.lblStopBits.Font = new System.Drawing.Font("Microsoft Sans Serif", 21.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(222)));
            this.lblStopBits.ForeColor = System.Drawing.Color.White;
            this.lblStopBits.Location = new System.Drawing.Point(3, 262);
            this.lblStopBits.Name = "lblStopBits";
            this.lblStopBits.Size = new System.Drawing.Size(202, 33);
            this.lblStopBits.TabIndex = 35;
            this.lblStopBits.Text = "Stop Bits";
            this.lblStopBits.TextAlign = System.Drawing.ContentAlignment.TopRight;
            // 
            // cmbPortName
            // 
            this.cmbPortName.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.cmbPortName.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cmbPortName.Font = new System.Drawing.Font("Microsoft Sans Serif", 18F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(222)));
            this.cmbPortName.FormattingEnabled = true;
            this.cmbPortName.Location = new System.Drawing.Point(211, 5);
            this.cmbPortName.Name = "cmbPortName";
            this.cmbPortName.Size = new System.Drawing.Size(334, 37);
            this.cmbPortName.TabIndex = 32;
            this.cmbPortName.SelectedIndexChanged += new System.EventHandler(this.cmbPortName_SelectedIndexChanged);
            // 
            // cmbBaudRate
            // 
            this.cmbBaudRate.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.cmbBaudRate.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cmbBaudRate.Font = new System.Drawing.Font("Microsoft Sans Serif", 18F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(222)));
            this.cmbBaudRate.FormattingEnabled = true;
            this.cmbBaudRate.Location = new System.Drawing.Point(211, 134);
            this.cmbBaudRate.Name = "cmbBaudRate";
            this.cmbBaudRate.Size = new System.Drawing.Size(334, 37);
            this.cmbBaudRate.TabIndex = 34;
            this.cmbBaudRate.SelectedIndexChanged += new System.EventHandler(this.cmbBaudRate_SelectedIndexChanged);
            // 
            // cmbParity
            // 
            this.cmbParity.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.cmbParity.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cmbParity.Font = new System.Drawing.Font("Microsoft Sans Serif", 18F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(222)));
            this.cmbParity.FormattingEnabled = true;
            this.cmbParity.Location = new System.Drawing.Point(211, 220);
            this.cmbParity.Name = "cmbParity";
            this.cmbParity.Size = new System.Drawing.Size(334, 37);
            this.cmbParity.TabIndex = 38;
            this.cmbParity.SelectedIndexChanged += new System.EventHandler(this.cmbParity_SelectedIndexChanged);
            // 
            // cmbDataBits
            // 
            this.cmbDataBits.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.cmbDataBits.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cmbDataBits.Font = new System.Drawing.Font("Microsoft Sans Serif", 18F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(222)));
            this.cmbDataBits.FormattingEnabled = true;
            this.cmbDataBits.Location = new System.Drawing.Point(211, 177);
            this.cmbDataBits.Name = "cmbDataBits";
            this.cmbDataBits.Size = new System.Drawing.Size(334, 37);
            this.cmbDataBits.TabIndex = 40;
            this.cmbDataBits.SelectedIndexChanged += new System.EventHandler(this.cmbDataBits_SelectedIndexChanged);
            // 
            // cmbStopBits
            // 
            this.cmbStopBits.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.cmbStopBits.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cmbStopBits.Font = new System.Drawing.Font("Microsoft Sans Serif", 18F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(222)));
            this.cmbStopBits.FormattingEnabled = true;
            this.cmbStopBits.Location = new System.Drawing.Point(211, 263);
            this.cmbStopBits.Name = "cmbStopBits";
            this.cmbStopBits.Size = new System.Drawing.Size(334, 37);
            this.cmbStopBits.TabIndex = 36;
            this.cmbStopBits.SelectedIndexChanged += new System.EventHandler(this.cmbStopBits_SelectedIndexChanged);
            // 
            // cmbDeviceName
            // 
            this.cmbDeviceName.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.cmbDeviceName.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cmbDeviceName.Font = new System.Drawing.Font("Microsoft Sans Serif", 18F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(222)));
            this.cmbDeviceName.FormattingEnabled = true;
            this.cmbDeviceName.Location = new System.Drawing.Point(211, 91);
            this.cmbDeviceName.Name = "cmbDeviceName";
            this.cmbDeviceName.Size = new System.Drawing.Size(334, 37);
            this.cmbDeviceName.TabIndex = 42;
            this.cmbDeviceName.SelectedIndexChanged += new System.EventHandler(this.cmbDeviceName_SelectedIndexChanged);
            // 
            // lblDeviceName
            // 
            this.lblDeviceName.Font = new System.Drawing.Font("Microsoft Sans Serif", 21.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(222)));
            this.lblDeviceName.ForeColor = System.Drawing.Color.White;
            this.lblDeviceName.Location = new System.Drawing.Point(3, 90);
            this.lblDeviceName.Name = "lblDeviceName";
            this.lblDeviceName.Size = new System.Drawing.Size(202, 33);
            this.lblDeviceName.TabIndex = 41;
            this.lblDeviceName.Text = "Device Name";
            this.lblDeviceName.TextAlign = System.Drawing.ContentAlignment.TopRight;
            // 
            // btnDelaySetZero
            // 
            this.btnDelaySetZero.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.btnDelaySetZero.BackgroundImageLayout = System.Windows.Forms.ImageLayout.Center;
            this.btnDelaySetZero.FlatStyle = System.Windows.Forms.FlatStyle.Popup;
            this.btnDelaySetZero.Font = new System.Drawing.Font("Microsoft Sans Serif", 18F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(222)));
            this.btnDelaySetZero.ForeColor = System.Drawing.Color.Black;
            this.btnDelaySetZero.Location = new System.Drawing.Point(308, 306);
            this.btnDelaySetZero.Name = "btnDelaySetZero";
            this.btnDelaySetZero.Size = new System.Drawing.Size(75, 35);
            this.btnDelaySetZero.TabIndex = 45;
            this.btnDelaySetZero.Text = "0";
            this.btnDelaySetZero.TextAlign = System.Drawing.ContentAlignment.BottomCenter;
            this.btnDelaySetZero.Click += new System.EventHandler(this.btnDelaySetZero_Click);
            // 
            // lblDelay
            // 
            this.lblDelay.Font = new System.Drawing.Font("Microsoft Sans Serif", 21.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(222)));
            this.lblDelay.ForeColor = System.Drawing.Color.White;
            this.lblDelay.Location = new System.Drawing.Point(3, 304);
            this.lblDelay.Name = "lblDelay";
            this.lblDelay.Size = new System.Drawing.Size(202, 33);
            this.lblDelay.TabIndex = 43;
            this.lblDelay.Text = "Delay (sec.)";
            this.lblDelay.TextAlign = System.Drawing.ContentAlignment.TopRight;
            // 
            // btnDelayPlusZeroPointFive
            // 
            this.btnDelayPlusZeroPointFive.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.btnDelayPlusZeroPointFive.BackgroundImageLayout = System.Windows.Forms.ImageLayout.Center;
            this.btnDelayPlusZeroPointFive.FlatStyle = System.Windows.Forms.FlatStyle.Popup;
            this.btnDelayPlusZeroPointFive.Font = new System.Drawing.Font("Microsoft Sans Serif", 18F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(222)));
            this.btnDelayPlusZeroPointFive.ForeColor = System.Drawing.Color.Black;
            this.btnDelayPlusZeroPointFive.Location = new System.Drawing.Point(389, 306);
            this.btnDelayPlusZeroPointFive.Name = "btnDelayPlusZeroPointFive";
            this.btnDelayPlusZeroPointFive.Size = new System.Drawing.Size(75, 35);
            this.btnDelayPlusZeroPointFive.TabIndex = 46;
            this.btnDelayPlusZeroPointFive.Text = "+0.5";
            this.btnDelayPlusZeroPointFive.TextAlign = System.Drawing.ContentAlignment.BottomCenter;
            this.btnDelayPlusZeroPointFive.Click += new System.EventHandler(this.btnDelayPlusZeroPointFive_Click);
            // 
            // txtDelay
            // 
            this.txtDelay.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.txtDelay.DecimalPlaces = 1;
            this.txtDelay.Font = new System.Drawing.Font("Microsoft Sans Serif", 18F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(222)));
            this.txtDelay.Location = new System.Drawing.Point(211, 306);
            this.txtDelay.Maximum = new decimal(new int[] {
            10,
            0,
            0,
            0});
            this.txtDelay.Name = "txtDelay";
            this.txtDelay.Size = new System.Drawing.Size(91, 35);
            this.txtDelay.TabIndex = 44;
            this.txtDelay.ValueChanged += new System.EventHandler(this.txtDelay_ValueChanged);
            // 
            // btnDelayPlusOne
            // 
            this.btnDelayPlusOne.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.btnDelayPlusOne.BackgroundImageLayout = System.Windows.Forms.ImageLayout.Center;
            this.btnDelayPlusOne.FlatStyle = System.Windows.Forms.FlatStyle.Popup;
            this.btnDelayPlusOne.Font = new System.Drawing.Font("Microsoft Sans Serif", 18F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(222)));
            this.btnDelayPlusOne.ForeColor = System.Drawing.Color.Black;
            this.btnDelayPlusOne.Location = new System.Drawing.Point(470, 306);
            this.btnDelayPlusOne.Name = "btnDelayPlusOne";
            this.btnDelayPlusOne.Size = new System.Drawing.Size(75, 35);
            this.btnDelayPlusOne.TabIndex = 47;
            this.btnDelayPlusOne.Text = "+1";
            this.btnDelayPlusOne.TextAlign = System.Drawing.ContentAlignment.BottomCenter;
            this.btnDelayPlusOne.Click += new System.EventHandler(this.btnDelayPlusOne_Click);
            // 
            // lblIsActived
            // 
            this.lblIsActived.Font = new System.Drawing.Font("Microsoft Sans Serif", 21.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(222)));
            this.lblIsActived.ForeColor = System.Drawing.Color.White;
            this.lblIsActived.Location = new System.Drawing.Point(3, 47);
            this.lblIsActived.Name = "lblIsActived";
            this.lblIsActived.Size = new System.Drawing.Size(202, 33);
            this.lblIsActived.TabIndex = 50;
            this.lblIsActived.Text = "Is Active";
            this.lblIsActived.TextAlign = System.Drawing.ContentAlignment.TopRight;
            // 
            // lblEnableTrace
            // 
            this.lblEnableTrace.Font = new System.Drawing.Font("Microsoft Sans Serif", 21.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(222)));
            this.lblEnableTrace.ForeColor = System.Drawing.Color.White;
            this.lblEnableTrace.Location = new System.Drawing.Point(3, 348);
            this.lblEnableTrace.Name = "lblEnableTrace";
            this.lblEnableTrace.Size = new System.Drawing.Size(202, 33);
            this.lblEnableTrace.TabIndex = 53;
            this.lblEnableTrace.Text = "Enable Trace";
            this.lblEnableTrace.TextAlign = System.Drawing.ContentAlignment.TopRight;
            // 
            // chkEnableTrace
            // 
            this.chkEnableTrace.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.chkEnableTrace.BackgroundImageLayout = System.Windows.Forms.ImageLayout.None;
            this.chkEnableTrace.Checked = false;
            this.chkEnableTrace.DisplayText = "";
            this.chkEnableTrace.Location = new System.Drawing.Point(211, 349);
            this.chkEnableTrace.MinimumSize = new System.Drawing.Size(0, 33);
            this.chkEnableTrace.Name = "chkEnableTrace";
            this.chkEnableTrace.Size = new System.Drawing.Size(334, 37);
            this.chkEnableTrace.TabIndex = 52;
            this.chkEnableTrace.CheckedChanged += new MDI.Forms.ctrlCheckbox.EventCheckedChanged(this.chkEnableTrace_CheckedChanged);
            // 
            // chkIsActive
            // 
            this.chkIsActive.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.chkIsActive.BackgroundImageLayout = System.Windows.Forms.ImageLayout.None;
            this.chkIsActive.Checked = false;
            this.chkIsActive.DisplayText = "";
            this.chkIsActive.Location = new System.Drawing.Point(211, 48);
            this.chkIsActive.MinimumSize = new System.Drawing.Size(0, 33);
            this.chkIsActive.Name = "chkIsActive";
            this.chkIsActive.Size = new System.Drawing.Size(334, 37);
            this.chkIsActive.TabIndex = 48;
            this.chkIsActive.CheckedChanged += new MDI.Forms.ctrlCheckbox.EventCheckedChanged(this.chkIsActive_CheckedChanged);
            // 
            // chkWeight
            // 
            this.chkWeight.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.chkWeight.BackgroundImageLayout = System.Windows.Forms.ImageLayout.None;
            this.chkWeight.Checked = false;
            this.chkWeight.DisplayText = "Weight";
            this.chkWeight.Location = new System.Drawing.Point(3, 3);
            this.chkWeight.MinimumSize = new System.Drawing.Size(0, 33);
            this.chkWeight.Name = "chkWeight";
            this.chkWeight.Size = new System.Drawing.Size(275, 37);
            this.chkWeight.TabIndex = 54;
            this.chkWeight.CheckedChanged += new MDI.Forms.ctrlCheckbox.EventCheckedChanged(this.chkWeight_CheckedChanged);
            // 
            // chkHeight
            // 
            this.chkHeight.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.chkHeight.BackgroundImageLayout = System.Windows.Forms.ImageLayout.None;
            this.chkHeight.Checked = false;
            this.chkHeight.DisplayText = "Height";
            this.chkHeight.Location = new System.Drawing.Point(3, 46);
            this.chkHeight.MinimumSize = new System.Drawing.Size(0, 33);
            this.chkHeight.Name = "chkHeight";
            this.chkHeight.Size = new System.Drawing.Size(275, 37);
            this.chkHeight.TabIndex = 55;
            this.chkHeight.CheckedChanged += new MDI.Forms.ctrlCheckbox.EventCheckedChanged(this.chkHeight_CheckedChanged);
            // 
            // chkPulseRate
            // 
            this.chkPulseRate.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.chkPulseRate.BackgroundImageLayout = System.Windows.Forms.ImageLayout.None;
            this.chkPulseRate.Checked = false;
            this.chkPulseRate.DisplayText = "Pulse Rate";
            this.chkPulseRate.Location = new System.Drawing.Point(3, 132);
            this.chkPulseRate.MinimumSize = new System.Drawing.Size(0, 33);
            this.chkPulseRate.Name = "chkPulseRate";
            this.chkPulseRate.Size = new System.Drawing.Size(275, 37);
            this.chkPulseRate.TabIndex = 57;
            this.chkPulseRate.CheckedChanged += new MDI.Forms.ctrlCheckbox.EventCheckedChanged(this.chkPulseRate_CheckedChanged);
            // 
            // chkBmi
            // 
            this.chkBmi.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.chkBmi.BackgroundImageLayout = System.Windows.Forms.ImageLayout.None;
            this.chkBmi.Checked = false;
            this.chkBmi.DisplayText = "BMI";
            this.chkBmi.Location = new System.Drawing.Point(3, 89);
            this.chkBmi.MinimumSize = new System.Drawing.Size(0, 33);
            this.chkBmi.Name = "chkBmi";
            this.chkBmi.Size = new System.Drawing.Size(275, 37);
            this.chkBmi.TabIndex = 56;
            this.chkBmi.CheckedChanged += new MDI.Forms.ctrlCheckbox.EventCheckedChanged(this.chkBmi_CheckedChanged);
            // 
            // chkBloodPressure
            // 
            this.chkBloodPressure.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.chkBloodPressure.BackgroundImageLayout = System.Windows.Forms.ImageLayout.None;
            this.chkBloodPressure.Checked = false;
            this.chkBloodPressure.DisplayText = "Blood Pressure";
            this.chkBloodPressure.Location = new System.Drawing.Point(3, 175);
            this.chkBloodPressure.MinimumSize = new System.Drawing.Size(0, 33);
            this.chkBloodPressure.Name = "chkBloodPressure";
            this.chkBloodPressure.Size = new System.Drawing.Size(275, 37);
            this.chkBloodPressure.TabIndex = 58;
            this.chkBloodPressure.CheckedChanged += new MDI.Forms.ctrlCheckbox.EventCheckedChanged(this.chkBloodPressureSystolic_CheckedChanged);
            // 
            // chkSpO2
            // 
            this.chkSpO2.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.chkSpO2.BackgroundImageLayout = System.Windows.Forms.ImageLayout.None;
            this.chkSpO2.Checked = false;
            this.chkSpO2.DisplayText = "SpO2";
            this.chkSpO2.Location = new System.Drawing.Point(3, 218);
            this.chkSpO2.MinimumSize = new System.Drawing.Size(0, 33);
            this.chkSpO2.Name = "chkSpO2";
            this.chkSpO2.Size = new System.Drawing.Size(275, 37);
            this.chkSpO2.TabIndex = 61;
            this.chkSpO2.CheckedChanged += new MDI.Forms.ctrlCheckbox.EventCheckedChanged(this.chkSpO2_CheckedChanged);
            // 
            // chkBloodGlucose
            // 
            this.chkBloodGlucose.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.chkBloodGlucose.BackgroundImageLayout = System.Windows.Forms.ImageLayout.None;
            this.chkBloodGlucose.Checked = false;
            this.chkBloodGlucose.DisplayText = "Blood Glucose";
            this.chkBloodGlucose.Location = new System.Drawing.Point(3, 304);
            this.chkBloodGlucose.MinimumSize = new System.Drawing.Size(0, 33);
            this.chkBloodGlucose.Name = "chkBloodGlucose";
            this.chkBloodGlucose.Size = new System.Drawing.Size(275, 37);
            this.chkBloodGlucose.TabIndex = 63;
            this.chkBloodGlucose.CheckedChanged += new MDI.Forms.ctrlCheckbox.EventCheckedChanged(this.chkBloodGlucose_CheckedChanged);
            // 
            // chkTemperature
            // 
            this.chkTemperature.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.chkTemperature.BackgroundImageLayout = System.Windows.Forms.ImageLayout.None;
            this.chkTemperature.Checked = false;
            this.chkTemperature.DisplayText = "Temperature";
            this.chkTemperature.Location = new System.Drawing.Point(3, 261);
            this.chkTemperature.MinimumSize = new System.Drawing.Size(0, 33);
            this.chkTemperature.Name = "chkTemperature";
            this.chkTemperature.Size = new System.Drawing.Size(275, 37);
            this.chkTemperature.TabIndex = 62;
            this.chkTemperature.CheckedChanged += new MDI.Forms.ctrlCheckbox.EventCheckedChanged(this.chkTemperature_CheckedChanged);
            // 
            // chkPainScale
            // 
            this.chkPainScale.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.chkPainScale.BackgroundImageLayout = System.Windows.Forms.ImageLayout.None;
            this.chkPainScale.Checked = false;
            this.chkPainScale.DisplayText = "Pain Scale";
            this.chkPainScale.Location = new System.Drawing.Point(3, 390);
            this.chkPainScale.MinimumSize = new System.Drawing.Size(0, 33);
            this.chkPainScale.Name = "chkPainScale";
            this.chkPainScale.Size = new System.Drawing.Size(275, 37);
            this.chkPainScale.TabIndex = 65;
            this.chkPainScale.CheckedChanged += new MDI.Forms.ctrlCheckbox.EventCheckedChanged(this.chkPainScale_CheckedChanged);
            // 
            // chkRespirationRate
            // 
            this.chkRespirationRate.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Right)));
            this.chkRespirationRate.BackgroundImageLayout = System.Windows.Forms.ImageLayout.None;
            this.chkRespirationRate.Checked = false;
            this.chkRespirationRate.DisplayText = "Respirations";
            this.chkRespirationRate.Location = new System.Drawing.Point(3, 347);
            this.chkRespirationRate.MinimumSize = new System.Drawing.Size(0, 33);
            this.chkRespirationRate.Name = "chkRespirationRate";
            this.chkRespirationRate.Size = new System.Drawing.Size(275, 37);
            this.chkRespirationRate.TabIndex = 64;
            this.chkRespirationRate.CheckedChanged += new MDI.Forms.ctrlCheckbox.EventCheckedChanged(this.chkRespirationRate_CheckedChanged);
            // 
            // pnlDeviceSetting
            // 
            this.pnlDeviceSetting.Controls.Add(this.lblPortName);
            this.pnlDeviceSetting.Controls.Add(this.btnDelayPlusOne);
            this.pnlDeviceSetting.Controls.Add(this.lblEnableTrace);
            this.pnlDeviceSetting.Controls.Add(this.txtDelay);
            this.pnlDeviceSetting.Controls.Add(this.chkEnableTrace);
            this.pnlDeviceSetting.Controls.Add(this.btnDelayPlusZeroPointFive);
            this.pnlDeviceSetting.Controls.Add(this.lblIsActived);
            this.pnlDeviceSetting.Controls.Add(this.lblDelay);
            this.pnlDeviceSetting.Controls.Add(this.chkIsActive);
            this.pnlDeviceSetting.Controls.Add(this.btnDelaySetZero);
            this.pnlDeviceSetting.Controls.Add(this.lblDeviceName);
            this.pnlDeviceSetting.Controls.Add(this.lblBaudRate);
            this.pnlDeviceSetting.Controls.Add(this.cmbDeviceName);
            this.pnlDeviceSetting.Controls.Add(this.lblDataBits);
            this.pnlDeviceSetting.Controls.Add(this.cmbStopBits);
            this.pnlDeviceSetting.Controls.Add(this.lblParity);
            this.pnlDeviceSetting.Controls.Add(this.cmbDataBits);
            this.pnlDeviceSetting.Controls.Add(this.lblStopBits);
            this.pnlDeviceSetting.Controls.Add(this.cmbParity);
            this.pnlDeviceSetting.Controls.Add(this.cmbPortName);
            this.pnlDeviceSetting.Controls.Add(this.cmbBaudRate);
            this.pnlDeviceSetting.Location = new System.Drawing.Point(3, 3);
            this.pnlDeviceSetting.Name = "pnlDeviceSetting";
            this.pnlDeviceSetting.Size = new System.Drawing.Size(550, 389);
            this.pnlDeviceSetting.TabIndex = 67;
            // 
            // pnlDeviceAcceptData
            // 
            this.pnlDeviceAcceptData.Controls.Add(this.chkWeight);
            this.pnlDeviceAcceptData.Controls.Add(this.chkHeight);
            this.pnlDeviceAcceptData.Controls.Add(this.chkPainScale);
            this.pnlDeviceAcceptData.Controls.Add(this.chkBmi);
            this.pnlDeviceAcceptData.Controls.Add(this.chkRespirationRate);
            this.pnlDeviceAcceptData.Controls.Add(this.chkPulseRate);
            this.pnlDeviceAcceptData.Controls.Add(this.chkBloodGlucose);
            this.pnlDeviceAcceptData.Controls.Add(this.chkBloodPressure);
            this.pnlDeviceAcceptData.Controls.Add(this.chkTemperature);
            this.pnlDeviceAcceptData.Controls.Add(this.chkSpO2);
            this.pnlDeviceAcceptData.Location = new System.Drawing.Point(559, 3);
            this.pnlDeviceAcceptData.Name = "pnlDeviceAcceptData";
            this.pnlDeviceAcceptData.Size = new System.Drawing.Size(550, 430);
            this.pnlDeviceAcceptData.TabIndex = 68;
            // 
            // flowLayoutPanel
            // 
            this.flowLayoutPanel.Controls.Add(this.pnlDeviceSetting);
            this.flowLayoutPanel.Controls.Add(this.pnlDeviceAcceptData);
            this.flowLayoutPanel.Dock = System.Windows.Forms.DockStyle.Fill;
            this.flowLayoutPanel.FlowDirection = System.Windows.Forms.FlowDirection.TopDown;
            this.flowLayoutPanel.Location = new System.Drawing.Point(0, 0);
            this.flowLayoutPanel.Name = "flowLayoutPanel";
            this.flowLayoutPanel.Size = new System.Drawing.Size(1109, 593);
            this.flowLayoutPanel.TabIndex = 69;
            // 
            // ctrlSettingDevice
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.DodgerBlue;
            this.Controls.Add(this.flowLayoutPanel);
            this.Name = "ctrlSettingDevice";
            this.Size = new System.Drawing.Size(1109, 593);
            ((System.ComponentModel.ISupportInitialize)(this.txtDelay)).EndInit();
            this.pnlDeviceSetting.ResumeLayout(false);
            this.pnlDeviceAcceptData.ResumeLayout(false);
            this.flowLayoutPanel.ResumeLayout(false);
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.Label lblPortName;
        private System.Windows.Forms.Label lblBaudRate;
        private System.Windows.Forms.Label lblDataBits;
        private System.Windows.Forms.Label lblParity;
        private System.Windows.Forms.Label lblStopBits;
        private System.Windows.Forms.ComboBox cmbPortName;
        private System.Windows.Forms.ComboBox cmbBaudRate;
        private System.Windows.Forms.ComboBox cmbParity;
        private System.Windows.Forms.ComboBox cmbDataBits;
        private System.Windows.Forms.ComboBox cmbStopBits;
        private System.Windows.Forms.ComboBox cmbDeviceName;
        private System.Windows.Forms.Label lblDeviceName;
        private System.Windows.Forms.Button btnDelaySetZero;
        private System.Windows.Forms.Label lblDelay;
        private System.Windows.Forms.Button btnDelayPlusZeroPointFive;
        private System.Windows.Forms.NumericUpDown txtDelay;
        private System.Windows.Forms.Button btnDelayPlusOne;
        private ctrlCheckbox chkIsActive;
        private System.Windows.Forms.Label lblIsActived;
        private ctrlCheckbox chkEnableTrace;
        private System.Windows.Forms.Label lblEnableTrace;
        private ctrlCheckbox chkWeight;
        private ctrlCheckbox chkHeight;
        private ctrlCheckbox chkPulseRate;
        private ctrlCheckbox chkBmi;
        private ctrlCheckbox chkBloodPressure;
        private ctrlCheckbox chkSpO2;
        private ctrlCheckbox chkBloodGlucose;
        private ctrlCheckbox chkTemperature;
        private ctrlCheckbox chkPainScale;
        private ctrlCheckbox chkRespirationRate;
        private System.Windows.Forms.Panel pnlDeviceSetting;
        private System.Windows.Forms.Panel pnlDeviceAcceptData;
        private System.Windows.Forms.FlowLayoutPanel flowLayoutPanel;
    }
}
