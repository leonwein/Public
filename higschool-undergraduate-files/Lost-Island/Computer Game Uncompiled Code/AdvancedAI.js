#pragma strict

var Distance : float;
var Target : Transform;
var lookAtDistance = 25.0;
var chaseRange = 15.0;
var attackRange = 2.7;
var moveSpeed = 5.0;
var Damping = 6.0;
var attackRepeatTime = 1;
private var playerGUI : PlayerGUI;
private var playerGUI2 : PlayerGUI2;
private var enemyScript: EnemyHealth;
var rayLength : int = 20;
var attackGUI : GameObject;
var x : int = 0;

var ding : AudioClip;

private var textScript: text2;


var TheDammage = 40;

private var attackTime : float;

var controller : CharacterController;
var gravity : float = 20.0;
private var MoveDirection : Vector3 = Vector3.zero;

function Start ()
{
    attackTime = Time.time;
    playerGUI = GameObject.Find("FPSController").GetComponent(PlayerGUI);
    playerGUI2 = GameObject.Find("FPSController").GetComponent(PlayerGUI2);
    enemyScript = GameObject.Find("enemy").GetComponent(EnemyHealth);
    textScript = GameObject.Find("Objectives").GetComponent(text2);
}

function Update ()

{

    var  hit : RaycastHit;
    var fwd = transform.TransformDirection(Vector3.forward);
    Distance = Vector3.Distance(Target.position, transform.position);

    enemyScript = GameObject.Find("enemy").GetComponent(EnemyHealth);
    
	 

    if(Physics.Raycast(transform.position, fwd, hit, rayLength))
    {
        //Debug.Log("broooooo");
        if(hit.collider.gameObject.tag == "enemy")
        {
          //  Debug.Log("broooooo");
            enemyScript = GameObject.Find(hit.collider.gameObject.name).GetComponent(EnemyHealth);
            enemyScript.Health -=50;
          

            if(Input.GetButtonDown("Fire1") == true)
            {
                        // Debug.Log("eagle has landed");
                        enemyScript.Health -=50;
            }
        }
    }

	
	if (Distance < lookAtDistance)
	{
		lookAt();
	}
	
	if (Distance > lookAtDistance)
	{
	    GetComponent.<Renderer>().material.color = Color.green;
	  
	}
	
	if (Distance <= attackRange)
	{
	    x++;
	    attack();
	    attackGUI.SetActive(true);
	    if(x == 5)
	    {
	        GetComponent.<AudioSource>().PlayOneShot(ding);
	        if(x == 500)
	        {
	            x = 0;
	        }
	    }

	     Debug.Log ("Sup DOg");
	   
	}
	else if (Distance < chaseRange)
	{
	  
		chase ();
	}
}

function lookAt ()
{
	GetComponent.<Renderer>().material.color = Color.yellow;
	var rotation = Quaternion.LookRotation(Target.position - transform.position);
	transform.rotation = Quaternion.Slerp(transform.rotation, rotation, Time.deltaTime * Damping);
	
	attackGUI.SetActive(false);
}

function chase ()
{
	GetComponent.<Renderer>().material.color = Color.red;
	
	MoveDirection = transform.forward;
	MoveDirection *= moveSpeed;
	
	MoveDirection.y -= gravity * Time.deltaTime;
	controller.Move(MoveDirection * Time.deltaTime);
	attackGUI.SetActive(false);
	

	//textScript.problem = 0;
}

function attack ()
{
    playerGUI = GameObject.Find("FPSController").GetComponent(PlayerGUI);
    

	if (Time.time > attackTime)
	{
	
	    attackTime = Time.time + attackRepeatTime;
	    
		playerGUI.healthBarDisplay -= .05; 
		playerGUI2.healthBarDisplay -= .05;
		attackGUI.SetActive(true);
	    
		
		//textScript.problem = 1;

	}
}

function ApplyDammage ()
{
	chaseRange += 30;
	moveSpeed += 2;
	lookAtDistance += 40;
    
}