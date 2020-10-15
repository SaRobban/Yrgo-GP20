using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CameraControl : MonoBehaviour
{


    public Vector3 offsett = Vector3.forward * -5;
    private Camera cam;
    public Transform target;
    public control plControl;

    public float lerpSpeed = 3;

    private float minX = 0;
    private float maxX = 0;
    private float minY = 0;
    private float maxY = 0;

    // Start is called before the first frame update
    void Start()
    {
        cam = GetComponent<Camera>();
        plControl = target.GetComponent<control>();

        GameObject[] allObj = GameObject.FindObjectsOfType(typeof(GameObject)) as GameObject[];
        for (int i = 0; i < allObj.Length; i++)
        {
            if (allObj[i].transform.position.x + cam.orthographicSize < minX)
                minX = allObj[i].transform.position.x + cam.orthographicSize;

            if (allObj[i].transform.position.x - cam.orthographicSize > maxX)
                maxX = allObj[i].transform.position.x - cam.orthographicSize;

            if (allObj[i].transform.position.y + cam.orthographicSize < minY)
                minY = allObj[i].transform.position.y + cam.orthographicSize;

            if (allObj[i].transform.position.y - cam.orthographicSize > maxY)
                maxY = allObj[i].transform.position.y - cam.orthographicSize;
        }
        print(minX + " " + maxX + " " + minY + " " + maxY);
      
    }

    // Update is called once per frame
    void LateUpdate()
    {
       // Vector3 moveStep = Vector3.Lerp(cam.transform.position, target.position + plControl.inputAxis + offsett, lerpSpeed);
        //Debug.DrawRay(transform.position, moveStep.normalized * 5, Color.green);
        transform.position = Vector3.Lerp(cam.transform.position, target.position + plControl.inputAxis * 4 + offsett, plControl.inputAxis.sqrMagnitude * lerpSpeed * Time.deltaTime);

        if (transform.position.x > maxX)
        {
            transform.position = new Vector3(maxX, transform.position.y, transform.position.z);
        }else if(transform.position.x < minX)
        {
            transform.position = new Vector3(minX, transform.position.y, transform.position.z);
        }

        if (transform.position.y > maxY)
        {
            transform.position = new Vector3(transform.position.x, maxY, transform.position.z);
        }
        else if (transform.position.y < minY)
        {
            transform.position = new Vector3(transform.position.x, minY, transform.position.z);
        }

    }
}
