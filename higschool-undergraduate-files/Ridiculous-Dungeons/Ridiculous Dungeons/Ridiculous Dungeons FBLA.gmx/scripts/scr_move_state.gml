///scr_move_state
scr_get_input();



if(attack_key) {
    image_index = 0;
    state = scr_attack_state;
}



if (d_key) {
    sprite_index = spr_plyr_right;
    image_speed = .2;
}

if (a_key) {
    sprite_index = spr_plyr_left;
    image_speed = .2;
}

if (w_key) {
    sprite_index = spr_plyr_up;
    image_speed = .2;
}

if (s_key) {
    sprite_index = spr_plyr_down;
    image_speed = .2;
}

//animation stop on key release
if (!s_key and !d_key and !a_key and !w_key) {
    image_speed = 0;
    image_index = 0;
}

