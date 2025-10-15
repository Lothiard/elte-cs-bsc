using System.IO;

namespace ELTE.DocuStat.Persistence
{
    public class FileManagerFactory
    {
        public static IFileManager? CreateForPath(string path) => Path.GetExtension(path) switch
        {
            ".txt" => new TxtFileManager(path),
            ".pdf" => new PdfFileManager(path),
            _      => null
        };
    }
}
