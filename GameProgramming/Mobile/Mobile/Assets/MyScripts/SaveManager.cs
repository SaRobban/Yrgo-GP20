using System.Collections;
using UnityEngine;
using System;
using System.IO;
using System.Text;
using System.Net;

using Firebase;
using Firebase.Extensions;
using Firebase.Database;
using Firebase.Auth;

[Serializable]
public struct DataToStore
{
    public PlayerInfo[] players;
    public DataToStore(PlayerInfo[] players)
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
    public void SetDataToObject(DataToStore storedData)
    {
        Move[] players = FindObjectsOfType<Move>();

        for (int i = 0; i < players.Length; i++)
        {
            players[i].transform.name = storedData.players[i].Name;
            players[i].transform.position = storedData.players[i].Position;
        }
    }

    //Start Here
    public bool storeLocal = false;
    public bool storeOnline = false;
    public bool storeFireBase = false;
    public void SaveData()
    {
        Debug.Log("StartSaving");

        DataToStore storedData = StoreThisData();

        //turn class into json 
        string jsonString = JsonUtility.ToJson(storedData);

        //save that
        if (storeLocal)
            SaveToFile("GameSaveFile", jsonString);

        if (storeOnline)
            SaveOnWeb("GameSaveFile", jsonString);

        if (storeFireBase)
            StartCoroutine(SaveToFireBase("GameSaveFile", jsonString));

        if (!storeLocal && !storeOnline && !storeFireBase)
            Debug.Log("Error : NO SELECTED TARGET FOR SAVEFILE");
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
    }

    IEnumerator SaveToFireBase(string userID, string jsonString)
    {
        Debug.Log("Start save to FireBase");

        FirebaseAuth auth = FirebaseAuth.DefaultInstance;
        FirebaseUser user = auth.CurrentUser;

        FirebaseDatabase db = FirebaseDatabase.DefaultInstance;
        var dataTask = db.RootReference.Child("users").Child(FirebaseAuth.DefaultInstance.CurrentUser.UserId).SetRawJsonValueAsync(jsonString);
        yield return new WaitUntil(() => dataTask.IsCompleted);
        Debug.Log("<color=green>Saved to FireBase</color>");
    }

    //Prosses What should be saved/Loaded
    public DataToStore StoreThisData()
    {
        //Get player info
        Move[] players = FindObjectsOfType<Move>();

        //Create holder object
        DataToStore storedData = new DataToStore(new PlayerInfo[players.Length]);


        //put info in playerinfo class
        for (int i = 0; i < players.Length; i++)
        {
            storedData.players[i] = new PlayerInfo(players[i].transform.name, players[i].transform.position);
        }

        return storedData;
    }

    public void LoadData()
    {
        Debug.Log("Start Loading");

        string jsonString = null;

        //load file from HDD
        if (storeLocal)
            LoadFromLocal("GameSaveFile");


        //load file from server
        if (storeOnline)
        {
            LoadFromWeb("GameSaveFile");
        }

        if (storeFireBase)
        {
            LoadFromFireBase();
        }



    }

    void SetLoadData(string jsonString)
    {
        if (string.IsNullOrEmpty(jsonString))
        {
            Debug.LogError("<color=red>Nothing to load</color>");
        }
        else
        {
            DataToStore storedData = JsonUtility.FromJson<DataToStore>(jsonString);
            SetDataToObject(storedData);
            Debug.Log("Loaded");
        }
    }

    public void LoadFromLocal(string fileName)
    {
        // Open a stream for the supplied file name as a text file
        using (StreamReader stream = File.OpenText(Application.persistentDataPath + "\\" + fileName))
        {
            // Read the entire file and return the result. 
            // This assumes that we've written the file in UTF-8
            SetLoadData(stream.ReadToEnd());
        }
    }


    public void LoadFromWeb(string name)
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
                SetLoadData(body);
            }
        }
    }

    private void LoadFromFireBase()
    {
        var db = FirebaseDatabase.DefaultInstance;
        string userID = FirebaseAuth.DefaultInstance.CurrentUser.UserId;

        db.RootReference.Child("users").Child(userID).GetValueAsync().ContinueWithOnMainThread(task =>
        {
            if (task.Exception != null)
            {
                Debug.LogError(task.Exception);
            }
            DataSnapshot snap = task.Result;
            SetLoadData(snap.GetRawJsonValue());
            Debug.Log(snap.GetRawJsonValue());
            Debug.Log("<color=green>loaded from FireBase</color>");
        });
    }
}
