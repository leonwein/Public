#pragma strict

//tag 1 - BushFull
//tag 2 - BushEmpty

var rockTaken : boolean = false;

var rock : GameObject;

var rockTimer : float = 5;

function Update()
{
    if(rockTaken == true)
    {
        rock.active = false;
        rockTimer -= Time.deltaTime;
        this.gameObject.tag = "rock";
    }
	
    if(rockTimer <= 0)
    {
        rock.active = true;
        rockTaken = false;
        this.gameObject.tag = "rock";
        rockTimer = 5;
    }
}