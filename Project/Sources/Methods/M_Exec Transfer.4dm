//%attributes = {"invisible":true}
//procedure:  M_Exec Transfer
//for the menu do the data transfer

If (False:C215)
	// Modified by: Costas Manousakis-(Designer)-(3/28/16 10:22:01)
	Mods_2016_03_bug
	//  `if Shift or Mac command key is down launch process to do a delayed transfer; will check if there is either a transfer going on,
	//  ` or a delay already in process
	
	//launches processs with these two methods
	ut_ControlDBSycnh
	ut_DelayDBSynch
	// Modified by: Costas Manousakis-(Designer)-(5/27/20 17:28:19)
	Mods_2020_05
	//  `added option to hold mac command key for delayed transfer
	// Modified by: Costas Manousakis-(Designer)-(7/15/20 17:30:07)
	Mods_2020_07
	//  `removed Alert when launching normal
	// Modified by: Costas Manousakis-(Designer)-(3/17/21 15:27:14)
	Mods_2021_03
	//  `for district server user on district db ask if an immed ./iate transfer is to be done or at intervals
	// Modified by: Costas Manousakis-(Designer)-(4/26/21 15:39:33)
	Mods_2021_04
	//  `added option for other users to do delay transfers if Cmd or Shift key are pressed.
End if 

C_LONGINT:C283($Lpid; $LPIDTransf_L)
C_BOOLEAN:C305($Immediate_b)
$Immediate_b:=True:C214
If (Current user:C182="District@Server") & (Structure file:C489="District@BMS Server.4DC")
	//if the district server user is logged into the District server compiled db
	CONFIRM:C162("Do you want to execute a transfer immediately or start transfers at an interval?"; "Immediate"; "Interval")
	$Immediate_b:=(OK=1)
Else 
	//for everyone else , check to see if the cmd key or the shift key is presses while running this command
	If (Macintosh command down:C546 | Shift down:C543)
		
		CONFIRM:C162("Do you want to execute a transfer immediately or start transfers at an interval?"; "Immediate"; "Interval")
		$Immediate_b:=(OK=1)
		
	End if 
End if 
If (Not:C34($Immediate_b))
	
	$Lpid:=LProcessID("Delayed Transfer")
	$LPIDTransf_L:=LProcessID("Data Transfer")
	C_DATE:C307(vDate)
	C_TIME:C306(v_1_195_tm)
	If ($LPIDTransf_L>0)
		ALERT:C41("A Data Transfer is already in progress. You should make sure that you set the start time of the Delayed transfer past the expected  finish of the current transfer!")
	End if 
	ALERT:C41("Launching Delay transfer")
	$Lpid:=LSpawnProcess("ut_DelayDBSynch"; <>LStackSize; "Delayed Transfer"; True:C214; False:C215)  //name MUST BE Delayed Transfer = see ut_RunDBSynch
	
Else 
	
	$Lpid:=LSpawnProcess("ut_ControlDBSycnh"; <>LStackSize; "Data Transfer"; True:C214; False:C215)
	
End if 