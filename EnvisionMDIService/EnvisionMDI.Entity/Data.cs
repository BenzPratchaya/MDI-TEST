using System;

namespace EnvisionMDI.Entity
{
    public class Data : IDisposable
    {
        private bool disposed = false;

        public Data() { }
        ~Data() { Dispose(); }

        public virtual void Dispose()
        {
            if (disposed)
                return;

            disposed = true;
        }

        public int DataId { get; set; }
        public int PatientVisitId { get; set; }
        public int ModalityVsId { get; set; }
        public DateTime VsDateTime { get; set; }
        public int? PulseRate { get; set; }
        public string PulseUnit { get; set; }
        public string PulseFlag { get; set; }
        public int? BloodPressureSystolic { get; set; }
        public int? BloodPressureDiastolic { get; set; }
        public int? BloodPressureMean { get; set; }
        public string BloodPressure { get; set; }
        public string BloodPressureUnit { get; set; }
        public string BloodPressureMethod { get; set; }
        public decimal? SpO2 { get; set; }
        public string SpO2Unit { get; set; }
        public decimal? Temperature { get; set; }
        public string TemperatureUnit { get; set; }
        public string TemperatureMethod { get; set; }
        public int? BloodGlucose { get; set; }
        public string BloodGlucoseUnit { get; set; }
        public int? RespirationRate { get; set; }
        public int? PainScale { get; set; }
        public int? CvRiskScore { get; set; }
        public int? MewsScore { get; set; }
        public int? NewsScore { get; set; }
        public int? ComaScore { get; set; }

        public string DataStatus { get; set; } = "";
        public string Comment { get; set; } = "";
        public bool IsConfirmed { get; set; }

        public int OrganizationId { get; set; }
        public int ModifiedBy { get; set; }
    }
}