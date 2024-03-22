//%attributes = {"invisible":true}

//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 12/13/12, 14:49:04
//----------------------------------------------------
//Method: utl_SetUpNewElementTest
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2012_12  //r001 ` This method modifies element safety records to test for printing of reports
	//Modified by: Charles Miller (12/13/12 14:49:06)
	// Modified by: Costas Manousakis-(Designer)-(12/27/12 14:35:52)
	Mods_2012_12
	//  `Allow extra line for the element labels
	// Modified by: Costas Manousakis-(Designer)-(12/28/12 12:10:49)
	Mods_2012_12
	//  `Added code for testing of 4d Write comments.
	// Modified by: Costas Manousakis-(Designer)-(6/24/21 09:44:50)
	Mods_2021_WP
	//  `
End if 
READ ONLY:C145(*)
READ WRITE:C146([ElementsSafety:29])

C_TEXT:C284($inspId_txt)
C_TEXT:C284($InspTypeCode_txt; $InspCategory; $ElementType_txt; $ElementNumbers_txt; $ElementLbls_txt)
C_LONGINT:C283($Count_l; $MaxOffset_L; $Offset_L; $Position_L; $i)
$inspId_txt:=Request:C163("Enter inspection ID")
QUERY:C277([Inspections:27]; [Inspections:27]InspID:2=Num:C11($inspId_txt))
SET QUERY DESTINATION:C396(Into set:K19:2; "$set")

QUERY:C277([ElementsSafety:29]; [ElementsSafety:29]InspID:4=Num:C11($inspId_txt))

CONFIRM:C162("Are you sure you want to update the "+String:C10(Records in set:C195("$set"))+" [ElementsSafety] records?")
If (OK=1)
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	USE SET:C118("$set")
	APPLY TO SELECTION:C70([ElementsSafety:29]; [ElementsSafety:29]Rating:2:="")
	USE SET:C118("$set")
	APPLY TO SELECTION:C70([ElementsSafety:29]; [ElementsSafety:29]Deficiency:3:="")
	USE SET:C118("$set")
	APPLY TO SELECTION:C70([ElementsSafety:29]; [ElementsSafety:29]Priority:20:="")
	USE SET:C118("$set")
	APPLY TO SELECTION:C70([ElementsSafety:29]; [ElementsSafety:29]AltRating:21:="")
	
	USE SET:C118("$set")
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	
	C_OBJECT:C1216($WP_o; $Range_o)
	$WP_o:=WP New:C1317
	$Range_o:=WP Text range:C1341($WP_o; wk start text:K81:165; wk end text:K81:164)
	C_BLOB:C604($wpblob_x; $fieldBlob_x)
	C_TEXT:C284($DataTag)
	$DataTag:="WPAREA"
	
	For ($i; 1; Records in selection:C76([ElementsSafety:29]))
		GOTO SELECTED RECORD:C245([ElementsSafety:29]; $i)
		QUERY:C277([ElementDict:30]; [ElementDict:30]ElementNo:1=[ElementsSafety:29]ElementNo:1)
		[ElementsSafety:29]Description:22:=[ElementDict:30]Description:2
		WP SET TEXT:C1574($Range_o; "Comments for element "+[ElementsSafety:29]Description:22; wk replace:K81:177; wk include in range:K81:180)
		WP EXPORT VARIABLE:C1319($WP_o; $wpblob_x; wk 4wp:K81:4; wk normal:K81:7)
		VARIABLE TO BLOB:C532($DataTag; $fieldBlob_x)
		VARIABLE TO BLOB:C532($wpblob_x; $fieldBlob_x)
		[ElementsSafety:29]ElmComments:23:=$fieldBlob_x
		[ElementsSafety:29]Comment Flag:6:=True:C214
		SAVE RECORD:C53([ElementsSafety:29])
	End for 
	
	SET BLOB SIZE:C606($wpblob_x; 0)
	SET BLOB SIZE:C606($fieldBlob_x; 0)
	USE SET:C118("$set")
	
	ARRAY TEXT:C222($onecharText_atxt; 0)
	ARRAY TEXT:C222($twocharText_atxt; 0)
	ARRAY TEXT:C222($onecharText_atxt; 88)
	ARRAY TEXT:C222($twocharText_atxt; 88)
	For ($i; 1; 78)
		$onecharText_atxt{$i}:=Char:C90($i+32)
		$twocharText_atxt{$i}:=$onecharText_atxt{$i}+$onecharText_atxt{$i}
	End for 
	
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	
	$InspTypeCode_txt:=Request:C163("Enter inspection Type Code"; [Inspections:27]Insp Type:6)
	
	QUERY:C277([Inspection Type:31]; [Inspection Type:31]Code:1=$InspTypeCode_txt)
	If (Records in selection:C76([Inspection Type:31])=1)
		C_BOOLEAN:C305($Complete_b)
		$Complete_b:=False:C215
		$MaxOffset_L:=Length:C16([Inspection Type:31]ElementNumbers_txt:4)
		Repeat 
			$InspCategory:=Request:C163("Enter inspection Category (N58, N59, etc)")
			If (OK=1)
				
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
					Else 
						$Offset_L:=$MaxOffset_L
					End if 
					
				Until ($ElementType_txt=$InspCategory) | ($Offset_L>=$MaxOffset_L) | ($Position_L<1)
				
				ARRAY TEXT:C222($ElementNumbers_atxt; 0)
				ut_NewTextToArray($ElementNumbers_txt; ->$ElementNumbers_atxt; ",")
				ARRAY INTEGER:C220($ElementNumbers_ai; 0)
				For ($i; 1; Size of array:C274($ElementNumbers_atxt))
					APPEND TO ARRAY:C911($ElementNumbers_ai; Num:C11($ElementNumbers_atxt{$i}))
				End for 
				SET QUERY DESTINATION:C396(Into set:K19:2; "$set1")
				QUERY WITH ARRAY:C644([ElementsSafety:29]ElementNo:1; $ElementNumbers_ai)
				
				INTERSECTION:C121("$set1"; "$set"; "$set3")
				
				USE SET:C118("$set3")
				
				For ($i; 1; Records in selection:C76([ElementsSafety:29]))
					GOTO SELECTED RECORD:C245([ElementsSafety:29]; $i)
					[ElementsSafety:29]Rating:2:=$onecharText_atxt{$i}
					[ElementsSafety:29]Deficiency:3:=$twocharText_atxt{$i}
					[ElementsSafety:29]Priority:20:=$twocharText_atxt{89-$i}
					[ElementsSafety:29]AltRating:21:=$onecharText_atxt{89-$i}
					[ElementsSafety:29]Description:22:=[ElementsSafety:29]Description:22+String:C10($i)
					[ElementsSafety:29]Description:22:=Replace string:C233([ElementsSafety:29]Description:22; "blank"; "wasblk")
					SAVE RECORD:C53([ElementsSafety:29])
				End for 
			Else 
				$Complete_b:=True:C214
			End if 
		Until ($Complete_b)
	End if 
End if 
UNLOAD RECORD:C212([ElementsSafety:29])

SET QUERY DESTINATION:C396(Into current selection:K19:1)
CLEAR SET:C117("$set1")
CLEAR SET:C117("$set2")
CLEAR SET:C117("$set3")

ALERT:C41("Update completed")

//End utl_SetUpNewElementTest