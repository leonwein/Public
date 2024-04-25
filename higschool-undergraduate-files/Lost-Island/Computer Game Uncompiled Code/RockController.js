#pragma strict

var rockHealth : int = 8;

var stone : Transform;
var rock : GameObject;

var speed : int = 8;

function Start ()
{
    rock = this.gameObject;
    GetComponent.<Rigidbody>().isKinematic = true;

}

function Update()
{
    if(rockHealth <=0)
    {
        GetComponent.<Rigidbody>().isKinematic = false;
        GetComponent.<Rigidbody>().AddForce(transform.forward * speed);
        Destroyrock();

    }
}

function Destroyrock()
{
    yield WaitForSeconds(1);
    Destroy(rock);

    var position : Vector3 = Vector3(Random.Range(-1.0, 1.0), 0, Random.Range(-1.0, 1.0));
    Instantiate(stone, rock.transform.position + Vector3(0,0,0) + position, Quaternion.identity);
    Instantiate(stone, rock.transform.position + Vector3(0,0,3) + position, Quaternion.identity);
    Instantiate(stone, rock.transform.position + Vector3(0,0,6) + position, Quaternion.identity);
    Instantiate(stone, rock.transform.position + Vector3(2,0,9) + position, Quaternion.identity);
    Instantiate(stone, rock.transform.position + Vector3(2,0,12) + position, Quaternion.identity);
    Instantiate(stone, rock.transform.position + Vector3(2,0,15) + position, Quaternion.identity);


}