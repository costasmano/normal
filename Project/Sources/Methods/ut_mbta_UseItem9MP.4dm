//%attributes = {"invisible":true}
//Method: ut_mbta_UseItem9MP
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 04/18/13, 11:05:57
	// ----------------------------------------------------
	//Created : 
	Mods_2013_04
	
End if 
//

ARRAY LONGINT:C221($posF_aL; 0)
ARRAY LONGINT:C221($lefF_aL; 0)
C_BOOLEAN:C305($SaveChanges_b; $LogChanges_b; $FixItem11_b)
SET AUTOMATIC RELATIONS:C310(False:C215; False:C215)
ut_StartMessage(3; "Mileposts"; 800; 500)
QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]InspResp:173="MBTA")
QUERY SELECTION:C341([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]Item8 BridgeCat:207="RRO")
CONFIRM:C162("Narrow down selection of "+String:C10(Records in selection:C76([Bridge MHD NBIS:1]))+" bridge records?"; "Reduce Selection"; "Keep")
If (OK=1)
	QUERY SELECTION:C341([Bridge MHD NBIS:1])
End if 
ALERT:C41("Scanning "+String:C10(Records in selection:C76([Bridge MHD NBIS:1]))+" bridge records!")
$SaveChanges_b:=False:C215
$LogChanges_b:=False:C215
$FixItem11_b:=False:C215
CONFIRM:C162("Save Changes to Bridge and Rail info records?"; "Save"; "Don't Save")
$SaveChanges_b:=(OK=1)
If ($SaveChanges_b)
	CONFIRM:C162("Log Changes made to Bridge and Rail info records?"; "Log"; "Don't Log")
	$LogChanges_b:=(OK=1)
End if 
CONFIRM:C162("Fix Item 11 to match Milepost?"; "FIX"; "Leave as Is")
$FixItem11_b:=(OK=1)
FIRST RECORD:C50([Bridge MHD NBIS:1])
C_BOOLEAN:C305($MP_in_9_b)
C_REAL:C285($MP_Item9_r)
C_TEXT:C284($Line_Item9_txt; $MP_Item9_txt; $msg_txt)

If (Type:C295(ptr_Changes)#Array 2D:K8:24)
	ARRAY POINTER:C280(ptr_Changes; 0; 0)
End if 
InitChangeStack(1)
InitChangeStack(2)
C_TEXT:C284(vsForward)  // Command Replaced was o_C_STRING length was 80

While (Not:C34(End selection:C36([Bridge MHD NBIS:1])))
	ARRAY LONGINT:C221($posF_aL; 0)
	ARRAY LONGINT:C221($lefF_aL; 0)
	$MP_Item9_r:=0
	$Line_Item9_txt:=""
	$MP_Item9_txt:=""
	$MP_in_9_b:=Match regex:C1019("(.*)( MP )([0-9]*)(.*)"; [Bridge MHD NBIS:1]Item9:66; 1; $posF_aL; $lefF_aL)
	ut_Message([Bridge MHD NBIS:1]BIN:3+Char:C90(9)+[Bridge MHD NBIS:1]BDEPT:1+Char:C90(9)+[Bridge MHD NBIS:1]Item8:206+Char:C90(9)+[Bridge MHD NBIS:1]Item7:65+Char:C90(9)+[Bridge MHD NBIS:1]Item6A:63+Char:C90(9)+[Bridge MHD NBIS:1]Item9:66)
	ut_Message(Char:C90(9)+[Bridge MHD NBIS:1]RRBranch:210+Char:C90(9)+String:C10([Bridge MHD NBIS:1]RRBridgeNo:211)+Char:C90(9)+String:C10([Bridge MHD NBIS:1]Item11:67))
	If ($MP_in_9_b)
		$Line_Item9_txt:=Substring:C12([Bridge MHD NBIS:1]Item9:66; $posF_aL{1}; $lefF_aL{1})
		$MP_Item9_txt:=Substring:C12([Bridge MHD NBIS:1]Item9:66; $posF_aL{3})
		$MP_Item9_r:=Num:C11($MP_Item9_txt)
		ut_Message(Char:C90(9)+"["+$Line_Item9_txt+"]"+Char:C90(9)+"["+$MP_Item9_txt+"]"+Char:C90(9)+String:C10($MP_Item9_r))
		
		If ([Bridge MHD NBIS:1]RRBranch:210="")
			[Bridge MHD NBIS:1]RRBranch:210:=$Line_Item9_txt
			PushChange(1; ->[Bridge MHD NBIS:1]RRBranch:210)
			ut_Message(Char:C90(9)+"[Bridge MHD NBIS]RRBranch:="+$Line_Item9_txt)
		Else 
			ut_Message(Char:C90(9))
		End if 
		
		If ([Bridge MHD NBIS:1]RRBridgeNo:211=0)
			If ($MP_Item9_r>0)
				[Bridge MHD NBIS:1]RRBridgeNo:211:=$MP_Item9_r
				ut_Message(Char:C90(9)+"[Bridge MHD NBIS]RRBridgeNo:="+String:C10($MP_Item9_r))
			Else 
				If ([Bridge MHD NBIS:1]Item11:67>0)
					[Bridge MHD NBIS:1]RRBridgeNo:211:=Round:C94(([Bridge MHD NBIS:1]Item11:67*0.621371); 3)
					PushChange(1; ->[Bridge MHD NBIS:1]RRBridgeNo:211)
					ut_Message(Char:C90(9)+"[Bridge MHD NBIS]RRBridgeNo:= Item 11  :"+String:C10(Round:C94(([Bridge MHD NBIS:1]Item11:67*0.621371); 3)))
				Else 
					ut_Message(Char:C90(9))
				End if 
				
			End if 
		Else 
			ut_Message(Char:C90(9))
		End if 
		
		If ([Bridge MHD NBIS:1]Item11:67=0)
			
			If ([Bridge MHD NBIS:1]RRBridgeNo:211>0)
				[Bridge MHD NBIS:1]Item11:67:=Round:C94(([Bridge MHD NBIS:1]RRBridgeNo:211/0.621371); 4)
				PushChange(1; ->[Bridge MHD NBIS:1]Item11:67)
				ut_Message(Char:C90(9)+"[Bridge MHD NBIS]Item11:= RRBridgeNo  :"+String:C10(Round:C94(([Bridge MHD NBIS:1]RRBridgeNo:211/0.621371); 4)))
			Else 
				ut_Message(Char:C90(9))
			End if 
			
		Else 
			If (([Bridge MHD NBIS:1]RRBridgeNo:211>0) & $FixItem11_b & (Round:C94([Bridge MHD NBIS:1]Item11:67; 3)#Round:C94(Round:C94(([Bridge MHD NBIS:1]RRBridgeNo:211/0.621371); 4); 3)))
				[Bridge MHD NBIS:1]Item11:67:=Round:C94(([Bridge MHD NBIS:1]RRBridgeNo:211/0.621371); 4)
				PushChange(1; ->[Bridge MHD NBIS:1]Item11:67)
				ut_Message(Char:C90(9)+"[Bridge MHD NBIS]Item11:= RRBridgeNo  :"+String:C10(Round:C94(([Bridge MHD NBIS:1]RRBridgeNo:211/0.621371); 4)))
			Else 
				ut_Message(Char:C90(9))
			End if 
			
		End if 
		
	Else 
		ut_Message(5*Char:C90(9))
		
		If ([Bridge MHD NBIS:1]Item11:67=0)
			
			If ([Bridge MHD NBIS:1]RRBridgeNo:211>0)
				[Bridge MHD NBIS:1]Item11:67:=Round:C94(([Bridge MHD NBIS:1]RRBridgeNo:211/0.621371); 4)
				PushChange(1; ->[Bridge MHD NBIS:1]Item11:67)
				ut_Message(Char:C90(9)+"[Bridge MHD NBIS]Item11:= RRBridgeNo  :"+String:C10(Round:C94(([Bridge MHD NBIS:1]RRBridgeNo:211/0.621371); 4)))
			Else 
				ut_Message(Char:C90(9))
			End if 
			
		Else 
			If (([Bridge MHD NBIS:1]RRBridgeNo:211>0) & $FixItem11_b)
				[Bridge MHD NBIS:1]Item11:67:=Round:C94(([Bridge MHD NBIS:1]RRBridgeNo:211/0.621371); 4)
				PushChange(1; ->[Bridge MHD NBIS:1]Item11:67)
				ut_Message(Char:C90(9)+"[Bridge MHD NBIS]Item11:= RRBridgeNo  :"+String:C10(Round:C94(([Bridge MHD NBIS:1]RRBridgeNo:211/0.621371); 4)))
			Else 
				ut_Message(Char:C90(9))
			End if 
			
		End if 
		
	End if 
	ut_Message(Char:C90(9)+[Bridge MHD NBIS:1]RRBranch:210+Char:C90(9)+String:C10([Bridge MHD NBIS:1]RRBridgeNo:211)+Char:C90(9)+String:C10([Bridge MHD NBIS:1]Item11:67))
	ut_Message(Char:C90(9)+String:C10(Round:C94(Abs:C99([Bridge MHD NBIS:1]RRBridgeNo:211-Round:C94(([Bridge MHD NBIS:1]Item11:67*0.621371); 4)); 2)))
	
	QUERY:C277([RAILBridgeInfo:37]; [RAILBridgeInfo:37]BIN:1=[Bridge MHD NBIS:1]BIN:3)
	
	If (Records in selection:C76([RAILBridgeInfo:37])=1)
		ut_Message(Char:C90(9)+"Rail "+[RAILBridgeInfo:37]LineName:6+Char:C90(9)+String:C10([RAILBridgeInfo:37]MilePt:2))
		If ([RAILBridgeInfo:37]LineName:6="")
			If ([Bridge MHD NBIS:1]RRBranch:210#"")
				[RAILBridgeInfo:37]LineName:6:=[Bridge MHD NBIS:1]RRBranch:210
				PushChange(2; ->[RAILBridgeInfo:37]LineName:6)
				ut_Message(Char:C90(9)+"[RAILBridgeInfo]LineName:="+[Bridge MHD NBIS:1]RRBranch:210)
			Else 
				ut_Message(Char:C90(9))
			End if 
			
		Else 
			ut_Message(Char:C90(9))
		End if 
		
		If ([RAILBridgeInfo:37]MilePt:2=0)
			If ([Bridge MHD NBIS:1]RRBridgeNo:211>0)
				[RAILBridgeInfo:37]MilePt:2:=[Bridge MHD NBIS:1]RRBridgeNo:211
				PushChange(2; ->[RAILBridgeInfo:37]MilePt:2)
				ut_Message(Char:C90(9)+"[RAILBridgeInfo]MilePt:="+String:C10([Bridge MHD NBIS:1]RRBridgeNo:211))
			Else 
				ut_Message(Char:C90(9))
			End if 
		Else 
			ut_Message(Char:C90(9))
		End if 
		
		If (Modified record:C314([RAILBridgeInfo:37]))
			[RAILBridgeInfo:37]ModifiedBy_s:20:=<>CurrentUser_Name
			[RAILBridgeInfo:37]Modified_Date_d:21:=Current date:C33(*)
			[RAILBridgeInfo:37]Modified_Time_t:22:=Current time:C178(*)
			PushChange(2; ->[RAILBridgeInfo:37]CreatedBy_s:17)
			PushChange(2; ->[RAILBridgeInfo:37]Created_Date_d:18)
			PushChange(2; ->[RAILBridgeInfo:37]Created_Time_t:19)
			
			If ($SaveChanges_b)
				
				If ($LogChanges_b)
					FlushGrpChgs(2; ->[RAILBridgeInfo:37]BIN:1; ->[RAILBridgeInfo:37]BIN:1; ->[RAILBridgeInfo:37]BIN:1; 0)
				End if 
				SAVE RECORD:C53([RAILBridgeInfo:37])
			End if 
			
		End if 
	Else 
		If ($SaveChanges_b)
			CREATE RECORD:C68([RAILBridgeInfo:37])
			[RAILBridgeInfo:37]BIN:1:=[Bridge MHD NBIS:1]BIN:3
			[RAILBridgeInfo:37]MilePt:2:=[Bridge MHD NBIS:1]RRBridgeNo:211
			[RAILBridgeInfo:37]LineName:6:=[Bridge MHD NBIS:1]RRBranch:210
			[RAILBridgeInfo:37]CreatedBy_s:17:=<>CurrentUser_Name
			[RAILBridgeInfo:37]Created_Date_d:18:=Current date:C33(*)
			[RAILBridgeInfo:37]Created_Time_t:19:=Current time:C178(*)
			ut_Message(Char:C90(9)+"New Rail "+[RAILBridgeInfo:37]LineName:6+Char:C90(9)+String:C10([RAILBridgeInfo:37]MilePt:2))
			ut_Message(Char:C90(9)+"[RAILBridgeInfo]LineName:="+[Bridge MHD NBIS:1]RRBranch:210)
			ut_Message(Char:C90(9)+"[RAILBridgeInfo]MilePt:="+String:C10([Bridge MHD NBIS:1]RRBridgeNo:211))
			
			If ($LogChanges_b)
				LogNewRecord(->[RAILBridgeInfo:37]BIN:1; ->[RAILBridgeInfo:37]BIN:1; ->[RAILBridgeInfo:37]BIN:1; 0; "")
				PushChange(2; ->[RAILBridgeInfo:37]CreatedBy_s:17)
				PushChange(2; ->[RAILBridgeInfo:37]Created_Date_d:18)
				PushChange(2; ->[RAILBridgeInfo:37]Created_Time_t:19)
				PushChange(2; ->[RAILBridgeInfo:37]MilePt:2)
				PushChange(2; ->[RAILBridgeInfo:37]LineName:6)
				FlushGrpChgs(2; ->[RAILBridgeInfo:37]BIN:1; ->[RAILBridgeInfo:37]BIN:1; ->[RAILBridgeInfo:37]BIN:1; 0)
			End if 
			SAVE RECORD:C53([RAILBridgeInfo:37])
		End if 
		
	End if 
	ut_Message(Char:C90(13))
	If (Modified record:C314([Bridge MHD NBIS:1]))
		If ($SaveChanges_b)
			[Bridge MHD NBIS:1]Modified By:191:=<>CurrentUser_Name
			[Bridge MHD NBIS:1]DateModified:194:=Current date:C33(*)
			[Bridge MHD NBIS:1]TimeModified:195:=Current time:C178(*)
			PushChange(2; ->[RAILBridgeInfo:37]CreatedBy_s:17)
			PushChange(2; ->[RAILBridgeInfo:37]Created_Date_d:18)
			PushChange(2; ->[RAILBridgeInfo:37]Created_Time_t:19)
			
			If ($LogChanges_b)
				FlushGrpChgs(1; ->[Bridge MHD NBIS:1]BIN:3; ->[Bridge MHD NBIS:1]BIN:3; ->[Bridge MHD NBIS:1]BIN:3; 0)
			End if 
			SAVE RECORD:C53([Bridge MHD NBIS:1])
		End if 
		
	End if 
	
	NEXT RECORD:C51([Bridge MHD NBIS:1])
End while 
TRACE:C157
ut_CloseMessage

//End ut_mbta_UseItem9MP