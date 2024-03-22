//%attributes = {"invisible":true}
//procedure: PrepStatusRep
//  `get figures for Condition Status Report
If (False:C215)
	//Modified Feb-2002 : Adjust for new report
	//modified 1-feb-2001 :CM
	//    added check for DNR bridges when total DNR=0
	
	Mods_2004_CM12
	// Modified by: costasmanousakis-(Designer)-(3/1/2006 10:25:13)
	Mods_2006_CM03
	// Modified by: costasmanousakis-(Designer)-(10/5/09 11:36:12)
	Mods_2009_10("MassDOT")
	//  `Use the new STATREP_GetFieldPTR and STATREP_arrays  to simplify coding
	// Modified by: Costas Manousakis-(Designer)-(3/13/13 14:16:19)
	Mods_2013_03
	//  ` Call  SR_CalculateAreas at the end of method
End if 

C_TEXT:C284(vsDate)  // Command Replaced was o_C_STRING length was 80
C_LONGINT:C283($i)  //Command Replaced was o_C_INTEGER
C_POINTER:C301($p; $q; $r; $s; $kSfld; $kTfld)
C_LONGINT:C283(STATREP_NumDistr_L)
PrepReportTotal

vsDate:=String:C10([Status Report:69]Date_Created:1; 5)
If (True:C214)
	For ($i; 1; STATREP_NumDistr_L)
		C_LONGINT:C283($loop_L)
		For ($loop_L; 1; Size of array:C274(STATREP_FldTypes_atxt))
			
			If ((STATREP_FldTypes_atxt{$loop_L}#"a50") & (STATREP_FldTypes_atxt{$loop_L}#"t"))
				$p:=Get pointer:C304("ST_D"+String:C10($i)+STATREP_FldTypes_atxt{$loop_L})
				$kSfld:=STATREP_GetFieldPTR("S_D"+String:C10($i)+STATREP_FldTypes_atxt{$loop_L})
				$kTfld:=STATREP_GetFieldPTR("T_D"+String:C10($i)+STATREP_FldTypes_atxt{$loop_L})
				$p->:=$kSfld->+$kTfld->
				
			End if 
		End for 
		
		$p:=Get pointer:C304("Substd_D"+String:C10($i))
		$q:=Get pointer:C304("ST_D"+String:C10($i)+"sd")
		$r:=Get pointer:C304("ST_D"+String:C10($i)+"fo")
		$p->:=$q->+$r->
		$p:=Get pointer:C304("pSubstd_D"+String:C10($i))
		$q:=Get pointer:C304("Substd_D"+String:C10($i))
		$r:=Get pointer:C304("ST_D"+String:C10($i)+"total")
		$p->:=f_BrgStatus_PCT($q->; $r->)
		
		$p:=Get pointer:C304("ST_D"+String:C10($i)+"sd")
		$q:=Get pointer:C304("ST_D"+String:C10($i)+"fo")
		$r:=Get pointer:C304("ST_D"+String:C10($i)+"total")
		$s:=Get pointer:C304("ST_D"+String:C10($i)+"psd")
		$s->:=f_BrgStatus_PCT($p->; $r->)
		
		$s:=Get pointer:C304("ST_D"+String:C10($i)+"pfo")
		$s->:=f_BrgStatus_PCT($q->; $r->)
		
		$p:=Get pointer:C304("S_D"+String:C10($i)+"Subst")
		$kSfld:=STATREP_GetFieldPTR("S_D"+String:C10($i)+"sd")
		$kTfld:=STATREP_GetFieldPTR("S_D"+String:C10($i)+"fo")
		$p->:=$kSfld->+$kTfld->
		
		$s:=Get pointer:C304("S_D"+String:C10($i)+"pSubst")
		$s->:=f_BrgStatus_PCT($p->; $r->)
		
		$p:=Get pointer:C304("T_D"+String:C10($i)+"Subst")
		$kSfld:=STATREP_GetFieldPTR("T_D"+String:C10($i)+"sd")
		$kTfld:=STATREP_GetFieldPTR("T_D"+String:C10($i)+"fo")
		$p->:=$kSfld->+$kTfld->
		
		$s:=Get pointer:C304("T_D"+String:C10($i)+"pSubst")
		$s->:=f_BrgStatus_PCT($p->; $r->)
	End for 
	
Else 
	ST_D1total:=[Status Report:69]S_D1total:3+[Status Report:69]T_D1total:8
	ST_D2total:=[Status Report:69]S_D2total:4+[Status Report:69]T_D2total:9
	ST_D3total:=[Status Report:69]S_D3total:5+[Status Report:69]T_D3total:10
	ST_D4total:=[Status Report:69]S_D4total:6+[Status Report:69]T_D4total:11
	ST_D5total:=[Status Report:69]S_D5total:7+[Status Report:69]T_D5total:12
	
	ST_D1sd:=[Status Report:69]S_D1sd:20+[Status Report:69]T_D1sd:25
	ST_D2sd:=[Status Report:69]S_D2sd:21+[Status Report:69]T_D2sd:26
	ST_D3sd:=[Status Report:69]S_D3sd:22+[Status Report:69]T_D3sd:27
	ST_D4sd:=[Status Report:69]S_D4sd:23+[Status Report:69]T_D4sd:28
	ST_D5sd:=[Status Report:69]S_D5sd:24+[Status Report:69]T_D5sd:29
	
	ST_D1fo:=[Status Report:69]S_D1fo:37+[Status Report:69]T_D1fo:42
	ST_D2fo:=[Status Report:69]S_D2fo:38+[Status Report:69]T_D2fo:43
	ST_D3fo:=[Status Report:69]S_D3fo:39+[Status Report:69]T_D3fo:44
	ST_D4fo:=[Status Report:69]S_D4fo:40+[Status Report:69]T_D4fo:45
	ST_D5fo:=[Status Report:69]S_D5fo:41+[Status Report:69]T_D5fo:46
	
	ST_D1p:=[Status Report:69]S_D1p:54+[Status Report:69]T_D1p:59
	ST_D2p:=[Status Report:69]S_D2p:55+[Status Report:69]T_D2p:60
	ST_D3p:=[Status Report:69]S_D3p:56+[Status Report:69]T_D3p:61
	ST_D4p:=[Status Report:69]S_D4p:57+[Status Report:69]T_D4p:62
	ST_D5p:=[Status Report:69]S_D5p:58+[Status Report:69]T_D5p:63
	
	ST_D1k:=[Status Report:69]S_D1k:71+[Status Report:69]T_D1k:76
	ST_D2k:=[Status Report:69]S_D2k:72+[Status Report:69]T_D2k:77
	ST_D3k:=[Status Report:69]S_D3k:73+[Status Report:69]T_D3k:78
	ST_D4k:=[Status Report:69]S_D4k:74+[Status Report:69]T_D4k:79
	ST_D5k:=[Status Report:69]S_D5k:75+[Status Report:69]T_D5k:80
	
	S_D1Subst:=[Status Report:69]S_D1sd:20+[Status Report:69]S_D1fo:37
	S_D2Subst:=[Status Report:69]S_D2sd:21+[Status Report:69]S_D2fo:38
	S_D3Subst:=[Status Report:69]S_D3sd:22+[Status Report:69]S_D3fo:39
	S_D4Subst:=[Status Report:69]S_D4sd:23+[Status Report:69]S_D4fo:40
	S_D5Subst:=[Status Report:69]S_D5sd:24+[Status Report:69]S_D5fo:41
	S_D1pSubst:=f_BrgStatus_PCT(S_D1Subst; [Status Report:69]S_D1total:3)
	S_D2pSubst:=f_BrgStatus_PCT(S_D2Subst; [Status Report:69]S_D2total:4)
	S_D3pSubst:=f_BrgStatus_PCT(S_D3Subst; [Status Report:69]S_D3total:5)
	S_D4pSubst:=f_BrgStatus_PCT(S_D4Subst; [Status Report:69]S_D4total:6)
	S_D5pSubst:=f_BrgStatus_PCT(S_D5Subst; [Status Report:69]S_D5total:7)
	
	T_D1Subst:=[Status Report:69]T_D1sd:25+[Status Report:69]T_D1fo:42
	T_D2Subst:=[Status Report:69]T_D2sd:26+[Status Report:69]T_D2fo:43
	T_D3Subst:=[Status Report:69]T_D3sd:27+[Status Report:69]T_D3fo:44
	T_D4Subst:=[Status Report:69]T_D4sd:28+[Status Report:69]T_D4fo:45
	T_D5Subst:=[Status Report:69]T_D5sd:29+[Status Report:69]T_D5fo:46
	T_D1pSubst:=f_BrgStatus_PCT(T_D1Subst; [Status Report:69]T_D1total:8)
	T_D2pSubst:=f_BrgStatus_PCT(T_D2Subst; [Status Report:69]T_D2total:9)
	T_D3pSubst:=f_BrgStatus_PCT(T_D3Subst; [Status Report:69]T_D3total:10)
	T_D4pSubst:=f_BrgStatus_PCT(T_D4Subst; [Status Report:69]T_D4total:11)
	T_D5pSubst:=f_BrgStatus_PCT(T_D5Subst; [Status Report:69]T_D5total:12)
	
End if 

For ($i; 1; STATREP_NumDistr_L)
	
	$p:=Get pointer:C304("Substd_D"+String:C10($i))
	$q:=Get pointer:C304("ST_D"+String:C10($i)+"sd")
	$r:=Get pointer:C304("ST_D"+String:C10($i)+"fo")
	$p->:=$q->+$r->
	$p:=Get pointer:C304("pSubstd_D"+String:C10($i))
	$q:=Get pointer:C304("Substd_D"+String:C10($i))
	$r:=Get pointer:C304("ST_D"+String:C10($i)+"total")
	$p->:=f_BrgStatus_PCT($q->; $r->)
	
	$p:=Get pointer:C304("ST_D"+String:C10($i)+"sd")
	$q:=Get pointer:C304("ST_D"+String:C10($i)+"fo")
	$r:=Get pointer:C304("ST_D"+String:C10($i)+"total")
	$s:=Get pointer:C304("ST_D"+String:C10($i)+"psd")
	$s->:=f_BrgStatus_PCT($p->; $r->)
	
End for 

ST_total:=S_total+T_total
ST_sd:=S_sd+T_sd
ST_fo:=S_fo+T_fo
ST_Subst:=ST_sd+ST_fo
ST_pSubst:=f_BrgStatus_PCT(ST_Subst; ST_total)
ST_p:=S_p+T_p
ST_pp:=f_BrgStatus_PCT(ST_p; ST_total)
ST_k:=S_k+T_k
ST_pK:=f_BrgStatus_PCT(ST_k; ST_total)
ST_sdp:=f_BrgStatus_PCT(ST_sd; ST_total)
ST_fop:=f_BrgStatus_PCT(ST_fo; ST_total)
ST_t:=S_t+T_t
ST_pt:=f_BrgStatus_PCT(ST_t; ST_total)
ST_a50:=S_a50+T_a50
ST_pa50:=f_BrgStatus_PCT(ST_a50; ST_total)

S_Subst:=S_sd+S_fo
S_pSubst:=f_BrgStatus_PCT(S_Subst; S_total)
T_Subst:=T_sd+T_fo
T_pSubst:=f_BrgStatus_PCT(T_Subst; T_total)

MBTA_Substd:=[Status Report:69]MBTA_sd:30+[Status Report:69]MBTA_fo:47
MBTA_psub:=f_BrgStatus_PCT(MBTA_Substd; [Status Report:69]MBTA_total:13)
MDC_Substd:=[Status Report:69]MDC_sd:31+[Status Report:69]MDC_fo:48
MDC_psub:=f_BrgStatus_PCT(MDC_Substd; [Status Report:69]MDC_total:14)
MTA_Substd:=[Status Report:69]MTA_sd:32+[Status Report:69]MTA_fo:49
MTA_psub:=f_BrgStatus_PCT(MTA_Substd; [Status Report:69]MTA_total:15)
MPA_Substd:=[Status Report:69]MPA_sd:33+[Status Report:69]MPA_fo:50
MPA_psub:=f_BrgStatus_PCT(MPA_Substd; [Status Report:69]MPA_total:16)
DEM_Substd:=[Status Report:69]DEM_sd:34+[Status Report:69]DEM_fo:51
DEM_psub:=f_BrgStatus_PCT(DEM_Substd; [Status Report:69]DEM_total:17)
DNR_Substd:=[Status Report:69]DNR_sd:35+[Status Report:69]DNR_fo:52
DNR_psub:=f_BrgStatus_PCT(DNR_Substd; [Status Report:69]DNR_total:18)

gr_Substd:=gr_sd+gr_fo
gr_pSubstd:=f_BrgStatus_PCT(gr_Substd; gr_total)

SR_CalculateAreas