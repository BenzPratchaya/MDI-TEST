using EnvisionIE.Entity.Global;
using System;

namespace EnvisionMDI.Entity
{
    public class Patient : IName, IDisposable
    {
        private bool disposed = false;

        public Patient() { }
        ~Patient() { Dispose(); }

        public virtual void Dispose()
        {
            if (disposed)
                return;

            disposed = true;
        }

        public Name GetPatientName() => new Name(this);
        public void SetPatientName(IName value)
        {
            if (value == null)
                return;

            PatientTitle = value.Title;
            PatientFName = value.FName;
            PatientMName = value.MName;
            PatientLName = value.LName;
            PatientTitleEng = value.TitleEng;
            PatientFNameEng = value.FNameEng;
            PatientMNameEng = value.MNameEng;
            PatientLNameEng = value.LNameEng;
        }

        public int? PatientId { get; set; }
        public string Hn { get; set; } = "";
        public string PatientTitle { get; set; } = "";
        public string PatientFName { get; set; } = "";
        public string PatientMName { get; set; } = "";
        public string PatientLName { get; set; } = "";
        public string PatientTitleEng { get; set; } = "";
        public string PatientFNameEng { get; set; } = "";
        public string PatientMNameEng { get; set; } = "";
        public string PatientLNameEng { get; set; } = "";
        public string PatientGender { get; set; } = "";
        public DateTime? PatientDob { get; set; }
        public string PatientSsn { get; set; } = "";

        public int OrganizationId { get; set; }

        string IName.Title { get => PatientTitle; set => PatientTitle = value; }
        string IName.FName { get => PatientFName; set => PatientFName = value; }
        string IName.MName { get => PatientMName; set => PatientMName = value; }
        string IName.LName { get => PatientLName; set => PatientLName = value; }
        string IName.TitleEng { get => PatientTitleEng; set => PatientTitleEng = value; }
        string IName.FNameEng { get => PatientFNameEng; set => PatientFNameEng = value; }
        string IName.MNameEng { get => PatientMNameEng; set => PatientMNameEng = value; }
        string IName.LNameEng { get => PatientLNameEng; set => PatientLNameEng = value; }
    }
}