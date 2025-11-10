function create_afterimage(spr_index, opacity){
	var afterimage = instance_create_layer(x, y, "Instances", obj_afterimage);
	afterimage.sprite_index = spr_index;
	afterimage.image_alpha = opacity;
	afterimage.lifetime = 20;
}
