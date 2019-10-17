#include <Array.au3>

_ArrayDisplay( _
    StringRegExpSplit("abc", "(?:)", 0) _
)

_ArrayDisplay( _
    StringRegExpSplit("abc", ".{2}", 0) _
)

_ArrayDisplay( _
    StringRegExpSplit("this is a test", "\s+", 1) _
)