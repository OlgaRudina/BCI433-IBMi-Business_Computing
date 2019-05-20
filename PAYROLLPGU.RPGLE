000001190329                                                                                                    
000002190329     FTOTALPYU  CF   E             WORKSTN                                                          
000003190329      /FREE                                                                                         
000004190329        DCL-F PAYRPTU   PRINTER OFLIND(*IN01);                                                      
000109190329        DCL-F SHIFTRATES DISK(*EXT) USAGE(*INPUT) RENAME(SHIFTRATES:SHIFT);                         
000110190329        DCL-F WORKWEEK1  DISK(*EXT) USAGE(*INPUT) RENAME(WORKWEEK1:WK1);                            
000112190329                                                                                                    
000113190322        DCL-F EMPLOYEE DISK(*EXT) KEYED USAGE(*UPDATE : *OUTPUT : *DELETE)                          
000114190322          RENAME(EMPLOYEE:EMP);                                                                     
000115190329        DCL-PI MAIN EXTPGM('PAYROLLPGU');                                                           
000116190329          UNIONDUES BinDec(5:2);                                                                    
000117190329        END-PI;                                                                                     
000118190329                                                                                                    
000128190329        DCL-DS KEY;                                                                                 
000129190329          EMPKEY LIKEREC(EMPLOYEE: *KEY);                                                           
000130190329        END-DS KEY;                                                                                 
000131190329                                                                                                    
000132190329        DCL-DS WORKWEEKDS;                                                                          
000133190329         WORKSHIFT;                                                                                 
000134190329         HRSWORKED;                                                                                 
000135190329         EMPNUM;                                                                                    
000136190329                                                                                                    
000137190329        END-DS WORKWEEKDS;                                                                          
000138190329                                                                                                    
000139190329       DCL-DS EMPLOYEEDS;                                                                           
000140190329         PAYGRADE;                                                                                  
000141190329         FIRSTNAME;                                                                                 
000142190329         LASTNAME;                                                                                  
000143190329         PHONE;                                                                                     
000144190329         CITY;                                                                                      
000145190329         ADDRESS;                                                                                   
000146190329         UNIONDUES;                                                                                 
000147190329         YTDPAY;                                                                                    
000148190329         YTDTAX;                                                                                    
000149190329         EMPNUM;                                                                                    
000150190329                                                                                                    
000151190329       END-DS EMPLOYEEDS;                                                                           
000152190329           KEY = EMPNUM;                                                                            
000153190329           CHAIN %KDS(KEY) EMPLOYEE;                                                                
000154190329                                                                                                    
000155190306       WRITE TITLE;                                                                                 
000156190329       WRITE COLHDG;                                                                                
000157190329                                                                                                    
000158190329       READ SHIFTRATES;                                                                             
000159190329                                                                                                    
000160190329       READ WORKWEEK1;                                                                              
000161190329       DOW NOT %EOF;                                                                                
000162190329                                                                                                    
000163190329           WRITE EMPDETAIL;                                                                         
000164190329           READ WORKWEEK1;                                                                          
000165190329       ENDDO;                                                                                       
000166190329                                                                                                    
000167190329       EXFMT TOTALS;                                                                                
000168190306                                                                                                    
000169190306       *INLR = *ON;                                                                                 
000170190306       RETURN;                                                                                      
000171190329                                                                                                    
000172190329                                                                                                    
000182190329                                                                                                    
