using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class RailPieceOLD : MonoBehaviour
{
    public float angle = 30f;
    public float radius = 1.95f;
    public bool radiusSnap = true;
    public int segments = 30;
    public Vector3 radiusCenter;

    private Vector3[] pointNodes;

    public Transform start;
    public Transform end;

    // Start is called before the first frame update
    void Start()
    {
        SetName();
        GenerateMesh();
    }

    void SetName()
    {
        gameObject.name = (angle + "deg curve, radius " + radius);
    }

    void GenerateMesh()
    {
        pointNodes = new Vector3[segments];
        float angularStep = angle / segments;
        Vector3 normal = Vector3.forward;

        for (int i = 0; i < segments; i++)
        {
            normal = Quaternion.Euler(0, angularStep * i, 0) * Vector3.forward;
            pointNodes[i] = normal * radius;
        }

        Vector3 startP = pointNodes[0];
        Vector3 endP = pointNodes[pointNodes.Length - 1];
        Vector3 midP = (startP + endP) * 0.5f;

        for (int i = 0; i < segments; i++)
        {
            pointNodes[i] -= midP;
        }

        start = new GameObject().transform;
        start.position = transform.TransformPoint(pointNodes[0]);
        start.rotation = transform.rotation;
        start.localScale = Vector3.one;
        start.parent = transform;

        end = new GameObject().transform;
        end.position = transform.TransformPoint(pointNodes[pointNodes.Length - 1]);
        end.rotation = Quaternion.Euler(0, angle, 0) * transform.rotation;
        end.localScale = -Vector3.one;
        end.parent = transform;
    }

    public void Edit()
    {
        SetName();
        GenerateMesh();
    }

    // Update is called once per frame
    void Update()
    {
        //Draw
        int x = 0;
        for (int y = 1; y < pointNodes.Length; y++)
        {
            Debug.DrawLine(transform.TransformPoint(pointNodes[x]), transform.TransformPoint(pointNodes[y]));
            x = y;
        }
    }
}
