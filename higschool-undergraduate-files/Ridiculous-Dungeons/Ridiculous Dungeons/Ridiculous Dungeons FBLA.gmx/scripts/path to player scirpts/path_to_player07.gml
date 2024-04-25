
//path_to_player
if(room == level7) {
    if(instance_exists(player)) {
        
    
        var xx = (player.x div cell_width)*cell_width+cell_width/2;
        var yy = (player.y div cell_height)*cell_height+cell_height/2;
    
   
     
    
        if (mp_grid_path(level07.grid_path, path, x, y, xx, yy, true)) {
            path_start(path, 1, path_action_stop, true);
        }
    }
}
    
