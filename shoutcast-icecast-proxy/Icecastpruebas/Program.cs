using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Net;
using System.Net.Sockets;
using System.IO;


namespace IceShout
{
    class Program
    {
        
        static void Main(string[] args)
        {
            ShoutcastServer Shoutcast = new ShoutcastServer();
            Icecast2Client Icecast2 = new Icecast2Client();

            Console.WriteLine("Setting up Shoutcast");

            Shoutcast.SetIP(IPAddress.Loopback);
            Shoutcast.SetPort(8000);
            Shoutcast.SetPassword("hackme");
            Shoutcast.Start();

            Console.WriteLine("Waiting for a source");

            Shoutcast.NewSource();

            Console.WriteLine("Setting up icecast2");

            Icecast2.SetServer("rpgmaker.es");
            Icecast2.SetPort(8000);
            Icecast2.SetUser("source");
            Icecast2.SetPassword("welovemusic");
            Icecast2.SetMounpoint("/escuchar.mp3");
            Icecast2.StartClient();
            Icecast2.CreateMountpoint(Shoutcast.SourceIcyData, "pene pene pene");

            Console.WriteLine("Streaming...");

            while (Shoutcast.ReadyToStream && Icecast2.ReadyToStream)
            {
                Icecast2.SendStream( Shoutcast.GetStreaming() );
            }

            Console.WriteLine("Streaming finished");
            
        } // main
    } // Class

} // namespace
