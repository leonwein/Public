#pragma strict

var menuSkin : GUISkin;

var wood : int = 0;
var stone : int = 0;
var metal : int = 0;
var thatch : int = 0;



var a : boolean = false;
var b : boolean = false;
var c : boolean = false;
var d : boolean = false;
var e : boolean = false;
var f1 : boolean = false;

var g : boolean = false;
var h : boolean = false;
var i : boolean = false;
var trig : GameObject;
var trig2 : GameObject;

var woodCount : int = 0;
var bandageCount : int = 0;
var campfireCount : int = 0;
var waterwellCount : int = 0;

var bridge : GameObject;

var sound : AudioClip;

var kills : int = 0;
var Pkills : int = 0;

var pork : int = 0;
var cookedPork : int = 0;

var coconut : int = 0;

var bottle : int = 0;
var bottledWater : int = 0;

var bandage : int = 0;

var check1 : GameObject;
var check2 : GameObject;
var check3 : GameObject;
var check4 : GameObject;

var check5 : GameObject;
var check6 : GameObject;
var check7 : GameObject;

var finishGUI : GameObject;
var finishGUI2 : GameObject;


//var script : FirstPersonController;

private var showGUI : boolean = false;

//private var playerGUI : PlayerGUI;

var minimumVal : int = 0;

private var craft : Crafting;
private var playerGUI : PlayerGUI;
playerGUI = GameObject.Find("FPSController").GetComponent(PlayerGUI);
//craft - GameObject.Find("FPSController").GetComponent(Crafting);
function Start()
{
    
}

function Update ()


{


    if(wood <= 0)
    {
        wood = minimumVal;
    }

    if(stone <= 0)
    {
        stone = minimumVal;
    }

    if(metal <= 0)
    {
        metal = minimumVal;
    }
    
    if(thatch <= 0)
    {
        thatch = minimumVal;
    }
   
    if(pork <= 0)
    {
        pork = minimumVal;
    }
    
    if(cookedPork <= 0)
    {
        cookedPork = minimumVal;
    }
    
    if(bottle <= 0)
    {
        bottle = minimumVal;
    }

    if(bottledWater <= 0)
    {
        bottledWater = minimumVal;
    }

    if(bandage <= 0)
    {
        bandage = minimumVal;
    }

    if(coconut<= 0)
    {
        coconut = minimumVal;
    }
    if(kills<= 0)
    {
        kills = minimumVal;
    }
    
    if(Input.GetKeyDown("i"))
    {
        showGUI = !showGUI;
        
    }
    //objectives

    if(kills >= 5)
    {
        check1.SetActive(true);
        a = true;
     
        
    }

    if(Pkills >= 3)
    {
        check2.SetActive(true);
        b = true;
    }
  
    if(woodCount >= 10)
    {
        check3.SetActive(true);
        c = true;

    }
  if(bandageCount >= 6)
   {
       check4.SetActive(true);
       d = true;
  }
  if(campfireCount >= 1)
  {
      e = true;
  }
  if(waterwellCount >= 1)
  {
      f1 = true;
  }
    if(a == true && b == true && c == true && d == true && e == true && f1 == true)
    {
        trig.SetActive(true);
        finishGUI.SetActive(true);
    }

    //objectives level 3
   if(bandageCount >= 5)
   {
        Debug.Log("Hommie up in here brah");
        check5.SetActive(true);
        g = true;

    }
   if(kills >= 8)
   {
       check6.SetActive(true);
        h = true;
    }
    if(g == true && h == true && i == true)
    {
        trig2.SetActive(true);
        finishGUI2.SetActive(true);
        
       
    }
    
    

    if(showGUI == true)
    {

        (GameObject.FindWithTag("Player").GetComponent("FirstPersonController") as MonoBehaviour).enabled = false;
        (GameObject.FindWithTag("Axe").GetComponent("idletoslash")as MonoBehaviour).enabled = false;
       
    }


    if(showGUI == false)
    {
       
        (GameObject.FindWithTag("Player").GetComponent("FirstPersonController") as MonoBehaviour).enabled = true;
        (GameObject.FindWithTag("Axe").GetComponent("idletoslash")as MonoBehaviour).enabled = true;
    }


}

function OnGUI()
{
    if(showGUI == true)
    {
        (GameObject.FindWithTag("Player").GetComponent("FirstPersonController") as MonoBehaviour).enabled = false;
        (GameObject.FindWithTag("Axe").GetComponent("idletoslash")as MonoBehaviour).enabled = false;
        

       // Cursor.visible = true;
        GUI.skin = menuSkin;
        GUI.BeginGroup(new Rect(Screen.width / 2 - 150, Screen.height / 2 - 450 , 300, 300));
        GUI.Box(Rect(0, 0, 300, 300), "Inventory");
            
       
        
        
        //Resources collected
        GUI.Label(Rect(10, 50, 50, 50), "Wood");
        GUI.skin.box.fontSize=13;
        GUI.Box(Rect(60, 50, 20, 20), "" + wood);

        GUI.Label(Rect(90, 50, 50, 50), "Stone");
        GUI.Box(Rect(130, 50, 20, 20), "" + stone);

        GUI.Label(Rect(160, 50, 50, 50), "Metal");
        GUI.Box(Rect(200, 50, 20, 20), "" + metal);

        GUI.Label(Rect(225, 50, 50, 50), "Thatch");
        GUI.Box(Rect(270, 50, 20, 20), "" + thatch);
        // Empty

        GUI.Label(Rect(10, 130, 50, 50), "Pork");
        GUI.Box(Rect(60, 130, 20, 20), "" + pork);

        GUI.Label(Rect(10, 150, 50, 50), "Bottle");
        GUI.Box(Rect(60, 150, 20, 20), "" + bottle);

        GUI.Label(Rect(100, 100, 100, 50), "Enemy kills");
        GUI.Box(Rect(180, 100, 20, 20), "" + kills);
        //Edable Items
        GUI.Label(Rect(10, 190, 50, 50), "C.Pork");
        GUI.Box(Rect(60, 190, 20, 20), "" + cookedPork);
        if(GUI.Button(Rect(100, 190, 100, 20), "Eat C.Pork?"))
        {
            if(cookedPork >= 1)
            {
                cookedPork--;
                Eat();
                
            }
        }

        GUI.Label(Rect(10, 210, 50, 50), "B.Water");
        GUI.Box(Rect(60, 210, 20, 20), "" + bottledWater);
        if(GUI.Button(Rect(100, 210, 100, 20), "Drink Water?"))
        {
            if(bottledWater >= 1)
            {
                bottledWater--;
                Drink();
            }
        }

        GUI.Label(Rect(10, 240, 50, 50), "Heal");
        GUI.Box(Rect(60, 240, 20, 20), "" + bandage);
        if(GUI.Button(Rect(100, 240, 100, 20), "Use Bandage?"))
        {
            if(bandage >= 1)
            {
                bandage--;
                Heal();
            }
        }

        GUI.Label(Rect(10, 270, 50, 50), "Coconut");
        GUI.Box(Rect(60, 270, 20, 20), "" + coconut);
        if(GUI.Button(Rect(100, 270, 100, 20), "Eat Coconut?"))
        {
            if(coconut >= 1)
            {
                coconut--;
                Eat1();
            }
        }


            
        GUI.EndGroup();


    }
    if(showGUI == false)
    {
        (GameObject.FindWithTag("Player").GetComponent("FirstPersonController") as MonoBehaviour).enabled = true;
        (GameObject.FindWithTag("Axe").GetComponent("idletoslash")as MonoBehaviour).enabled = true;
    }
        //Cursor.visible = false;
    }


function Eat()
{
    playerGUI.hungerBarDisplay += .2;
    
}

function Drink()
{
    playerGUI.thirstBarDisplay += .2;
}

function Heal ()
{
    playerGUI.healthBarDisplay += .25;
}

function Eat1()
{
    playerGUI.hungerBarDisplay += .05;
}

function Reset()
{
    wood = minimumVal;
    stone = minimumVal;
    metal = minimumVal;
    thatch = minimumVal;
    pork = minimumVal;
    cookedPork = minimumVal;
    bottle = minimumVal;
    bottledWater = minimumVal;
    bandage = minimumVal;
    coconut = minimumVal;
}

