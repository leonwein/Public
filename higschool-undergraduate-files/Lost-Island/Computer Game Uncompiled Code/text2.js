#pragma strict
 


//var Text1 : UI.Text;\

var someText : UI.Text;
var start : GameObject;

var calm : boolean = true;
var x : int = 0;
var problem : int = 4;
var k : int = 0;



private var seq : int = 1;



private var TC : RayCastChop;
private var inventory : Inv;




function Start () {
   
   
    someText.text = "sup";
    //textScript = GameObject.Find("Objectives").GetComponent(text2);

}


function Update () {
    if(k == 0)
    {
        Time.timeScale = 0;
        (GameObject.FindWithTag("Player").GetComponent("FirstPersonController") as MonoBehaviour).enabled = false;
    if(Input.GetKeyDown("space"))
    {
        k ++;
        start.SetActive(false);
        (GameObject.FindWithTag("Player").GetComponent("FirstPersonController") as MonoBehaviour).enabled = true;
        Time.timeScale = 1;

    }

    }

    if(calm == true)
    {
        if(x == 0)
        {
            someText.text = "You can Pick Up bottles to fill them with water at a well.";

        }

        else if (x == 1000)
        {
            someText.text = "Crafting a campfire will allow you to cook raw meat.";
        }
        else if (x == 2000)
        {
            someText.text = "You can press " + '"i"' + " to open the inventory.";
        }
        else if (x == 3000)
        {
            someText.text = "You can eat coconuts to restore some hunger.";
           
        }
        else if (x == 4000)
        {
            someText.text = "Tents will restore health, Hunger, and thirst.";
           
        }
        else if (x == 5000)
        {
            someText.text = "Enemies will take significant amounts of damage so be sure to heal yourself back up!";
           
        }
        else if (x == 6000)
        {
            someText.text = "You will not be able to craft an item if you do not have enough resources.";
           
        }
        else if (x == 7000)
        {
            someText.text = "If you are having trouble picking up an item, do not stand too close to it.";
            x = -1;
        }
        x++;
    }
    if(calm == false)
    {
        if(problem == 1)
        {
            someText.text = "You are bieng attacked!";
            //fontSize + 20;
        }
        if(problem == 2)
        {
            someText.text = "Your health is low. Bandage yourself to regain health!";
        }
        if(problem == 3)
        {
            someText.text = "Your hunger is low. Eat something to regain hunger!";
        }
       else if(problem == 4)
        {
            someText.text = "Your thirst is low. Drink water to regain hydration!";
        }
        else if(problem == 0)
        {
            someText.text = "";
            calm = true;
            x = 0;
        }
    }

    
}


