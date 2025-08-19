using System;
using System.Windows.Forms;

namespace MDI.Forms
{
    public partial class ctrlCheckbox : UserControl
    {
        public delegate void EventCheckedChanged();
        public event EventCheckedChanged CheckedChanged;
        protected virtual void OnCheckedChanged() { CheckedChanged?.Invoke(); }

        private bool raw_checked = false;
        public bool Checked
        {
            get => raw_checked; set
            {
                if (raw_checked == value)
                    return;

                raw_checked = value;

                CheckState();
            }
        }
        public string DisplayText { get => lblText.Text; set => lblText.Text = value; }

        public ctrlCheckbox()
        {
            InitializeComponent();

            CheckState();
        }

        private void CheckState() => lblImage.Image = Checked ? Properties.Resources.check_state_checked_24 : Properties.Resources.check_state_unchecked_24;

        private void ctrlCheckbox_Click(object sender, EventArgs e)
        {
            Checked = !Checked;

            CheckState();
            OnCheckedChanged();
        }
    }
}