#pragma strict

var pigHealth : int = 5;

var pork : Transform;
var pig : GameObject;

var speed : int = 8;
private var inventory : Inv;

function Start ()
{
    inventory = GameObject.Find("FPSController").GetComponent(Inv);
    pig = this.gameObject;
    GetComponent.<Rigidbody>().isKinematic = true;

}

function Update()
{
    if(pigHealth <=0)
    {
        GetComponent.<Rigidbody>().isKinematic = false;
        GetComponent.<Rigidbody>().AddForce(transform.forward * speed);
        DestroyPig();
        

    }
}

function DestroyPig()
{
    
    //Debug.Log ("pig should die");
    yield WaitForSeconds(1);
    Destroy(pig);

    var position : Vector3 = Vector3(Random.Range(-1.0, 1.0), 0, Random.Range(-1.0, 1.0));
    Instantiate(pork, pig.transform.position + Vector3(0,0,0) + position, Quaternion.identity);
    Instantiate(pork, pig.transform.position + Vector3(0,0,2) + position, Quaternion.identity);
    Instantiate(pork, pig.transform.position + Vector3(0,0,4) + position, Quaternion.identity);
    inventory.Pkills += 1;




}