#pragma strict

var rayLength : int = 5;

private var treeScript : TreeController;
private var rockScript : RockController;
private var metalScript : MetalController;
private var pigScript : PigController;
private var enemyScript : enemyController;

var count : int = 0;

function Update()
{
    var  hit : RaycastHit;
    var fwd = transform.TransformDirection(Vector3.forward);

    if(Physics.Raycast(transform.position, fwd, hit, rayLength))
    {
        if(hit.collider.gameObject.tag == "Tree")
        {
            treeScript = GameObject.Find(hit.collider.gameObject.name).GetComponent(TreeController);
          

            if(Input.GetButtonDown("Fire1") == true)
            {
                print("eagle has landed");
                treeScript.treeHealth -=1;
                
                if(treeScript.treeHealth == 0)
                {
                   // yield WaitForSeconds(5);
                    count++;
                    
                }
            }
        }




        if(hit.collider.gameObject.tag == "rock")
        {
            rockScript = GameObject.Find(hit.collider.gameObject.name).GetComponent(RockController);
          

            if(Input.GetButtonDown("Fire1") == true)
            {
                print("eagle has landed");
                rockScript.rockHealth -=1;
                
            }
        }



        if(hit.collider.gameObject.tag == "metal")
        {
            metalScript = GameObject.Find(hit.collider.gameObject.name).GetComponent(MetalController);
          

            if(Input.GetButtonDown("Fire1") == true)
            {
                print("eagle has landed");
                metalScript.metalHealth -=1;
                
            }
        }

        if(hit.collider.gameObject.tag == "pig")
        {
            pigScript = GameObject.Find(hit.collider.gameObject.name).GetComponent(PigController);
            Debug.Log("It knows the Script");
          

            if(Input.GetButtonDown("Fire1") == true)
            {
                print("eagle has landed");
                pigScript.pigHealth -=1;
                
            }
        }

        if(hit.collider.gameObject.tag == "enemy")
        {
            enemyScript = GameObject.Find(hit.collider.gameObject.name).GetComponent(enemyController);
            Debug.Log("It knows the Script");
          

            if(Input.GetButtonDown("Fire1") == true)
            {
                print("eagle has landed");
                enemyScript.enemyHealth -=1;
                
            }
        }



    }
}

