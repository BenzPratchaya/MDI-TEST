using EnvisionIE.Entity.Global;
using System.Collections.Generic;

namespace EnvisionMDIService.Controllers
{
    public class DefaultAck
    {
        public static Ack Accept(string controllerName, string functionName = null) { return new Ack() { AcknowledgementCode = "AA", TextMessage = GetTextMessage(new List<string>(new string[] { controllerName, functionName, "Success" })) }; }
        public static Ack Reject(string controllerName, string functionName, string message) { return new Ack() { AcknowledgementCode = "AR", TextMessage = GetTextMessage(new List<string>(new string[] { controllerName, functionName, message })) }; }
        public static Ack Error(string controllerName, string functionName, string message) { return new Ack() { AcknowledgementCode = "AE", TextMessage = GetTextMessage(new List<string>(new string[] { controllerName, functionName, message })) }; }
        public static Ack Skip(string controllerName, string functionName) { return new Ack() { AcknowledgementCode = "AA", TextMessage = GetTextMessage(new List<string>(new string[] { controllerName, functionName, "Skip" })) }; }

        private static string GetTextMessage(List<string> message)
        {
            message.RemoveAll(x => (x ?? "").Trim() == "");

            return string.Join("->", message.ToArray());
        }
    }
}