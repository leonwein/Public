#pragma strict
var sound : AudioClip;
function Start(){
     
    GetComponent.<AudioSource>().PlayOneShot(sound);
     
}
