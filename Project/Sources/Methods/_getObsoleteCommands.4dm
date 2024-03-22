//%attributes = {}
////get obsolete lines
//$text:=""
//ARRAY TEXT($arrMethodPaths; 0)
//METHOD GET PATHS(Path all objects; $arrMethodPaths)

//SORT ARRAY($arrMethodPaths)

//$compare:="@_O_@"
//ARRAY TEXT($methods; 0)
//ARRAY TEXT($obsoleteLines; 0)
//$ExportWithToken:=Num(True)

//For ($MethodCounter; 1; Size of array($arrMethodPaths))
//ARRAY TEXT($arrMethodCodeLines; 0)
//$MethodCode:=""
//METHOD GET CODE($arrMethodPaths{$MethodCounter}; $MethodCode; $ExportWithToken)
//$obsolete:="\\"+Char(Carriage return)
//$MethodCode:=Replace string($MethodCode; $obsolete; "")
//If ($MethodCode=$compare)
//_Get_ArrayFromText($MethodCode; ->$arrMethodCodeLines; "\r"; True)
//$add:=False
//$rowCount:=1
//$continue:=True
//While ($continue)
//$arrMethodCodeLines{$rowCount}:=Replace string($arrMethodCodeLines{$rowCount}; Char(Tab); "")
//If ($arrMethodCodeLines{$rowCount}="_O_@")
//APPEND TO ARRAY($obsoleteLines; $arrMethodCodeLines{$rowCount})
//End if 
//If ($rowCount>=Size of array($arrMethodCodeLines))
//$continue:=False
//End if 
//$rowCount:=$rowCount+1
//End while 

//End if 

//End for 
//SORT ARRAY($obsoleteLines)
//For ($i; 1; Size of array($obsoleteLines))
//$text:=$text+$obsoleteLines{$i}+Char(Carriage return)
//End for 
//SET TEXT TO PASTEBOARD($text)
//TRACE