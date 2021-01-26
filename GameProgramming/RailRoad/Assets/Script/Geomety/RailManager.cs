using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class RailManager : MonoBehaviour
{
    public List<GameObject> railPices;
    public List<GameObject> railsnaps;


    //public List<SnapPoint> snaps = new List<SnapPoint>();

    //public SnapPoint[] snapPoints = new SnapPoint[0];

    public void AddRail(GameObject railP)
    {
        railPices.Add(railP);
        print("number of railPices" + railPices.Count);
       // AddSnaps(c.start, c.end);
    }
    public void RemoveRail(GameObject railP)
    {
        railPices.Remove(railP);
        print("number of railPices" + railPices.Count);
    }


    /*
    private void AddSnaps(SnapPoint start, SnapPoint end)
    {
        snaps.Add(start);
        snaps.Add(end);
        //snapPoints = snaps.ToArray();
    }
    */

    // Start is called before the first frame update
    void Start()
    {
        WorkBench.railManager = this;
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}
