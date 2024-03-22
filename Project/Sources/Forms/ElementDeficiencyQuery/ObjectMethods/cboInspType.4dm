//Method: ElementDeficiencyQuery.cboInspType
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 12/13/18, 11:51:28
	// ----------------------------------------------------
	//Created : 
	Mods_2018_12
End if 
//
C_TEXT:C284($Search_txt)
$Search_txt:=cboInspType{cboInspType}
ARRAY LONGINT:C221(v_163_002_aL; 0)
If ($Search_txt="ALL")
	COPY ARRAY:C226(v_162_002_atxt; cboElem)
	COPY ARRAY:C226(v_162_001_aL; v_163_002_aL)
Else 
	C_LONGINT:C283($Pos_L; $Start_L)
	ARRAY TEXT:C222(cboElem; 0)
	CLEAR VARIABLE:C89(cboElem)
	ARRAY LONGINT:C221(v_163_002_aL; 0)
	CLEAR VARIABLE:C89(v_163_002_aL)
	$Start_L:=1
	Repeat 
		$Pos_L:=Find in array:C230(LSS_Headers_atxt; $Search_txt; $Start_L)
		If ($Pos_L>0)
			APPEND TO ARRAY:C911(cboElem; v_162_002_atxt{$Pos_L})
			APPEND TO ARRAY:C911(v_163_002_aL; v_162_001_aL{$Pos_L})
			$Start_L:=$Pos_L+1
		End if 
	Until ($Pos_L<1)
End if 
$Start_L:=0
C_LONGINT:C283($pos1_L)
Repeat 
	$Pos_L:=Find in array:C230(cboElem; "@Blank Element"; $Start_L)
	If ($Pos_L>0)
		//$Start_L:=$Pos_L+1
		//ARRAY TEXT($Parts_atxt;0)
		//CLEAR VARIABLE($Parts_atxt)
		//$pos1_L:=Position(" ";cboElem{$Pos_L})
		//cboElem{$Pos_L}:=Substring(cboElem{$Pos_L};1;$Pos1_L)+" Blank Element"
		DELETE FROM ARRAY:C228(cboElem; $Pos_L; 1)
		DELETE FROM ARRAY:C228(v_163_002_aL; $Pos_L; 1)
	End if 
	
Until ($Pos_L<1)
OBJECT SET ENABLED:C1123(*; "FindButton"; LSS_EditCheckDefQRY)

//End ElementDeficiencyQuery.cboInspType