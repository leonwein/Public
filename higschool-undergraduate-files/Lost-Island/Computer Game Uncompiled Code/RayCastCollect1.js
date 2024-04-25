#pragma strict


var rayLength : int = 0;
public var pickup : AudioClip;
public var sizzle : AudioClip;
public var water : AudioClip;
private var inventory : Inv;

var plusWood : GameObject;
var plusStone : GameObject;
var plusMetal : GameObject;
var plusThatch : GameObject;
var plusPork : GameObject;
var plusCPork: GameObject;
var plusCoconut : GameObject;
var plusBottle : GameObject;
var plusBWater : GameObject;
var plusBandage : GameObject;




var player : GameObject;

private var guiShow : boolean = false;
private var guiPork : boolean = false;
private var guiWater : boolean = false;
private var guiShow2 : boolean = false;
private var guiShow3 : boolean = false;
private var guiShow4 : boolean = false;
var dock : GameObject;
var boat : GameObject;
var buildBoat : GameObject;

function Start()
{

    inventory = GameObject.Find("FPSController").GetComponent(Inv);
 
    
}

function Update()
{
	var hit : RaycastHit;
	var fwd = transform.TransformDirection(Vector3.forward);
	
	if(Physics.Raycast(transform.position, fwd, hit, rayLength))
	{
	    
		if(hit.collider.gameObject.tag == "stick")
		{	
		    print("eagle has landed");
			guiShow4 = true;
			
			if(Input.GetKeyDown("e"))
			{
			  

			    inventory.wood++;
			    inventory.woodCount++;
			    Destroy(hit.collider.gameObject);
			    GetComponent.<AudioSource>().PlayOneShot(pickup);
			    guiShow4 = false;	
                
			    plusWood.SetActive(true);
			    sup();
			    
			   			    								 
			}
		
		}
		else
		{
		    guiShow4 = false;
		}

		if(hit.collider.gameObject.tag == "campfire")
		{
		    guiShow4 = true;

		    if (Input.GetKeyDown("e") &&  player.GetComponent(Inv).pork >= 1)
		    {

		        player.GetComponent(Inv).cookedPork++;
		        player.GetComponent(Inv).pork--;
                
		     
		        GetComponent.<AudioSource>().PlayOneShot(sizzle);
		        guiShow4 = false;
		        plusCPork.SetActive(true);
		        sup();
		        Debug.Log ("bud why is it not working");
		    }

		    else
		    {
		        guiShow4 = false;
		    }
		}

		if(hit.collider.gameObject.tag == "waterwell")
		{
		    guiWater = true;

		    if (Input.GetKeyDown("e") && player.GetComponent(Inv).bottle >= 1)
		    {
		        player.GetComponent(Inv).bottledWater++;
		        player.GetComponent(Inv).bottle--;

		        GetComponent.<AudioSource>().PlayOneShot(water);
		        plusBWater.SetActive(true);
		        sup();
		        Debug.Log ("bud why is it not working");
		    }

		    else
		    {
		        //not enough pork
		        Debug.Log("Not enough bottles");
		    }
		}


		
		
		else
			{
		    guiShow = false;
		    guiPork = false;
		    guiWater = false;
		    //guiShow4 = false;
		    
			}
	
	
		
		
		if(hit.collider.gameObject.tag == "coconut")
		{	
		    print("eagle has landed");
		    guiShow = true;
			
		    if(Input.GetKeyDown("e"))
		    {
		        
		        inventory.coconut++;
		       
		        Destroy(hit.collider.gameObject);
		        GetComponent.<AudioSource>().PlayOneShot(pickup);
		        guiShow = false;
		        plusCoconut.SetActive(true);
		        sup();
		    }
		}


		if(hit.collider.gameObject.tag == "rockbit")
		{	
		    print("eagle has landed");
		    guiShow = true;
			
		    if(Input.GetKeyDown("e"))
		    {
		        
		        inventory.stone++;
		        
		        Destroy(hit.collider.gameObject);
		        GetComponent.<AudioSource>().PlayOneShot(pickup);
		        guiShow = false;
		        plusStone.SetActive(true);
		        sup();

		    }
		}



        
		if(hit.collider.gameObject.tag == "metalbit")
		{	
		    print("eagle has landed");
		    guiShow = true;
			
		    if(Input.GetKeyDown("e"))
		    {
		        
		        inventory.metal++;
		      
		        Destroy(hit.collider.gameObject);
		        GetComponent.<AudioSource>().PlayOneShot(pickup);
		        guiShow = false;
		        plusMetal.SetActive(true);
		        sup();
		    }
		}

		if(hit.collider.gameObject.tag == "pork")
		{	
		    print("eagle has landed");
		    guiShow = true;
			
		    if(Input.GetKeyDown("e"))
		    {
		        
		        inventory.pork++;
		      
		        Destroy(hit.collider.gameObject);
		        GetComponent.<AudioSource>().PlayOneShot(pickup);
		        guiShow = false;
		        plusPork.SetActive(true);
		        sup();
		    }
		}

		if(hit.collider.gameObject.tag == "bottle")
		{	
		    print("eagle has landed");
		    guiShow = true;
			
		    if(Input.GetKeyDown("e"))
		    {
		        GetComponent.<AudioSource>().PlayOneShot(pickup);
		        inventory.bottle++;
		       
		        Destroy(hit.collider.gameObject);
		        GetComponent.<AudioSource>().PlayOneShot(pickup);
		        plusBottle.SetActive(true);
		        sup();
		        guiShow = false;
		    }
		}

		if(hit.collider.gameObject.tag == "thatch")
		{	
		    print("eagle has landed");
		    guiShow = true;
			
		    if(Input.GetKeyDown("e"))
		    {
		        GetComponent.<AudioSource>().PlayOneShot(pickup);
		        inventory.thatch++;
		       
		        Destroy(hit.collider.gameObject);
		        GetComponent.<AudioSource>().PlayOneShot(pickup);
		        guiShow = false;
		        plusThatch.SetActive(true);
		        sup();
		    }
		}

		if(inventory.g == true && inventory.h == true && inventory.i == true)
		{
		    buildBoat.SetActive(true);
		    dock.SetActive(true);
		    if(hit.collider.gameObject.tag == "dock")
		    {	
		        print("eagle has landed");
		        guiShow2 = true;
		    }
		    else
		    {
		        guiShow2 = false;
		    }
		    
			
		        if(Input.GetKeyDown("e"))
		        {
		            
		            if(inventory.wood >= 12 && inventory.stone >= 6 && inventory.thatch >= 8)
		            {
		                
                        inventory.wood -= 12;
		            inventory.stone -= 6;
		            inventory.thatch -= 8;
		            guiShow2 = false;
		            boat.SetActive(true);
		          

		            }
		       
		            
		           
		        }

		        if(hit.collider.gameObject.tag == "boat")
		        {
		            guiShow3 = true;
		            if(Input.GetKeyDown("e"))
		            {
		                guiShow3 = false;
		                Application.LoadLevel(4);	
		            }


		        }
		        else
		        {
		            guiShow3 = false;
		        }
		    }
		




	}

}


function OnGUI()
{
	if(guiShow == true)
	{
	    GUI.skin.box.fontSize=30;
		GUI.Box(Rect(Screen.width / 2 - 250, Screen.height / 2 - 300, 200, 50), "(E) To Pickup");
	}

	if(guiPork== true)
	{
	    GUI.skin.box.fontSize=30;
	    GUI.Box(Rect(Screen.width / 2 - 250, Screen.height / 2 - 300, 200, 50), "(E) To Cook");
	}

	if(guiWater== true)
	{
	    GUI.skin.box.fontSize=25;
	    GUI.Box(Rect(Screen.width / 2 - 250, Screen.height / 2 - 300, 200, 50), "(E) To Fill Water");
	}
	if(guiShow2 == true)
	{
	    GUI.skin.box.fontSize=25;
	    GUI.Box(Rect(Screen.width / 2 - 250, Screen.height / 2 - 300, 200, 50), "(E) To Build Boat");
	}
	if(guiShow3 == true)
	{
	    GUI.skin.box.fontSize=25;
	    GUI.Box(Rect(Screen.width / 2 - 250, Screen.height / 2 - 300, 200, 50), "(E) Escape Lost Island!");
	}

	if(guiShow4 == true)
	{
	    GUI.skin.box.fontSize=30;
	    GUI.Box(Rect(Screen.width / 2 - 250, Screen.height / 2 - 300, 200, 50), "(E) To Pickup");
	}
}

function sup()
{
    yield WaitForSeconds(.5);
    plusWood.SetActive(false);
    plusStone.SetActive(false);
    plusMetal.SetActive(false);
    plusThatch.SetActive(false);
    plusPork.SetActive(false);
    plusCPork.SetActive(false);
    plusCoconut.SetActive(false);
    plusBottle.SetActive(false);
    plusBWater.SetActive(false);
    plusStone.SetActive(false);
}








































