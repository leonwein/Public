#pragma strict

var enemyHealth : int = 3;


var coconut : Transform;
var enemy : GameObject;
private var textScript: text2;

var speed : int = 8;
private var inventory : Inv;
private var inv2 : Inv2;
private var redGUI : AdvancedAI;
var attackGUI : GameObject;
function Start ()
{
    redGUI = GetComponent(AdvancedAI);
    inventory = GameObject.Find("FPSController").GetComponent(Inv);
    inv2 = GameObject.Find("FPSController").GetComponent(Inv2);
    textScript = GameObject.Find("Objectives").GetComponent(text2);
    enemy = this.gameObject;
    GetComponent.<Rigidbody>().isKinematic = true;
    

}

function Update()
{
    
    if(enemyHealth <=0)
    {
        attackGUI.SetActive(false);
        enemyHealth = 0;
         
        Debug.Log("yolo");
        Destroyenemy();
        inv2.kills += 1; 
        textScript.problem = 0;
        

        //GetComponent.<Rigidbody>().isKinematic = false;
        //GetComponent.<Rigidbody>().AddForce(transform.forward * speed);
        
       
        

    }
}

function Destroyenemy()
{
   // redGUI.damageGUI.SetActive(false);
    
    
    Destroy(enemy);

    //
    inventory.kills += 1;
    
   // damage.damageGUI.SetActive(false);

    var position : Vector3 = Vector3(Random.Range(-1.0, 1.0), 0, Random.Range(-1.0, 1.0));
    Instantiate(coconut, enemy.transform.position + Vector3(0,0,0) + position, Quaternion.identity);
    Instantiate(coconut, enemy.transform.position + Vector3(0,0,2) + position, Quaternion.identity);
    

 
}