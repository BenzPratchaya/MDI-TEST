using System;

namespace EnvisionMDI.Entity
{
    public class Location : IDisposable
    {
        private bool disposed = false;

        public Location() { }
        ~Location() { Dispose(); }

        public virtual void Dispose()
        {
            if (disposed)
                return;

            disposed = true;
        }

        public int? LocationId { get; set; }
        public string LocationUid { get; set; } = "";
        public string LocationName { get; set; } = "";
        public string LocationDesc { get; set; } = "";

        public bool IsDeleted { get; set; } = false;

        public int OrganizationId { get; set; }
    }
}