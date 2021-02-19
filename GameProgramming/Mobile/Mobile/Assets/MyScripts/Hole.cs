using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Hole : MonoBehaviour
{
    public MiniGolfBall ball;
    private void OnTriggerEnter2D(Collider2D collision)
    {
        print("WIN!");
    }
    // Start is called before the first frame update
    void Start()
    {
        ball = (MiniGolfBall)FindObjectOfType(typeof(MiniGolfBall));
    }

    // Update is called once per frame
    void Update()
    {
        Vector2 dir = transform.position - ball.transform.position;
        float dist = dir.sqrMagnitude * 4;

        if(dist < 1)
        {
            ball.GetComponent<Rigidbody2D>().AddForce(dir * 20 * (1-dist));
           // ball.GetComponent<Rigidbody2D>().velocity *= 0.9f *(1- dist);
        }
    }
}
