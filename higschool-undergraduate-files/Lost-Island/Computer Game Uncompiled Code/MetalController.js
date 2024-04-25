#pragma strict

var metalHealth : int = 12;

var metalbit : Transform;
var metal : GameObject;

var speed : int = 8;

function Start ()
{
    metal = this.gameObject;
    GetComponent.<Rigidbody>().isKinematic = true;

}

function Update()
{
    if(metalHealth <=0)
    {
        GetComponent.<Rigidbody>().isKinematic = false;
        GetComponent.<Rigidbody>().AddForce(transform.forward * speed);
        Destroymetal();

    }
}

function Destroymetal()
{
    yield WaitForSeconds(1);
    Destroy(metal);

    var position : Vector3 = Vector3(Random.Range(-1.0, 1.0), 0, Random.Range(-1.0, 1.0));
    Instantiate(metalbit, metal.transform.position + Vector3(0,0,0) + position, Quaternion.identity);
    Instantiate(metalbit, metal.transform.position + Vector3(0,0,3) + position, Quaternion.identity);
    Instantiate(metalbit, metal.transform.position + Vector3(0,0,6) + position, Quaternion.identity);
    Instantiate(metalbit, metal.transform.position + Vector3(2,0,9) + position, Quaternion.identity);
    
}