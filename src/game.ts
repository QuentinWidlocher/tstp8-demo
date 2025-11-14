import { GameObjectManager } from "./game-object/game-object-manager";
import { Player } from "./player";
import "tstp8";
import { Walls } from "./walls";
import { Color } from "tstp8/constants";
import { Score } from "./score";

export function _init(): void {
  GameObjectManager.init();

  const player = new Player();
  const walls = new Walls(player);
  const score = new Score();

  function resetGame() {
    player.reset();
    walls.reset();
    score.reset();
  }

  walls.onWallPassed.subscribe(() => score.increment());
  walls.onWallTouched.subscribe(() => resetGame());
  player.onDeath.subscribe(() => resetGame());

  GameObjectManager.instance.register([player, walls, score]);

  GameObjectManager.instance._init();
}

export function _update60(): void {
  GameObjectManager.instance._update();
}

export function _draw(): void {
  cls(Color.blue);
  GameObjectManager.instance._draw();
}
