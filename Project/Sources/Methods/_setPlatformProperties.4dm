//%attributes = {}
//$OldExp:="_O_PLATFORM PROPERTIES:C365"

//ARRAY TEXT($arrMethodPaths; 0)
//ARRAY TEXT($arrMethodCodeLines; 0)
//METHOD GET PATHS(Path all objects; $arrMethodPaths)

//$CurrentPath:=METHOD Get path(Path project method; Current method name)
//$position:=Find in array($arrMethodPaths; $CurrentPath)
//If ($position>0)
//DELETE FROM ARRAY($arrMethodPaths; $position)
//End if 
//$ExportWithToken:=Num(True)


//For ($MethodCounter; 1; Size of array($arrMethodPaths))

//METHOD GET CODE($arrMethodPaths{$MethodCounter}; $MethodCode; $ExportWithToken)
//_Get_ArrayFromText($MethodCode; ->$arrMethodCodeLines; "\r"; True)
//$ModifiedCode:=False
//For ($rowCount; 1; Size of array($arrMethodCodeLines))
//If (Position($OldExp; $arrMethodCodeLines{$rowCount})>0)
//$ModifiedCode:=True
//$arrMethodCodeLines{$rowCount}:=Replace string($arrMethodCodeLines{$rowCount}; Char(Tab); "")
//$arrMethodCodeLines{$rowCount}:=Replace string($arrMethodCodeLines{$rowCount}; ":C365"; "")
//$arrMethodCodeLines{$rowCount}:="//"+$arrMethodCodeLines{$rowCount}+"// MassDOT_PS - conversion v19R7"
//End if 
//End for 

//If ($ModifiedCode)
//$newCode:=_Set_ArrayInText(->$arrMethodCodeLines; "\r")
//METHOD SET CODE($arrMethodPaths{$MethodCounter}; $newCode)
//End if 
//End for 

//ALERT("Done")