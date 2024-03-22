//%attributes = {"invisible":true}
//Method: clone_ControlClone
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2017_12  // Fix issue with double click by adding Compiler_LB as InDoubleClick_B was undefined
	Mods_2018_06
	// Modified by: Costas Manousakis-(Designer)-(2022-11-21 18:16:49)
	Mods_2022_11
	//  `added progress bars before login dialog and after.
End if 

C_LONGINT:C283($progress)
$progress:=Progress New
Progress SET TITLE($progress; "Initial setup")
Progress SET PROGRESS($progress; -1)

Compiler_clone
Compiler_LB
Compiler_SQL
clone_IncludeUUIDS_B:=False:C215
clone_IncludeUUIDS_L:=0
clone_CreateSQLLimits
C_TEXT:C284($TableName_txt)
//$Query_txt:="SQL_LIMITS"
//Repeat 
//Begin SQL

//SELECT [TableOfLists].[ListValue_s], [TableOfLists].[ListSequence_l] 
//FROM [TableOfLists] 
//WHERE [TableOfLists].[ListName_s] = :$Query_txt 
//ORDER BY [TableOfLists].ListSequence_l ASC, [TableOfLists].ListValue_s ASC 
//INTO :SQL_LimitNames_atxt, :SQL_Limits_AL;

//End SQL
//If (Size of array(SQL_LimitNames_atxt)=0)
//clone_CreateSQLLimits 
//End if 

//Until (Size of array(SQL_LimitNames_atxt)>0)
ARRAY LONGINT:C221(clone_PrimaryKeyTable_aL; 0)
ARRAY LONGINT:C221(clone_PrimaryField_aL; 0)
C_LONGINT:C283($Primary_key_field_id_L; $TableLoop_L)
For ($TableLoop_L; 1; Get last table number:C254)
	If (Is table number valid:C999($TableLoop_L))
		$Primary_key_field_id_L:=clone_ReturnUUIDPrimaryKey($TableLoop_L)
		APPEND TO ARRAY:C911(clone_PrimaryKeyTable_aL; $TableLoop_L)
		APPEND TO ARRAY:C911(clone_PrimaryField_aL; $Primary_key_field_id_L)
		
	End if 
	
End for 

Progress QUIT($progress)

clone_ControlConnect

If (OK=1)
	
	$progress:=Progress New
	Progress SET TITLE($progress; "Collecting info from remote server")
	Progress SET PROGRESS($progress; -1)
	
	clone_CreateremoteMissingFields
	ARRAY LONGINT:C221(LocalCount_al; 0)
	ARRAY LONGINT:C221(RemoteCount_al; 0)
	ARRAY TEXT:C222(TableNames_atxt; 0)
	ARRAY LONGINT:C221(TableNumber_al; 0)
	ARRAY LONGINT:C221(LocalCount_al; Get last table number:C254)
	ARRAY LONGINT:C221(RemoteCount_al; Get last table number:C254)
	ARRAY TEXT:C222(TableNames_atxt; Get last table number:C254)
	ARRAY LONGINT:C221(TableNumber_al; Get last table number:C254)
	
	ARRAY LONGINT:C221(ProcessLocalCount_al; 0)
	ARRAY LONGINT:C221(ProcessRemoteCount_al; 0)
	ARRAY TEXT:C222(ProcessTableNames_atxt; 0)
	ARRAY LONGINT:C221(ProcessTableNumber_al; 0)
	ARRAY TEXT:C222(RemoteQueryType_atxt; 0)
	ARRAY TEXT:C222(RemoteKey_atxt; 0)
	ARRAY TEXT:C222(RemoteKeyName_atxt; 0)
	ARRAY TEXT:C222(RemoteCustomQuery_atxt; 0)
	
	
	// lets get a display of files
	C_LONGINT:C283($NoRecords_l; Count_l; $TableLoop_L)
	C_POINTER:C301($Table_ptr)
	For ($TableLoop_L; 1; Get last table number:C254)
		If (Is table number valid:C999($TableLoop_L))
			$Table_ptr:=Table:C252($TableLoop_L)
			$NoRecords_l:=Records in table:C83($Table_ptr->)
			TableNames_atxt{$TableLoop_L}:=Table name:C256($TableLoop_L)
			TableNumber_al{$TableLoop_L}:=$TableLoop_L
			LocalCount_al{$TableLoop_L}:=Records in table:C83($Table_ptr->)
			$TableName_txt:="["+Table name:C256($TableLoop_L)+"]"
			Compiler_FieldVariables($TableLoop_L)
			SQLCount_txt:="SELECT Count(*) FROM "+$TableName_txt+" INTO :Count_l"
			Count_l:=0
			If (Find in array:C230(clone_RemoteTables_atxt; TableNames_atxt{$TableLoop_L})>0)
				Begin SQL
					EXECUTE IMMEDIATE :SQLCount_txt;
				End SQL
			End if 
			RemoteCount_al{$TableLoop_L}:=Count_l
			
			
		End if 
	End for 
	
	Repeat 
		$TableLoop_L:=Find in array:C230(TableNumber_al; 0)
		If ($TableLoop_L>0)
			DELETE FROM ARRAY:C228(TableNames_atxt; $TableLoop_L; 1)
			DELETE FROM ARRAY:C228(TableNumber_al; $TableLoop_L; 1)
			DELETE FROM ARRAY:C228(LocalCount_al; $TableLoop_L; 1)
			DELETE FROM ARRAY:C228(RemoteCount_al; $TableLoop_L; 1)
		End if 
	Until ($TableLoop_L<0)
	
	Progress QUIT($progress)
	C_LONGINT:C283($ApplicationType_l)
	$ApplicationType_l:=-1
	$ApplicationType_l:=Application type:C494
	
	C_LONGINT:C283($Width_l; $Height_l; $Win_l; $Pages_l)
	C_BOOLEAN:C305($FixedWidth_b; $FixedHeight_b)
	C_TEXT:C284($Title_txt)
	
	FORM GET PROPERTIES:C674("CloneTables"; $Width_l; $Height_l; $Pages_l; $FixedWidth_b; $FixedHeight_b; $Title_txt)
	clone_OpenNewWindow($Width_l; $Height_l; 0; 4; "Cloning"; "clone_close")
	
	DIALOG:C40("CloneTables")
	CLOSE WINDOW:C154
	ARRAY LONGINT:C221(LocalCount_al; 0)
	ARRAY LONGINT:C221(RemoteCount_al; 0)
	ARRAY TEXT:C222(TableNames_atxt; 0)
	ARRAY LONGINT:C221(TableNumber_al; 0)
	SQL LOGOUT:C872
End if 
clone_IncludeUUIDS_B:=False:C215
//End ut_ControlClone