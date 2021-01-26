using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class RailStamp : MonoBehaviour
{
    public GetSettingsFromUI inValues;
    public GameObject stamp;
    public Material material;

    public RailInfo stampRailInfo;

    public LayerMask railMask;
    public LayerMask workBenchMask;

    // Start is called before the first frame update
    void Start()
    {
        SetStamp(inValues.settings);
    }

    public void SwapStamp(RailStruct railStruct)
    {
        if (stamp)
            Destroy(stamp.gameObject);

        StartCoroutine(NewStamp(railStruct));
    }

    private IEnumerator NewStamp(RailStruct railStruct)
    {
        //wait one frame to comleate destruction
        yield return null;
        SetStamp(railStruct);
    }

    private void SetStamp(RailStruct railStruct)
    {
        stamp = WorkBench.railPieceGenerator.GenerateAPiece(railStruct);
        stampRailInfo = stamp.GetComponent<RailInfo>();
        stamp.GetComponentInChildren<MeshRenderer>().material = material;
    }

    // Update is called once per frame
    void Update()
    {
        Ray ray = Camera.main.ScreenPointToRay(Input.mousePosition);
        if (stamp)
        {
            RaycastHit hit;
            if (Physics.Raycast(ray, out hit, Mathf.Infinity, workBenchMask))
            {
                stamp.transform.position = hit.point;

                Transform snap = GetClostestSnap(hit.point);
                if (snap != null)
                {
                    SnapTo(snap);
                }
            }

            if (Input.GetButtonDown("Fire1"))
            {
                GameObject newRail = (Instantiate(stamp.gameObject, stamp.transform.position, stamp.transform.rotation));
                newRail.GetComponent<RailInfo>().rCenter.gameObject.AddComponent<MeshCollider>().convex = true;
                newRail.AddComponent<Rigidbody>().isKinematic = true;
                newRail.layer = 9;// railMask.value;
                WorkBench.railManager.AddRail(newRail);
            }
        }

        if (Input.GetButtonDown("Fire2"))
        {
            RaycastHit hitRail;
            if (Physics.Raycast(ray, out hitRail))
            {
                if (hitRail.collider.GetComponentInParent<RailInfo>())
                {
                    print("Hit : " + hitRail.collider.name);
                    WorkBench.railManager.RemoveRail(hitRail.collider.transform.parent.gameObject);
                    Destroy(hitRail.collider.transform.parent.gameObject);
                }
            }
        }
    }

    public Transform GetClostestSnap(Vector3 pos)
    {
        if (WorkBench.railManager.railPices.Count > 0)
        {
            RailInfo rI;

            Transform closestStart = null;
            Transform closestEnd = null;

            float closetDistToStart = WorkBench.snapRange;
            float closetDistToEnd = WorkBench.snapRange;

            foreach (GameObject rail in WorkBench.railManager.railPices)
            {
                rI = rail.GetComponent<RailInfo>();

                //Transform thisRailStart = rail.GetComponent<RailPiece>().start;
                float distToThisStart = (pos - rI.startSnap.position).sqrMagnitude;

                if (distToThisStart < closetDistToStart)
                {
                    closestStart = rI.startSnap;
                    closetDistToStart = distToThisStart;
                }

                float distToThisEnd = (pos - rI.endSnap.position).sqrMagnitude;

                if (distToThisEnd < closetDistToEnd)
                {
                    closestEnd = rI.endSnap;
                    closetDistToEnd = distToThisEnd;
                }
            }

            if (closetDistToEnd < closetDistToStart)
            {
                return closestEnd;
            }
            else if (closetDistToStart < closetDistToEnd)
            {
                return closestStart;
            }
            else
            {
                return null;
            }
        }
        return null;
    }

    public void SnapTo(Transform snap)
    {
        Vector3 dir = snap.position - stamp.transform.position;
        int mulDir = 1;
        int curveDir = 0;

        if (Vector3.Dot(dir, snap.right) > 0)
        {
            mulDir = -1;
        }

        if (Vector3.Dot(dir, snap.forward) > 0)
        {
            curveDir = 180;
            mulDir *= -1;
        }

        stamp.transform.rotation = snap.rotation * Quaternion.Euler(0, inValues.settings.angle * 0.5f * mulDir + curveDir, 0);

        Vector3 offDir = stampRailInfo.startSnap.position - stamp.transform.position;
        if (mulDir < 0)
        {
            offDir = stampRailInfo.endSnap.position - stamp.transform.position;
        }
        stamp.transform.position = snap.position - offDir;
    }
}
