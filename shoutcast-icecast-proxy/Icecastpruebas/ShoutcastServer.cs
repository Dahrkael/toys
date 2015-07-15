using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Net;
using System.Net.Sockets;
using System.IO;

namespace IceShout
{
    class ShoutcastServer
    {
        private TcpListener Server;
        private IPAddress IP = IPAddress.Loopback;
        private int Port = 8000;
        private string Password = "";

        private Socket Source;
        private string SourceIP;
        public Hashtable SourceIcyData;

        private Byte[] bInMSG = new Byte[1024];
        private string InMSG;

        private Byte[] bOutMSG = new Byte[1024];
        private string OutMSG;

        public bool ReadyToStream = false;

        private int Data = 0; 
        private int Timeout = 0;

        private Byte[] bInStream = new Byte[4096];
        private Byte[] bOutStream = new Byte[4096];

        public void Start()
        {
            Server = new TcpListener(IP, Port);
            Server.Start();
        }

        public void NewSource()
        {
            Source = Server.AcceptSocket();
            if (Source.Connected)
            {
                Console.WriteLine("Source connected");
                SourceIP = Source.RemoteEndPoint.ToString();

                Source.Receive(bInMSG, bInMSG.Length, 0);
                InMSG = Encoding.ASCII.GetString(bInMSG);

                if (!InMSG.Contains(Password + "\n"))
                {
                    Source.Send(Encoding.ASCII.GetBytes("invalid password\r\n"));
                }
                else
                {
                    Console.WriteLine("Password accepted");
                    InMSG.Replace(Password, "");
                    
                    //Source.Receive(bInMSG, bInMSG.Length, 0);
                    //InMSG = Encoding.ASCII.GetString(bInMSG);

                    string[] sSourceIcyData = InMSG.Replace("\n", ":").Split(new Char[] { ':' });

                    SourceIcyData = new Hashtable();
                    SourceIcyData.Add("icy-name", Convert.ToString(sSourceIcyData[1]));
                    SourceIcyData.Add("icy-genre", Convert.ToString(sSourceIcyData[3]));
                    SourceIcyData.Add("icy-url", Convert.ToString(sSourceIcyData[5]));
                    SourceIcyData.Add("icy-irc", Convert.ToString(sSourceIcyData[7]));
                    SourceIcyData.Add("icy-icq", Convert.ToString(sSourceIcyData[9]));
                    SourceIcyData.Add("icy-aim", Convert.ToString(sSourceIcyData[11]));
                    SourceIcyData.Add("icy-pub", Convert.ToString(sSourceIcyData[13]));
                    SourceIcyData.Add("icy-br", Convert.ToString(sSourceIcyData[15]));

                    Source.Send(Encoding.ASCII.GetBytes("OK2\r\nicy-caps:11\r\n\r\n"));
                    ReadyToStream = true;
                }
            }

        }

        public byte[] GetStreaming()
        {
            if (ReadyToStream == true)
            {
                Data = Source.Receive(bInStream, bInStream.Length, 0);
                Console.WriteLine("Received" + Data.ToString() + "bytes");
                //if (Data == 0)
                //{
                    //Timeout++;
                    //if (Timeout > 10)
                   // {
                   //     Source.Close();
                   //     ReadyToStream = false;
                   // }
                //}
                return bInStream;
            }
            return bInStream;
        }

        public void SetIP(IPAddress ip)
        {
            IP = ip;
        }
        public void SetPort(int port)
        {
            Port = port;
        }
        public void SetPassword(string pass)
        {
            Password = pass;
        }
    }
}