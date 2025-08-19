using System;

namespace EnvisionMDI.Entity
{
    public class GrantOrg : IDisposable
    {
        private bool disposed = false;

        public GrantOrg() { }
        ~GrantOrg() { Dispose(); }

        public virtual void Dispose()
        {
            if (disposed)
                return;

            disposed = true;
        }

        public int? UserId { get; set; }
        public int AccessOrganizationId { get; set; }
    }
}