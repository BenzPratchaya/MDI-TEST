using System;

namespace EnvisionMDI.Entity
{
    public class Modality : IDisposable
    {
        private bool disposed = false;

        public Modality() { }
        ~Modality() { Dispose(); }

        public virtual void Dispose()
        {
            if (disposed)
                return;

            disposed = true;
        }

        public int ModalityId { get; set; }
        public string ModalityUid { get; set; } = "";
        public string ModalityName { get; set; } = "";
        public string ModalityTypeAlias { get; set; } = "";
        public string ModalityHost { get; set; } = "";
        public string ModalityConfig { get; set; } = "";
        public string ModalityLog { get; set; } = "";
        public int VitalsignInterval { get; set; }

        public int LocationId { get; set; }
        public int SubLocationId { get; set; }

        public bool AutoConfirm { get; set; } = false;
        public bool IsDeleted { get; set; } = false;
        public int OrganizationId { get; set; }
    }
}