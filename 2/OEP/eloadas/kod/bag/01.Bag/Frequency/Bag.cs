//Author:   Gregorics Tibor
//Date:     2021.10.24.
//Title:    class of Bag

using System;

namespace Frequency
{
    /// <summary>
    /// class of bags (multiplicative sets) which can contain the same element several times
    /// </summary>
    public class Bag
    {
        public class NegativeSizeException : Exception { }  // when the parameter of constructor is negative
        public class EmptyBagException : Exception { } // when the method MostFrequented() is called on an empty bag
        public class IllegalElementException : Exception { } // when the method PutIn() is called with the element which is not in the interval 0 .. max

        // representation of a bag
        protected int[] vec;
        protected int max;                          // the most frequented integer of the bag (list)

        //Task: 	creating of empty bag
        //Input:    int m      -  the upper limit of the natural numbers of the bag
        //Output:   Bag this   -  the bag
        //Activity: memory allocation of the array representing the bag and erasing the bag
        public Bag(int m)
        {
            if (m < 0) throw new NegativeSizeException();
            vec = new int[m+1];
            for (int i = 0; i <= m; ++i) vec[i]=0;
            max = 0;
        }

        //Task: 	erasing the bag
        //Input:    Bag this   -  the bag
        //Output:   Bag this   -  the bag
        //Activity: sets to zero the elements of vec and maintains the type invariant
        public void Erase()
        {
            for (int i = 0; i < vec.Length; ++i) vec[i] = 0;
            max = 0;
        }

        //Task: 	putting an integer into the bag
        //Input:    Bag this   -  the bag
        //          int e      -  the integer being put in
        //Output:   Bag this   -  the bag
        //Activity: increases the occurrence frequency of 'e' in vec and maintains the type invariant
        public void PutIn(int e)
        {
            if (e < 0 || e >= vec.Length) throw new IllegalElementException();
            if (++vec[e] > vec[max]) max = e;
        }

        //Task: 	retrieves the most frequent integer of the bag
        //Input:    Bag this    -  the bag
        //Output:   int max     -  most frequent integer of the bag
        //Activity: gives vec[max] if vec[max]>0 (bag is not empty)
        public int MostFrequent()
        {
            if (0 == vec[max]) throw new EmptyBagException();
            return max;
        }
    }
}
