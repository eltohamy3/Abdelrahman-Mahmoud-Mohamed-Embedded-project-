
           // west trafic
#define red  porte.B0
#define yellow porte.B1
#define green  porte.B2
        //  south trafic
#define red2 portb.B2
#define yellow2 portb.B3
#define green2 portb.B4

#define ones1 portc.b0  // west
#define tens1 portc.b1  // west

#define ones2 portc.b2  // south
#define tens2 portc.b3  // south

#define automatic_led portb.b5
#define manual_led portb.b6

       /********** variable used ************/
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
            automatic =0 ; // go to manual moood
        }
        else if (automatic ==0)
        {
            automatic =1 ; // go to automatic mood
        }
    }
}


void main()
{
    // west    portc 1
     // south portd 2
    adcon1=7 ; // make porta and porte digital
    //trisa=0; porta=1;

    trisb=0b00000011;  trisd=0; portd=0;
    trisc=0 ; portc =0 ;
    trise=0 ; porte=0;
    yellow2=0 ; red2=0 ; green2=0 ;
    red=0 ;yellow =0 ;green =0;
    gie_bit=1 ; inte_bit=1;  intedg_bit=1 ;           // for interrupt

    ones2 =0 ;tens2 =0 ;
    ones1=0 ;tens1=0 ;

    automatic=1;
    automatic_led =1  ; manual_led=0 ;
    while (1)
    {

        //Automatic_Mood :
        while( automatic==1)
        {
            automatic_led =1  ; manual_led=0 ;

            ones1=1 ;tens1=1; //west digit
            ones2=1 ; tens2 =1 ; // south digit
            red =0 ;green =0; yellow =0 ;  red2 =0 ;green2 =0 ;yellow2=0 ; // intial all off

            red =1; green2 =0 ; yellow2 =1 ;// first south is green
            for ( i =15; i>0 ;i--)
            {
                if (i==12)
                {
                    yellow2=0;
                    green2=1 ;
                }
                portd = getval(i) ;

                if (!automatic )
                break ;
                if (i>3)
                {
                    delay_ms(800) ; // dont make the delay in 0
                }
                else
                {
                    yellow2=1;delay_ms(100) ;yellow2=0;delay_ms(100) ;yellow2=1;delay_ms(100) ;
                    yellow2=0;delay_ms(100) ;yellow2=1;delay_ms(100) ;yellow2=0;delay_ms(100) ;
                    yellow2=1;delay_ms(100) ;yellow2=0;delay_ms(100) ;
                }
                if (!automatic )
                break ;
            }
            if (!automatic )
                break ;
            red=0; yellow2 =0 ;
            green2=0 ;

            red2=1 ;
            green =0;
            yellow =1 ;
            for ( i =23 ;i>0 ;i--)
            {
                if (i==20)
                {
                   yellow =0 ;
                   green=1 ;
                }
                portd = getval(i) ;
                if (!automatic )
                break ;
                if (i>3)
                {
                    delay_ms(800) ; // dont make the delay in 0
                }
                else
                {
                    yellow=1;delay_ms(100) ;yellow=0;delay_ms(100) ;yellow=1;delay_ms(100) ;
                    yellow=0;delay_ms(100) ;yellow=1;delay_ms(100) ;yellow=0;delay_ms(100) ;
                    yellow=1;delay_ms(100) ;yellow=0;delay_ms(100) ;
                }
                if (!automatic )
                break ;
            }
            red2=0;  green =0 ;
            if (!automatic )
                break ;


         }
        //  Manual_mood :
        while( automatic==0)
        {
         automatic_led =0 ; manual_led=1 ;
            if (portb.b1==1)    // west on
            {
                red =0  ;green =0 ;red2=0 ;green2=0  ;yellow =0;  yellow2=0;
                yellow =1   ;red2 =1 ;
                if (automatic)
                     break ;
                ones2 =0 ;tens2 =0; ones1 =1 ;tens1 =1 ; // on all 7 segment
                for ( i =3 ;i>0 ;i--)
                {
                    portd= getval(i);
                    if (automatic)
                       break ;
                    delay_ms(800) ;
                }
                if (automatic)
                     break ;

                yellow =0 ;
                green =1;
                ones1=0 ;tens1=0 ; // off all 7 segment
                while(!automatic &&  portb.b1==1 )   ;

                if (automatic)
                     break ;
            }
            if (automatic)
                     break ;
            if (portb.b1==0)    // south on
            {
                red =0  ;green2 =0 ;red2=0 ;green=0  ;yellow2 =0;

                red=1;   yellow2 =1     ;
                ones2 =1 ;tens2 =1; ones1 =0 ;tens1 =0 ;  // on all 7 segment
                for ( i =3 ;i>0 ;i--)
                {
                    portd = getval(i) ;
                    if (automatic)
                        break ;
                    delay_ms(800) ;
                }
                if (automatic)
                     break ;
                yellow2 =0 ;
                green2=1 ;
                ones2 =0 ;tens2 =0 ; // of all 7 segment
                while(!automatic &&  portb.b1==0 )    ;
                if (automatic)
                    break ;
            }
            if (automatic)
                break ;
        }

    }

}