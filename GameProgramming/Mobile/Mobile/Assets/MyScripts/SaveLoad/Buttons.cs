using UnityEngine;
using UnityEngine.UI;
using System.Collections;

public class Buttons : MonoBehaviour
{
    public DataFromToFile fileM;
    public GameObject menu;
    private void Start()
    {
        if (!fileM)
        {
            fileM = FindObjectOfType<DataFromToFile>();
        }
    }
    public void OnClickSave()
    {
        Debug.Log("You have clicked the save button!");
        fileM.SaveData();
    }

    public void OnClickLoad()
    {
        Debug.Log("You have clicked the Load button!");
        fileM.LoadData();
    }

    public void OnClickedClose()
    {
        
        menu.SetActive(false);
    }
}
