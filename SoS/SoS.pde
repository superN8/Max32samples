#include <IOShieldOled.h>

const int clk =  13;
const int LD1 =  70;     
const int LD2 =  71;     
const int LD3 =  72;
const int LD4 =  73;
const int LD5 =  74;
const int LD6 =  75;
const int LD7 =  76;
const int LD8 =  77;

int cycle = 0;
//int d = 200;

void setup()
{
  pinMode(clk, OUTPUT);  
  pinMode(LD1, OUTPUT);
  pinMode(LD2, OUTPUT);
  pinMode(LD3, OUTPUT);
  pinMode(LD4, OUTPUT);
  pinMode(LD5, OUTPUT);
  pinMode(LD6, OUTPUT);
  pinMode(LD7, OUTPUT);
  pinMode(LD8, OUTPUT);
  
  IOShieldOled.begin();  
}

void loop()
{
  //displayGoods();
  /*
  cycle++;
  if (cycle = 7)
  {
    cycle = 1;
  }
  if (cycle > 3)
  {
   d=200;
  }
  else
  {
    d=600;
  }
  */
  lightsOn(200);
  lightsOn(200);
  lightsOn(200);
  delay(400);
  lightsOn(600);
  lightsOn(600);
  lightsOn(600);
  delay(400);    
}

void lightsOn(int d)
{
  digitalWrite(LD1, HIGH);
  digitalWrite(LD2, HIGH);
  digitalWrite(LD3, HIGH);
  digitalWrite(LD4, HIGH);
  digitalWrite(LD5, HIGH);
  digitalWrite(LD6, HIGH);
  digitalWrite(LD7, HIGH);
  digitalWrite(LD8, HIGH);
  
  delay(d);
  lightsOff(200);
} 

void lightsOff(int d)
{ 
  digitalWrite(LD1, LOW);
  digitalWrite(LD2, LOW);
  digitalWrite(LD3, LOW);
  digitalWrite(LD4, LOW);
  digitalWrite(LD5, LOW);
  digitalWrite(LD6, LOW);
  digitalWrite(LD7, LOW);
  digitalWrite(LD8, LOW); 
  delay(d);
}

void displayGoods()
{
  String s = String(cycle);
  IOShieldOled.setCursor(0,0);
  IOShieldOled.putChar(s.charAt(0));
  /*
  String s2 = String (d);
  IOShieldOled.setCursor(0,1);
  for(int i = 0; i < s2.length(); i++)
  {
    IOShieldOled.putChar(s2.charAt(i));
  }
  */
}
  
    
    

