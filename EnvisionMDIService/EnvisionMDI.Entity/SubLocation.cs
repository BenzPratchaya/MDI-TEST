using System;

namespace EnvisionMDI.Entity
{
    public class SubLocation : IDisposable
    {
        private bool disposed = false;

        public SubLocation() { }
        ~SubLocation() { Dispose(); }

        public virtual void Dispose()
        {
            if (disposed)
                return;

            disposed = true;
        }

        public int? SubLocationId { get; set; }
        public int? LocationId { get; set; }

        public string SubLocationUid { get; set; } = "";
        public string SubLocationName { get; set; } = "";
        public string SubLocationDesc { get; set; } = "";
        public string SubLocationBuilding { get; set; } = "";
        public string SubLocationFloor { get; set; } = "";
        public string SubLocationRoom { get; set; } = "";

        public bool IsDeleted { get; set; } = false;

        public int OrganizationId { get; set; }
    }
}