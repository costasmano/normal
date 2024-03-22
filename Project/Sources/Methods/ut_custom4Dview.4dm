//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 02/21/10, 23:03:30
	// ----------------------------------------------------
	// Method: ut_custom4Dview
	// Description
	//  ` do a custom 4D View document for a table as a quick report replacement
	// From Chuck Miller's suggestion!!!!
	// Parameters
	// ----------------------------------------------------
	
	Mods_2010_02
	Mods_2011_06  // CJ Miller`06/14/11, 13:25:05      ` Type all local variables for v11
End if 
C_LONGINT:C283($my4dViewArea_L; $Index; $Master)
C_LONGINT:C283($Mytable_L)

C_BLOB:C604($4DViewDocBlob_blb)
C_TIME:C306($4DViewDoc_t)

C_LONGINT:C283($newTempwin)
//Set Doc Margins ($newTempwin)
//PV BLOB TO AREA ($newTempwin;$4DViewDocBlob_blb)
C_LONGINT:C283($NumCols_L; $ActualCount_L; $TableNum_L)
$TableNum_L:=ut_SelectTableNum
C_POINTER:C301($tbl_ptr; $fld_ptr)
$tbl_ptr:=Table:C252($TableNum_L)
If (Get last field number:C255($tbl_ptr)<$NumCols_L)
	$NumCols_L:=Get last field number:C255($tbl_ptr)
End if 
C_BOOLEAN:C305($DoShow_b)
$DoShow_b:=False:C215

If (Records in selection:C76($tbl_ptr->)>0)
	$DoShow_b:=True:C214
Else 
	QUERY:C277($tbl_ptr->)
	If (Records in selection:C76($tbl_ptr->)>0)
		$DoShow_b:=True:C214
	Else 
		ALERT:C41("No Records selected for table ["+Table name:C256($TableNum_L)+"]")
	End if 
	
End if 
//If ($DoShow_b)

//$newTempwin:=_O_Open external window(20;20;500;500;Plain window;"Custom ["+Table name($TableNum_L)+"] View";"_4D View")
//$NumCols_L:=Get last field number($tbl_ptr)
//ARRAY LONGINT($ArrayColumns;$NumCols_L)  //Start cell column number 
//ARRAY LONGINT($ArrayRows;$NumCols_L)  //Start cell row number 
//ARRAY INTEGER($ConversionArray;$NumCols_L)  //0 for original type or 1 for set to text 
//ARRAY INTEGER($TablesArray;$NumCols_L)  //Table numbers 
//ARRAY INTEGER($FieldsArray;$NumCols_L)  //Field numbers 
//$ActualCount_L:=0
//For ($Index;1;$NumCols_L)
//$fld_ptr:=Field(Table($tbl_ptr);$index)
//Case of 
//: (Type($fld_ptr->)=Is BLOB)
//: (Type($fld_ptr->)=Is picture)
//Else 
//$ActualCount_L:=$ActualCount_L+1
//$ArrayColumns{$ActualCount_L}:=$ActualCount_L  //Columns A....
//$ArrayRows{$ActualCount_L}:=1  //Start at the 1st line 
//$ConversionArray{$ActualCount_L}:=0  //0=Keep original fields types ; 1->text
//$TablesArray{$ActualCount_L}:=Table($tbl_ptr)
//$FieldsArray{$ActualCount_L}:=$index
//PV SET COLUMN HEADER ($newTempwin;$ActualCount_L;Field name($TablesArray{$ActualCount_L};$index))  //Assign new name
//End case 

//End for 
//ARRAY LONGINT($ArrayColumns;$ActualCount_L)  //Start cell column number 
//ARRAY LONGINT($ArrayRows;$ActualCount_L)  //Start cell row number 
//ARRAY INTEGER($ConversionArray;$ActualCount_L)  //0 for original type or 1 for set to text 
//ARRAY INTEGER($TablesArray;$ActualCount_L)  //Table numbers 
//ARRAY INTEGER($FieldsArray;$ActualCount_L)  //Field numbers 
//$Master:=Table($tbl_ptr)
//  //ALL RECORDS($tbl_ptr->)
//PV FIELDS LIST TO CELLS ($newTempwin;1;$ArrayColumns;$ArrayRows;$ConversionArray;$Master;$TablesArray;$FieldsArray)
//PV SET DOCUMENT PROPERTY ($newTempwin;pv column count;$ActualCount_L)
//PV SET DOCUMENT PROPERTY ($newTempwin;pv row count;Records in selection($tbl_ptr->))
//PV SET AREA PROPERTY ($newTempwin;pv document modified;0)
//  //WR SET AREA PROPERTY ($newTempwin;wr modified ;0;"")  ` not modified
//SET BLOB SIZE($4DViewDocBlob_blb;0)
//  //End if 
//End if 