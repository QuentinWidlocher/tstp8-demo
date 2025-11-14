export abstract class GameObject {
  layer = 0;
  id = `${rnd(1000)}`;
  parent: GameObject | null = null;
  components: GameObject[] = [];

  debug = false;

  update(): void {}
  updateDebug(): void {}
  _update(): void {
    this.update?.();

    if (this.debug) {
      this.updateDebug?.();
    }

    for (const child of this.components) {
      child._update();
    }
  }

  init(): void {}
  initDebug(): void {}
  _init(): void {
    this.init?.();

    if (this.debug) {
      this.initDebug?.();
    }

    for (const child of this.components) {
      child._init();
    }
  }

  draw(): void {}
  drawDebug(): void {}
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
