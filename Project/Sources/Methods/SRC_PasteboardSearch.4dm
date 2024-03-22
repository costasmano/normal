//%attributes = {"invisible":true}
//Method: SRC_PasteboardSearch
// Perform a search through the bridge table from data in the pasteboard. 
// Parse the text data in the pasteboard to determine the search type
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): manousakisc
	//User (4D) : Designer
	//Date and time: 07/09/21, 11:08:29
	// ----------------------------------------------------
	//Created : 
	Mods_2021_07
	
	// Modified by: Costas Manousakis-(Designer)-(2023-03-03 14:13:31)
	Mods_2023_03_bug
	//  `use get text from pasteboard instead of get pasteboard (text data;...)
	
End if 
//

//ARRAY TEXT($sigs_atxt;0)
//ARRAY TEXT($types_atxt;0)

//GET PASTEBOARD DATA TYPE($sigs_atxt;$types_atxt)

C_TEXT:C284($ClipTextCopy; $DelimChar)

$ClipTextCopy:=Get text from pasteboard:C524
$DelimChar:=Char:C90(13)
Case of 
	: (Position:C15(Char:C90(9); $ClipTextCopy)>0)
		$DelimChar:=Char:C90(9)
	: (Position:C15(","; $ClipTextCopy)>0)
		$DelimChar:=","
	: (Position:C15((Char:C90(13)+Char:C90(10)); $ClipTextCopy)>0)
		$DelimChar:=(Char:C90(13)+Char:C90(10))
	: (Position:C15(Char:C90(10); $ClipTextCopy)>0)
		$DelimChar:=Char:C90(10)
		
End case 

ARRAY TEXT:C222($valuesToSearch_atxt; 0)
ut_TextToArray($ClipTextCopy; ->$valuesToSearch_atxt; $DelimChar)

If (Size of array:C274($valuesToSearch_atxt)<1)
	ALERT:C41("No data found in the pasteboard buffer")
Else 
	
	SRC_DeclareBrgVars
	
	//check what we have from the first one
	$valuesToSearch_atxt{1}:=Replace string:C233($valuesToSearch_atxt{1}; "-"; "")
	$valuesToSearch_atxt{1}:=ut_String2AlphaNumOnly($valuesToSearch_atxt{1})
	$valuesToSearch_atxt{1}:=f_TrimStr($valuesToSearch_atxt{1}; True:C214; True:C214)
	
	C_LONGINT:C283($InfoLen)
	$InfoLen:=Length:C16($valuesToSearch_atxt{1})  //length of the first one
	C_BOOLEAN:C305($continue_b)
	$continue_b:=True:C214
	C_POINTER:C301($searchField_ptr)
	Case of 
		: ($InfoLen=3)
			//search BIN
			$searchField_ptr:=SRC_BINField_ptr
		: ($InfoLen=6)
			//BDEPT
			$searchField_ptr:=SRC_BDEPTField_ptr
		: ($InfoLen=15)
			//extract the BIN
			$valuesToSearch_atxt{1}:=Substring:C12($valuesToSearch_atxt{1}; 7; 3)
			$searchField_ptr:=SRC_BINField_ptr
		Else 
			//did not find usable data!
			$continue_b:=False:C215
			ALERT:C41("No usable data found! Data should be 3, 6, or 15 characters long.\nFirst data found was \""+$valuesToSearch_atxt{1}+"\"")
	End case 
	
	If ($continue_b)
		//process the rest of the array
		C_LONGINT:C283($loop_L)
		For ($loop_L; 2; Size of array:C274($valuesToSearch_atxt))
			$valuesToSearch_atxt{$loop_L}:=Replace string:C233($valuesToSearch_atxt{$loop_L}; "-"; "")
			$valuesToSearch_atxt{$loop_L}:=ut_String2AlphaNumOnly($valuesToSearch_atxt{$loop_L})
			$valuesToSearch_atxt{$loop_L}:=f_TrimStr($valuesToSearch_atxt{$loop_L}; True:C214; True:C214)
			Case of 
				: ($InfoLen=3)
					//search BIN
					$valuesToSearch_atxt{$loop_L}:=Substring:C12($valuesToSearch_atxt{$loop_L}; 1; 3)
				: ($InfoLen=6)
					//BDEPT
					$valuesToSearch_atxt{$loop_L}:=Substring:C12($valuesToSearch_atxt{$loop_L}; 1; 6)
				: ($InfoLen=15)
					//extract the BIN
					$valuesToSearch_atxt{$loop_L}:=Substring:C12($valuesToSearch_atxt{$loop_L}; 7; 3)
			End case 
			
		End for 
		
		
		If ((vAddTo) & (Records in set:C195("Random Set")=0))
			CREATE SET:C116(SRC_MasterTable_ptr->; "Random Set")
		End if 
		OBJECT SET ENABLED:C1123(bFind; False:C215)
		If (Not:C34(SRC_HideLooking_b))
			SHORT_MESSAGE("Looking…")
		End if 
		If (vAddTo)
			If (SRC_AllowSearchAll_b)
				ALL RECORDS:C47(SRC_MasterTable_ptr->)
			Else 
				USE NAMED SELECTION:C332("UserRegionA")
			End if 
		Else 
			If (SRC_AllowSearchAll_b)
				ALL RECORDS:C47(SRC_MasterTable_ptr->)
			Else 
				USE NAMED SELECTION:C332("UserRegionA")
			End if 
		End if 
		
		//if the SRC_Mastertable_ptr is not the Bridge table -
		// then we have to do a search on the bridge table first and
		// then get the related records from the SRC_Mastertable_ptr
		C_POINTER:C301($searchTable_ptr)
		$searchTable_ptr:=Table:C252(Table:C252($searchField_ptr))
		If ($searchTable_ptr#SRC_MasterTable_ptr)
			//get the bridge records related to the current selection of the master search table
			RELATE ONE SELECTION:C349(SRC_MasterTable_ptr->; $searchTable_ptr->)
		End if 
		
		QUERY SELECTION WITH ARRAY:C1050($searchField_ptr->; $valuesToSearch_atxt)
		//
		If ($searchTable_ptr#SRC_MasterTable_ptr)
			//now get the master search table records related to the current selection of the bridge table
			//check if the BIN field pointer is the BIN field of the master table
			C_LONGINT:C283($oneField; $oneTable)
			GET RELATION PROPERTIES:C686(SRC_BINField_ptr; $oneTable; $oneField)
			If (Field:C253($oneTable; $oneField)=(->[Bridge MHD NBIS:1]BIN:3))
				RELATE MANY SELECTION:C340(SRC_BINField_ptr->)
			Else 
				//need to find it
				C_LONGINT:C283($fields_; $field_)
				$fields_:=Get last field number:C255(SRC_MasterTable_ptr)
				For ($field_; 1; $fields_)
					GET RELATION PROPERTIES:C686(Field:C253(Table:C252(SRC_MasterTable_ptr); $field_); $oneTable; $oneField)
					If (Field:C253($oneTable; $oneField)=(->[Bridge MHD NBIS:1]BIN:3))
						RELATE MANY SELECTION:C340(Field:C253($oneTable; $oneField)->)
						$field_:=$fields_+1
					End if 
				End for 
				
			End if 
		End if 
		
		CREATE SET:C116(SRC_MasterTable_ptr->; "Found Bridge Recs Set")
		
		If (Records in set:C195("Random Set")=0)
			If (vAddTo=False:C215)
				CREATE EMPTY SET:C140(SRC_MasterTable_ptr->; "Random Set")
			End if 
		End if 
		UNION:C120("Random Set"; "Found Bridge Recs Set"; "Random Set")
		C_TEXT:C284(vsSearchResults)
		vsSearchResults:="Last Find : "+String:C10(Records in set:C195("Found Bridge Recs Set"))+" Recs"
		vsSearchResults:=vsSearchResults+" - Total Recs Found : "+String:C10(Records in set:C195("Random Set"))
		CLEAR SET:C117("Found Bridge Recs Set")
		
		//closing
		If (Not:C34(SRC_HideLooking_b))
			CLOSE WINDOW:C154
		End if 
		
		OBJECT SET ENABLED:C1123(bFind; True:C214)
		
	End if 
	
End if 
//End SRC_PasteboardSearch