//%attributes = {"invisible":true}
//Method: DEV_FindStaticPictures
//Description
// Find static pictures on forms 
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 07/03/18, 14:07:57
	// ----------------------------------------------------
	//Created : 
	Mods_2018_07
End if 
//

C_LONGINT:C283($numTables_L; $table_loop; $loop2_L)
//start the bar
C_OBJECT:C1216($myprogress_O)
ARRAY TEXT:C222($Messages_atxt; 0)

$numTables_L:=Get last table number:C254
$myprogress_O:=ProgressNew("Scanning table forms "; $numTables_L; True:C214; " Tables"; 3)

For ($table_loop; 1; $numTables_L)
	If (Is table number valid:C999($table_loop))
		UpdateProgressNew($myprogress_O; $table_loop)
		
		ARRAY TEXT:C222($formnames_atxt; 0)
		FORM GET NAMES:C1167(Table:C252($table_loop)->; $formnames_atxt)
		C_LONGINT:C283($loop_L)
		//start the bar
		C_OBJECT:C1216($formsProgress_o)
		$formsProgress_o:=ProgressNew("Scanning Forms for "+Table name:C256($table_loop); Size of array:C274($formnames_atxt); True:C214; " Forms"; 3)
		
		For ($loop_L; 1; Size of array:C274($formnames_atxt))
			//update progress
			UpdateProgressNew($formsProgress_o; $loop_L)
			
			FORM LOAD:C1103(Table:C252($table_loop)->; $formnames_atxt{$loop_L})
			C_OBJECT:C1216($FormObjects_o)
			CLEAR VARIABLE:C89($FormObjects_o)
			DEV_GetFormObjects($formnames_atxt{$loop_L}; $table_loop; ->$FormObjects_o)
			ARRAY OBJECT:C1221($formObjects_ao; 0)
			OB GET ARRAY:C1229($FormObjects_o; "Form Objects"; $formObjects_ao)
			For ($loop2_L; 1; Size of array:C274($formObjects_ao))
				If (OB Get:C1224($formObjects_ao{$loop2_L}; "Type"; Is longint:K8:6)=Object type static picture:K79:3)
					If (OB Get:C1224($formObjects_ao{$loop2_L}; "Display Format"; Is text:K8:3)="")
						//ALERT("Table "+OB Get($FormObjects_o;"Table Name")+" Form Name "+OB Get($FormObjects_o;"Form Name")+" Static picture "+OB Get($formObjects_ao{$loop2_L};"Name")+" on page "+OB Get($formObjects_ao{$loop2_L};"Page Number";Is text)+" must go to library!")
						APPEND TO ARRAY:C911($Messages_atxt; OB Get:C1224($FormObjects_o; "Table Name"; Is text:K8:3)+Char:C90(Tab:K15:37)+OB Get:C1224($FormObjects_o; "Form Name"; Is text:K8:3)+Char:C90(Tab:K15:37)+OB Get:C1224($formObjects_ao{$loop2_L}; "Name"; Is text:K8:3)+Char:C90(Tab:K15:37)+OB Get:C1224($formObjects_ao{$loop2_L}; "Page Number"; Is text:K8:3))
					End if 
				End if 
			End for 
			
			//check if progress stopped
			If (Progress Stopped(OB Get:C1224($formsProgress_o; "progress"; Is longint:K8:6)))
				$loop_L:=Size of array:C274($formnames_atxt)+1
			End if 
			
		End for 
		//quit progress
		Progress QUIT(OB Get:C1224($formsProgress_o; "progress"; Is longint:K8:6))
		
	End if 
	//check if progress stopped
	If (Progress Stopped(OB Get:C1224($myprogress_O; "progress"; Is longint:K8:6)))
		//abort loop
		$table_loop:=$numTables_L+1
	End if 
	
End for 
//quit progress
Progress QUIT(OB Get:C1224($myprogress_O; "progress"; Is longint:K8:6))


//End DEV_FindStaticPictures