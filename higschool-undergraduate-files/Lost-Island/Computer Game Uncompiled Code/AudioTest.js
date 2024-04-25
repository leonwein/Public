#pragma strict


public var sound : AudioClip;
function Update () {
    if(Input.GetKeyDown("e"))
    {

      
        GetComponent.<AudioSource>().PlayOneShot(sound);
    }
}