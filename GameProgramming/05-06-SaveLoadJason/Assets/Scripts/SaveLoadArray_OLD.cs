/*
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

using System.IO;
using System.Runtime.Serialization.Formatters.Binary;

public class SaveLoadArray : MonoBehaviour
{
    public PlayerData[] FindAllSavebleObjects()
    {
        //Find all objects we want to save
        GameObject[] allObjectsIWantToSave = FindObjectsOfType<GameObject>();

        //Creata a list of savedata
        PlayerData[] saveList = new PlayerData[allObjectsIWantToSave.Length];
        for (int i = 0; i < saveList.Length; i++)
        {
            saveList[i] = new PlayerData(allObjectsIWantToSave[i].transform.name, allObjectsIWantToSave[i].transform.position);
        }
        return saveList;
    }

    public void SaveData()
    {
        // Create a save class format
        PlayerData[] save = FindAllSavebleObjects();

        // Create a BinaryFormatter and a FileStream
        BinaryFormatter bf = new BinaryFormatter();
        FileStream file = File.Create(Application.persistentDataPath + "/gamesave.save");
        bf.Serialize(file, save);
        file.Close();

        Debug.Log("Game Saved");
    }

    public void LoadGame()
    {
        //Check if File exist
        if (File.Exists(Application.persistentDataPath + "/gamesave.save"))
        {
            //Create a BinaryFormatter //"A stream of bytes to read"
            BinaryFormatter bf = new BinaryFormatter();
            FileStream file = File.Open(Application.persistentDataPath + "/gamesave.save", FileMode.Open);
            PlayerData save = (PlayerData)bf.Deserialize(file);
            file.Close();

            //Set Values to object
            transform.name = save.Name;
            transform.position = save.Position;

            Debug.Log("Game Loaded");
        }
        else
        {
            Debug.Log("No game saved!");
        }
    }
}
*/