using System;
using System.ComponentModel.DataAnnotations;

namespace EnvisionMDI.Entity
{
    public class PatientVisit : IDisposable
    {
        private bool disposed = false;

        public PatientVisit() { }
        ~PatientVisit() { Dispose(); }

        public virtual void Dispose()
        {
            if (disposed)
                return;

            disposed = true;
        }

        public int PatientVisitId { get; set; }
        public int PatientId { get; set; }
        public int LocationId { get; set; }
        public int SubLocationId { get; set; }

        public string VisitNo { get; set; } = "";
        public string PatientType { get; set; } = "";

        public int ModalityWhId { get; set; }
        public DateTime WhDateTime { get; set; }
        public decimal? PatientWeight { get; set; }
        public string PatientWeightUnit { get; set; } = "";
        public decimal? PatientHeight { get; set; }
        public string PatientHeightUnit { get; set; } = "";
        public decimal? PatientBmi { get; set; }
        public string SmokingStatus { get; set; }
        public string SmokingHsi { get; set; }

        public int OrganizationId { get; set; }
        public DateTime CreatedOn { get; set; }
        public int ModifiedBy { get; set; }
    }
}