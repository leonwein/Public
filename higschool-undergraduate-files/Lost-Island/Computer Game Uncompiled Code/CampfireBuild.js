#pragma strict

var campfirePrefab : Transform;
var player : GameObject;
var check5 : GameObject;

private var canBuild : boolean = true;
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
                Instantiate(campfirePrefab, player.transform.position + Vector3(0, 0, 5), Quaternion.identity);
                player.GetComponent(Crafting).campFire.SetActive(false);
                check5.SetActive(true);
                inventory.campfireCount ++;
                BtoB.SetActive(false);
            }
        }