import { GameObject } from "./game-object";

export class GameObjectManager extends GameObject {
  static instance: GameObjectManager;

  static init(debug: boolean = false): void {
    GameObjectManager.instance = new GameObjectManager(debug);
  }

  constructor(debug: boolean = false) {
    super();
    this.debug = debug;
  }

  push(this: this, gameObject: GameObject): void {
    this.addComponent(gameObject);
  }

  findGameObject(
    predicate: (gameObject: GameObject) => boolean
  ): GameObject | undefined {
    return this.components.find((gameObject) => predicate(gameObject));
  }

  findGameObjects(
    predicate: (gameObject: GameObject) => boolean
  ): GameObject[] {
    return this.components.filter((gameObject) => predicate(gameObject));
  }

  findGameObjectsOfType<T extends GameObject>(
    instanceOf: T,
    predicate?: (gameObject: T) => boolean
  ): Array<T> {
    return this.components.filter(
      (gameObject) =>
        gameObject instanceof instanceOf.constructor &&
        (predicate?.(gameObject as T) ?? true)
    ) as Array<T>;
  }

  getGameObject(id: GameObject["id"]): GameObject | undefined {
    return this.findGameObject((gameObject) => gameObject.id == id);
  }
}
