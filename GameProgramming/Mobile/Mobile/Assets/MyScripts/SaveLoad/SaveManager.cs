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

[RequireComponent (typeof(DataFromToFile))]
public class SaveManager : MonoBehaviour
{
    //Start Here
    public DataFromToFile dataFromToFile;
    public string saveFileName = "GameSaveFile";

    public bool storeLocal = false;
    public bool storeOnline = false;
    public bool storeFireBase = false;

    private void Awake()
    {
        dataFromToFile = GetComponent<DataFromToFile>();
    }

    public void SaveDataToggle(DataToStore dataIn)
    {
        Debug.Log("StartSaving");
        //turn class into json 
        string jsonString = JsonUtility.ToJson(dataIn);

        //save that
        if (storeLocal)
            SaveToFile(saveFileName, jsonString);

        if (storeOnline)
            SaveOnWeb(saveFileName, jsonString);

        if (storeFireBase)
            StartCoroutine(SaveToFireBase(saveFileName, jsonString));

        if (!storeLocal && !storeOnline && !storeFireBase)
            Debug.Log("Error : NO SELECTED TARGET FOR SAVEFILE");
    }



    //SAVE FILE////////////////////////////////////////////////////////////////////////////////////////
    private void SaveToFile(string fileName, string jsonString)
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
    private void SaveOnWeb(string fileName, string saveData)
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

    private IEnumerator SaveToFireBase(string userID, string jsonString)
    {
        Debug.Log("Start save to FireBase");

        FirebaseAuth auth = FirebaseAuth.DefaultInstance;
        FirebaseUser user = auth.CurrentUser;

        FirebaseDatabase db = FirebaseDatabase.DefaultInstance;
        var dataTask = db.RootReference.Child("users").Child(FirebaseAuth.DefaultInstance.CurrentUser.UserId).SetRawJsonValueAsync(jsonString);
        yield return new WaitUntil(() => dataTask.IsCompleted);
        Debug.Log("<color=green>Saved to FireBase</color>");
    }


    //LOAD FILE////////////////////////////////////////////////////////////////////////////////////////
    public void LoadDataToggle()
    {
        Debug.Log("Start Loading");

        //load file from HDD
        if (storeLocal)
            LoadFromLocal(saveFileName);

        //load file from server
        if (storeOnline)
        {
            LoadFromWeb(saveFileName);
        }

        if (storeFireBase)
        {
            LoadFromFireBase();
        }
    }

    private void SetLoadData(string jsonString)
    {
        if (string.IsNullOrEmpty(jsonString))
        {
            Debug.LogError("<color=red>Nothing to load</color>");
        }
        else
        {
            DataToStore storedData = JsonUtility.FromJson<DataToStore>(jsonString);
            dataFromToFile.SetDataToObject(storedData);
            Debug.Log("Loaded");
        }
    }

    private void LoadFromLocal(string fileName)
    {
        // Open a stream for the supplied file name as a text file
        using (StreamReader stream = File.OpenText(Application.persistentDataPath + "\\" + fileName))
        {
            // Read the entire file and return the result. 
            // This assumes that we've written the file in UTF-8
            SetLoadData(stream.ReadToEnd());
        }
    }

    private void LoadFromWeb(string name)
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
