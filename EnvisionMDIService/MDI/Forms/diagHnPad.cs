using System;
using System.Windows.Forms;

namespace MDI.Forms
{
    public partial class diagHnPad : Form
    {
        public string Hn
        {
            get => txtHn.Text;
            set
            {
                txtHn.Text = value;

                KeepFocus();
            }
        }

        public diagHnPad() => InitializeComponent();
        private void diagHnPad_Load(object sender, EventArgs e)
        {
            btnCustomCharacter00.Text = ServiceConfig.ModalityConfig.HnPad.CustomCharacter00;
            btnCustomCharacter01.Text = ServiceConfig.ModalityConfig.HnPad.CustomCharacter01;
            btnCustomCharacter02.Text = ServiceConfig.ModalityConfig.HnPad.CustomCharacter02;
            btnCustomCharacter03.Text = ServiceConfig.ModalityConfig.HnPad.CustomCharacter03;
            btnCustomCharacter04.Text = ServiceConfig.ModalityConfig.HnPad.CustomCharacter04;
            btnCustomCharacter05.Text = ServiceConfig.ModalityConfig.HnPad.CustomCharacter05;
            btnCustomCharacter06.Text = ServiceConfig.ModalityConfig.HnPad.CustomCharacter06;
            btnCustomCharacter07.Text = ServiceConfig.ModalityConfig.HnPad.CustomCharacter07;
            btnCustomCharacter08.Text = ServiceConfig.ModalityConfig.HnPad.CustomCharacter08;
        }
        private void diagHnPad_Shown(object sender, EventArgs e) => KeepFocus();

        private void KeepFocus()
        {
            try
            {
                if (string.IsNullOrEmpty(txtHn.Text))
                    txtHn.SelectAll();
                else
                    txtHn.Select(txtHn.Text.Length, 1);

                txtHn.Focus();
            }
            catch { }
        }

        private void txtHn_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Enter)
                DialogResult = DialogResult.OK;
        }
        private void btnEnter_Click(object sender, EventArgs e) => DialogResult = DialogResult.OK;
        private void btnCancel_Click(object sender, EventArgs e) => txtHn.Text = "";
        private void btnDelete_Click(object sender, EventArgs e)
        {
            string value = txtHn.Text;

            if (!string.IsNullOrEmpty(value))
                value = value.Substring(0, value.Length - 1);

            txtHn.Text = value;
        }
        private void btnCustomCharacter00_Click(object sender, EventArgs e) => SetValue(btnCustomCharacter00.Text);
        private void btnCustomCharacter01_Click(object sender, EventArgs e) => SetValue(btnCustomCharacter01.Text);
        private void btnCustomCharacter02_Click(object sender, EventArgs e) => SetValue(btnCustomCharacter02.Text);
        private void btnCustomCharacter03_Click(object sender, EventArgs e) => SetValue(btnCustomCharacter03.Text);
        private void btnCustomCharacter04_Click(object sender, EventArgs e) => SetValue(btnCustomCharacter04.Text);
        private void btnCustomCharacter05_Click(object sender, EventArgs e) => SetValue(btnCustomCharacter05.Text);
        private void btnCustomCharacter06_Click(object sender, EventArgs e) => SetValue(btnCustomCharacter06.Text);
        private void btnCustomCharacter07_Click(object sender, EventArgs e) => SetValue(btnCustomCharacter07.Text);
        private void btnCustomCharacter08_Click(object sender, EventArgs e) => SetValue(btnCustomCharacter08.Text);
        private void btnNumber0_Click(object sender, EventArgs e) => SetValue("0");
        private void btnNumber1_Click(object sender, EventArgs e) => SetValue("1");
        private void btnNumber2_Click(object sender, EventArgs e) => SetValue("2");
        private void btnNumber3_Click(object sender, EventArgs e) => SetValue("3");
        private void btnNumber4_Click(object sender, EventArgs e) => SetValue("4");
        private void btnNumber5_Click(object sender, EventArgs e) => SetValue("5");
        private void btnNumber6_Click(object sender, EventArgs e) => SetValue("6");
        private void btnNumber7_Click(object sender, EventArgs e) => SetValue("7");
        private void btnNumber8_Click(object sender, EventArgs e) => SetValue("8");
        private void btnNumber9_Click(object sender, EventArgs e) => SetValue("9");

        public void SetValue(string value)
        {
            txtHn.Text = txtHn.Text + value;

            KeepFocus();
        }
    }
}