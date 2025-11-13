

declare function music(
  this: void,
  n?: number,
  fade_len?: number,
  channel_mask?: number
): void;
declare function sfx(
  this: void,
  n: number,
  channel?: number,
  offset?: number,
  length?: number
): void;
declare function camera(this: void): void;
declare function camera(this: void, x: number, y: number): void;
declare function circ(
  this: void,
  x: number,
  y: number,
  r: number,
  col?: number
): void;
declare function circfill(
  this: void,
  x: number,
  y: number,
  r: number,
  col?: number
): void;
declare function clip(this: void): void;
declare function clip(
  this: void,
  x: number,
  y: number,
  w: number,
  h: number,
  clip_previous?: boolean
): void;
declare function cls(this: void, col?: number): void;
declare function cursor(this: void, x: number, y: number): void;
declare function fget(this: void, n: number, f?: number): number;
declare function flip(this: void): void;
declare function fset(this: void, n: number, f: number, v?: boolean): void;
declare function line(this: void, x0: number, y0: number): void;
declare function line(
  this: void,
  x0: number,
  y0: number,
  x1: number,
  y1: number,
  col?: number
): void;
declare function pal(this: void, c0: Color, c1: Color, p?: number): void;
declare function palt(this: void, col: number, t: boolean): void;
declare function pget(this: void, x: number, y: number): number;
declare function print(this: void, str: string): void;
declare function print(
  this: void,
  str: string,
  x: number,
  y: number,
  col?: number
): void;
declare function pset(this: void, x: number, y: number): void;
declare function rect(
  this: void,
  x0: number,
  y0: number,
  x1: number,
  y1: number,
  col?: number
): void;
declare function rectfill(
  this: void,
  x0: number,
  y0: number,
  x1: number,
  y1: number,
  col?: number
): void;
declare function sget(this: void, x: number, y: number): number;
declare function spr(this: void, n: number, x: number, y: number): void;
declare function spr(
  this: void,
  n: number,
  x: number,
  y: number,
  w: number,
  h: number
): void;
declare function spr(
  this: void,
  n: number,
  x: number,
  y: number,
  w: number,
  h: number,
  flip_x: boolean,
  flip_y: boolean
): void;
declare function sset(this: void, x: number, y: number, col: number): void;
declare function sspr(
  this: void,
  sx: number,
  sy: number,
  sw: number,
  sh: number,
  dx: number,
  dy: number
): void;
declare function sspr(
  this: void,
  sx: number,
  sy: number,
  sw: number,
  sh: number,
  dx: number,
  dy: number,
  dw: number,
  dh: number,
  flip_x?: boolean,
  flip_y?: boolean
): void;
declare function fillp(this: void, mask: number): void;
declare function btn(this: void, this: void, i?: number, p?: number): boolean;
declare function btnp(this: void, i?: number, p?: number): boolean;
declare function map(
  this: void,
  cel_x: number,
  cel_y: number,
  sx: number,
  sy: number,
  cel_w: number,
  cel_h: number,
  layer?: number
): void;
declare function mapdraw(
  this: void,
  cel_x: number,
  cel_y: number,
  sx: number,
  sy: number,
  cel_w: number,
  cel_h: number,
  layer?: number
): void;
declare function mset(this: void, x: number, y: number, v?: number): void;
declare function add(this: void, t: any, v: any, index?: number): void;
declare function all(this: void, t: any): void;
declare function count(this: void, t: any, v?: any[]): number;
declare function del(this: void, t: any, v?: any): void;
declare function deli(this: void, t: any, i?: any[]): void;
declare function foreach(
  this: void,
  t: any,
  f: (this: void, item: any) => void
): void;
declare function abs(this: void, x: number): number;
declare function atan2(this: void, dx: number, dy: number): number;
declare function ceil(this: void, x: number): number;
declare function cos(this: void, x: number): number;
declare function flr(this: void, x: number): number;
declare function max(this: void, x: number, y: number): number;
declare function mid(this: void, x: number, y: number, z: number): number;
declare function min(this: void, x: number, y: number): number;
declare function rnd(this: void, x: number): number;
declare function sgn(this: void, x: number): number;
declare function sin(this: void, x: number): number;
declare function srand(this: void, x: number): number;
declare function sub(
  this: void,
  str: string,
  from: number,
  to?: number
): string;
declare function tostr(this: void, val: any, hex?: boolean): string;
declare function tonum(this: void, str: string): number;
declare function time(this: void): number;
declare function t(this: void): number;
declare function stat(this: void, x: number): void;
declare function printh(
  this: void,
  str: string,
  filename?: string,
  overwrite?: boolean,
  save_to_desktop?: boolean
): void;


// game.ts

 declare function _init(): void;
 declare function _update(): void;
 declare function _draw(): void;

// game-object/game-object-manager.ts

 declare class GameObjectManager extends GameObject {
	static instance: GameObjectManager;
	static init(debug?: boolean): void;
	constructor(debug?: boolean);
	push(this: this, gameObject: GameObject): void;
	findGameObject(predicate: (gameObject: GameObject) => boolean): GameObject | undefined;
	findGameObjects(predicate: (gameObject: GameObject) => boolean): GameObject[];
	findGameObjectsOfType<T extends GameObject>(instanceOf: T, predicate?: (gameObject: T) => boolean): Array<T>;
	getGameObject(id: GameObject["id"]): GameObject | undefined;
}

// player.ts

 declare class Player extends GameObject {
	rect: Rectangle;
	velocity;
	jumpForce: number;
	gravity: number;
	constructor(position: Vector2, size: Vector2);
	update(): void;
	draw(): void;
}

// utils/vector2.ts

 declare class Vector2 {
	x: number;
	y: number;
	static zero: Vector2;
	static up: Vector2;
	static down: Vector2;
	static left: Vector2;
	static right: Vector2;
	constructor(x: number, y: number);
	static square(x: number): Vector2;
	static fromTuple([x, y]: [number, number]): Vector2;
	static lerp(a: Vector2, b: Vector2, t: number): Vector2;
	static plus(a: Vector2, b: Vector2): Vector2;
	add(other: Vector2);
	static minus(a: Vector2, b: Vector2): Vector2;
	subtract(other: Vector2);
	static dividedBy(a: Vector2, factor: number): Vector2;
	divideBy(factor: number): void;
	static multipliedBy(a: Vector2, factor: number): Vector2;
	multiplyBy(factor: number): void;
	lerp(other: Vector2, t: number): void;
	magnitude(): number;
	normalized(): Vector2;
}

// game-object/game-object.ts

 interface GameObject {
	id: string;
	components: GameObject[];
	update?(): void;
	init?(): void;
	draw?(): void;
	updateDebug?(): void;
	initDebug?(): void;
	drawDebug?(): void;
}
 declare abstract class GameObject {
	layer: number;
	id: string;
	parent: GameObject | null;
	components: GameObject[];
	debug: boolean;
	_update(): void;
	_init(): void;
	_draw(): void;
	protected addComponent<T extends GameObject>(child: T): T;
	withDebugEnabled(enabled?: boolean): this;
}

// utils/rectangle.ts

 declare class Rectangle {
	position: Vector2;
	size: Vector2;
	color: Color;
	constructor({ position, size, color }: {
		position: Vector2;
		size: Vector2;
		color?: Color;
	});
	intersects(other: Rectangle): boolean;
	contains(point: Vector2): boolean;
	draw(mode?: "fill" | "outlined"): void;
}

// utils/lerp.ts

 declare function lerp(a: number, b: number, t: number): number;

// src/game-object/game-object.ts
class GameObject {
  layer = 0;
  id = `${rnd(1000)}`;
  parent = null;
  components = [];
  debug = false;
  _update() {
    this.update?.();
    if (this.debug) {
      this.updateDebug?.();
    }
    for (const child of this.components) {
      child._update();
    }
  }
  _init() {
    this.init?.();
    if (this.debug) {
      this.initDebug?.();
    }
    for (const child of this.components) {
      child._init();
    }
  }
  _draw() {
    this.draw?.();
    if (this.debug) {
      this.drawDebug?.();
    }
    for (const child of this.components) {
      child._draw();
    }
  }
  addComponent(child) {
    this.components.push(child);
    child.parent = this;
    return child;
  }
  withDebugEnabled(enabled = true) {
    this.debug = enabled;
    return this;
  }
}

// src/game-object/game-object-manager.ts
class GameObjectManager extends GameObject {
  static instance;
  static init(debug = false) {
    GameObjectManager.instance = new GameObjectManager(debug);
  }
  constructor(debug = false) {
    super();
    this.debug = debug;
  }
  push(gameObject) {
    this.addComponent(gameObject);
  }
  findGameObject(predicate) {
    return this.components.find((gameObject) => predicate(gameObject));
  }
  findGameObjects(predicate) {
    return this.components.filter((gameObject) => predicate(gameObject));
  }
  findGameObjectsOfType(instanceOf, predicate) {
    return this.components.filter((gameObject) => gameObject instanceof instanceOf.constructor && (predicate?.(gameObject) ?? true));
  }
  getGameObject(id) {
    return this.findGameObject((gameObject) => gameObject.id == id);
  }
}

// src/utils/rectangle.ts
class Rectangle {
  position;
  size;
  color;
  constructor({
    position,
    size,
    color = 7 /* white */
  }) {
    this.position = position;
    this.size = size;
    this.color = color;
  }
  intersects(other) {
    return this.position.x < other.position.x + other.size.x && this.position.x + this.size.x > other.position.x && this.position.y < other.position.y + other.size.y && this.position.y + this.size.y > other.position.y;
  }
  contains(point) {
    return point.x >= this.position.x && point.x <= this.position.x + this.size.x && point.y >= this.position.y && point.y <= this.position.y + this.size.y;
  }
  draw(mode = "fill") {
    if (mode == "fill") {
      rectfill(this.position.x, this.position.y, this.position.x + this.size.x, this.position.y + this.size.y, this.color);
    } else {
      rect(this.position.x, this.position.y, this.position.x + this.size.x, this.position.y + this.size.y, this.color);
    }
  }
}

// src/utils/lerp.ts
function lerp(a, b, t) {
  return a + (b - a) * t;
}

// src/utils/vector2.ts
class Vector2 {
  x;
  y;
  static zero = new Vector2(0, 0);
  static up = new Vector2(0, 1);
  static down = new Vector2(0, -1);
  static left = new Vector2(1, 0);
  static right = new Vector2(-1, 0);
  constructor(x, y) {
    this.x = x;
    this.y = y;
  }
  static square(x) {
    return new Vector2(x, x);
  }
  static fromTuple([x, y]) {
    return new Vector2(x, y);
  }
  static lerp(a, b, t) {
    return new Vector2(lerp(a.x, b.x, t), lerp(a.y, b.y, t));
  }
  static plus(a, b) {
    return new Vector2(a.x + b.x, a.y + b.y);
  }
  add(other) {
    this.x += other.x;
    this.y += other.y;
  }
  static minus(a, b) {
    return new Vector2(a.x - b.x, a.y - b.y);
  }
  subtract(other) {
    this.x -= other.x;
    this.y -= other.y;
  }
  static dividedBy(a, factor) {
    return new Vector2(a.x / factor, a.y / factor);
  }
  divideBy(factor) {
    this.x = this.x / factor;
    this.y = this.y / factor;
  }
  static multipliedBy(a, factor) {
    return new Vector2(a.x * factor, a.y * factor);
  }
  multiplyBy(factor) {
    this.x = this.x * factor;
    this.y = this.y * factor;
  }
  lerp(other, t) {
    this.x = lerp(this.x, other.x, t);
    this.y = lerp(this.y, other.y, t);
  }
  magnitude() {
    return Math.sqrt(this.x * this.x + this.y * this.y);
  }
  normalized() {
    const mag = this.magnitude();
    return new Vector2(this.x / mag, this.y / mag);
  }
}

// src/player.ts
class Player extends GameObject {
  rect;
  velocity = Vector2.zero;
  jumpForce = 10;
  gravity = 1;
  constructor(position, size) {
    super();
    this.rect = new Rectangle({
      position,
      size,
      color: 12 /* blue */
    });
  }
  update() {
    this.velocity.subtract(Vector2.multipliedBy(Vector2.down, this.gravity));
    if (btnp(4 /* O */)) {
      this.rect.color = 8 /* red */;
      this.velocity.y = -this.jumpForce;
    } else {
      this.rect.color = 12 /* blue */;
    }
    this.rect.position.add(this.velocity);
  }
  draw() {
    this.rect.draw();
  }
}

// src/game.ts
var player = new Player(new Vector2(10, 10), new Vector2(10, 10));
function _init() {
  GameObjectManager.init();
  GameObjectManager.instance.push(player);
}
function _update() {
  GameObjectManager.instance._update();
}
function _draw() {
  cls();
  GameObjectManager.instance._draw();
}
 {
  _update,
  _init,
  _draw
};

    