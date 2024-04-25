#pragma strict


var rayLength : int = 0;
public var pickup : AudioClip;
public var sizzle : AudioClip;
public var water : AudioClip;
private var inventory2 : Inv2;

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

    inventory2 = GameObject.Find("FPSController").GetComponent(Inv2);
 
    
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
			  

                inventory2.wood++;
                inventory2.woodCount++;
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

            if (Input.GetKeyDown("e") &&  player.GetComponent(Inv2).pork >= 1)
            {

                player.GetComponent(Inv2).cookedPork++;
                player.GetComponent(Inv2).pork--;
                
		     
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

            if (Input.GetKeyDown("e") && player.GetComponent(Inv2).bottle >= 1)
            {
                player.GetComponent(Inv2).bottledWater++;
                player.GetComponent(Inv2).bottle--;

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
		        
                inventory2.coconut++;
		       
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
		        
                inventory2.stone++;
		        
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
		        
                inventory2.metal++;
		      
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
		        
                inventory2.pork++;
		      
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
                inventory2.bottle++;
		       
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
                inventory2.thatch++;
		       
                Destroy(hit.collider.gameObject);
                GetComponent.<AudioSource>().PlayOneShot(pickup);
                guiShow = false;
                plusThatch.SetActive(true);
                sup();
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







   












































