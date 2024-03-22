//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 09/13/05, 16:19:52
	// ----------------------------------------------------
	// Method: SRCP_LoadElmCat
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	Mods_2005_CM17
End if 
READ ONLY:C145([BMS Categories:49])
ARRAY TEXT:C222($aGCat; 0)  //Command Replaced was o_ARRAY string length was 36
ARRAY TEXT:C222($aSCat; 0)  //Command Replaced was o_ARRAY string length was 36
ARRAY BOOLEAN:C223($abSmartFlag; 0)
ARRAY INTEGER:C220(cboPontisElemCatCod; 0)
C_LONGINT:C283($i; $NumCats; $k)
QUERY:C277([BMS Categories:49]; [BMS Categories:49]Smart Flag:5=False:C215)
ORDER BY:C49([BMS Categories:49]; [BMS Categories:49]Category ID:1)
SELECTION TO ARRAY:C260([BMS Categories:49]Category ID:1; cboPontisElemCatCod; [BMS Categories:49]General Cat:2; $aGCat; [BMS Categories:49]Subcategory:3; $aSCat; [BMS Categories:49]Smart Flag:5; $abSmartFlag)
$NumCats:=Size of array:C274(cboPontisElemCatCod)
ARRAY TEXT:C222(cboPontisElemCat; ($NumCats+2))  //Command Replaced was o_ARRAY string length was 80
For ($i; 1; $NumCats)
	cboPontisElemCat{$i+1}:=$aGCat{$i}
	If ($aSCat{$i}#"")
		cboPontisElemCat{$i+1}:=cboPontisElemCat{$i+1}+" - "+$aSCat{$i}
	End if 
	
End for 
INSERT IN ARRAY:C227(cboPontisElemCatCod; (Size of array:C274(cboPontisElemCatCod)+1))
cboPontisElemCat{$NumCats+2}:="Smart Flags"
cboPontisElemCatCod{$NumCats+1}:=-1
INSERT IN ARRAY:C227(cboPontisElemCatCod; 1)
cboPontisElemCat{1}:="All Elements"
cboPontisElemCatCod{1}:=0