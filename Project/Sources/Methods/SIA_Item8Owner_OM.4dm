//%attributes = {"invisible":true}
// Method: SIA_Item8Owner_OM
// Description
// New method to be called from two forms
//  `Pop up menu for Item8 OwnerCode
// 
// Parameters
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 12/22/09, 08:57:15
	// ----------------------------------------------------
	
	Mods_2009_12
	// Modified by: costasmanousakis-(Designer)-(1/8/10 11:44:04)
	Mods_2010_01
	//  `Added code to adjust Legacy Owner field also.
	// Modified by: Costas Manousakis-(Designer)-(8/19/13 17:16:42)
	Mods_2013_08
	//  `use element 0 to display the  "Select...." prompt
	// Modified by: Costas Manousakis-(Designer)-(2/2/15 10:15:25)
	Mods_2015_02
	//  `Added optional parameter to check from which form we were called. -
	//  ` don't change legacy owner when adding a new bridge record (Form [bridge mhd nbis].BDEPT INPUT)
	// Modified by: Costas Manousakis-(Designer)-(5/29/18 11:38:04)
	Mods_2018_05
	//  `removed reference to vIt8OwnerDes
	// Modified by: Costas Manousakis-(Designer)-(9/17/18 10:05:17)
	Mods_2018_09
	//  `enhanced choises for Confirm for Legacy Owner changes
End if 

//C_TEXT(vIt8OwnerDes)// Command Replaced was o_C_STRING length was 50
C_TEXT:C284($Calledfrom_txt)
$Calledfrom_txt:=""

If (Count parameters:C259>0)
	C_TEXT:C284($1)
	$Calledfrom_txt:=$1
End if 

REDRAW:C174(aIt8OwnerDes_)
Case of 
	: ((Form event code:C388=On Load:K2:1) | (aIt8OwnerDes_=0))
		aIt8OwnerDes_:=Find in array:C230(aIt8OwnerCode_; Substring:C12([Bridge MHD NBIS:1]Item8:206; 10; 3))
		If (aIt8OwnerDes_<=0)  //Just in case nothing was found in array
			aIt8OwnerDes_:=0
			aIt8OwnerDes_{0}:="Select Bridge Owner..."
			//vIt8OwnerDes:="Select Bridge Owner..."
		Else 
			//vIt8OwnerDes:=aIt8OwnerDes_{aIt8OwnerDes_}
		End if 
	: (Form event code:C388=On Clicked:K2:4)
		If ((aIt8OwnerCode_{aIt8OwnerDes_}="MHD") | (aIt8OwnerCode_{aIt8OwnerDes_}="MTA") | (aIt8OwnerCode_{aIt8OwnerDes_}="MHS"))
			ALERT:C41("Due to the MassDOT transition cannot Assign "+aIt8OwnerCode_{aIt8OwnerDes_}+" as an Owner any more!")
			aIt8OwnerDes_:=Find in array:C230(aIt8OwnerCode_; Substring:C12([Bridge MHD NBIS:1]Item8:206; 10; 3))
			If (aIt8OwnerDes_<=0)  //Just in case nothing was found in array
				aIt8OwnerDes_:=0
				//vIt8OwnerDes:="Select Bridge Owner..."
				aIt8OwnerDes_{0}:="Select Bridge Owner..."
			Else 
				//vIt8OwnerDes:=aIt8OwnerDes_{aIt8OwnerDes_}
			End if 
		Else 
			
			[Bridge MHD NBIS:1]Item8:206:=Change string:C234([Bridge MHD NBIS:1]Item8:206; aIt8OwnerCode_{aIt8OwnerDes_}; 10)
			[Bridge MHD NBIS:1]Item8:206:=Change string:C234([Bridge MHD NBIS:1]Item8:206; [Bridge MHD NBIS:1]BDEPT:1; 1)
			[Bridge MHD NBIS:1]Item8:206:=Change string:C234([Bridge MHD NBIS:1]Item8:206; [Bridge MHD NBIS:1]BIN:3; 7)
			PushChange(1; ->[Bridge MHD NBIS:1]Item8:206)
			C_TEXT:C284($msg_txt)
			//first compare the new owner with the stored owner code and THEN change item8 owner field
			If ($Calledfrom_txt#"[bridge mhd nbis].BDEPT INPUT.@")  //not called from the Add Bridge record form
				If ((aIt8OwnerCode_{aIt8OwnerDes_}="DOT") & ([Bridge MHD NBIS:1]Item8 Owner:208#"DOT"))
					$msg_txt:="You are changing Owner from "+[Bridge MHD NBIS:1]Item8 Owner:208+" to  DOT.  Do you also want to "
					If ([Bridge MHD NBIS:1]LegacyOwner:226="")
						$msg_txt:=$msg_txt+"set the Legacy Owner to "+[Bridge MHD NBIS:1]Item8 Owner:208+"?"
					Else 
						$msg_txt:=$msg_txt+"change the Legacy Owner from "+[Bridge MHD NBIS:1]LegacyOwner:226+" to "+[Bridge MHD NBIS:1]Item8 Owner:208+"?"
					End if 
					CONFIRM:C162($msg_txt; "Change Legacy Owner to "+[Bridge MHD NBIS:1]Item8 Owner:208; "Do not change")
					If (OK=1)
						[Bridge MHD NBIS:1]LegacyOwner:226:=[Bridge MHD NBIS:1]Item8 Owner:208
						PushChange(1; ->[Bridge MHD NBIS:1]LegacyOwner:226)
					End if 
				Else 
					If ([Bridge MHD NBIS:1]LegacyOwner:226#"")
						$msg_txt:="You are changing Owner from "+[Bridge MHD NBIS:1]Item8 Owner:208+" to "+aIt8OwnerCode_{aIt8OwnerDes_}+".  Do you also want to "
						$msg_txt:=$msg_txt+"clear the Legacy Owner from "+[Bridge MHD NBIS:1]LegacyOwner:226+"?"
						CONFIRM:C162($msg_txt; "Clear Legacy Owner"; "Leave Legacy Owner as "+[Bridge MHD NBIS:1]LegacyOwner:226)
						If (OK=1)
							[Bridge MHD NBIS:1]LegacyOwner:226:=""
							PushChange(1; ->[Bridge MHD NBIS:1]LegacyOwner:226)
						End if 
						
					End if 
					
				End if 
			End if 
			[Bridge MHD NBIS:1]Item8 Owner:208:=aIt8OwnerCode_{aIt8OwnerDes_}
			PushChange(1; ->[Bridge MHD NBIS:1]Item8 Owner:208)
			//vIt8OwnerDes:=aIt8OwnerDes_{aIt8OwnerDes_}
			
		End if 
		
End case 