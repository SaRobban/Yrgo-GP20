using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class WorkBench : MonoBehaviour
{
    //Sigelton
    private static WorkBench _instance;
    public static WorkBench Instance { get { return _instance; } }

    //variables
    public static RailManager railManager;
    public static Vector3 mousePos;
    public static float snapRange = 8;

    public static float railWidth = 0.15f;

    public static RailPieceGenerator railPieceGenerator;


    private void Awake()
    {
        if (_instance != null && _instance != this)
        {
            Destroy(this.gameObject);
        }
        else
        {
            _instance = this;
        }

        railPieceGenerator = gameObject.AddComponent<RailPieceGenerator>();
    }


    // Start is called before the first frame update
    void Start()
    {

    }

    // Update is called once per frame
    void Update()
    {

        Ray ray = Camera.main.ScreenPointToRay(Input.mousePosition);
        RaycastHit hit;
        if (Physics.Raycast(ray, out hit))
        {
            mousePos = hit.point;
        }

    }
}
