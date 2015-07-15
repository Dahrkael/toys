using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Runtime.InteropServices;

namespace Synthesizer
{
    enum TipoOsc { Sinusoidal, Cuadrada, Aserrada, Triangular, Silencio };
    class Oscilador
    {
        private float   sample      = 0;
        private bool    tridir      = true;
        private Random  rnd;
        public  TipoOsc tipo        = TipoOsc.Silencio;
        public  int     BitRate     = 16;
        public  int     Canales     = 1;
        public  int     SampleRate  = 16000;
        public  float   Frecuencia  = 440.0f;
        public  float   Amplitud    = 32760;
        

        public Oscilador()
        {
            rnd = new Random();
        }

        public void Reiniciar()
        {
            switch (Tipo)
            {
                case TipoOsc.Sinusoidal:    sample = 0;          break;
                case TipoOsc.Cuadrada:      sample = 0;          break;
                case TipoOsc.Aserrada:      sample = -Amplitud;  break;
                case TipoOsc.Triangular:    sample = -Amplitud;  break;
                case TipoOsc.Silencio:      sample = 0;          break;
            }
        }

        public TipoOsc Tipo
        {
            get { return tipo; }
            set { tipo = value; Reiniciar(); }
        }

        private double FrecuenciaAngular()
        {
            return (Math.PI * 2 * Frecuencia) / (SampleRate * Canales);
        }

        public float SPO()
        {
            return (SampleRate / (Frecuencia * Canales));
        }

        public void Wave(short[] data, int size)
        {
            switch (Tipo)
            {
                case TipoOsc.Sinusoidal: SineWave(data, size);     break;
                case TipoOsc.Cuadrada:   SquareWave(data, size);   break;
                case TipoOsc.Aserrada:   SawtoothWave(data, size); break;
                case TipoOsc.Triangular: TriangleWave(data, size); break;
                case TipoOsc.Silencio:   SilenceWave(data, size);  break;
            }
        }

        private void SineWave(short[] data, int size)
        {
            double omega = FrecuenciaAngular();
            for (int i = 0; i < size; i++)
            {
                data[i] = Convert.ToInt16(Amplitud * Math.Sin(omega * sample));
                sample++; if (sample > SPO()) { sample = 0; }
            }
        }

        private void SquareWave(short[] data, int size)
        {
            double omega = FrecuenciaAngular();
            for (int i = 0; i < size; i++)
            {
                data[i] = Convert.ToInt16(Amplitud * Math.Sign(Math.Sin(omega * sample)));
                sample++; if (sample > SPO()) { sample = 0; }
            }
        }

        private void SawtoothWave(short[] data, int size)
        {
            short ampStep = Convert.ToInt16((Amplitud * 2) / SPO());

            for (int i = 0; i < size; i++)
            {
                data[i] = Convert.ToInt16(sample);
                sample += ampStep;
                if (sample >= Amplitud) { sample = (short)-Amplitud; }
            }
        }

        private void TriangleWave(short[] data, int size)
        {
            short ampStep = Convert.ToInt16((Amplitud * 2) / SPO());

            for (int i = 0; i < size; i++)
            {
                data[i] = Convert.ToInt16(sample);
                if (tridir == true) 
                {
                    if ((sample + ampStep) >= Amplitud) { sample = Amplitud; } else { sample += ampStep; }
                } 
                else 
                {
                    if ((sample - ampStep) <= -Amplitud) { sample = -Amplitud; } else { sample -= ampStep; }
                }
                if (Math.Abs(sample) >= Amplitud) 
                { tridir = !tridir; }
            }
        }

        private void NoiseWave(short[] data, int size)
        {
            for (int i = 0; i < size; i++)
            {
                data[i] = Convert.ToInt16(rnd.Next((int)-Amplitud, (int)Amplitud));
            }
        }

        private void SilenceWave(short[] data, int size)
        {
            for (int i = 0; i < size; i++)
            { data[i] = 0; }
        }
    }
}
