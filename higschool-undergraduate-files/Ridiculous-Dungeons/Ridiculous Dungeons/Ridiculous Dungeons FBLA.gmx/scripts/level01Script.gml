
//creating the level
room_width = (cell_width/16) * 720;
room_height = (cell_height/16) * 720;

//setting the grid
var width = room_width div cell_width;
var height = room_height div cell_height;

//creating the grid
grid = ds_grid_create(width, height);

//create the pathfinding grid
grid_path = mp_grid_create(0, 0, width, height, cell_width, cell_height);

//fill grid with void
ds_grid_set_region(grid, 0, 0, width-1, height-1, void);


// randomize the world
//random_set_seed();
randomize();
show_debug_message(random_get_seed());
global.rand = (random_get_seed());


// create controller in the center of grid
var cx = width div 2;
var cy = height div 2;

//the player
instance_create(cx*cell_width+cell_width/2, cy*cell_height+cell_height/2, player);

//controller direction(random)
var cdir = irandom(3);

//
var odds = 1;

//repeat how many times
var repeatnum = irandom_range(500, 500);

repeat (repeatnum) {
    //place floor tile at the controller position
    grid[# cx, cy] = FLOOR;
    
    // randomize direction of the controller
    if(irandom(odds) == odds) {
        cdir = irandom(3);
    }
    
    //move the controller
    var xdir = lengthdir_x(1, cdir*90);
    var ydir = lengthdir_y(1, cdir*90);
   
    cx += xdir;
    cy += ydir;
    
    // make sure controller dont move outside the grid
    cx = clamp(cx, 1, width-2);
    cy = clamp(cy, 1, height-2);
    
} 

for (var yy = 1; yy < height-1; yy++) {
    for(var xx = 1; xx < width-1; xx++) {
        if (grid[# xx, yy] == FLOOR) {
        //check for walls in all directions
            if(grid[# xx+1, yy] != FLOOR) grid[# xx+1, yy] = wall;
            if(grid[# xx-1, yy] != FLOOR) grid[# xx-1, yy] = wall;
            if (grid[# xx, yy+1] != FLOOR) grid[# xx, yy+1] = wall;
            if (grid[# xx, yy-1] != FLOOR) grid[# xx, yy-1] = wall;
        }
    
    }

}
// drawing the level
for (var yy = 0; yy < height; yy++) {
    for (var xx = 0; xx < width; xx++) {
        if (grid[# xx, yy] == FLOOR) {
            //draw the floor
            tile_add(bc_floor, 0, 0, cell_width, cell_height, xx*cell_width, yy*cell_height, 0);
            
            //spawn objects
            var odds01 = 50;
            var odds02 = 75;
            var ex = xx*cell_width+cell_width/2;
            var ey = yy*cell_height+cell_height/2;
            //spawn enemies
                if (point_distance(ex, ey, player.x, player.y) > 100 && irandom(odds01) == odds01 ) {
                    instance_create(ex, ey, obj_enemy);     
            }
                if (point_distance(ex, ey, player.x, player.y) > 180 && irandom(odds02) == odds02) {
                    instance_create(ex, ey, obj_collect01);     
                    
            }
            
        } 
        
        else {
            mp_grid_add_cell(grid_path, xx, yy);
        }
    }
}



//retreive tile size
var tw = cell_width/2;
var th = cell_height/2;

// Add the tiles
for (var yy = 0; yy < height*2; yy++) {
    for (var xx = 0; xx < width*2; xx++) {
        if (grid[# xx div 2, yy div 2] == FLOOR) {
            // Get the tile's x and y
            var tx = xx*tw;
            var ty = yy*th;
            
            var right = grid[# (xx+1) div 2, yy div 2] != FLOOR;
            var left = grid[# (xx-1) div 2, yy div 2] != FLOOR;
            var top = grid[# xx div 2, (yy-1) div 2] != FLOOR;
            var bottom = grid[# xx div 2, (yy+1) div 2] != FLOOR;
            
            var top_right = grid[# (xx+1) div 2, (yy-1) div 2] != FLOOR;
            var top_left = grid[# (xx-1) div 2, (yy-1) div 2] != FLOOR;
            var bottom_right = grid[# (xx+1) div 2, (yy+1) div 2] != FLOOR;
            var bottom_left = grid[# (xx-1) div 2, (yy+1) div 2] != FLOOR;
            
            if (right) {
                if (bottom) {
                    tile_add(bg_walltiles, tw*4, th*1, tw, th, tx+tw, ty, -ty);
                } else if (top) {
                    if (top_right) {
                        tile_add(bg_walltiles, tw*4, th*0, tw, th, tx+tw, ty-th, -ty);
                    } else {
                        tile_add(bg_walltiles, tw*3, th*0, tw, th, tx, ty-th, -ty);
                    }
                    tile_add(bg_walltiles, tw*0, th*1, tw, th, tx+tw, ty, -ty);
                } else {
                    tile_add(bg_walltiles, tw*0, th*1, tw, th, tx+tw, ty, -ty);
                }
            }
            
            if (left) {
                if (bottom) {
                    tile_add(bg_walltiles, tw*3, th*1, tw, th, tx-tw, ty, -ty);
                } else if (top) {
                    if (top_left) {
                        tile_add(bg_walltiles, tw*3, th*0, tw, th, tx-tw, ty-th, -ty);
                    } else {
                        tile_add(bg_walltiles, tw*4, th*0, tw, th, tx, ty-th, -ty);
                    }
                    tile_add(bg_walltiles, tw*2, th*1, tw, th, tx-tw, ty, -ty);
                } else {
                    tile_add(bg_walltiles, tw*2, th*1, tw, th, tx-tw, ty, -ty);
                }
            }
            
            if (top) {
                if (!top_right) {
                    tile_add(bg_walltiles, tw*2, th*2, tw, th, tx, ty-th, -ty);
                } else if (!top_left) {
                    tile_add(bg_walltiles, tw*0, th*2, tw, th, tx, ty-th, -ty);
                } else {
                    tile_add(bg_walltiles, tw*1, th*2, tw, th, tx, ty-th, -ty);
                }
            }
            
            if (bottom) {
                if (!bottom_right) {
                    tile_add(bg_walltiles, tw*2, th*0, tw, th, tx, ty, -ty-tw);
                } else if (!bottom_left) {
                    tile_add(bg_walltiles, tw*0, th*0, tw, th, tx, ty, -ty-tw);
                } else {
                    tile_add(bg_walltiles, tw*1, th*0, tw, th, tx, ty, -ty-tw);
                }
            }
        }
    }
}









