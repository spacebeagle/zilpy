<ROUTINE HELLO-WORLD ()
    <TELL "Hello, Zork!" CR>
    <COND (COND_A
       <COND (COND_B <PRINTI "B">)>)>
    <RETURN T>>

<OBJECT ROOM
    (DESC "Test Room")
    (FLAGS LIGHTBIT)>

