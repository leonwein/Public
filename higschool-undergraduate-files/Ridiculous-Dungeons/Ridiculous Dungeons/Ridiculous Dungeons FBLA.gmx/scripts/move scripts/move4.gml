//move
if(room == level2) {
var hspd = argument[0];
var vspd = argument[1];

if (grid_place_meeting_04(x+hspd, y)) {
    while(!grid_place_meeting_04(x+sign(hspd), y)) {
        x+=sign(hspd);
    }
    hspd = 0;
}

//horizontal movement
x+=hspd;

if (grid_place_meeting_04(x, y+vspd)) {
    while(!grid_place_meeting_04(x, y+sign(vspd))) {
        y+=sign(vspd);
    }
    vspd = 0;
}


//vertical movement
y+=vspd
}
