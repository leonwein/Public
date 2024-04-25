#pragma strict

var played = false;
var trig = false;
private var Obj : Inv;

var sound: AudioClip;

function Start () {

}

function OnTriggerEnter (other : Collider)
    {
        trig = true;
    }

    function Update () {
        Obj = GameObject.Find("FPSController").GetComponent(Inv);
    if(trig == true) //&& Obj.kills >= 5 && Obj.Pkills >= 3 && Obj.wood >=10 && Obj.campfireCount >= 1 && Obj.waterwellCount >= 1)
    {

        PlaySound();
        Application.LoadLevel(2);				
    
    }
     
}

function PlaySound()
{
    if(!played)
    {
        played = true;
        GetComponent.<AudioSource>().PlayOneShot(sound);
    }
}