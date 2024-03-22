//%attributes = {"invisible":true}
//Method: clone_ReportMissingFields
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 06/11/18, 11:04:44
	// ----------------------------------------------------
	//Created : 
	Mods_2018_06
End if 
//
Compiler_clone
clone_ControlConnect
C_LONGINT:C283($TableNumber_L)

ARRAY TEXT:C222($Tname_atxt; 0)
ARRAY TEXT:C222($Cname_atxt; 0)
ARRAY LONGINT:C221($DataType_aL; 0)
ARRAY LONGINT:C221($DataLength_aL; 0)
ARRAY LONGINT:C221($TableID_aL; 0)
ARRAY LONGINT:C221($ColumnID_aL; 0)
C_BLOB:C604($report_blb)
C_LONGINT:C283($loop_L)
C_TEXT:C284($4DType_txt)
C_LONGINT:C283($Type_l)
CONFIRM:C162("Report on "; "Exceptions"; "All")
C_BOOLEAN:C305($ReportOnExceptions_B)
$ReportOnExceptions_B:=OK=1
For ($TableNumber_L; 1; Get last table number:C254)
	If (Is table number valid:C999($Tablenumber_L))
		If (Not:C34($ReportOnExceptions_B))
			TEXT TO BLOB:C554("Table Name: "+Table name:C256($Tablenumber_L)+Char:C90(Carriage return:K15:38); $report_blb; UTF8 text without length:K22:17; *)
		End if 
		Begin SQL
			select 
			COLUMN_NAME, 
			DATA_TYPE, 
			DATA_LENGTH, 
			COLUMN_ID 
			from
			_USER_COLUMNS
			where
			TABLE_ID = :$TableNumber_L
			into
			:$Cname_atxt, :$DataType_aL, :$DataLength_aL,  :$ColumnID_aL;
		End SQL
		
		C_LONGINT:C283($ArrayPosition_L)
		C_POINTER:C301($Fld_ptr)
		
		For ($loop_L; 1; Get last field number:C255($TableNumber_L))
			If (Is field number valid:C1000($TableNumber_L; $loop_L))
				$ArrayPosition_L:=Find in array:C230($ColumnID_aL; $loop_L)
				$Fld_ptr:=Field:C253($TableNumber_L; $loop_L)
				GET FIELD PROPERTIES:C258($Fld_ptr; $Type_l)
				
				
				Case of 
					: ($Type_l=7)
						$4DType_txt:="Link - should not be any"+Char:C90(Tab:K15:37)
					: ($Type_l=Is alpha field:K8:1)
						$4DType_txt:="Is alpha field "+Char:C90(Tab:K15:37)
					: ($Type_l=Is text:K8:3)
						$4DType_txt:="Is text"+Char:C90(Tab:K15:37)
					: ($Type_l=Is real:K8:4)
						$4DType_txt:="Is real"+Char:C90(Tab:K15:37)
					: ($Type_l=Is integer:K8:5)
						$4DType_txt:="Is integer"+Char:C90(Tab:K15:37)
					: ($Type_l=Is longint:K8:6)
						$4DType_txt:="Is longint"+Char:C90(Tab:K15:37)
					: ($Type_l=Is date:K8:7)
						$4DType_txt:="Is date"+Char:C90(Tab:K15:37)
					: ($Type_l=Is time:K8:8)
						$4DType_txt:="Is time"+Char:C90(Tab:K15:37)
					: ($Type_l=Is boolean:K8:9)
						$4DType_txt:="Is boolean"+Char:C90(Tab:K15:37)
					: ($Type_l=Is picture:K8:10)
						$4DType_txt:="Is picture"+Char:C90(Tab:K15:37)
					: ($Type_l=Is BLOB:K8:12)
						$4DType_txt:="Is blob"+Char:C90(Tab:K15:37)
					Else 
						$4DType_txt:="unkown"
				End case 
				If (Not:C34($ReportOnExceptions_B))
					TEXT TO BLOB:C554(Field name:C257($Fld_ptr)+Char:C90(Tab:K15:37)+\
						$4DType_txt+\
						String:C10($Type_l)+Char:C90(Tab:K15:37); $report_blb; UTF8 text without length:K22:17; *)
					
					
					If ($ArrayPosition_L>0)
						TEXT TO BLOB:C554($Cname_atxt{$ArrayPosition_L}+Char:C90(Tab:K15:37)+\
							String:C10($DataType_aL{$ArrayPosition_L})+Char:C90(Tab:K15:37)\
							; $report_blb; UTF8 text without length:K22:17; *)
						DELETE FROM ARRAY:C228($Cname_atxt; $ArrayPosition_L; 1)
						DELETE FROM ARRAY:C228($DataType_aL; $ArrayPosition_L; 1)
						DELETE FROM ARRAY:C228($DataLength_aL; $ArrayPosition_L; 1)
						DELETE FROM ARRAY:C228($ColumnID_aL; $ArrayPosition_L; 1)
					Else 
						APPEND TO ARRAY:C911(clone_MissRemoteTableFld_atxt; Table name:C256($TableNumber_L)+"--"+Field name:C257($Fld_ptr))
						
						TEXT TO BLOB:C554("Missing from remote "; $report_blb; UTF8 text without length:K22:17; *)
					End if 
					TEXT TO BLOB:C554(Char:C90(Carriage return:K15:38); $report_blb; UTF8 text without length:K22:17; *)
				Else 
					If ($ArrayPosition_L>0)
						DELETE FROM ARRAY:C228($Cname_atxt; $ArrayPosition_L; 1)
						DELETE FROM ARRAY:C228($DataType_aL; $ArrayPosition_L; 1)
						DELETE FROM ARRAY:C228($DataLength_aL; $ArrayPosition_L; 1)
						DELETE FROM ARRAY:C228($ColumnID_aL; $ArrayPosition_L; 1)
					Else 
						TEXT TO BLOB:C554("Table Name: "+Table name:C256($Tablenumber_L)+Char:C90(Tab:K15:37)+\
							Field name:C257($Fld_ptr)+Char:C90(Tab:K15:37)+\
							$4DType_txt+\
							String:C10($Type_l)+Char:C90(Tab:K15:37)+\
							"Missing from remote "+Char:C90(Carriage return:K15:38); $report_blb; UTF8 text without length:K22:17; *)
					End if 
					
				End if 
			End if 
		End for 
		If (Size of array:C274($Cname_atxt)>0)
			TEXT TO BLOB:C554("Table Name: "+Table name:C256($Tablenumber_L)+Char:C90(Carriage return:K15:38); $report_blb; UTF8 text without length:K22:17; *)
			For ($loop_L; 1; Size of array:C274($Cname_atxt))
				
				TEXT TO BLOB:C554($Cname_atxt{$loop_L}+Char:C90(Tab:K15:37)+\
					String:C10($DataType_aL{$ArrayPosition_L})+Char:C90(Tab:K15:37)+\
					"Missing from Local"+Char:C90(Carriage return:K15:38); $report_blb; UTF8 text without length:K22:17; *)
			End for 
			TEXT TO BLOB:C554("End Table Name: "+Table name:C256($Tablenumber_L)+Char:C90(Carriage return:K15:38)+Char:C90(Carriage return:K15:38); $report_blb; UTF8 text without length:K22:17; *)
			
		End if 
		
	End if 
	If (Not:C34($ReportOnExceptions_B))
		TEXT TO BLOB:C554("End Table Name: "+Table name:C256($Tablenumber_L)+Char:C90(Carriage return:K15:38)+Char:C90(Carriage return:K15:38); $report_blb; UTF8 text without length:K22:17; *)
	End if 
End for 
C_TEXT:C284($Path_txt)
$Path_txt:=Select folder:C670("Sekect folder to store report")
$Path_txt:=$Path_txt+"FildCompare_"+ut_ReturnTimeStampFromDate(Current date:C33; Current time:C178)+".txt"
BLOB TO DOCUMENT:C526($Path_txt; $report_blb)
SQL LOGOUT:C872
//End clone_ReportMissingFields