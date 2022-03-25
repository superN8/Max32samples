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
int state = 0;  

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

  IOShieldOled.begin();
  IOShieldOled.displayOn(); 
  IOShieldOled.setCursor(0,0);
  IOShieldOled.putString("Beer Machine");  
  IOShieldOled.setCursor(0,1);
  IOShieldOled.putString("Nathan");
  IOShieldOled.setCursor(0,2);
  IOShieldOled.putString("Jonathan");
  IOShieldOled.setCursor(0,3);
  IOShieldOled.putString("Austin");
  //IOShieldOled.putString("State:");
}

void loop()
{ 
  digitalWrite(LD1, digitalRead(SW1));
  digitalWrite(LD2, digitalRead(SW2));
  digitalWrite(LD3, digitalRead(SW3));
  digitalWrite(LD4, digitalRead(SW4));  
  
  //IOShieldOled.setCursor(7,1);
  
  switch(state)
  {
    case 0:
     //IOShieldOled.putChar('0');
      digitalWrite(LD5, LOW); 
      digitalWrite(LD6, LOW); 
      digitalWrite(LD7, LOW); 
      digitalWrite(LD8, LOW); 
      if(digitalRead(SW1) == HIGH)
        state = 1;
    break;
     
    case 1:
      //IOShieldOled.putChar('1');
      digitalWrite(LD6, HIGH);
      if(digitalRead(SW4) == HIGH)
        state = 2;
    break;
     
    case 2:
      //IOShieldOled.putChar('2'); 
      digitalWrite(LD6, LOW);
      digitalWrite(LD7, HIGH);
      if(digitalRead(SW3) == HIGH)
        state = 3;
    break;
     
    case 3:
      //IOShieldOled.putChar('3');
      digitalWrite(LD7, LOW);
      delay(7000);
      state = 4;
    break;
     
    case 4:
      //IOShieldOled.putChar('4');
      digitalWrite(LD8, HIGH);
      if(digitalRead(SW3) == LOW)
        state = 5;
    break;
     
    case 5:
      //IOShieldOled.putChar('5');
      digitalWrite(LD5, HIGH);
      digitalWrite(LD8, LOW);
      if(digitalRead(SW4) == LOW)
        state = 0;
    break;
  }  
}
