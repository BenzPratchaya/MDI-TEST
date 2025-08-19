using MDI.Entity;
using System;
using System.Windows.Forms;

namespace MDI.Forms
{
    public partial class ctrlSettingHnPad : UserControl
    {
        public ModalityHnPadConfig ModalityHnPadConfig { get; set; }

        public ctrlSettingHnPad()
        {
            InitializeComponent();

            initClass();
        }

        private void initClass() { ModalityHnPadConfig = new ModalityHnPadConfig(); }

        public void SetValue()
        {
            txtCustomCharacter00.Text = ModalityHnPadConfig.CustomCharacter00;
            txtCustomCharacter01.Text = ModalityHnPadConfig.CustomCharacter01;
            txtCustomCharacter02.Text = ModalityHnPadConfig.CustomCharacter02;
            txtCustomCharacter03.Text = ModalityHnPadConfig.CustomCharacter03;
            txtCustomCharacter04.Text = ModalityHnPadConfig.CustomCharacter04;
            txtCustomCharacter05.Text = ModalityHnPadConfig.CustomCharacter05;
            txtCustomCharacter06.Text = ModalityHnPadConfig.CustomCharacter06;
            txtCustomCharacter07.Text = ModalityHnPadConfig.CustomCharacter07;
            txtCustomCharacter08.Text = ModalityHnPadConfig.CustomCharacter08;
        }

        private void txtCustomCharacter00_TextChanged(object sender, EventArgs e) => ModalityHnPadConfig.CustomCharacter00 = txtCustomCharacter00.Text;
        private void txtCustomCharacter01_TextChanged(object sender, EventArgs e) => ModalityHnPadConfig.CustomCharacter01 = txtCustomCharacter01.Text;
        private void txtCustomCharacter02_TextChanged(object sender, EventArgs e) => ModalityHnPadConfig.CustomCharacter02 = txtCustomCharacter02.Text;
        private void txtCustomCharacter03_TextChanged(object sender, EventArgs e) => ModalityHnPadConfig.CustomCharacter03 = txtCustomCharacter03.Text;
        private void txtCustomCharacter04_TextChanged(object sender, EventArgs e) => ModalityHnPadConfig.CustomCharacter04 = txtCustomCharacter04.Text;
        private void txtCustomCharacter05_TextChanged(object sender, EventArgs e) => ModalityHnPadConfig.CustomCharacter05 = txtCustomCharacter05.Text;
        private void txtCustomCharacter06_TextChanged(object sender, EventArgs e) => ModalityHnPadConfig.CustomCharacter06 = txtCustomCharacter06.Text;
        private void txtCustomCharacter07_TextChanged(object sender, EventArgs e) => ModalityHnPadConfig.CustomCharacter07 = txtCustomCharacter07.Text;
        private void txtCustomCharacter08_TextChanged(object sender, EventArgs e) => ModalityHnPadConfig.CustomCharacter08 = txtCustomCharacter08.Text;
    }
}