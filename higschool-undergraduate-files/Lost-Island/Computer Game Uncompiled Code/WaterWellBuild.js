#pragma strict

var waterwellPrefab : Transform;
var player : GameObject;

private var canBuild : boolean = true;
var check6 : GameObject;
private var inventory : Inv;
var BtoB : GameObject;

function Start()
{
    GetComponent.<Renderer>().material.color = Color.green;
    GetComponent.<Renderer>().material.color.a = 0.5;
    inventory = GameObject.Find("FPSController").GetComponent(Inv);
}

function OnTriggerEnter(Col : Collider)
    {
        if(Col.gameObject.tag == "Terrain" || Col.gameObject.tag == "Tree") 

        {
            GetComponent.<Renderer>().material.color = Color.red;
            GetComponent.<Renderer>().material.color.a = 0.5;
            canBuild = false;
        }
    }


    function OnTriggerExit(Col : Collider)
        {
            if(Col.gameObject.tag == "Terrain" || Col.gameObject.tag == "Tree") 

            {
                GetComponent.<Renderer>().material.color = Color.green;
                GetComponent.<Renderer>().material.color.a = 0.5;
                canBuild = true;
            }
        }


        function Update()
        {
            if(Input.GetKeyDown("b") && canBuild == true)
            {
                
                Instantiate(waterwellPrefab, player.transform.position + Vector3(0, 0, 10), Quaternion.identity);
                player.GetComponent(Crafting).waterWell.SetActive(false);
                
                check6.SetActive(true);
                inventory.waterwellCount ++;
                BtoB.SetActive(false);
               
            }
        }