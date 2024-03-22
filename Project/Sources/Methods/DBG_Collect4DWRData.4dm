//%attributes = {"invisible":true}
//Method: DBG_Collect4DWRData
//Description
// method to collect data from 4D Write areas on print forms while printing.
// can be called from the form methods while printing to append
// Parameters
// $1 : $Task_txt (Start | Append | Export )
// $2 : $FormName_txt
// $3 : $WriteArea_L
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 09/13/18, 16:12:05
	// ----------------------------------------------------
	//Created : 
	Mods_2018_09_bug
	
	C_TEXT:C284(DBG_Collect4DWRData; $1)
	C_TEXT:C284(DBG_Collect4DWRData; $2)
	C_LONGINT:C283(DBG_Collect4DWRData; $3)
	
End if 
//
C_TEXT:C284($1)
C_TEXT:C284($Task_txt)
$Task_txt:=$1

C_BLOB:C604(DBG_Collect4DWRData_o)

Case of 
	: ($Task_txt="Start")
		//start the collection object
		SET BLOB SIZE:C606(DBG_Collect4DWRData_o; 0)
		
	: ($Task_txt="Append")
		C_TEXT:C284($2)
		C_LONGINT:C283($3)
		C_TEXT:C284($Form_txt; $Debug_txt)
		C_LONGINT:C283($WriteArea_L)
		$Form_txt:=$2
		$WriteArea_L:=$3
		
		$Debug_txt:="******"+Char:C90(Carriage return:K15:38)+"Form :"+$Form_txt+Char:C90(Carriage return:K15:38)+\
			"Date Time :"+String:C10(Current date:C33(*); ISO date:K1:8; Current time:C178(*))+Char:C90(Carriage return:K15:38)+\
			"4D Write Area properties : "+DBG_Get4DWriteAreaProps($WriteArea_L)+Char:C90(Carriage return:K15:38)+Char:C90(Carriage return:K15:38)+\
			"4D Write Document properties : "+DBG_Get4DWriteDocProps($WriteArea_L)+Char:C90(Carriage return:K15:38)+Char:C90(Carriage return:K15:38)+\
			"4D Write Print options : "+DBG_Get4DWritePrintProps($WriteArea_L)+Char:C90(Carriage return:K15:38)+Char:C90(Carriage return:K15:38)+\
			"Print options : "+DBG_GetPrintOptions+Char:C90(Carriage return:K15:38)+Char:C90(Carriage return:K15:38)
		
		TEXT TO BLOB:C554($Debug_txt; DBG_Collect4DWRData_o; UTF8 text without length:K22:17; *)
		
	: ($Task_txt="Export")
		//export the collection object as text to a file
		// create a text document
		C_TEXT:C284($filename_txt)
		$filename_txt:=Select document:C905(System folder:C487(Documents folder:K41:18)+"Debug.txt"; "txt"; "Report name:"; File name entry:K24:17)
		If (OK=1)
			BLOB TO DOCUMENT:C526(Document; DBG_Collect4DWRData_o)
		End if 
		SET BLOB SIZE:C606(DBG_Collect4DWRData_o; 0)
		
End case 

//End DBG_Collect4DWRData