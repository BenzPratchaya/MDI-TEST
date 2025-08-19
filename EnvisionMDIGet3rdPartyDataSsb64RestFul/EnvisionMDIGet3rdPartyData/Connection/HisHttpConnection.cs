using EnvisionIE.Connection.Engine;
using EnvisionIE.Operational;
using EnvisionIE.Operational.Miracle;
using EnvisionIEService.Api;
using EnvisionIEService.Entity;
using System;

namespace EnvisionMDIGet3rdPartyData.Connection
{
    public class HisHttpConnection : HttpEngine, IDisposable
    {
        private const string class_name = "HisHttp";

        private bool disposed = false;

        public HisHttpConnection(string controller) : base(null, ServiceConfig.HisHttpEncoding)
        {
            Callback += delegate (EngineCallbackEventArgs e)
            {
                if (e.EventFailure || ServiceConfig.HisHttpEnableTrace)
                {
                    IeServiceLog.Save(new IeLog()
                    {
                        OwnerName = IeServiceConfig.ServiceName,
                        ThirdPartyName = class_name,

                        Connection = e.Connection,

                        EventName = e.EventName,
                        EventData = e.EventData,

                        AcknowledgementCode = e.AcknowledgementCode,
                        TextMessage = e.TextMessage
                    });
                }
            };
        }

        ~HisHttpConnection() { Dispose(); }

        public override void Dispose()
        {
            if (disposed)
                return;

            base.Dispose();

            disposed = true;
        }

        public string GetPatientByHn(string hn)
        {
            RequestUrl = ServiceConfig.HisUrlPatient;

            MiJsonObjectList json_obj_param = new MiJsonObjectList();
            json_obj_param["ContextKey"] = ServiceConfig.HisContextKey;
            json_obj_param["HN"] = hn;
            //json_obj_param["FirstName"] = null;
            //json_obj_param["LastName"] = null;
            //json_obj_param["BirthDateTime"] = null;
            //json_obj_param["Gender"] = null; //1 = ชาย, 2 = หญิง
            //json_obj_param["IDCardType"] = null; //1:idcard , 5:passport
            //json_obj_param["IDCardNo"] = null;

            MiJsonObjectList json_obj = new MiJsonObjectList();
            json_obj["param"] = json_obj_param.ToJsonString();

            return Post(json_obj.ToJsonString());
        }
        public string GetPatientByVisitNo(string visitNo)
        {
            RequestUrl = ServiceConfig.HisUrlPatientByVisitNo;

            MiJsonObjectList json_obj_param = new MiJsonObjectList();
            json_obj_param["ContextKey"] = ServiceConfig.HisContextKey;
            json_obj_param["VN"] = visitNo;
            json_obj_param["VisitDateFrom"] = DateTime.Today;
            json_obj_param["VisitDateTo"] = DateTime.Today;

            MiJsonObjectList json_obj = new MiJsonObjectList();
            json_obj["param"] = json_obj_param.ToJsonString();

            return Post(json_obj.ToJsonString());
        }
        public string SetData(MiJsonObjectList json)
        {
            RequestUrl = ServiceConfig.HisUrlResult;

            json["ContextKey"] = ServiceConfig.HisContextKey;

            MiJsonObjectList json_obj = new MiJsonObjectList();
            json_obj["param"] = json.ToJsonString();

            return Post(json_obj.ToJsonString());
        }

        public override string Post(string body = null, int timeRetry = 3)
        {
            string ack_message = base.Post(body, timeRetry);

            if (!EventFailure)
            {
                using (MiJsonObjectList json_obj_ack = new MiJsonObjectList(ack_message))
                {
                    Ack.AcknowledgementCode = Utilities.ToBoolean(json_obj_ack["ResultStatus"]) ? "AA" : "AE";
                    Ack.TextMessage = json_obj_ack["ErrorMessage"].ToString();
                }
            }

            return ack_message;
        }
    }
}