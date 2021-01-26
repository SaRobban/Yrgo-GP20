using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using TMPro;
public class GetSettingsFromUI : MonoBehaviour
{
    public TMP_InputField lengthInputField;
    public TMP_InputField radiusInputField;
    public TMP_InputField angleInputField;
    public TMP_InputField slopeInputField;

    public RailStruct settings;

    public int radius;

    private bool lockOut = false;

    public RailStamp rs;
    // Start is called before the first frame update
    void Start()
    {
        settings = new RailStruct(Vector3.zero, Quaternion.identity, 0, 1.95f, 30, 0, true);
        // Event triggered when Input Field text is changed.
        lengthInputField.onEndEdit.AddListener(ChangeLength);
        radiusInputField.onEndEdit.AddListener(ChangeRadius);
        angleInputField.onEndEdit.AddListener(ChangeAngle);
        slopeInputField.onEndEdit.AddListener(ChangeSlope);
        PrintValuesToConsole();
    }
    public void ChangeLength(string text)
    {
        int l;
        if (int.TryParse(text, out l))
        {
            settings.length = Mathf.Abs((float)l * 0.01f);

            settings.radius = 0;
            settings.angle = 0;

            if (!lockOut)
            {
                PrintValuesToConsole();
            }
        }
        else
        {
            lengthInputField.text = "E";
            print("Invalid input : " + lengthInputField);
        }
    }

    public void ChangeRadius(string text)
    {
        int r;
        if (int.TryParse(text, out r))
        {
            settings.radius = Mathf.Abs((float)r * 0.01f);

            settings.length = 0;
            if (settings.angle < 13)
            {
                settings.angle = 13;
            }

            if (!lockOut)
            {
                PrintValuesToConsole();
            }
        }
        else
        {
            radiusInputField.text = "E";
            print("Invalid input : " + radiusInputField);
        }
    }

    public void ChangeAngle(string text)
    {
        int a;
        if (int.TryParse(text, out a))
        {
            settings.angle = Mathf.Abs((float)a);

            settings.length = 0;
            if (settings.radius < 0.45f)
            {
                settings.radius = 0.45f;
            }

            if (!lockOut)
            {
                PrintValuesToConsole();
            }
        }
        else
        {
            angleInputField.text = "E";
            print("Invalid input : " + angleInputField);
        }
    }

    public void ChangeSlope(string text)
    {
        int s;
        if (int.TryParse(text, out s))
        {
            settings.slopeAngle = Mathf.Abs((float)s);

            if (!lockOut)
            {
                PrintValuesToConsole();
            }
        }
        else
        {
            slopeInputField.text = "E";
            print("Invalid input : " + slopeInputField);
        }
    }

    void PrintValuesToConsole()
    {
        lengthInputField.interactable = true;
        radiusInputField.interactable = true;
        angleInputField.interactable = true;
        slopeInputField.interactable = true;

        lengthInputField.text = (settings.length * 100).ToString();
        radiusInputField.text = (settings.radius * 100).ToString();
        angleInputField.text = (settings.angle).ToString();
        slopeInputField.text = (settings.slopeAngle).ToString();
        print(" " + settings.length + " " + settings.radius + " " + settings.angle + " " + settings.slopeAngle + " " + settings.enable);

        rs.SwapStamp(settings);
        StartCoroutine(LockOut());
    }

    IEnumerator LockOut()
    {
        lockOut = true;
        yield return null;
        lockOut = false;
    }
}


