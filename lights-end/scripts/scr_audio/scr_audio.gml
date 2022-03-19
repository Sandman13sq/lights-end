/*
*/

function SFXPlayAt(snd, x, y)
{
	if audio_is_playing(snd) {audio_stop_sound(snd);}
	return audio_play_sound(snd, 0, false);
}


