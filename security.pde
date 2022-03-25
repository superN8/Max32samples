#include <IOShieldOled.h>

const int clk = 13,
          LD1 = 70,
          LD2 = 71,
          LD3 = 72,
          LD4 = 73,
          LD5 = 74,
          LD6 = 75,
          LD7 = 76,
          LD8 = 77,
          SW1 = 2,
          SW2 = 7,
          SW3 = 8,
          SW4 = 79;
boolean c = true;          
void setup()
{
  for(int i = 0; i <= 7; i++)
  {
    pinMode((LD1+i), OUTPUT);
  }
  pinMode(SW1, INPUT);
  pinMode(SW2, INPUT);
  pinMode(SW3, INPUT);
  pinMode(SW4, INPUT);
  
  IOShieldOled.begin();
  //IOShieldOled.putString("running");
}
void loop()
{
  boolean arm = digitalRead(SW1),
          SW2b = digitalRead(SW2),
          SW3b = digitalRead(SW3),
          SW4b = digitalRead(SW4);
  
  digitalWrite(LD1, arm);
  digitalWrite(LD5, arm);
  if(arm)
  {
     digitalWrite(LD2, SW2b);
     digitalWrite(LD3, SW3b);
     digitalWrite(LD4, SW4b);
     digitalWrite(LD7, SW3b);
     digitalWrite(LD8, SW4b);
     
     IOShieldOled.setCursor(0,1);
     if(SW2b || SW3b || SW4b)
     {
       digitalWrite(LD6, HIGH);
       IOShieldOled.clear();
       IOShieldOled.putString("ALERT");
       
     }
     else
     {
       digitalWrite(LD6, LOW);
       IOShieldOled.putString("              ");
     }
     IOShieldOled.setCursor(0,0);
     IOShieldOled.putString("  Armed");
  }
  else
  {
    IOShieldOled.setCursor(0,0);
    IOShieldOled.putString("Unarmed");
    IOShieldOled.setCursor(0,1);
    IOShieldOled.putString("           ");
    for(int i = 0; i <= 7; i++)
    {
      digitalWrite((LD1+i), LOW);
    }
  }
  digitalWrite(clk, c);
  c=!c;
  delay(100);
  
}
         
