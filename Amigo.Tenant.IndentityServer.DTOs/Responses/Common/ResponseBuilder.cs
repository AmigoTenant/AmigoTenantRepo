﻿namespace Amigo.Tenant.IdentityServer.DTOs.Responses.Common
{
    public static class ResponseBuilder
    {
        public static ResponseDTO InCorrect()
        {
            return new ResponseDTO(false);
        }

        public static ResponseDTO Correct()
        {
            return new ResponseDTO(true);
        }

        public static ResponseDTO<T> InCorrect<T>()
        {
            return new ResponseDTO<T>(false);
        }

        public static ResponseDTO<T> Correct<T>(T data)
        {
            return new ResponseDTO<T>(true)
            {
                Data = data
            };
        }
        public static ResponseDTO<T> InCorrect<T>(T data)
        {
            return new ResponseDTO<T>(true)
            {
                Data = data,
                IsValid = false
            };
        }
    }
}