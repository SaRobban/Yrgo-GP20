using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TwoPlayerInputController : MonoBehaviour
{
    public Rigidbody2D playerOne;
    public Rigidbody2D playerTwo;

    private Vector2 moveAxisPlOne;
    private Vector2 moveAxisPlTwo;

    private PlayerMovement playerMoveOne;
    private PlayerMovement playerMoveTwo;

    // Start is called before the first frame update
    void Start()
    {
        playerMoveOne = playerOne.GetComponent<PlayerMovement>();
        playerMoveTwo = playerTwo.GetComponent<PlayerMovement>();
    }

    // Update is called once per frame
    void Update()
    {
        moveAxisPlOne.x = Input.GetAxis("Horizontal");
        if (Input.GetButton("Jump"))
        {
            moveAxisPlOne.y = 1;
        }
        else
        {
            moveAxisPlOne.y = 0;
        }

        moveAxisPlTwo.x = Input.GetAxis("HorizontalTwo");
        if (Input.GetButton("JumpTwo"))
        {
            moveAxisPlTwo.y = 1;
        }
        else
        {
            moveAxisPlTwo.y = 0;
        }

        playerMoveOne.setInput(moveAxisPlOne);
        playerMoveTwo.setInput(moveAxisPlTwo);
    }
}
