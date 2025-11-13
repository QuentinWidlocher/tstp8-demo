export interface GameObject {
  id: string;
  components: GameObject[];

  update?(): void;
  init?(): void;
  draw?(): void;

  updateDebug?(): void;
  initDebug?(): void;
  drawDebug?(): void;
}

export abstract class GameObject {
  layer = 0;
  id = `${rnd(1000)}`;
  parent: GameObject | null = null;
  components: GameObject[] = [];

  debug = false;

  _update(): void {
    this.update?.();

    if (this.debug) {
      this.updateDebug?.();
    }

    for (const child of this.components) {
      child._update();
    }
  }

  _init(): void {
    this.init?.();

    if (this.debug) {
      this.initDebug?.();
    }

    for (const child of this.components) {
      child._init();
    }
  }

  _draw(): void {
    this.draw?.();
    if (this.debug) {
      this.drawDebug?.();
    }

    for (const child of this.components) {
      child._draw();
    }
  }

  protected addComponent<T extends GameObject>(child: T): T {
    this.components.push(child);
    child.parent = this;
    return child;
  }

  withDebugEnabled(enabled = true): this {
    this.debug = enabled;
    return this;
  }
}
