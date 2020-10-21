using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class cameraMovement : MonoBehaviour
{
    public Transform targetOne;
    public Transform targetTwo;
    Vector3 newCamPos;

    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        newCamPos = (targetOne.position + targetTwo.position) * 0.5f;
        newCamPos += Vector3.forward *-5;
        /*
        if(newCamPos.y < 0)
        {
           newCamPos.y = 0;
        }
        */
        newCamPos.y = 0;
        transform.position = newCamPos;
    }
}
