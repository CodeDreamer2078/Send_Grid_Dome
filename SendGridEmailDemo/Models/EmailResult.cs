namespace SendGridEmailDemo.Models
{
    /// <summary>
    /// Encapsulates the outcome of an email send operation.
    /// </summary>
    public class EmailResult
    {
        public bool IsSuccess { get; set; }

        public string Message { get; set; }

        public int StatusCode { get; set; }

        public static EmailResult Success(string message, int statusCode)
        {
            return new EmailResult
            {
                IsSuccess = true,
                Message = message,
                StatusCode = statusCode
            };
        }

        public static EmailResult Failure(string message, int statusCode = 0)
        {
            return new EmailResult
            {
                IsSuccess = false,
                Message = message,
                StatusCode = statusCode
            };
        }
    }
}
