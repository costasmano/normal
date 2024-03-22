If (False:C215)
	//[Out of Freq].P_OutofFreq
	// Modified by: manousakisc-(Designer)-(9/7/2023 11:08:51)
	Mods_2023_09
	//  `made all text, variables, fields, rectangles, matrices transparent
	//  `replaced MHD logo with DOT logo
End if 

Case of 
	: ((Form event code:C388=On Load:K2:1) | (Form event code:C388=On Printing Detail:K2:18) | (Form event code:C388=On Display Detail:K2:22))
		C_TEXT:C284(vsDate)  // Command Replaced was o_C_STRING length was 80
		
		vsDate:=String:C10([Out of Freq:70]Date_Created:1; 5)
		
		D1_month:=[Out of Freq:70]D1_reqd:5-[Out of Freq:70]D1_made:17
		D2_month:=[Out of Freq:70]D2_reqd:6-[Out of Freq:70]D2_made:18
		D3_month:=[Out of Freq:70]D3_reqd:7-[Out of Freq:70]D3_made:19
		D4_month:=[Out of Freq:70]D4_reqd:8-[Out of Freq:70]D4_made:20
		D5_month:=[Out of Freq:70]D5_reqd:9-[Out of Freq:70]D5_made:21
		If (D1_month<0)
			D1_month:=0
		End if 
		If (D2_month<0)
			D2_month:=0
		End if 
		If (D3_month<0)
			D3_month:=0
		End if 
		If (D4_month<0)
			D4_month:=0
		End if 
		If (D5_month<0)
			D5_month:=0
		End if 
		
		Dive_month:=[Out of Freq:70]Dive_reqd:16-[Out of Freq:70]Dive_made:28
		MBTA_month:=[Out of Freq:70]MBTA_reqd:10-[Out of Freq:70]MBTA_made:22
		MDC_month:=[Out of Freq:70]MDC_reqd:11-[Out of Freq:70]MDC_made:23
		MTA_month:=[Out of Freq:70]MTA_reqd:12-[Out of Freq:70]MTA_made:24
		MPA_month:=[Out of Freq:70]MPA_reqd:13-[Out of Freq:70]MPA_made:25
		If (MBTA_month<0)
			MBTA_month:=0
		End if 
		If (MDC_month<0)
			MDC_month:=0
		End if 
		If (MTA_month<0)
			MTA_month:=0
		End if 
		If (MPA_month<0)
			MPA_month:=0
		End if 
		S_reqd:=[Out of Freq:70]D1_reqd:5+[Out of Freq:70]D2_reqd:6+[Out of Freq:70]D3_reqd:7
		S_reqd:=S_reqd+[Out of Freq:70]D4_reqd:8+[Out of Freq:70]D5_reqd:9+[Out of Freq:70]Dive_reqd:16
		S_made:=[Out of Freq:70]D1_made:17+[Out of Freq:70]D2_made:18+[Out of Freq:70]D3_made:19
		S_made:=S_made+[Out of Freq:70]D4_made:20+[Out of Freq:70]D5_made:21+[Out of Freq:70]Dive_made:28
		S_reqd:=[Out of Freq:70]D1_reqd:5+[Out of Freq:70]D2_reqd:6+[Out of Freq:70]D3_reqd:7
		S_reqd:=S_reqd+[Out of Freq:70]D4_reqd:8+[Out of Freq:70]D5_reqd:9+[Out of Freq:70]Dive_reqd:16
		S_month:=S_reqd-S_made
		S_1ytd:=[Out of Freq:70]D1_1ytd:29+[Out of Freq:70]D2_1ytd:30+[Out of Freq:70]D3_1ytd:31
		S_1ytd:=S_1ytd+[Out of Freq:70]D4_1ytd:32+[Out of Freq:70]D5_1ytd:33+[Out of Freq:70]Dive_1ytd:40
		S_2ytd:=[Out of Freq:70]D1_2ytd:41+[Out of Freq:70]D2_2ytd:42+[Out of Freq:70]D3_2ytd:43
		S_2ytd:=S_2ytd+[Out of Freq:70]D4_2ytd:44+[Out of Freq:70]D5_2ytd:45+[Out of Freq:70]Dive_2ytd:52
		S_3ytd:=[Out of Freq:70]D1_3ytd:53+[Out of Freq:70]D2_3ytd:54+[Out of Freq:70]D3_3ytd:55
		S_3ytd:=S_3ytd+[Out of Freq:70]D4_3ytd:56+[Out of Freq:70]D5_3ytd:57+[Out of Freq:70]Dive_3ytd:64
		A_reqd:=[Out of Freq:70]MBTA_reqd:10+[Out of Freq:70]MDC_reqd:11+[Out of Freq:70]MTA_reqd:12+[Out of Freq:70]MPA_reqd:13
		A_made:=[Out of Freq:70]MBTA_made:22+[Out of Freq:70]MDC_made:23+[Out of Freq:70]MTA_made:24+[Out of Freq:70]MPA_made:25
		A_month:=A_reqd-A_made
		A_1ytd:=[Out of Freq:70]MBTA_1ytd:34+[Out of Freq:70]MDC_1ytd:35+[Out of Freq:70]MTA_1ytd:36+[Out of Freq:70]MPA_1ytd:37
		A_2ytd:=[Out of Freq:70]MBTA_2ytd:46+[Out of Freq:70]MDC_2ytd:47+[Out of Freq:70]MTA_2ytd:48+[Out of Freq:70]MPA_2ytd:49
		A_3ytd:=[Out of Freq:70]MBTA_3ytd:58+[Out of Freq:70]MDC_3ytd:59+[Out of Freq:70]MTA_3ytd:60+[Out of Freq:70]MPA_3ytd:61
		total_reqd:=S_reqd+A_reqd
		total_made:=S_made+A_made
		total_1ytd:=S_1ytd+A_1ytd
		total_2ytd:=S_2ytd+A_2ytd
		total_3ytd:=S_3ytd+A_3ytd
		total_month:=S_month+A_month
End case 