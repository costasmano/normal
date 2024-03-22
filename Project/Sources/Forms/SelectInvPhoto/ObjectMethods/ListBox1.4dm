//Method: "SelectInvPhoto".List Box
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Bridge Section
	//User (4D) : Designer
	//Date and time: 10/25/18, 13:20:49
	// ----------------------------------------------------
	//Created : 
	Mods_2018_10
	// Modified by: Costas Manousakis-(Designer)-(4/21/21 13:05:32)
	Mods_2021_04
	//  `force ob get to return correct type
End if 
//
Case of 
	: (Form event code:C388=On Load:K2:1)
		
		
	: (Form event code:C388=On Clicked:K2:4)
		If (Right click:C712 | Macintosh control down:C544 | Contextual click:C713)
			C_LONGINT:C283($row_L)
			$row_L:=LISTBOX1
			
			If ($row_L>0)
				//make sure photo is not blank
				
				If (Picture size:C356(INVPHOTOINSPAPPR_AP{$row_L})>0)
					
					//check if photo already used as approach or elevation
					C_TEXT:C284($menuref_txt; $selected_txt)
					ARRAY TEXT:C222($Choises_atxt; 0)
					ARRAY TEXT:C222($ChoiseCmds_atxt; 0)
					
					Case of 
						: (v_113_001_aL{$row_L}=v_113_005_L)
							//already as approach
							ARRAY TEXT:C222($Choises_atxt; 2)
							ARRAY TEXT:C222($ChoiseCmds_atxt; 2)
							$Choises_atxt{1}:="Select as Elevation"
							$ChoiseCmds_atxt{1}:="Elevation"
							$Choises_atxt{2}:="Remove from Approach selection"
							$ChoiseCmds_atxt{2}:="ClearAppr"
							
						: (v_113_001_aL{$row_L}=v_113_001_L)
							//already as elevation
							ARRAY TEXT:C222($Choises_atxt; 2)
							ARRAY TEXT:C222($ChoiseCmds_atxt; 2)
							$Choises_atxt{1}:="Select as Approach"
							$ChoiseCmds_atxt{1}:="Approach"
							$Choises_atxt{2}:="Remove from Elevation selection"
							$ChoiseCmds_atxt{2}:="ClearElev"
							
						Else 
							ARRAY TEXT:C222($Choises_atxt; 2)
							ARRAY TEXT:C222($ChoiseCmds_atxt; 2)
							$Choises_atxt{1}:="Select as Approach"
							$ChoiseCmds_atxt{1}:="Approach"
							$Choises_atxt{2}:="Select as Elevation"
							$ChoiseCmds_atxt{2}:="Elevation"
							
					End case 
					
					$menuref_txt:=MENU_BuildMenuFromArrays(->$Choises_atxt; ->$ChoiseCmds_atxt; "")
					$selected_txt:=Dynamic pop up menu:C1006($menuref_txt)
					
					C_BOOLEAN:C305($Apply_b)
					
					Case of 
						: ($selected_txt="Approach")
							$Apply_b:=True:C214
							//is there a different approach selected?
							
							If ((v_113_005_L>0) & (v_113_005_L#v_113_001_aL{$row_L}))
								C_LONGINT:C283($currPhoto_L)
								$currPhoto_L:=Find in array:C230(v_113_001_aL; v_113_005_L)
								CONFIRM:C162("Replace "+v_113_003_atxt{$currPhoto_L}+" with "+v_113_003_atxt{$row_L})
								$Apply_b:=(OK=1)
							End if 
							If ($Apply_b)
								OBJECT SET TITLE:C194(*; "ApproachDescr"; v_113_003_atxt{$row_L})
								v_113_005_L:=v_113_001_aL{$row_L}
								//if this was Elevation - clear the elevation
								If (v_113_001_L=v_113_005_L)
									OBJECT SET TITLE:C194(*; "ElevationDescr"; OB Get:C1224(SelectInvPhotoData_o; "DefElevLabel"; Is text:K8:3))
									v_113_001_L:=0
								End if 
								
							End if 
							
						: ($selected_txt="Elevation")
							$Apply_b:=True:C214
							//is there a different Elevation selected?
							
							If ((v_113_001_L>0) & (v_113_001_L#v_113_001_aL{$row_L}))
								C_LONGINT:C283($currPhoto_L)
								$currPhoto_L:=Find in array:C230(v_113_001_aL; v_113_001_L)
								CONFIRM:C162("Replace "+v_113_003_atxt{$currPhoto_L}+" with "+v_113_003_atxt{$row_L})
								$Apply_b:=(OK=1)
							End if 
							If ($Apply_b)
								OBJECT SET TITLE:C194(*; "ElevationDescr"; v_113_003_atxt{$row_L})
								v_113_001_L:=v_113_001_aL{$row_L}
								
								//if this was approach - clear the approach
								If (v_113_001_L=v_113_005_L)
									OBJECT SET TITLE:C194(*; "ApproachDescr"; OB Get:C1224(SelectInvPhotoData_o; "DefApprLabel"; Is text:K8:3))
									v_113_005_L:=0
									
								End if 
								
							End if 
							
						: ($selected_txt="ClearAppr")
							OBJECT SET TITLE:C194(*; "ApproachDescr"; OB Get:C1224(SelectInvPhotoData_o; "DefApprLabel"; Is text:K8:3))
							v_113_005_L:=0
							
						: ($selected_txt="ClearElev")
							OBJECT SET TITLE:C194(*; "ElevationDescr"; OB Get:C1224(SelectInvPhotoData_o; "DefElevLabel"; Is text:K8:3))
							v_113_001_L:=0
							
					End case 
					
				Else 
					ALERT:C41("Selection is a blank photo!")
				End if 
				
			End if 
		End if 
		
End case 

//End SelectInvPhoto.List Box