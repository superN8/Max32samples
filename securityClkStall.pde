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
boolean c = true,
        arm = false;
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
  
  arm = digitalRead(SW1);
  
  IOShieldOled.begin();
}
void loop()
{
  cycleClock();
  if(arm != digitalRead(SW1) && digitalRead(SW1) == true)
  {
    digitalWrite(LD1, digitalRead(SW1));
    IOShieldOled.setCursor(0,0);
    IOShieldOled.putString("Arming ");
    const int seconds = 5;
    //delay(seconds * 1000);
    
    for(int i = 0; i < (seconds * 10); i++)
    {
       //cycleClock();
       
       //digitalWrite(clk, (i % 2));
       
       delay(100);       
    }
    /*
    int w = 0;
    
    while(w < (seconds * 10))
    {
      //cycleClock();
      //digitalWrite(clk, (w % 2));
      //digitalWrite(clk, c);
      //c=!c;
      delay(100);
      w++;
    }
    */
  }
  arm = digitalRead(SW1);
  boolean SW2b = digitalRead(SW2),
          SW3b = digitalRead(SW3),
          SW4b = digitalRead(SW4);
  
  digitalWrite(LD1, arm); //LD1 = Arm indicator
  digitalWrite(LD5, arm); //LD5 = System Armed
  if(arm)
  {
     digitalWrite(LD2, SW2b); //LD2 = Entrance indicator
     digitalWrite(LD3, SW3b); //LD3 = Heat indicator
     digitalWrite(LD4, SW4b); //LD4 = Restrict Indication
     digitalWrite(LD7, SW3b); //LD7 = Sprinkler = heat
     digitalWrite(LD8, SW4b); //LD8 = Laser = restrict
     
     if(SW2b || SW3b || SW4b)
     {
       digitalWrite(LD6, HIGH); //LD6 = Alarm
       
       IOShieldOled.setCursor(0,1);
       if(SW2b) IOShieldOled.putString("please"); //entrance
       else     IOShieldOled.putString("        ");
       
       IOShieldOled.setCursor(0,2);
       if(SW3b)IOShieldOled.putString("kill"); //heat
       else    IOShieldOled.putString("    ");       
       
       IOShieldOled.setCursor(0,3);
       if(SW4b) IOShieldOled.putString("me"); //restrict
       else     IOShieldOled.putString("        ");
     }
     
     else
     {
       digitalWrite(LD6, LOW);
       clearScreen();
     }
     IOShieldOled.setCursor(0,0);
     IOShieldOled.putString("Armed ");
  }
  else
  {
    IOShieldOled.setCursor(0,0);
    IOShieldOled.putString("Unarmed");
    clearScreen();
    for(int i = 0; i <= 7; i++)
    {
      digitalWrite((LD1+i), LOW);
    }
  }
  //cycleClock();
}

void clearScreen()
{
  IOShieldOled.setCursor(0,1);
  IOShieldOled.putString("                ");
  IOShieldOled.setCursor(0,2);
  IOShieldOled.putString("                ");
  IOShieldOled.setCursor(0,3);
  IOShieldOled.putString("                ");
}

void cycleClock()
{
  digitalWrite(clk, c);
  c=!c;
  delay(100);
}
