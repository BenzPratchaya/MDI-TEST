using EnvisionIE.Operational;
using System;
using System.Windows.Forms;

namespace MDI.Forms
{
    public partial class diagNumPad : Form
    {
        private string RawValue;
        public string Value { get => txtValue.Text; set => txtValue.Text = RawValue = value; }

        public diagNumPad() { InitializeComponent(); }

        private void diagNumpad_Shown(object sender, EventArgs e) { btnEnter.Focus(); }

        private void btnEnter_Click(object sender, EventArgs e) => DialogResult = DialogResult.OK;
        private void btnCancel_Click(object sender, EventArgs e) => txtValue.Text = RawValue;
        private void btnDelete_Click(object sender, EventArgs e)
        {
            string value = txtValue.Text;

            if (!string.IsNullOrEmpty(value))
                value = value.Substring(0, value.Length - 1);

            txtValue.Text = value;
        }
        private void btnDecimalPoint_Click(object sender, EventArgs e) => SetValue(".");
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
            if (Utilities.ToDecimal(txtValue.Text) == decimal.Zero)
                txtValue.Text = value;
            else
                txtValue.Text = txtValue.Text + value;
        }
    }
}