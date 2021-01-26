/*
using UnityEngine;
using System.IO;
using System.Runtime.Serialization.Formatters.Binary;

//Made by tutorial //https://www.raywenderlich.com/418-how-to-save-and-load-a-game-in-unity

[SerializeField]
public struct PlayerData
{
    public string Name;
    public Vector3 Position;
    public PlayerData(string Name, Vector3 Position)
    {
        this.Name = Name;
        this.Position = Position;
    }
}

public class SaveLoadData : MonoBehaviour
{
    public void SaveData()
    {
        // Create a save class format  //NOTE!!! You also want to insert your real values here!
        PlayerData save = new PlayerData("Hej", Vector3.zero);

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