//%attributes = {"invisible":true}
//procedure: DataToCondRep
//by: Albert Leung
//created: 10/14/97
//purpose: called by GenerateCondRep
If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(11/1/09 08:14:54)
	Mods_2009_10("MASSDOT")
	//  `Use the new STATREP_GetFieldPTR and STATREP_arrays  to simplify coding
	// Modified by: Costas Manousakis-(Designer)-(3/13/13 14:15:43)
	Mods_2013_03
	//  `Clean up code
End if 

C_LONGINT:C283($i)  //Command Replaced was o_C_INTEGER
C_POINTER:C301($p)

C_LONGINT:C283($i; $j; $arrayIndex_L)
C_POINTER:C301($StatRepFld_ptr)
For ($j; 1; Size of array:C274(STATREP_FldTypes_atxt))
	For ($i; 1; STATREP_NumDistr_L)
		$arrayIndex_L:=Find in array:C230(STATREP_DataName_as; STATREP_FldTypes_atxt{$j})
		$StatRepFld_ptr:=STATREP_GetFieldPTR("S_D"+String:C10($i)+STATREP_FldTypes_atxt{$j})
		$StatRepFld_ptr->:=astate{$i}{$arrayIndex_L}
		$StatRepFld_ptr:=STATREP_GetFieldPTR("T_D"+String:C10($i)+STATREP_FldTypes_atxt{$j})
		$StatRepFld_ptr->:=atown{$i}{$arrayIndex_L}
	End for 
	
End for 

For ($j; 1; Size of array:C274(STATREP_FldTypes_atxt))
	$arrayIndex_L:=Find in array:C230(STATREP_DataName_as; STATREP_FldTypes_atxt{$j})
	$StatRepFld_ptr:=STATREP_GetFieldPTR("MBTA_"+STATREP_FldTypes_atxt{$j})
	$StatRepFld_ptr->:=aMBTA{$arrayIndex_L}
	$StatRepFld_ptr:=STATREP_GetFieldPTR("MDC_"+STATREP_FldTypes_atxt{$j})
	$StatRepFld_ptr->:=aMDC{$arrayIndex_L}
	$StatRepFld_ptr:=STATREP_GetFieldPTR("MTA_"+STATREP_FldTypes_atxt{$j})
	$StatRepFld_ptr->:=aMTA{$arrayIndex_L}
	$StatRepFld_ptr:=STATREP_GetFieldPTR("MPA_"+STATREP_FldTypes_atxt{$j})
	$StatRepFld_ptr->:=aMPA{$arrayIndex_L}
	$StatRepFld_ptr:=STATREP_GetFieldPTR("DEM_"+STATREP_FldTypes_atxt{$j})
	$StatRepFld_ptr->:=aDEM{$arrayIndex_L}
	$StatRepFld_ptr:=STATREP_GetFieldPTR("DNR_"+STATREP_FldTypes_atxt{$j})
	$StatRepFld_ptr->:=aDNR{$arrayIndex_L}
	
End for 

For ($i; 1; 13)
	$p:=Get pointer:C304("S_"+STATREP_DataName_as{$i})
	$p->:=astate_z{$i}
	$p:=Get pointer:C304("T_"+STATREP_DataName_as{$i})
	$p->:=atown_z{$i}
	$p:=Get pointer:C304("gr_"+STATREP_DataName_as{$i})
	$p->:=atotal{$i}
End for 

For ($i; 1; STATREP_NumDistr_L)
	$p:=Get pointer:C304("S_D"+String:C10($i)+"psd")
	$p->:=astate{$i}{3}
	$p:=Get pointer:C304("S_D"+String:C10($i)+"pfo")
	$p->:=astate{$i}{5}
	$p:=Get pointer:C304("S_D"+String:C10($i)+"pp")
	$p->:=astate{$i}{7}
	$p:=Get pointer:C304("S_D"+String:C10($i)+"pk")
	$p->:=astate{$i}{9}
	$p:=Get pointer:C304("S_D"+String:C10($i)+"pt")
	$p->:=astate{$i}{11}
	$p:=Get pointer:C304("S_D"+String:C10($i)+"pa50")
	$p->:=astate{$i}{13}
	$p:=Get pointer:C304("T_D"+String:C10($i)+"psd")
	$p->:=atown{$i}{3}
	$p:=Get pointer:C304("T_D"+String:C10($i)+"pfo")
	$p->:=atown{$i}{5}
	$p:=Get pointer:C304("T_D"+String:C10($i)+"pp")
	$p->:=atown{$i}{7}
	$p:=Get pointer:C304("T_D"+String:C10($i)+"pk")
	$p->:=atown{$i}{9}
	$p:=Get pointer:C304("T_D"+String:C10($i)+"pt")
	$p->:=atown{$i}{11}
	$p:=Get pointer:C304("T_D"+String:C10($i)+"pa50")
	$p->:=atown{$i}{13}
End for 

For ($i; 1; 6)
	$p:=Get pointer:C304("MBTA_"+STATREP_DataName_as{($i*2)+1})
	$p->:=aMBTA{($i*2)+1}
	$p:=Get pointer:C304("MDC_"+STATREP_DataName_as{($i*2)+1})
	$p->:=aMDC{($i*2)+1}
	$p:=Get pointer:C304("MTA_"+STATREP_DataName_as{($i*2)+1})
	$p->:=aMTA{($i*2)+1}
	$p:=Get pointer:C304("MPA_"+STATREP_DataName_as{($i*2)+1})
	$p->:=aMPA{($i*2)+1}
	$p:=Get pointer:C304("DEM_"+STATREP_DataName_as{($i*2)+1})
	$p->:=aDEM{($i*2)+1}
	$p:=Get pointer:C304("DNR_"+STATREP_DataName_as{($i*2)+1})
	$p->:=aDNR{($i*2)+1}
End for 