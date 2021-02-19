using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System.Net.NetworkInformation;
/*
public class ping : MonoBehaviour
{

    Material red;
    Material green;

    using System;
using System.Net;
using System.Net.NetworkInformation;
using System.Text;

namespace Examples.System.Net.NetworkInformation.PingTest
{
    public class PingExample
    {
        // args[0] can be an IPaddress or host name.
        public static void Main(string[] args)
        {
            Ping pingSender = new Ping();
            PingOptions options = new PingOptions();

            // Use the default Ttl value which is 128,
            // but change the fragmentation behavior.
            options.DontFragment = true;

            // Create a buffer of 32 bytes of data to be transmitted.
            string data = "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa";
            byte[] buffer = Encoding.ASCII.GetBytes(data);
            int timeout = 120;
            PingReply reply = pingSender.Send(args[0], timeout, buffer, options);
            if (reply.Status == IPStatus.Success)
            {
                Console.WriteLine("Address: {0}", reply.Address.ToString());
                Console.WriteLine("RoundTrip time: {0}", reply.RoundtripTime);
                Console.WriteLine("Time to live: {0}", reply.Options.Ttl);
                Console.WriteLine("Don't fragment: {0}", reply.Options.DontFragment);
                Console.WriteLine("Buffer size: {0}", reply.Buffer.Length);
            }
        }
    }
}

IEnumerator PingGoogle()
    {
        System.Net.NetworkInformation.Ping googPing = new System.Net.NetworkInformation.Ping("74.125.224.72");
        Debug.Log(googPing.ip);
        googPing.pin
        // keep in mind that 'Ping' only accepts IP addresses, it doesn't 
        // do DNS lookup. This address may not work for your location-
        // Google owns many servers the world over.
        while (!googPing.isDone)
        {
            yield return null;
        }
        Debug.Log(googPing.time);
        gameObject.GetComponent<Renderer>().material = green;
    }
    // Update is called once per frame
    void Update()
    {
        
    }
}
*/