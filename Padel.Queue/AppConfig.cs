namespace Padel.Queue
{
    public class AppConfig
    {
        public string AwsRegion                   { get; set; }
        public string AwsAccessKey                { get; set; }
        public string AwsSecretKey                { get; set; }
        public string AwsQueueName                { get; set; }
        public string AwsDeadLetterQueueName      => AwsQueueName + "-dlq";
        public int    AwsQueueLongPollTimeSeconds { get; set; }

        public int      AwsQueueMaxRetries { get; set; }
        public string[] Topics             { get; set; }
    }
}