//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 04/09/10, 08:33:54
	// ----------------------------------------------------
	// Method: ut_SearchTableField
	// Description
	//  ` Search any table by any field in a quick succession without the use of the
	//  ` query editor.
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2010_04
End if 
C_LONGINT:C283($fileno; $TableNo; $fieldNo; $FieldType)
$TableNo:=ut_SelectTableNum
If ($TableNo>0)
	$fieldNo:=ut_SelectFieldNum($TableNo)
	If ($fieldNo>0)
		C_POINTER:C301($tbl_ptr; $fld_ptr)
		$tbl_ptr:=Table:C252($TableNo)
		$fld_ptr:=Field:C253($TableNo; $fieldNo)
		C_TEXT:C284($SearchTxt_txt; $FieldName_txt; $TableName_txt; $Operator)
		$FieldName_txt:=Field name:C257($TableNo; $fieldNo)
		$TableName_txt:=Table name:C256($TableNo)
		$FieldType:=Type:C295($fld_ptr->)
		If (($FieldType=Is longint:K8:6) | ($FieldType=Is integer:K8:5) | ($FieldType=Is real:K8:4) | ($FieldType=Is date:K8:7) | ($FieldType=Is text:K8:3) | ($FieldType=Is alpha field:K8:1))
			//$fileno:=Num(Request("Filenumber :";String($fileno)))
			$QueryCount:=0
			C_LONGINT:C283($inputChoise_L; $QueryCount; $txtClipL)
			C_BOOLEAN:C305($proceed_b)
			$inputChoise_L:=ut_3Option_Confirm("Select method for searching in the field ["+$TableName_txt+"]"+$FieldName_txt+" :"; "Manual"; "TextFile"; "Clipboard")
			C_TIME:C306($TextFile_t)
			C_TEXT:C284($Buffer_txt)
			$proceed_b:=True:C214
			If ($inputChoise_L=2)
				//text file
				$TextFile_t:=Open document:C264(""; "")
				If (OK=0)
					$proceed_b:=False:C215
				End if 
				
			End if 
			If ($inputChoise_L=3)
				//
				//$txtClipL:=Test clipboard("TEXT")
				//If ($txtClipL<=0)
				//ALERT("There is no Text in the clipboard!")
				//$proceed_b:=False
				//End if 
				ALERT:C41("Clipboard search not supported yet - switching to manual!!")
				$inputChoise_L:=1
				
			End if 
			If ($proceed_b)
				Repeat 
					Case of 
						: ($inputChoise_L=1)
							$SearchTxt_txt:=Request:C163($FieldName_txt+" :"; $SearchTxt_txt)
						: ($inputChoise_L=2)
							RECEIVE PACKET:C104($TextFile_t; $SearchTxt_txt; <>sCR)
							If (Substring:C12($SearchTxt_txt; 1; 1)=<>sLF)
								//if 1st char is a LF then skip it    
								$SearchTxt_txt:=Substring:C12($SearchTxt_txt; 2)
							End if 
						: ($inputChoise_L=3)
							
					End case 
					
					If (OK=1)
						If (($SearchTxt_txt="") & (($inputChoise_L=3) | ($inputChoise_L=2)))
							//dont search for blank lines in the text file or the clipboard
						Else 
							$QueryCount:=$QueryCount+1
							If ($QueryCount=1)
								Case of 
									: ($FieldType=Is longint:K8:6) | ($FieldType=Is integer:K8:5) | ($FieldType=Is real:K8:4)
										QUERY:C277($tbl_ptr->; $fld_ptr->=Num:C11($SearchTxt_txt); *)
									: ($FieldType=Is date:K8:7)
										QUERY:C277($tbl_ptr->; $fld_ptr->=Date:C102($SearchTxt_txt); *)
									: ($FieldType=Is text:K8:3) | ($FieldType=Is alpha field:K8:1)
										QUERY:C277($tbl_ptr->; $fld_ptr->=$SearchTxt_txt; *)
								End case 
							Else 
								Case of 
									: ($FieldType=Is longint:K8:6) | ($FieldType=Is integer:K8:5) | ($FieldType=Is real:K8:4)
										QUERY:C277($tbl_ptr->;  | ; $fld_ptr->=Num:C11($SearchTxt_txt); *)
									: ($FieldType=Is date:K8:7)
										QUERY:C277($tbl_ptr->;  | ; $fld_ptr->=Date:C102($SearchTxt_txt); *)
									: ($FieldType=Is text:K8:3) | ($FieldType=Is alpha field:K8:1)
										QUERY:C277($tbl_ptr->;  | ; $fld_ptr->=$SearchTxt_txt; *)
								End case 
							End if 
							
						End if 
					End if 
					
				Until (OK=0)
				If ($QueryCount>0)
					QUERY:C277($tbl_ptr->)
				End if 
				If ($inputChoise_L=2)
					CLOSE DOCUMENT:C267($TextFile_t)
				End if 
				
			End if 
			
		Else 
			ALERT:C41("Field ["+$TableName_txt+"]"+$FieldName_txt+" is not a numeric, date or text field")
		End if 
		
	End if 
	
End if 
