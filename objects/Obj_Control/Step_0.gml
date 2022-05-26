DELTATIME = (timeScale/room_speed)*((room_speed/1000000)*delta_time);

//Cap deltatime.
if(DELTATIME > 0.15)
{
    DELTATIME = 0.15;
}
