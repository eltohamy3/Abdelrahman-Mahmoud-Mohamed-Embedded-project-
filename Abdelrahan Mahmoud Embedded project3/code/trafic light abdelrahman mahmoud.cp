#line 1 "C:/Users/ROL/Desktop/Embedded projectes/Embedded project3 only one pin/code/trafic light abdelrahman mahmoud.c"
#line 21 "C:/Users/ROL/Desktop/Embedded projectes/Embedded project3 only one pin/code/trafic light abdelrahman mahmoud.c"
unsigned char tens[]= {0,0x10,0x20,0x30,0x40,0x50,0x60,0x70,0x80,0x90} ;
char automatic =1 ;
int i ;

unsigned char getval(int i )
{
 return (i %10 ) + tens[i/10] ;
}

void interrupt()
{
 if (intf_bit==1)
 {
 intf_bit =0 ;
 if (automatic ==1 )
 {
 automatic =0 ;
 }
 else if (automatic ==0)
 {
 automatic =1 ;
 }
 }
}


void main()
{


 adcon1=7 ;


 trisb=0b00000011; trisd=0; portd=0;
 trisc=0 ; portc =0 ;
 trise=0 ; porte=0;
  portb.B3 =0 ;  portb.B2 =0 ;  portb.B4 =0 ;
  porte.B0 =0 ; porte.B1  =0 ; porte.B2  =0;
 gie_bit=1 ; inte_bit=1; intedg_bit=1 ;

  portc.b2  =0 ; portc.b3  =0 ;
  portc.b0 =0 ; portc.b1 =0 ;

 automatic=1;
  portb.b5  =1 ;  portb.b6 =0 ;
 while (1)
 {


 while( automatic==1)
 {
  portb.b5  =1 ;  portb.b6 =0 ;

  portc.b0 =1 ; portc.b1 =1;
  portc.b2 =1 ;  portc.b3  =1 ;
  porte.B0  =0 ; porte.B2  =0;  porte.B1  =0 ;  portb.B2  =0 ; portb.B4  =0 ; portb.B3 =0 ;

  porte.B0  =1;  portb.B4  =0 ;  portb.B3  =1 ;
 for ( i =15; i>0 ;i--)
 {
 if (i==12)
 {
  portb.B3 =0;
  portb.B4 =1 ;
 }
 portd = getval(i) ;

 if (!automatic )
 break ;
 if (i>3)
 {
 delay_ms(800) ;
 }
 else
 {
  portb.B3 =1;delay_ms(100) ; portb.B3 =0;delay_ms(100) ; portb.B3 =1;delay_ms(100) ;
  portb.B3 =0;delay_ms(100) ; portb.B3 =1;delay_ms(100) ; portb.B3 =0;delay_ms(100) ;
  portb.B3 =1;delay_ms(100) ; portb.B3 =0;delay_ms(100) ;
 }
 if (!automatic )
 break ;
 }
 if (!automatic )
 break ;
  porte.B0 =0;  portb.B3  =0 ;
  portb.B4 =0 ;

  portb.B2 =1 ;
  porte.B2  =0;
  porte.B1  =1 ;
 for ( i =23 ;i>0 ;i--)
 {
 if (i==20)
 {
  porte.B1  =0 ;
  porte.B2 =1 ;
 }
 portd = getval(i) ;
 if (!automatic )
 break ;
 if (i>3)
 {
 delay_ms(800) ;
 }
 else
 {
  porte.B1 =1;delay_ms(100) ; porte.B1 =0;delay_ms(100) ; porte.B1 =1;delay_ms(100) ;
  porte.B1 =0;delay_ms(100) ; porte.B1 =1;delay_ms(100) ; porte.B1 =0;delay_ms(100) ;
  porte.B1 =1;delay_ms(100) ; porte.B1 =0;delay_ms(100) ;
 }
 if (!automatic )
 break ;
 }
  portb.B2 =0;  porte.B2  =0 ;
 if (!automatic )
 break ;


 }

 while( automatic==0)
 {
  portb.b5  =0 ;  portb.b6 =1 ;
 if (portb.b1==1)
 {
  porte.B0  =0 ; porte.B2  =0 ; portb.B2 =0 ; portb.B4 =0 ; porte.B1  =0;  portb.B3 =0;
  porte.B1  =1 ; portb.B2  =1 ;
 if (automatic)
 break ;
  portc.b2  =0 ; portc.b3  =0;  portc.b0  =1 ; portc.b1  =1 ;
 for ( i =3 ;i>0 ;i--)
 {
 portd= getval(i);
 if (automatic)
 break ;
 delay_ms(800) ;
 }
 if (automatic)
 break ;

  porte.B1  =0 ;
  porte.B2  =1;
  portc.b0 =0 ; portc.b1 =0 ;
 while(!automatic && portb.b1==1 ) ;

 if (automatic)
 break ;
 }
 if (automatic)
 break ;
 if (portb.b1==0)
 {
  porte.B0  =0 ; portb.B4  =0 ; portb.B2 =0 ; porte.B2 =0 ; portb.B3  =0;

  porte.B0 =1;  portb.B3  =1 ;
  portc.b2  =1 ; portc.b3  =1;  portc.b0  =0 ; portc.b1  =0 ;
 for ( i =3 ;i>0 ;i--)
 {
 portd = getval(i) ;
 if (automatic)
 break ;
 delay_ms(800) ;
 }
 if (automatic)
 break ;
  portb.B3  =0 ;
  portb.B4 =1 ;
  portc.b2  =0 ; portc.b3  =0 ;
 while(!automatic && portb.b1==0 ) ;
 if (automatic)
 break ;
 }
 if (automatic)
 break ;
 }

 }

}
