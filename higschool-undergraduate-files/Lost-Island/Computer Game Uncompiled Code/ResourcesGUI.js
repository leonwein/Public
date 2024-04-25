#pragma strict

var MenuSkin : GUISkin;

//References

private var showGUI : boolean = false;





function Update()
{
    if(Input.GetKeyDown("i"))
    {
        Cursor.visible = true;
        showGUI = !showGUI;
	  
    }
	
  
}
 


    function OnGUI()
    {
        if(showGUI == true)
        {
            // Cursor.visible = true;
            //GUI.skin = menuSkin;
            GUI.BeginGroup(new Rect(Screen.width / 2 - 150, Screen.height / 2 - 150, 300, 150));
            GUI.Box(Rect(0, 0, 300, 300), "Crafting Guide");
            
       
        
        
            //Resources collected
            GUI.Label(Rect(10, 20, 300, 50), "Camp Fire =  9 Wood; 4 Stone");
            

            GUI.Label(Rect(10, 50, 300, 50), "Tent =  6 Wood; 2 Stone; 9 Thatch");


            GUI.Label(Rect(10, 80, 300, 50), "Water Well =  2 Wood; 5 Stone; 6 Metal");
            

            GUI.Label(Rect(10, 110, 300, 50), "Bandage =  2 Thatch");
            
            // Empty

           // GUI.Label(Rect(10, 130, 50, 50), "Pork");
         

           // GUI.Label(Rect(10, 150, 50, 50), "Bottle");
           


        GUI.Label (Rect (100, 250, 100, 40), GUI.tooltip);
        GUI.EndGroup ();
    }
}
















