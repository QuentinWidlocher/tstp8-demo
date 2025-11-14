import { Color } from "tstp8/constants";
import { GameObject } from "./game-object/game-object";
import { printOutlinedBold } from "./utils/text";

export class Score extends GameObject {
  score = 0;
  maxScore = 0;

  draw(): void {
    printOutlinedBold(`score: ${this.score}`, 5, 5);
    if (this.maxScore > 0) {
      printOutlinedBold(`max: ${this.maxScore}`, 5, 13);
    }
  }

  increment() {
    this.score++;
  }

  reset() {
    this.maxScore = max(this.score, this.maxScore);
    this.score = 0;
  }
}
