If (False:C215)
	// Modified by: Costas Manousakis-(Designer)-(12/21/18 16:30:37)
	Mods_2018_12_bug
	//  ` added to copy the list to a text in pasteboard
End if 

If (LBGeneric_ab>0)
	C_LONGINT:C283($OpenCount_L)
	C_LONGINT:C283($loop_L; $parts_L; $progress_L)
	$OpenCount_L:=0
	$progress_L:=0
	C_TEXT:C284($forClipboard_txt; $path_txt)
	$forClipboard_txt:=""
	If (Size of array:C274(LBGeneric_atxt)>5000)
		$progress_L:=Progress New
		Progress SET TITLE($progress_L; "Copying List to pasteboard...")
		Progress SET MESSAGE($progress_L; "Copying List to pasteboard...")
		
	End if 
	For ($loop_L; 1; Size of array:C274(LBGeneric_ab))
		$path_txt:=Substring:C12(LBGeneric_atxt{$loop_L}; 23)
		ARRAY TEXT:C222($parts_atxt; 0)
		Case of 
			: ($path_txt="[tableForm]@")
				$path_txt:=Substring:C12($path_txt; Length:C16("[tableForm]/")+1)
				ut_TextToArray($path_txt; ->$parts_atxt; "/")
				$path_txt:="["+$parts_atxt{1}+"];"+Char:C90(Double quote:K15:41)+$parts_atxt{2}+Char:C90(Double quote:K15:41)
				For ($parts_L; 3; Size of array:C274($parts_atxt))
					$path_txt:=$path_txt+"."+$parts_atxt{$parts_L}
				End for 
				
			: ($path_txt="[projectForm]@")
				$path_txt:=Substring:C12($path_txt; Length:C16("[projectForm]/")+1)
				ut_TextToArray($path_txt; ->$parts_atxt; "/")
				$path_txt:=Char:C90(Double quote:K15:41)+$parts_atxt{1}+Char:C90(Double quote:K15:41)
				For ($parts_L; 2; Size of array:C274($parts_atxt))
					$path_txt:=$path_txt+"."+$parts_atxt{$parts_L}
				End for 
				
			Else 
				
		End case 
		
		$forClipboard_txt:=$forClipboard_txt+$path_txt+Char:C90(13)
	End for 
	If ($progress_L#0)
		Progress QUIT($progress_L)
	End if 
	SET TEXT TO PASTEBOARD:C523($forClipboard_txt)
	ALERT:C41("Copied list of methods to pasteboard! Size of text is "+String:C10(Length:C16($forClipboard_txt)))
End if 

//End MethodsList.Button1