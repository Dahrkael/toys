using System;
using System.Collections.Generic;
using System.Text;

namespace Initial_D_Street_Stage_Manager
{
    public class SubFile
    {
        public string filename;
        public uint offset;
        public uint size;
        public uint name_offset;
        public uint identifier;
        public uint ordinal;
        public byte[] buffer;
    }
}
