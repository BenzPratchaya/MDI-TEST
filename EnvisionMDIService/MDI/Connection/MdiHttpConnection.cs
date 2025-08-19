using EnvisionIE.Connection.Engine;
using EnvisionIE.Entity.Global;
using EnvisionIE.Hl7;
using EnvisionIE.Operational.Miracle;
using EnvisionIEService.Api;
using EnvisionIEService.Entity;
using MDI.Entity;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.NetworkInformation;
using System.Text;
using System.Text.RegularExpressions;
using System.Timers;

namespace MDI.Connection
{
    public class MdiHttpConnection : IDisposable
    {
        private const string class_name = "MdiHttp";
        private const string format_datetime = "yyyyMMddHHmmss";

        private bool disposed = false;

        public Ack Ack = new Ack();

        private HttpEngine http_engine = null;
        private string request_url = "";

        private Timer timer_wakeup = new Timer();

        public MdiHttpConnection(string requestUrl, Encoding encoding, bool enableTrace)
        {
            request_url = requestUrl;

            http_engine = new HttpEngine(request_url, encoding);
            http_engine.Callback += delegate (EngineCallbackEventArgs e)
            {
                if (e.EventFailure || enableTrace)
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

            timer_wakeup.Elapsed += TimerWakeup_Elapsed;
            timer_wakeup.Interval = 1000;
            timer_wakeup.Start();
        }

        private void TimerWakeup_Elapsed(object sender, ElapsedEventArgs e)
        {
            http_engine.RequestUrl = request_url + "/EnvisionMDIService/Service/Welcome";

            Post(new MiJsonObjectList());

            timer_wakeup.Interval = 10000;
        }

        ~MdiHttpConnection() { Dispose(); }

        public void Dispose()
        {
            if (disposed)
                return;

            http_engine?.Dispose();

            disposed = true;
        }

        public string Patient_SelectByHn(string hn, string modalityUid)
        {
            http_engine.RequestUrl = request_url + "/EnvisionMDIService/Patient/SelectByHn";

            MiJsonObjectList json = new MiJsonObjectList();
            json["ModalityUid"] = modalityUid;
            json["Hn"] = hn;

            return Post(json);
        }

        public string Modality_SelectByModalityUid(string modalityUid)
        {
            http_engine.RequestUrl = request_url + "/EnvisionMDIService/Modality/SelectByModalityUid";

            MiJsonObjectList json = new MiJsonObjectList();
            json["ModalityUid"] = modalityUid;

            return Post(json);
        }

        public string Service_GetMessage(DeviceData data)
        {
            http_engine.RequestUrl = request_url + "/EnvisionMDIService/Service/GetMessage";

            MiJsonObjectList json = new MiJsonObjectList();
            json["EventName"] = "Direct";
            json["ClientIp"] = GetIPAddress();
            json["Message"] = Hl7Manager.ConcatSegment(
                    ToMshSegment(data),
                    ToPidSegment(data),
                    ToPv1Segment(data),
                    ToOrcSegment(data),
                    ToObrSegment(data),
                    ToObxSegment(data));

            return Post(json);
        }

        private string Post(MiJsonObjectList json)
        {
            //try
            //{
            //    string host = new Uri(http_engine.RequestUrl).Host;

            //    PingReply ping_reply = new Ping().Send(host);

            //    if (ping_reply.Status == IPStatus.TimedOut)
            //    {
            //        http_engine.Ack.AcknowledgementCode = "AE";
            //        http_engine.Ack.TextMessage = $"'{host}' connect timeout";

            //        return "";
            //    }
            //}
            //catch { }

            json["ServiceName"] = IeServiceConfig.ServiceName;
            json["MdiVersion"] = Env.MdiVersion;

            string json_message = http_engine.Post(json.ToJsonStringLite());

            Ack = http_engine.EventFailure
                ? http_engine.Ack
                : new MiJsonObjectList(json_message).To<Ack>();

            return json_message;
        }

        private string ToMshSegment(DeviceData data)
        {
            List<string> fields = new List<string>(new string[64]);
            fields[0] = "MSH";
            fields[1] = "^~\\&";
            fields[2] = "MonitoringWH";
            fields[3] = "";
            fields[4] = "";
            fields[5] = "";
            fields[6] = DateTime.Now.ToString(format_datetime);
            fields[7] = "";
            fields[8] = "ORU^R01";
            fields[9] = data.MessageControlId;
            fields[10] = "P";
            fields[11] = "2.3";

            return Hl7Manager.ConcatField(fields.ToArray());
        }
        private string ToPidSegment(DeviceData data)
        {
            List<string> fields = new List<string>(new string[64]);
            fields[0] = "PID";
            fields[1] = "1";
            fields[2] = "";
            fields[3] = data.Hn;

            return Hl7Manager.ConcatField(fields.ToArray());
        }
        private string ToPv1Segment(DeviceData data)
        {
            List<string> fields = new List<string>(new string[64]);
            fields[0] = "PV1";
            fields[1] = "1";
            fields[2] = "";
            fields[3] = "";
            fields[4] = "";
            fields[5] = "";
            fields[6] = "";
            fields[7] = "";
            fields[8] = "";
            fields[9] = "";
            fields[10] = "";
            fields[11] = "";
            fields[12] = "";
            fields[13] = "";
            fields[14] = "";
            fields[15] = "";
            fields[16] = "";
            fields[17] = "";
            fields[18] = "";
            fields[19] = data.VisitNo;

            return Hl7Manager.ConcatField(fields.ToArray());
        }
        private string ToOrcSegment(DeviceData data)
        {
            List<string> fields = new List<string>(new string[64]);
            fields[0] = "ORC";
            fields[1] = "";
            fields[2] = "";
            fields[3] = "";
            fields[4] = "";
            fields[5] = "";
            fields[6] = "";
            fields[7] = "";
            fields[8] = "";
            fields[9] = "";
            fields[10] = "";
            fields[11] = "";
            fields[12] = "";
            fields[13] = "";
            fields[14] = "";
            fields[15] = "";
            fields[16] = "";
            fields[17] = "";
            fields[18] = ServiceConfig.ModalityConfig.ModalityUid;

            return Hl7Manager.ConcatField(fields.ToArray());
        }
        private string ToObrSegment(DeviceData data)
        {
            List<string> fields = new List<string>(new string[64]);
            fields[0] = "OBR";
            fields[1] = "1";

            return Hl7Manager.ConcatField(fields.ToArray());
        }
        private string ToObxSegment(DeviceData data)
        {
            List<string> segments = new List<string>();


            Func<string, string, string, string, string, string[]> func = delegate (string identifier, string observation, string unit, string flag, string method)
            {
                List<string> fields = new List<string>(new string[64]);
                fields[0] = "OBX";
                fields[1] = "";
                fields[2] = "NM";
                fields[3] = Hl7Manager.ConcatComponent("", identifier);
                fields[4] = "";
                fields[5] = observation;
                fields[6] = Hl7Manager.ConcatComponent("", unit);
                fields[7] = "";
                fields[8] = Hl7Manager.ConcatComponent("", flag);
                fields[9] = "";
                fields[10] = "";
                fields[11] = "";
                fields[12] = "";
                fields[13] = "";
                fields[14] = "";
                fields[15] = "";
                fields[16] = "";
                fields[17] = Hl7Manager.ConcatComponent("", method);

                return fields.ToArray();
            };

            if (data.Weight > decimal.Zero)
                segments.Add(Hl7Manager.ConcatField(func("Weight", data.Weight.ToString(), data.WeightUnit, "", "")));

            if (data.Height > decimal.Zero)
                segments.Add(Hl7Manager.ConcatField(func("Height", data.Height.ToString(), data.HeightUnit, "", "")));

            if (data.Bmi > decimal.Zero)
                segments.Add(Hl7Manager.ConcatField(func("BMI", data.Bmi.ToString(), "", "", "")));

            if (data.PainScale > 0)
                segments.Add(Hl7Manager.ConcatField(func("PainScale", data.PainScale.ToString(), "", "", "")));

            if (data.PulseRate > 0)
                segments.Add(Hl7Manager.ConcatField(func("PulseRate", data.PulseRate.ToString(), data.PulseUnit, data.PulseFlag, "")));

            if (data.BloodPressureSystolic > 0)
                segments.Add(Hl7Manager.ConcatField(func("BloodPressureSystolic", data.BloodPressureSystolic.ToString(), data.BloodPressureUnit, "", data.BloodPressureMethod)));

            if (data.BloodPressureDiastolic > 0)
                segments.Add(Hl7Manager.ConcatField(func("BloodPressureDiastolic", data.BloodPressureDiastolic.ToString(), data.BloodPressureUnit, "", data.BloodPressureMethod)));

            if (data.BloodPressureMean > 0)
                segments.Add(Hl7Manager.ConcatField(func("BloodPressureMean", data.BloodPressureMean.ToString(), data.BloodPressureUnit, "", data.BloodPressureMethod)));

            if (data.SpO2 > decimal.Zero)
                segments.Add(Hl7Manager.ConcatField(func("SpO2", data.SpO2.ToString(), data.SpO2Unit, "", "")));

            if (data.Temperature > decimal.Zero)
                segments.Add(Hl7Manager.ConcatField(func("Temperature", data.Temperature.ToString(), data.TemperatureUnit, "", data.TemperatureMethod)));

            if (data.BloodGlucose > decimal.Zero)
                segments.Add(Hl7Manager.ConcatField(func("BloodGlucose", data.BloodGlucose.ToString(), data.BloodGlucoseUnit, "", "")));

            if (data.RespirationRate > 0)
                segments.Add(Hl7Manager.ConcatField(func("RespirationRate", data.RespirationRate.ToString(), "", "", "")));

            return Hl7Manager.ConcatSegment(segments.ToArray());
        }

        #region ใช้งานชั่วคร่าว
        public static string GetIPAddress(string hostName = null)
        {
            List<string> ip_addresses = GetIPAddresses(hostName ?? Dns.GetHostName());

            if (ip_addresses.Count == 0)
                return hostName;

            return ip_addresses[0];

            //return ip_addresses.Exists(x => x == "127.0.0.1")
            //    ? "127.0.0.1"
            //    : ip_addresses[0];
        }
        public static List<string> GetIPAddresses(string hostName)
        {
            List<string> ip_addresses = new List<string>();

            if (string.IsNullOrEmpty(hostName))
                return ip_addresses;

            //if (new List<string>() { ".", "localhost" }.Contains(hostName.ToLower()))
            //    hostName = "127.0.0.1";

            if (!CheckValidIpAddress(hostName))
            {
                List<IPAddress> address_list = new List<IPAddress>();

                if (address_list.Count == 0)
                {
                    try
                    {
                        address_list.AddRange(new List<IPAddress>(Dns.GetHostEntry(hostName).AddressList));
                    }
                    catch { }
                }

                if (address_list.Count == 0)
                {
                    try
                    {
                        address_list.AddRange(new List<IPAddress>(Dns.GetHostAddresses(hostName)));
                    }
                    catch { }
                }

                if (address_list.Count == 0)
                {
                    try
                    {
                        address_list.AddRange(new List<IPAddress>(Dns.GetHostByName(hostName).AddressList));
                    }
                    catch { }
                }

                if (address_list.Count > 0)
                {
                    ip_addresses = address_list.ConvertAll(x => x.ToString()).Distinct().ToList();
                    ip_addresses.RemoveAll(x => !CheckValidIpAddress(x));

                    return ip_addresses;
                }
            }

            ip_addresses.Add(hostName);

            return ip_addresses;
        }
        public static bool CheckValidIpAddress(string data) { return Regex.IsMatch(data, @"^(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])$"); }
        #endregion
    }
}