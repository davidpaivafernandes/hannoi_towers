       IDENTIFICATION DIVISION.
           PROGRAM-ID. T1.

       ENVIRONMENT DIVISION.

       INPUT-OUTPUT SECTION.

       FILE-CONTROL.

           SELECT CUSTOMERS ASSIGN TO "./files/CUSTOMERS.DAT"
           ORGANIZATION IS INDEXED
           ACCESS MODE IS DYNAMIC
           RECORD KEY IS CUSTOMER-ID OF CUSTOMER-RECORD
           ALTERNATE RECORD KEY IS CUSTOMER-PCD4 OF CUSTOMER-RECORD
               WITH DUPLICATES
           FILE STATUS IS WS-FS1.

           SELECT CUSTOMERS-TXT ASSIGN TO "./files/CUSTOMERS.TXT"
           ORGANIZATION IS LINE SEQUENTIAL
           ACCESS MODE IS SEQUENTIAL
           FILE STATUS IS WS-FS1.

       DATA DIVISION.

       FILE SECTION.

       FD  CUSTOMERS-TXT LABEL RECORD IS STANDARD
           RECORD CONTAINS   73 CHARACTERS
           BLOCK  CONTAINS  730 CHARACTERS
           DATA RECORD IS CUSTOMER-TXT-RECORD.

       01 CUSTOMER-TXT-RECORD.
           03 CUSTOMER-ID              PIC 9(03).
           03 CUSTOMER-NAME            PIC X(30).
           03 CUSTOMER-POSTALCODE.
              05 CUSTOMER-PCD4         PIC X(04).
              05 CUSTOMER-PCD3         PIC X(03).
              05 CUSTOMER-CITY   PIC X(30).
           03 CUSTOMER-DELIVERY-TIME   PIC 9(03).

       FD  CUSTOMERS LABEL RECORD IS STANDARD
           RECORD CONTAINS   73 CHARACTERS
           BLOCK  CONTAINS  730 CHARACTERS
           DATA RECORD IS CUSTOMER-RECORD.

       01 CUSTOMER-RECORD.
           03 CUSTOMER-ID              PIC 9(03).
           03 CUSTOMER-NAME            PIC X(30).
           03 CUSTOMER-POSTALCODE.
              05 CUSTOMER-PCD4         PIC X(04).
              05 CUSTOMER-PCD3         PIC X(03).
              05 CUSTOMER-CITY   PIC X(30).
           03 CUSTOMER-DELIVERY-TIME   PIC 9(03).

       WORKING-STORAGE SECTION.

       01 WS-VAR.
           03 WS-FS1                  PIC 9(02).
           03 WS-EOF-SW               PIC X(01) VALUE 'N'.
              88 EOF-SW               VALUE 'Y'.
              88 NOT-EOF-SW           VALUE 'N'.
           
       01 CUSTOMER-RECORD-FMT.
           03 CUSTOMER-ID              PIC 9(03).
           03 FILLER                  PIC X(3) VALUE " ! ".
           03 CUSTOMER-NAME            PIC X(30).
           03 FILLER                  PIC X(3) VALUE " ! ".
           03 CUSTOMER-POSTALCODE.
              05 CUSTOMER-PCD4         PIC X(04).
              05 FILLER               PIC X(1) VALUE "-".
              05 CUSTOMER-PCD3         PIC X(03).
              05 FILLER               PIC X(3) VALUE " ! ".
              05 CUSTOMER-CITY   PIC X(30).
           03 FILLER                  PIC X(3) VALUE " ! ".
           03 CUSTOMER-DELIVERY-TIME   PIC 9(03).

       PROCEDURE DIVISION.
           
       MAIN SECTION.
           
       MAIN-10.

           PERFORM WRITE-DATA.
      *    PERFORM UPDATE-DATA.
           PERFORM SHOW-DATA.

       MAIN-99.

           DISPLAY "OK".
           STOP RUN.
     
       WRITE-DATA SECTION.

       WRITE-DATA-10.

           OPEN INPUT CUSTOMERS-TXT.

           IF WS-FS1 NOT = ZEROS THEN            
               DISPLAY 'ERROR OPENING CUSTOMERS-TXT'          
               DISPLAY 'ERROR CODE IS : ', WS-FS1
               GO TO WRITE-DATA-99.

           OPEN OUTPUT CUSTOMERS.

           IF WS-FS1 NOT = ZEROS THEN            
               DISPLAY 'ERROR OPENING CUSTOMERS'          
               DISPLAY 'ERROR CODE IS : ', WS-FS1
               GO TO WRITE-DATA-91.

       WRITE-DATA-20.

           READ CUSTOMERS-TXT INTO CUSTOMER-RECORD 
               AT END GO TO WRITE-DATA-90.
           
           DISPLAY CUSTOMER-ID OF CUSTOMER-RECORD.

           WRITE CUSTOMER-RECORD.

           GO TO WRITE-DATA-20.

       WRITE-DATA-90.

           CLOSE CUSTOMERS.

       WRITE-DATA-91.

           CLOSE CUSTOMERS-TXT.

       WRITE-DATA-99.

           EXIT.

       SHOW-DATA SECTION.

           OPEN INPUT CUSTOMERS.

           MOVE 1 TO CUSTOMER-ID OF CUSTOMER-RECORD.
           START CUSTOMERS KEY 
               GREATER THAN OR EQUAL TO CUSTOMER-ID OF CUSTOMER-RECORD
               INVALID KEY GO TO SHOW-DATA-80.

       SHOW-DATA-10.

           READ CUSTOMERS NEXT RECORD INTO CUSTOMER-RECORD-FMT
               AT END GO TO SHOW-DATA-90.
           DISPLAY CUSTOMER-RECORD-FMT.
           
           GO TO SHOW-DATA-10.

       SHOW-DATA-80.

           DISPLAY "Invalid key.".

       SHOW-DATA-90.

           CLOSE CUSTOMERS.

       SHOW-DATA-99.

           EXIT. 

       UPDATE-DATA SECTION.

           OPEN I-O CUSTOMERS.

           IF WS-FS1 NOT = ZEROS THEN            
               DISPLAY 'ERROR OPENING FILENAME'          
               DISPLAY 'ERROR CODE IS : ', 'CUSTOMERS''
               GO TO UPDATE-DATA-99.

      * CLIENT-ID IS THE KEY FIELD
           MOVE 1 TO CUSTOMER-ID OF CUSTOMER-RECORD.

      * SET THE FILE "POINTER" TO THE FIRST RECORD RESPECTING THE PREDICATE

           START CUSTOMERS KEY 
               GREATER THAN OR EQUAL TO CUSTOMER-ID OF CUSTOMER-RECORD
               INVALID KEY GO TO UPDATE-DATA-80.

       UPDATE-DATA-10.

      * THE ORDER BY WHICH THE RECORDS ARE READ IS THE ORDER OF VALUES 
      * IN THE KEY FIELD CUSTOMER-ID

           READ CUSTOMERS NEXT RECORD 
               AT END GO TO UPDATE-DATA-90.

           IF CUSTOMER-PCD4 OF CUSTOMER-RECORD = 4475
               MOVE 20 TO CUSTOMER-DELIVERY-TIME OF CUSTOMER-RECORD.
               DISPLAY CUSTOMER-ID OF CUSTOMER-RECORD
               REWRITE CUSTOMER-RECORD.
           
           GO TO UPDATE-DATA-10.

       UPDATE-DATA-80.

           DISPLAY "Invalid key.".

       UPDATE-DATA-90.

           CLOSE CUSTOMERS.

       UPDATE-DATA-99.

           EXIT. 
