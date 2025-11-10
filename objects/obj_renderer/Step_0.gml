if(ring_active){
	ring_radius += 3;
	ring_cooldown = 0;
	
	if(ring_radius > ring_max){
		ring_active = false;
		ring_radius = 0;
	}
	
} else if(ring_cooldown > 0){
	ring_cooldown--;
}