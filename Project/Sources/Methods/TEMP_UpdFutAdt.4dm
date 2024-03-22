//%attributes = {"invisible":true}
If (False:C215)
	//GP  TEMP_UpdFutAdt
	
	//purpose: update future ADT fields (114, 115) for bridges in the current selectio
	
	// Modified by: costasmanousakis-(Designer)-(2/28/2007 16:25:29)
	Mods_2007_CM07
End if 
C_LONGINT:C283($i; $k; $Recs)
C_REAL:C285($ADT_f)  // factor by which to multiply future adt's 
//C_LONGINT($ADT_y)  ` year of future adt
C_LONGINT:C283($ADT_y_c)  // current entry for year of future adt
C_LONGINT:C283($ADT_c)  // current ADT
C_LONGINT:C283($Insp_y)  // year of current inspection
C_BOOLEAN:C305($ReadonlyOn_b)
$ReadonlyOn_b:=Read only state:C362([Bridge MHD NBIS:1])
$Recs:=Records in selection:C76([Bridge MHD NBIS:1])

$ADT_f:=1.5793  //from MHD Coding guide
// $ADT_y:=2019
$k:=0
C_LONGINT:C283($Option_L)
$Option_L:=ut_3Option_Confirm("Run ADT update on current list of "+String:C10($Recs; "##,##0")+" record(s)?"; "Current"; "New Search"; "Cancel")
Case of 
	: ($Option_L=2)
		QUERY:C277([Bridge MHD NBIS:1])
		If (OK=1)
			$Recs:=Records in selection:C76([Bridge MHD NBIS:1])
		Else 
			$Option_L:=3  //Cancel
		End if 
End case 
If ($Option_L<3)
	CONFIRM:C162("Update Future ADTs of "+String:C10($Recs; "##,##0")+" record(s) by "+String:C10($ADT_f)+" and 21 years from Inspection year ?")
	If (OK=1)
		
		ARRAY POINTER:C280(ptr_Changes; 0; 0)
		
		InitChangeStack(1)
		FIRST RECORD:C50([Bridge MHD NBIS:1])
		For ($i; 1; $Recs)
			$Insp_y:=Year of:C25([Bridge MHD NBIS:1]Item90:161)
			$ADT_c:=[Bridge MHD NBIS:1]Item29:88
			$ADT_y_c:=[Bridge MHD NBIS:1]Item115:160
			If ($ADT_y_c<($Insp_y+21))
				// ALERT(" insp y = "+String($Insp_y)+" ADT y = "+String($ADT_y_c))
				[Bridge MHD NBIS:1]Item114:159:=$ADT_c*$ADT_f
				//cannot have more than 6 digits ADT
				If ([Bridge MHD NBIS:1]Item114:159>999999)
					[Bridge MHD NBIS:1]Item114:159:=999999
				End if 
				[Bridge MHD NBIS:1]Item115:160:=$Insp_y+21
				PushChange(1; ->[Bridge MHD NBIS:1]Item114:159)
				PushChange(1; ->[Bridge MHD NBIS:1]Item115:160)
				FlushGrpChgs(1; ->[Bridge MHD NBIS:1]BIN:3; ->[Bridge MHD NBIS:1]BIN:3; ->[Bridge MHD NBIS:1]BIN:3; 0)
				SAVE RECORD:C53([Bridge MHD NBIS:1])
				
				$k:=$k+1
				
			End if 
			
			If ($i%10=0)  //Don't slow down things just to display
				GOTO XY:C161(1; 1)
				MESSAGE:C88("Record "+String:C10($i)+" of "+String:C10($Recs))
			End if 
			NEXT RECORD:C51([Bridge MHD NBIS:1])
		End for 
		ALERT:C41("Updated "+String:C10($k)+" of "+String:C10($Recs)+" total selected records")
		CLOSE WINDOW:C154
	End if 
	
End if 
