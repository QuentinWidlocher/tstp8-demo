import { GameObjectManager } from "./game-object/game-object-manager";
import { Player } from "./player";
import { Vector2 } from "./utils/vector2";
import "tstp8";

const player = new Player(new Vector2(10, 10), new Vector2(10, 10));

export function _init(): void {
  GameObjectManager.init();
  GameObjectManager.instance.push(player);
}

export function _update(): void {
  GameObjectManager.instance._update();
}

export function _draw(): void {
  cls();
  GameObjectManager.instance._draw();
}
