using System;
using System.Numerics;
using System.Threading;
using System.Threading.Tasks;

namespace ELTE.FibonacciNumberGenerator.Model
{
    public class FibonacciGenerator : IDisposable
    {
        public event EventHandler<ResultEventArgs>? NewResult;
        public event EventHandler? Ready;

        private CancellationTokenSource? _source;
        private CancellationToken _token;

        public void Run(Int32 n)
        {
            _source = new CancellationTokenSource();
            _token = _source.Token;

            var task = new Task(() => Calculate(n), _token);
            task.ContinueWith(t => OnReady());
            task.Start();
        }

        public void Cancel()
        {
            _source?.Cancel();
        }

        private void Calculate(Int32 n)
        {
            BigInteger first = 0, second = 1, third = 1;

            if (n >= 0)
                OnNewResult(0, second);

            if (n >= 1)
                OnNewResult(1, third);

            for (Int32 i = 2; i <= n; ++i)
            {
                if (_token.IsCancellationRequested)
                    break;

                first = second;
                second = third;
                third = second + first;
                OnNewResult(i, third);
                Thread.Sleep(10); // Szándékos lassítás
            }
        }

        private void OnNewResult(Int32 n, BigInteger result)
        {
            if (NewResult != null)
                NewResult(this, new ResultEventArgs(n, result));
        }

        private void OnReady()
        {
            if (Ready != null)
                Ready(this, EventArgs.Empty);
        }

        public void Dispose()
        {
            _source?.Dispose();
        }
    }
}
