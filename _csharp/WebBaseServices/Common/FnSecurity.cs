using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Cryptography;
using System.Text;

namespace WebBaseServices.Common
{
    class FnSecurity
    {
        const string SALT_PASSWORD = "fw6do4jv";

        public static string GeneratePassword(string value)
        {
            return GenerateHash(SALT_PASSWORD, value);
        }
        private static string GenerateHash(string salt, string value)
        {
            byte[] data = System.Text.Encoding.ASCII.GetBytes(salt + value);
            data = System.Security.Cryptography.MD5.Create().ComputeHash(data);
            return Convert.ToBase64String(data);
        }
    }
}
