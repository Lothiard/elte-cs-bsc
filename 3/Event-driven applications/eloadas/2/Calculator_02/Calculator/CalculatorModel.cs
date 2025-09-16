using System;

namespace ELTE.Calculator
{
    /// <summary>
    /// Művelet felsorolási típusa.
    /// </summary>
    public enum Operation { None, Add, Subtract, Multiply, Divide }

    /// <summary>
    /// Számológép típusa.
    /// </summary>
    public class CalculatorModel
    {
        private Double _result; // eredmény
        private String _calculationString; // szöveges leírás
        private Operation _operation; // utolsó művelet

        /// <summary>
        /// Aktuális eredmény lekérdezése.
        /// </summary>
        public Double Result { get { return _result; } }
        /// <summary>
        /// Aktuális számítás szöveges lekérdezése.
        /// </summary>
        public String CalculationString { get { return _calculationString; } }

        /// <summary>
        /// Számológép példányosítása.
        /// </summary>
        public CalculatorModel()
        {
            _result = 0;
            _calculationString = String.Empty;
            _operation = Operation.None;
        }

        /// <summary>
        /// Művelet végrehajtása.
        /// </summary>
        /// <param name="value">A második érték.</param>
        /// <param name="operation">Az új művelet.</param>
        public void Calculate(Double value, Operation operation)
        {
            if (_operation != Operation.None) // ha már volt művelet
            {
                switch (_operation) // végrehajtjuk a korábbi műveletet a két operandussal
                {
                    case Operation.Add:
                        _calculationString = _result + " + " + value + " = " + (_result + value);
                        _result = _result + value;
                        break;
                    case Operation.Subtract:
                        _calculationString = _result + " - " + value + " = " + (_result - value);
                        _result = _result - value;
                        break;
                    case Operation.Multiply:
                        _calculationString = _result + " * " + value + " = " + (_result * value);
                        _result = _result * value;
                        break;
                    case Operation.Divide:
                        _calculationString = _result + " / " + value + " = " + (_result / value);
                        _result = _result / value;
                        break;
                }
            }
            else
            {
                _result = value;
            }

            _operation = operation; // művelet eltárolása
        }
    }
}
