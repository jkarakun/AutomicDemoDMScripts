$source = @"

    using System.IO;
    using System.Runtime.InteropServices;
    using System.Text;

    public static class IniFile
    {
        [DllImport("kernel32.dll", CharSet = CharSet.Unicode, SetLastError = true)]
        [return: MarshalAs(UnmanagedType.Bool)]
        private static extern bool WritePrivateProfileString(string lpAppName,
           string lpKeyName, string lpString, string lpFileName);

        [DllImport("kernel32.dll", CharSet = CharSet.Unicode)]
        static extern uint GetPrivateProfileString(
           string lpAppName,
           string lpKeyName,
           string lpDefault,
           StringBuilder lpReturnedString,
           uint nSize,
           string lpFileName);

        public static void WriteValue(string filePath, string section, string key, string value)
        {
            string fullPath = Path.GetFullPath(filePath);
            bool result = WritePrivateProfileString(section, key, value, fullPath);
        }

        public static string GetValue(string filePath, string section, string key, string defaultValue)
        {
            string fullPath = Path.GetFullPath(filePath);
            var sb = new StringBuilder(500);
            GetPrivateProfileString(section, key, defaultValue, sb, (uint)sb.Capacity, fullPath);
            return sb.ToString();
        }
    }
"@

Add-Type -TypeDefinition $source

function Set-IniValue {

   param (
       [string]$path,
       [string]$section,
       [string]$key,
       [string]$value
   )

   $fullPath = [System.IO.Path]::GetFullPath($(Join-Path $pwd $path))
   [IniFile]::WriteValue($fullPath, $section, $key, $value)
}
