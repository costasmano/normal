//%attributes = {"invisible":true}
// ----------------------------------------------------
// ut_ResetUserStartUp
// User name (OS): charlesmiller
// Date and time: 04/12/11, 10:32:31
// ----------------------------------------------------
// Description
//  ` Clear the startup method of users which has been set to "x"
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2011_04  //r002 CJ Miller`04/12/11, 10:32:35      `Fix bugs found during testing of initial release of v11
	Mods_2011_06  // CJ Miller`06/20/11, 10:34:17      ` Type all local variables for v11
End if 

C_TIME:C306($doc)
ARRAY TEXT:C222($UserNames_atxt; 0)
ARRAY LONGINT:C221($UserNumbers_al; 0)
C_DATE:C307($LastLogin_d)
GET USER LIST:C609($UserNames_atxt; $UserNumbers_al)
C_LONGINT:C283($Loop_l; $UserID_l; $NumberofLogins_l)
C_TEXT:C284($Name_txt; $StartUp_txt; $Password_txt; $GroupOwner_txt)
C_TEXT:C284($Changes_txt; $DocPath_txt)

For ($Loop_l; 1; Size of array:C274($UserNumbers_al))
	If (Not:C34(Is user deleted:C616($UserNumbers_al{$Loop_l})))
		ARRAY LONGINT:C221($Membership_aL; 0)
		GET USER PROPERTIES:C611($UserNumbers_al{$Loop_l}; $Name_txt; $StartUp_txt; $Password_txt; $NumberofLogins_l; $LastLogin_d; $Membership_aL; $GroupOwner_txt)
		If ($StartUp_txt="x")
			
			$UserID_l:=Set user properties:C612($UserNumbers_al{$Loop_l}; $Name_txt; ""; *; $NumberofLogins_l; $LastLogin_d; $Membership_aL)
			$Changes_txt:=$Changes_txt+String:C10($UserNumbers_al{$Loop_l})+Char:C90(Tab:K15:37)+$Name_txt+Char:C90(Carriage return:K15:38)
			If (Length:C16($Changes_txt)>25000)
				If ($DocPath_txt="")
					$Doc:=Create document:C266("")
					$DocPath_txt:=document
				Else 
					$doc:=Append document:C265($DocPath_txt)
				End if 
				SEND PACKET:C103($doc; $Changes_txt)
				CLOSE DOCUMENT:C267($doc)
			End if 
		End if 
	End if 
	
End for 

If ($DocPath_txt="")
	$Doc:=Create document:C266("")
	$DocPath_txt:=document
Else 
	$doc:=Append document:C265($DocPath_txt)
End if 
SEND PACKET:C103($doc; $Changes_txt)
CLOSE DOCUMENT:C267($doc)

//End ut_ResetUserStartUp