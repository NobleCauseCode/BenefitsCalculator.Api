namespace Api.Common.Exceptions
{
    public class DependentNotFoundException: Exception
    {
        public DependentNotFoundException() { }
        public DependentNotFoundException(string message) : base(message) { }
        public DependentNotFoundException(string message, System.Exception inner) : base(message, inner) { }
        protected DependentNotFoundException(
          System.Runtime.Serialization.SerializationInfo info,
          System.Runtime.Serialization.StreamingContext context) : base(info, context) { }

    }
}
