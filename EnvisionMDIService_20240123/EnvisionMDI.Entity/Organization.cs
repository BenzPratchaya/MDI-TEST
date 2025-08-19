using System;
using System.Text;

namespace EnvisionMDI.Entity
{
    public class General : IDisposable
    {
        private bool disposed = false;

        public General() { }
        ~General() { Dispose(); }

        public virtual void Dispose()
        {
            if (disposed)
                return;

            disposed = true;
        }

        public int GeneralId { get; set; }
        public string GeneralUid { get; set; } = "";
        public string GeneralName { get; set; } = "";
        public string GeneralGroup { get; set; } = "";
        public bool IsDeleted { get; set; } = false;
        public bool IsDefault { get; set; } = false;
        public int CreatedBy { get; set; }
        public DateTime CreatedOn { get; set; }
        public int ModifiedBy { get; set; }
        public DateTime ModifiedOn { get; set; }
        
    }
}
