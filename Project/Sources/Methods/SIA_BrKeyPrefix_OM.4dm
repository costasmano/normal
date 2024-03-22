//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 12/22/09, 09:06:05
	// ----------------------------------------------------
	// Method: SIA_BrKeyPrefix_OM
	// Description
	//SC aKeyDescr_ on layout [Bridge MHD NBIS];"BDEPT Input".
	//Copyright © 1997, Thomas D. Nee, All Rights Reserved.
	
	//Pop up menu for Structure Number Prefix.
	
	// 
	// Parameters
	// ----------------------------------------------------
	
	Mods_2009_12
	Mods_2012_12  //r001 ` Add code for new inspection types
	//Modified by: Charles Miller (12/13/12 14:05:29)
	
End if 

C_TEXT:C284(vKeyDescr)  // Command Replaced was o_C_STRING length was 30
C_TEXT:C284($Prefix)  // Command Replaced was o_C_STRING length was 3
C_LONGINT:C283($codes; $i)  //Command Replaced was o_C_INTEGER

REDRAW:C174(aKeyDescr_)
If ((Form event code:C388=On Clicked:K2:4) & (aKeyDescr_>0))
	vKeyDescr:=aKeyDescr_{aKeyDescr_}
End if 
Case of 
	: ((Form event code:C388=On Load:K2:1) | (aKeyDescr_=0))
		aKeyDescr_:=Find in array:C230(aKeyCodes_; Substring:C12([Bridge MHD NBIS:1]Bridge Key:2; 1; 3))
		If (aKeyDescr_<=0)  //Just in case nothing was found in array
			aKeyDescr_:=0
			vKeyDescr:="Structure No. prefix..."
		Else 
			vKeyDescr:=aKeyDescr_{aKeyDescr_}
		End if 
		
	: (Form event code:C388=On Clicked:K2:4)
		[Bridge MHD NBIS:1]Bridge Key:2:=Change string:C234([Bridge MHD NBIS:1]Bridge Key:2; aKeyCodes_{aKeyDescr_}; 1)
		PushChange(1; ->[Bridge MHD NBIS:1]Bridge Key:2)
		
		$Prefix:=Substring:C12([Bridge MHD NBIS:1]Bridge Key:2; 1; 3)
		If (($Prefix="BRI") | ($Prefix="CUL") | ($Prefix="PED") | ($Prefix="BLD"))
			LIST TO ARRAY:C288("Owner Codes Descr"; aOwnerDescr)
			$codes:=Size of array:C274(aOwnerDescr)
			ARRAY TEXT:C222(aOwnerCodes; $codes)  //Command Replaced was o_ARRAY string length was 1
			For ($i; 1; $codes)
				aOwnerCodes{$i}:=Substring:C12(aOwnerDescr{$i}; 1; 1)
			End for 
			aOwnerDescr:=Find in array:C230(aOwnerCodes; Substring:C12([Bridge MHD NBIS:1]Bridge Key:2; 7; 1))
			If (aOwnerDescr<=0)  //Just in case nothing was found in array
				aOwnerDescr:=0
				vOwnerDescr:="Select owner..."
			Else 
				vOwnerDescr:=aOwnerDescr{aOwnerDescr}
			End if 
		Else 
			ARRAY TEXT:C222(aOwnerDescr; 0)
			ARRAY TEXT:C222(aOwnerCodes; 0)  //Command Replaced was o_ARRAY string length was 1
			vOwnerDescr:="Not Applicable."
		End if 
End case 