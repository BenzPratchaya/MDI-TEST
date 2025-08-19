using System;
using System.Text;

namespace EnvisionMDI.Entity
{
    public class Organization : IDisposable
    {
        private bool disposed = false;

        public Organization() { }
        ~Organization() { Dispose(); }

        public virtual void Dispose()
        {
            if (disposed)
                return;

            disposed = true;
        }

        public int OrganizationId { get; set; }
        public string OrganizationUid { get; set; } = "";
        public string OrganizationName { get; set; } = "";
        public string OrganizationAlias { get; set; } = "";

        public Encoding ThirdPartyEncoding { get; set; }
        public string ThirdPartyUrl { get; set; } = "";

        public bool IsDeleted { get; set; } = false;
    }
}
