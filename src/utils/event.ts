export class Event<T = void> {
  private subscribers: ((data: T) => void)[] = [];

  public subscribe(callback: (data: T) => void) {
    this.subscribers.push(callback);
  }

  public emit(data: T) {
    for (const subscriber of this.subscribers) {
      subscriber(data);
    }
  }
}

export type EventPayload<T> = T extends Event<infer U> ? U : never;
