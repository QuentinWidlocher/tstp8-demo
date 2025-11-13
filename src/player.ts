import { Button, Color } from "tstp8/constants";
import { GameObject } from "./game-object/game-object";
import { Rectangle } from "./utils/rectangle";
import { Vector2 } from "./utils/vector2";

export class Player extends GameObject {
  rect: Rectangle;
  velocity = Vector2.zero;

  jumpForce = 10;
  gravity = 1;

  constructor(position: Vector2, size: Vector2) {
    super();
    this.rect = new Rectangle({
      position,
      size,
      color: Color.blue,
    });
  }

  update(): void {
    // Gravity
    this.velocity.subtract(Vector2.multipliedBy(Vector2.down, this.gravity));

    // Jump
    if (btnp(Button.O)) {
      this.rect.color = Color.red;
      this.velocity.y = -this.jumpForce;
    } else {
      this.rect.color = Color.blue;
    }

    // Update position
    this.rect.position.add(this.velocity);
  }

  draw(): void {
    this.rect.draw();
  }
}
