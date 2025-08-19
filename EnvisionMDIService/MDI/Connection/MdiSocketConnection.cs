using EnvisionIE.Connection.Engine;
using EnvisionIE.Entity.Global;
using EnvisionIE.Hl7;
using EnvisionIEService.Api;
using EnvisionIEService.Entity;
using MDI.Entity;
using System;
using System.Collections.Generic;

namespace MDI.Connection
{
    public class MdiSocketConnection : SocketEngine, IDisposable
    {
        private const string class_name = "MdiSocket";
        private const string format_datetime = "yyyyMMddHHmmss";

        private bool disposed = false;

        public MdiSocketConnection() : base()
        {
            Callback += delegate (EngineCallbackEventArgs e)
            {
                if (e.EventFailure || ServiceConfig.ModalityConfig.MdiSocketEnableTrace)
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

        ~MdiSocketConnection() { Dispose(); }

        public override void Dispose()
        {
            if (disposed)
                return;

            base.Dispose();

            disposed = true;
        }

        public string Send(DeviceData data)
        {
            if (string.IsNullOrEmpty(ServiceConfig.ModalityConfig.MdiSocketIp) )
            {
                Ack.AcknowledgementCode = "AR";
                Ack.TextMessage = "Mdi socket ip null or empty";

                return "";
            }

            string hl7_message = Send(
                ServiceConfig.ModalityConfig.MdiSocketIp,
                ServiceConfig.ModalityConfig.MdiSocketPort,
                Hl7Manager.ConcatSegment(
                    ToMshSegment(data),
                    ToPidSegment(data),
                    ToPv1Segment(data),
                    ToOrcSegment(data),
                    ToObrSegment(data),
                    ToObxSegment(data)),
                ServiceConfig.ModalityConfig.MdiSocketEncoding,
                1);

            if (!EventFailure)
                Ack = new Ack(Hl7AckConverter.ToObject(hl7_message));

            return hl7_message;
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
    }
}