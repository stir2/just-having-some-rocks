function scr_draw_hitbox(spr, frame, xx, yy, col, alp){

var w = sprite_get_width(spr);
var h = sprite_get_height(spr);
var buff = sprite_get_pixeldata(spr, frame);

draw_set_color(col);
draw_set_alpha(alp);

for (var j = 0; j < h; j++) {
    for (var i = 0; i < w; i++) {
        var a = buffer_peek(buff, (j * w + i) * 4 + 3, buffer_u8); // alpha channel
        if (a > 128) {
            // Check neighbor transparency — if any neighbor is transparent, this is an edge pixel
            var edge = false;
            for (var dj = -1; dj <= 1 && !edge; dj++)
            for (var di = -1; di <= 1 && !edge; di++) {
                var ni = i + di, nj = j + dj;
                if (ni >= 0 && nj >= 0 && ni < w && nj < h) {
                    var a2 = buffer_peek(buff, (nj * w + ni) * 4 + 3, buffer_u8);
                    if (a2 < 128) edge = true;
                }
            }
            if (edge) draw_point(xx + i - sprite_get_xoffset(spr), yy + j - sprite_get_yoffset(spr));
        }
    }
}
buffer_delete(buff);
draw_set_alpha(1);
draw_set_color(c_white);
}