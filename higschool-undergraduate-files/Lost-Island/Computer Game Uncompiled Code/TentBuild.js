#pragma strict

var tentPrefab : Transform;
var player : GameObject;
var check7 : GameObject;
var BtoB : GameObject;

private var canBuild : boolean = true;
private var inventory : Inv;

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
                Instantiate(tentPrefab, player.transform.position + Vector3(10, 0, 10), Quaternion.identity);
                player.GetComponent(Crafting).tent.SetActive(false);
                check7.SetActive(true);
                inventory.i = true;
                BtoB.SetActive(false);
            }
        }