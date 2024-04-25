#pragma strict


//Size of Textures

var size : Vector2 = new Vector2(240, 40);

var hasPlayed : boolean = false;
var x : int = 0;
var y : int = 0;
var z : int = 0;


//Health Variables
var healthPos : Vector2 = new Vector2(20, 20);
var healthBarDisplay : float = 1;
var healthBarEmpty : Texture2D;
var healthBarFull : Texture2D;

//Hunger Variables
var hungerPos : Vector2 = new Vector2(20, 60);
var hungerBarDisplay : float = 1;
var hungerBarEmpty : Texture2D;
var hungerBarFull : Texture2D;

//Thirst Variables
var thirstPos : Vector2 = new Vector2(20, 100);
var thirstBarDisplay : float = 1;
var thirstBarEmpty : Texture2D;
var thirstBarFull : Texture2D;

//Stamina Variables
var staminaPos : Vector2 = new Vector2(20, 140);
var staminaBarDisplay : float = 1;
var staminaBarEmpty : Texture2D;
var staminaBarFull : Texture2D;

//Fall Rate
var healthFallRate : int = 150;
var hungerFallRate : int = 150;
var thirstFallRate : int = 100;
var staminaFallRate : int = 35;

var infoicon : GameObject;
var infoicon1 : GameObject;
var infoicon2 : GameObject;

var Info : AudioClip;

var damageGUI : GameObject;

var quit = false;

private var textScript: text2;

//private var FPC : FirstPersonController;
private var controller : CharacterController;
//private var imessage : message;

var canJump : boolean = false;

var jumpTimer : float = 0.7;


var destination : Transform;
var RespawnGUI : GameObject;
//var tent : GameObject;

function Start()
{
    
    //FPC = GetComponent(FirstPersonController);
    controller = GetComponent(CharacterController);
    textScript = GameObject.Find("Objectives").GetComponent(text2);

}

function OnGUI()
{
    //Health GUI
    GUI.BeginGroup(new Rect (healthPos.x, healthPos.y, size.x, size.y));
    GUI.Box(Rect(0, 0, size.x, size.y), healthBarEmpty);
	
    GUI.BeginGroup(new Rect (0, 0, size.x * healthBarDisplay, size.y));
    GUI.Box(Rect(0, 0, size.x, size.y), healthBarFull);
	
    GUI.EndGroup();
    GUI.EndGroup();
	
    //Hunger GUI
    GUI.BeginGroup(new Rect (hungerPos.x, hungerPos.y, size.x, size.y));
    GUI.Box(Rect(0, 0, size.x, size.y), hungerBarEmpty);
	
    GUI.BeginGroup(new Rect (0, 0, size.x * hungerBarDisplay, size.y));
    GUI.Box(Rect(0, 0, size.x, size.y), hungerBarFull);
	
    GUI.EndGroup();
    GUI.EndGroup();
	
    //Thirst GUI
    GUI.BeginGroup(new Rect (thirstPos.x, thirstPos.y, size.x, size.y));
    GUI.Box(Rect(0, 0, size.x, size.y), thirstBarEmpty);
	
    GUI.BeginGroup(new Rect (0, 0, size.x * thirstBarDisplay, size.y));
    GUI.Box(Rect(0, 0, size.x, size.y), thirstBarFull);
	
    GUI.EndGroup();
    GUI.EndGroup();
	
    //Stamina GUI
    GUI.BeginGroup(new Rect (staminaPos.x, staminaPos.y, size.x, size.y));
    GUI.Box(Rect(0, 0, size.x, size.y), staminaBarEmpty);
	
    GUI.BeginGroup(new Rect (0, 0, size.x * staminaBarDisplay, size.y));
    GUI.Box(Rect(0, 0, size.x, size.y), staminaBarFull);
	
    GUI.EndGroup();
    GUI.EndGroup();
}

function Update()
{
    //imessage = GameObject.Find("message");
    //tent.FindGameObjectsWithTag("tent");
    //HEALTH CONTROL SECTION
    if(hungerBarDisplay <= 0 && (thirstBarDisplay <= 0))
    {
        healthBarDisplay -= Time.deltaTime / healthFallRate * 2;
    }
	
    else
    {
        if(hungerBarDisplay <= 0 || thirstBarDisplay <= 0)
        {
            healthBarDisplay -= Time.deltaTime / healthFallRate;
            // imessage.
		    
            
        }
    }
	
    if(healthBarDisplay <= 0)
    {
	   
        //yield WaitForSeconds(6);
        Respawn();

    }
	
    //HUNGER CONTROL SECTION
    if(hungerBarDisplay >= 0)
    {
        hungerBarDisplay -= Time.deltaTime / hungerFallRate;
        damageGUI.SetActive(false);
    }
	
    if(hungerBarDisplay <= 0)
    {
        hungerBarDisplay = 0;
        damageGUI.SetActive(true);
        textScript.calm = false;
        textScript.someText.text = "You are Loosing Health!";
        infoicon2.SetActive(true);

    }
	
    if(hungerBarDisplay >= 1)
    {
        hungerBarDisplay = 1;
    }
	
    //THIRST CONTROL SECTION
    if(thirstBarDisplay >= 0)
    {
        thirstBarDisplay -= Time.deltaTime / thirstFallRate;
        damageGUI.SetActive(false);
    }
	
    if(thirstBarDisplay <= 0)
    {
        thirstBarDisplay = 0;
        damageGUI.SetActive(true);
        textScript.calm = false;
        textScript.someText.text = "You are Loosing Health!";
        infoicon.SetActive(true);
    }
	
    if(thirstBarDisplay >= 1)
    {
        thirstBarDisplay = 1;
    }

    //problem situations

    if(healthBarDisplay <= .3)
    {

        textScript.calm = false;
        Debug.Log("sup dooggg");
	   

	   
        textScript.someText.text = "Heal yourself! your Health is low!";
        infoicon1.SetActive(true);
        z++;
        if(z == 5)
        {
	        
            GetComponent.<AudioSource>().PlayOneShot(Info);
        }
    }
    if(hungerBarDisplay <= .3 && hungerBarDisplay > .0001)
    {
	    
        textScript.calm = false;
	   
        textScript.someText.text = "Eat something! your Hunger bar is low!";
        infoicon2.SetActive(true);
        y++;
        if(y == 5)
        {
	        
            GetComponent.<AudioSource>().PlayOneShot(Info);
        }
    }
    if(thirstBarDisplay <= .3 && thirstBarDisplay > .0001)
    {
        infoicon.SetActive(true);
        textScript.calm = false;
        Debug.Log("Noiccee");
        textScript.someText.text = "Drink something! your thirst bar is low!";
        x++;
        if(x == 5)
        {
	        
            GetComponent.<AudioSource>().PlayOneShot(Info);
        }
	 
	

	    
    }

    
    if(healthBarDisplay >= .31)
    {	    
        textScript.problem = 0;
        infoicon1.SetActive(false);
        z = 0;
    }
    if(hungerBarDisplay >= .31)
    {
        textScript.problem = 0;
        infoicon2.SetActive(false);
        y = 0;
	   
    }
    if(thirstBarDisplay >= .31)
    {
        textScript.problem = 0;
        infoicon.SetActive(false);
        x = 0;
    }




	
    //STAMINA CONTROL SECTION
    if(Input.GetKey(KeyCode.LeftShift))
    {
		
        staminaBarDisplay -= Time.deltaTime / staminaFallRate;
	    
    }
        

	
    else
    {
        //chMotor.movement.maxForwardSpeed = 6;
        //chMotor.movement.maxSidewaysSpeed = 6;
        staminaBarDisplay += Time.deltaTime / staminaFallRate;
    }


	
	
	
    if(staminaBarDisplay >= 1)
    {
        staminaBarDisplay = 1;
    }
	
    if(staminaBarDisplay <= 0)
    {
		
        staminaBarDisplay = 0;
        canJump = false;
		
    }
}

function Respawn()
{
    Time.timeScale = 0;
    RespawnGUI.SetActive(true);
    (GameObject.FindWithTag("Player").GetComponent("FirstPersonController") as MonoBehaviour).enabled = false;
    (GameObject.FindWithTag("Axe").GetComponent("idletoslash")as MonoBehaviour).enabled = false;
    
    if(Input.GetKeyDown("space"))
    {
        Time.timeScale = 1;
        Debug.Log("homeslice");
      
        RespawnGUI.SetActive(false);
        this.gameObject.transform.position = destination.position + Vector3(20, 5, 5);
      
        healthBarDisplay = .5;
        hungerBarDisplay = 1;
        thirstBarDisplay = 1;
        staminaBarDisplay = 1;
        (GameObject.FindWithTag("Player").GetComponent("FirstPersonController") as MonoBehaviour).enabled = true;
        (GameObject.FindWithTag("Axe").GetComponent("idletoslash")as MonoBehaviour).enabled = true;

        var inventoryScript = GetComponent(Inv);
        inventoryScript.Reset();
    }
    if(Input.GetKeyDown("escape"))
    {
        Time.timeScale = 1;
        RespawnGUI.SetActive(false);
        Application.LoadLevel(0);
    }

    
}

function Wait()
{
    yield WaitForSeconds(0.5);
    //canJump = false;
}
function Play()
{
    GetComponent.<AudioSource>().PlayOneShot(Info);
  
}
