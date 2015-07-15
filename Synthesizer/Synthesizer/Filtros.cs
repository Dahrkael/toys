using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Synthesizer
{
    class Filtros
    {
        public static short LowPassFilterSimple(short[] input, short[] output, int size, double xm1)
        {
            output[0] = Convert.ToInt16(input[0] + xm1);
            for (int i = 1; i < size; i++)
            { output[i] = Convert.ToInt16(input[i] + input[i - 1]); }
            return output[size - 1];
        }

        public static void LowPassFilterButterworth(short[] input, short[] output, int size, double xm1)
        {
            for (int i = 1; i < size; i++)
            { output[i] = Convert.ToInt16(input[i] - xm1 * input[i - 1]); }   
        }
    }
}
