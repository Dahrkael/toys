using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;
using System.Runtime.InteropServices;
using WaveLib;

namespace Synthesizer
{
    public partial class Form1 : Form
    {
        private Single Tono = 0.0f;

        private WaveOutPlayer m_Player;
        private WaveFormat format;

        private float Volumen = 0.5f;
        private int BitRate = 16;
        private int Canales = 1;
        private int SampleRate = 16000;

        private Oscilador osc1;
        private Oscilador osc2;
        private Oscilador osc3;

        private int MCM = 0;

        public Form1()
        {
            InitializeComponent();

            format = new WaveFormat(SampleRate, BitRate, Canales);
            osc1 = new Oscilador();
            osc2 = new Oscilador();
            osc3 = new Oscilador();

            Osc1_TrackBarAmplitud.Value = (int)osc1.Amplitud;
            Osc2_TrackBarAmplitud.Value = (int)osc2.Amplitud;
            Osc3_TrackBarAmplitud.Value = (int)osc3.Amplitud;

            Osc1_TrackBarFrecuencia.Value = (int)osc1.Frecuencia;
            Osc2_TrackBarFrecuencia.Value = (int)osc2.Frecuencia;
            Osc3_TrackBarFrecuencia.Value = (int)osc3.Frecuencia;

            trackBarVolumen.Value = (int)(Volumen * 100);
        }

        static int EuclidesMCD(int a, int b)
        {
            int iaux; //auxiliar
            a = Math.Abs(a); //tomamos valor absoluto
            b = Math.Abs(b);
            int i1 = Math.Max(a, b); //i1 = el más grande
            int i2 = Math.Min(a, b); //i2 = el más pequeño
            do
            {
                iaux = i2;  //guardar divisor
                i2 = i1 % i2; //resto pasa a divisor
                i1 = iaux;  //divisor pasa a dividendo
            } while (i2 != 0);
            return i1; //ultimo resto no nulo
        }

        static int EuclidesMCM(int a, int b)
        {
            return (a / EuclidesMCD(a, b)) * b;
        }

        private void Filler(IntPtr data, int size)
        {
            int ssize = size / 2;
            short[] bavg    = new short[ssize];
            short[] buffer1 = new short[ssize];
            short[] buffer2 = new short[ssize];
            short[] buffer3 = new short[ssize];
            if (Tono > 0)
            {
                osc1.Wave(buffer1, ssize);
                osc2.Wave(buffer2, ssize);
                osc3.Wave(buffer3, ssize);
            }

            // Average
            for (int i = 0; i < bavg.Length; i++)
            { bavg[i] = (short)((buffer1[i] + buffer2[i] + buffer3[i]) / 3); }

            // Frecuencia media (frecuencia de la onda resultante) [TEST]
            int a = EuclidesMCM((int)osc1.SPO(), (int)osc2.SPO());
            MCM = EuclidesMCM(a, (int)osc3.SPO());
            // Volumen general
            for (int i = 0; i < bavg.Length; i++) { bavg[i] = (short)(bavg[i] * Volumen); }
            // Copiar a Waveout
            Marshal.Copy(bavg, 0, data, bavg.Length);
            return;
        }

        private void Stop()
        {
            if (m_Player != null)
                try { m_Player.Dispose();  }
                finally { m_Player = null; }
        }

        private void Play()
        {
            osc1.Reiniciar();
            osc2.Reiniciar();
            osc3.Reiniciar();
            if (m_Player != null) { return; }
            m_Player = new WaveOutPlayer(-1, format, 2048, 3, new WaveLib.BufferFillEventHandler(Filler));
        }

        private void button2_Click(object sender, EventArgs e)
        {
            Stop();
            labelPower.BackColor = Color.Red;
            labelPower.Text = "OFF";
        }

        private void button1_Click(object sender, EventArgs e)
        {
            Play();
            labelPower.BackColor = Color.Green;
            labelPower.Text = "ON";
        }

        private void Osc1_TrackBarFrecuencia_Scroll(object sender, EventArgs e)
        {
            osc1.Frecuencia = Osc1_TrackBarFrecuencia.Value;
            Osc1_LabelSPO.Text = (osc1.SampleRate / osc1.Frecuencia).ToString();
            labelMCM.Text = "SPO: " + MCM;
        }

        private void Osc2_TrackBarFrecuencia_Scroll(object sender, EventArgs e)
        { 
            osc2.Frecuencia = Osc2_TrackBarFrecuencia.Value;
            Osc2_LabelSPO.Text = (osc2.SampleRate / osc2.Frecuencia).ToString();
            labelMCM.Text = "SPO: " + MCM;
        }

        private void Osc3_TrackBarFrecuencia_Scroll(object sender, EventArgs e)
        { 
            osc3.Frecuencia = Osc3_TrackBarFrecuencia.Value;
            Osc3_LabelSPO.Text = (osc3.SampleRate / osc3.Frecuencia).ToString();
            labelMCM.Text = "SPO: " + MCM;
        }

        private void Osc1_TrackBarAmplitud_Scroll(object sender, EventArgs e)
        { osc1.Amplitud = Osc1_TrackBarAmplitud.Value; }

        private void Osc2_TrackBarAmplitud_Scroll(object sender, EventArgs e)
        { osc2.Amplitud = Osc2_TrackBarAmplitud.Value; }

        private void Osc3_TrackBarAmplitud_Scroll(object sender, EventArgs e)
        { osc2.Amplitud = Osc2_TrackBarAmplitud.Value; }

        private void trackBarVolumen_Scroll(object sender, EventArgs e)
        { 
            Volumen = trackBarVolumen.Value / 100.0f;
            labelVolumen.Text = "Volumen: " + Volumen.ToString();
        }

        private void trackBarFrecuencia_Scroll(object sender, EventArgs e)
        {
            osc1.Frecuencia = trackBarFrecuencia.Value;
            osc2.Frecuencia = trackBarFrecuencia.Value;
            osc3.Frecuencia = trackBarFrecuencia.Value;
            Osc1_TrackBarFrecuencia.Value = trackBarFrecuencia.Value;
            Osc2_TrackBarFrecuencia.Value = trackBarFrecuencia.Value;
            Osc3_TrackBarFrecuencia.Value = trackBarFrecuencia.Value;
            Osc1_LabelSPO.Text = (osc1.SampleRate / osc1.Frecuencia).ToString();
            Osc2_LabelSPO.Text = (osc2.SampleRate / osc2.Frecuencia).ToString();
            Osc3_LabelSPO.Text = (osc3.SampleRate / osc3.Frecuencia).ToString();
            labelMCM.Text = "SPO: " + MCM;
            labelFrecuencia.Text = "Frecuencia General: " + trackBarFrecuencia.Value.ToString();
        }

        private void Osc1_ButtonS_Click(object sender, EventArgs e)
        { osc1.Tipo = TipoOsc.Sinusoidal;   Osc1_Label.Text = "Sinusoidal"; }

        private void Osc1_ButtonC_Click(object sender, EventArgs e)
        { osc1.Tipo = TipoOsc.Cuadrada;     Osc1_Label.Text = "Cuadrada"; }

        private void Osc1_ButtonT_Click(object sender, EventArgs e)
        { osc1.Tipo = TipoOsc.Triangular;   Osc1_Label.Text = "Triangular"; }

        private void Osc1_ButtonA_Click(object sender, EventArgs e)
        { osc1.Tipo = TipoOsc.Aserrada;     Osc1_Label.Text = "Aserrada"; }

        private void Osc1_ButtonMute_Click(object sender, EventArgs e)
        { osc1.Tipo = TipoOsc.Silencio;     Osc1_Label.Text = "Silencio"; }

        private void Osc2_ButtonS_Click(object sender, EventArgs e)
        { osc2.Tipo = TipoOsc.Sinusoidal;   Osc2_Label.Text = "Sinusoidal"; }

        private void Osc2_ButtonC_Click(object sender, EventArgs e)
        { osc2.Tipo = TipoOsc.Cuadrada;     Osc2_Label.Text = "Cuadrada"; }

        private void Osc2_ButtonT_Click(object sender, EventArgs e)
        { osc2.Tipo = TipoOsc.Triangular;   Osc2_Label.Text = "Triangular"; }

        private void Osc2_ButtonA_Click(object sender, EventArgs e)
        { osc2.Tipo = TipoOsc.Aserrada;     Osc2_Label.Text = "Aserrada"; }

        private void Osc2_ButtonMute_Click(object sender, EventArgs e)
        { osc2.Tipo = TipoOsc.Silencio;     Osc2_Label.Text = "Silencio"; }

        private void Osc3_ButtonS_Click(object sender, EventArgs e)
        { osc3.Tipo = TipoOsc.Sinusoidal;   Osc3_Label.Text = "Sinusoidal"; }

        private void Osc3_ButtonC_Click(object sender, EventArgs e)
        { osc3.Tipo = TipoOsc.Cuadrada;     Osc3_Label.Text = "Cuadrada"; }

        private void Osc3_ButtonT_Click(object sender, EventArgs e)
        { osc3.Tipo = TipoOsc.Triangular;   Osc3_Label.Text = "Triangular"; }

        private void Osc3_ButtonA_Click(object sender, EventArgs e)
        { osc3.Tipo = TipoOsc.Aserrada;     Osc3_Label.Text = "Aserrada"; }

        private void Osc3_ButtonMute_Click(object sender, EventArgs e)
        { osc3.Tipo = TipoOsc.Silencio;     Osc3_Label.Text = "Silencio"; }

        private void Form1_KeyDown(object sender, KeyEventArgs e)
        {
            if (e.KeyCode == Keys.Z) { Tono = Tones.C4; }
            if (e.KeyCode == Keys.S) { Tono = Tones.Cs4; }
            if (e.KeyCode == Keys.X) { Tono = Tones.D4; }
            if (e.KeyCode == Keys.D) { Tono = Tones.Ds4; }
            if (e.KeyCode == Keys.C) { Tono = Tones.E4; }
            if (e.KeyCode == Keys.V) { Tono = Tones.F4; }
            if (e.KeyCode == Keys.G) { Tono = Tones.Fs4; }
            if (e.KeyCode == Keys.B) { Tono = Tones.G4; }
            if (e.KeyCode == Keys.H) { Tono = Tones.Gs4; }
            if (e.KeyCode == Keys.N) { Tono = Tones.A4; }
            if (e.KeyCode == Keys.J) { Tono = Tones.As4; }
            if (e.KeyCode == Keys.M) { Tono = Tones.B4; }

            osc1.Frecuencia = Tono;
            osc2.Frecuencia = Tono;
            osc3.Frecuencia = Tono;
        }

        private void Form1_KeyUp(object sender, KeyEventArgs e)
        {
            Tono = 0;
        }
    }
}
