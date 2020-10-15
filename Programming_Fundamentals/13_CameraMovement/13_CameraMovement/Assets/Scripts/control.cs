using System.Collections;
using System.Collections.Generic;
using UnityEditor;
using UnityEngine;

public class control : MonoBehaviour
{
    public float speed = 2;
    public Vector3 inputAxis;
    private Vector3 velocityAxis;
    private Rigidbody2D rb2d;

    public bool fire;

    // Start is called before the first frame update
    void Start()
    {
        rb2d = GetComponent<Rigidbody2D>();

        inputAxis = Vector3.zero;
        velocityAxis = Vector3.zero;
    }

    // Update is called once per frame
    void Update()
    {
        if (Input.GetButtonDown("Fire1"))
        {
            fire = true;
        }
    }

    void FixedUpdate()
    {
        inputAxis.x = Input.GetAxis("Horizontal");
        inputAxis.y = Input.GetAxis("Vertical");

        if(inputAxis.sqrMagnitude > 1)
        {
            inputAxis = inputAxis.normalized;
        }

        velocityAxis = inputAxis * speed;
        Debug.DrawRay(transform.position, velocityAxis, Color.red);
        
        rb2d.MovePosition(rb2d.transform.position + velocityAxis * Time.deltaTime);

        if (fire)
        {
            Debug.DrawRay(transform.position, velocityAxis, Color.green, 0.5f);
        }

        fire = false;
    }

}
