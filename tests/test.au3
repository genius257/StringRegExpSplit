#include <Array.au3>
#include "../StringRegExpSplit.au3"
#include "Unit\assert.au3"

#AutoIt3Wrapper_Run_Au3Check=N

Global $expected = ['', 'a', 'b', 'c', '']
assertEquals($expected, StringRegExpSplit("abc", "(?:)"))

Global $expected = ['', 'c']
assertEquals($expected, StringRegExpSplit("abc", ".{2}"))

Global $expected = ['this', 'is a test']
assertEquals($expected, StringRegExpSplit("this is a test", "\s+", 1))

Global $expected = ['split', 'Camel', 'Case', 'Words']
assertEquals($expected, StringRegExpSplit('splitCamelCaseWords', '(?<=\w)(?=[A-Z])'))

Global $expected = ['a', 'b', 'c']
assertEquals($expected, StringRegExpSplit("abc", "(b)", 0, $PREG_SPLIT_DELIM_CAPTURE))

Global $aShard1 = ['a', 1]
Global $aShard2 = ['c', 3]
Global $expected = [$aShard1, $aShard2]
assertEquals($expected, StringRegExpSplit("abc", "(b)", 0, $PREG_SPLIT_OFFSET_CAPTURE))

Global $expected = ['0|1|2|3|4|5|6|7|8|9']
assertEquals($expected, StringRegExpSplit("0|1|2|3|4|5|6|7|8|9", "(\|)", 1, $PREG_SPLIT_DELIM_CAPTURE))

Global $expected = ['0', '|', '1|2|3|4|5|6|7|8|9']
assertEquals($expected, StringRegExpSplit("0|1|2|3|4|5|6|7|8|9", "(\|)", 2, $PREG_SPLIT_DELIM_CAPTURE))

Global $expected = ['0', '1|2|3|4|5|6|7|8|9']
assertEquals($expected, StringRegExpSplit("0|1|2|3|4|5|6|7|8|9", "\|", 2, $PREG_SPLIT_DELIM_CAPTURE))

Global $expected = ["0", "|", "|", "1||2||3||4||5||6||7||8||9"]
assertEquals($expected, StringRegExpSplit("0||1||2||3||4||5||6||7||8||9", "(\|)(\|)", 2, $PREG_SPLIT_DELIM_CAPTURE))
