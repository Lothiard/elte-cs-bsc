using System;
using System.Numerics;

namespace ELTE.FibonacciNumberGenerator.Model
{
    public class ResultEventArgs : EventArgs
    {
        public Int32 N { get; set; }
        public BigInteger Result { get; set; }

        public ResultEventArgs(int n, BigInteger result)
        {
            N = n;
            Result = result;
        }
    }
}
