if(room == level7) {
var xx = argument[0];
var yy = argument[1];

//check for position
var xp = x;
var yp = y;

x = xx;
y = yy;

var x_meeting = (level07.grid[# bbox_right div cell_width, bbox_top div cell_height] != FLOOR) || 
                (level07.grid[# bbox_left div cell_width, bbox_top div cell_height] != FLOOR);
                
var y_meeting = (level07.grid[# bbox_right div cell_width, bbox_bottom div cell_height] != FLOOR) || 
                (level07.grid[# bbox_left div cell_width, bbox_bottom div cell_height] != FLOOR);
                
var center_meeting = level07.grid[# xx div cell_width, yy div cell_height] != FLOOR;
                
//move back
x = xp;
y = yp;

return x_meeting || y_meeting || center_meeting;
}
