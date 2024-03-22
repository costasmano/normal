//%attributes = {"invisible":true}
//Method: NTI_PONHELP_FM
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 04/22/16, 11:52:26
	// ----------------------------------------------------
	//Created : 
	Mods_2016_NTE
	
	C_LONGINT:C283(NTI_PONHELP_FM; $1)
	
	// Modified by: Costas Manousakis-(Designer)-(5/28/19 16:52:05)
	Mods_2019_05_bug
	//  `because web area was changed to use integrated webkit, had to define var $Filespec_txt depending on platform (windows works with 3 "/", Mac OS with 2
	// Modified by: Costas Manousakis-(Designer)-(10/2/19 16:25:12)
	Mods_2019_10_bug
	//  `make all tables RO.
	// Modified by: Costas Manousakis-(Designer)-(2021-09-24T00:00:00 09:51:10)
	Mods_2021_09
	//  //Fix for use in OSX 10.14
	//  `onload event just initialize webarea, then call on timer, and there call the On Outside call event
	//  `don't create temp file, instead use WA SET PAGE CONTENT
End if 
//
C_LONGINT:C283($FormEvent_L)
If (Count parameters:C259>0)
	C_LONGINT:C283($1)
	$FormEvent_L:=$1
Else 
	$FormEvent_L:=Form event code:C388
End if 

C_TEXT:C284($Filespec_txt)

If (<>PL_LPLATFRM=Windows:K25:3)
	$Filespec_txt:="file://"
Else 
	$Filespec_txt:="file://"
End if 


Case of 
	: ($FormEvent_L=On Close Detail:K2:24)
		
	: ($FormEvent_L=On Load:K2:1)
		//make sure all tables are RO
		READ ONLY:C145(*)
		
		//on load just initialize the area
		WA OPEN URL:C1020(*; "PON_WebArea"; "about:blank")
		
		SET TIMER:C645(1)
		
	: ($FormEvent_L=On Timer:K2:25)
		
		NTI_PONHELP_FM(On Outside Call:K2:11)
		SET TIMER:C645(0)
		
	: ($FormEvent_L=On Outside Call:K2:11)
		PON_HELPWINTITLE_TXT:="Somebody called us! for element "+String:C10(PON_NEWELEMENTNO_L)
		If (PON_NEWELEMENTNO_L=-999)
			// we have to close
			CANCEL:C270
		Else 
			
			PON_HELPWINTITLE_TXT:=NTI_LoadElementHelp(PON_NEWELEMENTNO_L)
			WA SET PAGE CONTENT:C1037(*; "PON_WebArea"; PON_HELPWINTITLE_TXT; $Filespec_txt)
			
			BRING TO FRONT:C326(Current process:C322)
		End if 
End case 
//End NTI_PONHELP_FM