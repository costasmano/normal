//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): administrator
//Date and time: 11/19/15, 16:00:12
//----------------------------------------------------
//Method: ut_CreateXMLfromtableExample
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2015_11  // 
	//Modified by: administrator (11/19/15 16:00:14)
	
End if 

C_TEXT:C284($OutPut_txt; $Start_txt; $End_txt; $FieldName_txt)
$OutPut_txt:=""
C_LONGINT:C283($TableLoop_l; $FieldLoop_l)
C_TIME:C306($d)

For ($TableLoop_l; 1; Get last table number:C254)
	If (Is table number valid:C999($TableLoop_l))
		If (Table name:C256($TableLoop_l)="NTI_TunnelInfo")
			
			For ($FieldLoop_l; 1; Get last field number:C255($TableLoop_l))
				If (Is field number valid:C1000($TableLoop_l; $FieldLoop_l))
					$FieldName_txt:=Field name:C257($TableLoop_l; $FieldLoop_l)
					$Start_txt:=Replace string:C233($FieldName_txt; "NTI_"; "")
					$Start_txt:=Replace string:C233($Start_txt; "_s"; "")
					$Start_txt:=Replace string:C233($Start_txt; "_r"; "")
					$Start_txt:=Replace string:C233($Start_txt; "_L"; "")
					$Start_txt:=Replace string:C233($Start_txt; "_B"; "")
					$Start_txt:=Replace string:C233($Start_txt; "_d"; "")
					$End_txt:="</"+$Start_txt+">"
					$Start_txt:="<"+$Start_txt+">"
					$OutPut_txt:=$OutPut_txt+Uppercase:C13($Start_txt)+"<!--#4DVAR [NTI_TunnelInfo]"+$FieldName_txt+"-->"+Uppercase:C13($End_txt)+Char:C90(Carriage return:K15:38)
				End if 
			End for 
			$TableLoop_l:=Get last table number:C254+1
		End if 
	End if 
End for 

$D:=Create document:C266("")
SEND PACKET:C103($d; $OutPut_txt)
CLOSE DOCUMENT:C267($d)
//End ut_CrdateXMLfromtableExample

