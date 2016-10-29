namespace Initial_D_Street_Stage_Manager
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
            this.components = new System.ComponentModel.Container();
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(Form1));
            this.buttonXBB = new System.Windows.Forms.Button();
            this.listBox = new System.Windows.Forms.ListBox();
            this.contextMenuStrip = new System.Windows.Forms.ContextMenuStrip(this.components);
            this.extractToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.replaceToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.labelFilename = new System.Windows.Forms.Label();
            this.openFileDialog = new System.Windows.Forms.OpenFileDialog();
            this.saveFileDialog = new System.Windows.Forms.SaveFileDialog();
            this.buttonANA = new System.Windows.Forms.Button();
            this.buttonConvert = new System.Windows.Forms.Button();
            this.pictureBox = new System.Windows.Forms.PictureBox();
            this.panel = new System.Windows.Forms.Panel();
            this.buttonSaveMod = new System.Windows.Forms.Button();
            this.GIMToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.viewToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.saveToPNGToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.contextMenuStrip.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox)).BeginInit();
            this.panel.SuspendLayout();
            this.SuspendLayout();
            // 
            // buttonXBB
            // 
            this.buttonXBB.Location = new System.Drawing.Point(12, 231);
            this.buttonXBB.Name = "buttonXBB";
            this.buttonXBB.Size = new System.Drawing.Size(100, 23);
            this.buttonXBB.TabIndex = 0;
            this.buttonXBB.Text = "Load XBB";
            this.buttonXBB.UseVisualStyleBackColor = true;
            this.buttonXBB.Click += new System.EventHandler(this.buttonXBB_Click);
            // 
            // listBox
            // 
            this.listBox.ContextMenuStrip = this.contextMenuStrip;
            this.listBox.FormattingEnabled = true;
            this.listBox.Location = new System.Drawing.Point(12, 38);
            this.listBox.Name = "listBox";
            this.listBox.Size = new System.Drawing.Size(268, 186);
            this.listBox.TabIndex = 1;
            // 
            // contextMenuStrip
            // 
            this.contextMenuStrip.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.extractToolStripMenuItem,
            this.replaceToolStripMenuItem,
            this.GIMToolStripMenuItem});
            this.contextMenuStrip.Name = "contextMenuStrip";
            this.contextMenuStrip.Size = new System.Drawing.Size(153, 92);
            this.contextMenuStrip.Opening += new System.ComponentModel.CancelEventHandler(this.contextMenuStrip_Opening);
            // 
            // extractToolStripMenuItem
            // 
            this.extractToolStripMenuItem.Name = "extractToolStripMenuItem";
            this.extractToolStripMenuItem.Size = new System.Drawing.Size(152, 22);
            this.extractToolStripMenuItem.Text = "Extract";
            this.extractToolStripMenuItem.Click += new System.EventHandler(this.extractToolStripMenuItem_Click);
            // 
            // replaceToolStripMenuItem
            // 
            this.replaceToolStripMenuItem.Name = "replaceToolStripMenuItem";
            this.replaceToolStripMenuItem.Size = new System.Drawing.Size(152, 22);
            this.replaceToolStripMenuItem.Text = "Replace";
            this.replaceToolStripMenuItem.Click += new System.EventHandler(this.replaceToolStripMenuItem_Click);
            // 
            // labelFilename
            // 
            this.labelFilename.AutoSize = true;
            this.labelFilename.Location = new System.Drawing.Point(12, 12);
            this.labelFilename.Name = "labelFilename";
            this.labelFilename.Size = new System.Drawing.Size(90, 13);
            this.labelFilename.TabIndex = 3;
            this.labelFilename.Text = "Opened file name";
            // 
            // saveFileDialog
            // 
            this.saveFileDialog.AddExtension = false;
            // 
            // buttonANA
            // 
            this.buttonANA.Location = new System.Drawing.Point(12, 261);
            this.buttonANA.Name = "buttonANA";
            this.buttonANA.Size = new System.Drawing.Size(100, 23);
            this.buttonANA.TabIndex = 5;
            this.buttonANA.Text = "Load ANA";
            this.buttonANA.UseVisualStyleBackColor = true;
            this.buttonANA.Click += new System.EventHandler(this.buttonANA_Click);
            // 
            // buttonConvert
            // 
            this.buttonConvert.Location = new System.Drawing.Point(177, 260);
            this.buttonConvert.Name = "buttonConvert";
            this.buttonConvert.Size = new System.Drawing.Size(100, 23);
            this.buttonConvert.TabIndex = 6;
            this.buttonConvert.Text = "Convert GIM";
            this.buttonConvert.UseVisualStyleBackColor = true;
            this.buttonConvert.Click += new System.EventHandler(this.buttonConvert_Click);
            // 
            // pictureBox
            // 
            this.pictureBox.BackgroundImage = global::Initial_D_Street_Stage_Manager.Properties.Resources.InitialDStreetStage;
            this.pictureBox.BackgroundImageLayout = System.Windows.Forms.ImageLayout.Center;
            this.pictureBox.InitialImage = null;
            this.pictureBox.Location = new System.Drawing.Point(3, 3);
            this.pictureBox.Name = "pictureBox";
            this.pictureBox.Size = new System.Drawing.Size(512, 256);
            this.pictureBox.TabIndex = 7;
            this.pictureBox.TabStop = false;
            // 
            // panel
            // 
            this.panel.AutoScroll = true;
            this.panel.Controls.Add(this.pictureBox);
            this.panel.Location = new System.Drawing.Point(286, 12);
            this.panel.Name = "panel";
            this.panel.Size = new System.Drawing.Size(536, 275);
            this.panel.TabIndex = 8;
            // 
            // buttonSaveMod
            // 
            this.buttonSaveMod.Location = new System.Drawing.Point(177, 231);
            this.buttonSaveMod.Name = "buttonSaveMod";
            this.buttonSaveMod.Size = new System.Drawing.Size(99, 23);
            this.buttonSaveMod.TabIndex = 9;
            this.buttonSaveMod.Text = "Save Modified";
            this.buttonSaveMod.UseVisualStyleBackColor = true;
            this.buttonSaveMod.Click += new System.EventHandler(this.buttonSaveMod_Click);
            // 
            // GIMToolStripMenuItem
            // 
            this.GIMToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.viewToolStripMenuItem,
            this.saveToPNGToolStripMenuItem});
            this.GIMToolStripMenuItem.Name = "GIMToolStripMenuItem";
            this.GIMToolStripMenuItem.Size = new System.Drawing.Size(152, 22);
            this.GIMToolStripMenuItem.Text = "GIM";
            // 
            // viewToolStripMenuItem
            // 
            this.viewToolStripMenuItem.Name = "viewToolStripMenuItem";
            this.viewToolStripMenuItem.Size = new System.Drawing.Size(152, 22);
            this.viewToolStripMenuItem.Text = "View";
            this.viewToolStripMenuItem.Click += new System.EventHandler(this.viewToolStripMenuItem_Click);
            // 
            // saveToPNGToolStripMenuItem
            // 
            this.saveToPNGToolStripMenuItem.Name = "saveToPNGToolStripMenuItem";
            this.saveToPNGToolStripMenuItem.Size = new System.Drawing.Size(152, 22);
            this.saveToPNGToolStripMenuItem.Text = "Save to PNG";
            this.saveToPNGToolStripMenuItem.Click += new System.EventHandler(this.saveToPNGToolStripMenuItem_Click);
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 13F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(832, 299);
            this.Controls.Add(this.buttonConvert);
            this.Controls.Add(this.buttonSaveMod);
            this.Controls.Add(this.buttonANA);
            this.Controls.Add(this.labelFilename);
            this.Controls.Add(this.listBox);
            this.Controls.Add(this.buttonXBB);
            this.Controls.Add(this.panel);
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.Name = "Form1";
            this.Text = "Initial D Street Stage Manager";
            this.contextMenuStrip.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.pictureBox)).EndInit();
            this.panel.ResumeLayout(false);
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.Button buttonXBB;
        private System.Windows.Forms.ListBox listBox;
        private System.Windows.Forms.Label labelFilename;
        private System.Windows.Forms.OpenFileDialog openFileDialog;
        private System.Windows.Forms.SaveFileDialog saveFileDialog;
        private System.Windows.Forms.Button buttonANA;
        private System.Windows.Forms.Button buttonConvert;
        private System.Windows.Forms.PictureBox pictureBox;
        private System.Windows.Forms.Panel panel;
        private System.Windows.Forms.ContextMenuStrip contextMenuStrip;
        private System.Windows.Forms.ToolStripMenuItem extractToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem replaceToolStripMenuItem;
        private System.Windows.Forms.Button buttonSaveMod;
        private System.Windows.Forms.ToolStripMenuItem GIMToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem viewToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem saveToPNGToolStripMenuItem;
    }
}

