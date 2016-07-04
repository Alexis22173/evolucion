using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;

namespace SIS_BLANKITO.control
{
    public class clsEncriptacion
    {
        #region Encriptar
        /// Metodo de Encriptacion que contiene un Key por Default
        public static string Encriptar(string plainText)
        {
            try
            {
                if (!String.IsNullOrEmpty(plainText))
                {
                    string passPhrase = "@1B2c3D4e5F6g7H8x1cr3t22";
                    string saltValue = "@1B2c3D4e5F6g7H8";
                    string hashAlgorithm = "SHA1";
                    int passwordIterations = 2;
                    string initVector = "@1B2c3D4e5F6g7H8";
                    int keySize = 256;

                    byte[] initVectorBytes = Encoding.ASCII.GetBytes(initVector);
                    byte[] saltValueBytes = Encoding.ASCII.GetBytes(saltValue);

                    byte[] plainTextBytes = Encoding.UTF8.GetBytes(plainText);

                    PasswordDeriveBytes password = new PasswordDeriveBytes(passPhrase, saltValueBytes, hashAlgorithm, passwordIterations);

                    byte[] keyBytes = password.GetBytes(keySize / 8);
                    RijndaelManaged symmetricKey = new RijndaelManaged();

                    symmetricKey.Mode = CipherMode.CBC;

                    ICryptoTransform encryptor = symmetricKey.CreateEncryptor(keyBytes, initVectorBytes);

                    MemoryStream memoryStream = new MemoryStream();
                    CryptoStream cryptoStream = new CryptoStream(memoryStream, encryptor, CryptoStreamMode.Write);

                    cryptoStream.Write(plainTextBytes, 0, plainTextBytes.Length);
                    cryptoStream.FlushFinalBlock();
                    byte[] cipherTextBytes = memoryStream.ToArray();
                    memoryStream.Close();
                    cryptoStream.Close();
                    string cipherText = Convert.ToBase64String(cipherTextBytes);
                    return cipherText;
                }
                else
                {
                    return "";
                }
            }
            catch (Exception)
            {
                return "";
            }
        }

        /// Metodo de Encriptacion que se tiene que mandar la Key para Encriptar
        public static string Encriptar(string C_ENCRYPTION_KEY, string C_ENCRYPTION_SALTVALUE, string plainText)
        {
            try
            {
                string passPhrase = C_ENCRYPTION_KEY;
                string saltValue = C_ENCRYPTION_SALTVALUE;
                string hashAlgorithm = "SHA1";
                int passwordIterations = 2;
                string initVector = "@1B2c3D4e5F6g7H8";
                int keySize = 256;

                byte[] initVectorBytes = Encoding.ASCII.GetBytes(initVector);
                byte[] saltValueBytes = Encoding.ASCII.GetBytes(saltValue);

                byte[] plainTextBytes = Encoding.UTF8.GetBytes(plainText);

                PasswordDeriveBytes password = new PasswordDeriveBytes(passPhrase, saltValueBytes, hashAlgorithm, passwordIterations);

                byte[] keyBytes = password.GetBytes(keySize / 8);
                RijndaelManaged symmetricKey = new RijndaelManaged();

                symmetricKey.Mode = CipherMode.CBC;

                ICryptoTransform encryptor = symmetricKey.CreateEncryptor(keyBytes, initVectorBytes);

                MemoryStream memoryStream = new MemoryStream();
                CryptoStream cryptoStream = new CryptoStream(memoryStream, encryptor, CryptoStreamMode.Write);

                cryptoStream.Write(plainTextBytes, 0, plainTextBytes.Length);
                cryptoStream.FlushFinalBlock();
                byte[] cipherTextBytes = memoryStream.ToArray();
                memoryStream.Close();
                cryptoStream.Close();
                string cipherText = Convert.ToBase64String(cipherTextBytes);
                return cipherText;
            }
            catch (Exception)
            {
                return "";
            }
        }
        #endregion

        #region Desencriptar
        /// Metodo de Desencriptacion que contiene un Key por Default
        public static string Desencriptar(string cipherText)
        {
            try
            {
                string passPhrase = "@1B2c3D4e5F6g7H8x1cr3t22";
                string saltValue = "@1B2c3D4e5F6g7H8";
                string hashAlgorithm = "SHA1";
                int passwordIterations = 2;
                string initVector = "@1B2c3D4e5F6g7H8";
                int keySize = 256;
                byte[] initVectorBytes = Encoding.ASCII.GetBytes(initVector);
                byte[] saltValueBytes = Encoding.ASCII.GetBytes(saltValue);
                byte[] cipherTextBytes = Convert.FromBase64String(cipherText);

                PasswordDeriveBytes password = new PasswordDeriveBytes(passPhrase, saltValueBytes, hashAlgorithm, passwordIterations);
                byte[] keyBytes = password.GetBytes(keySize / 8);

                RijndaelManaged symmetricKey = new RijndaelManaged();
                symmetricKey.Mode = CipherMode.CBC;

                ICryptoTransform decryptor = symmetricKey.CreateDecryptor(keyBytes, initVectorBytes);
                MemoryStream memoryStream = new MemoryStream(cipherTextBytes);

                CryptoStream cryptoStream = new CryptoStream(memoryStream, decryptor, CryptoStreamMode.Read);
                byte[] plainTextBytes = new byte[cipherTextBytes.Length];

                int decryptedByteCount = cryptoStream.Read(plainTextBytes, 0, plainTextBytes.Length);

                memoryStream.Close();
                cryptoStream.Close();
                string plainText = Encoding.UTF8.GetString(plainTextBytes, 0, decryptedByteCount);
  
                return plainText;
            }
            catch (Exception)
            {
                return "";
            }
        }

        /// Metodo para Desencriptacion que se tiene que mandar la Key para desencriptar
        public static string Desencriptar(string C_ENCRYPTION_KEY, string C_ENCRYPTION_SALTVALUE, string cipherText)
        {
            try
            {
                string passPhrase = C_ENCRYPTION_KEY;
                string saltValue = C_ENCRYPTION_SALTVALUE;
                string hashAlgorithm = "SHA1";
                int passwordIterations = 2;
                string initVector = "@1B2c3D4e5F6g7H8";
                int keySize = 256;

                byte[] initVectorBytes = Encoding.ASCII.GetBytes(initVector);
                byte[] saltValueBytes = Encoding.ASCII.GetBytes(saltValue);

                byte[] cipherTextBytes = Convert.FromBase64String(cipherText);

                PasswordDeriveBytes password = new PasswordDeriveBytes(passPhrase, saltValueBytes, hashAlgorithm, passwordIterations);
                byte[] keyBytes = password.GetBytes(keySize / 8);

                RijndaelManaged symmetricKey = new RijndaelManaged();
                symmetricKey.Mode = CipherMode.CBC;

                ICryptoTransform decryptor = symmetricKey.CreateDecryptor(keyBytes, initVectorBytes);
                MemoryStream memoryStream = new MemoryStream(cipherTextBytes);
                CryptoStream cryptoStream = new CryptoStream(memoryStream, decryptor, CryptoStreamMode.Read);

                byte[] plainTextBytes = new byte[cipherTextBytes.Length];
                int decryptedByteCount = cryptoStream.Read(plainTextBytes, 0, plainTextBytes.Length);

                memoryStream.Close();
                cryptoStream.Close();
                string plainText = Encoding.UTF8.GetString(plainTextBytes, 0, decryptedByteCount);
                return plainText;
            }
            catch (Exception)
            {
                return "";
            }
        }
        #endregion
    }
}