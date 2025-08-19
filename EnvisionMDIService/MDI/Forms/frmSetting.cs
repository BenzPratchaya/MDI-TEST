using EnvisionIE.Operational;
using EnvisionIEService.Api;
using MDI.Entity;
using System;
using System.Windows.Forms;

namespace MDI.Forms
{
    public partial class frmSetting : Form
    {
        private ModalityConfig ModalityConfig = new ModalityConfig();

        public frmSetting( ModalityConfig modalityConfig)
        {
            InitializeComponent();

            ModalityConfig = modalityConfig.Clone();
        }

        private void frmSetting_Load(object sender, EventArgs e) { }
        private void frmSetting_Shown(object sender, EventArgs e) { initForm(); }

        private void initForm()
        {
            txtModalityUid.Text = ModalityConfig.ModalityUid;
            txtUrlConnection.Text = ModalityConfig.UrlConnection;
            txtAutoSaveSeconds.Value = ModalityConfig.AutoSaveSeconds;

            txtMdiSocketIp.Text = ModalityConfig.MdiSocketIp;
            txtMdiSocketPort.Value = ModalityConfig.MdiSocketPort;

            txtShutdownTime.Text = ModalityConfig.ShutdownTime == TimeSpan.MinValue ? "" : ModalityConfig.ShutdownTime.ToString();

            pnlSettinghnPad.ModalityHnPadConfig = ModalityConfig.HnPad;
            pnlSettinghnPad.SetValue();
            pnlSettingDevice1.ModalityDeviceConfig = ModalityConfig.Device1;
            pnlSettingDevice1.SetValue();
            pnlSettingDevice2.ModalityDeviceConfig = ModalityConfig.Device2;
            pnlSettingDevice2.SetValue();
        }

        private void btnSettingGeneral_Click(object sender, EventArgs e)
        {
            pnlSettingGeneral.Visible = true;
            pnlSettinghnPad.Visible = false;
            pnlSettingDevice1.Visible = false;
            pnlSettingDevice2.Visible = false;
        }
        private void btnSettingHnPad_Click(object sender, EventArgs e)
        {
            pnlSettingGeneral.Visible = false;
            pnlSettinghnPad.Visible = true;
            pnlSettingDevice1.Visible = false;
            pnlSettingDevice2.Visible = false;
        }
        private void btnSettingDevice1_Click(object sender, EventArgs e)
        {
            pnlSettingGeneral.Visible = false;
            pnlSettinghnPad.Visible = false;
            pnlSettingDevice1.Visible = true;
            pnlSettingDevice2.Visible = false;
        }
        private void btnSettingDevice2_Click(object sender, EventArgs e)
        {
            pnlSettingGeneral.Visible = false;
            pnlSettinghnPad.Visible = false;
            pnlSettingDevice1.Visible = false;
            pnlSettingDevice2.Visible = true;
        }

        private void btnPageBack_Click(object sender, EventArgs e) => DialogResult = DialogResult.Cancel;
        private void btnShutdown_Click(object sender, EventArgs e) => WindowsCommands.Shutdown();
        private void btnRestart_Click(object sender, EventArgs e) => WindowsCommands.Restart();
        private void btnNetworkConnections_Click(object sender, EventArgs e) => WindowsCommands.NetworkConnections();
        private void btnWinOnScreenKeyboard_Click(object sender, EventArgs e) => WindowsCommands.OnScreenKeyboard();

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
        private void btnCountdownAutoSaveSetZero_Click(object sender, EventArgs e) { txtAutoSaveSeconds.Value = 0; }
        private void btnCountdownAutoSavePlusFive_Click(object sender, EventArgs e)
        {
            try { txtAutoSaveSeconds.Value += 5M; }
            catch { txtAutoSaveSeconds.Value = txtAutoSaveSeconds.Maximum; }
        }
        private void btnCountdownAutoSavePlusTen_Click(object sender, EventArgs e)
        {
            try { txtAutoSaveSeconds.Value += 10M; }
            catch { txtAutoSaveSeconds.Value = txtAutoSaveSeconds.Maximum; }
        }

        private void btnSaveConfig_Click(object sender, EventArgs e)
        {
            IeServiceConfig.UrlEnvisionIeService = txtUrlConnection.Text.Trim().TrimEnd(new char[] { '/' }) + "/EnvisionIEService/";

            ModalityConfig.ModalityUid = txtModalityUid.Text;

            ModalityConfig.UrlConnection = txtUrlConnection.Text.Trim().TrimEnd(new char[] { '/' });
            ModalityConfig.AutoSaveSeconds = Utilities.ToInt(txtAutoSaveSeconds.Value);

            ModalityConfig.MdiSocketIp = txtMdiSocketIp.Text.Trim();
            ModalityConfig.MdiSocketPort = Utilities.ToInt(txtMdiSocketPort.Value);

            ModalityConfig.ShutdownTime = Utilities.ToTimeSpan(txtShutdownTime.Text);

            ModalityConfig.HnPad = pnlSettinghnPad.ModalityHnPadConfig;
            pnlSettingDevice1.GetValue();
            ModalityConfig.Device1 = pnlSettingDevice1.ModalityDeviceConfig;
            pnlSettingDevice2.GetValue();
            ModalityConfig.Device2 = pnlSettingDevice2.ModalityDeviceConfig;

            ServiceConfig.ModalityConfig = ModalityConfig;

            DialogResult = DialogResult.OK;
        }
    }
}