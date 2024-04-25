#pragma strict
var text1 : GameObject;
var text2 : GameObject;
var text3 : GameObject;
var text4 : GameObject;
var text5 : GameObject;


//var Text1 : UI.Text;\

var someText : UI.Text;

var calm : boolean = true;
var x : int = 0;



private var seq : int = 1;





private var TC : RayCastChop;
private var inventory : Inv;



function Start () {
   
    someText.text = "sup";
    

}


function Update () {

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
            x = -1;
        }
        x++;
    }

    
}


