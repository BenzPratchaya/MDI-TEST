using EnvisionIE.Operational;
using System;
using System.ComponentModel;
using System.Drawing;
using System.Windows.Forms;

namespace MDI.Forms
{
    public enum ObservationEditorMode
    {
        Numpad,
        PainScale
    }
    public partial class ctrlObservation : UserControl
    {
        public delegate void EventValueChanged();
        public event EventValueChanged ValueChanged;
        protected virtual void OnValueChanged() { ValueChanged?.Invoke(); }

        public string Identifier { get => lblIdentifier.Text; set => lblIdentifier.Text = value; }
        [DefaultValue(typeof(decimal), "-1")]
        public decimal NormalMin { get; set; } = decimal.MinusOne;
        [DefaultValue(typeof(decimal), "-1")]
        public decimal NormalMax { get; set; } = decimal.MinusOne;
        public string ObservationText { get => lblObservation.Text; set => lblObservation.Text = value; }
        public string ObservationFormat { get; set; } = "";
        public string ObservationType { get; set; } = "int";
        public string Unit { get => lblUnit.Text; set => lblUnit.Text = value; }
        public ObservationEditorMode EditorMode { get; set; } = ObservationEditorMode.Numpad;

        public ctrlObservation() { InitializeComponent(); }

        private void ctrlObservation_Load(object sender, EventArgs e)
        {
            if (NormalMin > decimal.MinusOne && NormalMax > decimal.MinusOne)
                lblMinMax.Text = $"{NormalMin.ToString(ObservationFormat)} - {NormalMax.ToString(ObservationFormat)}";
            else if (NormalMin > decimal.MinusOne)
                lblMinMax.Text = $">= {NormalMin.ToString(ObservationFormat)}";
            else if (NormalMax > decimal.MinusOne)
                lblMinMax.Text = $"<= {NormalMax.ToString(ObservationFormat)}";
            else
                lblMinMax.Text = "";
        }

        public void Reset()
        {
            switch (ObservationType)
            {
                default:
                    ObservationText = 0.ToString(ObservationFormat);
                    break;
                case "decimal":
                    ObservationText = 0.ToString(ObservationFormat);
                    break;
            }
        }

        private void ctrlObservation_Click(object sender, EventArgs e)
        {
            using (diagNumPad diag = new diagNumPad())
            {
                diag.Value = ObservationText;

                if (diag.ShowDialog() == DialogResult.OK)
                {
                    switch (ObservationType)
                    {
                        default:
                            ObservationText = Utilities.ToInt(diag.Value).ToString(ObservationFormat);
                            break;
                        case "decimal":
                            ObservationText = Utilities.ToDecimal(diag.Value).ToString(ObservationFormat);
                            break;
                    }

                    OnValueChanged();
                }
            }
        }

        private void lblObservation_TextChanged(object sender, EventArgs e)
        {
            bool flag_has_value = false;
            bool is_normal = false;

            decimal observation_value = Utilities.ToDecimal(lblObservation.Text);

            if (observation_value > decimal.Zero)
            {
                flag_has_value = true;

                if (NormalMin > decimal.MinusOne && NormalMin > observation_value)
                    is_normal = false;
                else if (NormalMax > decimal.MinusOne && NormalMax < observation_value)
                    is_normal = false;
                else
                    is_normal = true;
            }

            if (flag_has_value)
            {
                lblObservation.ForeColor = Color.Black;
                lblObservation.BackColor = is_normal ? Color.White : Color.LightSalmon;
            }
            else
            {
                lblObservation.ForeColor = Color.Gray;
                lblObservation.BackColor = Color.White;
            }
        }
    }
}
