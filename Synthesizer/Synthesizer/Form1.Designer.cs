namespace Synthesizer
{
    partial class Form1
    {
        /// <summary>
        /// Variable del diseñador requerida.
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// Limpiar los recursos que se estén utilizando.
        /// </summary>
        /// <param name="disposing">true si los recursos administrados se deben eliminar; false en caso contrario, false.</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Código generado por el Diseñador de Windows Forms

        /// <summary>
        /// Método necesario para admitir el Diseñador. No se puede modificar
        /// el contenido del método con el editor de código.
        /// </summary>
        private void InitializeComponent()
        {
            this.button1 = new System.Windows.Forms.Button();
            this.button2 = new System.Windows.Forms.Button();
            this.labelPower = new System.Windows.Forms.Label();
            this.trackBarVolumen = new System.Windows.Forms.TrackBar();
            this.labelVolumen = new System.Windows.Forms.Label();
            this.Osc2_TrackBarFrecuencia = new System.Windows.Forms.TrackBar();
            this.Osc2_TrackBarAmplitud = new System.Windows.Forms.TrackBar();
            this.Osc3_TrackBarAmplitud = new System.Windows.Forms.TrackBar();
            this.Osc3_TrackBarFrecuencia = new System.Windows.Forms.TrackBar();
            this.Osc1_TrackBarAmplitud = new System.Windows.Forms.TrackBar();
            this.Osc1_TrackBarFrecuencia = new System.Windows.Forms.TrackBar();
            this.groupBox2 = new System.Windows.Forms.GroupBox();
            this.Osc1_LabelSPO = new System.Windows.Forms.Label();
            this.Osc1_Label = new System.Windows.Forms.Label();
            this.Osc1_ButtonMute = new System.Windows.Forms.Button();
            this.Osc1_ButtonC = new System.Windows.Forms.Button();
            this.Osc1_ButtonT = new System.Windows.Forms.Button();
            this.Osc1_ButtonA = new System.Windows.Forms.Button();
            this.Osc1_ButtonS = new System.Windows.Forms.Button();
            this.groupBox3 = new System.Windows.Forms.GroupBox();
            this.Osc2_LabelSPO = new System.Windows.Forms.Label();
            this.Osc2_Label = new System.Windows.Forms.Label();
            this.Osc2_ButtonMute = new System.Windows.Forms.Button();
            this.Osc2_ButtonC = new System.Windows.Forms.Button();
            this.Osc2_ButtonT = new System.Windows.Forms.Button();
            this.Osc2_ButtonS = new System.Windows.Forms.Button();
            this.Osc2_ButtonA = new System.Windows.Forms.Button();
            this.groupBox4 = new System.Windows.Forms.GroupBox();
            this.Osc3_LabelSPO = new System.Windows.Forms.Label();
            this.Osc3_Label = new System.Windows.Forms.Label();
            this.Osc3_ButtonMute = new System.Windows.Forms.Button();
            this.Osc3_ButtonC = new System.Windows.Forms.Button();
            this.Osc3_ButtonT = new System.Windows.Forms.Button();
            this.Osc3_ButtonA = new System.Windows.Forms.Button();
            this.Osc3_ButtonS = new System.Windows.Forms.Button();
            this.trackBarFrecuencia = new System.Windows.Forms.TrackBar();
            this.labelFrecuencia = new System.Windows.Forms.Label();
            this.labelMCM = new System.Windows.Forms.Label();
            ((System.ComponentModel.ISupportInitialize)(this.trackBarVolumen)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.Osc2_TrackBarFrecuencia)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.Osc2_TrackBarAmplitud)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.Osc3_TrackBarAmplitud)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.Osc3_TrackBarFrecuencia)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.Osc1_TrackBarAmplitud)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.Osc1_TrackBarFrecuencia)).BeginInit();
            this.groupBox2.SuspendLayout();
            this.groupBox3.SuspendLayout();
            this.groupBox4.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.trackBarFrecuencia)).BeginInit();
            this.SuspendLayout();
            // 
            // button1
            // 
            this.button1.Location = new System.Drawing.Point(12, 234);
            this.button1.Name = "button1";
            this.button1.Size = new System.Drawing.Size(75, 23);
            this.button1.TabIndex = 0;
            this.button1.Text = "Play";
            this.button1.UseVisualStyleBackColor = true;
            this.button1.Click += new System.EventHandler(this.button1_Click);
            // 
            // button2
            // 
            this.button2.Location = new System.Drawing.Point(93, 234);
            this.button2.Name = "button2";
            this.button2.Size = new System.Drawing.Size(75, 23);
            this.button2.TabIndex = 1;
            this.button2.Text = "Stop";
            this.button2.UseVisualStyleBackColor = true;
            this.button2.Click += new System.EventHandler(this.button2_Click);
            // 
            // labelPower
            // 
            this.labelPower.BackColor = System.Drawing.Color.Red;
            this.labelPower.Location = new System.Drawing.Point(174, 234);
            this.labelPower.Name = "labelPower";
            this.labelPower.Size = new System.Drawing.Size(75, 23);
            this.labelPower.TabIndex = 7;
            this.labelPower.Text = "OFF";
            this.labelPower.TextAlign = System.Drawing.ContentAlignment.MiddleCenter;
            // 
            // trackBarVolumen
            // 
            this.trackBarVolumen.Location = new System.Drawing.Point(12, 29);
            this.trackBarVolumen.Maximum = 100;
            this.trackBarVolumen.Name = "trackBarVolumen";
            this.trackBarVolumen.Size = new System.Drawing.Size(406, 45);
            this.trackBarVolumen.TabIndex = 9;
            this.trackBarVolumen.Scroll += new System.EventHandler(this.trackBarVolumen_Scroll);
            // 
            // labelVolumen
            // 
            this.labelVolumen.AutoSize = true;
            this.labelVolumen.Location = new System.Drawing.Point(13, 13);
            this.labelVolumen.Name = "labelVolumen";
            this.labelVolumen.Size = new System.Drawing.Size(51, 13);
            this.labelVolumen.TabIndex = 10;
            this.labelVolumen.Text = "Volumen:";
            // 
            // Osc2_TrackBarFrecuencia
            // 
            this.Osc2_TrackBarFrecuencia.Location = new System.Drawing.Point(49, 17);
            this.Osc2_TrackBarFrecuencia.Maximum = 4978;
            this.Osc2_TrackBarFrecuencia.Minimum = 16;
            this.Osc2_TrackBarFrecuencia.Name = "Osc2_TrackBarFrecuencia";
            this.Osc2_TrackBarFrecuencia.Orientation = System.Windows.Forms.Orientation.Vertical;
            this.Osc2_TrackBarFrecuencia.Size = new System.Drawing.Size(45, 104);
            this.Osc2_TrackBarFrecuencia.TabIndex = 12;
            this.Osc2_TrackBarFrecuencia.TickStyle = System.Windows.Forms.TickStyle.None;
            this.Osc2_TrackBarFrecuencia.Value = 16;
            this.Osc2_TrackBarFrecuencia.Scroll += new System.EventHandler(this.Osc2_TrackBarFrecuencia_Scroll);
            // 
            // Osc2_TrackBarAmplitud
            // 
            this.Osc2_TrackBarAmplitud.Location = new System.Drawing.Point(6, 18);
            this.Osc2_TrackBarAmplitud.Maximum = 32760;
            this.Osc2_TrackBarAmplitud.Name = "Osc2_TrackBarAmplitud";
            this.Osc2_TrackBarAmplitud.Orientation = System.Windows.Forms.Orientation.Vertical;
            this.Osc2_TrackBarAmplitud.Size = new System.Drawing.Size(45, 104);
            this.Osc2_TrackBarAmplitud.TabIndex = 13;
            this.Osc2_TrackBarAmplitud.TickStyle = System.Windows.Forms.TickStyle.None;
            this.Osc2_TrackBarAmplitud.Scroll += new System.EventHandler(this.Osc2_TrackBarAmplitud_Scroll);
            // 
            // Osc3_TrackBarAmplitud
            // 
            this.Osc3_TrackBarAmplitud.Location = new System.Drawing.Point(6, 19);
            this.Osc3_TrackBarAmplitud.Maximum = 32760;
            this.Osc3_TrackBarAmplitud.Name = "Osc3_TrackBarAmplitud";
            this.Osc3_TrackBarAmplitud.Orientation = System.Windows.Forms.Orientation.Vertical;
            this.Osc3_TrackBarAmplitud.Size = new System.Drawing.Size(45, 104);
            this.Osc3_TrackBarAmplitud.TabIndex = 14;
            this.Osc3_TrackBarAmplitud.TickStyle = System.Windows.Forms.TickStyle.None;
            this.Osc3_TrackBarAmplitud.Scroll += new System.EventHandler(this.Osc3_TrackBarAmplitud_Scroll);
            // 
            // Osc3_TrackBarFrecuencia
            // 
            this.Osc3_TrackBarFrecuencia.Location = new System.Drawing.Point(49, 19);
            this.Osc3_TrackBarFrecuencia.Maximum = 4978;
            this.Osc3_TrackBarFrecuencia.Minimum = 16;
            this.Osc3_TrackBarFrecuencia.Name = "Osc3_TrackBarFrecuencia";
            this.Osc3_TrackBarFrecuencia.Orientation = System.Windows.Forms.Orientation.Vertical;
            this.Osc3_TrackBarFrecuencia.Size = new System.Drawing.Size(45, 104);
            this.Osc3_TrackBarFrecuencia.TabIndex = 15;
            this.Osc3_TrackBarFrecuencia.TickStyle = System.Windows.Forms.TickStyle.None;
            this.Osc3_TrackBarFrecuencia.Value = 16;
            this.Osc3_TrackBarFrecuencia.Scroll += new System.EventHandler(this.Osc3_TrackBarFrecuencia_Scroll);
            // 
            // Osc1_TrackBarAmplitud
            // 
            this.Osc1_TrackBarAmplitud.Location = new System.Drawing.Point(6, 18);
            this.Osc1_TrackBarAmplitud.Maximum = 32760;
            this.Osc1_TrackBarAmplitud.Name = "Osc1_TrackBarAmplitud";
            this.Osc1_TrackBarAmplitud.Orientation = System.Windows.Forms.Orientation.Vertical;
            this.Osc1_TrackBarAmplitud.Size = new System.Drawing.Size(45, 104);
            this.Osc1_TrackBarAmplitud.TabIndex = 16;
            this.Osc1_TrackBarAmplitud.TickStyle = System.Windows.Forms.TickStyle.None;
            this.Osc1_TrackBarAmplitud.Scroll += new System.EventHandler(this.Osc1_TrackBarAmplitud_Scroll);
            // 
            // Osc1_TrackBarFrecuencia
            // 
            this.Osc1_TrackBarFrecuencia.Location = new System.Drawing.Point(49, 18);
            this.Osc1_TrackBarFrecuencia.Maximum = 4978;
            this.Osc1_TrackBarFrecuencia.Minimum = 16;
            this.Osc1_TrackBarFrecuencia.Name = "Osc1_TrackBarFrecuencia";
            this.Osc1_TrackBarFrecuencia.Orientation = System.Windows.Forms.Orientation.Vertical;
            this.Osc1_TrackBarFrecuencia.Size = new System.Drawing.Size(45, 104);
            this.Osc1_TrackBarFrecuencia.TabIndex = 17;
            this.Osc1_TrackBarFrecuencia.TickStyle = System.Windows.Forms.TickStyle.None;
            this.Osc1_TrackBarFrecuencia.Value = 16;
            this.Osc1_TrackBarFrecuencia.Scroll += new System.EventHandler(this.Osc1_TrackBarFrecuencia_Scroll);
            // 
            // groupBox2
            // 
            this.groupBox2.Controls.Add(this.Osc1_LabelSPO);
            this.groupBox2.Controls.Add(this.Osc1_Label);
            this.groupBox2.Controls.Add(this.Osc1_ButtonMute);
            this.groupBox2.Controls.Add(this.Osc1_TrackBarFrecuencia);
            this.groupBox2.Controls.Add(this.Osc1_ButtonC);
            this.groupBox2.Controls.Add(this.Osc1_ButtonT);
            this.groupBox2.Controls.Add(this.Osc1_TrackBarAmplitud);
            this.groupBox2.Controls.Add(this.Osc1_ButtonA);
            this.groupBox2.Controls.Add(this.Osc1_ButtonS);
            this.groupBox2.Location = new System.Drawing.Point(424, 12);
            this.groupBox2.Name = "groupBox2";
            this.groupBox2.Size = new System.Drawing.Size(100, 246);
            this.groupBox2.TabIndex = 18;
            this.groupBox2.TabStop = false;
            this.groupBox2.Text = "Oscilador 1";
            // 
            // Osc1_LabelSPO
            // 
            this.Osc1_LabelSPO.AutoSize = true;
            this.Osc1_LabelSPO.Location = new System.Drawing.Point(6, 228);
            this.Osc1_LabelSPO.Name = "Osc1_LabelSPO";
            this.Osc1_LabelSPO.Size = new System.Drawing.Size(35, 13);
            this.Osc1_LabelSPO.TabIndex = 34;
            this.Osc1_LabelSPO.Text = "label1";
            // 
            // Osc1_Label
            // 
            this.Osc1_Label.Location = new System.Drawing.Point(6, 183);
            this.Osc1_Label.Name = "Osc1_Label";
            this.Osc1_Label.Size = new System.Drawing.Size(87, 23);
            this.Osc1_Label.TabIndex = 33;
            this.Osc1_Label.Text = "Silencio";
            this.Osc1_Label.TextAlign = System.Drawing.ContentAlignment.MiddleCenter;
            // 
            // Osc1_ButtonMute
            // 
            this.Osc1_ButtonMute.Location = new System.Drawing.Point(37, 157);
            this.Osc1_ButtonMute.Name = "Osc1_ButtonMute";
            this.Osc1_ButtonMute.Size = new System.Drawing.Size(56, 23);
            this.Osc1_ButtonMute.TabIndex = 30;
            this.Osc1_ButtonMute.Text = "Silencio";
            this.Osc1_ButtonMute.UseVisualStyleBackColor = true;
            this.Osc1_ButtonMute.Click += new System.EventHandler(this.Osc1_ButtonMute_Click);
            // 
            // Osc1_ButtonC
            // 
            this.Osc1_ButtonC.Location = new System.Drawing.Point(37, 128);
            this.Osc1_ButtonC.Name = "Osc1_ButtonC";
            this.Osc1_ButtonC.Size = new System.Drawing.Size(25, 23);
            this.Osc1_ButtonC.TabIndex = 32;
            this.Osc1_ButtonC.Text = "C";
            this.Osc1_ButtonC.UseVisualStyleBackColor = true;
            this.Osc1_ButtonC.Click += new System.EventHandler(this.Osc1_ButtonC_Click);
            // 
            // Osc1_ButtonT
            // 
            this.Osc1_ButtonT.Location = new System.Drawing.Point(68, 128);
            this.Osc1_ButtonT.Name = "Osc1_ButtonT";
            this.Osc1_ButtonT.Size = new System.Drawing.Size(25, 23);
            this.Osc1_ButtonT.TabIndex = 29;
            this.Osc1_ButtonT.Text = "T";
            this.Osc1_ButtonT.UseVisualStyleBackColor = true;
            this.Osc1_ButtonT.Click += new System.EventHandler(this.Osc1_ButtonT_Click);
            // 
            // Osc1_ButtonA
            // 
            this.Osc1_ButtonA.Location = new System.Drawing.Point(6, 157);
            this.Osc1_ButtonA.Name = "Osc1_ButtonA";
            this.Osc1_ButtonA.Size = new System.Drawing.Size(25, 23);
            this.Osc1_ButtonA.TabIndex = 28;
            this.Osc1_ButtonA.Text = "A";
            this.Osc1_ButtonA.UseVisualStyleBackColor = true;
            this.Osc1_ButtonA.Click += new System.EventHandler(this.Osc1_ButtonA_Click);
            // 
            // Osc1_ButtonS
            // 
            this.Osc1_ButtonS.Location = new System.Drawing.Point(6, 128);
            this.Osc1_ButtonS.Name = "Osc1_ButtonS";
            this.Osc1_ButtonS.Size = new System.Drawing.Size(25, 23);
            this.Osc1_ButtonS.TabIndex = 31;
            this.Osc1_ButtonS.Text = "S";
            this.Osc1_ButtonS.UseVisualStyleBackColor = true;
            this.Osc1_ButtonS.Click += new System.EventHandler(this.Osc1_ButtonS_Click);
            // 
            // groupBox3
            // 
            this.groupBox3.Controls.Add(this.Osc2_LabelSPO);
            this.groupBox3.Controls.Add(this.Osc2_Label);
            this.groupBox3.Controls.Add(this.Osc2_ButtonMute);
            this.groupBox3.Controls.Add(this.Osc2_TrackBarFrecuencia);
            this.groupBox3.Controls.Add(this.Osc2_ButtonC);
            this.groupBox3.Controls.Add(this.Osc2_TrackBarAmplitud);
            this.groupBox3.Controls.Add(this.Osc2_ButtonT);
            this.groupBox3.Controls.Add(this.Osc2_ButtonS);
            this.groupBox3.Controls.Add(this.Osc2_ButtonA);
            this.groupBox3.Location = new System.Drawing.Point(530, 13);
            this.groupBox3.Name = "groupBox3";
            this.groupBox3.Size = new System.Drawing.Size(100, 246);
            this.groupBox3.TabIndex = 19;
            this.groupBox3.TabStop = false;
            this.groupBox3.Text = "Oscilador 2";
            // 
            // Osc2_LabelSPO
            // 
            this.Osc2_LabelSPO.AutoSize = true;
            this.Osc2_LabelSPO.Location = new System.Drawing.Point(6, 228);
            this.Osc2_LabelSPO.Name = "Osc2_LabelSPO";
            this.Osc2_LabelSPO.Size = new System.Drawing.Size(35, 13);
            this.Osc2_LabelSPO.TabIndex = 29;
            this.Osc2_LabelSPO.Text = "label2";
            // 
            // Osc2_Label
            // 
            this.Osc2_Label.Location = new System.Drawing.Point(5, 183);
            this.Osc2_Label.Name = "Osc2_Label";
            this.Osc2_Label.Size = new System.Drawing.Size(88, 23);
            this.Osc2_Label.TabIndex = 28;
            this.Osc2_Label.Text = "Silencio";
            this.Osc2_Label.TextAlign = System.Drawing.ContentAlignment.MiddleCenter;
            // 
            // Osc2_ButtonMute
            // 
            this.Osc2_ButtonMute.Location = new System.Drawing.Point(37, 157);
            this.Osc2_ButtonMute.Name = "Osc2_ButtonMute";
            this.Osc2_ButtonMute.Size = new System.Drawing.Size(56, 23);
            this.Osc2_ButtonMute.TabIndex = 25;
            this.Osc2_ButtonMute.Text = "Silencio";
            this.Osc2_ButtonMute.UseVisualStyleBackColor = true;
            this.Osc2_ButtonMute.Click += new System.EventHandler(this.Osc2_ButtonMute_Click);
            // 
            // Osc2_ButtonC
            // 
            this.Osc2_ButtonC.Location = new System.Drawing.Point(37, 128);
            this.Osc2_ButtonC.Name = "Osc2_ButtonC";
            this.Osc2_ButtonC.Size = new System.Drawing.Size(25, 23);
            this.Osc2_ButtonC.TabIndex = 27;
            this.Osc2_ButtonC.Text = "C";
            this.Osc2_ButtonC.UseVisualStyleBackColor = true;
            this.Osc2_ButtonC.Click += new System.EventHandler(this.Osc2_ButtonC_Click);
            // 
            // Osc2_ButtonT
            // 
            this.Osc2_ButtonT.Location = new System.Drawing.Point(68, 128);
            this.Osc2_ButtonT.Name = "Osc2_ButtonT";
            this.Osc2_ButtonT.Size = new System.Drawing.Size(25, 23);
            this.Osc2_ButtonT.TabIndex = 24;
            this.Osc2_ButtonT.Text = "T";
            this.Osc2_ButtonT.UseVisualStyleBackColor = true;
            this.Osc2_ButtonT.Click += new System.EventHandler(this.Osc2_ButtonT_Click);
            // 
            // Osc2_ButtonS
            // 
            this.Osc2_ButtonS.Location = new System.Drawing.Point(6, 128);
            this.Osc2_ButtonS.Name = "Osc2_ButtonS";
            this.Osc2_ButtonS.Size = new System.Drawing.Size(25, 23);
            this.Osc2_ButtonS.TabIndex = 26;
            this.Osc2_ButtonS.Text = "S";
            this.Osc2_ButtonS.UseVisualStyleBackColor = true;
            this.Osc2_ButtonS.Click += new System.EventHandler(this.Osc2_ButtonS_Click);
            // 
            // Osc2_ButtonA
            // 
            this.Osc2_ButtonA.Location = new System.Drawing.Point(6, 157);
            this.Osc2_ButtonA.Name = "Osc2_ButtonA";
            this.Osc2_ButtonA.Size = new System.Drawing.Size(25, 23);
            this.Osc2_ButtonA.TabIndex = 23;
            this.Osc2_ButtonA.Text = "A";
            this.Osc2_ButtonA.UseVisualStyleBackColor = true;
            this.Osc2_ButtonA.Click += new System.EventHandler(this.Osc2_ButtonA_Click);
            // 
            // groupBox4
            // 
            this.groupBox4.Controls.Add(this.Osc3_LabelSPO);
            this.groupBox4.Controls.Add(this.Osc3_Label);
            this.groupBox4.Controls.Add(this.Osc3_ButtonMute);
            this.groupBox4.Controls.Add(this.Osc3_ButtonC);
            this.groupBox4.Controls.Add(this.Osc3_ButtonT);
            this.groupBox4.Controls.Add(this.Osc3_ButtonA);
            this.groupBox4.Controls.Add(this.Osc3_ButtonS);
            this.groupBox4.Controls.Add(this.Osc3_TrackBarFrecuencia);
            this.groupBox4.Controls.Add(this.Osc3_TrackBarAmplitud);
            this.groupBox4.Location = new System.Drawing.Point(637, 12);
            this.groupBox4.Name = "groupBox4";
            this.groupBox4.Size = new System.Drawing.Size(100, 247);
            this.groupBox4.TabIndex = 20;
            this.groupBox4.TabStop = false;
            this.groupBox4.Text = "Oscilador 3";
            // 
            // Osc3_LabelSPO
            // 
            this.Osc3_LabelSPO.AutoSize = true;
            this.Osc3_LabelSPO.Location = new System.Drawing.Point(7, 228);
            this.Osc3_LabelSPO.Name = "Osc3_LabelSPO";
            this.Osc3_LabelSPO.Size = new System.Drawing.Size(35, 13);
            this.Osc3_LabelSPO.TabIndex = 24;
            this.Osc3_LabelSPO.Text = "label3";
            // 
            // Osc3_Label
            // 
            this.Osc3_Label.Location = new System.Drawing.Point(5, 184);
            this.Osc3_Label.Name = "Osc3_Label";
            this.Osc3_Label.Size = new System.Drawing.Size(88, 23);
            this.Osc3_Label.TabIndex = 23;
            this.Osc3_Label.Text = "Silencio";
            this.Osc3_Label.TextAlign = System.Drawing.ContentAlignment.MiddleCenter;
            // 
            // Osc3_ButtonMute
            // 
            this.Osc3_ButtonMute.Location = new System.Drawing.Point(37, 158);
            this.Osc3_ButtonMute.Name = "Osc3_ButtonMute";
            this.Osc3_ButtonMute.Size = new System.Drawing.Size(56, 23);
            this.Osc3_ButtonMute.TabIndex = 20;
            this.Osc3_ButtonMute.Text = "Silencio";
            this.Osc3_ButtonMute.UseVisualStyleBackColor = true;
            this.Osc3_ButtonMute.Click += new System.EventHandler(this.Osc3_ButtonMute_Click);
            // 
            // Osc3_ButtonC
            // 
            this.Osc3_ButtonC.Location = new System.Drawing.Point(37, 129);
            this.Osc3_ButtonC.Name = "Osc3_ButtonC";
            this.Osc3_ButtonC.Size = new System.Drawing.Size(25, 23);
            this.Osc3_ButtonC.TabIndex = 22;
            this.Osc3_ButtonC.Text = "C";
            this.Osc3_ButtonC.UseVisualStyleBackColor = true;
            this.Osc3_ButtonC.Click += new System.EventHandler(this.Osc3_ButtonC_Click);
            // 
            // Osc3_ButtonT
            // 
            this.Osc3_ButtonT.Location = new System.Drawing.Point(68, 129);
            this.Osc3_ButtonT.Name = "Osc3_ButtonT";
            this.Osc3_ButtonT.Size = new System.Drawing.Size(25, 23);
            this.Osc3_ButtonT.TabIndex = 19;
            this.Osc3_ButtonT.Text = "T";
            this.Osc3_ButtonT.UseVisualStyleBackColor = true;
            this.Osc3_ButtonT.Click += new System.EventHandler(this.Osc3_ButtonT_Click);
            // 
            // Osc3_ButtonA
            // 
            this.Osc3_ButtonA.Location = new System.Drawing.Point(6, 158);
            this.Osc3_ButtonA.Name = "Osc3_ButtonA";
            this.Osc3_ButtonA.Size = new System.Drawing.Size(25, 23);
            this.Osc3_ButtonA.TabIndex = 18;
            this.Osc3_ButtonA.Text = "A";
            this.Osc3_ButtonA.UseVisualStyleBackColor = true;
            this.Osc3_ButtonA.Click += new System.EventHandler(this.Osc3_ButtonA_Click);
            // 
            // Osc3_ButtonS
            // 
            this.Osc3_ButtonS.Location = new System.Drawing.Point(6, 129);
            this.Osc3_ButtonS.Name = "Osc3_ButtonS";
            this.Osc3_ButtonS.Size = new System.Drawing.Size(25, 23);
            this.Osc3_ButtonS.TabIndex = 21;
            this.Osc3_ButtonS.Text = "S";
            this.Osc3_ButtonS.UseVisualStyleBackColor = true;
            this.Osc3_ButtonS.Click += new System.EventHandler(this.Osc3_ButtonS_Click);
            // 
            // trackBarFrecuencia
            // 
            this.trackBarFrecuencia.Location = new System.Drawing.Point(12, 90);
            this.trackBarFrecuencia.Maximum = 4978;
            this.trackBarFrecuencia.Minimum = 16;
            this.trackBarFrecuencia.Name = "trackBarFrecuencia";
            this.trackBarFrecuencia.Size = new System.Drawing.Size(405, 45);
            this.trackBarFrecuencia.TabIndex = 21;
            this.trackBarFrecuencia.TickStyle = System.Windows.Forms.TickStyle.None;
            this.trackBarFrecuencia.Value = 16;
            this.trackBarFrecuencia.Scroll += new System.EventHandler(this.trackBarFrecuencia_Scroll);
            // 
            // labelFrecuencia
            // 
            this.labelFrecuencia.AutoSize = true;
            this.labelFrecuencia.Location = new System.Drawing.Point(13, 74);
            this.labelFrecuencia.Name = "labelFrecuencia";
            this.labelFrecuencia.Size = new System.Drawing.Size(103, 13);
            this.labelFrecuencia.TabIndex = 22;
            this.labelFrecuencia.Text = "Frecuencia General:";
            // 
            // labelMCM
            // 
            this.labelMCM.AutoSize = true;
            this.labelMCM.Location = new System.Drawing.Point(13, 121);
            this.labelMCM.Name = "labelMCM";
            this.labelMCM.Size = new System.Drawing.Size(35, 13);
            this.labelMCM.TabIndex = 23;
            this.labelMCM.Text = "SPO: ";
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(748, 266);
            this.Controls.Add(this.labelMCM);
            this.Controls.Add(this.labelFrecuencia);
            this.Controls.Add(this.trackBarFrecuencia);
            this.Controls.Add(this.groupBox4);
            this.Controls.Add(this.groupBox3);
            this.Controls.Add(this.groupBox2);
            this.Controls.Add(this.labelVolumen);
            this.Controls.Add(this.trackBarVolumen);
            this.Controls.Add(this.labelPower);
            this.Controls.Add(this.button2);
            this.Controls.Add(this.button1);
            this.KeyPreview = true;
            this.Name = "Form1";
            this.Text = "Sintetizador";
            this.KeyDown += new System.Windows.Forms.KeyEventHandler(this.Form1_KeyDown);
            this.KeyUp += new System.Windows.Forms.KeyEventHandler(this.Form1_KeyUp);
            ((System.ComponentModel.ISupportInitialize)(this.trackBarVolumen)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.Osc2_TrackBarFrecuencia)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.Osc2_TrackBarAmplitud)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.Osc3_TrackBarAmplitud)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.Osc3_TrackBarFrecuencia)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.Osc1_TrackBarAmplitud)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.Osc1_TrackBarFrecuencia)).EndInit();
            this.groupBox2.ResumeLayout(false);
            this.groupBox2.PerformLayout();
            this.groupBox3.ResumeLayout(false);
            this.groupBox3.PerformLayout();
            this.groupBox4.ResumeLayout(false);
            this.groupBox4.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.trackBarFrecuencia)).EndInit();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Button button1;
        private System.Windows.Forms.Button button2;
        private System.Windows.Forms.Label labelPower;
        private System.Windows.Forms.TrackBar trackBarVolumen;
        private System.Windows.Forms.Label labelVolumen;
        private System.Windows.Forms.TrackBar Osc2_TrackBarFrecuencia;
        private System.Windows.Forms.TrackBar Osc2_TrackBarAmplitud;
        private System.Windows.Forms.TrackBar Osc3_TrackBarAmplitud;
        private System.Windows.Forms.TrackBar Osc3_TrackBarFrecuencia;
        private System.Windows.Forms.TrackBar Osc1_TrackBarAmplitud;
        private System.Windows.Forms.TrackBar Osc1_TrackBarFrecuencia;
        private System.Windows.Forms.GroupBox groupBox2;
        private System.Windows.Forms.GroupBox groupBox3;
        private System.Windows.Forms.GroupBox groupBox4;
        private System.Windows.Forms.Button Osc3_ButtonMute;
        private System.Windows.Forms.Button Osc3_ButtonC;
        private System.Windows.Forms.Button Osc3_ButtonT;
        private System.Windows.Forms.Button Osc3_ButtonA;
        private System.Windows.Forms.Button Osc3_ButtonS;
        private System.Windows.Forms.Button Osc1_ButtonMute;
        private System.Windows.Forms.Button Osc1_ButtonC;
        private System.Windows.Forms.Button Osc1_ButtonT;
        private System.Windows.Forms.Button Osc1_ButtonA;
        private System.Windows.Forms.Button Osc1_ButtonS;
        private System.Windows.Forms.Button Osc2_ButtonMute;
        private System.Windows.Forms.Button Osc2_ButtonC;
        private System.Windows.Forms.Button Osc2_ButtonT;
        private System.Windows.Forms.Button Osc2_ButtonS;
        private System.Windows.Forms.Button Osc2_ButtonA;
        private System.Windows.Forms.Label Osc1_Label;
        private System.Windows.Forms.Label Osc2_Label;
        private System.Windows.Forms.Label Osc3_Label;
        private System.Windows.Forms.TrackBar trackBarFrecuencia;
        private System.Windows.Forms.Label labelFrecuencia;
        private System.Windows.Forms.Label Osc1_LabelSPO;
        private System.Windows.Forms.Label Osc2_LabelSPO;
        private System.Windows.Forms.Label Osc3_LabelSPO;
        private System.Windows.Forms.Label labelMCM;
    }
}

