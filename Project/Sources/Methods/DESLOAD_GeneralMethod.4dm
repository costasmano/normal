//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 10/03/08, 09:38:41
	// ----------------------------------------------------
	// Method: DESLOAD_GeneralMethod
	// Description
	// Method that contains modules used in the [Design Load]"Translation" form interface
	// 
	// Parameters
	// $1 : Function
	// ----------------------------------------------------
	
	Mods_2008_CM_5404  // ("DESIGNMODS")
	// Modified by: costasmanousakis-(Designer)-(11/2/10 21:06:42)
	Mods_2010_11  //Copied to Server on : 11/08/10, 10:04:27
	//  `Changed dialog to ListBox, added the description, initialize the translation if it does not exist at the start,
	//  `options to reload codes from the table and adjust translation. 
End if 
C_TEXT:C284($1)
Case of 
	: ($1="LAUNCH")
		C_LONGINT:C283($iwn; $Fw; $fH)
		FORM GET PROPERTIES:C674([Design Load:6]; "Translation"; $Fw; $fH)
		NewWindow($Fw; $fH; 0; Plain window:K34:13; "Translation")
		DIALOG:C40([Design Load:6]; "Translation")
		//CLOSE WINDOW
		
	: ($1="ARRAYCLICK")
		C_LONGINT:C283($indx)
		$indx:=FHWAItem31_atxt
		FHWAItem31_txt:=FHWAItem31_atxt{$indx}
		MHDItem31_txt:=MHDItem31_atxt{$indx}
		MHDItem31Desc_txt:=MHDItem31Desc_atxt{$indx}
		GOTO OBJECT:C206(FHWAItem31_txt)
		
	: ($1="DATACHANGE")
		C_LONGINT:C283($indx)
		$indx:=FHWAItem31_atxt
		If ($indx>0)
			FHWAItem31_atxt{$indx}:=FHWAItem31_txt
		Else 
			APPEND TO ARRAY:C911(FHWAItem31_atxt; FHWAItem31_txt)
			APPEND TO ARRAY:C911(MHDItem31_atxt; "")
		End if 
		
	: ($1="UPDATE")
		ARRAY TEXT:C222($MHDItem31Reload_atxt; 0)
		ARRAY TEXT:C222(MHDItem31Desc_atxt; 0)
		COPY NAMED SELECTION:C331([Design Load:6]; "DesignLoadSELECT")
		ALL RECORDS:C47([Design Load:6])
		SELECTION TO ARRAY:C260([Design Load:6]Code:1; $MHDItem31Reload_atxt; [Design Load:6]Description:2; MHDItem31Desc_atxt)
		USE NAMED SELECTION:C332("DesignLoadSELECT")
		CLEAR NAMED SELECTION:C333("DesignLoadSELECT")
		ARRAY TEXT:C222($FHWAItem31Reload_atxt; Size of array:C274($MHDItem31Reload_atxt))
		C_LONGINT:C283($loop_L; $PrevIndx_L)
		For ($loop_L; 1; Size of array:C274($FHWAItem31Reload_atxt))
			$PrevIndx_L:=Find in array:C230(MHDItem31_atxt; $MHDItem31Reload_atxt{$loop_L})
			If ($PrevIndx_L>0)
				$FHWAItem31Reload_atxt{$loop_L}:=FHWAItem31_atxt{$PrevIndx_L}
				
			Else 
				$FHWAItem31Reload_atxt{$loop_L}:=$MHDItem31Reload_atxt{$loop_L}
			End if 
		End for 
		SORT ARRAY:C229($MHDItem31Reload_atxt; $FHWAItem31Reload_atxt; MHDItem31Desc_atxt)
		COPY ARRAY:C226($MHDItem31Reload_atxt; MHDItem31_atxt)
		COPY ARRAY:C226($FHWAItem31Reload_atxt; FHWAItem31_atxt)
		
	: ($1="FORMLOAD")
		ARRAY TEXT:C222(MHDItem31_atxt; 0)
		ARRAY TEXT:C222(MHDItem31Desc_atxt; 0)
		C_TEXT:C284($MHDCodes_txt; $FHWACodes_txt)
		$MHDCodes_txt:=ut_GetSysParameter("SIA_DESLOADCODE_MHD"; ""; "VALUE")
		If (Replace string:C233($MHDCodes_txt; ","; "")="")
			COPY NAMED SELECTION:C331([Design Load:6]; "DesignLoadSELECT")
			ALL RECORDS:C47([Design Load:6])
			SELECTION TO ARRAY:C260([Design Load:6]Code:1; MHDItem31_atxt; [Design Load:6]Description:2; MHDItem31Desc_atxt)
			USE NAMED SELECTION:C332("DesignLoadSELECT")
			CLEAR NAMED SELECTION:C333("DesignLoadSELECT")
		Else 
			ut_TextToArray($MHDCodes_txt; ->MHDItem31_atxt; ",")
			ARRAY TEXT:C222(MHDItem31Desc_atxt; Size of array:C274(MHDItem31_atxt))
			COPY NAMED SELECTION:C331([Design Load:6]; "DesignLoadSELECT")
			C_LONGINT:C283($loop_L)
			For ($loop_L; 1; Size of array:C274(MHDItem31_atxt))
				QUERY:C277([Design Load:6]; [Design Load:6]Code:1=MHDItem31_atxt{$loop_L})
				MHDItem31Desc_atxt{$loop_L}:=[Design Load:6]Description:2
			End for 
			USE NAMED SELECTION:C332("DesignLoadSELECT")
			CLEAR NAMED SELECTION:C333("DesignLoadSELECT")
		End if 
		
		ARRAY TEXT:C222(FHWAItem31_atxt; 0)
		$FHWACodes_txt:=ut_GetSysParameter("SIA_DESLOADCODE_FHWA"; ""; "VALUE")
		If (Replace string:C233($FHWACodes_txt; ","; "")="")
			ARRAY TEXT:C222(FHWAItem31_atxt; Size of array:C274(MHDItem31_atxt))
			C_LONGINT:C283($i)
			For ($i; 1; Size of array:C274(MHDItem31_atxt))
				FHWAItem31_atxt{$i}:=MHDItem31_atxt{$i}
			End for 
		Else 
			ut_TextToArray($FHWACodes_txt; ->FHWAItem31_atxt; ",")
		End if 
		
		C_TEXT:C284(FHWAItem31_txt; MHDItem31_txt; MHDItem31Desc_txt)
		FHWAItem31_txt:=""
		MHDItem31_txt:=""
		MHDItem31Desc_txt:=""
		If (Type:C295(MHDItem31TransLB)=Boolean array:K8:21)
			LISTBOX SELECT ROW:C912(MHDItem31TransLB; 0; 2)
		End if 
		
	: ($1="APPLY")
		
		C_TEXT:C284($ParamStore_txt; $FHWACodeOld_txt; $MHDCodeOld_txt)
		C_LONGINT:C283($i)
		$ParamStore_txt:=FHWAItem31_atxt{1}
		For ($i; 2; Size of array:C274(FHWAItem31_atxt))
			$ParamStore_txt:=$ParamStore_txt+","+FHWAItem31_atxt{$i}
		End for 
		QUERY:C277([Parameters:107]; [Parameters:107]ParamCode:1="SIA_DESLOADCODE_FHWA")
		If (Records in selection:C76([Parameters:107])=0)
			CREATE RECORD:C68([Parameters:107])
			[Parameters:107]ParamCode:1:="SIA_DESLOADCODE_FHWA"
			SAVE RECORD:C53([Parameters:107])
		End if 
		$FHWACodeOld_txt:=[Parameters:107]Value:3
		If (ut_LoadRecordInteractive(->[Parameters:107]))
			[Parameters:107]Value:3:=$ParamStore_txt
			SAVE RECORD:C53([Parameters:107])
			$ParamStore_txt:=MHDItem31_atxt{1}
			For ($i; 2; Size of array:C274(MHDItem31_atxt))
				$ParamStore_txt:=$ParamStore_txt+","+MHDItem31_atxt{$i}
			End for 
			QUERY:C277([Parameters:107]; [Parameters:107]ParamCode:1="SIA_DESLOADCODE_MHD")
			If (Records in selection:C76([Parameters:107])=0)
				CREATE RECORD:C68([Parameters:107])
				[Parameters:107]ParamCode:1:="SIA_DESLOADCODE_MHD"
				SAVE RECORD:C53([Parameters:107])
			End if 
			If (ut_LoadRecordInteractive(->[Parameters:107]))
				[Parameters:107]Value:3:=$ParamStore_txt
				SAVE RECORD:C53([Parameters:107])
				COPY ARRAY:C226(FHWAItem31_atxt; <>FHWAItm31Codes_atxt)
				COPY ARRAY:C226(MHDItem31_atxt; <>MHDItm31Codes_atxt)
			Else 
				ALERT:C41("Could not load Parameter record SIA_DESLOADCODE_MHD ! Reverting FHWA Code changes"+"!")
				QUERY:C277([Parameters:107]; [Parameters:107]ParamCode:1="SIA_DESLOADCODE_FHWA")
				If (ut_LoadRecordInteractive(->[Parameters:107]))
					[Parameters:107]Value:3:=$FHWACodeOld_txt
					SAVE RECORD:C53([Parameters:107])
				End if 
			End if 
		Else 
			ALERT:C41("Could not load Parameter record SIA_DESLOADCODE_FHWA ! Changes not saved!")
		End if 
		
End case 