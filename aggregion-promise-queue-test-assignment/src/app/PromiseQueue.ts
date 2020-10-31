class Queue<T = any> {
  readonly #queue: {
    promise: () => PromiseLike<T>;
    resolve: (value?: T | PromiseLike<T>) => void;
    reject: (reason?: any) => void;
  }[] = [];
  #stop = false;
  #workingOnPromise = false;

  enqueue(promise: () => PromiseLike<T>) {
    return new Promise((resolve, reject) => {
      this.#queue.push({
        promise,
        resolve,
        reject,
      });
      this.dequeue();
    });
  }

  dequeue() {
    if (this.#workingOnPromise) {
      return false;
    }
    if (this.#stop) {
      this.#queue.length = 0;
      this.#stop = false;
      return;
    }
    const item = this.#queue.shift();
    if (!item) {
      return false;
    }
    try {
      this.#workingOnPromise = true;
      item.promise().then(
        (value) => {
          this.#workingOnPromise = false;
          item.resolve(value);
          this.dequeue();
        },
        (err: Error) => {
          this.#workingOnPromise = false;
          item.reject(err);
          this.dequeue();
        }
      );
    } catch (err) {
      this.#workingOnPromise = false;
      item.reject(err);
      this.dequeue();
    }
    return true;
  }
}
