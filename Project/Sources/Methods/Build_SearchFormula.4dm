//%attributes = {"invisible":true}
//Method: Build_SearchFormula
//Description
// build a search formula file
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 04/16/19, 16:05:37
	// ----------------------------------------------------
	//Created : 
	Mods_2019_04
	//NOTES :
	// QueryDestinations 
	// 1 : new selection
	// 2 : search in selection
	// 3 : add to selection
	// 4 : Remove from selection
	
	//lineOperator 
	// 1 : And
	// 2 : OR
	
	//Criterion
	// 1 : equal
	// 2 : not equal
	// 11 : contain
	// 12 : does not contain
	// 9 : begin with
	// 10 : end with
	// 15 : in   values separated by a ; - there is a limit to either number of values or length of the string
	// 41 : is empty -no "oneBox"
	// 42 : is not empty
	// 7 : is between , "firstOfTwoBoxes" : "val1" , "secondOfTwoBoxes" : "val2"
	// 8 : is between (excluded) , "firstOfTwoBoxes" : "val1" , "secondOfTwoBoxes" : "val2"
	
	// Modified by: Costas Manousakis-(Designer)-(2022-06-17 09:37:25)
	Mods_2022_06
	//  `if the blob from getpasteboard data("Text"; is empty, try get text from pasteboard
	
	// Modified by: Costas Manousakis-(Designer)-(2023-07-03 20:06:04)
	Mods_2023_07
	//  `use pick from list to select comparison criteria
	//  `if over 500 entries, split the file in multiple .4df files
	
End if 
//
ARRAY TEXT:C222(Search_Value; 0)
C_LONGINT:C283(SEARCH_Table; SEARCH_Field; SEARCH_Criterion; SEARCH_Destination)

SEARCH_Destination:=1  //new selection
C_TEXT:C284($menu_txt; $Criterion_txt)
ARRAY TEXT:C222($criterionDesc_atxt; 0)
ARRAY TEXT:C222($criterion_atxt; 0)
APPEND TO ARRAY:C911($criterionDesc_atxt; "Equal")
APPEND TO ARRAY:C911($criterion_atxt; "1")
APPEND TO ARRAY:C911($criterionDesc_atxt; "Contains")
APPEND TO ARRAY:C911($criterion_atxt; "11")
APPEND TO ARRAY:C911($criterionDesc_atxt; "Begins with")
APPEND TO ARRAY:C911($criterion_atxt; "9")
APPEND TO ARRAY:C911($criterionDesc_atxt; "Ends with")
APPEND TO ARRAY:C911($criterion_atxt; "10")

If (False:C215)
	$menu_txt:=MENU_BuildMenuFromArrays(->$criterionDesc_atxt; ->$criterion_atxt; "\\")
	$Criterion_txt:=Dynamic pop up menu:C1006($menu_txt)
	RELEASE MENU:C978($menu_txt)
	
	If ($Criterion_txt#"")
		SEARCH_Criterion:=Num:C11($Criterion_txt)
	Else 
		SEARCH_Criterion:=1  //Equal
	End if 
	
End if 

C_LONGINT:C283($criteria_L)
$criteria_L:=G_PickFromList(->$criterionDesc_atxt; "Choose Comparison Criterion")

If ($criteria_L>0)
	SEARCH_Criterion:=Num:C11($criterion_atxt{$criteria_L})
Else 
	SEARCH_Criterion:=1  //Equal
End if 

//pick table and field
SEARCH_Table:=0
SEARCH_Field:=0
SEARCH_Table:=ut_SelectTableNum
If (SEARCH_Table>0)
	SEARCH_Field:=ut_SelectFieldNum(SEARCH_Table)
End if 

//load values in text array from clipboard?
C_BLOB:C604($SearchTemplate_x; $FormulaBlob_x; $ClipBlob_x)
C_TEXT:C284($ClipText_txt; $DelimChar)
GET PASTEBOARD DATA:C401("TEXT"; $ClipBlob_x)
If (BLOB size:C605($ClipBlob_x)=0)
	//try this
	$ClipText_txt:=Get text from pasteboard:C524
Else 
	$ClipText_txt:=BLOB to text:C555($ClipBlob_x; Mac text without length:K22:10)
End if 
$DelimChar:=Char:C90(Carriage return:K15:38)
Case of 
	: (Position:C15(Char:C90(9); $ClipText_txt)>0)
		$DelimChar:=Char:C90(9)
	: (Position:C15(","; $ClipText_txt)>0)
		$DelimChar:=","
	: (Position:C15((Char:C90(13)+Char:C90(10)); $ClipText_txt)>0)
		$DelimChar:=(Char:C90(13)+Char:C90(10))
	: (Position:C15(Char:C90(10); $ClipText_txt)>0)
		$DelimChar:=Char:C90(10)
		
End case 
ut_TextToArray($ClipText_txt; ->Search_Value; $DelimChar)
ut_DisplayArray(->Search_Value; "List of values"; "Value")
CONFIRM:C162("Found "+String:C10(Size of array:C274(Search_Value))+" possible values in the pasteboard"+\
" to search in field "+Field name:C257(SEARCH_Table; SEARCH_Field); "Continue"; "Abort")
If (OK=1)
	C_LONGINT:C283($reduceto_L)
	$reduceto_L:=Num:C11(Request:C163("reduce number of values to "; String:C10(Size of array:C274(Search_Value))))
	$reduceto_L:=MinNum($reduceto_L; 500)
	
	C_TEXT:C284($templfile_txt)
	$templfile_txt:=Select document:C905(""; ".4df"; "Select file to save formula"; File name entry:K24:17)
	C_OBJECT:C1216($qfile_o)
	$qfile_o:=File:C1566(Document; fk platform path:K87:2)
	
	$SearchTemplate_x:=RES_Load_to_Blob(""; "SEARCH_ByFieldFormulaTemplate.txt")
	
	If (OK=1)
		C_LONGINT:C283($startindex_L; $fileindex_L)
		$startindex_L:=0
		$fileindex_L:=0
		C_COLLECTION:C1488($base_c; $slice_c)
		$base_c:=New collection:C1472
		ARRAY TO COLLECTION:C1563($base_c; Search_Value)
		
		//start the bar
		C_OBJECT:C1216($progress_o)
		$progress_o:=ProgressNew("Saving query files"; 500; False:C215; "parts"; 0)
		Progress SET PROGRESS($progress_o.progress; -1)
		
		While ($startindex_L<$base_c.length)
			If ($fileindex_L=0)
				$templfile_txt:=$qfile_o.platformPath
			Else 
				SEARCH_Destination:=3  //subsequent search files do "add to selection"
				$templfile_txt:=$qfile_o.parent.platformPath+$qfile_o.name+"_"+String:C10($fileindex_L)+".4df"
			End if 
			$fileindex_L:=$fileindex_L+1
			
			$slice_c:=$base_c.slice($startindex_L; ($startindex_L+$reduceto_L))
			COLLECTION TO ARRAY:C1562($slice_c; Search_Value)
			$startindex_L:=$startindex_L+$reduceto_L
			
			PROCESS 4D TAGS:C816($SearchTemplate_x; $FormulaBlob_x)
			
			BLOB TO DOCUMENT:C526($templfile_txt; $FormulaBlob_x)
			
		End while 
		//quit progress
		Progress QUIT(OB Get:C1224($progress_o; "progress"; Is longint:K8:6))
		
		If ($fileindex_L>1)
			ALERT:C41("Number of values to search exceeded 500."+\
				"Generated "+String:C10($fileindex_L)+" query formula files that can be used in sequence.")
		End if 
		
		SHOW ON DISK:C922($qfile_o.platformPath)
		
	End if 
End if 

//End Build_SearchFormula