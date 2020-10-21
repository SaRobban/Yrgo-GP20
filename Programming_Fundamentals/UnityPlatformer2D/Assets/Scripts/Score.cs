using UnityEngine;

public class Score : MonoBehaviour
{
    public int score = 0;
    private void OnTriggerEnter2D(Collider2D collision)
    {
        score++;
        Debug.Log("score: " + score);
    }
}
