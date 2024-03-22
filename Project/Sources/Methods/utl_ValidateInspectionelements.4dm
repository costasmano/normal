//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 12/18/12, 16:47:03
//----------------------------------------------------
//Method: utl_ValidateInspectionelements
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2012_12  //r001 ` 
	//Modified by: Charles Miller (12/18/12 16:47:04)
	// Modified by: Costas Manousakis-(Designer)-(12/27/12 16:13:59)
	Mods_2012_12
	//Allow extra line for the element labels
End if 
READ ONLY:C145(*)

QUERY:C277([Inspection Type:31]; [Inspection Type:31]ElementNumbers_txt:4#"")

C_LONGINT:C283($InnerLoop_l; $OuterLoop_l; $MaxOffset_L; $Offset_L; $Position_L)
C_BLOB:C604($Report_blb)
C_TEXT:C284($ElementType_txt; $ElementNumbers_txt; $ElementLbls_txt)
SET BLOB SIZE:C606($Report_blb; 0)

For ($OuterLoop_l; 1; Records in selection:C76([Inspection Type:31]))
	GOTO SELECTED RECORD:C245([Inspection Type:31]; $OuterLoop_l)
	TEXT TO BLOB:C554("Checking inspection type of "+[Inspection Type:31]Code:1+Char:C90(Carriage return:K15:38); $Report_blb; Mac text without length:K22:10; *)
	
	$MaxOffset_L:=Length:C16([Inspection Type:31]ElementNumbers_txt:4)
	
	$Offset_L:=1
	Repeat 
		$Position_L:=Position:C15("\r"; [Inspection Type:31]ElementNumbers_txt:4; $Offset_L)
		If ($Position_L>0)
			$ElementType_txt:=Substring:C12([Inspection Type:31]ElementNumbers_txt:4; $Offset_L; $Position_L-$Offset_L)  //N58, n60 etc
			$Offset_L:=$Position_L+1
			$Position_L:=Position:C15("\r"; [Inspection Type:31]ElementNumbers_txt:4; $Offset_L)  //element numbers 100, 101, etc
			If ($Position_L>0)
				$ElementNumbers_txt:=Substring:C12([Inspection Type:31]ElementNumbers_txt:4; $Offset_L; $Position_L-$Offset_L)  //element numbers 100, 101, etc 
				$Offset_L:=$Position_L+1
				$Position_L:=Position:C15("\r"; [Inspection Type:31]ElementNumbers_txt:4; $Offset_L)  //element labels 1.,2.,a. etc
				
				If ($Position_L>0)
					$ElementLbls_txt:=Substring:C12([Inspection Type:31]ElementNumbers_txt:4; $Offset_L; $Position_L-$Offset_L)  // `element labels 1.,2.,a. etc
					$Offset_L:=$Position_L+1
				Else 
					$ElementLbls_txt:=Substring:C12([Inspection Type:31]ElementNumbers_txt:4; $Offset_L)
					$Offset_L:=$MaxOffset_L
				End if 
			Else 
				$Offset_L:=$MaxOffset_L
			End if 
			ARRAY TEXT:C222($ElementNumbers_atxt; 0)
			ut_NewTextToArray($ElementNumbers_txt; ->$ElementNumbers_atxt; ",")
		Else 
			$Offset_L:=$MaxOffset_L
		End if 
		C_LONGINT:C283($Count_l)
		TEXT TO BLOB:C554("Checking element code type of "+$ElementType_txt+Char:C90(Carriage return:K15:38); $Report_blb; Mac text without length:K22:10; *)
		SET QUERY DESTINATION:C396(Into variable:K19:4; $Count_l)
		
		QUERY:C277([Element Cat:32]; [Element Cat:32]Code:1=$ElementType_txt)
		Case of 
			: ($Count_l=0)
				TEXT TO BLOB:C554("Missing element code type "+$ElementType_txt+Char:C90(Carriage return:K15:38); $Report_blb; Mac text without length:K22:10; *)
				
			: ($Count_l>1)
				TEXT TO BLOB:C554("More than one record for  element code type "+$ElementType_txt+Char:C90(Carriage return:K15:38); $Report_blb; Mac text without length:K22:10; *)
			Else 
				
		End case 
		SET QUERY DESTINATION:C396(Into set:K19:2; "$ElementDictSet")
		
		QUERY:C277([ElementDict:30]; [ElementDict:30]Category:3=$ElementType_txt)
		For ($InnerLoop_l; 1; Size of array:C274($ElementNumbers_atxt))
			SET QUERY DESTINATION:C396(Into variable:K19:4; $Count_l)
			USE SET:C118("$ElementDictSet")
			QUERY SELECTION:C341([ElementDict:30]; [ElementDict:30]ElementNo:1=$ElementNumbers_atxt{$InnerLoop_l})
			Case of 
				: ($Count_l=0)
					TEXT TO BLOB:C554("Missing element number "+$ElementNumbers_atxt{$InnerLoop_l}+Char:C90(Carriage return:K15:38); $Report_blb; Mac text without length:K22:10; *)
					
				: ($Count_l>1)
					TEXT TO BLOB:C554("More than one record for  element number "+$ElementNumbers_atxt{$InnerLoop_l}+Char:C90(Carriage return:K15:38); $Report_blb; Mac text without length:K22:10; *)
					
				Else 
			End case 
			
		End for 
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		
		
	Until ($Offset_L>=$MaxOffset_L)
End for 
C_TIME:C306($Doc_tm)
$Doc_tm:=Create document:C266("")

CLOSE DOCUMENT:C267($Doc_tm)
BLOB TO DOCUMENT:C526(Document; $Report_blb)

//End utl_ValidateInspectionelements

