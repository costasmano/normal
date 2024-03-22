//%attributes = {"shared":true}
// ----------------------------------------------------
// PRJ_QR_ReturnAttributes
// User name (OS): charlesmiller
// Date and time: 12/24/08, 14:01:50
// ----------------------------------------------------
// Description
// 
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	//CJM `r005    `12/24/08, 14:01:52 `Add change log records
End if 
C_TEXT:C284($0)
$0:=""
If (Records in selection:C76([PRJ_ProjectFile:117])=0)
	
Else 
	QUERY:C277([PRJ_ATTRFileNoXrefs:131]; [PRJ_ATTRFileNoXrefs:131]PF_FileNumber_l:2=[PRJ_ProjectFile:117]PF_FileNumber_l:3)
	If (Records in selection:C76([PRJ_ATTRFileNoXrefs:131])=0)
	Else 
		C_TEXT:C284($Separator_txt)
		$Separator_txt:=","
		If (Count parameters:C259=1)
			C_TEXT:C284($1)
			$Separator_txt:=$1
		Else 
			
		End if 
		ARRAY LONGINT:C221($AttributeIDS_al; 0)
		
		SELECTION TO ARRAY:C260([PRJ_ATTRFileNoXrefs:131]ATTR_ID_l:1; $AttributeIDS_al)
		QUERY WITH ARRAY:C644([PRJ_Attributes:130]ATTR_ID_l:1; $AttributeIDS_al)
		ARRAY TEXT:C222($AttributeName_as; 0)  //Command Replaced was o_ARRAY string length was 65
		SELECTION TO ARRAY:C260([PRJ_Attributes:130]ATTR_Name_s:2; $AttributeName_as)
		C_LONGINT:C283($Loop_l)
		For ($Loop_l; 1; Size of array:C274($AttributeName_as))
			If ($Loop_l=Size of array:C274($AttributeName_as))
				$0:=$0+$AttributeName_as{$Loop_l}
			Else 
				$0:=$0+$AttributeName_as{$Loop_l}+$Separator_txt
			End if 
		End for 
	End if 
	
End if 
//End PRJ_QR_ReturnAttributes