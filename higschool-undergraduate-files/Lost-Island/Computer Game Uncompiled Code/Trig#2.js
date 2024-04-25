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
        if(trig == true)
        {

            PlaySound();
            Application.LoadLevel(3);				
    
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