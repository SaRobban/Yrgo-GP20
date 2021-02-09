//This script collects data from scene
//Converts it to a jason sting 
//And send the string to saveManager
//Aswell as get string on load

using UnityEngine;
using System;

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


[RequireComponent(typeof(SaveManager))]

public class DataFromToFile : MonoBehaviour
{
    public SaveManager saveManager;
    private void Awake()
    {
        GetComponent<SaveManager>();
    }

    public void SaveData()
    {
        DataToStore storedData = StoreThisData();
        saveManager.SaveDataToggle(storedData);
    }

    public void LoadData()
    {
        saveManager.LoadDataToggle();
    }

    //Prosses What should be saved
    public DataToStore StoreThisData()
    {
        //Get player info
        Move[] players = FindObjectsOfType<Move>();

        //Create holder object
        DataToStore storedData = new DataToStore(new PlayerInfo[players.Length]);

        //Put info in playerinfo class
        for (int i = 0; i < players.Length; i++)
        {
            storedData.players[i] = new PlayerInfo(players[i].transform.name, players[i].transform.position);
        }
        return storedData;
    }

    //Set loaded data to scene
    public void SetDataToObject(DataToStore storedData)
    {
        Move[] players = FindObjectsOfType<Move>();

        for (int i = 0; i < players.Length; i++)
        {
            players[i].transform.name = storedData.players[i].Name;
            players[i].transform.position = storedData.players[i].Position;
        }
    }
}
