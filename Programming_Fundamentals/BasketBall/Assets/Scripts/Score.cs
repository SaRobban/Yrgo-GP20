using UnityEngine;


public class Score : MonoBehaviour
{
    public BallOwner ballScript;
    public int score = 0;
    
    private void OnTriggerEnter2D(Collider2D collision)
    {
        if (collision.attachedRigidbody.velocity.y < 0)
            ballScript.AddScore();

        print(score);
    }
}
