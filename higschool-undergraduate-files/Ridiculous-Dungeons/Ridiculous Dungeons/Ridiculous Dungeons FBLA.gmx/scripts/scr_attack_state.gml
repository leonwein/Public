///scr_attack_state
image_speed = .5;

switch (sprite_index) {
    case spr_plyr_down: 
        sprite_index = spr_plyr_attack_down;
        break;
        
    case spr_plyr_up:
        sprite_index = spr_plyr_attack_up;
        break;
        
     case spr_plyr_left:
        sprite_index = spr_plyr_attack_left;
        break;
        
      case spr_plyr_right:
        sprite_index = spr_plyr_attack_right;
        break;
}
if (image_index >= 3 && attacked == false) {
    instance_create(player.x, player.y, obj_damage);

    attacked = true;
}


