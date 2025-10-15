using iText.Kernel.Pdf.Canvas.Parser;
using iText.Kernel.Pdf;
using System;
using System.Text;

namespace ELTE.DocuStat.Persistence
{
    internal class PdfFileManager: IFileManager
    {
        private readonly string _path;

        public PdfFileManager(string path)
        {
            _path = path;
        }

        public string Load()
        {
            try
            {
                using PdfReader reader = new PdfReader(_path);
                using PdfDocument document = new PdfDocument(reader);

                StringBuilder text = new StringBuilder();
                for (int i = 1; i <= document.GetNumberOfPages(); i++)
                {
                    PdfPage page = document.GetPage(i);
                    text.Append(PdfTextExtractor.GetTextFromPage(page));
                }
                return text.ToString();
            }
            catch (Exception ex)
            {
                throw new FileManagerException(ex.Message, ex);
            }
        }
    }
}
