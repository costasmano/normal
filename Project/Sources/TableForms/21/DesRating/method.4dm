If (Form event code:C388=On Load:K2:1)
	COPY ARRAY:C226(<>aDesignLoad; aDesLoads)
	DELETE FROM ARRAY:C228(aDesLoads; 6; 4)
End if 