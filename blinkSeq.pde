const int LD1 =  70;     
const int LD2 =  71;     
const int LD3 =  72;
const int LD4 =  73;
const int LD5 =  74;
const int LD6 =  75;
const int LD7 =  76;
const int LD8 =  77;
const int clk =  13;

int r = 0; //rotation
//int f = 1; //flip flop
boolean b = true;

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
  pinMode(clk, OUTPUT); 
}

void loop()
{
  if (b)
  {
    digitalWrite((LD1 + r), HIGH);
    r++;
  }
  else
  {
    digitalWrite((LD1 + r), LOW);
    r--;
  }
  if (r == 8)
  {
    b = false;
  }
  if (r == -1)
  {
    b = true;
  }
  delay(500);
  digitalWrite(clk, HIGH);
  delay(500);
  digitalWrite(clk, LOW);
  
}
