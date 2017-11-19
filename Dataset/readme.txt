--------------------------------------------------------------------------------
Description of the answer notaion
--------------------------------------------------------------------------------
expression_style_note (esn): Text file of array, storing the onset, offset 
                             and pitch of each note as well as its expression.
                             The file is attached with .expression_style_note
                             extenion.
    Example:
        (0)    (1)   (2)   (3)   (4)   (5)   (6)   (7)   (8)   (9)  (10)  (11)
        Pit     On   Dur  PreB     B     R     P     H     S    SI    SO     V    
    [    66   1.24   0.5     2     0     0     0     0     1     2     1     1]
    Pi:     pitch (MIDI number)
    On:     onset (sec.)
    Dur:    duration (sec.)
    PreB:   pre-bend
    B:      string bend (0 for none,
                         1 for bend by 1 semitone,
                         2 for bend by 2 semitone,
                         3 for bend by 3 semitone, 
                         
    R:      release  (0: none, 
                      1: release by 1 semitone,
                      2: release by 2 semitone,
                      3: release by 3 semitone)
    P:      pull-off (0: none, 
                      1: pull-off start,
                      2: pull-off stop)
    H:      hammer-on (0: none,
                       1: hammer-on start,
                       2: hammer-on stop)
    S:      legato slide (0: none,
                          1: legato slide start, 
                          2: legato slide stop, 
                
    SI:     slide in (0: none,
                      1: slide in from below,
                      2: slide in from above)
    SO:     slide out (0: none,
                       1: slide out downward,
                       2: slide out upward)
    V:      vibrato (0 for none,
                     1 for vibrato: vivrato with entext smaller or equal to 1 semitone,
                     2 for wild vibrato: vibrato with entext larger than 1 semitone)

technique_spot (ts): An array that stores all the techniques inside the clip.

    Example:
        (0)     (1)
        Time    Technique
    [   5.497   8         ]
    Time: the middle time point of this technique (sec.)
    Technique: the code of the tachnique, which is equal to the index of the technique 
               in esn file. Ex: 8 == Slide