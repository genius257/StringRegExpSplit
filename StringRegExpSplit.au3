#include <Math.au3>

Global Enum Step *2 $PREG_SPLIT_NONE = 0, $PREG_SPLIT_NO_EMPTY = 1, $PREG_SPLIT_DELIM_CAPTURE, $PREG_SPLIT_OFFSET_CAPTURE

;FIXME: either support PREG_SPLIT_OFFSET_CAPTURE or remove the flag

Func StringRegExpSplit($sString, $sPattern, $iLimit = 0, $iFlags = $PREG_SPLIT_NONE)
    Local $iPrevOffset = 1, $iOffset = 1, $aMatches, $aReturn[0], $i, $sValue, $iCount = 0
    While 1
        If $iLimit > 0 And $iCount >= $iLimit Then ExitLoop
        $aMatches = StringRegExp($sString, $sPattern, 2, $iOffset)
        If @error Or @extended = 0 Then ExitLoop
        $iOffset = @extended
        
        $sValue = StringMid($sString, $iPrevOffset, $iOffset - StringLen($aMatches[0]) - $iPrevOffset)
        If (Not BitAND($PREG_SPLIT_NO_EMPTY, $iFlags)) Or (Not $sValue = "") Then
            ReDim $aReturn[UBound($aReturn, 1) + 1]
            $aReturn[UBound($aReturn, 1) - 1] = $sValue
        EndIf
        If BitAND($PREG_SPLIT_DELIM_CAPTURE, $iFlags) Then
            For $i = 1 To UBound($aMatches, 1) - 1
                ReDim $aReturn[UBound($aReturn, 1) + 1]
                $aReturn[UBound($aReturn, 1) - 1] = $aMatches[$i]
            Next
        EndIf
        $iPrevOffset = $iOffset
        $iCount += 1
        If StringLen($aMatches[0]) = 0 Then $iOffset += 1
    WEnd

    $sValue = StringMid($sString, $iOffset)
    If (Not BitAND($PREG_SPLIT_NO_EMPTY, $iFlags)) Or (Not $sValue == "") Then
        ReDim $aReturn[UBound($aReturn, 1) + 1]
        $aReturn[UBound($aReturn, 1) - 1] = $sValue
    EndIf

    If $iLimit < 0 Then
        ReDim $aReturn[_Max(UBound($aReturn, 1) + $iLimit, 0)]
    EndIf

    Return $aReturn
EndFunc