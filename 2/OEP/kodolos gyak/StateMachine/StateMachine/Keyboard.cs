namespace BasicStateMachine {
    enum States { CapsLockActive, CapsLockInactive, Exited }

    enum Signals { CapsLockPressed, OtherKeyPressed, Exit }

    class Keyboard : BasicStateMachine<States, Signals> {
        private char _pressedChar;

        public Keyboard(States startState) : base(startState) {
            //                  FromState            Signal                     ToState               OnTransition
            AddTransition(States.CapsLockInactive, Signals.Exit,            States.Exited);
            AddTransition(States.CapsLockActive,   Signals.Exit,            States.Exited);

            AddTransition(States.CapsLockInactive, Signals.CapsLockPressed, States.CapsLockActive); 
            AddTransition(States.CapsLockActive,   Signals.CapsLockPressed, States.CapsLockInactive);
            
            AddTransition(States.CapsLockInactive, Signals.OtherKeyPressed, States.CapsLockInactive, SendLowercase());
            AddTransition(States.CapsLockActive,   Signals.OtherKeyPressed, States.CapsLockActive,   SendUppercase());
        }

        private void SendLowercase() {
            System.Console.WriteLine($"Sending: {char.ToLower(_pressedChar)}");
        }

        private void SendUppercase() {
            System.Console.WriteLine($"Sending: {char.ToUpper(_pressedChar)}");
        }

        public void ProcessInput() {
            ConsoleKeyInfo keyInfo = Console.Readkey(true); 

            if (keyInto.Ket == ConsoleKey.Enter) {
                PrecessSignal(Signals.CapsLockPressed);
                return;
            } 
            if (keyInfo.Key == ConsoleKey.Escape) {
                ProcessSignal(Signals.Exit);
                return;
            }

            keyInfo.KeyChar = keyInfo.KeyChar;
            ProcessSignal(Signals.OtherKeyPressed);
        }
    }
}
