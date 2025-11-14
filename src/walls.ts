import { Color, ScreenSize } from "tstp8/constants";
import { GameObject } from "./game-object/game-object";
import { Player } from "./player";
import { Rectangle } from "./utils/rectangle";
import { Vector2 } from "./utils/vector2";
import { Event } from "./utils/event";

export class Walls extends GameObject {
  rectangles: Rectangle[] = [];
  width = 20;
  vGap = 10;
  hGap = ScreenSize;
  gapOffset = 50;
  scrollSpeed = 2;

  onWallPassed = new Event();
  onWallTouched = new Event();

  constructor(private readonly player: Player) {
    super();
  }

  init(): void {
    this.reset();
  }

  reset(): void {
    this.rectangles = [];
    this.spawnWall(this.hGap);
  }

  update(): void {
    this.spawnNextWall();

    for (const rect of this.rectangles) {
      rect.position.subtract(
        Vector2.multipliedBy(Vector2.left, this.scrollSpeed)
      );
      this.checkForCollisions(rect);
    }
  }

  draw(): void {
    for (const rect of this.rectangles) {
      rect.draw();
    }
  }

  spawnWall(x: number) {
    const gapOffset = rnd(this.gapOffset) - this.gapOffset / 2;

    this.rectangles.push(
      new Rectangle({
        position: Vector2.fromTuple([x, 0]),
        size: Vector2.fromTuple([this.width, ScreenSize / 4 + gapOffset]),
        color: Color.green,
      }),
      new Rectangle({
        position: Vector2.fromTuple([
          x,
          ScreenSize / 2 + gapOffset + this.vGap,
        ]),
        size: Vector2.fromTuple([
          this.width,
          ScreenSize - (ScreenSize / 2 + gapOffset + this.vGap),
        ]),
        color: Color.green,
      })
    );
  }

  spawnNextWall() {
    if (this.rectangles.some((rect) => rect.position.x < -this.width)) {
      this.rectangles.shift();
      this.rectangles.shift();
      this.spawnWall(this.hGap);
      this.onWallPassed.emit();
    }
  }

  checkForCollisions(rectangle: Rectangle) {
    if (!this.player) {
      return;
    }

    if (rectangle.intersects(this.player.rect)) {
      this.onWallTouched.emit();
    }
  }
}
