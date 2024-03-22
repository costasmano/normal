//%attributes = {"invisible":true}
If (False:C215)
	
	//procedure: PrepReportTotal
	//get totals for Substandard report
	//Modified
	//Feb-2002 : Adjust checks for total=0 for DEM and DNR bridges
	
	Mods_2004_CM12
	
	Mods_2009_10("MASSDOT")
	//  `Use the new STATREP_GetFieldPTR and STATREP_arrays  to simplify coding
End if 

C_LONGINT:C283(STATREP_NumDistr_L; $statFld_L; $OwnLoop_L; $typeLoop_L)

C_POINTER:C301($PercVar_ptr; $StatFld_ptr; $SumVar_ptr; $TotFld_ptr)
For ($OwnLoop_L; 1; Size of array:C274(STATREP_OwnTypes_atxt))
	For ($typeLoop_L; 1; Size of array:C274(STATREP_FldTypes_atxt))
		$SumVar_ptr:=Get pointer:C304(STATREP_OwnTypes_atxt{$OwnLoop_L}+"_"+STATREP_FldTypes_atxt{$typeLoop_L})
		$SumVar_ptr->:=0
	End for 
End for 
C_LONGINT:C283($i)

For ($i; 1; STATREP_NumDistr_L)
	
	For ($OwnLoop_L; 1; Size of array:C274(STATREP_OwnTypes_atxt))
		
		For ($typeLoop_L; 1; Size of array:C274(STATREP_FldTypes_atxt))
			$StatFld_ptr:=STATREP_GetFieldPTR(STATREP_OwnTypes_atxt{$OwnLoop_L}+"_D"+String:C10($i)+STATREP_FldTypes_atxt{$typeLoop_L})
			$SumVar_ptr:=Get pointer:C304(STATREP_OwnTypes_atxt{$OwnLoop_L}+"_"+STATREP_FldTypes_atxt{$typeLoop_L})
			$SumVar_ptr->:=$SumVar_ptr->+$StatFld_ptr->
		End for 
		
		$TotFld_ptr:=STATREP_GetFieldPTR(STATREP_OwnTypes_atxt{$OwnLoop_L}+"_D"+String:C10($i)+"Total")
		
		For ($typeLoop_L; 1; Size of array:C274(STATREP_FldTypes_atxt))
			
			If (STATREP_FldTypes_atxt{$typeLoop_L}#"total")
				$PercVar_ptr:=Get pointer:C304(STATREP_OwnTypes_atxt{$OwnLoop_L}+"_D"+String:C10($i)+"p"+STATREP_FldTypes_atxt{$typeLoop_L})
				$StatFld_ptr:=STATREP_GetFieldPTR(STATREP_OwnTypes_atxt{$OwnLoop_L}+"_D"+String:C10($i)+STATREP_FldTypes_atxt{$typeLoop_L})
				
				$PercVar_ptr->:=f_BrgStatus_PCT($StatFld_ptr->; $TotFld_ptr->)
			End if 
		End for 
		
	End for 
	
End for 

For ($OwnLoop_L; 1; Size of array:C274(STATREP_OwnTypes_atxt))
	$TotFld_ptr:=Get pointer:C304(STATREP_OwnTypes_atxt{$OwnLoop_L}+"_total")
	For ($typeLoop_L; 1; Size of array:C274(STATREP_FldTypes_atxt))
		If (STATREP_FldTypes_atxt{$typeLoop_L}#"total")
			$SumVar_ptr:=Get pointer:C304(STATREP_OwnTypes_atxt{$OwnLoop_L}+"_"+STATREP_FldTypes_atxt{$typeLoop_L})
			$PercVar_ptr:=Get pointer:C304(STATREP_OwnTypes_atxt{$OwnLoop_L}+"_p"+STATREP_FldTypes_atxt{$typeLoop_L})
			$PercVar_ptr->:=f_BrgStatus_PCT($SumVar_ptr->; $TotFld_ptr->)
		End if 
	End for 
End for 


If (False:C215)
	S_total:=[Status Report:69]S_D1total:3+[Status Report:69]S_D2total:4+[Status Report:69]S_D3total:5+[Status Report:69]S_D4total:6+[Status Report:69]S_D5total:7
	S_sd:=[Status Report:69]S_D1sd:20+[Status Report:69]S_D2sd:21+[Status Report:69]S_D3sd:22+[Status Report:69]S_D4sd:23+[Status Report:69]S_D5sd:24
	S_fo:=[Status Report:69]S_D1fo:37+[Status Report:69]S_D2fo:38+[Status Report:69]S_D3fo:39+[Status Report:69]S_D4fo:40+[Status Report:69]S_D5fo:41
	S_p:=[Status Report:69]S_D1p:54+[Status Report:69]S_D2p:55+[Status Report:69]S_D3p:56+[Status Report:69]S_D4p:57+[Status Report:69]S_D5p:58
	S_k:=[Status Report:69]S_D1k:71+[Status Report:69]S_D2k:72+[Status Report:69]S_D3k:73+[Status Report:69]S_D4k:74+[Status Report:69]S_D5k:75
	S_t:=[Status Report:69]S_D1t:88+[Status Report:69]S_D2t:89+[Status Report:69]S_D3t:90+[Status Report:69]S_D4t:91+[Status Report:69]S_D5t:92
	S_a50:=[Status Report:69]S_D1a50:105+[Status Report:69]S_D2a50:106+[Status Report:69]S_D3a50:107+[Status Report:69]S_D4a50:108+[Status Report:69]S_D5a50:109
	T_total:=[Status Report:69]T_D1total:8+[Status Report:69]T_D2total:9+[Status Report:69]T_D3total:10+[Status Report:69]T_D4total:11+[Status Report:69]T_D5total:12
	T_sd:=[Status Report:69]T_D1sd:25+[Status Report:69]T_D2sd:26+[Status Report:69]T_D3sd:27+[Status Report:69]T_D4sd:28+[Status Report:69]T_D5sd:29
	T_fo:=[Status Report:69]T_D1fo:42+[Status Report:69]T_D2fo:43+[Status Report:69]T_D3fo:44+[Status Report:69]T_D4fo:45+[Status Report:69]T_D5fo:46
	T_p:=[Status Report:69]T_D1p:59+[Status Report:69]T_D2p:60+[Status Report:69]T_D3p:61+[Status Report:69]T_D4p:62+[Status Report:69]T_D5p:63
	T_k:=[Status Report:69]T_D1k:76+[Status Report:69]T_D2k:77+[Status Report:69]T_D3k:78+[Status Report:69]T_D4k:79+[Status Report:69]T_D5k:80
	T_t:=[Status Report:69]T_D1t:93+[Status Report:69]T_D2t:94+[Status Report:69]T_D3t:95+[Status Report:69]T_D4t:96+[Status Report:69]T_D5t:97
	T_a50:=[Status Report:69]T_D1a50:110+[Status Report:69]T_D2a50:111+[Status Report:69]T_D3a50:112+[Status Report:69]T_D4a50:113+[Status Report:69]T_D5a50:114
	S_D1psd:=f_BrgStatus_PCT([Status Report:69]S_D1sd:20; [Status Report:69]S_D1total:3)
	S_D1pfo:=f_BrgStatus_PCT([Status Report:69]S_D1fo:37; [Status Report:69]S_D1total:3)
	S_D1pp:=f_BrgStatus_PCT([Status Report:69]S_D1p:54; [Status Report:69]S_D1total:3)
	S_D1pk:=f_BrgStatus_PCT([Status Report:69]S_D1k:71; [Status Report:69]S_D1total:3)
	S_D1pt:=f_BrgStatus_PCT([Status Report:69]S_D1t:88; [Status Report:69]S_D1total:3)
	S_D1pa50:=f_BrgStatus_PCT([Status Report:69]S_D1a50:105; [Status Report:69]S_D1total:3)
	
	S_D2psd:=f_BrgStatus_PCT([Status Report:69]S_D2sd:21; [Status Report:69]S_D2total:4)
	S_D2pfo:=f_BrgStatus_PCT([Status Report:69]S_D2fo:38; [Status Report:69]S_D2total:4)
	S_D2pp:=f_BrgStatus_PCT([Status Report:69]S_D2p:55; [Status Report:69]S_D2total:4)
	S_D2pk:=f_BrgStatus_PCT([Status Report:69]S_D2k:72; [Status Report:69]S_D2total:4)
	S_D2pt:=f_BrgStatus_PCT([Status Report:69]S_D2t:89; [Status Report:69]S_D2total:4)
	S_D2pa50:=f_BrgStatus_PCT([Status Report:69]S_D2a50:106; [Status Report:69]S_D2total:4)
	
	S_D3psd:=f_BrgStatus_PCT([Status Report:69]S_D3sd:22; [Status Report:69]S_D3total:5)
	S_D3pfo:=f_BrgStatus_PCT([Status Report:69]S_D3fo:39; [Status Report:69]S_D3total:5)
	S_D3pp:=f_BrgStatus_PCT([Status Report:69]S_D3p:56; [Status Report:69]S_D3total:5)
	S_D3pk:=f_BrgStatus_PCT([Status Report:69]S_D3k:73; [Status Report:69]S_D3total:5)
	S_D3pt:=f_BrgStatus_PCT([Status Report:69]S_D3t:90; [Status Report:69]S_D3total:5)
	S_D3pa50:=f_BrgStatus_PCT([Status Report:69]S_D3a50:107; [Status Report:69]S_D3total:5)
	
	S_D4psd:=f_BrgStatus_PCT([Status Report:69]S_D4sd:23; [Status Report:69]S_D4total:6)
	S_D4pfo:=f_BrgStatus_PCT([Status Report:69]S_D4fo:40; [Status Report:69]S_D4total:6)
	S_D4pp:=f_BrgStatus_PCT([Status Report:69]S_D4p:57; [Status Report:69]S_D4total:6)
	S_D4pk:=f_BrgStatus_PCT([Status Report:69]S_D4k:74; [Status Report:69]S_D4total:6)
	S_D4pt:=f_BrgStatus_PCT([Status Report:69]S_D4t:91; [Status Report:69]S_D4total:6)
	S_D4pa50:=f_BrgStatus_PCT([Status Report:69]S_D4a50:108; [Status Report:69]S_D4total:6)
	
	S_D5psd:=f_BrgStatus_PCT([Status Report:69]S_D5sd:24; [Status Report:69]S_D5total:7)
	S_D5pfo:=f_BrgStatus_PCT([Status Report:69]S_D5fo:41; [Status Report:69]S_D5total:7)
	S_D5pp:=f_BrgStatus_PCT([Status Report:69]S_D5p:58; [Status Report:69]S_D5total:7)
	S_D5pk:=f_BrgStatus_PCT([Status Report:69]S_D5k:75; [Status Report:69]S_D5total:7)
	S_D5pt:=f_BrgStatus_PCT([Status Report:69]S_D5t:92; [Status Report:69]S_D5total:7)
	S_D5pa50:=f_BrgStatus_PCT([Status Report:69]S_D5a50:109; [Status Report:69]S_D5total:7)
	
	T_D1psd:=f_BrgStatus_PCT([Status Report:69]T_D1sd:25; [Status Report:69]T_D1total:8)
	T_D1pfo:=f_BrgStatus_PCT([Status Report:69]T_D1fo:42; [Status Report:69]T_D1total:8)
	T_D1pp:=f_BrgStatus_PCT([Status Report:69]T_D1p:59; [Status Report:69]T_D1total:8)
	T_D1pk:=f_BrgStatus_PCT([Status Report:69]T_D1k:76; [Status Report:69]T_D1total:8)
	T_D1pt:=f_BrgStatus_PCT([Status Report:69]T_D1t:93; [Status Report:69]T_D1total:8)
	T_D1pa50:=f_BrgStatus_PCT([Status Report:69]T_D1a50:110; [Status Report:69]T_D1total:8)
	
	T_D2psd:=f_BrgStatus_PCT([Status Report:69]T_D2sd:26; [Status Report:69]T_D2total:9)
	T_D2pfo:=f_BrgStatus_PCT([Status Report:69]T_D2fo:43; [Status Report:69]T_D2total:9)
	T_D2pp:=f_BrgStatus_PCT([Status Report:69]T_D2p:60; [Status Report:69]T_D2total:9)
	T_D2pk:=f_BrgStatus_PCT([Status Report:69]T_D2k:77; [Status Report:69]T_D2total:9)
	T_D2pt:=f_BrgStatus_PCT([Status Report:69]T_D2t:94; [Status Report:69]T_D2total:9)
	T_D2pa50:=f_BrgStatus_PCT([Status Report:69]T_D2a50:111; [Status Report:69]T_D2total:9)
	
	T_D3psd:=f_BrgStatus_PCT([Status Report:69]T_D3sd:27; [Status Report:69]T_D3total:10)
	T_D3pfo:=f_BrgStatus_PCT([Status Report:69]T_D3fo:44; [Status Report:69]T_D3total:10)
	T_D3pp:=f_BrgStatus_PCT([Status Report:69]T_D3p:61; [Status Report:69]T_D3total:10)
	T_D3pk:=f_BrgStatus_PCT([Status Report:69]T_D3k:78; [Status Report:69]T_D3total:10)
	T_D3pt:=f_BrgStatus_PCT([Status Report:69]T_D3t:95; [Status Report:69]T_D3total:10)
	T_D3pa50:=f_BrgStatus_PCT([Status Report:69]T_D3a50:112; [Status Report:69]T_D3total:10)
	
	T_D4psd:=f_BrgStatus_PCT([Status Report:69]T_D4sd:28; [Status Report:69]T_D4total:11)
	T_D4pfo:=f_BrgStatus_PCT([Status Report:69]T_D4fo:45; [Status Report:69]T_D4total:11)
	T_D4pp:=f_BrgStatus_PCT([Status Report:69]T_D4p:62; [Status Report:69]T_D4total:11)
	T_D4pk:=f_BrgStatus_PCT([Status Report:69]T_D4k:79; [Status Report:69]T_D4total:11)
	T_D4pt:=f_BrgStatus_PCT([Status Report:69]T_D4t:96; [Status Report:69]T_D4total:11)
	T_D4pa50:=f_BrgStatus_PCT([Status Report:69]T_D4a50:113; [Status Report:69]T_D4total:11)
	
	T_D5psd:=f_BrgStatus_PCT([Status Report:69]T_D5sd:29; [Status Report:69]T_D5total:12)
	T_D5pfo:=f_BrgStatus_PCT([Status Report:69]T_D5fo:46; [Status Report:69]T_D5total:12)
	T_D5pp:=f_BrgStatus_PCT([Status Report:69]T_D5p:63; [Status Report:69]T_D5total:12)
	T_D5pk:=f_BrgStatus_PCT([Status Report:69]T_D5k:80; [Status Report:69]T_D5total:12)
	T_D5pt:=f_BrgStatus_PCT([Status Report:69]T_D5t:97; [Status Report:69]T_D5total:12)
	T_D5pa50:=f_BrgStatus_PCT([Status Report:69]T_D5a50:114; [Status Report:69]T_D5total:12)
	
	S_psd:=f_BrgStatus_PCT(S_sd; S_total)
	S_pfo:=f_BrgStatus_PCT(S_fo; S_total)
	S_pp:=f_BrgStatus_PCT(S_p; S_total)
	S_pk:=f_BrgStatus_PCT(S_k; S_total)
	S_pt:=f_BrgStatus_PCT(S_t; S_total)
	S_pa50:=f_BrgStatus_PCT(S_a50; S_total)
	T_psd:=f_BrgStatus_PCT(T_sd; T_total)
	T_pfo:=f_BrgStatus_PCT(T_fo; T_total)
	T_pp:=f_BrgStatus_PCT(T_p; T_total)
	T_pk:=f_BrgStatus_PCT(T_k; T_total)
	T_pt:=f_BrgStatus_PCT(T_t; T_total)
	T_pa50:=f_BrgStatus_PCT(T_a50; T_total)
	
	MBTA_psd:=f_BrgStatus_PCT([Status Report:69]MBTA_sd:30; [Status Report:69]MBTA_total:13)
	MBTA_pfo:=f_BrgStatus_PCT([Status Report:69]MBTA_fo:47; [Status Report:69]MBTA_total:13)
	MBTA_pp:=f_BrgStatus_PCT([Status Report:69]MBTA_p:64; [Status Report:69]MBTA_total:13)
	MBTA_pk:=f_BrgStatus_PCT([Status Report:69]MBTA_k:81; [Status Report:69]MBTA_total:13)
	MBTA_pt:=f_BrgStatus_PCT([Status Report:69]MBTA_t:98; [Status Report:69]MBTA_total:13)
	MBTA_pa50:=f_BrgStatus_PCT([Status Report:69]MBTA_a50:115; [Status Report:69]MBTA_total:13)
	
	MDC_psd:=f_BrgStatus_PCT([Status Report:69]MDC_sd:31; [Status Report:69]MDC_total:14)
	MDC_pfo:=f_BrgStatus_PCT([Status Report:69]MDC_fo:48; [Status Report:69]MDC_total:14)
	MDC_pp:=f_BrgStatus_PCT([Status Report:69]MDC_p:65; [Status Report:69]MDC_total:14)
	MDC_pk:=f_BrgStatus_PCT([Status Report:69]MDC_k:82; [Status Report:69]MDC_total:14)
	MDC_pt:=f_BrgStatus_PCT([Status Report:69]MDC_t:99; [Status Report:69]MDC_total:14)
	MDC_pa50:=f_BrgStatus_PCT([Status Report:69]MDC_a50:116; [Status Report:69]MDC_total:14)
	
	MTA_psd:=f_BrgStatus_PCT([Status Report:69]MTA_sd:32; [Status Report:69]MTA_total:15)
	MTA_pfo:=f_BrgStatus_PCT([Status Report:69]MTA_fo:49; [Status Report:69]MTA_total:15)
	MTA_pp:=f_BrgStatus_PCT([Status Report:69]MTA_p:66; [Status Report:69]MTA_total:15)
	MTA_pk:=f_BrgStatus_PCT([Status Report:69]MTA_k:83; [Status Report:69]MTA_total:15)
	MTA_pt:=f_BrgStatus_PCT([Status Report:69]MTA_t:100; [Status Report:69]MTA_total:15)
	MTA_pa50:=f_BrgStatus_PCT([Status Report:69]MTA_a50:117; [Status Report:69]MTA_total:15)
	
	MPA_psd:=f_BrgStatus_PCT([Status Report:69]MPA_sd:33; [Status Report:69]MPA_total:16)
	MPA_pfo:=f_BrgStatus_PCT([Status Report:69]MPA_fo:50; [Status Report:69]MPA_total:16)
	MPA_pp:=f_BrgStatus_PCT([Status Report:69]MPA_p:67; [Status Report:69]MPA_total:16)
	MPA_pk:=f_BrgStatus_PCT([Status Report:69]MPA_k:84; [Status Report:69]MPA_total:16)
	MPA_pt:=f_BrgStatus_PCT([Status Report:69]MPA_t:101; [Status Report:69]MPA_total:16)
	MPA_pa50:=f_BrgStatus_PCT([Status Report:69]MPA_a50:118; [Status Report:69]MPA_total:16)
	
	DEM_psd:=f_BrgStatus_PCT([Status Report:69]DEM_sd:34; [Status Report:69]DEM_total:17)
	DEM_pfo:=f_BrgStatus_PCT([Status Report:69]DEM_fo:51; [Status Report:69]DEM_total:17)
	DEM_pp:=f_BrgStatus_PCT([Status Report:69]DEM_p:68; [Status Report:69]DEM_total:17)
	DEM_pk:=f_BrgStatus_PCT([Status Report:69]DEM_k:85; [Status Report:69]DEM_total:17)
	DEM_pt:=f_BrgStatus_PCT([Status Report:69]DEM_t:102; [Status Report:69]DEM_total:17)
	DEM_pa50:=f_BrgStatus_PCT([Status Report:69]DEM_a50:119; [Status Report:69]DEM_total:17)
	
	DNR_psd:=f_BrgStatus_PCT([Status Report:69]DNR_sd:35; [Status Report:69]DNR_total:18)
	DNR_pfo:=f_BrgStatus_PCT([Status Report:69]DNR_fo:52; [Status Report:69]DNR_total:18)
	DNR_pp:=f_BrgStatus_PCT([Status Report:69]DNR_p:69; [Status Report:69]DNR_total:18)
	DNR_pk:=f_BrgStatus_PCT([Status Report:69]DNR_k:86; [Status Report:69]DNR_total:18)
	DNR_pt:=f_BrgStatus_PCT([Status Report:69]DNR_t:103; [Status Report:69]DNR_total:18)
	DNR_pa50:=f_BrgStatus_PCT([Status Report:69]DNR_a50:120; [Status Report:69]DNR_total:18)
End if 

ARRAY TEXT:C222($STAT_Agencies_atxt; 6)
$STAT_Agencies_atxt{1}:="MBTA"
$STAT_Agencies_atxt{2}:="MDC"
$STAT_Agencies_atxt{3}:="MTA"
$STAT_Agencies_atxt{4}:="MPA"
$STAT_Agencies_atxt{5}:="DEM"
$STAT_Agencies_atxt{6}:="DNR"
For ($OwnLoop_L; 1; Size of array:C274($STAT_Agencies_atxt))
	$TotFld_ptr:=STATREP_GetFieldPTR($STAT_Agencies_atxt{$OwnLoop_L}+"_total")
	For ($typeLoop_L; 1; Size of array:C274(STATREP_FldTypes_atxt))
		If (STATREP_FldTypes_atxt{$typeLoop_L}#"total")
			$SumVar_ptr:=STATREP_GetFieldPTR($STAT_Agencies_atxt{$OwnLoop_L}+"_"+STATREP_FldTypes_atxt{$typeLoop_L})
			$PercVar_ptr:=Get pointer:C304($STAT_Agencies_atxt{$OwnLoop_L}+"_p"+STATREP_FldTypes_atxt{$typeLoop_L})
			$PercVar_ptr->:=f_BrgStatus_PCT($SumVar_ptr->; $TotFld_ptr->)
		End if 
	End for 
End for 

gr_total:=S_total+T_total+[Status Report:69]MBTA_total:13+[Status Report:69]MDC_total:14+[Status Report:69]MTA_total:15
gr_total:=gr_total+[Status Report:69]MPA_total:16+[Status Report:69]DEM_total:17+[Status Report:69]DNR_total:18
gr_sd:=S_sd+T_sd+[Status Report:69]MBTA_sd:30+[Status Report:69]MDC_sd:31+[Status Report:69]MTA_sd:32+[Status Report:69]MPA_sd:33
gr_sd:=gr_sd+[Status Report:69]DEM_sd:34+[Status Report:69]DNR_sd:35
gr_psd:=f_BrgStatus_PCT(gr_sd; gr_total)
gr_fo:=S_fo+T_fo+[Status Report:69]MBTA_fo:47+[Status Report:69]MDC_fo:48+[Status Report:69]MTA_fo:49+[Status Report:69]MPA_fo:50
gr_fo:=gr_fo+[Status Report:69]DEM_fo:51+[Status Report:69]DNR_fo:52
gr_pfo:=f_BrgStatus_PCT(gr_fo; gr_total)
gr_p:=S_p+T_p+[Status Report:69]MBTA_p:64+[Status Report:69]MDC_p:65+[Status Report:69]MTA_p:66+[Status Report:69]MPA_p:67
gr_p:=gr_p+[Status Report:69]DEM_p:68+[Status Report:69]DNR_p:69
gr_pp:=f_BrgStatus_PCT(gr_p; gr_total)
gr_k:=S_k+T_k+[Status Report:69]MBTA_k:81+[Status Report:69]MDC_k:82+[Status Report:69]MTA_k:83+[Status Report:69]MPA_k:84
gr_k:=gr_k+[Status Report:69]DEM_k:85+[Status Report:69]DNR_k:86
gr_pk:=f_BrgStatus_PCT(gr_k; gr_total)
gr_t:=S_t+T_t+[Status Report:69]MBTA_t:98+[Status Report:69]MDC_t:99+[Status Report:69]MTA_t:100+[Status Report:69]MPA_t:101
gr_t:=gr_t+[Status Report:69]DEM_t:102+[Status Report:69]DNR_t:103
gr_pt:=f_BrgStatus_PCT(gr_t; gr_total)
gr_a50:=S_a50+T_a50+[Status Report:69]MBTA_a50:115+[Status Report:69]MDC_a50:116+[Status Report:69]MTA_a50:117+[Status Report:69]MPA_a50:118
gr_a50:=gr_a50+[Status Report:69]DEM_a50:119+[Status Report:69]DNR_a50:120
gr_pa50:=f_BrgStatus_PCT(gr_a50; gr_total)