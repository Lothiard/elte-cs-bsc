using System;
using System.IO;

namespace ELTE.DocuStat.Persistence
{
    internal class TxtFileManager: IFileManager
    {
        private readonly string _path;
        
        public TxtFileManager(string path)
        {
            _path = path;
        }

        public string Load()
        {
            try
            {
                return File.ReadAllText(_path);
            }
            catch (Exception ex)
            {
                throw new FileManagerException(ex.Message, ex);
            }
        }
    }
}

