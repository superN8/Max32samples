#include <IOShieldOled.h>
const int clk = 13,
          LD1 = 70,
          LD2 = 71,
          LD3 = 72,
          LD4 = 73,
          LD5 = 74,
          LD6 = 75,
          LD7 = 76,
          LD8 = 77;
int cycleLED=0; 
boolean b = true;
void setup()
{
  for(int i = 0; i < 8; i++)
  {
    pinMode((LD1+i), OUTPUT);
  }
      digitalWrite(LD1,HIGH);
      digitalWrite(LD2,HIGH);
      digitalWrite(LD3,HIGH);
      digitalWrite(LD4,HIGH);
      digitalWrite(LD5,HIGH);
      digitalWrite(LD6,HIGH);
      digitalWrite(LD7,HIGH);
      digitalWrite(LD8,HIGH);
  IOShieldOled.begin();
}

void loop()
{
  
  switch(cycleLED)
  {
    case 0:
    {
      digitalWrite(LD8,HIGH);
      digitalWrite(LD1,HIGH);
      digitalWrite(LD4,LOW);
      digitalWrite(LD5,LOW);
      break;
    }
    case 1:
    {
      digitalWrite(LD4,HIGH);
      digitalWrite(LD5,HIGH);
      digitalWrite(LD3,LOW);
      digitalWrite(LD6,LOW);
      break;
    }
    case 2:
    {
      digitalWrite(LD3,HIGH);
      digitalWrite(LD6,HIGH);
      digitalWrite(LD2,LOW);
      digitalWrite(LD7,LOW);
      break;
    }
    case 3:
    {
      digitalWrite(LD2,HIGH);
      digitalWrite(LD7,HIGH);
      digitalWrite(LD1,LOW);
      digitalWrite(LD8,LOW);
      break;
    }
    
  }
  cycleLED++;
  cycleLED &= 3;
  
  cycleClock();
}
void cycleClock()
{
	digitalWrite(clk, b);
	b=!b;
	delay(150);
}
