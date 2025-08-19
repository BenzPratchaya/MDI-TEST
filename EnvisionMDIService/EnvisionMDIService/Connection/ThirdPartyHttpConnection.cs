using EnvisionIE.Connection.Engine;
using EnvisionIE.Entity.Global;
using EnvisionIE.Operational;
using EnvisionIE.Operational.Miracle;
using EnvisionIEService.Api;
using EnvisionIEService.Entity;
using EnvisionMDI.Entity;
using System;
using System.Data;

namespace EnvisionMDIService.Connection
{
    public class ThirdPartyHttpConnection : HttpEngine, IDisposable
    {
        private const string class_name = "ThirdPartyHttpConnection";

        private bool disposed = false;

        public MdiDbConnection mdi_db = new MdiDbConnection(class_name);

        public ThirdPartyHttpConnection(string controller) : base()
        {
            Callback += delegate (EngineCallbackEventArgs e)
            {
                if (e.EventFailure || ServiceConfig.MdiDbEnableTrace)
                {
                    IeServiceLog.Save(new IeLog()
                    {
                        OwnerName = IeServiceConfig.ServiceName,
                        ThirdPartyName = "ThirdPartyHttp",

                        Connection = e.Connection,

                        EventName = e.EventName,
                        EventData = e.EventData,

                        AcknowledgementCode = e.AcknowledgementCode,
                        TextMessage = e.TextMessage
                    });
                }
            };
        }
        ~ThirdPartyHttpConnection() { Dispose(); }

        public override void Dispose()
        {
            if (disposed)
                return;

            mdi_db?.Dispose();
            mdi_db = null;

            base.Dispose();

            disposed = true;
        }

        public string PostGetPatient(string hn, int organizationId)
        {
            MiJsonObjectList json = new MiJsonObjectList();
            json["Hn"] = hn;

            return Post(json, "GetPatient", organizationId);
        }
        public string PostGetPatientByVn(string vn, int organizationId)
        {
            MiJsonObjectList json = new MiJsonObjectList();
            json["VisitNo"] = vn;

            return Post(json, "GetPatient", organizationId);
        }
        public string PostSetDataByPatientVisitId(int patientVisitId, int organizationId)
        {
            MiJsonObjectList json = new MiJsonObjectList();
            json["PatientVisitId"] = patientVisitId;

            DataSet ds_mdi = mdi_db.SelectDataSet(SqlScriptName.Data_SelectSend3rdPartyByPatientVisitId, json);

            if (!Utilities.HasData(ds_mdi))
                return "";

            foreach (DataTable dtt_mdi in ds_mdi.Tables)
                dtt_mdi.TableName = dtt_mdi.TableName.Replace("Data_SelectSend3rdPartyByPatientVisitId", "Data");

            ds_mdi.AcceptChanges();

            json.Add(ds_mdi);

            return Post(json, "SetData", organizationId);
        }
        public string PostSetDataByDataId(int dataId, int organizationId)
        {
            MiJsonObjectList json = new MiJsonObjectList();
            json["DataId"] = dataId;

            DataSet ds_mdi = mdi_db.SelectDataSet(SqlScriptName.Data_SelectSend3rdPartyByDataId, json);

            if (!Utilities.HasData(ds_mdi))
                return "";

            foreach (DataTable dtt_mdi in ds_mdi.Tables)
                dtt_mdi.TableName = dtt_mdi.TableName.Replace("Data_SelectSend3rdPartyByDataId", "Data");

            ds_mdi.AcceptChanges();

            json.Add(ds_mdi);

            return Post(json, "SetData", organizationId);
        }

        public string Post(MiJsonObjectList obj, string actionName, int organizationId)
        {
            Organization organization = new MdiDbConnection(class_name).Organization_SelectByOrganizationId(organizationId);

            if (organization == null || string.IsNullOrEmpty(organization.ThirdPartyUrl))
                return "";

            RequestUrl = $"{organization.ThirdPartyUrl.TrimEnd(new char[] { '/' })}/{actionName}";
            Encoding = organization.ThirdPartyEncoding;

            string ack_message = Post(obj.ToJsonStringLite());

            if (!EventFailure)
            {
                using (MiJsonObjectList json_obj_ack = new MiJsonObjectList(ack_message))
                    Ack = json_obj_ack.To<Ack>();
            }

            return ack_message;
        }
    }
}