using System;

namespace MDI.Entity
{
    public class DeviceData : IDisposable
    {
        private bool disposed = false;

        public DeviceData()
        {
            MessageControlId = $"{ServiceConfig.ModalityConfig.ModalityUid}_{DateTime.Now.ToString("yyyyMMddHHmmssffff")}";

            IsActivePatient = false;
            IsActiveDevice1 = false;

            CreatedOn = DateTime.Now;
        }
        ~DeviceData() { Dispose(); }

        public virtual void Dispose()
        {
            if (disposed)
                return;

            disposed = true;
        }

        public string MessageControlId { get; set; } = "";

        public string Hn { get; set; } = "";
        public string VisitNo { get; set; } = "";

        public decimal Weight { get; set; } = decimal.Zero;
        public string WeightUnit { get; set; } = "Kg";
        public decimal Height { get; set; } = decimal.Zero;
        public string HeightUnit { get; set; } = "cm";
        public decimal Bmi { get; set; } = decimal.Zero;

        public int PulseRate { get; set; }
        public string PulseUnit { get; set; } = "";
        public string PulseFlag { get; set; }
        public int BloodPressureSystolic { get; set; }
        public int BloodPressureDiastolic { get; set; }
        public int BloodPressureMean { get; set; }
        public string BloodPressureUnit { get; set; } = "mmHg";
        public string BloodPressureMethod { get; set; }
        public decimal SpO2 { get; set; }
        public string SpO2Unit { get; set; } = "%";
        public decimal Temperature { get; set; }
        public string TemperatureUnit { get; set; } = "C";
        public string TemperatureMethod { get; set; }
        public int BloodGlucose { get; set; }
        public string BloodGlucoseUnit { get; set; } = "mg/dL";
        public int RespirationRate { get; set; }
        public int PainScale { get; set; }

        public bool IsActivePatient { get; set; }
        public bool IsActiveDevice1 { get; set; }
        public bool IsActiveDevice2 { get; set; }

        public string AcknowledgementCode { get; set; }
        public string TextMessage { get; set; }

        public DateTime CreatedOn { get; set; }
    }
}