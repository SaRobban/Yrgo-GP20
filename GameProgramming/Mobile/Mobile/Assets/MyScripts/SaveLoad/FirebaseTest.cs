using System.Collections;
using UnityEngine;
using Firebase;
using Firebase.Auth;
using Firebase.Database;
using Firebase.Extensions;
using System;

using TMPro;


public class FirebaseTest : MonoBehaviour
{
	public string storedEmail;
	public string storedPassword;

	public TMP_InputField emailIn;
	public TMP_InputField paswIn;
    private void Start()
    {
        //StartSignIn("")
    }
    public void StartLogOn(string email, string password, bool registerNewUser)
	{
		
		FirebaseApp.CheckAndFixDependenciesAsync().ContinueWithOnMainThread(task =>
		{
			if (task.Exception != null)
			{
				Debug.LogError(task.Exception);
			}

			//Run this the first time, then run the "SignIn" coroutine instead.
			if(registerNewUser)
				StartCoroutine(RegUser(email, password));
			else
				StartCoroutine(SignIn(email, password));
		});
		
	}

	public void OnClickRegesterNewUser()
	{
		StartLogOn(storedEmail, storedPassword, true);
	}

	public void OnClickSignIn()
    {
		StartLogOn(storedEmail, storedPassword, false);
    }

	public void ChangeEmail()
    {
		print(emailIn.text);
		storedEmail = emailIn.text;
	}
	public void ChangePassword()
	{
		print(paswIn.text);
		storedPassword = paswIn.text;
		//paswIn.text = "";
	}

	private IEnumerator RegUser(string email, string password)
	{

		Debug.Log("Starting Registration");
		var auth = FirebaseAuth.DefaultInstance;
		var regTask = auth.CreateUserWithEmailAndPasswordAsync(email, password);
		yield return new WaitUntil(() => regTask.IsCompleted);

		if (regTask.Exception != null)
			Debug.LogWarning(regTask.Exception);
		else
			Debug.Log("Registration Complete");

		//StartCoroutine(SignIn(email, password));
	}


	private IEnumerator SignIn(string email, string password)
	{
		Debug.Log("Atempting to log in");
		var auth = FirebaseAuth.DefaultInstance;
		var loginTask = auth.SignInWithEmailAndPasswordAsync(email, password);


		yield return new WaitUntil(() => loginTask.IsCompleted);


		if (loginTask.Exception != null)
		{
			FirebaseException error = (FirebaseException) (loginTask.Exception.InnerException.InnerException);
			Debug.Log(error.ErrorCode);
			Debug.LogWarning(loginTask.Exception);
			if(error.ErrorCode == 14)
            {
				Debug.Log("User does not exist");
			}
		}
		else
			Debug.Log("login completed");

		StartCoroutine(DataTest(FirebaseAuth.DefaultInstance.CurrentUser.UserId, "TestWrite"));
	}






	private IEnumerator DataTest(string userID, string data)
	{
		Debug.Log("Trying to write data");
		var db = FirebaseDatabase.DefaultInstance;
		var dataTask = db.RootReference.Child("users").Child(userID).SetValueAsync(data);

		yield return new WaitUntil(() => dataTask.IsCompleted);

		if (dataTask.Exception != null)
			Debug.LogWarning(dataTask.Exception);
		else
			Debug.Log("DataTestWrite: Complete");
	}
}