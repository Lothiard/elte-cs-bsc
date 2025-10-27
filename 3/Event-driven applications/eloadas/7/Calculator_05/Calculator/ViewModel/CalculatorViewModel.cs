using ELTE.Calculator.Model;
using System;
using System.Collections.ObjectModel;
using System.ComponentModel;
using System.Runtime.CompilerServices;
using System.Windows;

namespace ELTE.Calculator.ViewModel
{
    /// <summary>
    /// Számológép nézetmodell típusa.
    /// </summary>
    public class CalculatorViewModel : INotifyPropertyChanged
    {
        private CalculatorModel _model;
        private String _numberFieldValue;

        /// <summary>
        /// Beviteli mező szövegének lekérdezése, vagy beállítása.
        /// </summary>
        public String NumberFieldValue 
        { 
            get { return _numberFieldValue; } 
            set 
            {
                if (_numberFieldValue != value)
                {
                    _numberFieldValue = value; 
                    OnPropertyChanged(); 
                }
           } 
        }
        
        /// <summary>
        /// Számítások listájának lekérdezése.
        /// </summary>
        public ObservableCollection<String> Calculations { get; private set; }
        
        /// <summary>
        /// Számítás parancsának lekérdezése.
        /// </summary>
        public DelegateCommand CalculateCommand { get; private set; }

        /// <summary>
        /// Tulajdonság változásának eseménye.
        /// </summary>
        public event PropertyChangedEventHandler? PropertyChanged;

        public CalculatorViewModel()
        {
            CalculateCommand = new DelegateCommand(param => Calculate(param?.ToString() ?? String.Empty));

            Calculations = new ObservableCollection<String>();

            _model = new CalculatorModel();
            _model.CalculationPerformed += new EventHandler<CalculatorEventArgs>(Model_CalculationPerformed);
            _numberFieldValue = "0";
        }

        /// <summary>
        /// Számítás végrehajtásának eseménykezelője.
        /// </summary>
        /// <param name="sender">Küldő</param>
        /// <param name="e">Eseményargumentumok.</param>
        private void Model_CalculationPerformed(object? sender, CalculatorEventArgs e)
        {
            NumberFieldValue = e.Result.ToString(); // eredmény és művelet kiírása

            if (!String.IsNullOrEmpty(e.CalculationString))
               Calculations.Insert(0, e.CalculationString);    
        }

        /// <summary>
        /// Számítás végrehajtása.
        /// </summary>
        /// <param name="operatorString">A művelet szöveges megfelelője.</param>
        private void Calculate(String operatorString)
        {
            try
            {
                Double value = Double.Parse(_numberFieldValue); // szám lekérése

                switch (operatorString) // művelet végrehajtása a modellel
                {
                    case "+":
                        _model.Calculate(value, Operation.Add);
                        break;
                    case "-":
                        _model.Calculate(value, Operation.Subtract);
                        break;
                    case "*":
                        _model.Calculate(value, Operation.Multiply);
                        break;
                    case "/":
                        _model.Calculate(value, Operation.Divide);
                        break;
                    case "=":
                        _model.Calculate(value, Operation.None);
                        break;
                }

            }
            catch (OverflowException)
            {
                MessageBox.Show("Your input has to many digits!", "Calculation Error", MessageBoxButton.OK, MessageBoxImage.Error);
            }
            catch (FormatException)
            {
                MessageBox.Show("Your input is not a real number!\nPlease correct!", "Calculation Error", MessageBoxButton.OK, MessageBoxImage.Error);
            }
            catch (NullReferenceException)
            {
                MessageBox.Show("No number in input!\nPlease correct!", "Calculation Error", MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }

        /// <summary>
        /// Tulajdonságváltozás eseménykliváltása.
        /// </summary>
        /// <param name="property">A tulajdonság neve.</param>
        private void OnPropertyChanged([CallerMemberName] String? property = null)
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(property));
        }
    }
}
