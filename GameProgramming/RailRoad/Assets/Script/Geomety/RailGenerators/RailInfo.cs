using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class RailInfo : MonoBehaviour
{
    public RailStruct railStruct;
    public Transform startSnap;
    public Transform endSnap;
    public Transform rCenter;

    public void RailInfoInit(RailStruct railStruct, Transform startSnap, Transform endSnap, Transform rCenter)
    {
        this.railStruct = railStruct;
        this.startSnap = startSnap;
        this.endSnap = endSnap;
        this.rCenter = rCenter;
    }
}
