//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 08/15/13, 10:30:26
//----------------------------------------------------
//Method: ut_DocumentIndexedandUnique
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2013_08  //r001 ` 
	//Modified by: Charles Miller (8/15/13 10:30:28)
	
End if 

C_TEXT:C284($Structure_txt; $Folder_txt)
$Structure_txt:=Structure file:C489
C_LONGINT:C283($UniqueFldNumber_l; $UniqueFldNumber_l; $TableNumber_l; $Length_l; $Type_l; $FieldLoop_l)

C_TEXT:C284($Variable_txt; $Report_txt; $Indexed_txt)
C_LONGINT:C283($UniqueCount_l)

C_BOOLEAN:C305($Indexed_b; $Unique_b; $Invisible_b)
For ($TableNumber_l; 1; Get last table number:C254)
	$UniqueCount_l:=0
	If (Is table number valid:C999($TableNumber_l))
		$UniqueFldNumber_l:=-1
		
		For ($FieldLoop_l; 1; Get last field number:C255($TableNumber_l))
			If (Is field number valid:C1000($TableNumber_l; $FieldLoop_l))
				GET FIELD PROPERTIES:C258($TableNumber_l; $FieldLoop_l; $Type_l; $Length_l; $Indexed_b; $Unique_b; $Invisible_b)
				$Indexed_txt:=String:C10($Indexed_b)
				If ($Unique_b)
					$UniqueCount_l:=$UniqueCount_l+1
					$Report_txt:=$Report_txt+String:C10($TableNumber_l)+Char:C90(Tab:K15:37)+Table name:C256($TableNumber_l)+Char:C90(Tab:K15:37)+Field name:C257($TableNumber_l; $FieldLoop_l)+Char:C90(Tab:K15:37)+$Indexed_txt+Char:C90(Tab:K15:37)+String:C10($UniqueCount_l)+Char:C90(Carriage return:K15:38)
				Else 
					//If ($Indexed_b)
					//$Report_txt:=$Report_txt+String($TableNumber_l)+Char(Tab)+Table name($TableNumber_l)+Char(Tab)+Field name($TableNumber_l;$FieldLoop_l)+Char(Tab)+$Indexed_txt+Char(Carriage return)
					//End if 
				End if 
			End if 
		End for 
	End if 
End for 
C_TIME:C306($doc)
$Folder_txt:=Select folder:C670("")
$Structure_txt:=Replace string:C233($Structure_txt; ".4DB"; ".txt")
$Folder_txt:=$Folder_txt+$Structure_txt
$doc:=Create document:C266($Folder_txt)
If (OK=1)
	SEND PACKET:C103($Doc; $Report_txt)
	CLOSE DOCUMENT:C267($doc)
End if 
//End ut_DocumentIndexedandUnique

