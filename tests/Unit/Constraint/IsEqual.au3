#include-once
;https://github.com/sebastianbergmann/phpunit/blob/master/src/Framework/Constraint/IsEqual.php
;shallow implementation

Func Au3UnitConstraintIsEqual_Matches($other, $exspected)
	If Not (VarGetType($other) == VarGetType($exspected)) Then Return False
	If IsString($other) Then Return $exspected == $other
	If IsArray($other) Then
		;Return UBound($other, 0) = UBound($exspected, 0)

		Local $count = 0
		Local $i
		Local $index[UBound($other, 0)]
		Local $val
		For $i = 0 To UBound($index)-1
			$index[$i] = 0
		Next

		While 1
			$val1 = Execute(StringFormat("$other[%s]", _ArrayToString($index, "][")))
			If @error <> 0 Then Return False
			$val2 = Execute(StringFormat("$exspected[%s]", _ArrayToString($index, "][")))
			If @error <> 0 Then Return False
			If Not Au3UnitConstraintIsEqual_Matches($val1, $val2) Then Return False

			Local $innerIndex = UBound($index, 1)
			While 1
				$innerIndex-=1
				If $innerIndex < 0 Then ExitLoop
				$index[$innerIndex] += 1
				If Not ($index[$innerIndex] >= UBound($other, $innerIndex + 1)) Then
					ExitLoop
				EndIf
				If $innerIndex = 0 And $index[$innerIndex] = UBound($other, 1) Then ExitLoop 2
				$index[$innerIndex] = 0
			WEnd

			$count += 1
		WEnd

		Return True
	EndIf
	Return $other = $exspected
EndFunc

Func Au3UnitConstraintIsEqual_ToString($a)
	Return StringFormat("is equal to %s", $a)
EndFunc
#cs
#include <Array.au3>

Dim $aArray[3][1][2] = [[['a','a1']],[['b','b1']],[['c','c1']]]

$count = 0
Dim $index[UBound($aArray, 0)]
For $i = 0 To UBound($index)-1
	$index[$i] = 0
Next

While 1
	ConsoleWrite($index[0])

	$val = Execute(StringFormat("$aArray[%s]", _ArrayToString($index, "][")))
	ConsoleWrite(StringFormat('index: [%s] = %s', _ArrayToString($index, "]["), $val)&@CRLF)

	$innerIndex = UBound($index, 1)
	While 1
		$innerIndex-=1
		If $innerIndex < 0 Then ExitLoop
		$index[$innerIndex] += 1
		If Not ($index[$innerIndex] >= UBound($aArray, $innerIndex + 1)) Then
			ExitLoop
		EndIf
		If $innerIndex = 0 And $index[$innerIndex] = UBound($aArray, 1) Then ExitLoop 2
		$index[$innerIndex] = 0
	WEnd

	$count += 1
WEnd
#ce