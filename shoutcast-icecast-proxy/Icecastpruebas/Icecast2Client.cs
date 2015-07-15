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
    class Icecast2Client
    {
        private TcpClient Client;
        private string Server;
        private int Port;

        private string Password = "";
        private string User = "source";
        private String Mountpoint = "/stream.mp3";

        private Stream Icecast2Stream;

        private Byte[] bInMSG = new Byte[1024];
        private string InMSG;

        private Byte[] bOutMSG = new Byte[1024];
        private string OutMSG;

        private Hashtable IceData;

        public bool ReadyToStream = false;

        private Byte[] bInStream = new Byte[4096];
        private Byte[] bOutStream = new Byte[4096];

        public void StartClient()
        {
            Client = new TcpClient(Server, Port);

            Icecast2Stream = Client.GetStream();
        }

        public void CreateMountpoint(Hashtable IcyData, String Description)
        {
            IceData = new Hashtable();
            IceData.Add("ice-name", IcyData["icy-name"]);
            IceData.Add("ice-description", Description);
            IceData.Add("ice-url", IcyData["icy-url"]);
            IceData.Add("ice-genre", IcyData["icy-genre"]);
            IceData.Add("ice-bitrate", IcyData["icy-br"]);
            IceData.Add("ice-public", IcyData["icy-pub"]);
            if ((string)IceData["ice-public"] == "1") 
            { IceData.Add("ice-private", 0); } else { IceData.Add("ice-private", 1); }
            IceData.Add("ice-audio-info", "ice-samplerate=44100;ice-bitrate=" + IcyData["icy-br"] + ";ice-channels=2");

            Byte[] bOutMSG = Encoding.ASCII.GetBytes(
                "SOURCE "                   + Mountpoint + " ICE/1.0 "      + "\r\n" +
                "Authorization: Basic "     + EncodeTo64(User+':'+Password) + "\r\n" +
                "content-type: audio/mpeg"                                  + "\r\n" +
                "ice-name: "                + IceData["ice-name"]           + "\r\n" +
                "ice-url: "                 + IceData["ice-url"]            + "\r\n" +
                "ice-genre: "               + IceData["ice-genre"]          + "\r\n" +
                "ice-bitrate: "             + IceData["ice-bitrate"]        + "\r\n" +
                "ice-private: "             + IceData["ice-private"]        + "\r\n" +
                "ice-public: "              + IceData["ice-public"]         + "\r\n" +
                "ice-description: "         + IceData["ice-description"]    + "\r\n" +
                "ice-audio-info: "          + IceData["ice-audio-info"]     + "\r\n" +
                "\r\n");

            Icecast2Stream.Write(bOutMSG, 0, bOutMSG.Length);
            Icecast2Stream.Read(bInMSG, 0, bInMSG.Length);
            String ServerAnswer = Encoding.ASCII.GetString(bInMSG);
            if (!ServerAnswer.Contains("HTTP/1.0 200 OK\r\n\r\n"))
            {
                // Invalid Stream
            }
            else
            {
                // Valid Stream
                ReadyToStream = true;
            }
        }

        public void SendStream(Byte[] stream)
        {
            if (ReadyToStream == true)
            {
                Icecast2Stream.Write(stream, 0, stream.Length);
            }
        }

        public void SetDescription(String description)
        {
            IceData.Add("ice-description", description);
        }
        public void SetMounpoint(String mountpoint)
        {
            Mountpoint = mountpoint;
        }
        public void SetURL(String url)
        {
            IceData.Add("ice-url", url);
        }
        public void SetName(String name)
        {
            IceData.Add("ice-name", name);
        }
        public void SetGenre(String genre)
        {
            IceData.Add("ice-genre", genre);
        }

        public void SetServer(String server)
        {
            Server = server;
        }
        public void SetPort(int port)
        {
            Port = port;
        }
        public void SetPassword(String password)
        {
            Password = password;
        }
        public void SetUser(String user)
        {
            User = user;
        }

        private string EncodeTo64(string text)
        {
            byte[] textAsBytes = Encoding.ASCII.GetBytes(text);
            string returnValue = Convert.ToBase64String(textAsBytes);
            return returnValue;
        }
    }
}