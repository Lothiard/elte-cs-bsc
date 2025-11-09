using System;

namespace ELTE.ExamGenerator.ViewModel
{
    /// <summary>
    /// Üzenettípusok felsorolási típusa.
    /// </summary>
    public enum MessageType { Information, Error }

    /// <summary>
    /// Üzenet eseményargumentum típusa.
    /// </summary>
    public class ApplicationMessageEventArgs : EventArgs
    {
        /// <summary>
        /// Üzenet lekérdezése. vagy beállítása.
        /// </summary>
        public String Message { get; set; } = String.Empty;

        /// <summary>
        /// Üzenettípus lekérdezése, vagy beállítása.
        /// </summary>
        public MessageType Type { get; set; }
    }
}
