//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 10/07/10, 11:08:12
	// ----------------------------------------------------
	// Method: SIA_PasteLatLon
	// Description
	//  ` Copy the Lat and or Long values from the clipboard to the respective fields on
	//  ` the [Bridge MHD NBIS] table. Designed to be run from a button on the input form.
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2010_10
	Mods_2011_06  // CJ Miller`06/20/11, 10:12:38      ` Type all local variables for v11
End if 
C_POINTER:C301($vp)
C_LONGINT:C283($tbl_L; $Fld_L)
$vp:=Focus object:C278  // will work only if the focus is on one of the lat lon fields
C_TEXT:C284($Varname)
RESOLVE POINTER:C394($vp; $Varname; $tbl_L; $Fld_L)
C_BOOLEAN:C305($LatLonFld_b)
$LatLonFld_b:=($Fld_L=Field:C253(->[Bridge MHD NBIS:1]Item16A:68)) | ($Fld_L=Field:C253(->[Bridge MHD NBIS:1]Item16B:69)) | ($Fld_L=Field:C253(->[Bridge MHD NBIS:1]Item16C:109))
$LatLonFld_b:=$LatLonFld_b | ($Fld_L=Field:C253(->[Bridge MHD NBIS:1]Item17A:70)) | ($Fld_L=Field:C253(->[Bridge MHD NBIS:1]Item17B:71)) | ($Fld_L=Field:C253(->[Bridge MHD NBIS:1]Item17C:136))

If ($tbl_L=Table:C252(->[Bridge MHD NBIS:1])) & $LatLonFld_b
	C_TEXT:C284($clip; $delim_txt; $DelimList_txt)
	$clip:=Get text from pasteboard:C524
	$clip:=f_TrimStr($clip; True:C214; True:C214)
	
	$DelimList_txt:=" =:;,"+<>sTAB
	C_LONGINT:C283($loop_L)
	For ($loop_L; 1; Length:C16($DelimList_txt))
		If (Position:C15(Substring:C12($DelimList_txt; $loop_L; 1); $clip)>0)
			$delim_txt:=Substring:C12($DelimList_txt; $loop_L; 1)
			$loop_L:=Length:C16($DelimList_txt)+1
		End if 
		
	End for 
	ARRAY TEXT:C222($ListofNumbers_atxt; 0)
	ut_TextToArray($clip; ->$ListofNumbers_atxt; $delim_txt)
	C_REAL:C285($Degrees_R; $Sec_R)
	C_POINTER:C301($degFld_ptr; $minFld_ptr; $secFld_ptr)
	C_BOOLEAN:C305($DoCopy_b)
	ARRAY REAL:C219($ListofDegrees_ar; 0)
	For ($loop_L; 1; Size of array:C274($ListofNumbers_atxt))
		$Degrees_R:=Abs:C99(Num:C11($ListofNumbers_atxt{$loop_L}))
		If ($Degrees_R>0)
			APPEND TO ARRAY:C911($ListofDegrees_ar; $Degrees_R)
			If (Size of array:C274($ListofDegrees_ar)=2)
				//end the loop
				$loop_L:=Size of array:C274($ListofNumbers_atxt)+1
			End if 
			
		End if 
	End for 
	If (Size of array:C274($ListofDegrees_ar)>0)
		$DoCopy_b:=True:C214
		For ($loop_L; 1; Size of array:C274($ListofDegrees_ar))
			If (($ListofDegrees_ar{$loop_L}>41.2) & ($ListofDegrees_ar{$loop_L}<42.9)) | (($ListofDegrees_ar{$loop_L}>69.93) & ($ListofDegrees_ar{$loop_L}<73.51))
			Else 
				$DoCopy_b:=False:C215  //not in range - do not copy
			End if 
			
		End for 
		If ($DoCopy_b)
			For ($loop_L; 1; Size of array:C274($ListofDegrees_ar))
				$Degrees_R:=$ListofDegrees_ar{$loop_L}
				$DoCopy_b:=False:C215
				If ($Degrees_R>0)
					Case of 
						: ($Degrees_R>41.2) & ($Degrees_R<42.9)
							//lat
							$DoCopy_b:=True:C214
							$degFld_ptr:=->[Bridge MHD NBIS:1]Item16A:68
							$minFld_ptr:=->[Bridge MHD NBIS:1]Item16B:69
							$secFld_ptr:=->[Bridge MHD NBIS:1]Item16C:109
							
						: ($Degrees_R>69.93) & ($Degrees_R<73.51)
							$DoCopy_b:=True:C214
							$degFld_ptr:=->[Bridge MHD NBIS:1]Item17A:70
							$minFld_ptr:=->[Bridge MHD NBIS:1]Item17B:71
							$secFld_ptr:=->[Bridge MHD NBIS:1]Item17C:136
							//lon -not here
					End case 
					If ($DoCopy_b)
						C_LONGINT:C283($Deg_L; $Min_L)
						$Deg_L:=Trunc:C95($Degrees_R; 0)
						$Degrees_R:=$Degrees_R-$Deg_L
						$Degrees_R:=$Degrees_R*60
						$Min_L:=Trunc:C95($Degrees_R; 0)
						$Sec_R:=$Degrees_R-$Min_L
						$Sec_R:=$Sec_R*60
						$Sec_R:=Trunc:C95($Sec_R; 4)
						$degFld_ptr->:=$Deg_L
						$minFld_ptr->:=$Min_L
						$secFld_ptr->:=$Sec_R
						PushChange(1; $degFld_ptr)
						PushChange(1; $minFld_ptr)
						PushChange(1; $secFld_ptr)
					Else 
						//There was a real value but was not within parameters!
						ALERT:C41("Value: "+String:C10($Degrees_R)+" not between 41.2 and 42.9 or 69.93 and 73.51")
					End if 
					
				End if 
			End for 
			
		Else 
			C_TEXT:C284($msg_txt)
			If (Size of array:C274($ListofDegrees_ar)=1)
				$msg_txt:="Value in clipboard "+String:C10($ListofDegrees_ar{1})+" is"
			Else 
				$msg_txt:="One or both of the values in clipboard "+String:C10($ListofDegrees_ar{1})+" , "+String:C10($ListofDegrees_ar{2})+" are"
			End if 
			$msg_txt:=$msg_txt+" not in the range of [41.2-42.9] or  [69.93-73.51] !!!"
			ALERT:C41($msg_txt)
		End if 
	Else 
		ALERT:C41("No Values in the Clipboard!!!")
	End if 
	
	ARRAY TEXT:C222($ListofNumbers_atxt; 0)
	ARRAY REAL:C219($ListofDegrees_ar; 0)
End if 