//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 04/14/10, 16:24:36
	// ----------------------------------------------------
	// Method: SETUTIL_Control
	// Description
	// Do SET commands using record IDs instead of 4D Sets
	// 
	// Parameters
	// $1 : $TASK_txt :  "SAVE" ; "LOAD" ; "ADD"  "SUBTRACT"; "INTERSECT"
	// $2 : $KeyFld_ptr
	// ----------------------------------------------------
	
	Mods_2010_04
	// Modified by: Costas Manousakis-(Designer)-(12/23/13 08:41:54)
	Mods_2013_12
	//  `Added INTERSECT task ; a tag at the beginnig of the set file; a return boolean if all is ok;
	//  `Adjusted method of saving set file - added 4st extension
	// Modified by: Costas Manousakis-(Designer)-(3/12/14 17:14:58)
	Mods_2014_03_Bug
	//  `fixed "bug" when loading files that are actual 4D Set. now if the file loaded deoas not have the "SETUTIL_SAVESET" tag
	//  `it is assumed to be a 4D Set and loaded directly into the current table
End if 
C_BOOLEAN:C305($0; $SET_OK_b)
C_TEXT:C284($1; $TASK_txt)
$TASK_txt:=$1
C_POINTER:C301($2; $KeyFld_ptr)
$KeyFld_ptr:=$2
C_LONGINT:C283($Table_L; $Field_L; $FieldType_L)
$Field_L:=Field:C253($KeyFld_ptr)
$Table_L:=Table:C252($KeyFld_ptr)
C_POINTER:C301($Table_ptr)
$Table_ptr:=Table:C252($Table_L)
C_TEXT:C284($Table_txt; $Field_txt)
$Table_txt:=Table name:C256($Table_L)
$Field_txt:="["+$Table_txt+"]"+Field name:C257($Table_L; $Field_L)
GET FIELD PROPERTIES:C258($KeyFld_ptr; $FieldType_L)
ARRAY INTEGER:C220($RecIDs_ai; 0)
ARRAY LONGINT:C221($RecIDs_aL; 0)
ARRAY TEXT:C222($RecIDs_atxt; 0)
C_TIME:C306($SetFile_t)
C_BLOB:C604($BlobToSave)
C_BOOLEAN:C305($DoTheMath_b)
C_TEXT:C284($FileTag_s)  // Command Replaced was o_C_STRING length was 80
$SET_OK_b:=False:C215
$FileTag_s:=""
//_O_MAP FILE TYPES("SETT"; ".4st"; "4D Set Document")
Case of 
	: (($FieldType_L#Is integer:K8:5) & ($FieldType_L#Is longint:K8:6) & ($FieldType_L#Is alpha field:K8:1))
		ALERT:C41("These Set routines work only with Integer and Alpha fields!")
		
	: ($TASK_txt="SAVE")
		$FileTag_s:="SETUTIL_SAVESET"
		VARIABLE TO BLOB:C532($FileTag_s; $BlobToSave; *)
		VARIABLE TO BLOB:C532($Table_L; $BlobToSave; *)
		VARIABLE TO BLOB:C532($Field_L; $BlobToSave; *)
		VARIABLE TO BLOB:C532($FieldType_L; $BlobToSave; *)
		
		Case of 
			: ($FieldType_L=Is integer:K8:5)
				SELECTION TO ARRAY:C260($KeyFld_ptr->; $RecIDs_ai)
				VARIABLE TO BLOB:C532($RecIDs_ai; $BlobToSave; *)
			: ($FieldType_L=Is longint:K8:6)
				SELECTION TO ARRAY:C260($KeyFld_ptr->; $RecIDs_aL)
				VARIABLE TO BLOB:C532($RecIDs_aL; $BlobToSave; *)
			: ($FieldType_L=Is alpha field:K8:1)
				SELECTION TO ARRAY:C260($KeyFld_ptr->; $RecIDs_atxt)
				VARIABLE TO BLOB:C532($RecIDs_atxt; $BlobToSave; *)
		End case 
		//$SetFile_t:=Create document(""; "SETT")
		$SetFile_t:=Create document:C266(""; ".4st")
		If (OK=1)
			C_TEXT:C284($SetFileName_txt)
			$SetFileName_txt:=Document
			CLOSE DOCUMENT:C267($SetFile_t)
			C_TEXT:C284($fileExt_txt)
			$fileExt_txt:=GetFileExtension($SetFileName_txt)
			If ($fileExt_txt#".4st")
				C_TEXT:C284($FilePath_txt)
				$FilePath_txt:=Substring:C12($SetFileName_txt; 1; Length:C16($SetFileName_txt)-Length:C16($fileExt_txt))
				If (Test path name:C476($FilePath_txt+".4st")=Is a document:K24:1)
					//file already exists - we will replace contents anyway
				Else 
					//does not exist - rename file created to one with correct extersion
					MOVE DOCUMENT:C540($SetFileName_txt; ($FilePath_txt+".4st"))
				End if 
				$SetFileName_txt:=$FilePath_txt+".4st"
			End if 
			BLOB TO DOCUMENT:C526($SetFileName_txt; $BlobToSave)
			$SET_OK_b:=True:C214
		End if 
		
	: (($TASK_txt="LOAD") | ($TASK_txt="ADD") | ($TASK_txt="SUBTRACT"))
		//$SetFile_t:=Open document(""; "SETT")
		$SetFile_t:=Open document:C264(""; ".4st")
		If (OK=1)
			C_TEXT:C284($SetFileName_txt; $StoreTable_txt; $StoreField_txt)
			$SetFileName_txt:=Document
			CLOSE DOCUMENT:C267($SetFile_t)
			DOCUMENT TO BLOB:C525($SetFileName_txt; $BlobToSave)
			C_LONGINT:C283($offset_L; $StoredTable_L; $StoredField_L; $StoredFieldType_L)
			$offset_L:=0
			$DoTheMath_b:=True:C214
			BLOB TO VARIABLE:C533($BlobToSave; $FileTag_s; $offset_L)
			
			If ($FileTag_s="SETUTIL_SAVESET")
				BLOB TO VARIABLE:C533($BlobToSave; $StoredTable_L; $offset_L)
				BLOB TO VARIABLE:C533($BlobToSave; $StoredField_L; $offset_L)
				BLOB TO VARIABLE:C533($BlobToSave; $StoredFieldType_L; $offset_L)
				$StoreTable_txt:=Table name:C256($StoredTable_L)
				$StoreField_txt:="["+$StoreTable_txt+"]"+Field name:C257($StoredTable_L; $StoredField_L)
				SET QUERY DESTINATION:C396(Into set:K19:2; "SETUTILSETTOLOAD")
				Case of 
					: ($StoredTable_L#$Table_L)
						ALERT:C41("Table ["+$StoreTable_txt+"] stored in selected set file does not match required Table  ["+$Table_txt+"] !!!!")
						$DoTheMath_b:=False:C215
					: ($StoredField_L#$Field_L)
						ALERT:C41("Field  "+$StoreField_txt+" stored in selected set file does not match required Field "+$Field_txt+" !!!!")
						$DoTheMath_b:=False:C215
					: ($StoredFieldType_L#$FieldType_L)
						ALERT:C41("Field type "+String:C10($StoredFieldType_L)+" stored in selected set file does not match required Field type "+String:C10($FieldType_L)+" for field "+$Field_txt+" !!!!")
						$DoTheMath_b:=False:C215
					: ($FieldType_L=Is integer:K8:5)
						BLOB TO VARIABLE:C533($BlobToSave; $RecIDs_ai; $offset_L)
						QUERY WITH ARRAY:C644($KeyFld_ptr->; $RecIDs_ai)
					: ($FieldType_L=Is longint:K8:6)
						BLOB TO VARIABLE:C533($BlobToSave; $RecIDs_aL; $offset_L)
						QUERY WITH ARRAY:C644($KeyFld_ptr->; $RecIDs_aL)
					: ($FieldType_L=Is alpha field:K8:1)
						BLOB TO VARIABLE:C533($BlobToSave; $RecIDs_atxt; $offset_L)
						QUERY WITH ARRAY:C644($KeyFld_ptr->; $RecIDs_atxt)
				End case 
				SET QUERY DESTINATION:C396(Into current selection:K19:1)
			Else 
				//assume it is a 4D Type Set
				LOAD SET:C185($table_ptr->; "SETUTILSETTOLOAD"; $SetFileName_txt)
				$SET_OK_b:=True:C214
			End if 
			
			If ($DoTheMath_b)
				CREATE SET:C116($Table_Ptr->; "SETUTILCURRSET")
				Case of 
					: ($TASK_txt="LOAD")
						COPY SET:C600("SETUTILSETTOLOAD"; "SETUTILCURRSET")
					: ($TASK_txt="ADD")
						UNION:C120("SETUTILCURRSET"; "SETUTILSETTOLOAD"; "SETUTILCURRSET")
					: ($TASK_txt="SUBTRACT")
						DIFFERENCE:C122("SETUTILCURRSET"; "SETUTILSETTOLOAD"; "SETUTILCURRSET")
					: ($TASK_txt="INTERSECT")
						INTERSECTION:C121("SETUTILCURRSET"; "SETUTILSETTOLOAD"; "SETUTILCURRSET")
				End case 
				USE SET:C118("SETUTILCURRSET")
				CLEAR SET:C117("SETUTILCURRSET")
				CLEAR SET:C117("SETUTILSETTOLOAD")
				$SET_OK_b:=True:C214
			End if 
		Else 
			$SET_OK_b:=False:C215
		End if 
		
End case 

SET BLOB SIZE:C606($BlobToSave; 0)

ARRAY INTEGER:C220($RecIDs_ai; 0)
ARRAY LONGINT:C221($RecIDs_aL; 0)
ARRAY TEXT:C222($RecIDs_atxt; 0)

$0:=$SET_OK_b