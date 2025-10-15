using System;
using System.IO;

namespace ELTE.DocuStat.Persistence
{
	public class FileManagerException : IOException
	{
		public FileManagerException() { }
		public FileManagerException(string message) : base(message) { }
		public FileManagerException(string message, Exception inner) : base(message, inner) { }
	}
}
