using System;
using System.Collections.Generic;
using System.Linq;

namespace ELTE.Tombola
{
    public class TombolaModel
    {
        private IList<int> tickets = new List<int>();
        private readonly Random generator = new Random();

        public int TicketCount { get; private set; }
        public int LastTaken { get; private set; }

        public TombolaModel(int ticketCount)
        {
            if (ticketCount < 1)
                throw new ArgumentOutOfRangeException(nameof(ticketCount), "At least 1 ticket must exist!");
            if (ticketCount > 999)
                throw new ArgumentOutOfRangeException(nameof(ticketCount), "Maximum 999 tickets can exist!");

            TicketCount = ticketCount;
            Reset();
        }

        public void Reset()
        {
            tickets.Clear();
            for (int i = 1; i <= TicketCount; ++i)
                tickets.Add(i);
        }

        public int Next()
        {
            if (tickets.Count == 0)
                throw new InvalidOperationException("No more tickets!");

            LastTaken = tickets.ElementAt(generator.Next(tickets.Count));
            tickets.Remove(LastTaken);
            return LastTaken;
        }

        public bool IsTaken(int ticket)
        {
            if (ticket < 1 || ticket > TicketCount)
                throw new ArgumentOutOfRangeException(nameof(ticket), "Not a valid ticket.");

            return !tickets.Contains(ticket);
        }
    }
}