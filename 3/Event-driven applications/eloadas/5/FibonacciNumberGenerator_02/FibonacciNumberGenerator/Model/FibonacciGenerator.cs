using System;
using System.Threading.Tasks;

namespace ELTE.FibonacciNumberGenerator.Model
{
    /// <summary>
    /// Fibonacci szám generátor.
    /// </summary>
    public class FibonacciGenerator
    {
        /// <summary>
        /// Szám generálása.
        /// </summary>
        /// <param name="number">A sorszám.</param>
        /// <returns>A generált Fibonacci szám.</returns>
        public Int64 Generate(Int32 number)
        {
            if (number < 1)
                throw new ArgumentOutOfRangeException("The number is less than 1.");
            if (number > 100)
                throw new ArgumentOutOfRangeException("Number is greater than 100.");

            if (number < 3)
                return 1;

            return Generate(number - 1) + Generate(number - 2);
        }

        /// <summary>
        /// Szám generálása (aszinkron módon).
        /// </summary>
        /// <param name="number">A sorszám.</param>
        /// <returns>A generált Fibonacci szám.</returns>
        public async Task<Int64> GenerateAsync(Int32 number)
        {
            return await Task.Run(() => Generate(number));
            // a háttérben fut a generálás
        }
    }
}
