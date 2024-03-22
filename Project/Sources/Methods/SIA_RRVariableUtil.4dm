//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 01/04/11, 16:56:43
	// ----------------------------------------------------
	// Method: SIA_RRVariableUtil
	// Description
	//  ` Utility for Rail SIA variables
	// 
	// Parameters
	// $1 : $Task_txt ("LOAD" | "SAVE" | "INIT" | "CANCEL" | "OBJECTEVENT" | "METERS-FTIN" | "FTIN-METERS" )
	// ----------------------------------------------------
	
	Mods_2011_01
	//`RR
	// Modified by: costasmanousakis-(Designer)-(8/30/11 08:33:05)
	Mods_2011_08
	//  `Added Code to handle the new check boxes for dimensions over 30M.
	Mods_2013_02  //r001 `  Remove [BridgeInfoLink] updates as we are going to update data on add only
	//Modified by: Charles Miller (2/26/13 16:35:13)
	// Modified by: Costas Manousakis-(Designer)-(3/4/14 12:51:29)
	Mods_2014_03
	//  `modified the messages when cancel 
	// Modified by: Costas Manousakis-(Designer)-(7/7/20 16:23:30)
	Mods_2020_07_bug
	//  `added call to PushAllChanges before saving the [RailBridgeInfo] record
End if 
C_TEXT:C284($1; $Task_txt)
$Task_txt:=$1
Case of 
	: ($Task_txt="INIT")
		//declare variables
		C_REAL:C285(SIA_RRItem48_r; SIA_RRItem49_r; SIA_RRItem50A_r; SIA_RRItem50B_r; SIA_RRItem51_r; SIA_RRItem52_r; SIA_RRItem34_r)
		C_REAL:C285(SIA_RRItem10Ft_r; SIA_RRItem10In_r; SIA_RRItem47_r; SIA_RRItem53Ft_r; SIA_RRItem53In_r)
		C_REAL:C285(SIA_RRItem54Ft_r; SIA_RRItem54In_r; SIA_RRItem55_r; SIA_RRItem56_r)
		C_REAL:C285(SIA_RRItem39_r; SIA_RRItem116_r; SIA_RRItem40_r)
		C_TEXT:C284(SIA_RRItem54A_s; SIA_RRItem55A_s)  // Command Replaced was o_C_STRING length was 1
		C_LONGINT:C283(SIA_RRItem35_L; SIA_Item10Over30_L; SIA_Item53Over30_L; SIA_Item54Over30_L; SIA_Item55Over30_L; SIA_Item56Over30_L)
		C_LONGINT:C283(SIA_FTRound_L)
		SIA_FTRound_L:=5
		Case of 
			: (FORM Get current page:C276=9)
				SIA_Tabs_atxt:=1
			: (FORM Get current page:C276=10)
				SIA_Tabs_atxt:=2
			Else 
				SIA_Tabs_atxt:=0
		End case 
		
	: ($Task_txt="LOAD")
		If ([Bridge MHD NBIS:1]Item35:101)
			SIA_RRItem35_L:=1
		Else 
			SIA_RRItem35_L:=0
		End if 
		
		SIA_RRItem48_r:=Round:C94([Bridge MHD NBIS:1]Item48:92/0.3048; SIA_FTRound_L)
		SIA_RRItem49_r:=Round:C94([Bridge MHD NBIS:1]Item49:93/0.3048; SIA_FTRound_L)
		SIA_RRItem50A_r:=Round:C94([Bridge MHD NBIS:1]Item50A:94/0.3048; SIA_FTRound_L)
		SIA_RRItem50B_r:=Round:C94([Bridge MHD NBIS:1]Item50B:95/0.3048; SIA_FTRound_L)
		SIA_RRItem51_r:=Round:C94([Bridge MHD NBIS:1]Item51:96/0.3048; SIA_FTRound_L)
		SIA_RRItem52_r:=Round:C94([Bridge MHD NBIS:1]Item52:97/0.3048; SIA_FTRound_L)
		SIA_RRItem34_r:=[Bridge MHD NBIS:1]Item34:100
		If ([Bridge MHD NBIS:1]Item10:102>30)
			SIA_RRItem10Ft_r:=99
			SIA_RRItem10In_r:=99
			SIA_Item10Over30_L:=1
		Else 
			SIA_RRVariableUtil("METERS-FTIN"; ->[Bridge MHD NBIS:1]Item10:102; ->SIA_RRItem10Ft_r; ->SIA_RRItem10In_r)
			SIA_Item10Over30_L:=0
		End if 
		
		SIA_RRItem47_r:=Round:C94([Bridge MHD NBIS:1]Item47:104/0.3048; SIA_FTRound_L)
		If ([Bridge MHD NBIS:1]Item53:105>30)
			SIA_RRItem53Ft_r:=99
			SIA_RRItem53In_r:=99
			SIA_Item53Over30_L:=1
		Else 
			SIA_RRVariableUtil("METERS-FTIN"; ->[Bridge MHD NBIS:1]Item53:105; ->SIA_RRItem53Ft_r; ->SIA_RRItem53In_r)
			SIA_Item53Over30_L:=0
		End if 
		
		SIA_RRItem54A_s:=[Bridge MHD NBIS:1]Item54A:107
		
		SIA_RRItem55A_s:=[Bridge MHD NBIS:1]Item55A:110
		If ([Bridge MHD NBIS:1]Item54B:108>30)
			SIA_RRItem54Ft_r:=99
			SIA_RRItem54In_r:=99
			SIA_Item54Over30_L:=1
		Else 
			SIA_RRVariableUtil("METERS-FTIN"; ->[Bridge MHD NBIS:1]Item54B:108; ->SIA_RRItem54Ft_r; ->SIA_RRItem54In_r)
			SIA_Item54Over30_L:=0
		End if 
		
		SIA_RRItem55_r:=Round:C94([Bridge MHD NBIS:1]Item55B:111/0.3048; SIA_FTRound_L)
		SIA_Item55Over30_L:=0
		If ([Bridge MHD NBIS:1]Item55B:111>30)
			SIA_RRItem55_r:=199
			SIA_Item55Over30_L:=1
		End if 
		
		SIA_RRItem56_r:=Round:C94([Bridge MHD NBIS:1]Item56:112/0.3048; SIA_FTRound_L)
		SIA_Item56Over30_L:=0
		If ([Bridge MHD NBIS:1]Item56:112>30)
			SIA_RRItem56_r:=199
			SIA_Item56Over30_L:=1
		End if 
		
		SIA_RRItem39_r:=Round:C94([Bridge MHD NBIS:1]Item39:115/0.3048; SIA_FTRound_L)
		SIA_RRItem116_r:=Round:C94([Bridge MHD NBIS:1]Item116:116/0.3048; SIA_FTRound_L)
		SIA_RRItem40_r:=Round:C94([Bridge MHD NBIS:1]Item40:117/0.3048; SIA_FTRound_L)
		SIA_RRItem76_r:=Round:C94([Bridge MHD NBIS:1]Item76:154/0.3048; SIA_FTRound_L)
		
	: ($Task_txt="SAVE")
		If ((Modified record:C314([Bridge MHD NBIS:1])) | (Modified record:C314([RAILBridgeInfo:37])))
			
			If ([Bridge MHD NBIS:1]RRBranch:210="")
				
				If ([RAILBridgeInfo:37]LineName:6#"")
					[Bridge MHD NBIS:1]RRBranch:210:=[RAILBridgeInfo:37]LineName:6
					PushChange(1; ->[Bridge MHD NBIS:1]RRBranch:210)
				End if 
			Else 
				
				If ([Bridge MHD NBIS:1]RRBranch:210#[RAILBridgeInfo:37]LineName:6)
					
				Else 
					
				End if 
				
			End if 
			
			If ([Bridge MHD NBIS:1]Item11:67=0)
				
				If ([RAILBridgeInfo:37]MilePt:2>0)
					[Bridge MHD NBIS:1]Item11:67:=Round:C94(([RAILBridgeInfo:37]MilePt:2/0.621371192); 4)
					PushChange(1; ->[Bridge MHD NBIS:1]Item11:67)
				End if 
				
			Else 
				
			End if 
			
			If ([Bridge MHD NBIS:1]RRBridgeNo:211=0)
				If ([RAILBridgeInfo:37]MilePt:2>0)
					[Bridge MHD NBIS:1]RRBridgeNo:211:=[RAILBridgeInfo:37]MilePt:2
					PushChange(1; ->[Bridge MHD NBIS:1]RRBridgeNo:211)
				End if 
				
			End if 
			
			If (Modified record:C314([Bridge MHD NBIS:1]))
				[Bridge MHD NBIS:1]Modified By:191:=<>CurrentUser_Name
				[Bridge MHD NBIS:1]DateModified:194:=Current date:C33(*)
				[Bridge MHD NBIS:1]TimeModified:195:=Current time:C178(*)
				PushChange(1; ->[Bridge MHD NBIS:1]Modified By:191)
				PushChange(1; ->[Bridge MHD NBIS:1]DateModified:194)
				PushChange(1; ->[Bridge MHD NBIS:1]TimeModified:195)
			End if 
			
			FlushGrpChgs(1; ->[Bridge MHD NBIS:1]BIN:3; ->[Bridge MHD NBIS:1]BIN:3; ->[Bridge MHD NBIS:1]BIN:3; 0)
			SAVE RECORD:C53([Bridge MHD NBIS:1])
			If (Modified record:C314([RAILBridgeInfo:37]))
				If (Is new record:C668([RAILBridgeInfo:37]))
					LogNewRecord(->[RAILBridgeInfo:37]BIN:1; ->[RAILBridgeInfo:37]BIN:1; ->[RAILBridgeInfo:37]BIN:1; 0; "")
					[RAILBridgeInfo:37]CreatedBy_s:17:=<>CurrentUser_Name
					[RAILBridgeInfo:37]Created_Date_d:18:=Current date:C33(*)
					[RAILBridgeInfo:37]Created_Time_t:19:=Current time:C178(*)
					PushChange(2; ->[RAILBridgeInfo:37]CreatedBy_s:17)
					PushChange(2; ->[RAILBridgeInfo:37]Created_Date_d:18)
					PushChange(2; ->[RAILBridgeInfo:37]Created_Time_t:19)
				End if 
				PushAllChanges(2; ->[RAILBridgeInfo:37]; ->[RAILBridgeInfo:37]BIN:1)
				[RAILBridgeInfo:37]ModifiedBy_s:20:=<>CurrentUser_Name
				[RAILBridgeInfo:37]Modified_Date_d:21:=Current date:C33(*)
				[RAILBridgeInfo:37]Modified_Time_t:22:=Current time:C178(*)
				PushChange(2; ->[RAILBridgeInfo:37]ModifiedBy_s:20)
				PushChange(2; ->[RAILBridgeInfo:37]Modified_Date_d:21)
				PushChange(2; ->[RAILBridgeInfo:37]Modified_Time_t:22)
				FlushGrpChgs(2; ->[RAILBridgeInfo:37]BIN:1; ->[RAILBridgeInfo:37]BIN:1; ->[RAILBridgeInfo:37]BIN:1; 0)
				SAVE RECORD:C53([RAILBridgeInfo:37])
			End if 
			ALERT:C41("The changes have been saved to the database!")
		End if 
		
	: ($Task_txt="CANCEL")
		If ((Modified record:C314([Bridge MHD NBIS:1])) | (Modified record:C314([RAILBridgeInfo:37])))
			C_TEXT:C284($Msg_txt)
			$Msg_txt:="Changes have been made to this record! Are you sure you want to Exit this form? These changes will be lost!"
			
			If (Is new record:C668([RAILBridgeInfo:37]))
				$Msg_txt:="You have initialized a new Rail/Transit information record! Are you sure you want to Exit this form? These changes will be lost!"
			End if 
			
			CONFIRM:C162($Msg_txt; "Exit"; "Stay in form")
			If (OK=1)
				CANCEL:C270
			End if 
		Else 
			CANCEL:C270
		End if 
		
	: ($Task_txt="OBJECTEVENT")
		C_POINTER:C301($2; $DataVar_ptr)
		$DataVar_ptr:=$2
		C_TEXT:C284($VarName_txt)
		C_LONGINT:C283($Tbl_L; $Fld_L)
		RESOLVE POINTER:C394($DataVar_ptr; $VarName_txt; $Tbl_L; $Fld_L)
		//ALERT("Variable "+$VarName_txt)
		
		Case of 
			: ($VarName_txt="SIA_RRItem35_L")
				[Bridge MHD NBIS:1]Item35:101:=(SIA_RRItem35_L=1)
				PushChange(1; ->[Bridge MHD NBIS:1]Item35:101)
				
			: ($VarName_txt="SIA_RRItem48_r")
				[Bridge MHD NBIS:1]Item48:92:=SIA_RRItem48_r*0.3048
				PushChange(1; ->[Bridge MHD NBIS:1]Item48:92)
			: ($VarName_txt="SIA_RRItem49_r")
				[Bridge MHD NBIS:1]Item49:93:=SIA_RRItem49_r*0.3048
				PushChange(1; ->[Bridge MHD NBIS:1]Item49:93)
				
			: ($VarName_txt="SIA_RRItem50A_r")
				[Bridge MHD NBIS:1]Item50A:94:=SIA_RRItem50A_r*0.3048
				PushChange(1; ->[Bridge MHD NBIS:1]Item50A:94)
			: ($VarName_txt="SIA_RRItem50B_r")
				[Bridge MHD NBIS:1]Item50B:95:=SIA_RRItem50B_r*0.3048
				PushChange(1; ->[Bridge MHD NBIS:1]Item50B:95)
				
			: ($VarName_txt="SIA_RRItem51_r")
				[Bridge MHD NBIS:1]Item51:96:=SIA_RRItem51_r*0.3048
				PushChange(1; ->[Bridge MHD NBIS:1]Item51:96)
				
			: ($VarName_txt="SIA_RRItem52_r")
				[Bridge MHD NBIS:1]Item52:97:=SIA_RRItem52_r*0.3048
				PushChange(1; ->[Bridge MHD NBIS:1]Item52:97)
				
			: ($VarName_txt="SIA_RRItem34_r")
				[Bridge MHD NBIS:1]Item34:100:=SIA_RRItem34_r
				PushChange(1; ->[Bridge MHD NBIS:1]Item34:100)
				
			: (($VarName_txt="SIA_RRItem10Ft_r") | ($VarName_txt="SIA_RRItem10In_r"))
				SIA_RRVariableUtil("FTIN-METERS"; ->[Bridge MHD NBIS:1]Item10:102; ->SIA_RRItem10Ft_r; ->SIA_RRItem10In_r)
				If ([Bridge MHD NBIS:1]Item10:102<=30)
					SIA_Item10Over30_L:=0
				Else 
					SIA_Item10Over30_L:=1
				End if 
				PushChange(1; ->[Bridge MHD NBIS:1]Item10:102)
				
			: ($VarName_txt="SIA_Item10Over30_L")
				If (SIA_Item10Over30_L=1)
					SIA_RRItem10Ft_r:=99
					SIA_RRItem10In_r:=99
					[Bridge MHD NBIS:1]Item10:102:=99.99
					PushChange(1; ->[Bridge MHD NBIS:1]Item10:102)
				End if 
				
			: ($VarName_txt="SIA_RRItem47_r")
				[Bridge MHD NBIS:1]Item47:104:=SIA_RRItem47_r*0.3048
				PushChange(1; ->[Bridge MHD NBIS:1]Item47:104)
				
			: (($VarName_txt="SIA_RRItem53Ft_r") | ($VarName_txt="SIA_RRItem53In_r"))
				SIA_RRVariableUtil("FTIN-METERS"; ->[Bridge MHD NBIS:1]Item53:105; ->SIA_RRItem53Ft_r; ->SIA_RRItem53In_r)
				If ([Bridge MHD NBIS:1]Item53:105<=30)
					SIA_Item53Over30_L:=0
				Else 
					SIA_Item53Over30_L:=1
				End if 
				
				PushChange(1; ->[Bridge MHD NBIS:1]Item53:105)
				
			: ($VarName_txt="SIA_Item53Over30_L")
				If (SIA_Item53Over30_L=1)
					[Bridge MHD NBIS:1]Item53:105:=99.99
					SIA_RRItem53Ft_r:=99
					SIA_RRItem53In_r:=99
					PushChange(1; ->[Bridge MHD NBIS:1]Item53:105)
				End if 
				
				
			: (($VarName_txt="SIA_RRItem54Ft_r") | ($VarName_txt="SIA_RRItem54In_r"))
				SIA_RRVariableUtil("FTIN-METERS"; ->[Bridge MHD NBIS:1]Item54B:108; ->SIA_RRItem54Ft_r; ->SIA_RRItem54In_r)
				If ([Bridge MHD NBIS:1]Item54B:108<=30)
					SIA_Item54Over30_L:=0
				Else 
					SIA_Item54Over30_L:=1
				End if 
				
				PushChange(1; ->[Bridge MHD NBIS:1]Item54B:108)
				
			: ($VarName_txt="SIA_Item54Over30_L")
				If (SIA_Item54Over30_L=1)
					[Bridge MHD NBIS:1]Item54B:108:=99.99
					SIA_RRItem54Ft_r:=99
					SIA_RRItem54In_r:=99
					PushChange(1; ->[Bridge MHD NBIS:1]Item54B:108)
				End if 
				
			: ($VarName_txt="SIA_RRItem55_r")
				[Bridge MHD NBIS:1]Item55B:111:=SIA_RRItem55_r*0.3048
				PushChange(1; ->[Bridge MHD NBIS:1]Item55B:111)
				If ([Bridge MHD NBIS:1]Item55B:111>30)
					SIA_Item55Over30_L:=1
				Else 
					SIA_Item55Over30_L:=0
				End if 
				
				
			: ($VarName_txt="SIA_Item55Over30_L")
				SIA_RRItem55_r:=199
				[Bridge MHD NBIS:1]Item55B:111:=99.9
				PushChange(1; ->[Bridge MHD NBIS:1]Item55B:111)
				
			: ($VarName_txt="SIA_RRItem56_r")
				[Bridge MHD NBIS:1]Item56:112:=SIA_RRItem56_r*0.3048
				PushChange(1; ->[Bridge MHD NBIS:1]Item56:112)
				If ([Bridge MHD NBIS:1]Item56:112>30)
					SIA_Item56Over30_L:=1
				Else 
					SIA_Item56Over30_L:=0
				End if 
				
				
			: ($VarName_txt="SIA_Item56Over30_L")
				SIA_RRItem56_r:=199
				[Bridge MHD NBIS:1]Item56:112:=99.9
				PushChange(1; ->[Bridge MHD NBIS:1]Item56:112)
				
			: ($VarName_txt="SIA_RRItem39_r")
				[Bridge MHD NBIS:1]Item39:115:=SIA_RRItem39_r*0.3048
				PushChange(1; ->[Bridge MHD NBIS:1]Item39:115)
				
			: ($VarName_txt="SIA_RRItem116_r")
				[Bridge MHD NBIS:1]Item116:116:=SIA_RRItem116_r*0.3048
				PushChange(1; ->[Bridge MHD NBIS:1]Item116:116)
				
			: ($VarName_txt="SIA_RRItem40_r")
				[Bridge MHD NBIS:1]Item40:117:=SIA_RRItem40_r*0.3048
				PushChange(1; ->[Bridge MHD NBIS:1]Item40:117)
				
			: ($VarName_txt="SIA_RRItem76_r")
				[Bridge MHD NBIS:1]Item76:154:=SIA_RRItem76_r*0.3048
				PushChange(1; ->[Bridge MHD NBIS:1]Item76:154)
				
			: ($VarName_txt="SIA_RRITem54A_atxt")
				C_LONGINT:C283($pick_L)
				$pick_L:=SIA_RRITem54A_atxt
				If ($pick_L>0)
					SIA_RRItem54A_s:=Substring:C12(SIA_RRITem54A_atxt{$pick_L}; 1; 1)
					[Bridge MHD NBIS:1]Item54A:107:=SIA_RRItem54A_s
					PushChange(1; ->[Bridge MHD NBIS:1]Item54A:107)
				End if 
				
			: ($VarName_txt="SIA_RRITem55A_atxt")
				C_LONGINT:C283($pick_L)
				$pick_L:=SIA_RRITem55A_atxt
				If ($pick_L>0)
					SIA_RRItem55A_s:=Substring:C12(SIA_RRITem55A_atxt{$pick_L}; 1; 1)
					[Bridge MHD NBIS:1]Item55A:110:=SIA_RRItem55A_s
					PushChange(1; ->[Bridge MHD NBIS:1]Item55A:110)
				End if 
		End case 
		
		
	: ($Task_txt="METERS-FTIN")
		C_POINTER:C301($2; $Meters_ptr; $3; $Foot_ptr; $4; $Inch_ptr)
		$Meters_ptr:=$2
		$Foot_ptr:=$3
		$Inch_ptr:=$4
		C_REAL:C285($Meters_r; $Feet_r; $Inches_r; $FeetInt_R; $DecFt_R)
		$Meters_r:=$Meters_ptr->
		$Feet_R:=Abs:C99($Meters_R)/0.3048
		$FeetInt_R:=Int:C8($Feet_R)
		$DecFt_R:=$Feet_R-$FeetInt_R
		$Inches_R:=Round:C94(12*$DecFt_R; 3)
		$Foot_ptr->:=$FeetInt_R
		$Inch_ptr->:=$Inches_R
		
	: ($Task_txt="FTIN-METERS")
		C_POINTER:C301($2; $Meters_ptr; $3; $Foot_ptr; $4; $Inch_ptr)
		$Meters_ptr:=$2
		$Foot_ptr:=$3
		$Inch_ptr:=$4
		C_REAL:C285($Meters_r; $Feet_r; $Inches_r; $FeetInt_R; $DecFt_R)
		$FeetInt_R:=$Foot_ptr->
		$DecFt_R:=$Inch_ptr->
		$FeetInt_R:=$FeetInt_R+($DecFt_R/12)
		$Meters_r:=Round:C94(($FeetInt_R*0.3048); 7)
		$Meters_ptr->:=$Meters_r
End case 