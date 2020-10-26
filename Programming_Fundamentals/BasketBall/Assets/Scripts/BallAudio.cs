using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BallAudio : MonoBehaviour
{
    public AudioClip[] ballbounce;
    public AudioClip cage;
    public AudioClip board;

    AudioSource audioSource;

    private void OnCollisionEnter2D(Collision2D collision)
    {
        if (collision.gameObject.tag == "Board")
        {
            audioSource.PlayOneShot(board, 1);
        }
        else if (collision.gameObject.tag == "Cage")
        {
            audioSource.PlayOneShot(cage, 3);
            audioSource.PlayOneShot(board, 0.5f);
        }
        else
        {
            int randomNum = Random.Range(0, ballbounce.Length);
            audioSource.PlayOneShot(ballbounce[randomNum], 1);
        }
    }
    // Start is called before the first frame update
    void Start()
    {
        audioSource = GetComponent<AudioSource>();
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}
