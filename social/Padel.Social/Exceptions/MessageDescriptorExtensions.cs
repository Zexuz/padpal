using Google.Protobuf;
using Google.Protobuf.Reflection;

namespace Padel.Social.Exceptions
{
    public static class MessageDescriptorExtensions
    {
        public static string GetMessageName(this MessageDescriptor descriptor)
        {
            return descriptor
                .GetOptions()
                .GetExtension(new Extension<MessageOptions, string>(418301, FieldCodec.ForString(1)));
        }
    }
}