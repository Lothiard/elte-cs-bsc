using iText.Kernel.Pdf.Canvas.Parser;
using iText.Kernel.Pdf;
using System;
using System.Text;
using System.Threading.Tasks;

namespace ELTE.DocuStat.Persistence
{
    internal class PdfFileManager: IFileManager
    {
        private readonly string _path;

        public PdfFileManager(string path)
        {
            _path = path;
        }

        public async Task<string> LoadAsync()
        {
            try
            {
                using PdfReader reader = new PdfReader(_path);
                using PdfDocument document = new PdfDocument(reader);

                return await Task.Run(() =>
                {
                    StringBuilder text = new StringBuilder();
                    for (int i = 1; i <= document.GetNumberOfPages(); i++)
                    {
                        PdfPage page = document.GetPage(i);
                        text.Append(PdfTextExtractor.GetTextFromPage(page));
                        // According to the documentation of iText7, only a single thread can access the same document at the same time.
                        // Therefore we do not read multiple pages concurrently here.
                    }
                    return text.ToString();
                });
            }
            catch (Exception ex)
            {
                throw new FileManagerException(ex.Message, ex);
            }
        }
    }
}
