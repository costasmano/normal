//%attributes = {"invisible":true}
// ----------------------------------------------------
// ut_CompareUsersToPersonnel
// User name (OS): charlesmiller
// Date and time: 03/03/11, 14:57:17
// ----------------------------------------------------
// Description
//  ` Create a report comparing info from the Personnel table and
//  ` the 4D Users  
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2011_03  //r002 CJ Miller`03/03/11, 14:57:19      `
	Mods_2011_06  // CJ Miller`06/20/11, 10:33:03      ` Type all local variables for v11
End if 

ARRAY TEXT:C222($UserNames_atxt; 0)
ARRAY LONGINT:C221($UserNumbers_al; 0)

GET USER LIST:C609($UserNames_atxt; $UserNumbers_al)
C_TEXT:C284($Name_txt; $StartUp_txt; $Password_txt)
C_LONGINT:C283($NumberofLogins_l; $SizeofNoPersonnel_l; $SizeofOldLogins_l; $SizeofTooMany_l)
$SizeofNoPersonnel_l:=1
$SizeofOldLogins_l:=1
$SizeofTooMany_l:=1
C_DATE:C307($lastLogin_d; $Compare_d)
$Compare_d:=Add to date:C393(Current date:C33; -2; 0; 0)
ARRAY TEXT:C222($OldLogins_atxt; 1)
ARRAY TEXT:C222($NoPersonnel_atxt; 1)
ARRAY TEXT:C222($ToManyPersonnel_atxt; 1)
C_LONGINT:C283($Loop_l)

For ($Loop_l; 1; Size of array:C274($UserNumbers_al))
	
	If (Not:C34(Is user deleted:C616($UserNumbers_al{$Loop_l})))
		
		GET USER PROPERTIES:C611($UserNumbers_al{$Loop_l}; $Name_txt; $StartUp_txt; $Password_txt; $NumberofLogins_l; $lastLogin_d)
		If ($lastLogin_d>=$Compare_d)
			QUERY:C277([Personnel:42]; [Personnel:42]UserID_4D:12=$UserNumbers_al{$Loop_l})
			Case of 
				: (Records in selection:C76([Personnel:42])=0)
					If (Length:C16($NoPersonnel_atxt{$SizeofNoPersonnel_l})>25000)
						APPEND TO ARRAY:C911($NoPersonnel_atxt; "")
						$SizeofNoPersonnel_l:=$SizeofNoPersonnel_l+1
					End if 
					$NoPersonnel_atxt{$SizeofNoPersonnel_l}:=$NoPersonnel_atxt{$SizeofNoPersonnel_l}+$UserNames_atxt{$Loop_l}+" - "+String:C10($UserNumbers_al{$Loop_l})+Char:C90(Carriage return:K15:38)
					
				: (Records in selection:C76([Personnel:42])=1)
				Else 
					If (Length:C16($ToManyPersonnel_atxt{$SizeofTooMany_l})>25000)
						APPEND TO ARRAY:C911($ToManyPersonnel_atxt; "")
						$SizeofTooMany_l:=$SizeofTooMany_l+1
					End if 
					$ToManyPersonnel_atxt{$SizeofTooMany_l}:=$ToManyPersonnel_atxt{$SizeofTooMany_l}+$UserNames_atxt{$Loop_l}+" - "+String:C10($UserNumbers_al{$Loop_l})+Char:C90(Carriage return:K15:38)
					
			End case 
			
		Else 
			If (Length:C16($OldLogins_atxt{$SizeofOldLogins_l})>25000)
				APPEND TO ARRAY:C911($OldLogins_atxt; "")
				$SizeofOldLogins_l:=$SizeofOldLogins_l+1
			End if 
			$OldLogins_atxt{$SizeofOldLogins_l}:=$OldLogins_atxt{$SizeofOldLogins_l}+$UserNames_atxt{$Loop_l}+" - "+String:C10($UserNumbers_al{$Loop_l})+" "+String:C10($lastLogin_d)+Char:C90(Carriage return:K15:38)
			
		End if 
		
	End if 
	
End for 
C_TEXT:C284($DocName_txt)
$DocName_txt:=""
C_TIME:C306($Doc)
$Doc:=Create document:C266("")
If (OK=1)
	$DocName_txt:=Document
	If ($OldLogins_atxt{1}#"")
		SEND PACKET:C103($Doc; "List of old users."+Char:C90(Carriage return:K15:38))
		For ($Loop_l; 1; $SizeofOldLogins_l)
			SEND PACKET:C103($Doc; $OldLogins_atxt{$loop_l})
		End for 
		SEND PACKET:C103($Doc; "End ==========="+Char:C90(Carriage return:K15:38)+Char:C90(Carriage return:K15:38))
	End if 
	
	If ($NoPersonnel_atxt{1}#"")
		SEND PACKET:C103($Doc; "List of Missing personnel records."+Char:C90(Carriage return:K15:38))
		For ($Loop_l; 1; $SizeofNoPersonnel_l)
			SEND PACKET:C103($Doc; $NoPersonnel_atxt{$loop_l})
		End for 
		SEND PACKET:C103($Doc; "End ==========="+Char:C90(Carriage return:K15:38)+Char:C90(Carriage return:K15:38))
	End if 
	
	If ($ToManyPersonnel_atxt{1}#"")
		SEND PACKET:C103($Doc; "List ofToo many personnel records."+Char:C90(Carriage return:K15:38))
		For ($Loop_l; 1; $SizeofTooMany_l)
			SEND PACKET:C103($Doc; $ToManyPersonnel_atxt{$loop_l})
		End for 
		SEND PACKET:C103($Doc; "End ==========="+Char:C90(Carriage return:K15:38)+Char:C90(Carriage return:K15:38))
	End if 
	
End if 

CLOSE DOCUMENT:C267($Doc)
If ($DocName_txt#"")
	ut_OpenDocument($DocName_txt)
End if 


//End ut_CompareUsersToPersonnel