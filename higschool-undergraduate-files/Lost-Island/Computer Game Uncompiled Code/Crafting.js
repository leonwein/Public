#pragma strict

var MenuSkin : GUISkin;

//References
var player : GameObject;
var mainCamera : GameObject;
var arms : GameObject;
var axe : GameObject;

//Icons
var campfireIcon : Texture;
var tentIcon : Texture;
var WaterWellIcon : Texture;

//Player prefabs
var campFire : GameObject;
var tent : GameObject;
var waterWell : GameObject;
var spareIcon2 : Texture;
var spare2 : GameObject;

var spareIcon3 : Texture;
var spare3 : GameObject;

var BtoB : GameObject;

//var check5 : GameObject;





private var showGUI : boolean = false;

private var invScript : Inv;


function Start()
{
    invScript = GetComponent(Inv);

}

function Update()
{
	if(Input.GetKeyDown("i"))
	{
	    Cursor.visible = true;
	    showGUI = !showGUI;
	  
	}
	
	if(showGUI == true)
	{
	    //player.GetComponent(idletoslash).enabled = false;
	    //Cursor.visible = true;
	    //Time.timeScale = 0;
	   // Cursor.visible = true;
		//player.GetComponent(FPSInputController).enabled = false;
		//player.GetComponent(MouseLook).enabled = false;
		//mainCamera.GetComponent(MouseLook).enabled = false;
		//arms.GetComponent(PlayerControl).enabled = false;
	}
	
	if(showGUI == false)
	{
	    //player.GetComponent(idletoslash).enabled = true;
	   // Time.timeScale = 1;
	   // Cursor.visible = false;
		//player.GetComponent(FPSInputController).enabled = true;
		//player.GetComponent(MouseLook).enabled = true;
		//mainCamera.GetComponent(MouseLook).enabled = true;
		//arms.GetComponent(PlayerControl).enabled = true;

	}
}
 
function OnGUI() 
{


	if(showGUI == true)
	{
	    
	    
		GUI.skin = MenuSkin;
    		GUI.BeginGroup(new Rect(Screen.width/2-150,Screen.height/2-0,300,300));
        		GUI.Box(Rect(0 , 0, 300, 300),"Crafting System");

        		if(GUI.Button(Rect(75, 75, 50, 50), GUIContent (campfireIcon, "Build a Campfire?")))
        		{
        			if(invScript.wood >= 6 && invScript.stone >= 3)
        			{
        			    //check5.SetActive(true);
        				campFire.SetActive(true);
        				invScript.wood -= 9;
        				invScript.stone -= 4;
        				invScript.campfireCount ++;
        				BtoB.SetActive(true);
        				
        				
        			}
        		}
        		
        		if(GUI.Button(Rect(75, 150, 50, 50), GUIContent(tentIcon, "Build a Tent?")))
        		{
        			if(invScript.wood >= 6 && invScript.stone >= 2 && invScript.thatch >= 9)
        			{
        				tent.SetActive(true);
        				invScript.wood -= 6;
        				invScript.stone -= 2;
        				invScript.thatch -= 9;
        				BtoB.SetActive(true);

        			}
        		}
        		
        		if(GUI.Button(Rect(175, 150, 50, 50), GUIContent(WaterWellIcon, "Build a Water Well?")))
        		{
        			if(invScript.wood >= 2 && invScript.stone >= 5 && invScript.metal >= 6)
        			{
        				waterWell.SetActive(true);
        				invScript.wood -= 2;
        				invScript.stone -= 5;
        				invScript.metal -= 6;
        				invScript.waterwellCount ++;
        				BtoB.SetActive(true);

        				
        			}
        		}

	    //Second Column

        		if(GUI.Button(Rect(175, 75, 50, 50), GUIContent(spareIcon2, "Craft a Bandage?")))
        		{
        		    if(invScript.thatch >= 2 && invScript.bandage >= 0)
        		    {
        		        //spare2.SetActive(true);
        		        invScript.thatch -= 2;
        		        invScript.bandage += 1;
        		        invScript.bandageCount ++;
        		    }
        		}
        		


        	//	if(GUI.Button(Rect(100, 120, 50, 50), GUIContent(spareIcon3, "Spare item tooltip!")))
        		//{
        		//    if(invScript.wood >= 10 && invScript.stone >= 5)
        		 //   {
        		 //       spare3.SetActive(true);
        		 //       invScript.wood -= 10;
        		 //       invScript.stone -= 5;
        		//    }
        	//	}

        		GUI.Label (Rect (100, 250, 100, 40), GUI.tooltip);
            	GUI.EndGroup ();
      }
}
















