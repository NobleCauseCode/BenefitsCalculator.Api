namespace Api.Common.Exceptions
{
    public class EmployeeNotFoundException:Exception
    {
        public EmployeeNotFoundException() { }
        public EmployeeNotFoundException(string message) : base(message) { }
        public EmployeeNotFoundException(string message, System.Exception inner) : base(message, inner) { }
        protected EmployeeNotFoundException(
          System.Runtime.Serialization.SerializationInfo info,
          System.Runtime.Serialization.StreamingContext context) : base(info, context) { }
    }
}
