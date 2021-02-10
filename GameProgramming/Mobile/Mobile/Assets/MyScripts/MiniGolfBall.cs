using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MiniGolfBall : MonoBehaviour
{
    private Vector3 orgin;
    private Vector2 force;
    public float forceMul = 1;
    public float speedLossPerSec = 1;

    private Rigidbody2D rb;
    // Start is called before the first frame update
    void Start()
    {
        rb = GetComponent<Rigidbody2D>();
    }

    private void OnCollisionEnter2D(Collision2D collision)
    {
        rb.velocity *= 0.9f;
    }

    // Update is called once per frame
    void Update()
    {
        if (Input.GetButtonDown("Fire1"))
        {
            orgin = Camera.main.ScreenPointToRay(Input.mousePosition).origin;
        }

        if (Input.GetButton("Fire1"))
        {
            force = orgin - Camera.main.ScreenPointToRay(Input.mousePosition).origin;
            Debug.DrawRay(orgin, force, Color.red);
            Debug.DrawRay(transform.position, force * forceMul, Color.green);
        }

        if (Input.GetButtonUp("Fire1"))
        {
            Debug.DrawRay(transform.position, force * forceMul, Color.green, 1);
            rb.AddForce(force * forceMul, ForceMode2D.Impulse);
        }

       // rb.velocity *= 1 - speedLossPerSec * Time.deltaTime;
    }
}
