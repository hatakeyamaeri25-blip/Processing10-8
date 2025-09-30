ArrayList<Firework> fireworks = new ArrayList<>();

void setup(){
  size(800,600);
}

void draw(){
  background(43,22,60);//デフォルト114,255,133
  
  if (mousePressed){
    //background(114,255,133);//動作確認
    for (int i = 0; i < 5 ; i++){
   fireworks.add(new Firework());
    }
  }
  
  ArrayList<Firework> liveFireworks = new ArrayList<>();
  for (Firework firework : fireworks){
    firework.update();
    firework.show();
    if (firework.isAlive()){
      liveFireworks.add(firework);
    }
  }
  fireworks = liveFireworks;
}

//ひとつの火花をあらわすクラス
class Spark{
  //現在位置
  PVector position;
  
  //ランダムな方向をもつベクトル
  PVector move;
  
  //ライフポイント
  float life = random(50,255);
  
  //火花の色
  color col = color(128,random(107,255),186);
  
  //コンストラクタ
  //@param position 開始位置
  //
  Spark(PVector position){
    this.position = position.copy();
    move = PVector.random2D();
    move.mult(random(5,25));
  }
  //円を描画
  void show(){
    fill(col,life);
    noStroke();
    circle(position.x, position.y, 3);
  }
  
  //位置を更新
  void update(){
    position.add(move);
    move.mult(0.95);
    life -= random(0,5);
  }
  
  //まだ生存しているかどうか
  boolean isAlive(){
    return 0 <= life;
  }
}

//ひとつの花火をあらわすクラス
class Firework{
  
  //管理対象の花火
  ArrayList<Spark> sparks = new ArrayList<>();
 
 //コンストラクタ
 Firework(){
   PVector position = new PVector(random(width),random(height));
   for (int i = 0; i < 400; i++){
     sparks.add(new Spark(position));
   }
 }
 
 //すべての火花を描画
 void show(){
   for (Spark s : sparks){
     s.show();
   }
 }
 
 //すべての火花の位置を更新
 void update(){
   ArrayList<Spark> liveSparks = new ArrayList<>();
   for (Spark s : sparks){
     s.update();
     if (s.isAlive()){
       liveSparks.add(s);
     }
   }
   sparks = liveSparks;
 }
 
 //すべての火花が生存中かどうか
 boolean isAlive(){
   return !sparks.isEmpty();
 }
}
