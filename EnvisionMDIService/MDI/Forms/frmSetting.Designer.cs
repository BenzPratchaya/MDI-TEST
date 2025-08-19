namespace MDI.Forms
{
    partial class frmSetting
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
            MDI.Entity.ModalityDeviceConfig modalityDeviceConfig11 = new MDI.Entity.ModalityDeviceConfig();
            MDI.Entity.ModalityDeviceConfig modalityDeviceConfig12 = new MDI.Entity.ModalityDeviceConfig();
            MDI.Entity.ModalityHnPadConfig modalityHnPadConfig6 = new MDI.Entity.ModalityHnPadConfig();
            this.pnlMain = new System.Windows.Forms.Panel();
            this.btnShutdown = new System.Windows.Forms.Button();
            this.btnRestart = new System.Windows.Forms.Button();
            this.pnlSetting = new System.Windows.Forms.Panel();
            this.btnSettingDevice2 = new System.Windows.Forms.Button();
            this.btnSettingGeneral = new System.Windows.Forms.Button();
            this.btnSettingDevice1 = new System.Windows.Forms.Button();
            this.btnSettingHnPad = new System.Windows.Forms.Button();
            this.pnlSettingGeneral = new System.Windows.Forms.Panel();
            this.lblShutdownTime = new System.Windows.Forms.Label();
            this.txtShutdownTime = new System.Windows.Forms.TextBox();
            this.lblModalityUid = new System.Windows.Forms.Label();
            this.txtModalityUid = new System.Windows.Forms.TextBox();
            this.lblMdiSocketPort = new System.Windows.Forms.Label();
            this.txtMdiSocketPort = new System.Windows.Forms.NumericUpDown();
            this.lblMdiSocketIp = new System.Windows.Forms.Label();
            this.txtMdiSocketIp = new System.Windows.Forms.TextBox();
            this.lblUrlConnection = new System.Windows.Forms.Label();
            this.lblCountdownAutoSave = new System.Windows.Forms.Label();
            this.btnCountdownAutoSaveSetZero = new System.Windows.Forms.Button();
            this.txtUrlConnection = new System.Windows.Forms.TextBox();
            this.btnCountdownAutoSavePlusFive = new System.Windows.Forms.Button();
            this.txtAutoSaveSeconds = new System.Windows.Forms.NumericUpDown();
            this.btnCountdownAutoSavePlusTen = new System.Windows.Forms.Button();
            this.pnlSettingDevice2 = new MDI.Forms.ctrlSettingDevice();
            this.pnlSettingDevice1 = new MDI.Forms.ctrlSettingDevice();
            this.pnlSettinghnPad = new MDI.Forms.ctrlSettingHnPad();
            this.btnSaveConfig = new System.Windows.Forms.Button();
            this.btnPageBack = new System.Windows.Forms.Button();
            this.btnNetworkConnections = new System.Windows.Forms.Button();
            this.btnWinOnScreenKeyboard = new System.Windows.Forms.Button();
            this.pnlMain.SuspendLayout();
            this.pnlSetting.SuspendLayout();
            this.pnlSettingGeneral.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.txtMdiSocketPort)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.txtAutoSaveSeconds)).BeginInit();
            this.SuspendLayout();
            // 
            // pnlMain
            // 
            this.pnlMain.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.pnlMain.BackColor = System.Drawing.Color.DeepSkyBlue;
            this.pnlMain.Controls.Add(this.btnShutdown);
            this.pnlMain.Controls.Add(this.btnRestart);
            this.pnlMain.Controls.Add(this.pnlSetting);
            this.pnlMain.Controls.Add(this.btnSaveConfig);
            this.pnlMain.Controls.Add(this.btnPageBack);
            this.pnlMain.Controls.Add(this.btnNetworkConnections);
            this.pnlMain.Controls.Add(this.btnWinOnScreenKeyboard);
            this.pnlMain.Location = new System.Drawing.Point(12, 12);
            this.pnlMain.Name = "pnlMain";
            this.pnlMain.Size = new System.Drawing.Size(1261, 716);
            this.pnlMain.TabIndex = 0;
            // 
            // btnShutdown
            // 
            this.btnShutdown.Anchor = System.Windows.Forms.AnchorStyles.Bottom;
            this.btnShutdown.BackgroundImage = global::MDI.Properties.Resources.shutdown_64;
            this.btnShutdown.BackgroundImageLayout = System.Windows.Forms.ImageLayout.Center;
            this.btnShutdown.FlatStyle = System.Windows.Forms.FlatStyle.Popup;
            this.btnShutdown.Font = new System.Drawing.Font("Microsoft Sans Serif", 9F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(222)));
            this.btnShutdown.ForeColor = System.Drawing.Color.Black;
            this.btnShutdown.Image = global::MDI.Properties.Resources.windows_16;
            this.btnShutdown.ImageAlign = System.Drawing.ContentAlignment.TopLeft;
            this.btnShutdown.Location = new System.Drawing.Point(428, 617);
            this.btnShutdown.Name = "btnShutdown";
            this.btnShutdown.Size = new System.Drawing.Size(96, 96);
            this.btnShutdown.TabIndex = 50;
            this.btnShutdown.Text = "SHUTDOWN";
            this.btnShutdown.TextAlign = System.Drawing.ContentAlignment.BottomCenter;
            this.btnShutdown.UseVisualStyleBackColor = false;
            this.btnShutdown.Click += new System.EventHandler(this.btnShutdown_Click);
            // 
            // btnRestart
            // 
            this.btnRestart.Anchor = System.Windows.Forms.AnchorStyles.Bottom;
            this.btnRestart.BackgroundImage = global::MDI.Properties.Resources.restart_64;
            this.btnRestart.BackgroundImageLayout = System.Windows.Forms.ImageLayout.Center;
            this.btnRestart.FlatStyle = System.Windows.Forms.FlatStyle.Popup;
            this.btnRestart.Font = new System.Drawing.Font("Microsoft Sans Serif", 9F, System.Drawing.FontStyle.Bold);
            this.btnRestart.ForeColor = System.Drawing.Color.Black;
            this.btnRestart.Image = global::MDI.Properties.Resources.windows_16;
            this.btnRestart.ImageAlign = System.Drawing.ContentAlignment.TopLeft;
            this.btnRestart.Location = new System.Drawing.Point(530, 617);
            this.btnRestart.Name = "btnRestart";
            this.btnRestart.Size = new System.Drawing.Size(96, 96);
            this.btnRestart.TabIndex = 51;
            this.btnRestart.Text = "RESTART";
            this.btnRestart.TextAlign = System.Drawing.ContentAlignment.BottomCenter;
            this.btnRestart.UseVisualStyleBackColor = false;
            this.btnRestart.Click += new System.EventHandler(this.btnRestart_Click);
            // 
            // pnlSetting
            // 
            this.pnlSetting.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.pnlSetting.BackColor = System.Drawing.Color.White;
            this.pnlSetting.Controls.Add(this.btnSettingDevice2);
            this.pnlSetting.Controls.Add(this.btnSettingGeneral);
            this.pnlSetting.Controls.Add(this.btnSettingDevice1);
            this.pnlSetting.Controls.Add(this.btnSettingHnPad);
            this.pnlSetting.Controls.Add(this.pnlSettingGeneral);
            this.pnlSetting.Controls.Add(this.pnlSettingDevice2);
            this.pnlSetting.Controls.Add(this.pnlSettingDevice1);
            this.pnlSetting.Controls.Add(this.pnlSettinghnPad);
            this.pnlSetting.Location = new System.Drawing.Point(3, 3);
            this.pnlSetting.Name = "pnlSetting";
            this.pnlSetting.Size = new System.Drawing.Size(1255, 609);
            this.pnlSetting.TabIndex = 49;
            // 
            // btnSettingDevice2
            // 
            this.btnSettingDevice2.AutoSize = true;
            this.btnSettingDevice2.BackColor = System.Drawing.Color.DodgerBlue;
            this.btnSettingDevice2.BackgroundImageLayout = System.Windows.Forms.ImageLayout.Center;
            this.btnSettingDevice2.FlatStyle = System.Windows.Forms.FlatStyle.Popup;
            this.btnSettingDevice2.Font = new System.Drawing.Font("Microsoft Sans Serif", 9F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(222)));
            this.btnSettingDevice2.ForeColor = System.Drawing.Color.Black;
            this.btnSettingDevice2.Location = new System.Drawing.Point(6, 312);
            this.btnSettingDevice2.Name = "btnSettingDevice2";
            this.btnSettingDevice2.Size = new System.Drawing.Size(128, 96);
            this.btnSettingDevice2.TabIndex = 52;
            this.btnSettingDevice2.Text = "DEVICE 2";
            this.btnSettingDevice2.UseVisualStyleBackColor = false;
            this.btnSettingDevice2.Click += new System.EventHandler(this.btnSettingDevice2_Click);
            // 
            // btnSettingGeneral
            // 
            this.btnSettingGeneral.AutoSize = true;
            this.btnSettingGeneral.BackColor = System.Drawing.Color.DodgerBlue;
            this.btnSettingGeneral.BackgroundImageLayout = System.Windows.Forms.ImageLayout.Center;
            this.btnSettingGeneral.FlatStyle = System.Windows.Forms.FlatStyle.Popup;
            this.btnSettingGeneral.Font = new System.Drawing.Font("Microsoft Sans Serif", 9F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(222)));
            this.btnSettingGeneral.ForeColor = System.Drawing.Color.Black;
            this.btnSettingGeneral.Location = new System.Drawing.Point(6, 6);
            this.btnSettingGeneral.Name = "btnSettingGeneral";
            this.btnSettingGeneral.Size = new System.Drawing.Size(128, 96);
            this.btnSettingGeneral.TabIndex = 45;
            this.btnSettingGeneral.Text = "GENERAL";
            this.btnSettingGeneral.UseVisualStyleBackColor = false;
            this.btnSettingGeneral.Click += new System.EventHandler(this.btnSettingGeneral_Click);
            // 
            // btnSettingDevice1
            // 
            this.btnSettingDevice1.AutoSize = true;
            this.btnSettingDevice1.BackColor = System.Drawing.Color.DodgerBlue;
            this.btnSettingDevice1.BackgroundImageLayout = System.Windows.Forms.ImageLayout.Center;
            this.btnSettingDevice1.FlatStyle = System.Windows.Forms.FlatStyle.Popup;
            this.btnSettingDevice1.Font = new System.Drawing.Font("Microsoft Sans Serif", 9F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(222)));
            this.btnSettingDevice1.ForeColor = System.Drawing.Color.Black;
            this.btnSettingDevice1.Location = new System.Drawing.Point(6, 210);
            this.btnSettingDevice1.Name = "btnSettingDevice1";
            this.btnSettingDevice1.Size = new System.Drawing.Size(128, 96);
            this.btnSettingDevice1.TabIndex = 51;
            this.btnSettingDevice1.Text = "DEVICE 1";
            this.btnSettingDevice1.UseVisualStyleBackColor = false;
            this.btnSettingDevice1.Click += new System.EventHandler(this.btnSettingDevice1_Click);
            // 
            // btnSettingHnPad
            // 
            this.btnSettingHnPad.AutoSize = true;
            this.btnSettingHnPad.BackColor = System.Drawing.Color.DodgerBlue;
            this.btnSettingHnPad.BackgroundImageLayout = System.Windows.Forms.ImageLayout.Center;
            this.btnSettingHnPad.FlatStyle = System.Windows.Forms.FlatStyle.Popup;
            this.btnSettingHnPad.Font = new System.Drawing.Font("Microsoft Sans Serif", 9F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(222)));
            this.btnSettingHnPad.ForeColor = System.Drawing.Color.Black;
            this.btnSettingHnPad.Location = new System.Drawing.Point(6, 108);
            this.btnSettingHnPad.Name = "btnSettingHnPad";
            this.btnSettingHnPad.Size = new System.Drawing.Size(128, 96);
            this.btnSettingHnPad.TabIndex = 50;
            this.btnSettingHnPad.Text = "HN PAD";
            this.btnSettingHnPad.UseVisualStyleBackColor = false;
            this.btnSettingHnPad.Click += new System.EventHandler(this.btnSettingHnPad_Click);
            // 
            // pnlSettingGeneral
            // 
            this.pnlSettingGeneral.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.pnlSettingGeneral.BackColor = System.Drawing.Color.DodgerBlue;
            this.pnlSettingGeneral.Controls.Add(this.lblShutdownTime);
            this.pnlSettingGeneral.Controls.Add(this.txtShutdownTime);
            this.pnlSettingGeneral.Controls.Add(this.lblModalityUid);
            this.pnlSettingGeneral.Controls.Add(this.txtModalityUid);
            this.pnlSettingGeneral.Controls.Add(this.lblMdiSocketPort);
            this.pnlSettingGeneral.Controls.Add(this.txtMdiSocketPort);
            this.pnlSettingGeneral.Controls.Add(this.lblMdiSocketIp);
            this.pnlSettingGeneral.Controls.Add(this.txtMdiSocketIp);
            this.pnlSettingGeneral.Controls.Add(this.lblUrlConnection);
            this.pnlSettingGeneral.Controls.Add(this.lblCountdownAutoSave);
            this.pnlSettingGeneral.Controls.Add(this.btnCountdownAutoSaveSetZero);
            this.pnlSettingGeneral.Controls.Add(this.txtUrlConnection);
            this.pnlSettingGeneral.Controls.Add(this.btnCountdownAutoSavePlusFive);
            this.pnlSettingGeneral.Controls.Add(this.txtAutoSaveSeconds);
            this.pnlSettingGeneral.Controls.Add(this.btnCountdownAutoSavePlusTen);
            this.pnlSettingGeneral.Location = new System.Drawing.Point(140, 6);
            this.pnlSettingGeneral.Name = "pnlSettingGeneral";
            this.pnlSettingGeneral.Size = new System.Drawing.Size(1109, 593);
            this.pnlSettingGeneral.TabIndex = 53;
            // 
            // lblShutdownTime
            // 
            this.lblShutdownTime.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)));
            this.lblShutdownTime.Font = new System.Drawing.Font("Microsoft Sans Serif", 21.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(222)));
            this.lblShutdownTime.Location = new System.Drawing.Point(9, 554);
            this.lblShutdownTime.Name = "lblShutdownTime";
            this.lblShutdownTime.Size = new System.Drawing.Size(246, 33);
            this.lblShutdownTime.TabIndex = 18;
            this.lblShutdownTime.Text = "Shutdown Time";
            this.lblShutdownTime.TextAlign = System.Drawing.ContentAlignment.TopRight;
            // 
            // txtShutdownTime
            // 
            this.txtShutdownTime.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.txtShutdownTime.Font = new System.Drawing.Font("Microsoft Sans Serif", 18F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(222)));
            this.txtShutdownTime.Location = new System.Drawing.Point(261, 555);
            this.txtShutdownTime.Name = "txtShutdownTime";
            this.txtShutdownTime.Size = new System.Drawing.Size(845, 35);
            this.txtShutdownTime.TabIndex = 19;
            this.txtShutdownTime.Text = "00:00";
            // 
            // lblModalityUid
            // 
            this.lblModalityUid.Font = new System.Drawing.Font("Microsoft Sans Serif", 21.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(222)));
            this.lblModalityUid.Location = new System.Drawing.Point(9, 2);
            this.lblModalityUid.Name = "lblModalityUid";
            this.lblModalityUid.Size = new System.Drawing.Size(246, 33);
            this.lblModalityUid.TabIndex = 14;
            this.lblModalityUid.Text = "Device Code";
            this.lblModalityUid.TextAlign = System.Drawing.ContentAlignment.TopRight;
            // 
            // txtModalityUid
            // 
            this.txtModalityUid.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.txtModalityUid.Font = new System.Drawing.Font("Microsoft Sans Serif", 18F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(222)));
            this.txtModalityUid.Location = new System.Drawing.Point(261, 3);
            this.txtModalityUid.Name = "txtModalityUid";
            this.txtModalityUid.Size = new System.Drawing.Size(845, 35);
            this.txtModalityUid.TabIndex = 15;
            // 
            // lblMdiSocketPort
            // 
            this.lblMdiSocketPort.Font = new System.Drawing.Font("Microsoft Sans Serif", 21.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(222)));
            this.lblMdiSocketPort.Location = new System.Drawing.Point(9, 247);
            this.lblMdiSocketPort.Name = "lblMdiSocketPort";
            this.lblMdiSocketPort.Size = new System.Drawing.Size(246, 33);
            this.lblMdiSocketPort.TabIndex = 12;
            this.lblMdiSocketPort.Text = "MDI Port";
            this.lblMdiSocketPort.TextAlign = System.Drawing.ContentAlignment.TopRight;
            // 
            // txtMdiSocketPort
            // 
            this.txtMdiSocketPort.Font = new System.Drawing.Font("Microsoft Sans Serif", 18F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(222)));
            this.txtMdiSocketPort.Location = new System.Drawing.Point(261, 249);
            this.txtMdiSocketPort.Maximum = new decimal(new int[] {
            10000,
            0,
            0,
            0});
            this.txtMdiSocketPort.Name = "txtMdiSocketPort";
            this.txtMdiSocketPort.Size = new System.Drawing.Size(98, 35);
            this.txtMdiSocketPort.TabIndex = 13;
            // 
            // lblMdiSocketIp
            // 
            this.lblMdiSocketIp.Font = new System.Drawing.Font("Microsoft Sans Serif", 21.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(222)));
            this.lblMdiSocketIp.Location = new System.Drawing.Point(9, 207);
            this.lblMdiSocketIp.Name = "lblMdiSocketIp";
            this.lblMdiSocketIp.Size = new System.Drawing.Size(246, 33);
            this.lblMdiSocketIp.TabIndex = 10;
            this.lblMdiSocketIp.Text = "MDI IP";
            this.lblMdiSocketIp.TextAlign = System.Drawing.ContentAlignment.TopRight;
            // 
            // txtMdiSocketIp
            // 
            this.txtMdiSocketIp.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.txtMdiSocketIp.Font = new System.Drawing.Font("Microsoft Sans Serif", 18F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(222)));
            this.txtMdiSocketIp.Location = new System.Drawing.Point(261, 208);
            this.txtMdiSocketIp.Name = "txtMdiSocketIp";
            this.txtMdiSocketIp.Size = new System.Drawing.Size(845, 35);
            this.txtMdiSocketIp.TabIndex = 11;
            // 
            // lblUrlConnection
            // 
            this.lblUrlConnection.Font = new System.Drawing.Font("Microsoft Sans Serif", 21.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(222)));
            this.lblUrlConnection.Location = new System.Drawing.Point(9, 84);
            this.lblUrlConnection.Name = "lblUrlConnection";
            this.lblUrlConnection.Size = new System.Drawing.Size(246, 33);
            this.lblUrlConnection.TabIndex = 3;
            this.lblUrlConnection.Text = "Url Connection";
            this.lblUrlConnection.TextAlign = System.Drawing.ContentAlignment.TopRight;
            // 
            // lblCountdownAutoSave
            // 
            this.lblCountdownAutoSave.Font = new System.Drawing.Font("Microsoft Sans Serif", 21.75F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(222)));
            this.lblCountdownAutoSave.Location = new System.Drawing.Point(9, 124);
            this.lblCountdownAutoSave.Name = "lblCountdownAutoSave";
            this.lblCountdownAutoSave.Size = new System.Drawing.Size(246, 33);
            this.lblCountdownAutoSave.TabIndex = 5;
            this.lblCountdownAutoSave.Text = "Auto Save (sec.)";
            this.lblCountdownAutoSave.TextAlign = System.Drawing.ContentAlignment.TopRight;
            // 
            // btnCountdownAutoSaveSetZero
            // 
            this.btnCountdownAutoSaveSetZero.BackgroundImageLayout = System.Windows.Forms.ImageLayout.Center;
            this.btnCountdownAutoSaveSetZero.FlatStyle = System.Windows.Forms.FlatStyle.Popup;
            this.btnCountdownAutoSaveSetZero.Font = new System.Drawing.Font("Microsoft Sans Serif", 18F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(222)));
            this.btnCountdownAutoSaveSetZero.ForeColor = System.Drawing.Color.Black;
            this.btnCountdownAutoSaveSetZero.Location = new System.Drawing.Point(365, 126);
            this.btnCountdownAutoSaveSetZero.Name = "btnCountdownAutoSaveSetZero";
            this.btnCountdownAutoSaveSetZero.Size = new System.Drawing.Size(75, 35);
            this.btnCountdownAutoSaveSetZero.TabIndex = 7;
            this.btnCountdownAutoSaveSetZero.Text = "0";
            this.btnCountdownAutoSaveSetZero.TextAlign = System.Drawing.ContentAlignment.BottomCenter;
            this.btnCountdownAutoSaveSetZero.Click += new System.EventHandler(this.btnCountdownAutoSaveSetZero_Click);
            // 
            // txtUrlConnection
            // 
            this.txtUrlConnection.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.txtUrlConnection.Font = new System.Drawing.Font("Microsoft Sans Serif", 18F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(222)));
            this.txtUrlConnection.Location = new System.Drawing.Point(261, 85);
            this.txtUrlConnection.Name = "txtUrlConnection";
            this.txtUrlConnection.Size = new System.Drawing.Size(845, 35);
            this.txtUrlConnection.TabIndex = 4;
            this.txtUrlConnection.Click += new System.EventHandler(this.txtUrlConnection_Click);
            // 
            // btnCountdownAutoSavePlusFive
            // 
            this.btnCountdownAutoSavePlusFive.BackgroundImageLayout = System.Windows.Forms.ImageLayout.Center;
            this.btnCountdownAutoSavePlusFive.FlatStyle = System.Windows.Forms.FlatStyle.Popup;
            this.btnCountdownAutoSavePlusFive.Font = new System.Drawing.Font("Microsoft Sans Serif", 18F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(222)));
            this.btnCountdownAutoSavePlusFive.ForeColor = System.Drawing.Color.Black;
            this.btnCountdownAutoSavePlusFive.Location = new System.Drawing.Point(446, 126);
            this.btnCountdownAutoSavePlusFive.Name = "btnCountdownAutoSavePlusFive";
            this.btnCountdownAutoSavePlusFive.Size = new System.Drawing.Size(75, 35);
            this.btnCountdownAutoSavePlusFive.TabIndex = 8;
            this.btnCountdownAutoSavePlusFive.Text = "+5";
            this.btnCountdownAutoSavePlusFive.TextAlign = System.Drawing.ContentAlignment.BottomCenter;
            this.btnCountdownAutoSavePlusFive.Click += new System.EventHandler(this.btnCountdownAutoSavePlusFive_Click);
            // 
            // txtAutoSaveSeconds
            // 
            this.txtAutoSaveSeconds.Font = new System.Drawing.Font("Microsoft Sans Serif", 18F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(222)));
            this.txtAutoSaveSeconds.Location = new System.Drawing.Point(261, 126);
            this.txtAutoSaveSeconds.Name = "txtAutoSaveSeconds";
            this.txtAutoSaveSeconds.Size = new System.Drawing.Size(98, 35);
            this.txtAutoSaveSeconds.TabIndex = 6;
            // 
            // btnCountdownAutoSavePlusTen
            // 
            this.btnCountdownAutoSavePlusTen.BackgroundImageLayout = System.Windows.Forms.ImageLayout.Center;
            this.btnCountdownAutoSavePlusTen.FlatStyle = System.Windows.Forms.FlatStyle.Popup;
            this.btnCountdownAutoSavePlusTen.Font = new System.Drawing.Font("Microsoft Sans Serif", 18F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(222)));
            this.btnCountdownAutoSavePlusTen.ForeColor = System.Drawing.Color.Black;
            this.btnCountdownAutoSavePlusTen.Location = new System.Drawing.Point(527, 126);
            this.btnCountdownAutoSavePlusTen.Name = "btnCountdownAutoSavePlusTen";
            this.btnCountdownAutoSavePlusTen.Size = new System.Drawing.Size(75, 35);
            this.btnCountdownAutoSavePlusTen.TabIndex = 9;
            this.btnCountdownAutoSavePlusTen.Text = "+10";
            this.btnCountdownAutoSavePlusTen.TextAlign = System.Drawing.ContentAlignment.BottomCenter;
            this.btnCountdownAutoSavePlusTen.Click += new System.EventHandler(this.btnCountdownAutoSavePlusTen_Click);
            // 
            // pnlSettingDevice2
            // 
            this.pnlSettingDevice2.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.pnlSettingDevice2.BackColor = System.Drawing.Color.DodgerBlue;
            this.pnlSettingDevice2.Location = new System.Drawing.Point(140, 6);
            modalityDeviceConfig11.AcceptBloodGlucose = true;
            modalityDeviceConfig11.AcceptBloodPressure = true;
            modalityDeviceConfig11.AcceptBmi = true;
            modalityDeviceConfig11.AcceptHeight = true;
            modalityDeviceConfig11.AcceptPainScale = true;
            modalityDeviceConfig11.AcceptPulseRate = true;
            modalityDeviceConfig11.AcceptRespirationRate = true;
            modalityDeviceConfig11.AcceptSpO2 = true;
            modalityDeviceConfig11.AcceptTemperature = true;
            modalityDeviceConfig11.AcceptWeight = true;
            modalityDeviceConfig11.BaudRate = 1200;
            modalityDeviceConfig11.DataBits = "Five";
            modalityDeviceConfig11.DelayMilliseconds = 0;
            modalityDeviceConfig11.DeviceName = "None";
            modalityDeviceConfig11.EnableTrace = false;
            modalityDeviceConfig11.IsActive = false;
            modalityDeviceConfig11.Parity = "None";
            modalityDeviceConfig11.PortName = "";
            modalityDeviceConfig11.StopBits = "None";
            this.pnlSettingDevice2.ModalityDeviceConfig = modalityDeviceConfig11;
            this.pnlSettingDevice2.Name = "pnlSettingDevice2";
            this.pnlSettingDevice2.Size = new System.Drawing.Size(1109, 593);
            this.pnlSettingDevice2.TabIndex = 55;
            // 
            // pnlSettingDevice1
            // 
            this.pnlSettingDevice1.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.pnlSettingDevice1.BackColor = System.Drawing.Color.DodgerBlue;
            this.pnlSettingDevice1.Location = new System.Drawing.Point(140, 6);
            modalityDeviceConfig12.AcceptBloodGlucose = true;
            modalityDeviceConfig12.AcceptBloodPressure = true;
            modalityDeviceConfig12.AcceptBmi = true;
            modalityDeviceConfig12.AcceptHeight = true;
            modalityDeviceConfig12.AcceptPainScale = true;
            modalityDeviceConfig12.AcceptPulseRate = true;
            modalityDeviceConfig12.AcceptRespirationRate = true;
            modalityDeviceConfig12.AcceptSpO2 = true;
            modalityDeviceConfig12.AcceptTemperature = true;
            modalityDeviceConfig12.AcceptWeight = true;
            modalityDeviceConfig12.BaudRate = 1200;
            modalityDeviceConfig12.DataBits = "Five";
            modalityDeviceConfig12.DelayMilliseconds = 0;
            modalityDeviceConfig12.DeviceName = "None";
            modalityDeviceConfig12.EnableTrace = false;
            modalityDeviceConfig12.IsActive = false;
            modalityDeviceConfig12.Parity = "None";
            modalityDeviceConfig12.PortName = "";
            modalityDeviceConfig12.StopBits = "None";
            this.pnlSettingDevice1.ModalityDeviceConfig = modalityDeviceConfig12;
            this.pnlSettingDevice1.Name = "pnlSettingDevice1";
            this.pnlSettingDevice1.Size = new System.Drawing.Size(1109, 593);
            this.pnlSettingDevice1.TabIndex = 54;
            // 
            // pnlSettinghnPad
            // 
            this.pnlSettinghnPad.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom) 
            | System.Windows.Forms.AnchorStyles.Left) 
            | System.Windows.Forms.AnchorStyles.Right)));
            this.pnlSettinghnPad.BackColor = System.Drawing.Color.DodgerBlue;
            this.pnlSettinghnPad.Location = new System.Drawing.Point(140, 6);
            modalityHnPadConfig6.CustomCharacter00 = "";
            modalityHnPadConfig6.CustomCharacter01 = "";
            modalityHnPadConfig6.CustomCharacter02 = "";
            modalityHnPadConfig6.CustomCharacter03 = "";
            modalityHnPadConfig6.CustomCharacter04 = "";
            modalityHnPadConfig6.CustomCharacter05 = "";
            modalityHnPadConfig6.CustomCharacter06 = "";
            modalityHnPadConfig6.CustomCharacter07 = "";
            modalityHnPadConfig6.CustomCharacter08 = "";
            this.pnlSettinghnPad.ModalityHnPadConfig = modalityHnPadConfig6;
            this.pnlSettinghnPad.Name = "pnlSettinghnPad";
            this.pnlSettinghnPad.Size = new System.Drawing.Size(1109, 593);
            this.pnlSettinghnPad.TabIndex = 56;
            // 
            // btnSaveConfig
            // 
            this.btnSaveConfig.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Right)));
            this.btnSaveConfig.AutoSize = true;
            this.btnSaveConfig.BackgroundImage = global::MDI.Properties.Resources.save_64;
            this.btnSaveConfig.BackgroundImageLayout = System.Windows.Forms.ImageLayout.Center;
            this.btnSaveConfig.FlatStyle = System.Windows.Forms.FlatStyle.Popup;
            this.btnSaveConfig.Font = new System.Drawing.Font("Microsoft Sans Serif", 9F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(222)));
            this.btnSaveConfig.ForeColor = System.Drawing.Color.Black;
            this.btnSaveConfig.Location = new System.Drawing.Point(1162, 617);
            this.btnSaveConfig.Name = "btnSaveConfig";
            this.btnSaveConfig.Size = new System.Drawing.Size(96, 96);
            this.btnSaveConfig.TabIndex = 31;
            this.btnSaveConfig.Text = "SAVE";
            this.btnSaveConfig.TextAlign = System.Drawing.ContentAlignment.BottomCenter;
            this.btnSaveConfig.Click += new System.EventHandler(this.btnSaveConfig_Click);
            // 
            // btnPageBack
            // 
            this.btnPageBack.Anchor = ((System.Windows.Forms.AnchorStyles)((System.Windows.Forms.AnchorStyles.Bottom | System.Windows.Forms.AnchorStyles.Left)));
            this.btnPageBack.AutoSize = true;
            this.btnPageBack.BackgroundImage = global::MDI.Properties.Resources.page_back_64;
            this.btnPageBack.BackgroundImageLayout = System.Windows.Forms.ImageLayout.Center;
            this.btnPageBack.FlatStyle = System.Windows.Forms.FlatStyle.Popup;
            this.btnPageBack.Font = new System.Drawing.Font("Microsoft Sans Serif", 9F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(222)));
            this.btnPageBack.ForeColor = System.Drawing.Color.Black;
            this.btnPageBack.Location = new System.Drawing.Point(3, 617);
            this.btnPageBack.Name = "btnPageBack";
            this.btnPageBack.Size = new System.Drawing.Size(96, 96);
            this.btnPageBack.TabIndex = 0;
            this.btnPageBack.Text = "BACK";
            this.btnPageBack.TextAlign = System.Drawing.ContentAlignment.BottomCenter;
            this.btnPageBack.Visible = false;
            this.btnPageBack.Click += new System.EventHandler(this.btnPageBack_Click);
            // 
            // btnNetworkConnections
            // 
            this.btnNetworkConnections.Anchor = System.Windows.Forms.AnchorStyles.Bottom;
            this.btnNetworkConnections.AutoSize = true;
            this.btnNetworkConnections.BackgroundImage = global::MDI.Properties.Resources.config_network_64;
            this.btnNetworkConnections.BackgroundImageLayout = System.Windows.Forms.ImageLayout.Center;
            this.btnNetworkConnections.FlatStyle = System.Windows.Forms.FlatStyle.Popup;
            this.btnNetworkConnections.Font = new System.Drawing.Font("Microsoft Sans Serif", 9F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(222)));
            this.btnNetworkConnections.ForeColor = System.Drawing.Color.Black;
            this.btnNetworkConnections.Image = global::MDI.Properties.Resources.windows_16;
            this.btnNetworkConnections.ImageAlign = System.Drawing.ContentAlignment.TopLeft;
            this.btnNetworkConnections.Location = new System.Drawing.Point(658, 617);
            this.btnNetworkConnections.Name = "btnNetworkConnections";
            this.btnNetworkConnections.Size = new System.Drawing.Size(96, 96);
            this.btnNetworkConnections.TabIndex = 2;
            this.btnNetworkConnections.Text = "NETWORK";
            this.btnNetworkConnections.TextAlign = System.Drawing.ContentAlignment.BottomCenter;
            this.btnNetworkConnections.Click += new System.EventHandler(this.btnNetworkConnections_Click);
            // 
            // btnWinOnScreenKeyboard
            // 
            this.btnWinOnScreenKeyboard.Anchor = System.Windows.Forms.AnchorStyles.Bottom;
            this.btnWinOnScreenKeyboard.AutoSize = true;
            this.btnWinOnScreenKeyboard.BackgroundImage = global::MDI.Properties.Resources.keyboard_64;
            this.btnWinOnScreenKeyboard.BackgroundImageLayout = System.Windows.Forms.ImageLayout.Center;
            this.btnWinOnScreenKeyboard.FlatStyle = System.Windows.Forms.FlatStyle.Popup;
            this.btnWinOnScreenKeyboard.Font = new System.Drawing.Font("Microsoft Sans Serif", 9F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(222)));
            this.btnWinOnScreenKeyboard.ForeColor = System.Drawing.Color.Black;
            this.btnWinOnScreenKeyboard.Image = global::MDI.Properties.Resources.windows_16;
            this.btnWinOnScreenKeyboard.ImageAlign = System.Drawing.ContentAlignment.TopLeft;
            this.btnWinOnScreenKeyboard.Location = new System.Drawing.Point(760, 617);
            this.btnWinOnScreenKeyboard.Name = "btnWinOnScreenKeyboard";
            this.btnWinOnScreenKeyboard.Size = new System.Drawing.Size(96, 96);
            this.btnWinOnScreenKeyboard.TabIndex = 1;
            this.btnWinOnScreenKeyboard.Text = "KEYBOARD";
            this.btnWinOnScreenKeyboard.TextAlign = System.Drawing.ContentAlignment.BottomCenter;
            this.btnWinOnScreenKeyboard.Click += new System.EventHandler(this.btnWinOnScreenKeyboard_Click);
            // 
            // frmSetting
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.BackColor = System.Drawing.Color.Black;
            this.ClientSize = new System.Drawing.Size(1285, 740);
            this.Controls.Add(this.pnlMain);
            this.ForeColor = System.Drawing.Color.White;
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.None;
            this.Margin = new System.Windows.Forms.Padding(1);
            this.Name = "frmSetting";
            this.ShowInTaskbar = false;
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterParent;
            this.Text = "Envision MDI - Setting";
            this.WindowState = System.Windows.Forms.FormWindowState.Maximized;
            this.Load += new System.EventHandler(this.frmSetting_Load);
            this.Shown += new System.EventHandler(this.frmSetting_Shown);
            this.pnlMain.ResumeLayout(false);
            this.pnlMain.PerformLayout();
            this.pnlSetting.ResumeLayout(false);
            this.pnlSetting.PerformLayout();
            this.pnlSettingGeneral.ResumeLayout(false);
            this.pnlSettingGeneral.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.txtMdiSocketPort)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.txtAutoSaveSeconds)).EndInit();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.Button btnPageBack;
        private System.Windows.Forms.Panel pnlMain;
        private System.Windows.Forms.Button btnNetworkConnections;
        private System.Windows.Forms.Button btnWinOnScreenKeyboard;
        private System.Windows.Forms.Label lblUrlConnection;
        private System.Windows.Forms.Label lblCountdownAutoSave;
        private System.Windows.Forms.TextBox txtUrlConnection;
        private System.Windows.Forms.NumericUpDown txtAutoSaveSeconds;
        private System.Windows.Forms.Button btnSaveConfig;
        private System.Windows.Forms.Button btnCountdownAutoSavePlusTen;
        private System.Windows.Forms.Button btnCountdownAutoSaveSetZero;
        private System.Windows.Forms.Button btnCountdownAutoSavePlusFive;
        private System.Windows.Forms.Button btnSettingGeneral;
        private System.Windows.Forms.Panel pnlSetting;
        private System.Windows.Forms.Button btnSettingDevice2;
        private System.Windows.Forms.Button btnSettingDevice1;
        private System.Windows.Forms.Button btnSettingHnPad;
        private System.Windows.Forms.Panel pnlSettingGeneral;
        private ctrlSettingDevice pnlSettingDevice1;
        private ctrlSettingDevice pnlSettingDevice2;
        private System.Windows.Forms.Label lblMdiSocketIp;
        private System.Windows.Forms.TextBox txtMdiSocketIp;
        private System.Windows.Forms.Label lblMdiSocketPort;
        private System.Windows.Forms.NumericUpDown txtMdiSocketPort;
        private System.Windows.Forms.Label lblModalityUid;
        private System.Windows.Forms.TextBox txtModalityUid;
        private ctrlSettingHnPad pnlSettinghnPad;
        private System.Windows.Forms.Button btnShutdown;
        private System.Windows.Forms.Button btnRestart;
        private System.Windows.Forms.Label lblShutdownTime;
        private System.Windows.Forms.TextBox txtShutdownTime;
    }
}