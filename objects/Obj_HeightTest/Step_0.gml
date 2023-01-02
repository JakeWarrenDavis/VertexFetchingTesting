/// @description Insert description here
// You can write your code in this editor




if(keyboard_check(vk_up))
{
	x += 15*DELTATIME;
}

if(keyboard_check(vk_down))
{
	x -= 15*DELTATIME;
}

if(keyboard_check(vk_left))
{
	y -= 15*DELTATIME;
}

if(keyboard_check(vk_right))
{
	y += 15*DELTATIME;
}