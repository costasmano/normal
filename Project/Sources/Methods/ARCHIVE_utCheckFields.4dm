//%attributes = {"invisible":true}
//Method: ARCHIVE_utCheckFields
//Description
//  `Verify that all fields in the master table are in the archive table
//  `Fields are named the same; verify fields exist; fields are same type; length is same for strings
// Parameters
// $1 : $MasterTbl_ptr
// $2 : $ArchiveTbl_ptr
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 06/18/13, 10:12:23
	// ----------------------------------------------------
	//Created : 
	Mods_2013_06
End if 
//
If (Application type:C494#4D Server:K5:6)
	If (Not:C34(Is compiled mode:C492))
		If (User in group:C338(Current user:C182; "Design Access Group"))
			C_POINTER:C301($1; $MasterTbl_ptr)
			$MasterTbl_ptr:=$1
			C_POINTER:C301($2; $ArchiveTbl_ptr)
			$ArchiveTbl_ptr:=$2
			
			C_LONGINT:C283($FieldLoop_L; $Type_L; $FieldLength_L; $TblNum_L; $MatchFiled_L; $ArchType_L; $ArchFieldLength_L; $ArchTblNum_L; $MasterTblNum_L)
			C_TEXT:C284($FieldName_txt; $TypeMissmatch_txt; $LengthMissmatch_txt; $MissingFilelds_txt)
			ARRAY TEXT:C222($MasterFields_atxt; Get last field number:C255($MasterTbl_ptr))
			ARRAY TEXT:C222($ArchiveFields_atxt; Get last field number:C255($ArchiveTbl_ptr))
			$ArchTblNum_L:=Table:C252($ArchiveTbl_ptr)
			//Get  the archive table fields 
			For ($FieldLoop_l; 1; Get last field number:C255($ArchiveTbl_ptr))
				If (Is field number valid:C1000($ArchTblNum_L; $FieldLoop_l))
					$ArchiveFields_atxt{$FieldLoop_l}:=Field name:C257($ArchTblNum_L; $FieldLoop_l)
				End if 
			End for 
			
			C_BOOLEAN:C305($AllOK_b; $Indexed_b; $Unique_b; $Invisible_b)
			//Loop through the master fields
			$MasterTblNum_L:=Table:C252($MasterTbl_ptr)
			$AllOK_b:=True:C214
			$TypeMissmatch_txt:=""
			$LengthMissmatch_txt:=""
			$MissingFilelds_txt:=""
			
			For ($FieldLoop_l; 1; Get last field number:C255($MasterTbl_ptr))
				If (Is field number valid:C1000($MasterTblNum_L; $FieldLoop_l))
					$FieldName_txt:=Field name:C257($MasterTblNum_L; $FieldLoop_l)
					$MatchFiled_L:=Find in array:C230($ArchiveFields_atxt; $FieldName_txt)
					GET FIELD PROPERTIES:C258($MasterTblNum_L; $FieldLoop_l; $Type_L; $FieldLength_L; $Indexed_b; $Unique_b; $Invisible_b)
					If ($MatchFiled_L>0)
						//Found it ! check type and size
						GET FIELD PROPERTIES:C258($ArchTblNum_L; $MatchFiled_L; $ArchType_L; $ArchFieldLength_L)
						
						If ($Type_L#$ArchType_L)
							$AllOK_b:=False:C215
							$TypeMissmatch_txt:=$TypeMissmatch_txt+Char:C90(13)+$FieldName_txt+"  main: "+fGetDataType($Type_L)+" arch: "+fGetDataType($ArchType_L)
						End if 
						
						If ($FieldLength_L#$ArchFieldLength_L)
							$AllOK_b:=False:C215
							$LengthMissmatch_txt:=$LengthMissmatch_txt+Char:C90(13)+$FieldName_txt+"  main: "+String:C10($FieldLength_L)+" arch: "+String:C10($ArchFieldLength_L)
						End if 
						
					Else 
						//missing field
						$AllOK_b:=False:C215
						$MissingFilelds_txt:=$MissingFilelds_txt+Char:C90(13)+$FieldName_txt+" type "+fGetDataType($Type_L)+" length "+String:C10($FieldLength_L)+" indexed:"+f_Boolean2String($Indexed_b; "YN")+" unique:"+f_Boolean2String($Unique_b; "YN")+" invis:"+f_Boolean2String($Invisible_b; "YN")
					End if 
					
				End if 
			End for 
			
			If (Not:C34($AllOK_b))
				C_TEXT:C284($AllErrors_txt)
				$AllErrors_txt:="Errors found comparing Master table ["+Table name:C256($MasterTblNum_L)+"] vs Archive table ["+Table name:C256($ArchTblNum_L)+"]"+Char:C90(13)
				$AllErrors_txt:=$AllErrors_txt+Char:C90(13)+"Missing fields : "+$MissingFilelds_txt+Char:C90(13)
				$AllErrors_txt:=$AllErrors_txt+Char:C90(13)+"MisTyped fields : "+$TypeMissmatch_txt+Char:C90(13)
				$AllErrors_txt:=$AllErrors_txt+Char:C90(13)+"Length MisMatch fields : "+$LengthMissmatch_txt
				ut_BigAlert($AllErrors_txt)
			End if 
			
		End if 
	End if 
End if 

//End ARCHIVE_utCheckFields