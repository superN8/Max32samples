#include <IOShieldOled.h>

const int SW1 = 2,
          SW2 = 7,
          SW3 = 8,
          SW4 = 79, 
          LD1 = 70,
          LD2 = 71,
          LD3 = 72,
          LD4 = 73,
          LD5 = 74,
          LD6 = 75,
          LD7 = 76,
          LD8 = 77,
          CLK = 13;
int state = -1;          
         


void setup()
{
  

	pinMode(CLK, OUTPUT); 
	pinMode(LD1, OUTPUT); 
	pinMode(LD2, OUTPUT); 
	pinMode(LD3, OUTPUT); 
	pinMode(LD4, OUTPUT);     
	pinMode(LD5, OUTPUT);  
	pinMode(LD6, OUTPUT);  
	pinMode(LD7, OUTPUT);  
	pinMode(LD8, OUTPUT);  

	pinMode(SW1, INPUT);
	pinMode(SW2, INPUT);
	pinMode(SW3, INPUT);
	pinMode(SW4, INPUT);   

	digitalWrite(LD1, LOW); 
	digitalWrite(LD2, LOW); 
	digitalWrite(LD3, LOW); 
	digitalWrite(LD4, LOW); 
	digitalWrite(LD5, LOW); 
	digitalWrite(LD6, LOW); 
	digitalWrite(LD7, LOW); 
	digitalWrite(LD8, LOW); 

	IOShieldOled.begin();
	IOShieldOled.displayOn(); 
	IOShieldOled.setCursor(0,0);
        IOShieldOled.putString("Mars Lander");

}
void loop()
{
  digitalWrite(LD1, digitalRead(SW1));
  digitalWrite(LD2, digitalRead(SW2));
  digitalWrite(LD3, digitalRead(SW3));
  digitalWrite(LD4, digitalRead(SW4));
  
  
    
  switch(state)
  {
    case -1:
      if(digitalRead(SW2) == 0)
      {
        IOShieldOled.setCursor(0,1);
        IOShieldOled.putString("Fuel me up");
      }
      else
      {
        IOShieldOled.setCursor(0,1);
        IOShieldOled.putString("State:    ");
        state = 0;
      }
    break;
    case 0:
      digitalWrite(LD5, 0);
      digitalWrite(LD6, 0);
      digitalWrite(LD7, 0);
      digitalWrite(LD8, 0);
      
      IOShieldOled.setCursor(8,1);
      IOShieldOled.putString("0");
      
      if(digitalRead(SW1) == 1)
      {
        state = 1;
      }           
    break;
    
    case 1:
      digitalWrite(LD5, 1);
      digitalWrite(LD6, 0);
      digitalWrite(LD7, 0);
      digitalWrite(LD8, 0);
      
      
      IOShieldOled.setCursor(8,1);
      IOShieldOled.putString("1");
      
      if(digitalRead(SW2) == 0)
      {
        state = 2;
      }      
    break;
    
    case 2:
      digitalWrite(LD5, 0);
      digitalWrite(LD6, 1);
      digitalWrite(LD7, 1);
      digitalWrite(LD8, 0);
      
      
      IOShieldOled.setCursor(8,1);
      IOShieldOled.putString("2");
      
      if(digitalRead(SW3) == 1)
      {
        state = 3;
      }
    break;
     
    case 3:
      digitalWrite(LD5, 0);
      digitalWrite(LD6, 0);
      digitalWrite(LD7, 0);
      digitalWrite(LD8, 1);
      
      
      IOShieldOled.setCursor(8,1);
      IOShieldOled.putString("3");
      
      if(digitalRead(SW4) == 1)
      {
        state = 4;
      }
    break;
     
    case 4:
      digitalWrite(LD5, 0);
      digitalWrite(LD6, 0);
      digitalWrite(LD7, 0);
      digitalWrite(LD8, 0);
      
      
      IOShieldOled.setCursor(8,1);
      IOShieldOled.putString("4");
     break;
  }
}
