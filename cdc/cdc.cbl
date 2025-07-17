IDENTIFICATION DIVISION.
       PROGRAM-ID. MERGE-CSV.
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
           SELECT INPUT-FILE ASSIGN TO "cdc.csv"
               ORGANIZATION IS LINE SEQUENTIAL.
           SELECT OUTPUT-FILE ASSIGN TO "output.csv"
               ORGANIZATION IS LINE SEQUENTIAL.

       DATA DIVISION.
       FILE SECTION.
       FD  INPUT-FILE.
       01  INPUT-RECORD.
           05  NAME            PIC X(30).
           05  ADDR            PIC X(30).
           05  CITY            PIC X(20).
           05  STATE           PIC X(2).
           05  ZIP             PIC X(5).
           05  CATEGORY        PIC X(20).
           05  PHONE           PIC X(12).
           05  EMAIL           PIC X(30).

       FD  OUTPUT-FILE.
       01  OUTPUT-RECORD.
           05  OUT-NAME        PIC X(30).
           05  FULL-ADDRESS    PIC X(70).
           05  OUT-CATEGORY    PIC X(20).
           05  OUT-PHONE       PIC X(12).
           05  OUT-EMAIL       PIC X(30).

       WORKING-STORAGE SECTION.
       01  WS-END-OF-FILE      PIC X VALUE 'N'.

       PROCEDURE DIVISION.
       MAIN-PROCEDURE.
           OPEN INPUT INPUT-FILE
           OPEN OUTPUT OUTPUT-FILE
           PERFORM UNTIL WS-END-OF-FILE = 'Y'
               READ INPUT-FILE INTO INPUT-RECORD
                   AT END MOVE 'Y' TO WS-END-OF-FILE
                   NOT AT END
                       MOVE NAME TO OUT-NAME
                       MOVE SPACES TO OUTPUT-RECORD
                       STRING ADDR ", " CITY ", " STATE " " ZIP
                              INTO FULL-ADDRESS
                       MOVE CATEGORY TO OUT-CATEGORY
                       MOVE PHONE TO OUT-PHONE
                       MOVE EMAIL TO OUT-EMAIL
                       STRING OUT-NAME "," FULL-ADDRESS "," OUT-CATEGORY ","
                              OUT-PHONE "," OUT-EMAIL
                              DELIMITED BY SIZE
                              INTO OUTPUT-RECORD
                       WRITE OUTPUT-RECORD
               END-READ
           END-PERFORM
           CLOSE INPUT-FILE
           CLOSE OUTPUT-FILE
           STOP RUN.