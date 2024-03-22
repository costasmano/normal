//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 06/20/05, 23:23:38
	// ----------------------------------------------------
	// Method: WKHR_CreateProposal
	// Description
	// 
	//
	// Parameters
	// ----------------------------------------------------
	// Modified by: costasmanousakis-(Designer)-(11/30/2005 12:02:18)
	Mods_2005_CM19
	
	// Modified by: costasmanousakis-(Designer)-(8/31/2007 11:46:18)
	Mods_2007_CM12_5301
	// Modified by: costasmanousakis-(Designer)-(2/9/09 20:52:07)
	Mods_2009_CM_5404  //Copied to Server on : 03/19/09, 12:06:16  ` ("WKHRMODS")
End if 
C_LONGINT:C283($1; $AddendumNo)  //Command Replaced was o_C_INTEGER
If (Count parameters:C259=1)
	$AddendumNo:=$1
Else 
	$AddendumNo:=0
End if 
C_REAL:C285($CatRate1; $CatRate2; $CatRate3; $CatRate4; $CatRate5; $CatRate6)
C_REAL:C285($ConCatRate1; $ConCatRate2; $ConCatRate3; $ConCatRate4; $ConCatRate5; $ConCatRate6)

If ($AddendumNo>0)
	//1  `look for work hour for orig assignment work estimate to copy rates
	SET AUTOMATIC RELATIONS:C310(False:C215; False:C215)  //avoid loading related records from the query
	READ ONLY:C145([Work_Estimate:103])
	QUERY:C277([Work_Estimate:103]; [Work_Estimate:103]AssignID:2=[Contract_Assignment_Maintenance:101]AssignID:3)
	QUERY SELECTION:C341([Work_Estimate:103]; [Work_Estimate:103]AddendumNo:29=0)
	If (Records in selection:C76([Work_Estimate:103])=1)
		$CatRate1:=[Work_Estimate:103]Cat1Rate:7
		$CatRate2:=[Work_Estimate:103]Cat2Rate:8
		$CatRate3:=[Work_Estimate:103]Cat3Rate:9
		$CatRate4:=[Work_Estimate:103]Cate4Rate:10
		$CatRate5:=[Work_Estimate:103]Cat5Rate:11
		$CatRate6:=[Work_Estimate:103]Cat6Rate:45
		$ConCatRate1:=[Work_Estimate:103]ConstCat1Rate:40
		$ConCatRate2:=[Work_Estimate:103]ConstCat2Rate:41
		$ConCatRate3:=[Work_Estimate:103]ConstCat3Rate:42
		$ConCatRate4:=[Work_Estimate:103]ConstCat4Rate:43
		$ConCatRate5:=[Work_Estimate:103]ConstCat5Rate:44
		$ConCatRate6:=[Work_Estimate:103]ConstCat6Rate:46
		
	Else 
		$CatRate1:=0
		$CatRate2:=0
		$CatRate3:=0
		$CatRate4:=0
		$CatRate5:=0
		$CatRate6:=0
		$ConCatRate1:=0
		$ConCatRate2:=0
		$ConCatRate3:=0
		$ConCatRate4:=0
		$ConCatRate5:=0
		$ConCatRate6:=0
	End if 
	
	READ WRITE:C146([Work_Estimate:103])
	SET AUTOMATIC RELATIONS:C310(True:C214; True:C214)
	//2  `check for description of addendum
	If ([Addendum_Maintenance:102]Description:19="")
		CONFIRM:C162("Current Addendum does not have a description.\rDo you wish to add a description to"+" be included in the Work Estimate?")
		If (OK=1)
			C_TEXT:C284($Descr_txt)
			$Descr_txt:=Request:C163("Enter Addendum description")
			If ($Descr_txt#"")
				[Addendum_Maintenance:102]Description:19:=$Descr_txt
			End if 
		End if 
	End if 
	
End if 

CREATE RECORD:C68([Work_Estimate:103])
[Work_Estimate:103]AssignID:2:=[Contract_Assignment_Maintenance:101]AssignID:3
[Work_Estimate:103]AssignNo:16:=[Contract_Assignment_Maintenance:101]AssignNo:2
[Work_Estimate:103]ContractNo:3:=[Contract_Assignment_Maintenance:101]ContractNo:1
[Work_Estimate:103]Consultant:6:=[Contract_Maintenance:97]ConsultantName:3
[Work_Estimate:103]ProjInfoNo:26:=[Contract_Assignment_Maintenance:101]ProjectIS:4
[Work_Estimate:103]IndirectCostPct:12:=[Contract_Maintenance:97]OverheadRate:10
[Work_Estimate:103]NetFeePct:13:=[Contract_Maintenance:97]NetFeeRate:11
[Work_Estimate:103]Version_L:47:=1  //Made the change after release XXXXXXXXXXXXXXXXXXXXXXXXXXXXX
[Work_Estimate:103]AddendumNo:29:=$AddendumNo

If ($AddendumNo>0)
	If ([Addendum_Maintenance:102]Description:19#"")
		[Work_Estimate:103]AssignDesc:4:=[Contract_Assignment_Maintenance:101]Description:35+" - Addendum "+String:C10($AddendumNo)+" : "+[Addendum_Maintenance:102]Description:19
	Else 
		[Work_Estimate:103]AssignDesc:4:=[Contract_Assignment_Maintenance:101]Description:35+" - Addendum "+String:C10($AddendumNo)
	End if 
	[Work_Estimate:103]Cat1Rate:7:=$CatRate1
	[Work_Estimate:103]Cat2Rate:8:=$CatRate2
	[Work_Estimate:103]Cat3Rate:9:=$CatRate3
	[Work_Estimate:103]Cate4Rate:10:=$CatRate4
	[Work_Estimate:103]Cat5Rate:11:=$CatRate5
	[Work_Estimate:103]Cat6Rate:45:=$CatRate6
	[Work_Estimate:103]ConstCat1Rate:40:=$ConCatRate1
	[Work_Estimate:103]ConstCat2Rate:41:=$ConCatRate2
	[Work_Estimate:103]ConstCat3Rate:42:=$ConCatRate3
	[Work_Estimate:103]ConstCat4Rate:43:=$ConCatRate4
	[Work_Estimate:103]ConstCat5Rate:44:=$ConCatRate5
	[Work_Estimate:103]ConstCat6Rate:46:=$ConCatRate6
	
Else 
	[Work_Estimate:103]AssignDesc:4:=[Contract_Assignment_Maintenance:101]Description:35
End if 

READ ONLY:C145([WorkHour_Config:104])
QUERY:C277([WorkHour_Config:104]; [WorkHour_Config:104]AssignType:2=[Contract_Assignment_Maintenance:101]ProjectType:36)
If (Records in selection:C76([WorkHour_Config:104])=1)
	[Work_Estimate:103]RestrictedItemList:32:=[WorkHour_Config:104]ConfigArrays:1
End if 

Inc_Sequence("WorkHrEstimate"; ->[Work_Estimate:103]WKID:1)
SAVE RECORD:C53([Work_Estimate:103])
LogNewRecord(->[Work_Estimate:103]WKID:1; ->[Work_Estimate:103]WKID:1; ->[Work_Estimate:103]WKID:1; 0; "WorkHrEstimate")
InitChangeStack(1)
PushChange(1; ->[Work_Estimate:103]AssignID:2)
PushChange(1; ->[Work_Estimate:103]AssignNo:16)
PushChange(1; ->[Work_Estimate:103]ContractNo:3)
PushChange(1; ->[Work_Estimate:103]Consultant:6)
PushChange(1; ->[Work_Estimate:103]ProjInfoNo:26)
PushChange(1; ->[Work_Estimate:103]AssignDesc:4)
PushChange(1; ->[Work_Estimate:103]IndirectCostPct:12)
PushChange(1; ->[Work_Estimate:103]NetFeePct:13)
PushChange(1; ->[Work_Estimate:103]AddendumNo:29)
PushChange(1; ->[Work_Estimate:103]RestrictedItemList:32)
PushChange(1; ->[Work_Estimate:103]Cat1Rate:7)
PushChange(1; ->[Work_Estimate:103]Cat2Rate:8)
PushChange(1; ->[Work_Estimate:103]Cat3Rate:9)
PushChange(1; ->[Work_Estimate:103]Cate4Rate:10)
PushChange(1; ->[Work_Estimate:103]Cat5Rate:11)
PushChange(1; ->[Work_Estimate:103]Cat6Rate:45)
PushChange(1; ->[Work_Estimate:103]ConstCat1Rate:40)
PushChange(1; ->[Work_Estimate:103]ConstCat2Rate:41)
PushChange(1; ->[Work_Estimate:103]ConstCat3Rate:42)
PushChange(1; ->[Work_Estimate:103]ConstCat4Rate:43)
PushChange(1; ->[Work_Estimate:103]ConstCat5Rate:44)
PushChange(1; ->[Work_Estimate:103]ConstCat6Rate:46)
PushChange(1; ->[Work_Estimate:103]Version_L:47)
FlushGrpChgs(1; ->[Work_Estimate:103]WKID:1; ->[Work_Estimate:103]WKID:1; ->[Work_Estimate:103]WKID:1; 0)
If ($AddendumNo>0)
	ALERT:C41("Work Hour Proposal Created For Assignment "+String:C10([Work_Estimate:103]AssignNo:16)+" - Addendum "+String:C10($AddendumNo))
Else 
	ALERT:C41("Work Hour Proposal Created For Assignment "+String:C10([Work_Estimate:103]AssignNo:16))
End if 
UNLOAD RECORD:C212([Work_Estimate:103])