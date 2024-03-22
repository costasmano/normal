//%attributes = {"invisible":true}
//Method: INSP_FieldWorkComplCheck
//Description
//  ` Check if field FieldWorkCompleteDate has been entered.
//  ` intended to be called before inspection is marked as complete.
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 01/15/15, 15:38:13
	// ----------------------------------------------------
	//Created : 
	Mods_2015_01
	// Modified by: Costas Manousakis-(Designer)-(10/09/19 11:22:45)
	Mods_2019_10_bug
	//  `check if field work complete date is in the future. CallReference #663
End if 
//
C_TEXT:C284($0)
C_TEXT:C284($message_txt)
$message_txt:=""

Case of 
	: ([Bridge MHD NBIS:1]InspResp:173="DIST@")  // only for DOT inspection responsibility
		If (<>INSPFORMREVDATE_8#!00-00-00!)  //date changes are effective
			If ([Inspections:27]Insp Date:78>=<>INSPFORMREVDATE_8)
				ARRAY TEXT:C222($Objectnames_atxt; 0)
				ARRAY POINTER:C280($objPointers_aptr; 0)
				ARRAY LONGINT:C221($objPages_aL; 0)
				C_TEXT:C284($TabName_txt; $varname_txt; $gotopage_txt)
				$gotopage_txt:=""
				$TabName_txt:=""
				FORM GET OBJECTS:C898($Objectnames_atxt; $objPointers_aptr; $objPages_aL)
				C_LONGINT:C283($Foundat_L)
				$Foundat_L:=Find in array:C230($objPointers_aptr; ->[Inspections:27]InspFldWorkComplDate:224)
				If ($Foundat_L>0)
					C_LONGINT:C283($loop_L; $tbl_L; $fld_L)
					For ($loop_L; 1; Size of array:C274($Objectnames_atxt))
						$TabName_txt:=""
						If ($objPages_aL{$loop_L}=0)
							//in first page
							RESOLVE POINTER:C394($objPointers_aptr{$loop_L}; $varname_txt; $tbl_L; $fld_L)
							If ($varname_txt#"")
								If ((Type:C295($objPointers_aptr{$loop_L}->)=String array:K8:15) | (Type:C295($objPointers_aptr{$loop_L}->)=Text array:K8:16)) & ($varname_txt="@tab@")
									//this must be the tab
									
									If (Size of array:C274($objPointers_aptr{$loop_L}->)>=$objPages_aL{$Foundat_L})
										$TabName_txt:=$objPointers_aptr{$loop_L}->{$objPages_aL{$Foundat_L}}
										$loop_L:=Size of array:C274($Objectnames_atxt)+1
									End if 
									
								End if 
							End if 
						End if 
					End for 
					
					If ($TabName_txt#"")
						$gotopage_txt:="  Please go to page "+String:C10($objPages_aL{$Foundat_L})+" ("+$TabName_txt+") of the input form!"
					Else 
						$gotopage_txt:="  Please go to page "+String:C10($objPages_aL{$Foundat_L})+" of the input form!"
					End if 
					
					Case of 
						: ([Inspections:27]InspFldWorkComplDate:224=!00-00-00!)
							$message_txt:=<>sCR+"A New Inspection Tracking Measure Was Implemented for Inspections dated after "+String:C10(<>INSPFORMREVDATE_8)
							$message_txt:=$message_txt+"! You Must Enter the Date Inspection Field Work Was Completed!"
							
							If ($Foundat_L>0)
								$message_txt:=$message_txt+$gotopage_txt+<>sCR
							End if 
						: ([Inspections:27]InspFldWorkComplDate:224<[Inspections:27]Insp Date:78)
							$message_txt:="Field Work Completion Date "+String:C10([Inspections:27]InspFldWorkComplDate:224)+" is BEFORE the Inspection Date "+String:C10([Inspections:27]Insp Date:78)+" !"
							
							If ($Foundat_L>0)
								$message_txt:=$message_txt+$gotopage_txt+<>sCR
							End if 
							
						: ([Inspections:27]InspFldWorkComplDate:224>Current date:C33(*))
							$message_txt:="Field Work Completion Date "+String:C10([Inspections:27]InspFldWorkComplDate:224)+" is in the future !"
							
							If ($Foundat_L>0)
								$message_txt:=$message_txt+$gotopage_txt+<>sCR
							End if 
							
					End case 
					
					
				End if 
				
			End if 
			
		End if 
		
End case 

$0:=$message_txt
//End INSP_FieldWorkComplCheck