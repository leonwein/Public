#pragma strict

function Start () {

}

function Update () {
    if(Input.GetKeyDown("1"))
    {
        
        Application.LoadLevel(2);	
    }
    if(Input.GetKeyDown("escape"))
    {
        Application.LoadLevel(0);
    }
}