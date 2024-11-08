       IDENTIFICATION DIVISION.
           PROGRAM-ID. HELLO-WORLD.

       ENVIRONMENT DIVISION.

       DATA DIVISION.

           WORKING-STORAGE SECTION.

           77 VALOR            PIC 9(10) VALUE ZERO.
           77 NATUREZA         PIC X.
           77 TOTAL-DEBITO     PIC 9(10) VALUE ZERO.
           77 TOTAL-CREDITO    PIC 9(10) VALUE ZERO.

		   77 BLANK-SCREEN     PIC X(1920) VALUE SPACES.
           
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
           