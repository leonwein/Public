#pragma strict

var treeHealth : int = 5;

var logs : Transform;
var coconut : Transform;
var tree : GameObject;
var thatch : GameObject;
var count : int = 0;

var speed : int = 8;

function Start ()
{
    tree = this.gameObject;
    GetComponent.<Rigidbody>().isKinematic = true;

}

function Update()
{
    if(treeHealth <=0)
    {
        
        GetComponent.<Rigidbody>().isKinematic = false;
        GetComponent.<Rigidbody>().AddForce(transform.forward * speed);
        DestroyTree();
        

    }
}

function DestroyTree()
{
    
    yield WaitForSeconds(5);
    count ++;
    Destroy(tree);
    

    var position : Vector3 = Vector3(Random.Range(-1.0, 1.0), 0, Random.Range(-1.0, 1.0));
    Instantiate(logs, tree.transform.position + Vector3(0,0,0) + position, Quaternion.identity);
    Instantiate(logs, tree.transform.position + Vector3(0,0,2) + position, Quaternion.identity);
    Instantiate(logs, tree.transform.position + Vector3(0,0,4) + position, Quaternion.identity);

    Instantiate(coconut, tree.transform.position + Vector3(2,0,6) + position, Quaternion.identity);
    Instantiate(coconut, tree.transform.position + Vector3(2,0,7) + position, Quaternion.identity);

    Instantiate(thatch, tree.transform.position + Vector3(0,0,7) + position, Quaternion.identity);
    Instantiate(thatch, tree.transform.position + Vector3(-2,0,7) + position, Quaternion.identity);
    Instantiate(thatch, tree.transform.position + Vector3(-4,0,7) + position, Quaternion.identity);
    



}