using System;

namespace ELTE.Sudoku.Persistence
{
    /// <summary>
    /// Sudoku játéktábla típusa.
    /// </summary>
    public class SudokuTable
    {
        #region Fields

        private Int32 _regionSize; // ház méret
        private Int32[,] _fieldValues; // mezőértékek
        private Boolean[,] _fieldLocks; // mező zárolások

        #endregion

        #region Properties

        /// <summary>
        /// Játéktábla kitöltöttségének lekérdezése.
        /// </summary>
        public Boolean IsFilled
        {
            get
            {
                foreach (Int32 value in _fieldValues)
                    if (value == 0)
                        return false;
                return true;
            }
        }

        /// <summary>
        /// Házak méretének lekérdezése.
        /// </summary>
        public Int32 RegionSize
        {
            get { return _regionSize; }
        }

        /// <summary>
        /// Játéktábla méretének lekérdezése.
        /// </summary>
        public Int32 Size
        {
            get { return _fieldValues.GetLength(0); }
        }

        /// <summary>
        /// Mező értékének lekérdezése.
        /// </summary>
        /// <param name="x">Vízszintes koordináta.</param>
        /// <param name="y">Függőleges koordináta.</param>
        /// <returns>Mező értéke.</returns>
        public Int32 this[Int32 x, Int32 y]
        {
            get { return GetValue(x, y); }
        }

        #endregion

        #region Constructors

        /// <summary>
        /// Sudoku játéktábla példányosítása.
        /// </summary>
        public SudokuTable() : this(9, 3)
        {
        }

        /// <summary>
        /// Sudoku játéktábla példányosítása.
        /// </summary>
        /// <param name="tableSize">Játéktábla mérete.</param>
        /// <param name="regionSize">Ház mérete.</param>
        public SudokuTable(Int32 tableSize, Int32 regionSize)
        {
            if (tableSize < 0)
                throw new ArgumentOutOfRangeException(nameof(tableSize), "The table size is less than 0.");
            if (regionSize < 0)
                throw new ArgumentOutOfRangeException(nameof(regionSize), "The region size is less than 0.");
            if (regionSize > tableSize)
                throw new ArgumentOutOfRangeException(nameof(regionSize),
                    "The region size is grater than the table size.");
            if (tableSize % regionSize != 0)
                throw new ArgumentException("The table size is not a multiple of the region size.", nameof(regionSize));

            _regionSize = regionSize;
            _fieldValues = new Int32[tableSize, tableSize];
            _fieldLocks = new Boolean[tableSize, tableSize];
        }

        #endregion

        #region Public methods

        /// <summary>
        /// Mező kitöltetlenségének lekérdezése.
        /// </summary>
        /// <param name="x">Vízszintes koordináta.</param>
        /// <param name="y">Függőleges koordináta.</param>
        /// <returns>Igaz, ha a mező ki van töltve, egyébként hamis.</returns>
        public Boolean IsEmpty(Int32 x, Int32 y)
        {
            if (x < 0 || x >= _fieldValues.GetLength(0))
                throw new ArgumentOutOfRangeException(nameof(x), "The X coordinate is out of range.");
            if (y < 0 || y >= _fieldValues.GetLength(1))
                throw new ArgumentOutOfRangeException(nameof(y), "The Y coordinate is out of range.");

            return _fieldValues[x, y] == 0;
        }

        /// <summary>
        /// Mező zároltságának lekérdezése.
        /// </summary>
        /// <param name="x">Vízszintes koordináta.</param>
        /// <param name="y">Függőleges koordináta.</param>
        /// <returns>Igaz, ha a mező zárolva van, különben hamis.</returns>
        public Boolean IsLocked(Int32 x, Int32 y)
        {
            if (x < 0 || x >= _fieldValues.GetLength(0))
                throw new ArgumentOutOfRangeException(nameof(x), "The X coordinate is out of range.");
            if (y < 0 || y >= _fieldValues.GetLength(1))
                throw new ArgumentOutOfRangeException(nameof(y), "The Y coordinate is out of range.");

            return _fieldLocks[x, y];
        }

        /// <summary>
        /// Mező értékének lekérdezése.
        /// </summary>
        /// <param name="x">Vízszintes koordináta.</param>
        /// <param name="y">Függőleges koordináta.</param>
        /// <returns>A mező értéke.</returns>
        public Int32 GetValue(Int32 x, Int32 y)
        {
            if (x < 0 || x >= _fieldValues.GetLength(0))
                throw new ArgumentOutOfRangeException(nameof(x), "The X coordinate is out of range.");
            if (y < 0 || y >= _fieldValues.GetLength(1))
                throw new ArgumentOutOfRangeException(nameof(y), "The Y coordinate is out of range.");

            return _fieldValues[x, y];
        }

        /// <summary>
        /// Mező értékének beállítása.
        /// </summary>
        /// <param name="x">Vízszintes koordináta.</param>
        /// <param name="y">Függőleges koordináta.</param>
        /// <param name="value">Érték.</param>
        /// <param name="lockField">Zárolja-e a mezőt.</param>
        public void SetValue(Int32 x, Int32 y, Int32 value, Boolean lockField)
        {
            if (x < 0 || x >= _fieldValues.GetLength(0))
                throw new ArgumentOutOfRangeException(nameof(x), "The X coordinate is out of range.");
            if (y < 0 || y >= _fieldValues.GetLength(1))
                throw new ArgumentOutOfRangeException(nameof(y), "The Y coordinate is out of range.");
            if (value < 0 || value > _fieldValues.GetLength(0) + 1)
                throw new ArgumentOutOfRangeException(nameof(value), "The value is out of range.");
            if (_fieldLocks[x, y]) // ha már zárolva van, nem állíthatjuk be
                return;
            if (!CheckStep(x, y)) // ha a beállítás érvénytelen, akkor nem végezzük el
                return;

            _fieldValues[x, y] = value;
            _fieldLocks[x, y] = lockField;
        }

        /// <summary>
        /// Mező léptetése.
        /// </summary>
        /// <param name="x">Vízszintes koordináta.</param>
        /// <param name="y">Függőleges koordináta.</param>
        public void StepValue(Int32 x, Int32 y)
        {
            if (x < 0 || x >= _fieldValues.GetLength(0))
                throw new ArgumentOutOfRangeException(nameof(x), "The X coordinate is out of range.");
            if (y < 0 || y >= _fieldValues.GetLength(1))
                throw new ArgumentOutOfRangeException(nameof(y), "The Y coordinate is out of range.");

            if (_fieldLocks[x, y]) // ha már zárolva van, nem állíthatjuk be
                return;

            do
            {
                _fieldValues[x, y] = (_fieldValues[x, y] + 1) % (_fieldValues.GetLength(0) + 1); // ciklikus generálás
            } while (!CheckStep(x, y)); // amíg nem jó az érték
        }

        /// <summary>
        /// Mező zárolása.
        /// </summary>
        /// <param name="x">Vízszintes koordináta.</param>
        /// <param name="y">Függőleges koordináta.</param>
        public void SetLock(Int32 x, Int32 y)
        {
            if (x < 0 || x >= _fieldValues.GetLength(0))
                throw new ArgumentOutOfRangeException(nameof(x), "The X coordinate is out of range.");
            if (y < 0 || y >= _fieldValues.GetLength(1))
                throw new ArgumentOutOfRangeException(nameof(y), "The Y coordinate is out of range.");

            _fieldLocks[x, y] = true;
        }

        #endregion

        #region Private methods

        /// <summary>
        /// Lépésellenőrzés.
        /// </summary>
        /// <param name="x">Vízszintes koordináta.</param>
        /// <param name="y">Függőleges koordináta.</param>
        /// <returns>Igaz, ha a lépés engedélyezett, különben hamis.</returns>
        private Boolean CheckStep(Int32 x, Int32 y)
        {
            if (_fieldValues[x, y] == 0)
                return true;
            else
            {
                // sor ellenőrzése:
                for (Int32 i = 0; i < _fieldValues.GetLength(0); i++)
                    if (_fieldValues[i, y] == _fieldValues[x, y] && x != i)
                        return false;

                // oszlop ellenőrzése:
                for (Int32 j = 0; j < _fieldValues.GetLength(1); j++)
                    if (_fieldValues[x, j] == _fieldValues[x, y] && y != j)
                        return false;

                // ház ellenőrzése:
                for (Int32 i = _regionSize * (x / _regionSize); i < _regionSize * ((x / _regionSize) + 1); i++)
                for (Int32 j = _regionSize * (y / _regionSize); j < _regionSize * ((y / _regionSize) + 1); j++)
                {
                    if (_fieldValues[i, j] == _fieldValues[x, y] && x != i && y != j)
                        return false;
                }

                return true;
            }
        }

        #endregion
    }
}
