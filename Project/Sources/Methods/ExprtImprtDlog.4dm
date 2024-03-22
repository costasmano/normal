//%attributes = {"invisible":true}
If (False:C215)
	//Procedure: ExprtImprtDlog(string)
	//ACI University Programming Classes
	//Generic ACI Shell Programming
	//Created By:  Jim Steinman
	//Date:  10/5/95
	
	//Legend:
	//$1 - string - type layout to display  "Import" or "Export"
	
	//Purpose: Prepares the Import Export information formats.
	//All records in the current selection are exported.
	
	<>fGeneric:=False:C215
	<>f_Ver1x20:=False:C215
	<>fJ_Steinman:=False:C215
	
	Mods_2005_CM15
	
	// Modified by: costasmanousakis-(Designer)-(5/26/11 15:37:38)
	Mods_2011_05
	//modified handling of the pFile pointer-use resolve pointer to check it.
	//Also avoid export if there are no records selected.
End if 

C_LONGINT:C283($Lpid)
C_TEXT:C284($sFormat)  // Command Replaced was o_C_STRING length was 1
C_TEXT:C284($sPurpose)  // Command Replaced was o_C_STRING length was 6

$sPurpose:=$1

//set up export fields arrays
ARRAY TEXT:C222(asExpImpFld; 0)  //Command Replaced was o_ARRAY string length was 19
ARRAY POINTER:C280(apExpImp; 0)
//Declare the array to store the field names
ARRAY TEXT:C222(asFields; 0)  //Command Replaced was o_ARRAY string length was 19
//Declare the array to store pointers to the fields
ARRAY POINTER:C280(apFlds; 0)
//Declare the array to store the field types
ARRAY TEXT:C222(asFldTypes; 0)  //Command Replaced was o_ARRAY string length was 8

C_POINTER:C301(pFile)
C_LONGINT:C283($Table_L; $Field_L)
C_TEXT:C284($Varname_txt)
RESOLVE POINTER:C394(pFile; $Varname_txt; $Table_L; $Field_L)
If ($Table_L<1)
	pFile:=->[Bridge MHD NBIS:1]
End if 

Case of 
	: (Table:C252(pFile)=1)
		COPY ARRAY:C226(<>asFields; asFields)
		COPY ARRAY:C226(<>apFlds; apFlds)
		COPY ARRAY:C226(<>asFldTypes; asFldTypes)
	: (Table:C252(pFile)>0)
		FieldsToArray(pFile; ->asFields; ->apFlds; False:C215; False:C215; ->asFldTypes)
		SORT ARRAY:C229(asFields; apFlds; asFldTypes)
	Else 
		
End case 
If ((($sPurpose="Export") & (Records in selection:C76(pFile->)>0)) | ($sPurpose="Import"))
	//Default values for the format dialog.
	sFldDel:="9"
	sRecDel:="13"
	ckInclude:=0
	sDlogText1:=$sPurpose+"ing Data…"
	sDlogText2:=Table name:C256(pFile)+" Fields"
	sDlogText3:=$sPurpose+" Order"
	
	NewWindow(450; 300; 0; 8; ""; "")
	DIALOG:C40([zDialogs:68]; "ExportImport")
	CLOSE WINDOW:C154
	
	If (bExport=1)
		Case of 
			: (ckLayout=1)
				$sFormat:="3"
				ARRAY POINTER:C280(apExpImp; 1)
				apExpImp{1}:=apFlds{1}
			: (ck4DFormat=1)
				$sFormat:="2"
				ARRAY POINTER:C280(apExpImp; 1)
				apExpImp{1}:=apFlds{1}
			: (ckInclude=1)
				$sFormat:="1"
			Else 
				$sFormat:="0"
		End case 
		
		//Prepare some diamond vars for passing info the new export process  
		ARRAY POINTER:C280(<>apExpImp; 0)
		COPY ARRAY:C226(apExpImp; <>apExpImp)
		
		If ($sPurpose="Export")  //Only use selection for export
			COPY NAMED SELECTION:C331(pFile->; "◊ExportSelection")
		End if 
		
		//Start exporting in a separate process
		$Lpid:=LSpawnProcess("P_"+$sPurpose+"Data"; 0; Substring:C12($sPurpose; 1; 3)+" "+Substring:C12(Table name:C256(pFile); 1; 6)+" Rs"; True:C214; True:C214)  //Limit to 13 chars to add number if needed
		If ($Lpid#0)
			<>tParameters:="◊apExpImp"+";"+$sFormat+";"+String:C10(ckCRLF)+";"+Char:C90(Num:C11(sFldDel))+";"+Char:C90(Num:C11(sRecDel))  //Prepare parameters for other process
			Repeat 
				DELAY PROCESS:C323(Current process:C322; 30)
			Until (Length:C16(<>tParameters)=0)  //Wait until received by other process
		Else 
			If ($sPurpose="Export")  //Only use selection for export
				CLEAR NAMED SELECTION:C333("◊ExportSelection")  //Clear if the other process didn't get created
			End if 
		End if 
		
	End if 
	
Else 
	ALERT:C41("There are no selected Records for table "+Table name:C256(pFile))
End if 

//End of procedure 