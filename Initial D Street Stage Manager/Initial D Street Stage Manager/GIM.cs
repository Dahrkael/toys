using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.IO;
using GimSharp;
using ImgSharp;
using System.Drawing;
using System.Drawing.Imaging;

namespace Initial_D_Street_Stage_Manager
{
    public class GIM
    {
        public GIM()
        {
            
        }

        public static Bitmap Decode(string filename)
        {
            try
            {
                GimFile file = new GimFile(filename);
                ImgFile file2 = new ImgFile(file.GetDecompressedData(), file.GetWidth(), file.GetHeight(), ImageFormat.Png);
                return new Bitmap(new MemoryStream(file2.GetCompressedData()));
            }
            catch
            {
                return null;
            }
        }

        public static Bitmap Decode(byte[] data)
        {
            try
            {
                GimFile file = new GimFile(data);
                ImgFile file2 = new ImgFile(file.GetDecompressedData(), file.GetWidth(), file.GetHeight(), ImageFormat.Png);
                return new Bitmap(new MemoryStream(file2.GetCompressedData()));
            }
            catch
            {
                return null;
            }
        }

        public static Stream Encode(Stream data)
        {
            return null;
        }
    }


}
