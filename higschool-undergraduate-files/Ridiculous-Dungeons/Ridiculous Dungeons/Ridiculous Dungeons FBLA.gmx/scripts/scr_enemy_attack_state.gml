
    if(attacked_enemy == false) {
        instance_create(player.x, player.y, obj_enemy_damage);
        attacked_enemy = true;
        player.image_blend = c_red;
        alarm[2] = 10;
        alarm[1] = 50;
    }


