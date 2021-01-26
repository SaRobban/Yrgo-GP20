using System.Collections;
using System.Collections.Generic;
using UnityEditor;
using UnityEngine;

public class control : MonoBehaviour
{
    public float speed;
    private Vector3 inputAxis;
    private Vector3 velocityAxis;
    private Rigidbody2D rb2dOne;
    private Rigidbody2D rb2dTwo;
    private Rigidbody2D rb2dTtree;

    public bool fire;

    // Start is called before the first frame update
    void Start()
    {
        Rigidbody2D[] allRB2D = Rigidbody2D.FindObjectsOfType(typeof(Rigidbody2D)) as Rigidbody2D[];
        for (int i = 0; i < allRB2D.Length; i++)
        {
            if (rb2dOne == null)
                rb2dOne = allRB2D[i];
            else if (rb2dTwo == null)
                rb2dTwo = allRB2D[i];
            else if (rb2dTtree == null)
                rb2dTtree = allRB2D[i];
        }


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

        velocityAxis = inputAxis * speed * Time.deltaTime;

        rb2dOne.MovePosition(rb2dOne.transform.position + velocityAxis);
        rb2dTwo.MovePosition(rb2dTwo.transform.position - velocityAxis);

        velocityAxis *= 0.5f;
        rb2dTtree.MovePosition(rb2dTtree.transform.position + velocityAxis);

        if (fire)
        {
            Debug.DrawRay(transform.position, velocityAxis, Color.green, 0.5f);
        }

        fire = false;
    }

}
