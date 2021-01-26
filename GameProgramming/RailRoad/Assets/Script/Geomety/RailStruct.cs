using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public struct RailStruct
{
    public Vector3 position;
    public Quaternion rotation;

    public float length;
    public float radius;
    public float angle;
    public float slopeAngle;
    public bool enable;


    public RailStruct(Vector3 position, Quaternion rotation, float length,  float radius, float angle, float slopeAngle, bool enable)
    {
        this.position = position;
        this.rotation = rotation;
        this.length = length;
        this.radius = radius;
        this.angle = angle;
        this.slopeAngle = slopeAngle;
        this.enable = enable;
    }
}

