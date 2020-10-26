using UnityEngine;
using UnityEngine.UI;

public class BallOwner : MonoBehaviour
{
    public Color32 player1Color;
    public Color32 player2Color;

    public float loseMulXspeedOnBoard = 0.25f;
    public int owner = 0;
    private Rigidbody2D rb2d;


    private int scorePlOne = 0;
    private int scorePlTwo = 0;

    public Text scoreUI;

    public void AddScore()
    {
        if(owner == 1)
        {
            scorePlOne++;
        }
        if(owner == 2)
        {
            scorePlTwo++;
        }
        Debug.Log("PL1 : " + scorePlOne + "    PL2 : " + scorePlTwo);

        scoreUI.text = "PL1 : " + scorePlOne + "    PL2 : " + scorePlTwo;
    }
    private void OnCollisionEnter2D(Collision2D collision)
    {
        if(collision.transform.name == "Player1")
        {
            this.GetComponent<Renderer>().material.SetColor("_Color", player1Color);
            owner = 1;
        }else if(collision.transform.name == "Player2")
        {
            this.GetComponent<Renderer>().material.SetColor("_Color", player2Color);
            owner = 2;
        }

        Vector2 norm = Vector2.zero;

        for (int i = 0; i < collision.contactCount; i++)
        {
            norm += collision.GetContact(i).normal;
        }

        if (collision.transform.tag == "Board")
        {
            Vector2 velo = rb2d.velocity;
            velo.x *= loseMulXspeedOnBoard;
            rb2d.velocity = velo;
        }
    }
    // Start is called before the first frame update
    void Start()
    {
        rb2d = GetComponent<Rigidbody2D>();
    }
}
