import { Color } from "tstp8/constants";

export function printOutlinedLight(
  text: string,
  x: number,
  y: number,
  bodyColor = Color.white,
  outlineColor = Color.black
) {
  print(text, x - 1, y, outlineColor);
  print(text, x + 1, y, outlineColor);
  print(text, x, y - 1, outlineColor);
  print(text, x, y + 1, outlineColor);
  print(text, x, y, bodyColor);
}

export function printOutlinedBold(
  text: string,
  x: number,
  y: number,
  bodyColor = Color.white,
  outlineColor = Color.black
) {
  print(text, x - 1, y - 1, outlineColor);
  print(text, x + 1, y + 1, outlineColor);
  print(text, x + 1, y - 1, outlineColor);
  print(text, x - 1, y + 1, outlineColor);
  printOutlinedLight(text, x, y, bodyColor, outlineColor);
}
