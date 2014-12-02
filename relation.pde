class Connection {
  Host _dest;
  Host _src;
  int _life;
  boolean _isfirst;

  Connection(Host dest, Host src, int life) {
    _dest = dest;
    _src = src;
    _life = life + 2;
    _isfirst = true;
  }

  void update() {
    _life -= 0.01;
  }

  void display() {
    if (_isfirst) {
      strokeWeight(10);
      stroke(_dest._color, 70);
      line(_src._location.x, _src._location.y, _dest._location.x, _dest._location.y);   
      _isfirst = false;
    }

    strokeWeight(min(_life, 4));
    stroke(_dest._color);
    line(_src._location.x, _src._location.y, _dest._location.x, _dest._location.y);
  }

  boolean isdead() {
    return _life <= 0;
  }
}

