//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 12/20/11, 15:56:37
//----------------------------------------------------
//Method: ut_DocumentUniqueKeys
//Description
//This method will create a text file cotaining table number, table name, unique key name
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2011_12  //
	//Modified by: Charles Miller (12/20/11 15:56:38)
	Mods_2013_01  //r001 ` Change way ut_ReturnKeyFldandVariable is called by adding reindex boolean as 5th parameter
	//It should only be passed as true if re-index will occur later using KeysToReset_aptr array
	//Modified by: Charles Miller (2/5/13 12:24:07)
End if 
C_LONGINT:C283($UniqueFldNumber_l; $UniqueFldNumber_l; $TableNumber_l; $Length_l; $Type_l; $FieldLoop_l)

C_TEXT:C284($Variable_txt; $Report_txt)
C_LONGINT:C283($UniqueCount_l)

C_BOOLEAN:C305($Indexed_b; $Unique_b; $Invisible_b)
For ($TableNumber_l; 1; Get last table number:C254)
	$UniqueCount_l:=0
	If (Is table number valid:C999($TableNumber_l))
		$UniqueFldNumber_l:=-1
		
		For ($FieldLoop_l; 1; Get last field number:C255($TableNumber_l))
			If (Is field number valid:C1000($TableNumber_l; $FieldLoop_l))
				GET FIELD PROPERTIES:C258($TableNumber_l; $FieldLoop_l; $Type_l; $Length_l; $Indexed_b; $Unique_b; $Invisible_b)
				If ($Unique_b)
					$UniqueCount_l:=$UniqueCount_l+1
					$Report_txt:=$Report_txt+String:C10($TableNumber_l)+Char:C90(Tab:K15:37)+Table name:C256($TableNumber_l)+Char:C90(Tab:K15:37)+Field name:C257($TableNumber_l; $FieldLoop_l)+Char:C90(Tab:K15:37)
					If ($UniqueCount_l=1)
						$Report_txt:=$Report_txt+Char:C90(Carriage return:K15:38)
					Else 
						$Report_txt:=$Report_txt+String:C10($UniqueCount_l)+Char:C90(Carriage return:K15:38)
					End if 
					
				End if 
			End if 
		End for 
	End if 
End for 
C_TIME:C306($doc)

$doc:=Create document:C266("")
If (OK=1)
	SEND PACKET:C103($Doc; $Report_txt)
	CLOSE DOCUMENT:C267($doc)
End if 
//End ut_DocumentUniqueKeys

