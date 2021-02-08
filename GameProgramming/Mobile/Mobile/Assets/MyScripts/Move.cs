using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Move : MonoBehaviour
{
    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        transform.position += Vector3.up * Input.GetAxis("Vertical") * Time.deltaTime;
        transform.position += Vector3.right * Input.GetAxis("Horizontal") * Time.deltaTime;
    }
}
