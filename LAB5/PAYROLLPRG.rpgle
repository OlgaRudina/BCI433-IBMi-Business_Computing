     FSHIFTRATESIF   E             DISK    RENAME(SHIFTRATES:SHIFTRATER)
     FALLSHIFT  IF   E           K DISK    RENAME(ALLSHIFT:ALLSHIFTR)
     FPAYROLLDSPCF   E             WORKSTN
     FPAYRPT    O    E             PRINTER OFLIND(*IN01)
     DHOURSOVER        S              3  0

        READ SHIFTRATES;
        WRITE TITLE;
        WRITE COLHDG;
        READ ALLSHIFT;
        DOW NOT %EOF;
        EXSR PaySr;
        IF *IN01;
            WRITE TITLE;
            WRITE COLHDG;
            *IN01 = *OFF;
        ENDIF;
        WRITE EMPDETAIL;
        READ ALLSHIFT;
        ENDDO;

        TOTWKPAY = TOTREGPAY + TOTOVTPAY;
        WRITE TOTALS;
        EXFMT RECORD1;



       *INLR = *ON;
       RETURN;

       BEGSR PaySr;
       SELECT;
       WHEN WORKSHIFT = 'D';
           HOURLYRATE = DAYRATE;
       WHEN WORKSHIFT = 'N';
           HOURLYRATE = NIGHTRATE;
       WHEN WORKSHIFT = 'A';
           HOURLYRATE = AFTNRATE;

       ENDSL;

         SELECT;
          WHEN PAYGRADE = '1';
             EVAL(H) HOURLYRATE *= 1.072;
          WHEN PAYGRADE = '2';
             EVAL(H) HOURLYRATE *= 1.056;
          WHEN PAYGRADE = '3';
            EVAL(H) HOURLYRATE *= .966;
         ENDSL;
         HOURSOVER = HRSWORKED - 40;
         SELECT;
         WHEN (HOURSOVER > 0);
            REGULARPAY = 40 * HOURLYRATE;
            EVAL(H) OVERPAY = HOURSOVER * HOURLYRATE * 1.5;
            TOTREGPAY += REGULARPAY;
            TOTOVTPAY += OVERPAY;
         OTHER;
            REGULARPAY = HRSWORKED * HOURLYRATE;
            OVERPAY = 0;
            TOTREGPAY += REGULARPAY;
         ENDSL;
         WEEKLYPAY = REGULARPAY + OVERPAY;
       ENDSR;
 