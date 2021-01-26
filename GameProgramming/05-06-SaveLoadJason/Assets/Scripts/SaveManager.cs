//using System.Collections;
//using System.Collections.Generic;
//using System.Collections.Generic;
//using UnityEngine;
//using System.Collections;
//using UnityEngine.Serialization;
//using TMPro;

using UnityEngine;
using System;
using System.IO;
using System.Text;
using System.Net;


[Serializable]
public struct MultiplePlayers
{
    public PlayerInfo[] players;
    public MultiplePlayers(PlayerInfo[] players)
    {
        this.players = players;
    }
}

[Serializable]
public struct PlayerInfo
{
    public string Name;
    public Vector3 Position;
    

    public PlayerInfo(string Name, Vector3 Position)
    {
        this.Name = Name;
        this.Position = Position;
    }
}
public class SaveManager : MonoBehaviour
{
public bool saveOnline = false;
    public void SaveData()
    {
        Debug.Log("StartSaving");

        MultiplePlayers multiplePlayers = StoreThisData();

        //turn class into json 
        string jsonString = JsonUtility.ToJson(multiplePlayers);

        //save that
        SaveToFile("GameSaveFile", jsonString);
        if(saveOnline)
            SaveOnWeb("GameSaveFile", jsonString);

        Debug.Log("GameSaved");
    }

    public void SaveToFile(string fileName, string jsonString)
    {
        // Open a file in write mode. This will create the file if it's missing.
        // It is assumed that the path already exists.
        // The "using" statement will automatically close the stream after we leave
        // the scope - this is VERY important
        using (FileStream stream = File.OpenWrite(Application.persistentDataPath + "\\" + fileName))
        {
            // Truncate the file if it exists (we want to overwrite the file)
            stream.SetLength(0);

            // Convert the string into bytes. Assume that the character-encoding is UTF8.
            Byte[] bytes = Encoding.UTF8.GetBytes(jsonString);

            // Write the bytes to the hard-drive
            stream.Write(bytes, 0, bytes.Length);
        }
    }

    //Saves the playerInfo string on the server.
    public void SaveOnWeb(string fileName, string saveData)
    {
        // Create a request for the URL.
        WebRequest request = (HttpWebRequest)WebRequest.Create("http://localhost:8080/" + fileName);
        request.ContentType = "application/json";
        request.Method = "PUT";

        // If required by the server, set the credentials.
        request.Credentials = CredentialCache.DefaultCredentials;
        
        using (StreamWriter streamWriter = new StreamWriter(request.GetRequestStream()))
        {
            streamWriter.Write(saveData);
            streamWriter.Close();
        }
        /*


        // Set the 'ContentLength' property of the WebRequest.
        request.ContentLength = byteArray.Length;
        Stream newStream = request.GetRequestStream();
        newStream.Write(byteArray, 0, byteArray.Length);

        /*/
        WebResponse httpResponse = (HttpWebResponse)request.GetResponse();
        using (StreamReader streamReader = new StreamReader(httpResponse.GetResponseStream()))
        {
            string result = streamReader.ReadToEnd();
            Debug.Log(result);
        }
        /*
         */
    }

    public MultiplePlayers StoreThisData()
    {
        //Get player info
        Move[] players = FindObjectsOfType<Move>();
        
        //Create holder object
        MultiplePlayers multiplePlayers = new MultiplePlayers(new PlayerInfo[players.Length]);


        //put info in playerinfo class
        for (int i = 0; i < players.Length; i++)
        {
            multiplePlayers.players[i] = new PlayerInfo(players[i].transform.name, players[i].transform.position);
        }

        return multiplePlayers;
    }

    public void LoadData()
    {
        Debug.Log("Start Loading");

        //load file from HDD
        string jsonStringLocal = Load("GameSaveFile");


        //load file from server
        if (saveOnline)
        {
            string jsonStringOnLine = LoadFromWeb("GameSaveFile");

            if (jsonStringOnLine != jsonStringLocal)
            {
                Debug.LogError("Local save file is not the same as Online save file");
            }
        }

        MultiplePlayers multiplePlayers = JsonUtility.FromJson<MultiplePlayers>(jsonStringLocal);
        SetDataToObject(multiplePlayers);
        Debug.Log("Loaded");
    }

    public string Load(string fileName)
    {
        // Open a stream for the supplied file name as a text file
        using (StreamReader stream = File.OpenText(Application.persistentDataPath + "\\" + fileName))
        {
            // Read the entire file and return the result. 
            // This assumes that we've written the file in UTF-8
            return stream.ReadToEnd();
        }
    }


    public string LoadFromWeb(string name)
    {
        WebRequest request = (HttpWebRequest)WebRequest.Create("http://localhost:8080/" + name);
        WebResponse response = (HttpWebResponse)request.GetResponse();

        // Open a stream to the server so we can read the response data it sent back from our GET request
        using (Stream stream = response.GetResponseStream())
        {
            using (StreamReader reader = new StreamReader(stream))
            {
                // Read the entire body as a string
                string body = reader.ReadToEnd();
                return body;
            }
        }
    }
    public void SetDataToObject(MultiplePlayers multiplePlayers)
    {
        Move[] players = FindObjectsOfType<Move>();

        for (int i = 0; i < players.Length; i++)
        {
            players[i].transform.name = multiplePlayers.players[i].Name;
            players[i].transform.position = multiplePlayers.players[i].Position;
        }
    }
}
