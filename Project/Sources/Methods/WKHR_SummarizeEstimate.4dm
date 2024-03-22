//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 09/11/07, 08:25:16
	// ----------------------------------------------------
	// Method: WKHR_SummarizeEstimate
	// Description
	// 
	// 
	// Parameters
	// $1 : $AssignAddend : Text
	// ----------------------------------------------------
	
	Mods_2007_CM12_5301
End if 
C_TEXT:C284($1)
Case of 
	: ($1="INITVARS")
		Item_100_tot_A:=0
		Item_150_tot_A:=0
		Item_200_tot_A:=0
		Item_220_tot_A:=0
		Item_300_tot_A:=0
		Item_350_tot_A:=0
		Item_400_tot_A:=0
		Item_450_tot_A:=0
		Item_500_tot_A:=0
		Item_600_tot_A:=0
		Item_700_tot_A:=0
		Item_710_tot_A:=0
		Item_750_tot_A:=0
		Item_800_tot_A:=0
		Item_900_tot_A:=0
	: ($1="TOTALASSIGN")
		WKHR_ZeroAll
		WKHR_LoadVariables_2
		WKHR_CalcTotals
		Item_100_tot_A:=Item_100_tot_A+Item_100_tot_6
		Item_150_tot_A:=Item_150_tot_A+Item_150_tot_6
		Item_200_tot_A:=Item_200_tot_A+Item_200_tot_6
		Item_220_tot_A:=Item_220_tot_A+Item_220_tot_6
		Item_300_tot_A:=Item_300_tot_A+Item_300_tot_6
		Item_350_tot_A:=Item_350_tot_A+Item_350_tot_6
		Item_400_tot_A:=Item_400_tot_A+Item_400_tot_6
		Item_450_tot_A:=Item_450_tot_A+Item_450_tot_6
		Item_500_tot_A:=Item_500_tot_A+Item_500_tot_6
		Item_600_tot_A:=Item_600_tot_A+Item_600_tot_6
		Item_700_tot_A:=Item_700_tot_A+Item_700_tot_6
		Item_710_tot_A:=Item_710_tot_A+Item_710_tot_6
		Item_750_tot_A:=Item_750_tot_A+Item_750_tot_6
		Item_800_tot_A:=Item_800_tot_A+Item_800_tot_6
		Item_900_tot_A:=Item_900_tot_A+Item_900_tot_6
	: ($1="ACCUMULATE")
		WKHR_Accumulate("ACCUMULATE"; ->Item_100_tot_C; ->Item_100_tot_C_i; Item_100_tot_A)
		WKHR_Accumulate("ACCUMULATE"; ->Item_150_tot_C; ->Item_150_tot_C_i; Item_150_tot_A)
		WKHR_Accumulate("ACCUMULATE"; ->Item_200_tot_C; ->Item_200_tot_C_i; Item_200_tot_A)
		WKHR_Accumulate("ACCUMULATE"; ->Item_220_tot_C; ->Item_220_tot_C_i; Item_220_tot_A)
		WKHR_Accumulate("ACCUMULATE"; ->Item_300_tot_C; ->Item_300_tot_C_i; Item_300_tot_A)
		WKHR_Accumulate("ACCUMULATE"; ->Item_350_tot_C; ->Item_350_tot_C_i; Item_350_tot_A)
		WKHR_Accumulate("ACCUMULATE"; ->Item_400_tot_C; ->Item_400_tot_C_i; Item_400_tot_A)
		WKHR_Accumulate("ACCUMULATE"; ->Item_450_tot_C; ->Item_450_tot_C_i; Item_450_tot_A)
		WKHR_Accumulate("ACCUMULATE"; ->Item_500_tot_C; ->Item_500_tot_C_i; Item_500_tot_A)
		WKHR_Accumulate("ACCUMULATE"; ->Item_600_tot_C; ->Item_600_tot_C_i; Item_600_tot_A)
		WKHR_Accumulate("ACCUMULATE"; ->Item_700_tot_C; ->Item_700_tot_C_i; Item_700_tot_A)
		WKHR_Accumulate("ACCUMULATE"; ->Item_710_tot_C; ->Item_710_tot_C_i; Item_710_tot_A)
		WKHR_Accumulate("ACCUMULATE"; ->Item_750_tot_C; ->Item_750_tot_C_i; Item_750_tot_A)
		WKHR_Accumulate("ACCUMULATE"; ->Item_800_tot_C; ->Item_800_tot_C_i; Item_800_tot_A)
		WKHR_Accumulate("ACCUMULATE"; ->Item_900_tot_C; ->Item_900_tot_C_i; Item_900_tot_A)
		WKHR_Accumulate("ACCUMULATE"; ->Item_100_Avg_t; ->Item_100_Avg_t_i; Item_100_tot_A)
		WKHR_Accumulate("ACCUMULATE"; ->Item_150_Avg_t; ->Item_150_Avg_t_i; Item_150_tot_A)
		WKHR_Accumulate("ACCUMULATE"; ->Item_200_Avg_t; ->Item_200_Avg_t_i; Item_200_tot_A)
		WKHR_Accumulate("ACCUMULATE"; ->Item_220_Avg_t; ->Item_220_Avg_t_i; Item_220_tot_A)
		WKHR_Accumulate("ACCUMULATE"; ->Item_300_Avg_t; ->Item_300_Avg_t_i; Item_300_tot_A)
		WKHR_Accumulate("ACCUMULATE"; ->Item_350_Avg_t; ->Item_350_Avg_t_i; Item_350_tot_A)
		WKHR_Accumulate("ACCUMULATE"; ->Item_400_Avg_t; ->Item_400_Avg_t_i; Item_400_tot_A)
		WKHR_Accumulate("ACCUMULATE"; ->Item_450_Avg_t; ->Item_450_Avg_t_i; Item_450_tot_A)
		WKHR_Accumulate("ACCUMULATE"; ->Item_500_Avg_t; ->Item_500_Avg_t_i; Item_500_tot_A)
		WKHR_Accumulate("ACCUMULATE"; ->Item_600_Avg_t; ->Item_600_Avg_t_i; Item_600_tot_A)
		WKHR_Accumulate("ACCUMULATE"; ->Item_700_Avg_t; ->Item_700_Avg_t_i; Item_700_tot_A)
		WKHR_Accumulate("ACCUMULATE"; ->Item_710_Avg_t; ->Item_710_Avg_t_i; Item_710_tot_A)
		WKHR_Accumulate("ACCUMULATE"; ->Item_750_Avg_t; ->Item_750_Avg_t_i; Item_750_tot_A)
		WKHR_Accumulate("ACCUMULATE"; ->Item_800_Avg_t; ->Item_800_Avg_t_i; Item_800_tot_A)
		WKHR_Accumulate("ACCUMULATE"; ->Item_900_Avg_t; ->Item_900_Avg_t_i; Item_900_tot_A)
	: ($1="AVERAGECONS")
		Item_100_Avg:=WKHR_Accumulate("AVERAGE"; ->Item_100_tot_C; ->Item_100_tot_C_i; 0)
		Item_150_Avg:=WKHR_Accumulate("AVERAGE"; ->Item_150_tot_C; ->Item_150_tot_C_i; 0)
		Item_200_Avg:=WKHR_Accumulate("AVERAGE"; ->Item_200_tot_C; ->Item_200_tot_C_i; 0)
		Item_220_Avg:=WKHR_Accumulate("AVERAGE"; ->Item_220_tot_C; ->Item_220_tot_C_i; 0)
		Item_300_Avg:=WKHR_Accumulate("AVERAGE"; ->Item_300_tot_C; ->Item_300_tot_C_i; 0)
		Item_350_Avg:=WKHR_Accumulate("AVERAGE"; ->Item_350_tot_C; ->Item_350_tot_C_i; 0)
		Item_400_Avg:=WKHR_Accumulate("AVERAGE"; ->Item_400_tot_C; ->Item_400_tot_C_i; 0)
		Item_450_Avg:=WKHR_Accumulate("AVERAGE"; ->Item_450_tot_C; ->Item_450_tot_C_i; 0)
		Item_500_Avg:=WKHR_Accumulate("AVERAGE"; ->Item_500_tot_C; ->Item_500_tot_C_i; 0)
		Item_600_Avg:=WKHR_Accumulate("AVERAGE"; ->Item_600_tot_C; ->Item_600_tot_C_i; 0)
		Item_700_Avg:=WKHR_Accumulate("AVERAGE"; ->Item_700_tot_C; ->Item_700_tot_C_i; 0)
		Item_710_Avg:=WKHR_Accumulate("AVERAGE"; ->Item_710_tot_C; ->Item_710_tot_C_i; 0)
		Item_750_Avg:=WKHR_Accumulate("AVERAGE"; ->Item_750_tot_C; ->Item_750_tot_C_i; 0)
		Item_800_Avg:=WKHR_Accumulate("AVERAGE"; ->Item_800_tot_C; ->Item_800_tot_C_i; 0)
		Item_900_Avg:=WKHR_Accumulate("AVERAGE"; ->Item_900_tot_C; ->Item_900_tot_C_i; 0)
		
	: ($1="AVERAGETOTAL")
		Item_100_Avg_t:=WKHR_Accumulate("AVERAGE"; ->Item_100_Avg_t; ->Item_100_Avg_t_i; 0)
		Item_150_Avg_t:=WKHR_Accumulate("AVERAGE"; ->Item_150_Avg_t; ->Item_150_Avg_t_i; 0)
		Item_200_Avg_t:=WKHR_Accumulate("AVERAGE"; ->Item_200_Avg_t; ->Item_200_Avg_t_i; 0)
		Item_220_Avg_t:=WKHR_Accumulate("AVERAGE"; ->Item_220_Avg_t; ->Item_220_Avg_t_i; 0)
		Item_300_Avg_t:=WKHR_Accumulate("AVERAGE"; ->Item_300_Avg_t; ->Item_300_Avg_t_i; 0)
		Item_350_Avg_t:=WKHR_Accumulate("AVERAGE"; ->Item_350_Avg_t; ->Item_350_Avg_t_i; 0)
		Item_400_Avg_t:=WKHR_Accumulate("AVERAGE"; ->Item_400_Avg_t; ->Item_400_Avg_t_i; 0)
		Item_450_Avg_t:=WKHR_Accumulate("AVERAGE"; ->Item_450_Avg_t; ->Item_450_Avg_t_i; 0)
		Item_500_Avg_t:=WKHR_Accumulate("AVERAGE"; ->Item_500_Avg_t; ->Item_500_Avg_t_i; 0)
		Item_600_Avg_t:=WKHR_Accumulate("AVERAGE"; ->Item_600_Avg_t; ->Item_600_Avg_t_i; 0)
		Item_700_Avg_t:=WKHR_Accumulate("AVERAGE"; ->Item_700_Avg_t; ->Item_700_Avg_t_i; 0)
		Item_710_Avg_t:=WKHR_Accumulate("AVERAGE"; ->Item_710_Avg_t; ->Item_710_Avg_t_i; 0)
		Item_750_Avg_t:=WKHR_Accumulate("AVERAGE"; ->Item_750_Avg_t; ->Item_750_Avg_t_i; 0)
		Item_800_Avg_t:=WKHR_Accumulate("AVERAGE"; ->Item_800_Avg_t; ->Item_800_Avg_t_i; 0)
		Item_900_Avg_t:=WKHR_Accumulate("AVERAGE"; ->Item_900_Avg_t; ->Item_900_Avg_t_i; 0)
		
End case 