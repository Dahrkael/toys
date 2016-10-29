using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using System.IO;
using System.Diagnostics;
using System.Linq;

namespace Initial_D_Street_Stage_Manager
{
    public partial class Form1 : Form
    {
        public string filename;
        public string file_type;
        public List<SubFile> Files;
        public byte[] ant_section;

        public Form1()
        {
            InitializeComponent();
            Files = new List<SubFile>();
        }

        private void contextMenuStrip_Opening(object sender, CancelEventArgs e)
        {
            if (listBox.SelectedIndex == -1)
            { contextMenuStrip.Items[0].Enabled = false; contextMenuStrip.Items[1].Enabled = false; }
            else
            { contextMenuStrip.Items[0].Enabled = true; contextMenuStrip.Items[1].Enabled = true; }
        }

        //////////////////////////////////////////////////////////////////////////////////////////////////////
        // Extraer fichero
        //////////////////////////////////////////////////////////////////////////////////////////////////////
        private void extractToolStripMenuItem_Click(object sender, EventArgs e)
        {
            //BinaryReader file = new BinaryReader(File.Open(filename, FileMode.Open));
            //file.BaseStream.Seek(Files[listBox.SelectedIndex].offset, SeekOrigin.Begin);
            //byte[] buffer;// = new byte[Files[listBox.SelectedIndex].size];
            //buffer = file.ReadBytes((int)Files[listBox.SelectedIndex].size);
            //file.Close();
            saveFileDialog.FileName = Files[listBox.SelectedIndex].filename;
            if (!Path.HasExtension(saveFileDialog.FileName))
            { saveFileDialog.FileName += ".gim"; }
            if (saveFileDialog.ShowDialog() == DialogResult.OK)
            {
                BinaryWriter file2 = new BinaryWriter(File.Open(saveFileDialog.FileName, FileMode.Create));
                file2.Write(Files[listBox.SelectedIndex].buffer);
                file2.Close();
                MessageBox.Show("File extracted!");
            }
        }

        //////////////////////////////////////////////////////////////////////////////////////////////////////
        // Reemplazar fichero
        //////////////////////////////////////////////////////////////////////////////////////////////////////
        private void replaceToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (openFileDialog.ShowDialog() == DialogResult.OK)
            {
                BinaryReader file = new BinaryReader(File.Open(openFileDialog.FileName, FileMode.Open));
                Files[listBox.SelectedIndex].buffer = file.ReadBytes((int)file.BaseStream.Length);
                uint old_size = Files[listBox.SelectedIndex].size;
                uint difference = (uint)file.BaseStream.Length - old_size;
                Files[listBox.SelectedIndex].size = (uint)file.BaseStream.Length;

                for (int i = listBox.SelectedIndex + 1; i < Files.Count; i++) // Recalcular offsets
                { Files[i].offset += difference; }
            }
        }

        //////////////////////////////////////////////////////////////////////////////////////////////////////
        // Ver fichero GIM
        //////////////////////////////////////////////////////////////////////////////////////////////////////
        private void viewToolStripMenuItem_Click(object sender, EventArgs e)
        {
            Bitmap preview = GIM.Decode(Files[listBox.SelectedIndex].buffer);
            pictureBox.Width = preview.Width;
            pictureBox.Height = preview.Height;
            pictureBox.Image = preview;
            pictureBox.BackgroundImage = null;
        }

        //////////////////////////////////////////////////////////////////////////////////////////////////////
        // Extraer fichero GIM como PNG
        //////////////////////////////////////////////////////////////////////////////////////////////////////
        private void saveToPNGToolStripMenuItem_Click(object sender, EventArgs e)
        {
            if (saveFileDialog.ShowDialog() == DialogResult.OK)
            {
                Bitmap gim = GIM.Decode(Files[listBox.SelectedIndex].buffer);
                gim.Save(saveFileDialog.FileName);
            }
        }

        //////////////////////////////////////////////////////////////////////////////////////////////////////
        // Leer fichero XBB
        //////////////////////////////////////////////////////////////////////////////////////////////////////
        private void buttonXBB_Click(object sender, EventArgs e)
        {
            if (openFileDialog.ShowDialog() == DialogResult.OK)
            {
                filename = openFileDialog.FileName;
                labelFilename.Text = Path.GetFileName(filename);
                BinaryReader file = new BinaryReader(File.Open(filename, FileMode.Open));
                
                if (file.ReadUInt32() != 0x01424258) // 58 42 42 01 02
                { MessageBox.Show("Incorrect header. Correct file?"); file.Close(); return; }

                file.ReadBytes(28); // Read padding
                Files.Clear(); // Borrar archivos anteriores
                listBox.Items.Clear(); // Borrar lista anterior
                while (true) // Leer los datos de los archivos contenidos
                {
                    SubFile temp = new SubFile(); // Crear archivo temporal
                    temp.offset = file.ReadUInt32(); // leer offset de inicio
                    if (temp.offset > file.BaseStream.Length) // si el offset es mayor que el tamaño del archivo
                    { break; }                                // es que ya no hay mas archivos
                    temp.size = file.ReadUInt32(); // Tamaño del archivo
                    temp.name_offset = file.ReadUInt32(); // posicion del nombre
                    temp.identifier = file.ReadUInt32(); // identificador
                    Files.Add(temp); // añadirlo a la lista de archivos
                }
                file.BaseStream.Seek(-4, SeekOrigin.Current); // Volver atras para leer el identificador
                for (int i = 0; i < Files.Count; i++) // Hay tantos ids como archivos conocidos
                {
                    uint temp = file.ReadUInt32(); // leer el id
                    for (int j = 0; j < Files.Count; j++) // buscar el archivo con ese id
                    { if (Files[j].identifier == temp) { Files[j].ordinal = file.ReadUInt32(); } } // leer el ordinal
                }

                for (int i = 0; i < Files.Count; i++) // leer los nombres de cada archivo
                {
                    file.BaseStream.Seek(Files[i].name_offset, SeekOrigin.Begin); // mover el puntero al offset del nombre
                    char[] temp = new char[256];
                    while (true)
                    {
                        char temp2 = file.ReadChar();
                        if (temp2 == 0x00) { break; } // si es null terminar
                        temp.SetValue(temp2, temp.Count(p => p != 0x00)); // ir añadiendo los caracteres
                    }
                    Files[i].filename = new String(temp).Trim('\0'); // asignar el nombre completo sin nulls
                    string temp3 = Files[i].ordinal.ToString("D2");
                    temp3 += "   "; temp3 += Files[i].filename;
                    temp3 += "   "; temp3 += Files[i].size.ToString();
                    temp3 += "   "; temp3 += Files[i].offset.ToString();
                    listBox.Items.Add(temp3); // añadir la informacion al listbox
                }
                listBox.Sorted = true;

                // Meter el contenido de cada fichero en un buffer, para no liar el reemplazo demasiado
                for (int i = 0; i < Files.Count; i++)
                {
                    file.BaseStream.Seek(Files[i].offset, SeekOrigin.Begin);
                    Files[i].buffer = file.ReadBytes((int)Files[i].size);
                }
                file_type = "xbb";
                file.Close(); // cerrar el archivo
            }
        }

        //////////////////////////////////////////////////////////////////////////////////////////////////////
        // Leer fichero ANA
        //////////////////////////////////////////////////////////////////////////////////////////////////////
        private void buttonANA_Click(object sender, EventArgs e)
        {
            uint anafile_size;
            uint subfiles_count;

            if (openFileDialog.ShowDialog() == DialogResult.OK)
            {
                Files.Clear(); // Borrar archivos anteriores
                listBox.Items.Clear(); // Borrar lista anterior

                filename = openFileDialog.FileName;
                labelFilename.Text = Path.GetFileName(filename);
                BinaryReader file = new BinaryReader(File.Open(filename, FileMode.Open));

                if (file.ReadUInt32() != 0x414E4140) // 40 41 4E 41   
                { MessageBox.Show("Incorrect header. Correct file?"); file.Close(); return; }

                file.ReadUInt32(); // Read (non)padding
                anafile_size = file.ReadUInt32(); // Read ANA size
                file.ReadUInt32(); // Read (non)padding
                subfiles_count = file.ReadUInt32();
                file.ReadUInt32(); file.ReadUInt32(); file.ReadUInt32(); // Read padding
                for (uint i = 0; i < subfiles_count; i++)
                {
                    SubFile temp = new SubFile();
                    temp.offset = file.ReadUInt32();
                    temp.size = file.ReadUInt32();
                    temp.filename = new String(file.ReadChars(8)).Trim('\0');
                    Files.Add(temp);
                    listBox.Items.Add(temp.filename);
                }
                listBox.Sorted = false;
                // Meter el contenido de cada fichero en un buffer, para no liar el reemplazo demasiado
                for (int i = 0; i < Files.Count; i++)
                {
                    file.BaseStream.Seek(Files[i].offset, SeekOrigin.Begin);
                    Files[i].buffer = file.ReadBytes((int)Files[i].size);
                }

                // experimental
                // copiar fragmento ANT a un buffer para luego
                file.BaseStream.Seek(Files[Files.Count - 1].offset + Files[Files.Count - 1].size, SeekOrigin.Begin);
                ant_section = file.ReadBytes((int)file.BaseStream.Length - (int)file.BaseStream.Position);
                // experimental

                file_type = "ana";
                file.Close();
            }
        }

        //////////////////////////////////////////////////////////////////////////////////////////////////////
        // Convertir fichero GIM a PNG
        //////////////////////////////////////////////////////////////////////////////////////////////////////
        private void buttonConvert_Click(object sender, EventArgs e)
        {
            if (openFileDialog.ShowDialog() == DialogResult.OK)
            {
                BinaryReader file = new BinaryReader(File.Open(openFileDialog.FileName, FileMode.Open));

                if (file.ReadUInt32() != 0x2E47494D) // 4D 49 47 2E
                { MessageBox.Show("Incorrect header. Correct file?"); file.Close(); return; }
                file.Close();

                string inf = openFileDialog.FileName;
                string outf = Path.ChangeExtension(openFileDialog.FileName, ".png");

                Bitmap preview = GIM.Decode(inf);
                preview.Save(outf);

                pictureBox.Width = preview.Width;
                pictureBox.Height = preview.Height;
                pictureBox.Image = preview;
                pictureBox.BackgroundImage = null;
            }
        }

        private void buttonSaveMod_Click(object sender, EventArgs e)
        {
            if (file_type == "xbb") { saveXBB(); return; }
            if (file_type == "ana") { saveANA(); return; }
            MessageBox.Show("Save what?");
        }

        private void saveXBB()
        {
            if (saveFileDialog.ShowDialog() == DialogResult.OK)
            {
                BinaryWriter file = new BinaryWriter(File.Open(saveFileDialog.FileName, FileMode.Create));
                // Write header
                file.Write(0x01424258); file.Write(0x00000007);
                file.Write(0x00000000); file.Write(0x00000000); file.Write(0x00000000);
                file.Write(0x00000000); file.Write(0x00000000); file.Write(0x00000000);
                // Write offsets, sizes and ids
                for(int i = 0; i < Files.Count; i++)
                {
                    file.Write(Files[i].offset);
                    file.Write(Files[i].size);
                    file.Write(Files[i].name_offset);
                    file.Write(Files[i].identifier);
                }
                // Write ids and ordinals
                for (int i = 0; i < Files.Count; i++)
                {
                    file.Write(Files[i].identifier);
                    file.Write(Files[i].ordinal);
                }
                // Write names
                for (int i = 0; i < Files.Count; i++)
                {
                    file.Write(Encoding.ASCII.GetBytes(Files[i].filename)); // stupid unicode!
                    file.Write('\0');
                }
                uint padding = Files[0].offset - (uint)file.BaseStream.Position; // get padding from header to first file
                for (int i = 0; i < padding; i++) { file.Write('\0'); } // write padding

                for (int i = 0; i < Files.Count; i++)
                {
                    file.BaseStream.Seek(Files[i].offset, SeekOrigin.Begin); // untested, but looks like it works
                    file.Write(Files[i].buffer);
                }
                file.Close();
                MessageBox.Show("New XBB File Written");
            }
        }

        private void saveANA()
        {
            if (saveFileDialog.ShowDialog() == DialogResult.OK)
            {
                BinaryWriter file = new BinaryWriter(File.Open(saveFileDialog.FileName, FileMode.Create));

                // write header
                file.Write(0x414E4140); file.Write(0x00000010);
                // write file size
                uint total_size = 32;
                for (int i = 0; i < Files.Count; i++)
                { total_size += 16 + Files[i].size; }
                file.Write(total_size);
                file.Write(0x00000100); // Unknown
                file.Write(Files.Count);  // number of files
                file.Write(0x00000000); file.Write(0x00000000); file.Write(0x00000000); // padding
                for (int i = 0; i < Files.Count; i++)
                {
                    file.Write(Files[i].offset);
                    file.Write(Files[i].size);
                    file.Write(Encoding.ASCII.GetBytes(Files[i].filename)); // stupid unicode!
                    file.Write('\0');
                }
                for (int i = 0; i < Files.Count; i++)
                {
                    file.BaseStream.Seek(Files[i].offset, SeekOrigin.Begin); // untested, but looks like it works
                    file.Write(Files[i].buffer);
                }
                // experimental
                // Guardar fragmento ANT leido anteriormente
                file.Write(ant_section);
                // experimental
                file.Close();
                MessageBox.Show("New ANA File Written.");
            }
        }
    }
}
