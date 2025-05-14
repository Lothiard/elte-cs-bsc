namespace BasicStateMachine {
    class BasicStateMachine<TState, TSignal> {
        private record TransitionInfo(TState ToState, Action? OnTransition);

        private Dictionary <(TState, TSignal), TransitionInfo> _transitionMap;
        private TState _currentState;

        public bool Verbose = true;

        public TState CurrentState => _currentState;

        protected BasicStateMachine(TState startState) {
            _transitionMap = new Dictionary<(TState, TSignal), TransitionInfo>();
            _currentState = startState;
        }

        protected void AddTransition(TState fromState, TSignal signal, TState toState, Action? onTransition = null) {
            _transitionMap[(fromState, signal)] = new TransitionInfo(toState, onTransition);
        }

        protected void ProcessSignal(TSignal signal) {
            var key = (_currentState, signal);

            if (_transitionMap.TryGetValue(key, out TransitionInfo transitionInfo)) {
                if (Verbose) {
                    // vmi
                    System.Console.WriteLine($"{_currentState} -> {signal} -> {transitionInfo.ToState}");
                    Console.ResetColor();
                }
                transition.OnTransition?.Invoke();
                _currentState = transitionInfo.ToState;
            } else {
                System.Console.WriteLine($"Invalid transition {_currentState} -> {signal}");
            }
        }
    }
}

