using EnvisionIE.Entity.Global;
using System;

namespace EnvisionMDI.Entity
{
    public class User : IName, IDisposable
    {
        private bool disposed = false;

        public User() { }
        ~User() { Dispose(); }

        public virtual void Dispose()
        {
            if (disposed)
                return;

            disposed = true;
        }

        public Name GetName() => new Name(this);
        public void SetName(IName value)
        {
            if (value == null)
                return;

            UserTitle = value.Title;
            UserFName = value.FName;
            UserMName = value.MName;
            UserLName = value.LName;
            UserTitleEng = value.TitleEng;
            UserFNameEng = value.FNameEng;
            UserMNameEng = value.MNameEng;
            UserLNameEng = value.LNameEng;
        }

        public int? UserId { get; set; }
        public string UserUid { get; set; } = "";
        public string UserName { get; set; } = "";
        public string UserPwd { get; set; } = "";
        public string UserType { get; set; } = "";
        public string UserTitle { get; set; } = "";
        public string UserFName { get; set; } = "";
        public string UserMName { get; set; } = "";
        public string UserLName { get; set; } = "";
        public string UserTitleEng { get; set; } = "";
        public string UserFNameEng { get; set; } = "";
        public string UserMNameEng { get; set; } = "";
        public string UserLNameEng { get; set; } = "";

        public bool IsDeleted { get; set; } = false;

        public int OrganizationId { get; set; }

        string IName.Title { get => UserTitle; set => UserTitle = value; }
        string IName.FName { get => UserFName; set => UserFName = value; }
        string IName.MName { get => UserMName; set => UserMName = value; }
        string IName.LName { get => UserLName; set => UserLName = value; }
        string IName.TitleEng { get => UserTitleEng; set => UserTitleEng = value; }
        string IName.FNameEng { get => UserFNameEng; set => UserFNameEng = value; }
        string IName.MNameEng { get => UserMNameEng; set => UserMNameEng = value; }
        string IName.LNameEng { get => UserLNameEng; set => UserLNameEng = value; }
    }
}