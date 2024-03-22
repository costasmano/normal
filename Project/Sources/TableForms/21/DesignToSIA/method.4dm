//%attributes = {"lang":"en"} comment added and reserved by 4D.
If (False:C215)
	//[Dialogs];"DesignToSIA"
	// Modified by: costasmanousakis-(Designer)-(2/27/2007 15:43:18)
	Mods_2007_CM07
End if 
C_REAL:C285($num)
C_REAL:C285($DecPart)
C_LONGINT:C283($IntPart)  //Command Replaced was o_C_INTEGER
C_TEXT:C284($prefix)  // Command Replaced was o_C_STRING length was 10

C_REAL:C285(metric_vSideLeft; metric_vSideRight; metric_vSpanLength; metric_vStructLength; metric_vWidthOut; metric_vWidthCurb)
C_REAL:C285(trans_vSideLeft; trans_vSideRight; trans_vSpanLength; trans_vStructLength; trans_vWidthOut; trans_vWidthCurb)
C_REAL:C285(trans_vMinVertUc; trans_vMinLatUcRt; trans_vMinLatUcLt)
C_TEXT:C284(trans_vMinVertUc_code; trans_vMinLatUcRt_code; trans_vDeckCode; trans_vWearingSurfaceCode; trans_vScour; trans_vDesignLoad)  // Command Replaced was o_C_STRING length was 2
C_LONGINT:C283(trans_vLanesOn; trans_vLanesUnder)  //Command Replaced was o_C_INTEGER
C_LONGINT:C283(trans_vADTYear; trans_vSkewAngle)  //Command Replaced was o_C_INTEGER
C_LONGINT:C283(trans_vADT; trans_vNumSpans)


Case of 
	: (Form event code:C388=On Load:K2:1)
		
		InitChangeStack(2)
		OBJECT SET VISIBLE:C603(*; "temp@"; False:C215)
		
		//Data in [Bridge Design] are stored as decimal feet - convert to metric          
		If ([Bridge Design:75]MetricUnit:38=True:C214)
			OBJECT SET VISIBLE:C603(*; "metric@"; True:C214)
			OBJECT SET VISIBLE:C603(*; "eng@"; False:C215)
			
			metric_vSideLeft:=Round:C94([Bridge Design:75]SidewalkLeft:23*0.3048; 3)
			trans_vSideLeft:=Round:C94(metric_vSideLeft; 1)
			
			metric_vSideRight:=Round:C94([Bridge Design:75]SidewalkRight:24*0.3048; 3)
			trans_vSideRight:=Round:C94(metric_vSideRight; 1)
			
			metric_vSpanLength:=Round:C94([Bridge Design:75]TotalSpanLength:25*0.3048; 3)
			trans_vSpanLength:=Round:C94(metric_vSpanLength; 1)
			
			metric_vStructLength:=Round:C94([Bridge Design:75]StructLength:43*0.3048; 3)
			trans_vStructLength:=Round:C94(metric_vStructLength; 1)
			
			metric_vWidthOut:=Round:C94([Bridge Design:75]WideOutToOut:26*0.3048; 3)
			trans_vWidthOut:=Round:C94(metric_vWidthOut; 1)
			
			metric_vWidthCurb:=Round:C94([Bridge Design:75]WidthCurbToCurb:44*0.3048; 3)
			trans_vWidthCurb:=Round:C94(metric_vWidthCurb; 1)
			
			Case of 
				: ([Bridge Design:75]MinVertUnderclear:45=99.99)
					trans_vMinVertUc:=99.99
				: ([Bridge Design:75]MinVertUnderclear:45=0)
					trans_vMinVertUc:=0
				Else 
					metric_vMinVertUc:=Round:C94([Bridge Design:75]MinVertUnderclear:45*0.3048; 3)
					If (Int:C8(metric_vMinVertUc)>=30)
						trans_vMinVertUc:=99.99
					Else 
						trans_vMinVertUc:=Round:C94(metric_vMinVertUc; 2)
					End if 
			End case 
			
			Case of 
				: ([Bridge Design:75]MinLatUnderclearRT:46=99.9)
					trans_vMinLatUcRt:=99.9
				: ([Bridge Design:75]MinLatUnderclearRT:46=0)
					trans_vMinLatUcRt:=0
				Else 
					metric_vMinLatUcRt:=Round:C94([Bridge Design:75]MinLatUnderclearRT:46*0.3048; 3)
					If (Int:C8(metric_vMinLatUcRt)>=30)
						trans_vMinLatUcRt:=99.9
					Else 
						trans_vMinLatUcRt:=Round:C94(metric_vMinLatUcRt; 1)
					End if 
			End case 
			
			Case of 
				: ([Bridge Design:75]MinLatUnderclearLT:47=99.9)
					trans_vMinLatUcLt:=99.9
				: ([Bridge Design:75]MinLatUnderclearLT:47=99.8)
					trans_vMinLatUcLt:=99.8
				: ([Bridge Design:75]MinLatUnderclearLT:47=0)
					trans_vMinLatUcLt:=0
				Else 
					metric_vMinLatUcLt:=Round:C94([Bridge Design:75]MinLatUnderclearLT:47*0.3048; 3)
					If (Int:C8(metric_vMinLatUcLt)>=30)
						trans_vMinLatUcLt:=99.8
					Else 
						trans_vMinLatUcLt:=Round:C94(metric_vMinLatUcLt; 1)
					End if 
			End case 
			
		Else 
			//if measurements are in English, display original English value and 
			//converted Metric value (engMetric_)
			OBJECT SET VISIBLE:C603(*; "metric@"; False:C215)
			OBJECT SET VISIBLE:C603(*; "eng@"; True:C214)
			
			C_REAL:C285(eng_vSideLeft_ft; eng_vSideLeft_in; temp_vSideLeft; eng_vSideRight_ft; eng_vSideRight_in; temp_vSideRight)
			C_REAL:C285(eng_vStructLength_ft; eng_vStructLength_in; temp_vStructLength; eng_vWidthOut_ft; eng_vWidthOut_in; temp_vStructLength)
			C_REAL:C285(eng_vWidthOut_ft; eng_vWidthOut_in; temp_vWidthOut; eng_vWidthCurb_ft; eng_vWidthCurb_in; temp_vWidthCurb)
			C_REAL:C285(eng_vMinVertUc_ft; eng_vMinVertUc_in; temp_vMinVertUc)
			C_REAL:C285(eng_vMinLatUcRt_ft; eng_vMinLatUcRt_in; temp_vMinLatUcRt; eng_vMinLatUcLt_ft; eng_vMinLatUcLt_in; temp_vMinLatUcLt)
			
			eng_vSideLeft_ft:=Int:C8([Bridge Design:75]SidewalkLeft:23)
			eng_vSideLeft_in:=Round:C94(Dec:C9([Bridge Design:75]SidewalkLeft:23)*12; 3)
			temp_vSideLeft:=[Bridge Design:75]SidewalkLeft:23*0.3048
			trans_vSideLeft:=Round:C94(temp_vSideLeft; 1)
			
			eng_vSideRight_ft:=Int:C8([Bridge Design:75]SidewalkRight:24)
			eng_vSideRight_in:=Round:C94(Dec:C9([Bridge Design:75]SidewalkRight:24)*12; 3)
			temp_vSideRight:=[Bridge Design:75]SidewalkRight:24*0.3048
			trans_vSideRight:=Round:C94(temp_vSideRight; 1)
			
			eng_vSpanLength_ft:=Int:C8([Bridge Design:75]TotalSpanLength:25)
			eng_vSpanLength_in:=Round:C94(Dec:C9([Bridge Design:75]TotalSpanLength:25)*12; 3)
			temp_vSpanLength:=[Bridge Design:75]TotalSpanLength:25*0.3048
			trans_vSpanLength:=Round:C94(temp_vSpanLength; 1)
			
			eng_vStructLength_ft:=Int:C8([Bridge Design:75]TotalSpanLength:25)
			eng_vStructLength_in:=Round:C94(Dec:C9([Bridge Design:75]TotalSpanLength:25)*12; 3)
			temp_vStructLength:=[Bridge Design:75]TotalSpanLength:25*0.3048
			trans_vStructLength:=Round:C94(temp_vStructLength; 1)
			
			eng_vWidthOut_ft:=Int:C8([Bridge Design:75]WideOutToOut:26)
			eng_vWidthOut_in:=Round:C94(Dec:C9([Bridge Design:75]WideOutToOut:26)*12; 3)
			temp_vWidthOut:=[Bridge Design:75]WideOutToOut:26*0.3048
			trans_vWidthOut:=Round:C94(temp_vWidthOut; 1)
			
			eng_vWidthCurb_ft:=Int:C8([Bridge Design:75]WidthCurbToCurb:44)
			eng_vWidthCurb_in:=Round:C94(Dec:C9([Bridge Design:75]WidthCurbToCurb:44)*12; 3)
			temp_vWidthCurb:=[Bridge Design:75]WidthCurbToCurb:44*0.3048
			trans_vWidthCurb:=Round:C94(temp_vWidthCurb; 1)
			
			If ([Bridge Design:75]MinVertUnderclear:45=99.99)
				eng_vMinVertUc_ft:=0
				eng_vMinVertUc_in:=99.99
				temp_vMinVertUc:=99.99
			Else 
				eng_vMinVertUc_ft:=Int:C8([Bridge Design:75]MinVertUnderclear:45)
				eng_vMinVertUc_in:=Round:C94(Dec:C9([Bridge Design:75]MinVertUnderclear:45)*12; 3)
				temp_vMinVertUc:=[Bridge Design:75]MinVertUnderclear:45*0.3048
			End if 
			
			If (Int:C8(temp_vMinVertUc)>=30)
				trans_vMinVertUc:=99.99
			Else 
				trans_vMinVertUc:=Round:C94(temp_vMinVertUc; 2)
			End if 
			
			
			//```````````      
			If ([Bridge Design:75]MinLatUnderclearRT:46=99.9)
				eng_vMinLatUcRt_ft:=0
				eng_vMinLatUcRt_in:=99.9
				temp_vMinLatUcRt:=99.9
			Else 
				eng_vMinLatUcRt_ft:=Int:C8([Bridge Design:75]MinLatUnderclearRT:46)
				eng_vMinLatUcRt_in:=Round:C94(Dec:C9([Bridge Design:75]MinLatUnderclearRT:46)*12; 3)
				temp_vMinLatUcRt:=[Bridge Design:75]MinLatUnderclearRT:46*0.3048
			End if 
			
			If (Int:C8(temp_vMinLatUcRt)>=30)
				trans_vMinLatUcRt:=99.9
			Else 
				trans_vMinLatUcRt:=Round:C94(temp_vMinLatUcRt; 1)
			End if 
			//```````````
			If ([Bridge Design:75]MinLatUnderclearLT:47=99.9) | ([Bridge Design:75]MinLatUnderclearLT:47=99.8)
				eng_vMinLatUcLt_ft:=0
				eng_vMinLatUcLt_in:=[Bridge Design:75]MinLatUnderclearLT:47
				temp_vMinLatUcLt:=[Bridge Design:75]MinLatUnderclearLT:47
			Else 
				eng_vMinLatUcLt_ft:=Int:C8([Bridge Design:75]MinLatUnderclearLT:47)
				eng_vMinLatUcLt_in:=Round:C94(Dec:C9([Bridge Design:75]MinLatUnderclearLT:47)*12; 3)
				temp_vMinLatUcLt:=[Bridge Design:75]MinLatUnderclearLT:47*0.3048
			End if 
			
			If (Int:C8(temp_vMinLatUcLt)>=30)
				trans_vMinLatUcLt:=99.9
			Else 
				trans_vMinLatUcLt:=Round:C94(temp_vMinLatUcLt; 1)
			End if 
		End if 
		
		C_LONGINT:C283($k)  //Command Replaced was o_C_INTEGER
		$k:=Find in array:C230(<>aDesign_Scour; [Bridge Design:75]Scour:17)
		If ($k#-1)
			trans_vScour:=<>aTrans_Scour{$k}
		Else 
			trans_vScour:=""
		End if 
		
		$k:=Find in array:C230(<>aDesign_SuperStr; [Bridge Design:75]SuperStruct:11)
		If ($k#-1)
			trans_vStructCode:=<>aTrans_SuperStr{$k}
		Else 
			trans_vStructCode:=""
		End if 
		If ($k#-1)
			C_TEXT:C284(item43a)  // Command Replaced was o_C_STRING length was 1//This must not be a local variable!
			C_TEXT:C284(item43b)  // Command Replaced was o_C_STRING length was 2//This must not be a local variable!
			item43a:=Substring:C12(trans_vStructCode; 1; 1)
			item43b:=Substring:C12(trans_vStructCode; 2; 2)
			trans_vStructDesc:=Get_Description(-><>aMaterial; -><>aMatCode; ->item43a)+" "+Get_Description(-><>aDesign; -><>aDesignCod; ->item43b)
		Else 
			trans_vStructDesc:=""
		End if 
		
		$k:=Find in array:C230(<>aDesign_Deck; [Bridge Design:75]Deck:13)
		If ($k#-1)
			trans_vDeckCode:=<>aTrans_Deck{$k}
			trans_vWearingSurfaceCode:=<>aTrans_WearingSurface{$k}
			trans_vDeckDesc:=Get_Description(-><>aDeck; -><>aDeckCod; ->trans_vDeckCode)
			trans_vWearingSurfaceDesc:=Get_Description(-><>aWearing; -><>aWearCod; ->trans_vWearingSurfaceCode)
		Else 
			trans_vDeckCode:=""
			trans_vWearingSurfaceCode:=""
			trans_vDeckDesc:=""
			trans_vWearingSurfaceDesc:=""
		End if 
		
		$k:=Find in array:C230(<>aDesignLoad; [Bridge Design:75]DesignLoad:36)
		If ($k#-1)
			trans_vDesignLoad:=<>aDesLoadCod{$k}
		Else 
			trans_vDesignLoad:=""
		End if 
		
		trans_vSkewAngle:=[Bridge Design:75]SkewAngle:28
		trans_vNumSpans:=[Bridge Design:75]NumSpans:27
		trans_vLanesOn:=[Bridge Design:75]LanesOnStruct:39
		trans_vLanesUnder:=[Bridge Design:75]LanesUnderStruct:40
		trans_vADT:=[Bridge Design:75]AvgDailyTraffic:41
		trans_vADTYear:=[Bridge Design:75]YearADT:42
		trans_vMinVertUc_code:=[Bridge Design:75]MinVertUcCode:48
		trans_vMinLatUcRt_code:=[Bridge Design:75]MinLatUcCode:49
		
		//compare with SI&A values and set the colors
		C_LONGINT:C283($greenColor; $redColor)
		
		$greenColor:=-(Dark green:K11:10+(256*White:K11:1))
		$redColor:=-(Red:K11:4+(256*White:K11:1))
		
		If (trans_vDesignLoad=[Bridge MHD NBIS:1]Item31:135)
			OBJECT SET RGB COLORS:C628(trans_vDesignLoad; Col_paletteToRGB(Abs:C99($greenColor)%256); Col_paletteToRGB(Abs:C99($greenColor)\256))  // **Replaced o OBJECT SET COLOR(trans_vDesignLoad;$greenColor)
		Else 
			OBJECT SET RGB COLORS:C628(trans_vDesignLoad; Col_paletteToRGB(Abs:C99($redColor)%256); Col_paletteToRGB(Abs:C99($redColor)\256))  // **Replaced o OBJECT SET COLOR(trans_vDesignLoad;$redColor)
		End if 
		
		If (trans_vStructCode=[Bridge MHD NBIS:1]Item43:75)
			OBJECT SET RGB COLORS:C628(trans_vStructCode; Col_paletteToRGB(Abs:C99($greenColor)%256); Col_paletteToRGB(Abs:C99($greenColor)\256))  // **Replaced o OBJECT SET COLOR(trans_vStructCode;$greenColor)
		Else 
			OBJECT SET RGB COLORS:C628(trans_vStructCode; Col_paletteToRGB(Abs:C99($redColor)%256); Col_paletteToRGB(Abs:C99($redColor)\256))  // **Replaced o OBJECT SET COLOR(trans_vStructCode;$redColor)
		End if 
		
		If (trans_vDeckCode=[Bridge MHD NBIS:1]Item107:79)
			OBJECT SET RGB COLORS:C628(trans_vDeckCode; Col_paletteToRGB(Abs:C99($greenColor)%256); Col_paletteToRGB(Abs:C99($greenColor)\256))  // **Replaced o OBJECT SET COLOR(trans_vDeckCode;$greenColor)
		Else 
			OBJECT SET RGB COLORS:C628(trans_vDeckCode; Col_paletteToRGB(Abs:C99($redColor)%256); Col_paletteToRGB(Abs:C99($redColor)\256))  // **Replaced o OBJECT SET COLOR(trans_vDeckCode;$redColor)
		End if 
		
		If (trans_vWearingSurfaceCode=[Bridge MHD NBIS:1]Item108A:80)
			OBJECT SET RGB COLORS:C628(trans_vWearingSurfaceCode; Col_paletteToRGB(Abs:C99($greenColor)%256); Col_paletteToRGB(Abs:C99($greenColor)\256))  // **Replaced o OBJECT SET COLOR(trans_vWearingSurfaceCode;$greenColor)
		Else 
			OBJECT SET RGB COLORS:C628(trans_vWearingSurfaceCode; Col_paletteToRGB(Abs:C99($redColor)%256); Col_paletteToRGB(Abs:C99($redColor)\256))  // **Replaced o OBJECT SET COLOR(trans_vWearingSurfaceCode;$redColor)
		End if 
		
		If (trans_vScour=[Bridge MHD NBIS:1]Item113:151)
			OBJECT SET RGB COLORS:C628(trans_vScour; Col_paletteToRGB(Abs:C99($greenColor)%256); Col_paletteToRGB(Abs:C99($greenColor)\256))  // **Replaced o OBJECT SET COLOR(trans_vScour;$greenColor)
		Else 
			OBJECT SET RGB COLORS:C628(trans_vScour; Col_paletteToRGB(Abs:C99($redColor)%256); Col_paletteToRGB(Abs:C99($redColor)\256))  // **Replaced o OBJECT SET COLOR(trans_vScour;$redColor)
		End if 
		
		If (trans_vSkewAngle=[Bridge MHD NBIS:1]Item34:100)
			OBJECT SET RGB COLORS:C628(trans_vSkewAngle; Col_paletteToRGB(Abs:C99($greenColor)%256); Col_paletteToRGB(Abs:C99($greenColor)\256))  // **Replaced o OBJECT SET COLOR(trans_vSkewAngle;$greenColor)
		Else 
			OBJECT SET RGB COLORS:C628(trans_vSkewAngle; Col_paletteToRGB(Abs:C99($redColor)%256); Col_paletteToRGB(Abs:C99($redColor)\256))  // **Replaced o OBJECT SET COLOR(trans_vSkewAngle;$redColor)
		End if 
		
		If (trans_vNumSpans=[Bridge MHD NBIS:1]Item45:77)
			OBJECT SET RGB COLORS:C628(trans_vNumSpans; Col_paletteToRGB(Abs:C99($greenColor)%256); Col_paletteToRGB(Abs:C99($greenColor)\256))  // **Replaced o OBJECT SET COLOR(trans_vNumSpans;$greenColor)
		Else 
			OBJECT SET RGB COLORS:C628(trans_vNumSpans; Col_paletteToRGB(Abs:C99($redColor)%256); Col_paletteToRGB(Abs:C99($redColor)\256))  // **Replaced o OBJECT SET COLOR(trans_vNumSpans;$redColor)
		End if 
		
		If (trans_vSpanLength=[Bridge MHD NBIS:1]Item48:92)
			OBJECT SET RGB COLORS:C628(trans_vSpanLength; Col_paletteToRGB(Abs:C99($greenColor)%256); Col_paletteToRGB(Abs:C99($greenColor)\256))  // **Replaced o OBJECT SET COLOR(trans_vSpanLength;$greenColor)
		Else 
			OBJECT SET RGB COLORS:C628(trans_vSpanLength; Col_paletteToRGB(Abs:C99($redColor)%256); Col_paletteToRGB(Abs:C99($redColor)\256))  // **Replaced o OBJECT SET COLOR(trans_vSpanLength;$redColor)
		End if 
		
		If (trans_vStructLength=[Bridge MHD NBIS:1]Item49:93)
			OBJECT SET RGB COLORS:C628(trans_vStructLength; Col_paletteToRGB(Abs:C99($greenColor)%256); Col_paletteToRGB(Abs:C99($greenColor)\256))  // **Replaced o OBJECT SET COLOR(trans_vStructLength;$greenColor)
		Else 
			OBJECT SET RGB COLORS:C628(trans_vStructLength; Col_paletteToRGB(Abs:C99($redColor)%256); Col_paletteToRGB(Abs:C99($redColor)\256))  // **Replaced o OBJECT SET COLOR(trans_vStructLength;$redColor)
		End if 
		
		If (trans_vSideLeft=[Bridge MHD NBIS:1]Item50A:94)
			OBJECT SET RGB COLORS:C628(trans_vSideLeft; Col_paletteToRGB(Abs:C99($greenColor)%256); Col_paletteToRGB(Abs:C99($greenColor)\256))  // **Replaced o OBJECT SET COLOR(trans_vSideLeft;$greenColor)
		Else 
			OBJECT SET RGB COLORS:C628(trans_vSideLeft; Col_paletteToRGB(Abs:C99($redColor)%256); Col_paletteToRGB(Abs:C99($redColor)\256))  // **Replaced o OBJECT SET COLOR(trans_vSideLeft;$redColor)
		End if 
		
		If (trans_vSideRight=[Bridge MHD NBIS:1]Item50B:95)
			OBJECT SET RGB COLORS:C628(trans_vSideRight; Col_paletteToRGB(Abs:C99($greenColor)%256); Col_paletteToRGB(Abs:C99($greenColor)\256))  // **Replaced o OBJECT SET COLOR(trans_vSideRight;$greenColor)
		Else 
			OBJECT SET RGB COLORS:C628(trans_vSideRight; Col_paletteToRGB(Abs:C99($redColor)%256); Col_paletteToRGB(Abs:C99($redColor)\256))  // **Replaced o OBJECT SET COLOR(trans_vSideRight;$redColor)
		End if 
		
		If (trans_vWidthCurb=[Bridge MHD NBIS:1]Item51:96)
			OBJECT SET RGB COLORS:C628(trans_vWidthCurb; Col_paletteToRGB(Abs:C99($greenColor)%256); Col_paletteToRGB(Abs:C99($greenColor)\256))  // **Replaced o OBJECT SET COLOR(trans_vWidthCurb;$greenColor)
		Else 
			OBJECT SET RGB COLORS:C628(trans_vWidthCurb; Col_paletteToRGB(Abs:C99($redColor)%256); Col_paletteToRGB(Abs:C99($redColor)\256))  // **Replaced o OBJECT SET COLOR(trans_vWidthCurb;$redColor)
		End if 
		
		If (trans_vWidthOut=[Bridge MHD NBIS:1]Item52:97)
			OBJECT SET RGB COLORS:C628(trans_vWidthOut; Col_paletteToRGB(Abs:C99($greenColor)%256); Col_paletteToRGB(Abs:C99($greenColor)\256))  // **Replaced o OBJECT SET COLOR(trans_vWidthOut;$greenColor)
		Else 
			OBJECT SET RGB COLORS:C628(trans_vWidthOut; Col_paletteToRGB(Abs:C99($redColor)%256); Col_paletteToRGB(Abs:C99($redColor)\256))  // **Replaced o OBJECT SET COLOR(trans_vWidthOut;$redColor)
		End if 
		
		If (trans_vMinVertUc_code=[Bridge MHD NBIS:1]Item54A:107)
			OBJECT SET RGB COLORS:C628(trans_vMinVertUc_code; Col_paletteToRGB(Abs:C99($greenColor)%256); Col_paletteToRGB(Abs:C99($greenColor)\256))  // **Replaced o OBJECT SET COLOR(trans_vMinVertUc_code;$greenColor)
		Else 
			OBJECT SET RGB COLORS:C628(trans_vMinVertUc_code; Col_paletteToRGB(Abs:C99($redColor)%256); Col_paletteToRGB(Abs:C99($redColor)\256))  // **Replaced o OBJECT SET COLOR(trans_vMinVertUc_code;$redColor)
		End if 
		
		If (trans_vMinVertUc=[Bridge MHD NBIS:1]Item54B:108)
			OBJECT SET RGB COLORS:C628(trans_vMinVertUc; Col_paletteToRGB(Abs:C99($greenColor)%256); Col_paletteToRGB(Abs:C99($greenColor)\256))  // **Replaced o OBJECT SET COLOR(trans_vMinVertUc;$greenColor)
		Else 
			OBJECT SET RGB COLORS:C628(trans_vMinVertUc; Col_paletteToRGB(Abs:C99($redColor)%256); Col_paletteToRGB(Abs:C99($redColor)\256))  // **Replaced o OBJECT SET COLOR(trans_vMinVertUc;$redColor)
		End if 
		
		If (trans_vMinLatUcRt_code=[Bridge MHD NBIS:1]Item55A:110)
			OBJECT SET RGB COLORS:C628(*; trans_vMinLatUcRt_code; Col_paletteToRGB(Abs:C99($greenColor)%256); Col_paletteToRGB(Abs:C99($greenColor)\256))  // **Replaced o OBJECT SET COLOR(*;trans_vMinLatUcRt_code;$greenColor)
		Else 
			OBJECT SET RGB COLORS:C628(trans_vMinLatUcRt_code; Col_paletteToRGB(Abs:C99($redColor)%256); Col_paletteToRGB(Abs:C99($redColor)\256))  // **Replaced o OBJECT SET COLOR(trans_vMinLatUcRt_code;$redColor)
		End if 
		
		If (trans_vMinLatUcRt=[Bridge MHD NBIS:1]Item55B:111)
			OBJECT SET RGB COLORS:C628(trans_vMinLatUcRt; Col_paletteToRGB(Abs:C99($greenColor)%256); Col_paletteToRGB(Abs:C99($greenColor)\256))  // **Replaced o OBJECT SET COLOR(trans_vMinLatUcRt;$greenColor)
		Else 
			OBJECT SET RGB COLORS:C628(trans_vMinLatUcRt; Col_paletteToRGB(Abs:C99($redColor)%256); Col_paletteToRGB(Abs:C99($redColor)\256))  // **Replaced o OBJECT SET COLOR(trans_vMinLatUcRt;$redColor)
		End if 
		
		If (trans_vMinLatUcLt=[Bridge MHD NBIS:1]Item56:112)
			OBJECT SET RGB COLORS:C628(trans_vMinLatUcLt; Col_paletteToRGB(Abs:C99($greenColor)%256); Col_paletteToRGB(Abs:C99($greenColor)\256))  // **Replaced o OBJECT SET COLOR(trans_vMinLatUcLt;$greenColor)
		Else 
			OBJECT SET RGB COLORS:C628(trans_vMinLatUcLt; Col_paletteToRGB(Abs:C99($redColor)%256); Col_paletteToRGB(Abs:C99($redColor)\256))  // **Replaced o OBJECT SET COLOR(trans_vMinLatUcLt;$redColor)
		End if 
		
		If (trans_vLanesOn=[Bridge MHD NBIS:1]Item28A:86)
			OBJECT SET RGB COLORS:C628(trans_vLanesOn; Col_paletteToRGB(Abs:C99($greenColor)%256); Col_paletteToRGB(Abs:C99($greenColor)\256))  // **Replaced o OBJECT SET COLOR(trans_vLanesOn;$greenColor)
		Else 
			OBJECT SET RGB COLORS:C628(trans_vLanesOn; Col_paletteToRGB(Abs:C99($redColor)%256); Col_paletteToRGB(Abs:C99($redColor)\256))  // **Replaced o OBJECT SET COLOR(trans_vLanesOn;$redColor)
		End if 
		
		If (trans_vLanesUnder=[Bridge MHD NBIS:1]Item28B:87)
			OBJECT SET RGB COLORS:C628(trans_vLanesUnder; Col_paletteToRGB(Abs:C99($greenColor)%256); Col_paletteToRGB(Abs:C99($greenColor)\256))  // **Replaced o OBJECT SET COLOR(trans_vLanesUnder;$greenColor)
		Else 
			OBJECT SET RGB COLORS:C628(trans_vLanesUnder; Col_paletteToRGB(Abs:C99($redColor)%256); Col_paletteToRGB(Abs:C99($redColor)\256))  // **Replaced o OBJECT SET COLOR(trans_vLanesUnder;$redColor)
		End if 
		
		If (trans_vADT=[Bridge MHD NBIS:1]Item29:88)
			OBJECT SET RGB COLORS:C628(trans_vADT; Col_paletteToRGB(Abs:C99($greenColor)%256); Col_paletteToRGB(Abs:C99($greenColor)\256))  // **Replaced o OBJECT SET COLOR(trans_vADT;$greenColor)
		Else 
			OBJECT SET RGB COLORS:C628(trans_vADT; Col_paletteToRGB(Abs:C99($redColor)%256); Col_paletteToRGB(Abs:C99($redColor)\256))  // **Replaced o OBJECT SET COLOR(trans_vADT;$redColor)
		End if 
		
		If (trans_vADTYear=[Bridge MHD NBIS:1]Item30:89)
			OBJECT SET RGB COLORS:C628(trans_vADTYear; Col_paletteToRGB(Abs:C99($greenColor)%256); Col_paletteToRGB(Abs:C99($greenColor)\256))  // **Replaced o OBJECT SET COLOR(trans_vADTYear;$greenColor)
		Else 
			OBJECT SET RGB COLORS:C628(trans_vADTYear; Col_paletteToRGB(Abs:C99($redColor)%256); Col_paletteToRGB(Abs:C99($redColor)\256))  // **Replaced o OBJECT SET COLOR(trans_vADTYear;$redColor)
		End if 
		
	: (Form event code:C388=On After Keystroke:K2:26)
		REDRAW WINDOW:C456
End case 
