If \
(False:C215\
)
	// Modified by: costasmanousakis-(Designer)-(10/31/06 16:14:50)
	Mods_2006_CM07\
		
End if \

Case of \

	: \
		(Form event code:C388\
		=On Clicked:K2:4\
		)
		SET CURSOR:C469\
			(4\
			)
		If \
			((vSortTotal\
			=0\
			) | (vSortTotal\
			=2\
			))
			ORDER BY:C49\
				([Contracts:79]\
				; [Contracts:79]TotalEncumbered:16\
				; >)
			vSortTotal\
				:=1\
				
		Else \
			
			ORDER BY:C49\
				([Contracts:79]\
				; [Contracts:79]TotalEncumbered:16\
				; <)
			vSortTotal\
				:=2\
				
		End if \
			
		
		vSortContract\
			:=0\
			
		vSortType\
			:=0\
			
		vSortStatus\
			:=0\
			
		vSortName\
			:=0\
			
		vSortADate\
			:=0\
			
		vSortCDate\
			:=0\
			
		vSortEDate\
			:=0\
			
		//vSortTotal:=0
		vSortApprox\
			:=0\
			
		vSortFedAid\
			:=0\
			
		vSortActual\
			:=0\
			
		SET CURSOR:C469\
			(0\
			)
		REDRAW WINDOW:C456\
			
End case \
