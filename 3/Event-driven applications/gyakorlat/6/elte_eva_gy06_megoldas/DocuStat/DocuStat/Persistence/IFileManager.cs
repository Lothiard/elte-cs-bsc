using System.Threading.Tasks;

namespace ELTE.DocuStat.Persistence
{
    public interface IFileManager
    {
        Task<string> LoadAsync();
    }
}
