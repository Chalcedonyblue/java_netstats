
HashMap<Object, Host> hosts;
ArrayList<Connection> connections;
Host localhost;

int countdown = 0;
void update() {
  if (--countdown > 0) {
    return;
  }
  countdown = 20;
  JSONObject json = loadJSONObject("http://localhost:4567");
  for (Object key : json.keys ()) {
    Host h = null;
    if (hosts.containsKey(key)) {
      h = hosts.get(key);
    }

    if (h == null) {
      h = new Host((String)key);
      hosts.put(key, h);
    }

    int count = json.getInt((String)key);
    connections.add(new Connection(localhost, h, count));
  }
}

// overwrite original function.
void background() {
  fill(255, 60);
  stroke(180, 50);
  rect(width/2, height/2, width, height);
  for (int i = 10; i< width; i+=20) {
    line(i, 0, i, height);
  }

  for (int j =10; j< height; j+=20) {
    line(0, j, width, j);
  }
}

void forground() {
  fill(0);
  textAlign(RIGHT);
  text("NETSTAT VISUALIZER v1.0 ", width, 15);
  fill(100);
  text("it works! ", width, 30);
}

void setup() {
  size(400, 400);
  frameRate(15);
  rectMode(CENTER);
  localhost = new LocalHost("127.0.0.1");
  hosts = new HashMap<Object, Host>();
  connections = new ArrayList<Connection>();
}

void draw() {
  update();

  // == background layer ==
  background();

  // == contents ==
  
  localhost.update();
  localhost.display();

  for (Object key : hosts.keySet ()) {
    Host h = hosts.get(key);
    h.update();
    h.display();
  }

  for (int i = connections.size () -1; i >= 0; i--) {
    Connection c = connections.get(i);
    c.update();
    if (c.isdead()) {
      connections.remove(i);
      continue;
    }
    c.display();
  }

  // == forground layer ==
  forground();
}

