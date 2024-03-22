//%attributes = {"invisible":true}
//Method: ut_runApplescript
//Description
// execute an applescript
// Parameters
// $0 : Result_txt
// $1 : $script_file_path_txt
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 11/18/15, 16:10:18
	// ----------------------------------------------------
	//Created : 
	Mods_2015_11
	C_TEXT:C284(ut_runApplescript; $0)
	C_TEXT:C284(ut_runApplescript; $1)
	
End if 
//

C_TEXT:C284($1; $0)

//_O_PLATFORM PROPERTIES($platform_l)// MassDOT_PS - conversion v19R7
If (Is macOS:C1572)
	C_TEXT:C284($script_file_path_txt; $path_system_txt; $target_volume_txt; $system_folder_txt; $boot_volume_txt; $standard_output_txt)
	
	$script_file_path_txt:=Replace string:C233($1; "/"; ":"; *)
	
	If (Test path name:C476($script_file_path_txt)=Is a document:K24:1)
		
		$path_system_txt:=Replace string:C233($script_file_path_txt; ":"; "/"; *)  //the POSIX separator
		$target_volume_txt:=Substring:C12($path_system_txt; 1; Position:C15("/"; $path_system_txt; *)-1)
		$system_folder_txt:=System folder:C487(System:K41:1)  // take care of the/Volumes/syntax
		$boot_volume_txt:=Substring:C12($system_folder_txt; 1; Position:C15(":"; $system_folder_txt; *)-1)
		$script_file_path_txt:=Choose:C955($boot_volume_txt=$target_volume_txt; Substring:C12($path_system_txt; Position:C15("/"; $path_system_txt; *)); "/Volumes/"+$path_system_txt)
		
		C_BLOB:C604($standard_input_x; $standard_output_x; $standard_error_x)
		LAUNCH EXTERNAL PROCESS:C811("osascript \""+$script_file_path_txt+"\""; $standard_input_x; $standard_output_x; $standard_error_x)
		$standard_output_txt:=Convert to text:C1012($standard_output_x; "UTF-8")
		
		If (BLOB size:C605($standard_error_x)#0) & (BLOB size:C605($standard_output_x)=0)
			$0:=Convert to text:C1012($standard_error_x; "UTF-8")
		Else 
			$0:=Substring:C12($standard_output_txt; 1; Length:C16($standard_output_txt)-1)
		End if 
		
	End if 
	
End if 
//End ut_runApplescript