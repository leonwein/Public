if(room == level9) {
var xx = argument[0];
var yy = argument[1];

//check for position
var xp = x;
var yp = y;

x = xx;
y = yy;

var x_meeting = (level09.grid[# bbox_right div cell_width, bbox_top div cell_height] != FLOOR) || 
                (level09.grid[# bbox_left div cell_width, bbox_top div cell_height] != FLOOR);
                
var y_meeting = (level09.grid[# bbox_right div cell_width, bbox_bottom div cell_height] != FLOOR) || 
                (level09.grid[# bbox_left div cell_width, bbox_bottom div cell_height] != FLOOR);
                
var center_meeting = level09.grid[# xx div cell_width, yy div cell_height] != FLOOR;
                
//move back
x = xp;
y = yp;

return x_meeting || y_meeting || center_meeting;
}
