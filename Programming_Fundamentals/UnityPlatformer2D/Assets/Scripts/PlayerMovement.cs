using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using UnityEngine;

public class PlayerMovement : MonoBehaviour
{
    public Vector2 inAxis = Vector2.zero;
    public Vector2 moveDir = Vector2.zero;
    private bool jump;
    [Header("Player Speed")]
    public float moveSpeed = 2f;
    public float airControl = 0.1f;
    public float jumpStrength = 10;

    [Header("Gravity")]
    private float gravity = 20;
    public float lightGravity = 10;
    public float heavyGravity = 20;

    public Boolean isGrounded;

    public LayerMask groundLayer;

    private RaycastHit2D[] hits;
    private Rigidbody2D rb2d;

    public AnimationCurve f;


    public void setInput(Vector2 axis)
    {
        inAxis = axis;
    }
    // Start is called before the first frame update
    void Start()
    {
        hits = new RaycastHit2D[4];
        rb2d = GetComponent<Rigidbody2D>();
        rb2d.constraints = RigidbodyConstraints2D.FreezeRotation;
        rb2d.gravityScale = 0;
    }


    private void FixedUpdate()
    {
        moveDir = rb2d.velocity;
        isGrounded = IsGrounded();

        if (isGrounded)
        {
            moveDir.x = inAxis.x * moveSpeed;
            if (inAxis.y > 0)
            {
                moveDir.y = jumpStrength;
            }
        }
        else
        {
            moveDir.x = inAxis.x * moveSpeed;
        }

        if(inAxis.y > 0)
        {
            moveDir.y -= lightGravity * Time.fixedDeltaTime;
        }
        else
        {
            moveDir.y -= heavyGravity * Time.fixedDeltaTime;
        }

        rb2d.velocity = moveDir;
        jump = false;
    }


    private bool IsGrounded()
    {
        if (moveDir.y <= 0)
        {
            int hitLength = Physics2D.CircleCastNonAlloc(transform.position, 0.5f, Vector2.down, hits, 1, groundLayer);
            if (hitLength > 0)
            {
                return true;
            }
        }
        return false;
        /*
        for (int i = 0; i < hitLength; i++)
        {
            //Få hit info här
        }
        */
    }
}
