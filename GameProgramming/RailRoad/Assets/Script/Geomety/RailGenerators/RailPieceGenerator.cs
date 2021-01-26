using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class RailPieceGenerator : MonoBehaviour
{
    public GameObject GenerateAPiece(RailStruct railData)
    {
        GameObject meshPiece = new GameObject("RailPiece");
        MeshFilter newMesh = meshPiece.AddComponent<MeshFilter>();
        meshPiece.AddComponent<MeshRenderer>();

        newMesh.mesh = GenerateA3DMesh(newMesh, railData);
        Transform startSnap = CreateStartSnap(railData);
        Transform endSnap = CreateEndSnap(railData);
        GameObject containerTransform = CreateContainerPoint(railData);

        PackContainer(containerTransform, startSnap, endSnap, meshPiece.transform);
        LabelAndPlaceContainer(containerTransform, railData, startSnap, endSnap, meshPiece.transform);



        return containerTransform;
    }

    Mesh GenerateAMesh(MeshFilter newMesh, RailStruct railData)
    {
        int segments = 10;
        Vector3[] verts = new Vector3[segments * 2];
        Vector3[] norm = new Vector3[segments * 2];
        int[] tris = new int[(segments - 1) * 6];


        float angularStep = railData.angle / (segments - 1);
        Vector3 normal = Quaternion.Euler(0, -railData.angle * 0.5f, 0) * Vector3.forward;

        float moveStep = railData.length / (segments - 1);
        float halfX = railData.length * 0.5f;
        float halfY = WorkBench.railWidth * 0.5f;
        float moveX = -halfX;



        int t = 0;
        int segment = 0;
        for (int i = 0; i < verts.Length; i++)
        {
            if (i % 2 == 0)//0,2,4...
            {
                verts[i] = new Vector3(moveX, 0, 0) + normal * (railData.radius + halfY);
            }
            else//1,3,5...
            {
                verts[i] = new Vector3(moveX, 0, 0) + normal * (railData.radius - halfY);

                //Generate tris
                if (i > 2)
                {
                    tris[t] = i - 3;        //0,0
                    tris[t + 1] = i - 1;    //1,2
                    tris[t + 2] = i - 2;    //2,1
                    tris[t + 3] = i - 1;    //3,2
                    tris[t + 4] = i;        //4,3
                    tris[t + 5] = i - 2;    //5,1
                    t += 6;
                }

                //Step forward
                segment++;
                moveX += moveStep;
                normal = Quaternion.Euler(0, -railData.angle * 0.5f + angularStep * segment, 0) * Vector3.forward;
                Debug.DrawLine(verts[i], verts[i - 1], Color.red, 10);
            }
            Debug.DrawRay(verts[i], Vector3.up, Color.blue, 5);
        }

        int x = 0;
        for (int i = 1; i < tris.Length; i++)
        {
            Debug.DrawLine(verts[tris[i]], verts[tris[x]], Color.cyan, 10);
            x = i;
        }
        newMesh.mesh.vertices = verts;
        newMesh.mesh.triangles = tris;

        newMesh.mesh.RecalculateNormals();
        return newMesh.mesh;
    }

    Mesh GenerateA3DMesh(MeshFilter newMesh, RailStruct railData)
    {
        int segments = 8;
        Vector3[] verts = new Vector3[(segments) * 4];
        int[] tris = new int[(segments - 1) * 18];


        float angularStep = railData.angle / (segments - 1);
        Vector3 normal = Quaternion.Euler(0, -railData.angle * 0.5f, 0) * Vector3.forward;

        float moveStep = railData.length / (segments - 1);
        float halfX = railData.length * 0.5f;
        float halfY = WorkBench.railWidth * 0.5f;
        float moveX = -halfX;


        int t = 0;
        int v = 0;
        for (int step = 0; step < segments; step++)
        {
            verts[v] = new Vector3(moveX, -1, 0) + normal * (railData.radius + halfY + 0.1f);
            verts[v + 1] = new Vector3(moveX, 0.1f, 0) + normal * (railData.radius + halfY);
            verts[v + 2] = new Vector3(moveX, 0.1f, 0) + normal * (railData.radius - halfY);
   
            verts[v + 3] = new Vector3(moveX, -1, 0) + normal * (railData.radius - halfY - 0.1f);
            v += 4;

            //Generate tris
            if (step > 0)
            {
                tris[t] = v - 8;
                tris[t + 1] = v - 4;
                tris[t + 2] = v - 7;

                tris[t + 3] = v - 7;
                tris[t + 4] = v - 4;
                tris[t + 5] = v - 3;

                tris[t + 6] = v - 7;
                tris[t + 7] = v - 3;
                tris[t + 8] = v - 6;

                tris[t + 9] = v - 6;
                tris[t + 10] = v - 3;
                tris[t + 11] = v - 2;

                tris[t + 12] = v - 6;
                tris[t + 13] = v - 2;
                tris[t + 14] = v - 5;

                tris[t + 15] = v - 5;
                tris[t + 16] = v - 2;
                tris[t + 17] = v - 1;
                t += 18;
            }

            //Step forward
            moveX += moveStep;
            normal = Quaternion.Euler(0, -railData.angle * 0.5f + angularStep * (step + 1), 0) * Vector3.forward;
        }


        int x = 0;
        for (int i = 1; i < tris.Length; i++)
        {
            Debug.DrawLine(verts[tris[i]], verts[tris[x]], Color.cyan, 10);
            x = i;
        }
        newMesh.mesh.vertices = verts;
        newMesh.mesh.triangles = tris;

        newMesh.mesh.RecalculateNormals();
        return newMesh.mesh;
    }

    Transform CreateStartSnap(RailStruct railData)
    {
        Vector3 normal = Quaternion.Euler(0, -railData.angle * 0.5f, 0) * Vector3.forward;
        GameObject startSnap = new GameObject("StartSnap");
        startSnap.transform.position = new Vector3(-railData.length * 0.5f, 0, 0) + normal * (railData.radius);
        startSnap.transform.rotation = Quaternion.Euler(0, -railData.angle * 0.5f, 0);
        return startSnap.transform;
    }

    Transform CreateEndSnap(RailStruct railData)
    {
        Vector3 normal = Quaternion.Euler(0, railData.angle * 0.5f, 0) * Vector3.forward;
        GameObject endSnap = new GameObject("EndSnap");
        endSnap.transform.position = new Vector3(railData.length * 0.5f, 0, 0) + normal * (railData.radius);
        endSnap.transform.rotation = Quaternion.Euler(0, railData.angle * 0.5f, 0);
        return endSnap.transform;
    }

    GameObject CreateContainerPoint(RailStruct railData)
    {
        GameObject midPoint = new GameObject("Container");
        midPoint.transform.position = Vector3.forward * (railData.radius);
        return midPoint;
    }

    void PackContainer(GameObject container, Transform meshPiece, Transform startSnap, Transform endSnap)
    {
        meshPiece.parent = container.transform;
        startSnap.parent = container.transform;
        endSnap.parent = container.transform;
    }
    void LabelAndPlaceContainer(GameObject container, RailStruct railData, Transform startSnap, Transform endSnap, Transform meshPiece)
    {
        if (railData.length > 0)
            container.transform.name = "Strait " + (railData.length * 100) + "mm" + "            MyPiece";
        else
            container.transform.name = "Radius " + (railData.radius * 100) + "mm, " + railData.angle + "º" + "            MyPiece";

        RailInfo ri = container.AddComponent<RailInfo>();
        ri.RailInfoInit(railData, startSnap, endSnap, meshPiece);

        container.transform.position = railData.position;
        container.transform.rotation = railData.rotation;
    }
}
