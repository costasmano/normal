//%attributes = {"invisible":true}
//BridgeRankingCalculation 
If (False:C215)
	//Created by K Yang
	
	// Modified by: Costas Manousakis-(Designer)-(3/21/14 09:46:16)
	Mods_2014_03
	//  `  `  `additional vars for bridgeranking
	// Modified by: Costas Manousakis-(Designer)-(12/1/17 13:11:31)
	Mods_2017_12_bug
	//  `add the BridgeRankingAvgCondition to the call to PM_GetPctDeteriorationByRunDate
End if 

C_BOOLEAN:C305(BridgeRankUseArchive_b)
C_DATE:C307(BridgeRankArchiveDate_d)
C_DATE:C307(BridgeRankPontisMetricDate_d)

C_REAL:C285(BridgeRankingAvgCondition; BridgeRankingConditionLost; BridgeRankingHealthIndexChange; BridgeRankingADTValue; BridgeRankingDetourValue)
C_TEXT:C284(BridgerankingScourCritical)
C_POINTER:C301($BinFld_ptr; $i59fld_ptr; $i60fld_ptr; $i58fld_ptr; $i62fld_ptr; $i29fld_ptr; $i19fld_ptr; $i26fld_ptr; $i67fld_ptr; $i68fld_ptr)

If (Not:C34(BridgeRankUseArchive_b))
	$BinFld_ptr:=->[Bridge MHD NBIS:1]BIN:3
	$i59fld_ptr:=->[Bridge MHD NBIS:1]Item59:131
	$i60fld_ptr:=->[Bridge MHD NBIS:1]Item60:132
	$i58fld_ptr:=->[Bridge MHD NBIS:1]Item58:130
	$i62fld_ptr:=->[Bridge MHD NBIS:1]Item62:134
	$i29fld_ptr:=->[Bridge MHD NBIS:1]Item29:88
	$i19fld_ptr:=->[Bridge MHD NBIS:1]Item19:91
	$i26fld_ptr:=->[Bridge MHD NBIS:1]Item26:120
	$i67fld_ptr:=->[Bridge MHD NBIS:1]Item67:142
	$i68fld_ptr:=->[Bridge MHD NBIS:1]Item68:143
Else 
	$BinFld_ptr:=->[BridgeMHDNBISArchive:139]BIN:3
	$i59fld_ptr:=->[BridgeMHDNBISArchive:139]Item59:130
	$i60fld_ptr:=->[BridgeMHDNBISArchive:139]Item60:131
	$i58fld_ptr:=->[BridgeMHDNBISArchive:139]Item58:129
	$i62fld_ptr:=->[BridgeMHDNBISArchive:139]Item62:133
	$i29fld_ptr:=->[BridgeMHDNBISArchive:139]Item29:87
	$i19fld_ptr:=->[BridgeMHDNBISArchive:139]Item19:90
	$i26fld_ptr:=->[BridgeMHDNBISArchive:139]Item26:119
	$i67fld_ptr:=->[BridgeMHDNBISArchive:139]Item67:141
	$i68fld_ptr:=->[BridgeMHDNBISArchive:139]Item68:142
	
End if 

If (True:C214)
	
	
	If (($i58fld_ptr->="N") & ($i59fld_ptr->="N") & ($i60fld_ptr->="N") & ($i62fld_ptr->="N"))
		BridgeRankingAvgCondition:=-1
		BridgeRankingConditionLost:=-1
	Else 
		If ($i62fld_ptr->="N")
			If ($i58fld_ptr->="N")
				
				BridgeRankingAvgCondition:=(Num:C11($i59fld_ptr->)+Num:C11($i60fld_ptr->))/2
				
			Else 
				BridgeRankingAvgCondition:=(Num:C11($i58fld_ptr->)+Num:C11($i59fld_ptr->)+Num:C11($i60fld_ptr->))/3
				
			End if 
		Else 
			BridgeRankingAvgCondition:=Num:C11($i62fld_ptr->)
			
		End if 
		BridgeRankingConditionLost:=((9-BridgeRankingAvgCondition)/9)*100
	End if 
	
	
	//need attension
	BridgeRankingHealthIndexChange:=100*PM_GetPctDeteriorationByRunDate(BridgeRankPontisMetricDate_d; $BINfld_ptr->; BridgeRankingAvgCondition)
	
	
	QUERY:C277([ScourPriorityRank:108]; [ScourPriorityRank:108]BIN:1=$BINfld_ptr->)
	BridgerankingScourCritical:=[ScourPriorityRank:108]Category:5
	
	C_REAL:C285(BridgeRankingAdHealthIndChange)
	Case of 
			
			
		: (BridgerankingScourCritical="")
			BridgeRankingAdHealthIndChange:=BridgeRankingHealthIndexChange*1
			
		: (BridgerankingScourCritical="A")
			BridgeRankingAdHealthIndChange:=BridgeRankingHealthIndexChange*1.2
			
		: (BridgerankingScourCritical="B")
			BridgeRankingAdHealthIndChange:=BridgeRankingHealthIndexChange*1.15
			
		: (BridgerankingScourCritical="C")
			BridgeRankingAdHealthIndChange:=BridgeRankingHealthIndexChange*1.1
			
		: (BridgerankingScourCritical="D")
			BridgeRankingAdHealthIndChange:=BridgeRankingHealthIndexChange*1.05
			
	End case 
	
	//BridgeRankingADTValue
	Case of 
			
		: (Num:C11($i29fld_ptr->)<1000)
			BridgeRankingADTValue:=1
			
		: (Num:C11($i29fld_ptr->)<=5000)
			BridgeRankingADTValue:=2
			
		: (Num:C11($i29fld_ptr->)<=10000)
			BridgeRankingADTValue:=3
			
		: (Num:C11($i29fld_ptr->)<=20000)
			BridgeRankingADTValue:=4
			
		: (Num:C11($i29fld_ptr->)>20000)
			BridgeRankingADTValue:=5
			
	End case 
	
	// BridgeRankingDetourValue
	C_REAL:C285(BridgeRankingDetourValue)
	
	Case of 
			
		: (Num:C11($i19fld_ptr->)<2)
			BridgeRankingDetourValue:=1
			
		: (Num:C11($i19fld_ptr->)<4)
			BridgeRankingDetourValue:=2
			
		: (Num:C11($i19fld_ptr->)<6)
			BridgeRankingDetourValue:=3
			
		: (Num:C11($i19fld_ptr->)<10)
			BridgeRankingDetourValue:=4
			
		: (Num:C11($i19fld_ptr->)>=10)
			BridgeRankingDetourValue:=5
			
	End case 
	
	// BridgeRankingClassValue:="lookips"
	
	C_REAL:C285(BridgeRankingClassValue)
	Case of 
			
		: (Num:C11($i26fld_ptr->)=9)
			BridgeRankingClassValue:=1
		: (Num:C11($i26fld_ptr->)=19)
			BridgeRankingClassValue:=1
		: (Num:C11($i26fld_ptr->)=8)
			BridgeRankingClassValue:=2
		: (Num:C11($i26fld_ptr->)=7)
			BridgeRankingClassValue:=3
		: (Num:C11($i26fld_ptr->)=17)
			BridgeRankingClassValue:=3
		: (Num:C11($i26fld_ptr->)=6)
			BridgeRankingClassValue:=4
		: (Num:C11($i26fld_ptr->)=16)
			BridgeRankingClassValue:=4
		: (Num:C11($i26fld_ptr->)=1)
			BridgeRankingClassValue:=5
		: (Num:C11($i26fld_ptr->)=2)
			BridgeRankingClassValue:=5
		: (Num:C11($i26fld_ptr->)=11)
			BridgeRankingClassValue:=5
		: (Num:C11($i26fld_ptr->)=12)
			BridgeRankingClassValue:=5
		: (Num:C11($i26fld_ptr->)=14)
			BridgeRankingClassValue:=5
			
	End case 
	
	
	// BridgeRankingStrucEvalValue
	C_REAL:C285(BridgeRankingStrucEvalValue)
	Case of 
			
		: (Num:C11($i67fld_ptr->)<3)
			BridgeRankingStrucEvalValue:=5
			
		: (Num:C11($i67fld_ptr->)=3)
			BridgeRankingStrucEvalValue:=4
			
		: (Num:C11($i67fld_ptr->)<6)
			BridgeRankingStrucEvalValue:=3
			
		: (Num:C11($i67fld_ptr->)<8)
			BridgeRankingStrucEvalValue:=2
			
		: (Num:C11($i67fld_ptr->)<=9)
			BridgeRankingStrucEvalValue:=1
			
	End case 
	
	// BridgeRankingDeckValue
	C_REAL:C285(BridgeRankingDeckValue)
	Case of 
			
		: (Num:C11($i68fld_ptr->)<3)
			BridgeRankingDeckValue:=5
			
		: (Num:C11($i68fld_ptr->)<5)
			BridgeRankingDeckValue:=4
			
		: (Num:C11($i68fld_ptr->)=5)
			BridgeRankingDeckValue:=3
			
		: (Num:C11($i68fld_ptr->)<8)
			BridgeRankingDeckValue:=2
			
		: (Num:C11($i68fld_ptr->)<=9)
			BridgeRankingDeckValue:=1
			
	End case 
	
	
	// BridgeRankingHWYEvalValue
	C_REAL:C285(BridgeRankingHWYEvalValue)
	If ($i68fld_ptr->="N")
		
		BridgeRankingHWYEvalValue:=(BridgeRankingADTValue+BridgeRankingDetourValue+BridgeRankingClassValue+BridgeRankingStrucEvalValue)/4
		
	Else 
		BridgeRankingHWYEvalValue:=(BridgeRankingADTValue+BridgeRankingDetourValue+BridgeRankingClassValue+BridgeRankingStrucEvalValue+BridgeRankingDeckValue)/5
		
	End if 
	
Else 
	
	If ([BridgeMHDNBISArchive:139]Item62:133="N")
		If ([BridgeMHDNBISArchive:139]Item58:129="N")
			
			BridgeRankingAvgCondition:=(Num:C11([BridgeMHDNBISArchive:139]Item59:130)+Num:C11([BridgeMHDNBISArchive:139]Item60:131))/2
			
		Else 
			BridgeRankingAvgCondition:=(Num:C11([BridgeMHDNBISArchive:139]Item58:129)+Num:C11([BridgeMHDNBISArchive:139]Item59:130)+Num:C11([BridgeMHDNBISArchive:139]Item60:131))/3
			
		End if 
	Else 
		BridgeRankingAvgCondition:=Num:C11([BridgeMHDNBISArchive:139]Item62:133)
		
	End if 
	
	
	BridgeRankingConditionLost:=((9-BridgeRankingAvgCondition)/9)*100
	
	//need attension
	BridgeRankingHealthIndexChange:=PM_GetPctDeteriorationByRunDate(BridgeRankPontisMetricDate_d; [BridgeMHDNBISArchive:139]BIN:3)
	
	QUERY:C277([ScourPriorityRank:108]; [ScourPriorityRank:108]BIN:1=[BridgeMHDNBISArchive:139]BIN:3)
	BridgerankingScourCritical:=[ScourPriorityRank:108]Category:5
	
	C_REAL:C285(BridgeRankingAdHealthIndChange)
	Case of 
			
			
		: (BridgerankingScourCritical="")
			BridgeRankingAdHealthIndChange:=BridgeRankingHealthIndexChange*1
			
		: (BridgerankingScourCritical="A")
			BridgeRankingAdHealthIndChange:=BridgeRankingHealthIndexChange*1.2
			
		: (BridgerankingScourCritical="B")
			BridgeRankingAdHealthIndChange:=BridgeRankingHealthIndexChange*1.15
			
		: (BridgerankingScourCritical="C")
			BridgeRankingAdHealthIndChange:=BridgeRankingHealthIndexChange*1.1
			
		: (BridgerankingScourCritical="D")
			BridgeRankingAdHealthIndChange:=BridgeRankingHealthIndexChange*1.05
			
	End case 
	
	//BridgeRankingADTValue
	Case of 
			
		: (Num:C11([BridgeMHDNBISArchive:139]Item29:87)<1000)
			BridgeRankingADTValue:=1
			
		: (Num:C11([BridgeMHDNBISArchive:139]Item29:87)<=5000)
			BridgeRankingADTValue:=2
			
		: (Num:C11([BridgeMHDNBISArchive:139]Item29:87)<=10000)
			BridgeRankingADTValue:=3
			
		: (Num:C11([BridgeMHDNBISArchive:139]Item29:87)<=20000)
			BridgeRankingADTValue:=4
			
		: (Num:C11([BridgeMHDNBISArchive:139]Item29:87)>20000)
			BridgeRankingADTValue:=5
			
	End case 
	
	// BridgeRankingDetourValue
	C_REAL:C285(BridgeRankingDetourValue)
	
	Case of 
			
		: (Num:C11([BridgeMHDNBISArchive:139]Item19:90)<2)
			BridgeRankingDetourValue:=1
			
		: (Num:C11([BridgeMHDNBISArchive:139]Item19:90)<4)
			BridgeRankingDetourValue:=2
			
		: (Num:C11([BridgeMHDNBISArchive:139]Item19:90)<6)
			BridgeRankingDetourValue:=3
			
		: (Num:C11([BridgeMHDNBISArchive:139]Item19:90)<10)
			BridgeRankingDetourValue:=4
			
		: (Num:C11([BridgeMHDNBISArchive:139]Item19:90)>=10)
			BridgeRankingDetourValue:=5
			
	End case 
	
	// BridgeRankingClassValue:="lookips"
	
	C_REAL:C285(BridgeRankingClassValue)
	Case of 
			
		: (Num:C11([BridgeMHDNBISArchive:139]Item26:119)=9)
			BridgeRankingClassValue:=1
		: (Num:C11([BridgeMHDNBISArchive:139]Item26:119)=19)
			BridgeRankingClassValue:=1
		: (Num:C11([BridgeMHDNBISArchive:139]Item26:119)=8)
			BridgeRankingClassValue:=2
		: (Num:C11([BridgeMHDNBISArchive:139]Item26:119)=7)
			BridgeRankingClassValue:=3
		: (Num:C11([BridgeMHDNBISArchive:139]Item26:119)=17)
			BridgeRankingClassValue:=3
		: (Num:C11([BridgeMHDNBISArchive:139]Item26:119)=6)
			BridgeRankingClassValue:=4
		: (Num:C11([BridgeMHDNBISArchive:139]Item26:119)=16)
			BridgeRankingClassValue:=4
		: (Num:C11([BridgeMHDNBISArchive:139]Item26:119)=1)
			BridgeRankingClassValue:=5
		: (Num:C11([BridgeMHDNBISArchive:139]Item26:119)=2)
			BridgeRankingClassValue:=5
		: (Num:C11([BridgeMHDNBISArchive:139]Item26:119)=11)
			BridgeRankingClassValue:=5
		: (Num:C11([BridgeMHDNBISArchive:139]Item26:119)=12)
			BridgeRankingClassValue:=5
		: (Num:C11([BridgeMHDNBISArchive:139]Item26:119)=14)
			BridgeRankingClassValue:=5
			
	End case 
	
	
	// BridgeRankingStrucEvalValue
	C_REAL:C285(BridgeRankingStrucEvalValue)
	Case of 
			
		: (Num:C11([BridgeMHDNBISArchive:139]Item67:141)<3)
			BridgeRankingStrucEvalValue:=5
			
		: (Num:C11([BridgeMHDNBISArchive:139]Item67:141)=3)
			BridgeRankingStrucEvalValue:=4
			
		: (Num:C11([BridgeMHDNBISArchive:139]Item67:141)<6)
			BridgeRankingStrucEvalValue:=3
			
		: (Num:C11([BridgeMHDNBISArchive:139]Item67:141)<8)
			BridgeRankingStrucEvalValue:=2
			
		: (Num:C11([BridgeMHDNBISArchive:139]Item67:141)<=9)
			BridgeRankingStrucEvalValue:=1
			
	End case 
	
	// BridgeRankingDeckValue
	C_REAL:C285(BridgeRankingDeckValue)
	Case of 
			
		: (Num:C11([BridgeMHDNBISArchive:139]Item68:142)<3)
			BridgeRankingDeckValue:=5
			
		: (Num:C11([BridgeMHDNBISArchive:139]Item68:142)<5)
			BridgeRankingDeckValue:=4
			
		: (Num:C11([BridgeMHDNBISArchive:139]Item68:142)=5)
			BridgeRankingDeckValue:=3
			
		: (Num:C11([BridgeMHDNBISArchive:139]Item68:142)<8)
			BridgeRankingDeckValue:=2
			
		: (Num:C11([BridgeMHDNBISArchive:139]Item68:142)<=9)
			BridgeRankingDeckValue:=1
			
	End case 
	
	
	// BridgeRankingHWYEvalValue
	C_REAL:C285(BridgeRankingHWYEvalValue)
	If ([BridgeMHDNBISArchive:139]Item68:142="N")
		
		BridgeRankingHWYEvalValue:=(BridgeRankingADTValue+BridgeRankingDetourValue+BridgeRankingClassValue+BridgeRankingStrucEvalValue)/4
		
	Else 
		BridgeRankingHWYEvalValue:=(BridgeRankingADTValue+BridgeRankingDetourValue+BridgeRankingClassValue+BridgeRankingStrucEvalValue+BridgeRankingDeckValue)/5
		
	End if 
	
End if 


// BridgeRankingEvalFactor
C_REAL:C285(BridgeRankingEvalFactor)
BridgeRankingEvalFactor:=((BridgeRankingHWYEvalValue/5))*100


// BridgeRankingRankFactor
C_REAL:C285(BridgeRankingRankFactor)
BridgeRankingRankFactor:=(BridgeRankingConditionLost*0.3)+(BridgeRankingEvalFactor*0.3)+(BridgeRankingAdHealthIndChange*0.4)