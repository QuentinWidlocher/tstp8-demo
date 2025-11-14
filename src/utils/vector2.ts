import { lerp } from "./lerp";

export class Vector2 {
  static zero: Vector2 = new Vector2(0, 0);
  static up: Vector2 = new Vector2(0, 1);
  static down: Vector2 = new Vector2(0, -1);
  static left: Vector2 = new Vector2(1, 0);
  static right: Vector2 = new Vector2(-1, 0);

  constructor(public x: number, public y: number) {}

  static square(x: number): Vector2 {
    return new Vector2(x, x);
  }

  static fromTuple([x, y]: [number, number]): Vector2 {
    return new Vector2(x, y);
  }

  static lerp(a: Vector2, b: Vector2, t: number): Vector2 {
    return new Vector2(lerp(a.x, b.x, t), lerp(a.y, b.y, t));
  }

  static plus(a: Vector2, b: Vector2): Vector2 {
    return new Vector2(a.x + b.x, a.y + b.y);
  }

  add(other: Vector2) {
    this.x += other.x;
    this.y += other.y;
  }

  static minus(a: Vector2, b: Vector2): Vector2 {
    return new Vector2(a.x - b.x, a.y - b.y);
  }

  subtract(other: Vector2) {
    this.x -= other.x;
    this.y -= other.y;
  }

  static dividedBy(a: Vector2, factor: number): Vector2 {
    return new Vector2(a.x / factor, a.y / factor);
  }

  divideBy(factor: number): void {
    this.x = this.x / factor;
    this.y = this.y / factor;
  }

  static multipliedBy(a: Vector2, factor: number): Vector2 {
    return new Vector2(a.x * factor, a.y * factor);
  }

  multiplyBy(factor: number): void {
    this.x = this.x * factor;
    this.y = this.y * factor;
  }

  lerp(other: Vector2, t: number): void {
    this.x = lerp(this.x, other.x, t);
    this.y = lerp(this.y, other.y, t);
  }

  magnitude(): number {
    return Math.sqrt(this.x * this.x + this.y * this.y);
  }

  normalized(): Vector2 {
    const mag = this.magnitude();
    return new Vector2(this.x / mag, this.y / mag);
  }

  reset() {
    this.x = 0;
    this.y = 0;
  }

  toString() {
    return `{ x: ${this.x}, y: ${this.y} }`;
  }
}
