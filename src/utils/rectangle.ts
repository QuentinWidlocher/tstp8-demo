import { Vector2 } from "./vector2";
import { Color } from "tstp8/constants";

export class Rectangle {
  position: Vector2;
  size: Vector2;
  color: Color;

  constructor({
    position,
    size,
    color = Color.white,
  }: {
    position: Vector2;
    size: Vector2;
    color?: Color;
  }) {
    this.position = position;
    this.size = size;
    this.color = color;
  }

  intersects(other: Rectangle): boolean {
    return (
      this.position.x < other.position.x + other.size.x &&
      this.position.x + this.size.x > other.position.x &&
      this.position.y < other.position.y + other.size.y &&
      this.position.y + this.size.y > other.position.y
    );
  }

  contains(point: Vector2): boolean {
    return (
      point.x >= this.position.x &&
      point.x <= this.position.x + this.size.x &&
      point.y >= this.position.y &&
      point.y <= this.position.y + this.size.y
    );
  }

  draw(mode: "fill" | "outlined" = "fill"): void {
    if (mode == "fill") {
      rectfill(
        this.position.x,
        this.position.y,
        this.position.x + this.size.x,
        this.position.y + this.size.y,
        this.color
      );
    } else {
      rect(
        this.position.x,
        this.position.y,
        this.position.x + this.size.x,
        this.position.y + this.size.y,
        this.color
      );
    }
  }
}
