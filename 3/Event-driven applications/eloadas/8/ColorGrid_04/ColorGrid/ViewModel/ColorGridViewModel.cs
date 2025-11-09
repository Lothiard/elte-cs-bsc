using System;
using System.Collections.ObjectModel;

namespace ELTE.ColorGrid.ViewModel
{
    /// <summary>
    /// Színrács nézetmodell típusa.
    /// </summary>
    public class ColorGridViewModel : ViewModelBase
    {
        /// <summary>
        /// Sorok számának lekérdezée, vagy beállítása.
        /// </summary>
        public Int32 RowCount { get; set; }

        /// <summary>
        /// Oszlopok számának lekérdezése, vagy beállítása.
        /// </summary>
        public Int32 ColumnCount { get; set; }

        /// <summary>
        /// Mezők lekérdezése.
        /// </summary>
        public ObservableCollection<ColorFieldViewModel> Fields { get; private set; }

        /// <summary>
        /// Méretváltás parancsának lekérdezése.
        /// </summary>
        public DelegateCommand ChangeSizeCommand { get; private set; }

        /// <summary>
        /// Színrács nézetmodell példányosítása.
        /// </summary>
        public ColorGridViewModel()
        {
            Fields = new ObservableCollection<ColorFieldViewModel>();

            ChangeSizeCommand = new DelegateCommand(x => GenerateFields());
        }

        /// <summary>
        /// Mezők generálása.
        /// </summary>
        private void GenerateFields()
        {
            Fields.Clear();

            OnPropertyChanged(nameof(RowCount));    // értesítjük a nézet rácsát a sor és oszlopszám változásáról
            OnPropertyChanged(nameof(ColumnCount));

            for (Int32 rowIndex = 0; rowIndex < RowCount; rowIndex++)
                for (Int32 columnIndex = 0; columnIndex < ColumnCount; columnIndex++)
                {
                    Fields.Add(new ColorFieldViewModel // mező létrehozása
                    {
                        ColorNumber = 0, // megadjuk a kezdőértékeket
                        Row = rowIndex,
                        Column = columnIndex,
                        FieldChangeCommand = new DelegateCommand(field =>
                        {
                            if (field is ColorFieldViewModel viewModel)
                                FieldChange(viewModel);
                        }) // és a végrehajtandó parancsot
                    });
                }
        }

        /// <summary>
        /// Mezőváltozás kezelése.
        /// </summary>
        /// <param name="selectedField">A kiválasztott mező.</param>
        private void FieldChange(ColorFieldViewModel selectedField)
        {
            Int32 color = (selectedField.ColorNumber + 1) % 3;
            // a rákövetkező színt vesszük

            foreach (ColorFieldViewModel field in Fields)
            {
                if (field.Column == selectedField.Column || field.Row == selectedField.Row) // adott oszlopban és sorban
                    field.ColorNumber = color; // átszínezés végrehajtása
            }
        }
    }
}
