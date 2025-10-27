using System;

namespace ELTE.Calculator.Model
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
        private Operation _operation; // utolsó művelet

        /// <summary>
        /// Aktuális eredmény lekérdezése.
        /// </summary>
        public Double Result { get { return _result; } }

        /// <summary>
        /// Számítás végrehajtásának eseménye.
        /// </summary>
        public event EventHandler<CalculatorEventArgs>? CalculationPerformed;

        /// <summary>
        /// Számológép példányosítása.
        /// </summary>
        public CalculatorModel()
        {
            _result = 0;
            _operation = Operation.None;
        }

        /// <summary>
        /// Művelet végrehajtása.
        /// </summary>
        /// <param name="value">A második érték.</param>
        /// <param name="operation">Az új művelet.</param>
        public void Calculate(Double value, Operation operation)
        {
            String calculationString = String.Empty;

            if (_operation != Operation.None) // ha már volt művelet
            {
                switch (_operation) // végrehajtjuk a korábbi műveletet a két operandussal
                {
                    case Operation.Add:
                        calculationString = _result + " + " + value + " = " + (_result + value);
                        _result = _result + value;
                        break;
                    case Operation.Subtract:
                        calculationString = _result + " - " + value + " = " + (_result - value);
                        _result = _result - value;
                        break;
                    case Operation.Multiply:
                        calculationString = _result + " * " + value + " = " + (_result * value);
                        _result = _result * value;
                        break;
                    case Operation.Divide:
                        calculationString = _result + " / " + value + " = " + (_result / value);
                        _result = _result / value;
                        break;
                }
            }
            else
            {
                _result = value;
            }

            _operation = operation; // művelet eltárolása

            OnCalculationPerformed(calculationString);
        }

        /// <summary>
        /// Számítás végrehajtásának eseménykiváltása.
        /// </summary>
        /// <param name="calculationString">Számítás szövege.</param>
        private void OnCalculationPerformed(String calculationString)
        {
            if (CalculationPerformed != null)
                CalculationPerformed(this, new CalculatorEventArgs(_result, calculationString));
                // feltöltjük az eseményargumentumot
        }
    }
}
