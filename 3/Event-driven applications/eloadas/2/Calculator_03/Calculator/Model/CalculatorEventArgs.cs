using System;

namespace ELTE.Calculator.Model
{
    /// <summary>
    /// Számológép eseményargumentum típusa.
    /// </summary>
    public class CalculatorEventArgs : EventArgs
    {
        private Double _result;
        private String _calculationString;

        /// <summary>
        /// Eredmény lekérdezése.
        /// </summary>
        public Double Result { get { return _result; } }
        /// <summary>
        /// Számítás szöveges lekérdezése.
        /// </summary>
        public String CalculationString { get { return _calculationString; } }

        /// <summary>
        /// Számológép eseményargumentum példányosítása.
        /// </summary>
        /// <param name="result">Eredmény.</param>
        /// <param name="calculationString">Számítás szövege.</param>
        public CalculatorEventArgs(Double result, String calculationString)
        {
            _result = result;
            _calculationString = calculationString;
        }
    }
}
