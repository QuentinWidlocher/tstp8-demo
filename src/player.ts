import { Button, Color, ScreenSize } from "tstp8/constants";
import { GameObject } from "./game-object/game-object";
import { Rectangle } from "./utils/rectangle";
import { Vector2 } from "./utils/vector2";
import { Event } from "./utils/event";

export class Player extends GameObject {
  rect!: Rectangle;
  velocity = Vector2.zero;

  jumpForce = 2;
  gravity = 0.1;

  onDeath = new Event();

  constructor() {
    super();
  }

  init(): void {
    this.reset();
  }

  reset(): void {
    this.rect = new Rectangle({
      position: new Vector2(10, 10),
      size: new Vector2(10, 10),
      color: Color.yellow,
    });

    this.velocity.reset();
  }

  update(): void {
    // Gravity
    this.velocity.subtract(Vector2.multipliedBy(Vector2.down, this.gravity));

    // Jump
    if (btnp(Button.O) || btnp(Button.X)) {
      this.velocity.y = -this.jumpForce;
    }

    if (
      this.rect.position.y + this.rect.size.y < 0 ||
      this.rect.position.y - this.rect.size.y > ScreenSize
    ) {
      this.onDeath.emit();
    }

    // Update position
    this.rect.position.add(this.velocity);
  }

  draw(): void {
    this.rect.draw();
  }
}
