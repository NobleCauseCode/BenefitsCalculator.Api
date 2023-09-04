using Newtonsoft.Json;

namespace Api.Common.Converters
{
    public class DecimalConverter : JsonConverter
    {
        private int _precision;

        public DecimalConverter(int precision)
        {
            _precision = precision;
        }

        public override bool CanConvert(Type objectType)
        {
            return true;
        }

        public override object ReadJson(JsonReader reader, Type objectType, object existingValue, JsonSerializer serializer)
        {
            if (reader.TokenType == JsonToken.Null) return null;

            // Advance to first token
            reader.Read();

            if (reader.TokenType == JsonToken.StartObject)
            {
                return serializer.Deserialize(reader, objectType);
            }

            if (reader.TokenType == JsonToken.Float || reader.TokenType == JsonToken.Integer)
            {

                var value = reader.Value as decimal?;

                if (value.HasValue)
                {
                    return Math.Round(value.Value, _precision);
                }
            }

            return reader.Value;
        }

        public override void WriteJson(JsonWriter writer, object value, JsonSerializer serializer)
        {
            writer.WriteValue((decimal)value);
        }
    }
}
