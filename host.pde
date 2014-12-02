class FloatingItem {
  PVector _location;
  PVector _velocity;
  float _color;

  float _noise_count;
  FloatingItem() {
    _location = new PVector(random(width-50) + 25, random(height - 50) + 25);
    _velocity = new PVector(0.0, 0.0);
    _noise_count = random(10000);
    _color = int(random(150))+50;
  }

  void update() {
    _velocity.y = noise(_noise_count)-0.5;
    _location.add(_velocity);
    _noise_count += 0.01;
  }
}

class Host extends FloatingItem {
  String _name;

  Host(String name) {
    super();
    _name = name; 
  }

  void update() {
    super.update();
  }

  void display() {
    fill(_color);
    strokeWeight(1);
    rect(_location.x, _location.y, 10, 10);
    textSize(10);

    textAlign(LEFT);
    String text = String.format("[%s] ", _name);
    text(text, _location.x - 10, _location.y - 10);
  }
}


class LocalHost extends Host {
  LocalHost(String name) {
    super(name);
    _location = new PVector(width/2, height/2);
  }

  void display() {
    fill(_color);
    strokeWeight(2);
    stroke(100);    
    ellipse(_location.x, _location.y, 40, 40);
    textSize(20);
    textAlign(CENTER);
    fill(0);

    text("- localhost - ", _location.x, _location.y - 20);
  }
}

