//Author:   Gregorics Tibor
//Date:     2024.05.15.
//Title:    class of statemachine

using System.Threading;

namespace StateMachine
{

    public abstract class State 
    {
        private Thread thread;

        protected void StartActivity()
        {
            thread = new (new ThreadStart(Activity));
            thread.Start();
        }
        protected virtual void Activity() { }

        protected virtual void StopActivity()
        {
            thread.Join();
        }
    }

    public interface ISignal
    {
        State Transition(State state) { return state; }
    } 
    
    public class InvalidStateException:System.Exception { }
    public abstract class StateMachine
    {
        private readonly Thread thread;
        protected State currentState;
        private readonly EventQueue<ISignal> eventQueue = new ();
        private readonly ISignal finalSignal;

        public StateMachine(ISignal final)
        {
            finalSignal = final;
            thread = new Thread(new ThreadStart(StateMachineProcess));
        }
        public void Start()
        {
            thread.Start();
        }
        public void Send(ISignal signal)
        {
            eventQueue.Enqueue(signal);
        }

        protected void StateMachineProcess()
        {
            while (true)
            {
                try
                {
                    ISignal signal = eventQueue.Dequeue();
                    if (signal.Equals(finalSignal)) break;
                    else { currentState = signal.Transition(currentState); }
                }
                catch (System.InvalidOperationException) { }
            }
        }
    }
}
