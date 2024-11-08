       IDENTIFICATION DIVISION.
           PROGRAM-ID. MOVE-CORRESPONDING.

       ENVIRONMENT DIVISION.

       DATA DIVISION.

           WORKING-STORAGE SECTION.

           77 DATE-TIME-YMD-RAW PIC X(14).
		   
		   01 DATE-TIME.
		      03  YEAR          PIC 9(4).
		      03  MONTH         PIC 9(2).
		      03  DAYX          PIC 9(2).
			  03  HOUR          PIC 9(2).
			  03  MINUTE        PIC 9(2).
			  03  SECOND        PIC 9(2).

		   01 DATE-TIME-US.
		      03  MONTH         PIC 9(2).
			  03  FILLER        PIC X(1) VALUE "/".
		      03  DAYX          PIC 9(2).
			  03  FILLER        PIC X(1) VALUE "/".
		      03  YEAR          PIC 9(4).
			  03  FILLER        PIC X(1) VALUE " ".
			  03  HOUR          PIC 9(2).
			  03  FILLER        PIC X(1) VALUE ":".
			  03  MINUTE        PIC 9(2).
			  03  FILLER        PIC X(1) VALUE ":".
			  03  SECOND        PIC 9(2).

		   01 DATE-TIME-EU.
		      03  YEAR          PIC 9(4).
			  03  FILLER        PIC X(1) VALUE "-".
		      03  MONTH         PIC 9(2).
			  03  FILLER        PIC X(1) VALUE "-".
		      03  DAYX          PIC 9(2).
			  03  FILLER        PIC X(1) VALUE " ".
			  03  HOUR          PIC 9(2).
			  03  FILLER        PIC X(1) VALUE ":".
			  03  MINUTE        PIC 9(2).
			  03  FILLER        PIC X(1) VALUE ":".
			  03  SECOND        PIC 9(2).

		   01 DATE-TIME-PT.
		      03  DAYX          PIC 9(2).
			  03  FILLER        PIC X(1) VALUE "/".
		      03  MONTH         PIC 9(2).
			  03  FILLER        PIC X(1) VALUE "/".
		      03  YEAR          PIC 9(4).
			  03  FILLER        PIC X(1) VALUE " ".
			  03  HOUR          PIC 9(2).
			  03  FILLER        PIC X(1) VALUE ":".
			  03  MINUTE        PIC 9(2).
			  03  FILLER        PIC X(1) VALUE ":".
			  03  SECOND        PIC 9(2).

		   77 BLANK-SCREEN      PIC X(1920) VALUE SPACES.               ;)
		   77 NATUREZA          PIC X.
           
       PROCEDURE DIVISION.
           
       MAIN SECTION.
       
       MAIN-10.

           DISPLAY BLANK-SCREEN.
		   
           DISPLAY 'Introduza natureza do movimento. F para terminar: '.
           ACCEPT NATUREZA.

           IF NATUREZA = 'F'
              GO TO MAIN-99.

           DISPLAY 'Introduza valor:'.
           ACCEPT VALOR.

           IF NATUREZA = 'C'
      *890123456789012345678901234567890123456789012345678901234567890123
      *                                                                 |
      *                                                                 V
                                              ADD VALOR TO TOTAL-CREDITO.      PONTO NA COLUNA 73

           IF NATUREZA = 'D'
              ADD VALOR TO TOTAL-DEBITO.
           
           GO TO MAIN-10.

       MAIN-99.

           DISPLAY "Totais:".
           DISPLAY "   Crédito: ", TOTAL-CREDITO.
           DISPLAY "    Débito: ", TOTAL-DEBITO.

           STOP RUN.
     