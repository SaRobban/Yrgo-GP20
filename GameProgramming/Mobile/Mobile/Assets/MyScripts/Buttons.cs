using UnityEngine;
using UnityEngine.UI;

public class Buttons : MonoBehaviour
{
    public DataFromToFile fileM;

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
}
