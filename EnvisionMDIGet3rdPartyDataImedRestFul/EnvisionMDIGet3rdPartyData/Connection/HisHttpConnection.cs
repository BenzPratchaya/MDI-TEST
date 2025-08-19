using EnvisionIE.Connection.Engine;
using EnvisionIEService.Api;
using EnvisionIEService.Entity;
using System;

namespace EnvisionMDIGet3rdPartyData.Connection
{
    public class HisHttpConnection : HttpEngine, IDisposable
    {
        private const string class_name = "HisTempDb";

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
            RequestUrl = ServiceConfig.HisUrlPatient.TrimEnd(new char[] { '/' }) + "/" + hn;

            return Get();
        }
        public string SetData(string json)
        {
            RequestUrl = ServiceConfig.HisUrlResult;

            return Post(json);
        }
    }
}