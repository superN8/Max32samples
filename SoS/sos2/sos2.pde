const int LD1 =  70;     
const int LD2 =  71;     
const int LD3 =  72;
const int LD4 =  73;
const int LD5 =  74;
const int LD6 =  75;
const int LD7 =  76;
const int LD8 =  77;

int r = 0;
int d = 200;

void setup()
{
  pinMode(LD1, OUTPUT);
  pinMode(LD2, OUTPUT);
  pinMode(LD3, OUTPUT);
  pinMode(LD4, OUTPUT);
  pinMode(LD5, OUTPUT);
  pinMode(LD6, OUTPUT);
  pinMode(LD7, OUTPUT);
  pinMode(LD8, OUTPUT); 
}

void loop()
{
  r++;
  if(r > 6)
  {r = 1;}
  if(r > 3)
  {d = 600;}
  else
  {d = 200;}
  
  lightsOn();
  delay(d);
  lightsOff();
  delay(200);
  
  if(r%3 == 0)
  {delay(400);}  
}

void lightsOn()
{
  digitalWrite(LD1, HIGH);
  digitalWrite(LD2, HIGH);
  digitalWrite(LD3, HIGH);
  digitalWrite(LD4, HIGH);
  digitalWrite(LD5, HIGH);
  digitalWrite(LD6, HIGH);
  digitalWrite(LD7, HIGH);
  digitalWrite(LD8, HIGH);
}

void lightsOff()
{
  digitalWrite(LD1, LOW);
  digitalWrite(LD2, LOW);
  digitalWrite(LD3, LOW);
  digitalWrite(LD4, LOW);
  digitalWrite(LD5, LOW);
  digitalWrite(LD6, LOW);
  digitalWrite(LD7, LOW);
  digitalWrite(LD8, LOW);
}
