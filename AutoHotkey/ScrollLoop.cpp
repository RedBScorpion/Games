$Space::
    Sleep 1
    Loop
    {
        GetKeyState, SpaceState, Space, P
        If SpaceState = U
            break
        Sleep 0.5
        Send, {Blind}{WheelDown 1}
    }
Return
